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

module RenameMapTable_4(
  input        clock,
               reset,
  input  [5:0] io_map_reqs_0_lrs1,
               io_map_reqs_0_lrs2,
               io_map_reqs_0_ldst,
               io_map_reqs_1_lrs1,
               io_map_reqs_1_lrs2,
               io_map_reqs_1_ldst,
               io_remap_reqs_0_ldst,
  input  [6:0] io_remap_reqs_0_pdst,
  input        io_remap_reqs_0_valid,
  input  [5:0] io_remap_reqs_1_ldst,
  input  [6:0] io_remap_reqs_1_pdst,
  input        io_remap_reqs_1_valid,
               io_ren_br_tags_0_valid,
  input  [3:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [3:0] io_ren_br_tags_1_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_rollback,
  output [6:0] io_map_resps_0_prs1,
               io_map_resps_0_prs2,
               io_map_resps_0_stale_pdst,
               io_map_resps_1_prs1,
               io_map_resps_1_prs2,
               io_map_resps_1_stale_pdst
);

  reg  [6:0]       map_table_0;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_1;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_2;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_3;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_4;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_5;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_6;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_7;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_8;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_9;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_10;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_11;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_12;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_13;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_14;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_15;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_16;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_17;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_18;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_19;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_20;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_21;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_22;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_23;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_24;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_25;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_26;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_27;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_28;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_29;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_30;	// rename-maptable.scala:70:26
  reg  [6:0]       map_table_31;	// rename-maptable.scala:70:26
  reg  [6:0]       br_snapshots_0_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_0_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_1_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_2_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_3_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_4_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_5_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_6_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_7_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_8_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_9_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_10_31;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_0;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_1;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_2;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_3;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_4;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_5;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_6;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_7;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_8;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_9;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_10;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_11;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_12;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_13;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_14;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_15;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_16;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_17;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_18;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_19;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_20;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_21;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_22;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_23;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_24;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_25;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_26;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_27;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_28;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_29;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_30;	// rename-maptable.scala:71:25
  reg  [6:0]       br_snapshots_11_31;	// rename-maptable.scala:71:25
  wire [31:0][6:0] _GEN =
    {{map_table_31},
     {map_table_30},
     {map_table_29},
     {map_table_28},
     {map_table_27},
     {map_table_26},
     {map_table_25},
     {map_table_24},
     {map_table_23},
     {map_table_22},
     {map_table_21},
     {map_table_20},
     {map_table_19},
     {map_table_18},
     {map_table_17},
     {map_table_16},
     {map_table_15},
     {map_table_14},
     {map_table_13},
     {map_table_12},
     {map_table_11},
     {map_table_10},
     {map_table_9},
     {map_table_8},
     {map_table_7},
     {map_table_6},
     {map_table_5},
     {map_table_4},
     {map_table_3},
     {map_table_2},
     {map_table_1},
     {map_table_0}};	// rename-maptable.scala:70:26, :113:32
  `ifndef SYNTHESIS	// rename-maptable.scala:128:12
    always @(posedge clock) begin	// rename-maptable.scala:128:12
      if (~(~io_remap_reqs_0_valid
            | ~(map_table_0 == io_remap_reqs_0_pdst | map_table_1 == io_remap_reqs_0_pdst
                | map_table_2 == io_remap_reqs_0_pdst
                | map_table_3 == io_remap_reqs_0_pdst
                | map_table_4 == io_remap_reqs_0_pdst
                | map_table_5 == io_remap_reqs_0_pdst
                | map_table_6 == io_remap_reqs_0_pdst
                | map_table_7 == io_remap_reqs_0_pdst
                | map_table_8 == io_remap_reqs_0_pdst
                | map_table_9 == io_remap_reqs_0_pdst
                | map_table_10 == io_remap_reqs_0_pdst
                | map_table_11 == io_remap_reqs_0_pdst
                | map_table_12 == io_remap_reqs_0_pdst
                | map_table_13 == io_remap_reqs_0_pdst
                | map_table_14 == io_remap_reqs_0_pdst
                | map_table_15 == io_remap_reqs_0_pdst
                | map_table_16 == io_remap_reqs_0_pdst
                | map_table_17 == io_remap_reqs_0_pdst
                | map_table_18 == io_remap_reqs_0_pdst
                | map_table_19 == io_remap_reqs_0_pdst
                | map_table_20 == io_remap_reqs_0_pdst
                | map_table_21 == io_remap_reqs_0_pdst
                | map_table_22 == io_remap_reqs_0_pdst
                | map_table_23 == io_remap_reqs_0_pdst
                | map_table_24 == io_remap_reqs_0_pdst
                | map_table_25 == io_remap_reqs_0_pdst
                | map_table_26 == io_remap_reqs_0_pdst
                | map_table_27 == io_remap_reqs_0_pdst
                | map_table_28 == io_remap_reqs_0_pdst
                | map_table_29 == io_remap_reqs_0_pdst
                | map_table_30 == io_remap_reqs_0_pdst
                | map_table_31 == io_remap_reqs_0_pdst) | io_remap_reqs_0_pdst == 7'h0
            & io_rollback | reset)) begin	// rename-maptable.scala:70:26, :128:{12,13,19,38,47,55}
        if (`ASSERT_VERBOSE_COND_)	// rename-maptable.scala:128:12
          $error("Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");	// rename-maptable.scala:128:12
        if (`STOP_COND_)	// rename-maptable.scala:128:12
          $fatal;	// rename-maptable.scala:128:12
      end
      if (~(~io_remap_reqs_1_valid
            | ~(map_table_0 == io_remap_reqs_1_pdst | map_table_1 == io_remap_reqs_1_pdst
                | map_table_2 == io_remap_reqs_1_pdst
                | map_table_3 == io_remap_reqs_1_pdst
                | map_table_4 == io_remap_reqs_1_pdst
                | map_table_5 == io_remap_reqs_1_pdst
                | map_table_6 == io_remap_reqs_1_pdst
                | map_table_7 == io_remap_reqs_1_pdst
                | map_table_8 == io_remap_reqs_1_pdst
                | map_table_9 == io_remap_reqs_1_pdst
                | map_table_10 == io_remap_reqs_1_pdst
                | map_table_11 == io_remap_reqs_1_pdst
                | map_table_12 == io_remap_reqs_1_pdst
                | map_table_13 == io_remap_reqs_1_pdst
                | map_table_14 == io_remap_reqs_1_pdst
                | map_table_15 == io_remap_reqs_1_pdst
                | map_table_16 == io_remap_reqs_1_pdst
                | map_table_17 == io_remap_reqs_1_pdst
                | map_table_18 == io_remap_reqs_1_pdst
                | map_table_19 == io_remap_reqs_1_pdst
                | map_table_20 == io_remap_reqs_1_pdst
                | map_table_21 == io_remap_reqs_1_pdst
                | map_table_22 == io_remap_reqs_1_pdst
                | map_table_23 == io_remap_reqs_1_pdst
                | map_table_24 == io_remap_reqs_1_pdst
                | map_table_25 == io_remap_reqs_1_pdst
                | map_table_26 == io_remap_reqs_1_pdst
                | map_table_27 == io_remap_reqs_1_pdst
                | map_table_28 == io_remap_reqs_1_pdst
                | map_table_29 == io_remap_reqs_1_pdst
                | map_table_30 == io_remap_reqs_1_pdst
                | map_table_31 == io_remap_reqs_1_pdst) | io_remap_reqs_1_pdst == 7'h0
            & io_rollback | reset)) begin	// rename-maptable.scala:70:26, :128:{12,13,19,38,47,55}
        if (`ASSERT_VERBOSE_COND_)	// rename-maptable.scala:128:12
          $error("Assertion failed: [maptable] Trying to write a duplicate mapping.\n    at rename-maptable.scala:128 assert (!r || !map_table.contains(p) || p === 0.U && io.rollback, \"[maptable] Trying to write a duplicate mapping.\")}\n");	// rename-maptable.scala:128:12
        if (`STOP_COND_)	// rename-maptable.scala:128:12
          $fatal;	// rename-maptable.scala:128:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [63:0] _remap_ldsts_oh_T = 64'h1 << io_remap_reqs_0_ldst;	// OneHot.scala:58:35
    automatic logic [30:0] _GEN_0 = _remap_ldsts_oh_T[31:1] & {31{io_remap_reqs_0_valid}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-maptable.scala:78:69
    automatic logic [63:0] _remap_ldsts_oh_T_3 = 64'h1 << io_remap_reqs_1_ldst;	// OneHot.scala:58:35
    automatic logic [30:0] _GEN_1 =
      _remap_ldsts_oh_T_3[31:1] & {31{io_remap_reqs_1_valid}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-maptable.scala:78:69
    automatic logic        _GEN_2;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_3;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_4;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_5;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_6;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_7;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_8;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_9;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_10;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_11;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_12;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_13;	// rename-maptable.scala:71:25, :98:36, :99:44
    automatic logic        _GEN_14 = io_ren_br_tags_1_bits == 4'h0;	// rename-maptable.scala:99:44
    automatic logic        _GEN_15 = io_ren_br_tags_1_bits == 4'h1;	// rename-maptable.scala:99:44
    automatic logic        _GEN_16 = io_ren_br_tags_1_bits == 4'h2;	// rename-maptable.scala:99:44
    automatic logic        _GEN_17 = io_ren_br_tags_1_bits == 4'h3;	// rename-maptable.scala:99:44
    automatic logic        _GEN_18 = io_ren_br_tags_1_bits == 4'h4;	// rename-maptable.scala:99:44
    automatic logic        _GEN_19 = io_ren_br_tags_1_bits == 4'h5;	// rename-maptable.scala:99:44
    automatic logic        _GEN_20 = io_ren_br_tags_1_bits == 4'h6;	// rename-maptable.scala:99:44
    automatic logic        _GEN_21 = io_ren_br_tags_1_bits == 4'h7;	// rename-maptable.scala:99:44
    automatic logic        _GEN_22 = io_ren_br_tags_1_bits == 4'h8;	// rename-maptable.scala:99:44
    automatic logic        _GEN_23 = io_ren_br_tags_1_bits == 4'h9;	// rename-maptable.scala:99:44
    automatic logic        _GEN_24 = io_ren_br_tags_1_bits == 4'hA;	// rename-maptable.scala:99:44
    automatic logic        _GEN_25 = io_ren_br_tags_1_bits == 4'hB;	// rename-maptable.scala:99:44
    _GEN_2 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h0;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_3 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h1;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_4 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h2;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_5 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h3;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_6 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h4;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_7 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h5;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_8 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h6;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_9 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h7;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_10 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h8;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_11 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'h9;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_12 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'hA;	// rename-maptable.scala:71:25, :98:36, :99:44
    _GEN_13 = io_ren_br_tags_0_valid & io_ren_br_tags_0_bits == 4'hB;	// rename-maptable.scala:71:25, :98:36, :99:44
    if (reset) begin
      map_table_0 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_1 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_2 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_3 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_4 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_5 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_6 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_7 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_8 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_9 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_10 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_11 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_12 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_13 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_14 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_15 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_16 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_17 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_18 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_19 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_20 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_21 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_22 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_23 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_24 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_25 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_26 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_27 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_28 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_29 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_30 <= 7'h0;	// rename-maptable.scala:70:26
      map_table_31 <= 7'h0;	// rename-maptable.scala:70:26
    end
    else if (io_brupdate_b2_mispredict) begin
      automatic logic [15:0][6:0] _GEN_26;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_27;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_28;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_29;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_30;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_31;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_32;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_33;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_34;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_35;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_36;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_37;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_38;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_39;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_40;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_41;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_42;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_43;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_44;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_45;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_46;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_47;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_48;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_49;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_50;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_51;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_52;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_53;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_54;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_55;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_56;	// rename-maptable.scala:105:15
      automatic logic [15:0][6:0] _GEN_57;	// rename-maptable.scala:105:15
      _GEN_26 =
        {{br_snapshots_0_0},
         {br_snapshots_0_0},
         {br_snapshots_0_0},
         {br_snapshots_0_0},
         {br_snapshots_11_0},
         {br_snapshots_10_0},
         {br_snapshots_9_0},
         {br_snapshots_8_0},
         {br_snapshots_7_0},
         {br_snapshots_6_0},
         {br_snapshots_5_0},
         {br_snapshots_4_0},
         {br_snapshots_3_0},
         {br_snapshots_2_0},
         {br_snapshots_1_0},
         {br_snapshots_0_0}};	// rename-maptable.scala:71:25, :105:15
      map_table_0 <= _GEN_26[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_27 =
        {{br_snapshots_0_1},
         {br_snapshots_0_1},
         {br_snapshots_0_1},
         {br_snapshots_0_1},
         {br_snapshots_11_1},
         {br_snapshots_10_1},
         {br_snapshots_9_1},
         {br_snapshots_8_1},
         {br_snapshots_7_1},
         {br_snapshots_6_1},
         {br_snapshots_5_1},
         {br_snapshots_4_1},
         {br_snapshots_3_1},
         {br_snapshots_2_1},
         {br_snapshots_1_1},
         {br_snapshots_0_1}};	// rename-maptable.scala:71:25, :105:15
      map_table_1 <= _GEN_27[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_28 =
        {{br_snapshots_0_2},
         {br_snapshots_0_2},
         {br_snapshots_0_2},
         {br_snapshots_0_2},
         {br_snapshots_11_2},
         {br_snapshots_10_2},
         {br_snapshots_9_2},
         {br_snapshots_8_2},
         {br_snapshots_7_2},
         {br_snapshots_6_2},
         {br_snapshots_5_2},
         {br_snapshots_4_2},
         {br_snapshots_3_2},
         {br_snapshots_2_2},
         {br_snapshots_1_2},
         {br_snapshots_0_2}};	// rename-maptable.scala:71:25, :105:15
      map_table_2 <= _GEN_28[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_29 =
        {{br_snapshots_0_3},
         {br_snapshots_0_3},
         {br_snapshots_0_3},
         {br_snapshots_0_3},
         {br_snapshots_11_3},
         {br_snapshots_10_3},
         {br_snapshots_9_3},
         {br_snapshots_8_3},
         {br_snapshots_7_3},
         {br_snapshots_6_3},
         {br_snapshots_5_3},
         {br_snapshots_4_3},
         {br_snapshots_3_3},
         {br_snapshots_2_3},
         {br_snapshots_1_3},
         {br_snapshots_0_3}};	// rename-maptable.scala:71:25, :105:15
      map_table_3 <= _GEN_29[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_30 =
        {{br_snapshots_0_4},
         {br_snapshots_0_4},
         {br_snapshots_0_4},
         {br_snapshots_0_4},
         {br_snapshots_11_4},
         {br_snapshots_10_4},
         {br_snapshots_9_4},
         {br_snapshots_8_4},
         {br_snapshots_7_4},
         {br_snapshots_6_4},
         {br_snapshots_5_4},
         {br_snapshots_4_4},
         {br_snapshots_3_4},
         {br_snapshots_2_4},
         {br_snapshots_1_4},
         {br_snapshots_0_4}};	// rename-maptable.scala:71:25, :105:15
      map_table_4 <= _GEN_30[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_31 =
        {{br_snapshots_0_5},
         {br_snapshots_0_5},
         {br_snapshots_0_5},
         {br_snapshots_0_5},
         {br_snapshots_11_5},
         {br_snapshots_10_5},
         {br_snapshots_9_5},
         {br_snapshots_8_5},
         {br_snapshots_7_5},
         {br_snapshots_6_5},
         {br_snapshots_5_5},
         {br_snapshots_4_5},
         {br_snapshots_3_5},
         {br_snapshots_2_5},
         {br_snapshots_1_5},
         {br_snapshots_0_5}};	// rename-maptable.scala:71:25, :105:15
      map_table_5 <= _GEN_31[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_32 =
        {{br_snapshots_0_6},
         {br_snapshots_0_6},
         {br_snapshots_0_6},
         {br_snapshots_0_6},
         {br_snapshots_11_6},
         {br_snapshots_10_6},
         {br_snapshots_9_6},
         {br_snapshots_8_6},
         {br_snapshots_7_6},
         {br_snapshots_6_6},
         {br_snapshots_5_6},
         {br_snapshots_4_6},
         {br_snapshots_3_6},
         {br_snapshots_2_6},
         {br_snapshots_1_6},
         {br_snapshots_0_6}};	// rename-maptable.scala:71:25, :105:15
      map_table_6 <= _GEN_32[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_33 =
        {{br_snapshots_0_7},
         {br_snapshots_0_7},
         {br_snapshots_0_7},
         {br_snapshots_0_7},
         {br_snapshots_11_7},
         {br_snapshots_10_7},
         {br_snapshots_9_7},
         {br_snapshots_8_7},
         {br_snapshots_7_7},
         {br_snapshots_6_7},
         {br_snapshots_5_7},
         {br_snapshots_4_7},
         {br_snapshots_3_7},
         {br_snapshots_2_7},
         {br_snapshots_1_7},
         {br_snapshots_0_7}};	// rename-maptable.scala:71:25, :105:15
      map_table_7 <= _GEN_33[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_34 =
        {{br_snapshots_0_8},
         {br_snapshots_0_8},
         {br_snapshots_0_8},
         {br_snapshots_0_8},
         {br_snapshots_11_8},
         {br_snapshots_10_8},
         {br_snapshots_9_8},
         {br_snapshots_8_8},
         {br_snapshots_7_8},
         {br_snapshots_6_8},
         {br_snapshots_5_8},
         {br_snapshots_4_8},
         {br_snapshots_3_8},
         {br_snapshots_2_8},
         {br_snapshots_1_8},
         {br_snapshots_0_8}};	// rename-maptable.scala:71:25, :105:15
      map_table_8 <= _GEN_34[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_35 =
        {{br_snapshots_0_9},
         {br_snapshots_0_9},
         {br_snapshots_0_9},
         {br_snapshots_0_9},
         {br_snapshots_11_9},
         {br_snapshots_10_9},
         {br_snapshots_9_9},
         {br_snapshots_8_9},
         {br_snapshots_7_9},
         {br_snapshots_6_9},
         {br_snapshots_5_9},
         {br_snapshots_4_9},
         {br_snapshots_3_9},
         {br_snapshots_2_9},
         {br_snapshots_1_9},
         {br_snapshots_0_9}};	// rename-maptable.scala:71:25, :105:15
      map_table_9 <= _GEN_35[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_36 =
        {{br_snapshots_0_10},
         {br_snapshots_0_10},
         {br_snapshots_0_10},
         {br_snapshots_0_10},
         {br_snapshots_11_10},
         {br_snapshots_10_10},
         {br_snapshots_9_10},
         {br_snapshots_8_10},
         {br_snapshots_7_10},
         {br_snapshots_6_10},
         {br_snapshots_5_10},
         {br_snapshots_4_10},
         {br_snapshots_3_10},
         {br_snapshots_2_10},
         {br_snapshots_1_10},
         {br_snapshots_0_10}};	// rename-maptable.scala:71:25, :105:15
      map_table_10 <= _GEN_36[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_37 =
        {{br_snapshots_0_11},
         {br_snapshots_0_11},
         {br_snapshots_0_11},
         {br_snapshots_0_11},
         {br_snapshots_11_11},
         {br_snapshots_10_11},
         {br_snapshots_9_11},
         {br_snapshots_8_11},
         {br_snapshots_7_11},
         {br_snapshots_6_11},
         {br_snapshots_5_11},
         {br_snapshots_4_11},
         {br_snapshots_3_11},
         {br_snapshots_2_11},
         {br_snapshots_1_11},
         {br_snapshots_0_11}};	// rename-maptable.scala:71:25, :105:15
      map_table_11 <= _GEN_37[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_38 =
        {{br_snapshots_0_12},
         {br_snapshots_0_12},
         {br_snapshots_0_12},
         {br_snapshots_0_12},
         {br_snapshots_11_12},
         {br_snapshots_10_12},
         {br_snapshots_9_12},
         {br_snapshots_8_12},
         {br_snapshots_7_12},
         {br_snapshots_6_12},
         {br_snapshots_5_12},
         {br_snapshots_4_12},
         {br_snapshots_3_12},
         {br_snapshots_2_12},
         {br_snapshots_1_12},
         {br_snapshots_0_12}};	// rename-maptable.scala:71:25, :105:15
      map_table_12 <= _GEN_38[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_39 =
        {{br_snapshots_0_13},
         {br_snapshots_0_13},
         {br_snapshots_0_13},
         {br_snapshots_0_13},
         {br_snapshots_11_13},
         {br_snapshots_10_13},
         {br_snapshots_9_13},
         {br_snapshots_8_13},
         {br_snapshots_7_13},
         {br_snapshots_6_13},
         {br_snapshots_5_13},
         {br_snapshots_4_13},
         {br_snapshots_3_13},
         {br_snapshots_2_13},
         {br_snapshots_1_13},
         {br_snapshots_0_13}};	// rename-maptable.scala:71:25, :105:15
      map_table_13 <= _GEN_39[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_40 =
        {{br_snapshots_0_14},
         {br_snapshots_0_14},
         {br_snapshots_0_14},
         {br_snapshots_0_14},
         {br_snapshots_11_14},
         {br_snapshots_10_14},
         {br_snapshots_9_14},
         {br_snapshots_8_14},
         {br_snapshots_7_14},
         {br_snapshots_6_14},
         {br_snapshots_5_14},
         {br_snapshots_4_14},
         {br_snapshots_3_14},
         {br_snapshots_2_14},
         {br_snapshots_1_14},
         {br_snapshots_0_14}};	// rename-maptable.scala:71:25, :105:15
      map_table_14 <= _GEN_40[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_41 =
        {{br_snapshots_0_15},
         {br_snapshots_0_15},
         {br_snapshots_0_15},
         {br_snapshots_0_15},
         {br_snapshots_11_15},
         {br_snapshots_10_15},
         {br_snapshots_9_15},
         {br_snapshots_8_15},
         {br_snapshots_7_15},
         {br_snapshots_6_15},
         {br_snapshots_5_15},
         {br_snapshots_4_15},
         {br_snapshots_3_15},
         {br_snapshots_2_15},
         {br_snapshots_1_15},
         {br_snapshots_0_15}};	// rename-maptable.scala:71:25, :105:15
      map_table_15 <= _GEN_41[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_42 =
        {{br_snapshots_0_16},
         {br_snapshots_0_16},
         {br_snapshots_0_16},
         {br_snapshots_0_16},
         {br_snapshots_11_16},
         {br_snapshots_10_16},
         {br_snapshots_9_16},
         {br_snapshots_8_16},
         {br_snapshots_7_16},
         {br_snapshots_6_16},
         {br_snapshots_5_16},
         {br_snapshots_4_16},
         {br_snapshots_3_16},
         {br_snapshots_2_16},
         {br_snapshots_1_16},
         {br_snapshots_0_16}};	// rename-maptable.scala:71:25, :105:15
      map_table_16 <= _GEN_42[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_43 =
        {{br_snapshots_0_17},
         {br_snapshots_0_17},
         {br_snapshots_0_17},
         {br_snapshots_0_17},
         {br_snapshots_11_17},
         {br_snapshots_10_17},
         {br_snapshots_9_17},
         {br_snapshots_8_17},
         {br_snapshots_7_17},
         {br_snapshots_6_17},
         {br_snapshots_5_17},
         {br_snapshots_4_17},
         {br_snapshots_3_17},
         {br_snapshots_2_17},
         {br_snapshots_1_17},
         {br_snapshots_0_17}};	// rename-maptable.scala:71:25, :105:15
      map_table_17 <= _GEN_43[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_44 =
        {{br_snapshots_0_18},
         {br_snapshots_0_18},
         {br_snapshots_0_18},
         {br_snapshots_0_18},
         {br_snapshots_11_18},
         {br_snapshots_10_18},
         {br_snapshots_9_18},
         {br_snapshots_8_18},
         {br_snapshots_7_18},
         {br_snapshots_6_18},
         {br_snapshots_5_18},
         {br_snapshots_4_18},
         {br_snapshots_3_18},
         {br_snapshots_2_18},
         {br_snapshots_1_18},
         {br_snapshots_0_18}};	// rename-maptable.scala:71:25, :105:15
      map_table_18 <= _GEN_44[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_45 =
        {{br_snapshots_0_19},
         {br_snapshots_0_19},
         {br_snapshots_0_19},
         {br_snapshots_0_19},
         {br_snapshots_11_19},
         {br_snapshots_10_19},
         {br_snapshots_9_19},
         {br_snapshots_8_19},
         {br_snapshots_7_19},
         {br_snapshots_6_19},
         {br_snapshots_5_19},
         {br_snapshots_4_19},
         {br_snapshots_3_19},
         {br_snapshots_2_19},
         {br_snapshots_1_19},
         {br_snapshots_0_19}};	// rename-maptable.scala:71:25, :105:15
      map_table_19 <= _GEN_45[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_46 =
        {{br_snapshots_0_20},
         {br_snapshots_0_20},
         {br_snapshots_0_20},
         {br_snapshots_0_20},
         {br_snapshots_11_20},
         {br_snapshots_10_20},
         {br_snapshots_9_20},
         {br_snapshots_8_20},
         {br_snapshots_7_20},
         {br_snapshots_6_20},
         {br_snapshots_5_20},
         {br_snapshots_4_20},
         {br_snapshots_3_20},
         {br_snapshots_2_20},
         {br_snapshots_1_20},
         {br_snapshots_0_20}};	// rename-maptable.scala:71:25, :105:15
      map_table_20 <= _GEN_46[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_47 =
        {{br_snapshots_0_21},
         {br_snapshots_0_21},
         {br_snapshots_0_21},
         {br_snapshots_0_21},
         {br_snapshots_11_21},
         {br_snapshots_10_21},
         {br_snapshots_9_21},
         {br_snapshots_8_21},
         {br_snapshots_7_21},
         {br_snapshots_6_21},
         {br_snapshots_5_21},
         {br_snapshots_4_21},
         {br_snapshots_3_21},
         {br_snapshots_2_21},
         {br_snapshots_1_21},
         {br_snapshots_0_21}};	// rename-maptable.scala:71:25, :105:15
      map_table_21 <= _GEN_47[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_48 =
        {{br_snapshots_0_22},
         {br_snapshots_0_22},
         {br_snapshots_0_22},
         {br_snapshots_0_22},
         {br_snapshots_11_22},
         {br_snapshots_10_22},
         {br_snapshots_9_22},
         {br_snapshots_8_22},
         {br_snapshots_7_22},
         {br_snapshots_6_22},
         {br_snapshots_5_22},
         {br_snapshots_4_22},
         {br_snapshots_3_22},
         {br_snapshots_2_22},
         {br_snapshots_1_22},
         {br_snapshots_0_22}};	// rename-maptable.scala:71:25, :105:15
      map_table_22 <= _GEN_48[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_49 =
        {{br_snapshots_0_23},
         {br_snapshots_0_23},
         {br_snapshots_0_23},
         {br_snapshots_0_23},
         {br_snapshots_11_23},
         {br_snapshots_10_23},
         {br_snapshots_9_23},
         {br_snapshots_8_23},
         {br_snapshots_7_23},
         {br_snapshots_6_23},
         {br_snapshots_5_23},
         {br_snapshots_4_23},
         {br_snapshots_3_23},
         {br_snapshots_2_23},
         {br_snapshots_1_23},
         {br_snapshots_0_23}};	// rename-maptable.scala:71:25, :105:15
      map_table_23 <= _GEN_49[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_50 =
        {{br_snapshots_0_24},
         {br_snapshots_0_24},
         {br_snapshots_0_24},
         {br_snapshots_0_24},
         {br_snapshots_11_24},
         {br_snapshots_10_24},
         {br_snapshots_9_24},
         {br_snapshots_8_24},
         {br_snapshots_7_24},
         {br_snapshots_6_24},
         {br_snapshots_5_24},
         {br_snapshots_4_24},
         {br_snapshots_3_24},
         {br_snapshots_2_24},
         {br_snapshots_1_24},
         {br_snapshots_0_24}};	// rename-maptable.scala:71:25, :105:15
      map_table_24 <= _GEN_50[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_51 =
        {{br_snapshots_0_25},
         {br_snapshots_0_25},
         {br_snapshots_0_25},
         {br_snapshots_0_25},
         {br_snapshots_11_25},
         {br_snapshots_10_25},
         {br_snapshots_9_25},
         {br_snapshots_8_25},
         {br_snapshots_7_25},
         {br_snapshots_6_25},
         {br_snapshots_5_25},
         {br_snapshots_4_25},
         {br_snapshots_3_25},
         {br_snapshots_2_25},
         {br_snapshots_1_25},
         {br_snapshots_0_25}};	// rename-maptable.scala:71:25, :105:15
      map_table_25 <= _GEN_51[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_52 =
        {{br_snapshots_0_26},
         {br_snapshots_0_26},
         {br_snapshots_0_26},
         {br_snapshots_0_26},
         {br_snapshots_11_26},
         {br_snapshots_10_26},
         {br_snapshots_9_26},
         {br_snapshots_8_26},
         {br_snapshots_7_26},
         {br_snapshots_6_26},
         {br_snapshots_5_26},
         {br_snapshots_4_26},
         {br_snapshots_3_26},
         {br_snapshots_2_26},
         {br_snapshots_1_26},
         {br_snapshots_0_26}};	// rename-maptable.scala:71:25, :105:15
      map_table_26 <= _GEN_52[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_53 =
        {{br_snapshots_0_27},
         {br_snapshots_0_27},
         {br_snapshots_0_27},
         {br_snapshots_0_27},
         {br_snapshots_11_27},
         {br_snapshots_10_27},
         {br_snapshots_9_27},
         {br_snapshots_8_27},
         {br_snapshots_7_27},
         {br_snapshots_6_27},
         {br_snapshots_5_27},
         {br_snapshots_4_27},
         {br_snapshots_3_27},
         {br_snapshots_2_27},
         {br_snapshots_1_27},
         {br_snapshots_0_27}};	// rename-maptable.scala:71:25, :105:15
      map_table_27 <= _GEN_53[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_54 =
        {{br_snapshots_0_28},
         {br_snapshots_0_28},
         {br_snapshots_0_28},
         {br_snapshots_0_28},
         {br_snapshots_11_28},
         {br_snapshots_10_28},
         {br_snapshots_9_28},
         {br_snapshots_8_28},
         {br_snapshots_7_28},
         {br_snapshots_6_28},
         {br_snapshots_5_28},
         {br_snapshots_4_28},
         {br_snapshots_3_28},
         {br_snapshots_2_28},
         {br_snapshots_1_28},
         {br_snapshots_0_28}};	// rename-maptable.scala:71:25, :105:15
      map_table_28 <= _GEN_54[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_55 =
        {{br_snapshots_0_29},
         {br_snapshots_0_29},
         {br_snapshots_0_29},
         {br_snapshots_0_29},
         {br_snapshots_11_29},
         {br_snapshots_10_29},
         {br_snapshots_9_29},
         {br_snapshots_8_29},
         {br_snapshots_7_29},
         {br_snapshots_6_29},
         {br_snapshots_5_29},
         {br_snapshots_4_29},
         {br_snapshots_3_29},
         {br_snapshots_2_29},
         {br_snapshots_1_29},
         {br_snapshots_0_29}};	// rename-maptable.scala:71:25, :105:15
      map_table_29 <= _GEN_55[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_56 =
        {{br_snapshots_0_30},
         {br_snapshots_0_30},
         {br_snapshots_0_30},
         {br_snapshots_0_30},
         {br_snapshots_11_30},
         {br_snapshots_10_30},
         {br_snapshots_9_30},
         {br_snapshots_8_30},
         {br_snapshots_7_30},
         {br_snapshots_6_30},
         {br_snapshots_5_30},
         {br_snapshots_4_30},
         {br_snapshots_3_30},
         {br_snapshots_2_30},
         {br_snapshots_1_30},
         {br_snapshots_0_30}};	// rename-maptable.scala:71:25, :105:15
      map_table_30 <= _GEN_56[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
      _GEN_57 =
        {{br_snapshots_0_31},
         {br_snapshots_0_31},
         {br_snapshots_0_31},
         {br_snapshots_0_31},
         {br_snapshots_11_31},
         {br_snapshots_10_31},
         {br_snapshots_9_31},
         {br_snapshots_8_31},
         {br_snapshots_7_31},
         {br_snapshots_6_31},
         {br_snapshots_5_31},
         {br_snapshots_4_31},
         {br_snapshots_3_31},
         {br_snapshots_2_31},
         {br_snapshots_1_31},
         {br_snapshots_0_31}};	// rename-maptable.scala:71:25, :105:15
      map_table_31 <= _GEN_57[io_brupdate_b2_uop_br_tag];	// rename-maptable.scala:70:26, :105:15
    end
    else begin
      map_table_0 <= 7'h0;	// rename-maptable.scala:70:26
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        map_table_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        map_table_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        map_table_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        map_table_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        map_table_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        map_table_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        map_table_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        map_table_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        map_table_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        map_table_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        map_table_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        map_table_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        map_table_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        map_table_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        map_table_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        map_table_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        map_table_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        map_table_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        map_table_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        map_table_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        map_table_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        map_table_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        map_table_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        map_table_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        map_table_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        map_table_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        map_table_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        map_table_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        map_table_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        map_table_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        map_table_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        map_table_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        map_table_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        map_table_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        map_table_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        map_table_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        map_table_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        map_table_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        map_table_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        map_table_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        map_table_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        map_table_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        map_table_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        map_table_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        map_table_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        map_table_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        map_table_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        map_table_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        map_table_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        map_table_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        map_table_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        map_table_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        map_table_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        map_table_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        map_table_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        map_table_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        map_table_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        map_table_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        map_table_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        map_table_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        map_table_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:70:26
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        map_table_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:70:26
    end
    if (io_ren_br_tags_1_valid & _GEN_14 | _GEN_2)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_0_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_14) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_2) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_0_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_0_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_15 | _GEN_3)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_1_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_15) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_3) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_1_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_1_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_16 | _GEN_4)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_2_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_16) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_4) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_2_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_2_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_17 | _GEN_5)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_3_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_17) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_5) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_3_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_3_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_18 | _GEN_6)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_4_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_18) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_6) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_4_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_4_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_19 | _GEN_7)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_5_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_19) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_7) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_5_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_5_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_20 | _GEN_8)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_6_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_20) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_8) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_6_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_6_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_21 | _GEN_9)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_7_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_21) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_9) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_7_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_7_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_22 | _GEN_10)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_8_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_22) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_10) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_8_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_8_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_23 | _GEN_11)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_9_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_23) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_11) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_9_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_9_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_24 | _GEN_12)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_10_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_24) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_12) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_10_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_10_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    if (io_ren_br_tags_1_valid & _GEN_25 | _GEN_13)	// rename-maptable.scala:71:25, :98:36, :99:44
      br_snapshots_11_0 <= 7'h0;	// rename-maptable.scala:71:25
    if (io_ren_br_tags_1_valid & _GEN_25) begin	// rename-maptable.scala:98:36, :99:44
      if (_GEN_1[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_1 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_2 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_3 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_4 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_5 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_6 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_7 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_8 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_9 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_10 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_11 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_12 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_13 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_14 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_15 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_16 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_17 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_18 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_19 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_20 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_21 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_22 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_23 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_24 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_25 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_26 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_27 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_28 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_29 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_30 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_1[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_31 <= io_remap_reqs_1_pdst;	// rename-maptable.scala:71:25
      else if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
    else if (_GEN_13) begin	// rename-maptable.scala:71:25, :98:36, :99:44
      if (_GEN_0[0])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_1 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_1 <= map_table_1;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[1])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_2 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_2 <= map_table_2;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[2])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_3 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_3 <= map_table_3;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[3])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_4 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_4 <= map_table_4;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[4])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_5 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_5 <= map_table_5;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[5])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_6 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_6 <= map_table_6;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[6])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_7 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_7 <= map_table_7;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[7])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_8 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_8 <= map_table_8;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[8])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_9 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_9 <= map_table_9;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[9])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_10 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_10 <= map_table_10;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[10])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_11 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_11 <= map_table_11;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[11])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_12 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_12 <= map_table_12;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[12])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_13 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_13 <= map_table_13;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[13])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_14 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_14 <= map_table_14;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[14])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_15 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_15 <= map_table_15;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[15])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_16 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_16 <= map_table_16;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[16])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_17 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_17 <= map_table_17;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[17])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_18 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_18 <= map_table_18;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[18])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_19 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_19 <= map_table_19;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[19])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_20 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_20 <= map_table_20;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[20])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_21 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_21 <= map_table_21;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[21])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_22 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_22 <= map_table_22;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[22])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_23 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_23 <= map_table_23;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[23])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_24 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_24 <= map_table_24;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[24])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_25 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_25 <= map_table_25;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[25])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_26 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_26 <= map_table_26;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[26])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_27 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_27 <= map_table_27;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[27])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_28 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_28 <= map_table_28;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[28])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_29 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_29 <= map_table_29;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[29])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_30 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_30 <= map_table_30;	// rename-maptable.scala:70:26, :71:25
      if (_GEN_0[30])	// rename-maptable.scala:78:69, :87:58
        br_snapshots_11_31 <= io_remap_reqs_0_pdst;	// rename-maptable.scala:71:25
      else	// rename-maptable.scala:87:58
        br_snapshots_11_31 <= map_table_31;	// rename-maptable.scala:70:26, :71:25
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:90];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h5B; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        map_table_0 = _RANDOM[7'h0][6:0];	// rename-maptable.scala:70:26
        map_table_1 = _RANDOM[7'h0][13:7];	// rename-maptable.scala:70:26
        map_table_2 = _RANDOM[7'h0][20:14];	// rename-maptable.scala:70:26
        map_table_3 = _RANDOM[7'h0][27:21];	// rename-maptable.scala:70:26
        map_table_4 = {_RANDOM[7'h0][31:28], _RANDOM[7'h1][2:0]};	// rename-maptable.scala:70:26
        map_table_5 = _RANDOM[7'h1][9:3];	// rename-maptable.scala:70:26
        map_table_6 = _RANDOM[7'h1][16:10];	// rename-maptable.scala:70:26
        map_table_7 = _RANDOM[7'h1][23:17];	// rename-maptable.scala:70:26
        map_table_8 = _RANDOM[7'h1][30:24];	// rename-maptable.scala:70:26
        map_table_9 = {_RANDOM[7'h1][31], _RANDOM[7'h2][5:0]};	// rename-maptable.scala:70:26
        map_table_10 = _RANDOM[7'h2][12:6];	// rename-maptable.scala:70:26
        map_table_11 = _RANDOM[7'h2][19:13];	// rename-maptable.scala:70:26
        map_table_12 = _RANDOM[7'h2][26:20];	// rename-maptable.scala:70:26
        map_table_13 = {_RANDOM[7'h2][31:27], _RANDOM[7'h3][1:0]};	// rename-maptable.scala:70:26
        map_table_14 = _RANDOM[7'h3][8:2];	// rename-maptable.scala:70:26
        map_table_15 = _RANDOM[7'h3][15:9];	// rename-maptable.scala:70:26
        map_table_16 = _RANDOM[7'h3][22:16];	// rename-maptable.scala:70:26
        map_table_17 = _RANDOM[7'h3][29:23];	// rename-maptable.scala:70:26
        map_table_18 = {_RANDOM[7'h3][31:30], _RANDOM[7'h4][4:0]};	// rename-maptable.scala:70:26
        map_table_19 = _RANDOM[7'h4][11:5];	// rename-maptable.scala:70:26
        map_table_20 = _RANDOM[7'h4][18:12];	// rename-maptable.scala:70:26
        map_table_21 = _RANDOM[7'h4][25:19];	// rename-maptable.scala:70:26
        map_table_22 = {_RANDOM[7'h4][31:26], _RANDOM[7'h5][0]};	// rename-maptable.scala:70:26
        map_table_23 = _RANDOM[7'h5][7:1];	// rename-maptable.scala:70:26
        map_table_24 = _RANDOM[7'h5][14:8];	// rename-maptable.scala:70:26
        map_table_25 = _RANDOM[7'h5][21:15];	// rename-maptable.scala:70:26
        map_table_26 = _RANDOM[7'h5][28:22];	// rename-maptable.scala:70:26
        map_table_27 = {_RANDOM[7'h5][31:29], _RANDOM[7'h6][3:0]};	// rename-maptable.scala:70:26
        map_table_28 = _RANDOM[7'h6][10:4];	// rename-maptable.scala:70:26
        map_table_29 = _RANDOM[7'h6][17:11];	// rename-maptable.scala:70:26
        map_table_30 = _RANDOM[7'h6][24:18];	// rename-maptable.scala:70:26
        map_table_31 = _RANDOM[7'h6][31:25];	// rename-maptable.scala:70:26
        br_snapshots_0_0 = _RANDOM[7'h7][6:0];	// rename-maptable.scala:71:25
        br_snapshots_0_1 = _RANDOM[7'h7][13:7];	// rename-maptable.scala:71:25
        br_snapshots_0_2 = _RANDOM[7'h7][20:14];	// rename-maptable.scala:71:25
        br_snapshots_0_3 = _RANDOM[7'h7][27:21];	// rename-maptable.scala:71:25
        br_snapshots_0_4 = {_RANDOM[7'h7][31:28], _RANDOM[7'h8][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_0_5 = _RANDOM[7'h8][9:3];	// rename-maptable.scala:71:25
        br_snapshots_0_6 = _RANDOM[7'h8][16:10];	// rename-maptable.scala:71:25
        br_snapshots_0_7 = _RANDOM[7'h8][23:17];	// rename-maptable.scala:71:25
        br_snapshots_0_8 = _RANDOM[7'h8][30:24];	// rename-maptable.scala:71:25
        br_snapshots_0_9 = {_RANDOM[7'h8][31], _RANDOM[7'h9][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_0_10 = _RANDOM[7'h9][12:6];	// rename-maptable.scala:71:25
        br_snapshots_0_11 = _RANDOM[7'h9][19:13];	// rename-maptable.scala:71:25
        br_snapshots_0_12 = _RANDOM[7'h9][26:20];	// rename-maptable.scala:71:25
        br_snapshots_0_13 = {_RANDOM[7'h9][31:27], _RANDOM[7'hA][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_0_14 = _RANDOM[7'hA][8:2];	// rename-maptable.scala:71:25
        br_snapshots_0_15 = _RANDOM[7'hA][15:9];	// rename-maptable.scala:71:25
        br_snapshots_0_16 = _RANDOM[7'hA][22:16];	// rename-maptable.scala:71:25
        br_snapshots_0_17 = _RANDOM[7'hA][29:23];	// rename-maptable.scala:71:25
        br_snapshots_0_18 = {_RANDOM[7'hA][31:30], _RANDOM[7'hB][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_0_19 = _RANDOM[7'hB][11:5];	// rename-maptable.scala:71:25
        br_snapshots_0_20 = _RANDOM[7'hB][18:12];	// rename-maptable.scala:71:25
        br_snapshots_0_21 = _RANDOM[7'hB][25:19];	// rename-maptable.scala:71:25
        br_snapshots_0_22 = {_RANDOM[7'hB][31:26], _RANDOM[7'hC][0]};	// rename-maptable.scala:71:25
        br_snapshots_0_23 = _RANDOM[7'hC][7:1];	// rename-maptable.scala:71:25
        br_snapshots_0_24 = _RANDOM[7'hC][14:8];	// rename-maptable.scala:71:25
        br_snapshots_0_25 = _RANDOM[7'hC][21:15];	// rename-maptable.scala:71:25
        br_snapshots_0_26 = _RANDOM[7'hC][28:22];	// rename-maptable.scala:71:25
        br_snapshots_0_27 = {_RANDOM[7'hC][31:29], _RANDOM[7'hD][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_0_28 = _RANDOM[7'hD][10:4];	// rename-maptable.scala:71:25
        br_snapshots_0_29 = _RANDOM[7'hD][17:11];	// rename-maptable.scala:71:25
        br_snapshots_0_30 = _RANDOM[7'hD][24:18];	// rename-maptable.scala:71:25
        br_snapshots_0_31 = _RANDOM[7'hD][31:25];	// rename-maptable.scala:71:25
        br_snapshots_1_0 = _RANDOM[7'hE][6:0];	// rename-maptable.scala:71:25
        br_snapshots_1_1 = _RANDOM[7'hE][13:7];	// rename-maptable.scala:71:25
        br_snapshots_1_2 = _RANDOM[7'hE][20:14];	// rename-maptable.scala:71:25
        br_snapshots_1_3 = _RANDOM[7'hE][27:21];	// rename-maptable.scala:71:25
        br_snapshots_1_4 = {_RANDOM[7'hE][31:28], _RANDOM[7'hF][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_1_5 = _RANDOM[7'hF][9:3];	// rename-maptable.scala:71:25
        br_snapshots_1_6 = _RANDOM[7'hF][16:10];	// rename-maptable.scala:71:25
        br_snapshots_1_7 = _RANDOM[7'hF][23:17];	// rename-maptable.scala:71:25
        br_snapshots_1_8 = _RANDOM[7'hF][30:24];	// rename-maptable.scala:71:25
        br_snapshots_1_9 = {_RANDOM[7'hF][31], _RANDOM[7'h10][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_1_10 = _RANDOM[7'h10][12:6];	// rename-maptable.scala:71:25
        br_snapshots_1_11 = _RANDOM[7'h10][19:13];	// rename-maptable.scala:71:25
        br_snapshots_1_12 = _RANDOM[7'h10][26:20];	// rename-maptable.scala:71:25
        br_snapshots_1_13 = {_RANDOM[7'h10][31:27], _RANDOM[7'h11][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_1_14 = _RANDOM[7'h11][8:2];	// rename-maptable.scala:71:25
        br_snapshots_1_15 = _RANDOM[7'h11][15:9];	// rename-maptable.scala:71:25
        br_snapshots_1_16 = _RANDOM[7'h11][22:16];	// rename-maptable.scala:71:25
        br_snapshots_1_17 = _RANDOM[7'h11][29:23];	// rename-maptable.scala:71:25
        br_snapshots_1_18 = {_RANDOM[7'h11][31:30], _RANDOM[7'h12][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_1_19 = _RANDOM[7'h12][11:5];	// rename-maptable.scala:71:25
        br_snapshots_1_20 = _RANDOM[7'h12][18:12];	// rename-maptable.scala:71:25
        br_snapshots_1_21 = _RANDOM[7'h12][25:19];	// rename-maptable.scala:71:25
        br_snapshots_1_22 = {_RANDOM[7'h12][31:26], _RANDOM[7'h13][0]};	// rename-maptable.scala:71:25
        br_snapshots_1_23 = _RANDOM[7'h13][7:1];	// rename-maptable.scala:71:25
        br_snapshots_1_24 = _RANDOM[7'h13][14:8];	// rename-maptable.scala:71:25
        br_snapshots_1_25 = _RANDOM[7'h13][21:15];	// rename-maptable.scala:71:25
        br_snapshots_1_26 = _RANDOM[7'h13][28:22];	// rename-maptable.scala:71:25
        br_snapshots_1_27 = {_RANDOM[7'h13][31:29], _RANDOM[7'h14][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_1_28 = _RANDOM[7'h14][10:4];	// rename-maptable.scala:71:25
        br_snapshots_1_29 = _RANDOM[7'h14][17:11];	// rename-maptable.scala:71:25
        br_snapshots_1_30 = _RANDOM[7'h14][24:18];	// rename-maptable.scala:71:25
        br_snapshots_1_31 = _RANDOM[7'h14][31:25];	// rename-maptable.scala:71:25
        br_snapshots_2_0 = _RANDOM[7'h15][6:0];	// rename-maptable.scala:71:25
        br_snapshots_2_1 = _RANDOM[7'h15][13:7];	// rename-maptable.scala:71:25
        br_snapshots_2_2 = _RANDOM[7'h15][20:14];	// rename-maptable.scala:71:25
        br_snapshots_2_3 = _RANDOM[7'h15][27:21];	// rename-maptable.scala:71:25
        br_snapshots_2_4 = {_RANDOM[7'h15][31:28], _RANDOM[7'h16][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_2_5 = _RANDOM[7'h16][9:3];	// rename-maptable.scala:71:25
        br_snapshots_2_6 = _RANDOM[7'h16][16:10];	// rename-maptable.scala:71:25
        br_snapshots_2_7 = _RANDOM[7'h16][23:17];	// rename-maptable.scala:71:25
        br_snapshots_2_8 = _RANDOM[7'h16][30:24];	// rename-maptable.scala:71:25
        br_snapshots_2_9 = {_RANDOM[7'h16][31], _RANDOM[7'h17][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_2_10 = _RANDOM[7'h17][12:6];	// rename-maptable.scala:71:25
        br_snapshots_2_11 = _RANDOM[7'h17][19:13];	// rename-maptable.scala:71:25
        br_snapshots_2_12 = _RANDOM[7'h17][26:20];	// rename-maptable.scala:71:25
        br_snapshots_2_13 = {_RANDOM[7'h17][31:27], _RANDOM[7'h18][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_2_14 = _RANDOM[7'h18][8:2];	// rename-maptable.scala:71:25
        br_snapshots_2_15 = _RANDOM[7'h18][15:9];	// rename-maptable.scala:71:25
        br_snapshots_2_16 = _RANDOM[7'h18][22:16];	// rename-maptable.scala:71:25
        br_snapshots_2_17 = _RANDOM[7'h18][29:23];	// rename-maptable.scala:71:25
        br_snapshots_2_18 = {_RANDOM[7'h18][31:30], _RANDOM[7'h19][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_2_19 = _RANDOM[7'h19][11:5];	// rename-maptable.scala:71:25
        br_snapshots_2_20 = _RANDOM[7'h19][18:12];	// rename-maptable.scala:71:25
        br_snapshots_2_21 = _RANDOM[7'h19][25:19];	// rename-maptable.scala:71:25
        br_snapshots_2_22 = {_RANDOM[7'h19][31:26], _RANDOM[7'h1A][0]};	// rename-maptable.scala:71:25
        br_snapshots_2_23 = _RANDOM[7'h1A][7:1];	// rename-maptable.scala:71:25
        br_snapshots_2_24 = _RANDOM[7'h1A][14:8];	// rename-maptable.scala:71:25
        br_snapshots_2_25 = _RANDOM[7'h1A][21:15];	// rename-maptable.scala:71:25
        br_snapshots_2_26 = _RANDOM[7'h1A][28:22];	// rename-maptable.scala:71:25
        br_snapshots_2_27 = {_RANDOM[7'h1A][31:29], _RANDOM[7'h1B][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_2_28 = _RANDOM[7'h1B][10:4];	// rename-maptable.scala:71:25
        br_snapshots_2_29 = _RANDOM[7'h1B][17:11];	// rename-maptable.scala:71:25
        br_snapshots_2_30 = _RANDOM[7'h1B][24:18];	// rename-maptable.scala:71:25
        br_snapshots_2_31 = _RANDOM[7'h1B][31:25];	// rename-maptable.scala:71:25
        br_snapshots_3_0 = _RANDOM[7'h1C][6:0];	// rename-maptable.scala:71:25
        br_snapshots_3_1 = _RANDOM[7'h1C][13:7];	// rename-maptable.scala:71:25
        br_snapshots_3_2 = _RANDOM[7'h1C][20:14];	// rename-maptable.scala:71:25
        br_snapshots_3_3 = _RANDOM[7'h1C][27:21];	// rename-maptable.scala:71:25
        br_snapshots_3_4 = {_RANDOM[7'h1C][31:28], _RANDOM[7'h1D][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_3_5 = _RANDOM[7'h1D][9:3];	// rename-maptable.scala:71:25
        br_snapshots_3_6 = _RANDOM[7'h1D][16:10];	// rename-maptable.scala:71:25
        br_snapshots_3_7 = _RANDOM[7'h1D][23:17];	// rename-maptable.scala:71:25
        br_snapshots_3_8 = _RANDOM[7'h1D][30:24];	// rename-maptable.scala:71:25
        br_snapshots_3_9 = {_RANDOM[7'h1D][31], _RANDOM[7'h1E][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_3_10 = _RANDOM[7'h1E][12:6];	// rename-maptable.scala:71:25
        br_snapshots_3_11 = _RANDOM[7'h1E][19:13];	// rename-maptable.scala:71:25
        br_snapshots_3_12 = _RANDOM[7'h1E][26:20];	// rename-maptable.scala:71:25
        br_snapshots_3_13 = {_RANDOM[7'h1E][31:27], _RANDOM[7'h1F][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_3_14 = _RANDOM[7'h1F][8:2];	// rename-maptable.scala:71:25
        br_snapshots_3_15 = _RANDOM[7'h1F][15:9];	// rename-maptable.scala:71:25
        br_snapshots_3_16 = _RANDOM[7'h1F][22:16];	// rename-maptable.scala:71:25
        br_snapshots_3_17 = _RANDOM[7'h1F][29:23];	// rename-maptable.scala:71:25
        br_snapshots_3_18 = {_RANDOM[7'h1F][31:30], _RANDOM[7'h20][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_3_19 = _RANDOM[7'h20][11:5];	// rename-maptable.scala:71:25
        br_snapshots_3_20 = _RANDOM[7'h20][18:12];	// rename-maptable.scala:71:25
        br_snapshots_3_21 = _RANDOM[7'h20][25:19];	// rename-maptable.scala:71:25
        br_snapshots_3_22 = {_RANDOM[7'h20][31:26], _RANDOM[7'h21][0]};	// rename-maptable.scala:71:25
        br_snapshots_3_23 = _RANDOM[7'h21][7:1];	// rename-maptable.scala:71:25
        br_snapshots_3_24 = _RANDOM[7'h21][14:8];	// rename-maptable.scala:71:25
        br_snapshots_3_25 = _RANDOM[7'h21][21:15];	// rename-maptable.scala:71:25
        br_snapshots_3_26 = _RANDOM[7'h21][28:22];	// rename-maptable.scala:71:25
        br_snapshots_3_27 = {_RANDOM[7'h21][31:29], _RANDOM[7'h22][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_3_28 = _RANDOM[7'h22][10:4];	// rename-maptable.scala:71:25
        br_snapshots_3_29 = _RANDOM[7'h22][17:11];	// rename-maptable.scala:71:25
        br_snapshots_3_30 = _RANDOM[7'h22][24:18];	// rename-maptable.scala:71:25
        br_snapshots_3_31 = _RANDOM[7'h22][31:25];	// rename-maptable.scala:71:25
        br_snapshots_4_0 = _RANDOM[7'h23][6:0];	// rename-maptable.scala:71:25
        br_snapshots_4_1 = _RANDOM[7'h23][13:7];	// rename-maptable.scala:71:25
        br_snapshots_4_2 = _RANDOM[7'h23][20:14];	// rename-maptable.scala:71:25
        br_snapshots_4_3 = _RANDOM[7'h23][27:21];	// rename-maptable.scala:71:25
        br_snapshots_4_4 = {_RANDOM[7'h23][31:28], _RANDOM[7'h24][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_4_5 = _RANDOM[7'h24][9:3];	// rename-maptable.scala:71:25
        br_snapshots_4_6 = _RANDOM[7'h24][16:10];	// rename-maptable.scala:71:25
        br_snapshots_4_7 = _RANDOM[7'h24][23:17];	// rename-maptable.scala:71:25
        br_snapshots_4_8 = _RANDOM[7'h24][30:24];	// rename-maptable.scala:71:25
        br_snapshots_4_9 = {_RANDOM[7'h24][31], _RANDOM[7'h25][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_4_10 = _RANDOM[7'h25][12:6];	// rename-maptable.scala:71:25
        br_snapshots_4_11 = _RANDOM[7'h25][19:13];	// rename-maptable.scala:71:25
        br_snapshots_4_12 = _RANDOM[7'h25][26:20];	// rename-maptable.scala:71:25
        br_snapshots_4_13 = {_RANDOM[7'h25][31:27], _RANDOM[7'h26][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_4_14 = _RANDOM[7'h26][8:2];	// rename-maptable.scala:71:25
        br_snapshots_4_15 = _RANDOM[7'h26][15:9];	// rename-maptable.scala:71:25
        br_snapshots_4_16 = _RANDOM[7'h26][22:16];	// rename-maptable.scala:71:25
        br_snapshots_4_17 = _RANDOM[7'h26][29:23];	// rename-maptable.scala:71:25
        br_snapshots_4_18 = {_RANDOM[7'h26][31:30], _RANDOM[7'h27][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_4_19 = _RANDOM[7'h27][11:5];	// rename-maptable.scala:71:25
        br_snapshots_4_20 = _RANDOM[7'h27][18:12];	// rename-maptable.scala:71:25
        br_snapshots_4_21 = _RANDOM[7'h27][25:19];	// rename-maptable.scala:71:25
        br_snapshots_4_22 = {_RANDOM[7'h27][31:26], _RANDOM[7'h28][0]};	// rename-maptable.scala:71:25
        br_snapshots_4_23 = _RANDOM[7'h28][7:1];	// rename-maptable.scala:71:25
        br_snapshots_4_24 = _RANDOM[7'h28][14:8];	// rename-maptable.scala:71:25
        br_snapshots_4_25 = _RANDOM[7'h28][21:15];	// rename-maptable.scala:71:25
        br_snapshots_4_26 = _RANDOM[7'h28][28:22];	// rename-maptable.scala:71:25
        br_snapshots_4_27 = {_RANDOM[7'h28][31:29], _RANDOM[7'h29][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_4_28 = _RANDOM[7'h29][10:4];	// rename-maptable.scala:71:25
        br_snapshots_4_29 = _RANDOM[7'h29][17:11];	// rename-maptable.scala:71:25
        br_snapshots_4_30 = _RANDOM[7'h29][24:18];	// rename-maptable.scala:71:25
        br_snapshots_4_31 = _RANDOM[7'h29][31:25];	// rename-maptable.scala:71:25
        br_snapshots_5_0 = _RANDOM[7'h2A][6:0];	// rename-maptable.scala:71:25
        br_snapshots_5_1 = _RANDOM[7'h2A][13:7];	// rename-maptable.scala:71:25
        br_snapshots_5_2 = _RANDOM[7'h2A][20:14];	// rename-maptable.scala:71:25
        br_snapshots_5_3 = _RANDOM[7'h2A][27:21];	// rename-maptable.scala:71:25
        br_snapshots_5_4 = {_RANDOM[7'h2A][31:28], _RANDOM[7'h2B][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_5_5 = _RANDOM[7'h2B][9:3];	// rename-maptable.scala:71:25
        br_snapshots_5_6 = _RANDOM[7'h2B][16:10];	// rename-maptable.scala:71:25
        br_snapshots_5_7 = _RANDOM[7'h2B][23:17];	// rename-maptable.scala:71:25
        br_snapshots_5_8 = _RANDOM[7'h2B][30:24];	// rename-maptable.scala:71:25
        br_snapshots_5_9 = {_RANDOM[7'h2B][31], _RANDOM[7'h2C][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_5_10 = _RANDOM[7'h2C][12:6];	// rename-maptable.scala:71:25
        br_snapshots_5_11 = _RANDOM[7'h2C][19:13];	// rename-maptable.scala:71:25
        br_snapshots_5_12 = _RANDOM[7'h2C][26:20];	// rename-maptable.scala:71:25
        br_snapshots_5_13 = {_RANDOM[7'h2C][31:27], _RANDOM[7'h2D][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_5_14 = _RANDOM[7'h2D][8:2];	// rename-maptable.scala:71:25
        br_snapshots_5_15 = _RANDOM[7'h2D][15:9];	// rename-maptable.scala:71:25
        br_snapshots_5_16 = _RANDOM[7'h2D][22:16];	// rename-maptable.scala:71:25
        br_snapshots_5_17 = _RANDOM[7'h2D][29:23];	// rename-maptable.scala:71:25
        br_snapshots_5_18 = {_RANDOM[7'h2D][31:30], _RANDOM[7'h2E][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_5_19 = _RANDOM[7'h2E][11:5];	// rename-maptable.scala:71:25
        br_snapshots_5_20 = _RANDOM[7'h2E][18:12];	// rename-maptable.scala:71:25
        br_snapshots_5_21 = _RANDOM[7'h2E][25:19];	// rename-maptable.scala:71:25
        br_snapshots_5_22 = {_RANDOM[7'h2E][31:26], _RANDOM[7'h2F][0]};	// rename-maptable.scala:71:25
        br_snapshots_5_23 = _RANDOM[7'h2F][7:1];	// rename-maptable.scala:71:25
        br_snapshots_5_24 = _RANDOM[7'h2F][14:8];	// rename-maptable.scala:71:25
        br_snapshots_5_25 = _RANDOM[7'h2F][21:15];	// rename-maptable.scala:71:25
        br_snapshots_5_26 = _RANDOM[7'h2F][28:22];	// rename-maptable.scala:71:25
        br_snapshots_5_27 = {_RANDOM[7'h2F][31:29], _RANDOM[7'h30][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_5_28 = _RANDOM[7'h30][10:4];	// rename-maptable.scala:71:25
        br_snapshots_5_29 = _RANDOM[7'h30][17:11];	// rename-maptable.scala:71:25
        br_snapshots_5_30 = _RANDOM[7'h30][24:18];	// rename-maptable.scala:71:25
        br_snapshots_5_31 = _RANDOM[7'h30][31:25];	// rename-maptable.scala:71:25
        br_snapshots_6_0 = _RANDOM[7'h31][6:0];	// rename-maptable.scala:71:25
        br_snapshots_6_1 = _RANDOM[7'h31][13:7];	// rename-maptable.scala:71:25
        br_snapshots_6_2 = _RANDOM[7'h31][20:14];	// rename-maptable.scala:71:25
        br_snapshots_6_3 = _RANDOM[7'h31][27:21];	// rename-maptable.scala:71:25
        br_snapshots_6_4 = {_RANDOM[7'h31][31:28], _RANDOM[7'h32][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_6_5 = _RANDOM[7'h32][9:3];	// rename-maptable.scala:71:25
        br_snapshots_6_6 = _RANDOM[7'h32][16:10];	// rename-maptable.scala:71:25
        br_snapshots_6_7 = _RANDOM[7'h32][23:17];	// rename-maptable.scala:71:25
        br_snapshots_6_8 = _RANDOM[7'h32][30:24];	// rename-maptable.scala:71:25
        br_snapshots_6_9 = {_RANDOM[7'h32][31], _RANDOM[7'h33][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_6_10 = _RANDOM[7'h33][12:6];	// rename-maptable.scala:71:25
        br_snapshots_6_11 = _RANDOM[7'h33][19:13];	// rename-maptable.scala:71:25
        br_snapshots_6_12 = _RANDOM[7'h33][26:20];	// rename-maptable.scala:71:25
        br_snapshots_6_13 = {_RANDOM[7'h33][31:27], _RANDOM[7'h34][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_6_14 = _RANDOM[7'h34][8:2];	// rename-maptable.scala:71:25
        br_snapshots_6_15 = _RANDOM[7'h34][15:9];	// rename-maptable.scala:71:25
        br_snapshots_6_16 = _RANDOM[7'h34][22:16];	// rename-maptable.scala:71:25
        br_snapshots_6_17 = _RANDOM[7'h34][29:23];	// rename-maptable.scala:71:25
        br_snapshots_6_18 = {_RANDOM[7'h34][31:30], _RANDOM[7'h35][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_6_19 = _RANDOM[7'h35][11:5];	// rename-maptable.scala:71:25
        br_snapshots_6_20 = _RANDOM[7'h35][18:12];	// rename-maptable.scala:71:25
        br_snapshots_6_21 = _RANDOM[7'h35][25:19];	// rename-maptable.scala:71:25
        br_snapshots_6_22 = {_RANDOM[7'h35][31:26], _RANDOM[7'h36][0]};	// rename-maptable.scala:71:25
        br_snapshots_6_23 = _RANDOM[7'h36][7:1];	// rename-maptable.scala:71:25
        br_snapshots_6_24 = _RANDOM[7'h36][14:8];	// rename-maptable.scala:71:25
        br_snapshots_6_25 = _RANDOM[7'h36][21:15];	// rename-maptable.scala:71:25
        br_snapshots_6_26 = _RANDOM[7'h36][28:22];	// rename-maptable.scala:71:25
        br_snapshots_6_27 = {_RANDOM[7'h36][31:29], _RANDOM[7'h37][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_6_28 = _RANDOM[7'h37][10:4];	// rename-maptable.scala:71:25
        br_snapshots_6_29 = _RANDOM[7'h37][17:11];	// rename-maptable.scala:71:25
        br_snapshots_6_30 = _RANDOM[7'h37][24:18];	// rename-maptable.scala:71:25
        br_snapshots_6_31 = _RANDOM[7'h37][31:25];	// rename-maptable.scala:71:25
        br_snapshots_7_0 = _RANDOM[7'h38][6:0];	// rename-maptable.scala:71:25
        br_snapshots_7_1 = _RANDOM[7'h38][13:7];	// rename-maptable.scala:71:25
        br_snapshots_7_2 = _RANDOM[7'h38][20:14];	// rename-maptable.scala:71:25
        br_snapshots_7_3 = _RANDOM[7'h38][27:21];	// rename-maptable.scala:71:25
        br_snapshots_7_4 = {_RANDOM[7'h38][31:28], _RANDOM[7'h39][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_7_5 = _RANDOM[7'h39][9:3];	// rename-maptable.scala:71:25
        br_snapshots_7_6 = _RANDOM[7'h39][16:10];	// rename-maptable.scala:71:25
        br_snapshots_7_7 = _RANDOM[7'h39][23:17];	// rename-maptable.scala:71:25
        br_snapshots_7_8 = _RANDOM[7'h39][30:24];	// rename-maptable.scala:71:25
        br_snapshots_7_9 = {_RANDOM[7'h39][31], _RANDOM[7'h3A][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_7_10 = _RANDOM[7'h3A][12:6];	// rename-maptable.scala:71:25
        br_snapshots_7_11 = _RANDOM[7'h3A][19:13];	// rename-maptable.scala:71:25
        br_snapshots_7_12 = _RANDOM[7'h3A][26:20];	// rename-maptable.scala:71:25
        br_snapshots_7_13 = {_RANDOM[7'h3A][31:27], _RANDOM[7'h3B][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_7_14 = _RANDOM[7'h3B][8:2];	// rename-maptable.scala:71:25
        br_snapshots_7_15 = _RANDOM[7'h3B][15:9];	// rename-maptable.scala:71:25
        br_snapshots_7_16 = _RANDOM[7'h3B][22:16];	// rename-maptable.scala:71:25
        br_snapshots_7_17 = _RANDOM[7'h3B][29:23];	// rename-maptable.scala:71:25
        br_snapshots_7_18 = {_RANDOM[7'h3B][31:30], _RANDOM[7'h3C][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_7_19 = _RANDOM[7'h3C][11:5];	// rename-maptable.scala:71:25
        br_snapshots_7_20 = _RANDOM[7'h3C][18:12];	// rename-maptable.scala:71:25
        br_snapshots_7_21 = _RANDOM[7'h3C][25:19];	// rename-maptable.scala:71:25
        br_snapshots_7_22 = {_RANDOM[7'h3C][31:26], _RANDOM[7'h3D][0]};	// rename-maptable.scala:71:25
        br_snapshots_7_23 = _RANDOM[7'h3D][7:1];	// rename-maptable.scala:71:25
        br_snapshots_7_24 = _RANDOM[7'h3D][14:8];	// rename-maptable.scala:71:25
        br_snapshots_7_25 = _RANDOM[7'h3D][21:15];	// rename-maptable.scala:71:25
        br_snapshots_7_26 = _RANDOM[7'h3D][28:22];	// rename-maptable.scala:71:25
        br_snapshots_7_27 = {_RANDOM[7'h3D][31:29], _RANDOM[7'h3E][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_7_28 = _RANDOM[7'h3E][10:4];	// rename-maptable.scala:71:25
        br_snapshots_7_29 = _RANDOM[7'h3E][17:11];	// rename-maptable.scala:71:25
        br_snapshots_7_30 = _RANDOM[7'h3E][24:18];	// rename-maptable.scala:71:25
        br_snapshots_7_31 = _RANDOM[7'h3E][31:25];	// rename-maptable.scala:71:25
        br_snapshots_8_0 = _RANDOM[7'h3F][6:0];	// rename-maptable.scala:71:25
        br_snapshots_8_1 = _RANDOM[7'h3F][13:7];	// rename-maptable.scala:71:25
        br_snapshots_8_2 = _RANDOM[7'h3F][20:14];	// rename-maptable.scala:71:25
        br_snapshots_8_3 = _RANDOM[7'h3F][27:21];	// rename-maptable.scala:71:25
        br_snapshots_8_4 = {_RANDOM[7'h3F][31:28], _RANDOM[7'h40][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_8_5 = _RANDOM[7'h40][9:3];	// rename-maptable.scala:71:25
        br_snapshots_8_6 = _RANDOM[7'h40][16:10];	// rename-maptable.scala:71:25
        br_snapshots_8_7 = _RANDOM[7'h40][23:17];	// rename-maptable.scala:71:25
        br_snapshots_8_8 = _RANDOM[7'h40][30:24];	// rename-maptable.scala:71:25
        br_snapshots_8_9 = {_RANDOM[7'h40][31], _RANDOM[7'h41][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_8_10 = _RANDOM[7'h41][12:6];	// rename-maptable.scala:71:25
        br_snapshots_8_11 = _RANDOM[7'h41][19:13];	// rename-maptable.scala:71:25
        br_snapshots_8_12 = _RANDOM[7'h41][26:20];	// rename-maptable.scala:71:25
        br_snapshots_8_13 = {_RANDOM[7'h41][31:27], _RANDOM[7'h42][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_8_14 = _RANDOM[7'h42][8:2];	// rename-maptable.scala:71:25
        br_snapshots_8_15 = _RANDOM[7'h42][15:9];	// rename-maptable.scala:71:25
        br_snapshots_8_16 = _RANDOM[7'h42][22:16];	// rename-maptable.scala:71:25
        br_snapshots_8_17 = _RANDOM[7'h42][29:23];	// rename-maptable.scala:71:25
        br_snapshots_8_18 = {_RANDOM[7'h42][31:30], _RANDOM[7'h43][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_8_19 = _RANDOM[7'h43][11:5];	// rename-maptable.scala:71:25
        br_snapshots_8_20 = _RANDOM[7'h43][18:12];	// rename-maptable.scala:71:25
        br_snapshots_8_21 = _RANDOM[7'h43][25:19];	// rename-maptable.scala:71:25
        br_snapshots_8_22 = {_RANDOM[7'h43][31:26], _RANDOM[7'h44][0]};	// rename-maptable.scala:71:25
        br_snapshots_8_23 = _RANDOM[7'h44][7:1];	// rename-maptable.scala:71:25
        br_snapshots_8_24 = _RANDOM[7'h44][14:8];	// rename-maptable.scala:71:25
        br_snapshots_8_25 = _RANDOM[7'h44][21:15];	// rename-maptable.scala:71:25
        br_snapshots_8_26 = _RANDOM[7'h44][28:22];	// rename-maptable.scala:71:25
        br_snapshots_8_27 = {_RANDOM[7'h44][31:29], _RANDOM[7'h45][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_8_28 = _RANDOM[7'h45][10:4];	// rename-maptable.scala:71:25
        br_snapshots_8_29 = _RANDOM[7'h45][17:11];	// rename-maptable.scala:71:25
        br_snapshots_8_30 = _RANDOM[7'h45][24:18];	// rename-maptable.scala:71:25
        br_snapshots_8_31 = _RANDOM[7'h45][31:25];	// rename-maptable.scala:71:25
        br_snapshots_9_0 = _RANDOM[7'h46][6:0];	// rename-maptable.scala:71:25
        br_snapshots_9_1 = _RANDOM[7'h46][13:7];	// rename-maptable.scala:71:25
        br_snapshots_9_2 = _RANDOM[7'h46][20:14];	// rename-maptable.scala:71:25
        br_snapshots_9_3 = _RANDOM[7'h46][27:21];	// rename-maptable.scala:71:25
        br_snapshots_9_4 = {_RANDOM[7'h46][31:28], _RANDOM[7'h47][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_9_5 = _RANDOM[7'h47][9:3];	// rename-maptable.scala:71:25
        br_snapshots_9_6 = _RANDOM[7'h47][16:10];	// rename-maptable.scala:71:25
        br_snapshots_9_7 = _RANDOM[7'h47][23:17];	// rename-maptable.scala:71:25
        br_snapshots_9_8 = _RANDOM[7'h47][30:24];	// rename-maptable.scala:71:25
        br_snapshots_9_9 = {_RANDOM[7'h47][31], _RANDOM[7'h48][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_9_10 = _RANDOM[7'h48][12:6];	// rename-maptable.scala:71:25
        br_snapshots_9_11 = _RANDOM[7'h48][19:13];	// rename-maptable.scala:71:25
        br_snapshots_9_12 = _RANDOM[7'h48][26:20];	// rename-maptable.scala:71:25
        br_snapshots_9_13 = {_RANDOM[7'h48][31:27], _RANDOM[7'h49][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_9_14 = _RANDOM[7'h49][8:2];	// rename-maptable.scala:71:25
        br_snapshots_9_15 = _RANDOM[7'h49][15:9];	// rename-maptable.scala:71:25
        br_snapshots_9_16 = _RANDOM[7'h49][22:16];	// rename-maptable.scala:71:25
        br_snapshots_9_17 = _RANDOM[7'h49][29:23];	// rename-maptable.scala:71:25
        br_snapshots_9_18 = {_RANDOM[7'h49][31:30], _RANDOM[7'h4A][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_9_19 = _RANDOM[7'h4A][11:5];	// rename-maptable.scala:71:25
        br_snapshots_9_20 = _RANDOM[7'h4A][18:12];	// rename-maptable.scala:71:25
        br_snapshots_9_21 = _RANDOM[7'h4A][25:19];	// rename-maptable.scala:71:25
        br_snapshots_9_22 = {_RANDOM[7'h4A][31:26], _RANDOM[7'h4B][0]};	// rename-maptable.scala:71:25
        br_snapshots_9_23 = _RANDOM[7'h4B][7:1];	// rename-maptable.scala:71:25
        br_snapshots_9_24 = _RANDOM[7'h4B][14:8];	// rename-maptable.scala:71:25
        br_snapshots_9_25 = _RANDOM[7'h4B][21:15];	// rename-maptable.scala:71:25
        br_snapshots_9_26 = _RANDOM[7'h4B][28:22];	// rename-maptable.scala:71:25
        br_snapshots_9_27 = {_RANDOM[7'h4B][31:29], _RANDOM[7'h4C][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_9_28 = _RANDOM[7'h4C][10:4];	// rename-maptable.scala:71:25
        br_snapshots_9_29 = _RANDOM[7'h4C][17:11];	// rename-maptable.scala:71:25
        br_snapshots_9_30 = _RANDOM[7'h4C][24:18];	// rename-maptable.scala:71:25
        br_snapshots_9_31 = _RANDOM[7'h4C][31:25];	// rename-maptable.scala:71:25
        br_snapshots_10_0 = _RANDOM[7'h4D][6:0];	// rename-maptable.scala:71:25
        br_snapshots_10_1 = _RANDOM[7'h4D][13:7];	// rename-maptable.scala:71:25
        br_snapshots_10_2 = _RANDOM[7'h4D][20:14];	// rename-maptable.scala:71:25
        br_snapshots_10_3 = _RANDOM[7'h4D][27:21];	// rename-maptable.scala:71:25
        br_snapshots_10_4 = {_RANDOM[7'h4D][31:28], _RANDOM[7'h4E][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_10_5 = _RANDOM[7'h4E][9:3];	// rename-maptable.scala:71:25
        br_snapshots_10_6 = _RANDOM[7'h4E][16:10];	// rename-maptable.scala:71:25
        br_snapshots_10_7 = _RANDOM[7'h4E][23:17];	// rename-maptable.scala:71:25
        br_snapshots_10_8 = _RANDOM[7'h4E][30:24];	// rename-maptable.scala:71:25
        br_snapshots_10_9 = {_RANDOM[7'h4E][31], _RANDOM[7'h4F][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_10_10 = _RANDOM[7'h4F][12:6];	// rename-maptable.scala:71:25
        br_snapshots_10_11 = _RANDOM[7'h4F][19:13];	// rename-maptable.scala:71:25
        br_snapshots_10_12 = _RANDOM[7'h4F][26:20];	// rename-maptable.scala:71:25
        br_snapshots_10_13 = {_RANDOM[7'h4F][31:27], _RANDOM[7'h50][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_10_14 = _RANDOM[7'h50][8:2];	// rename-maptable.scala:71:25
        br_snapshots_10_15 = _RANDOM[7'h50][15:9];	// rename-maptable.scala:71:25
        br_snapshots_10_16 = _RANDOM[7'h50][22:16];	// rename-maptable.scala:71:25
        br_snapshots_10_17 = _RANDOM[7'h50][29:23];	// rename-maptable.scala:71:25
        br_snapshots_10_18 = {_RANDOM[7'h50][31:30], _RANDOM[7'h51][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_10_19 = _RANDOM[7'h51][11:5];	// rename-maptable.scala:71:25
        br_snapshots_10_20 = _RANDOM[7'h51][18:12];	// rename-maptable.scala:71:25
        br_snapshots_10_21 = _RANDOM[7'h51][25:19];	// rename-maptable.scala:71:25
        br_snapshots_10_22 = {_RANDOM[7'h51][31:26], _RANDOM[7'h52][0]};	// rename-maptable.scala:71:25
        br_snapshots_10_23 = _RANDOM[7'h52][7:1];	// rename-maptable.scala:71:25
        br_snapshots_10_24 = _RANDOM[7'h52][14:8];	// rename-maptable.scala:71:25
        br_snapshots_10_25 = _RANDOM[7'h52][21:15];	// rename-maptable.scala:71:25
        br_snapshots_10_26 = _RANDOM[7'h52][28:22];	// rename-maptable.scala:71:25
        br_snapshots_10_27 = {_RANDOM[7'h52][31:29], _RANDOM[7'h53][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_10_28 = _RANDOM[7'h53][10:4];	// rename-maptable.scala:71:25
        br_snapshots_10_29 = _RANDOM[7'h53][17:11];	// rename-maptable.scala:71:25
        br_snapshots_10_30 = _RANDOM[7'h53][24:18];	// rename-maptable.scala:71:25
        br_snapshots_10_31 = _RANDOM[7'h53][31:25];	// rename-maptable.scala:71:25
        br_snapshots_11_0 = _RANDOM[7'h54][6:0];	// rename-maptable.scala:71:25
        br_snapshots_11_1 = _RANDOM[7'h54][13:7];	// rename-maptable.scala:71:25
        br_snapshots_11_2 = _RANDOM[7'h54][20:14];	// rename-maptable.scala:71:25
        br_snapshots_11_3 = _RANDOM[7'h54][27:21];	// rename-maptable.scala:71:25
        br_snapshots_11_4 = {_RANDOM[7'h54][31:28], _RANDOM[7'h55][2:0]};	// rename-maptable.scala:71:25
        br_snapshots_11_5 = _RANDOM[7'h55][9:3];	// rename-maptable.scala:71:25
        br_snapshots_11_6 = _RANDOM[7'h55][16:10];	// rename-maptable.scala:71:25
        br_snapshots_11_7 = _RANDOM[7'h55][23:17];	// rename-maptable.scala:71:25
        br_snapshots_11_8 = _RANDOM[7'h55][30:24];	// rename-maptable.scala:71:25
        br_snapshots_11_9 = {_RANDOM[7'h55][31], _RANDOM[7'h56][5:0]};	// rename-maptable.scala:71:25
        br_snapshots_11_10 = _RANDOM[7'h56][12:6];	// rename-maptable.scala:71:25
        br_snapshots_11_11 = _RANDOM[7'h56][19:13];	// rename-maptable.scala:71:25
        br_snapshots_11_12 = _RANDOM[7'h56][26:20];	// rename-maptable.scala:71:25
        br_snapshots_11_13 = {_RANDOM[7'h56][31:27], _RANDOM[7'h57][1:0]};	// rename-maptable.scala:71:25
        br_snapshots_11_14 = _RANDOM[7'h57][8:2];	// rename-maptable.scala:71:25
        br_snapshots_11_15 = _RANDOM[7'h57][15:9];	// rename-maptable.scala:71:25
        br_snapshots_11_16 = _RANDOM[7'h57][22:16];	// rename-maptable.scala:71:25
        br_snapshots_11_17 = _RANDOM[7'h57][29:23];	// rename-maptable.scala:71:25
        br_snapshots_11_18 = {_RANDOM[7'h57][31:30], _RANDOM[7'h58][4:0]};	// rename-maptable.scala:71:25
        br_snapshots_11_19 = _RANDOM[7'h58][11:5];	// rename-maptable.scala:71:25
        br_snapshots_11_20 = _RANDOM[7'h58][18:12];	// rename-maptable.scala:71:25
        br_snapshots_11_21 = _RANDOM[7'h58][25:19];	// rename-maptable.scala:71:25
        br_snapshots_11_22 = {_RANDOM[7'h58][31:26], _RANDOM[7'h59][0]};	// rename-maptable.scala:71:25
        br_snapshots_11_23 = _RANDOM[7'h59][7:1];	// rename-maptable.scala:71:25
        br_snapshots_11_24 = _RANDOM[7'h59][14:8];	// rename-maptable.scala:71:25
        br_snapshots_11_25 = _RANDOM[7'h59][21:15];	// rename-maptable.scala:71:25
        br_snapshots_11_26 = _RANDOM[7'h59][28:22];	// rename-maptable.scala:71:25
        br_snapshots_11_27 = {_RANDOM[7'h59][31:29], _RANDOM[7'h5A][3:0]};	// rename-maptable.scala:71:25
        br_snapshots_11_28 = _RANDOM[7'h5A][10:4];	// rename-maptable.scala:71:25
        br_snapshots_11_29 = _RANDOM[7'h5A][17:11];	// rename-maptable.scala:71:25
        br_snapshots_11_30 = _RANDOM[7'h5A][24:18];	// rename-maptable.scala:71:25
        br_snapshots_11_31 = _RANDOM[7'h5A][31:25];	// rename-maptable.scala:71:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_map_resps_0_prs1 = _GEN[io_map_reqs_0_lrs1[4:0]];	// rename-maptable.scala:113:32
  assign io_map_resps_0_prs2 = _GEN[io_map_reqs_0_lrs2[4:0]];	// rename-maptable.scala:113:32, :115:32
  assign io_map_resps_0_stale_pdst = _GEN[io_map_reqs_0_ldst[4:0]];	// rename-maptable.scala:113:32, :119:32
  assign io_map_resps_1_prs1 = _GEN[io_map_reqs_1_lrs1[4:0]];	// rename-maptable.scala:113:32, :114:10
  assign io_map_resps_1_prs2 = _GEN[io_map_reqs_1_lrs2[4:0]];	// rename-maptable.scala:113:32, :116:10
  assign io_map_resps_1_stale_pdst = _GEN[io_map_reqs_1_ldst[4:0]];	// rename-maptable.scala:113:32, :120:10
endmodule

