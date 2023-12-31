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

module RenameFreeList(
  input        clock,
               reset,
               io_reqs_0,
               io_reqs_1,
               io_reqs_2,
               io_reqs_3,
               io_dealloc_pregs_0_valid,
  input  [6:0] io_dealloc_pregs_0_bits,
  input        io_dealloc_pregs_1_valid,
  input  [6:0] io_dealloc_pregs_1_bits,
  input        io_dealloc_pregs_2_valid,
  input  [6:0] io_dealloc_pregs_2_bits,
  input        io_dealloc_pregs_3_valid,
  input  [6:0] io_dealloc_pregs_3_bits,
  input        io_ren_br_tags_0_valid,
  input  [4:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [4:0] io_ren_br_tags_1_bits,
  input        io_ren_br_tags_2_valid,
  input  [4:0] io_ren_br_tags_2_bits,
  input        io_ren_br_tags_3_valid,
  input  [4:0] io_ren_br_tags_3_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_debug_pipeline_empty,
  output       io_alloc_pregs_0_valid,
  output [6:0] io_alloc_pregs_0_bits,
  output       io_alloc_pregs_1_valid,
  output [6:0] io_alloc_pregs_1_bits,
  output       io_alloc_pregs_2_valid,
  output [6:0] io_alloc_pregs_2_bits,
  output       io_alloc_pregs_3_valid,
  output [6:0] io_alloc_pregs_3_bits
);

  reg  [6:0]         r_sel_3;	// Reg.scala:15:16
  reg  [6:0]         r_sel_2;	// Reg.scala:15:16
  reg  [6:0]         r_sel_1;	// Reg.scala:15:16
  reg  [6:0]         r_sel;	// Reg.scala:15:16
  reg  [127:0]       free_list;	// rename-freelist.scala:50:26
  reg  [127:0]       br_alloc_lists_0;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_1;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_2;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_3;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_4;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_5;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_6;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_7;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_8;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_9;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_10;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_11;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_12;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_13;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_14;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_15;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_16;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_17;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_18;	// rename-freelist.scala:51:27
  reg  [127:0]       br_alloc_lists_19;	// rename-freelist.scala:51:27
  wire [127:0]       sels_0 =
    free_list[0]
      ? 128'h1
      : free_list[1]
          ? 128'h2
          : free_list[2]
              ? 128'h4
              : free_list[3]
                  ? 128'h8
                  : free_list[4]
                      ? 128'h10
                      : free_list[5]
                          ? 128'h20
                          : free_list[6]
                              ? 128'h40
                              : free_list[7]
                                  ? 128'h80
                                  : free_list[8]
                                      ? 128'h100
                                      : free_list[9]
                                          ? 128'h200
                                          : free_list[10]
                                              ? 128'h400
                                              : free_list[11]
                                                  ? 128'h800
                                                  : free_list[12]
                                                      ? 128'h1000
                                                      : free_list[13]
                                                          ? 128'h2000
                                                          : free_list[14]
                                                              ? 128'h4000
                                                              : free_list[15]
                                                                  ? 128'h8000
                                                                  : free_list[16]
                                                                      ? 128'h10000
                                                                      : free_list[17]
                                                                          ? 128'h20000
                                                                          : free_list[18]
                                                                              ? 128'h40000
                                                                              : free_list[19]
                                                                                  ? 128'h80000
                                                                                  : free_list[20]
                                                                                      ? 128'h100000
                                                                                      : free_list[21]
                                                                                          ? 128'h200000
                                                                                          : free_list[22]
                                                                                              ? 128'h400000
                                                                                              : free_list[23]
                                                                                                  ? 128'h800000
                                                                                                  : free_list[24]
                                                                                                      ? 128'h1000000
                                                                                                      : free_list[25]
                                                                                                          ? 128'h2000000
                                                                                                          : free_list[26]
                                                                                                              ? 128'h4000000
                                                                                                              : free_list[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : free_list[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : free_list[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : free_list[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                          ? 128'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                              ? 128'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                  ? 128'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                      ? 128'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                          ? 128'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                              ? 128'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                  ? 128'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                      ? 128'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                          ? 128'h20000000000
                                                                                                                                                                          : free_list[42]
                                                                                                                                                                              ? 128'h40000000000
                                                                                                                                                                              : free_list[43]
                                                                                                                                                                                  ? 128'h80000000000
                                                                                                                                                                                  : free_list[44]
                                                                                                                                                                                      ? 128'h100000000000
                                                                                                                                                                                      : free_list[45]
                                                                                                                                                                                          ? 128'h200000000000
                                                                                                                                                                                          : free_list[46]
                                                                                                                                                                                              ? 128'h400000000000
                                                                                                                                                                                              : free_list[47]
                                                                                                                                                                                                  ? 128'h800000000000
                                                                                                                                                                                                  : free_list[48]
                                                                                                                                                                                                      ? 128'h1000000000000
                                                                                                                                                                                                      : free_list[49]
                                                                                                                                                                                                          ? 128'h2000000000000
                                                                                                                                                                                                          : free_list[50]
                                                                                                                                                                                                              ? 128'h4000000000000
                                                                                                                                                                                                              : free_list[51]
                                                                                                                                                                                                                  ? 128'h8000000000000
                                                                                                                                                                                                                  : free_list[52]
                                                                                                                                                                                                                      ? 128'h10000000000000
                                                                                                                                                                                                                      : free_list[53]
                                                                                                                                                                                                                          ? 128'h20000000000000
                                                                                                                                                                                                                          : free_list[54]
                                                                                                                                                                                                                              ? 128'h40000000000000
                                                                                                                                                                                                                              : free_list[55]
                                                                                                                                                                                                                                  ? 128'h80000000000000
                                                                                                                                                                                                                                  : free_list[56]
                                                                                                                                                                                                                                      ? 128'h100000000000000
                                                                                                                                                                                                                                      : free_list[57]
                                                                                                                                                                                                                                          ? 128'h200000000000000
                                                                                                                                                                                                                                          : free_list[58]
                                                                                                                                                                                                                                              ? 128'h400000000000000
                                                                                                                                                                                                                                              : free_list[59]
                                                                                                                                                                                                                                                  ? 128'h800000000000000
                                                                                                                                                                                                                                                  : free_list[60]
                                                                                                                                                                                                                                                      ? 128'h1000000000000000
                                                                                                                                                                                                                                                      : free_list[61]
                                                                                                                                                                                                                                                          ? 128'h2000000000000000
                                                                                                                                                                                                                                                          : free_list[62]
                                                                                                                                                                                                                                                              ? 128'h4000000000000000
                                                                                                                                                                                                                                                              : free_list[63]
                                                                                                                                                                                                                                                                  ? 128'h8000000000000000
                                                                                                                                                                                                                                                                  : free_list[64]
                                                                                                                                                                                                                                                                      ? 128'h10000000000000000
                                                                                                                                                                                                                                                                      : free_list[65]
                                                                                                                                                                                                                                                                          ? 128'h20000000000000000
                                                                                                                                                                                                                                                                          : free_list[66]
                                                                                                                                                                                                                                                                              ? 128'h40000000000000000
                                                                                                                                                                                                                                                                              : free_list[67]
                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000
                                                                                                                                                                                                                                                                                  : free_list[68]
                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000
                                                                                                                                                                                                                                                                                      : free_list[69]
                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000
                                                                                                                                                                                                                                                                                          : free_list[70]
                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000
                                                                                                                                                                                                                                                                                              : free_list[71]
                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[72]
                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[73]
                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[74]
                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[75]
                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[76]
                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[77]
                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[78]
                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000
                                                                                                                                                                                                                                                                                                                              : free_list[79]
                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000
                                                                                                                                                                                                                                                                                                                                  : free_list[80]
                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000
                                                                                                                                                                                                                                                                                                                                      : free_list[81]
                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000
                                                                                                                                                                                                                                                                                                                                          : free_list[82]
                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000
                                                                                                                                                                                                                                                                                                                                              : free_list[83]
                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : free_list[84]
                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : free_list[85]
                                                                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000000
                                                                                                                                                                                                                                                                                                                                                          : free_list[86]
                                                                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000000
                                                                                                                                                                                                                                                                                                                                                              : free_list[87]
                                                                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                  : free_list[88]
                                                                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                      : free_list[89]
                                                                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                          : free_list[90]
                                                                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                              : free_list[91]
                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                  : free_list[92]
                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                      : free_list[93]
                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                          : free_list[94]
                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                              : free_list[95]
                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[96]
                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[97]
                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[98]
                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[99]
                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[100]
                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[101]
                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[102]
                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[103]
                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[104]
                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[105]
                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[106]
                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[107]
                                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[108]
                                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[109]
                                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[110]
                                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[111]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[112]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[113]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[114]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[115]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h80000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[116]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h100000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[117]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h200000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[118]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h400000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[119]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h800000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[120]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h1000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[121]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h2000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[122]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h4000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : free_list[123]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ? 128'h8000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[124]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ? 128'h10000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[125]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ? 128'h20000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[126]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ? 128'h40000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : {free_list[127],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 127'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}
  wire [127:0]       _sels_T = ~sels_0;	// Mux.scala:47:69, util.scala:410:21
  wire [127:0]       _sels_sels_1_T_213 =
    free_list[42] & _sels_T[42]
      ? 128'h40000000000
      : free_list[43] & _sels_T[43]
          ? 128'h80000000000
          : free_list[44] & _sels_T[44]
              ? 128'h100000000000
              : free_list[45] & _sels_T[45]
                  ? 128'h200000000000
                  : free_list[46] & _sels_T[46]
                      ? 128'h400000000000
                      : free_list[47] & _sels_T[47]
                          ? 128'h800000000000
                          : free_list[48] & _sels_T[48]
                              ? 128'h1000000000000
                              : free_list[49] & _sels_T[49]
                                  ? 128'h2000000000000
                                  : free_list[50] & _sels_T[50]
                                      ? 128'h4000000000000
                                      : free_list[51] & _sels_T[51]
                                          ? 128'h8000000000000
                                          : free_list[52] & _sels_T[52]
                                              ? 128'h10000000000000
                                              : free_list[53] & _sels_T[53]
                                                  ? 128'h20000000000000
                                                  : free_list[54] & _sels_T[54]
                                                      ? 128'h40000000000000
                                                      : free_list[55] & _sels_T[55]
                                                          ? 128'h80000000000000
                                                          : free_list[56] & _sels_T[56]
                                                              ? 128'h100000000000000
                                                              : free_list[57]
                                                                & _sels_T[57]
                                                                  ? 128'h200000000000000
                                                                  : free_list[58]
                                                                    & _sels_T[58]
                                                                      ? 128'h400000000000000
                                                                      : free_list[59]
                                                                        & _sels_T[59]
                                                                          ? 128'h800000000000000
                                                                          : free_list[60]
                                                                            & _sels_T[60]
                                                                              ? 128'h1000000000000000
                                                                              : free_list[61]
                                                                                & _sels_T[61]
                                                                                  ? 128'h2000000000000000
                                                                                  : free_list[62]
                                                                                    & _sels_T[62]
                                                                                      ? 128'h4000000000000000
                                                                                      : free_list[63]
                                                                                        & _sels_T[63]
                                                                                          ? 128'h8000000000000000
                                                                                          : free_list[64]
                                                                                            & _sels_T[64]
                                                                                              ? 128'h10000000000000000
                                                                                              : free_list[65]
                                                                                                & _sels_T[65]
                                                                                                  ? 128'h20000000000000000
                                                                                                  : free_list[66]
                                                                                                    & _sels_T[66]
                                                                                                      ? 128'h40000000000000000
                                                                                                      : free_list[67]
                                                                                                        & _sels_T[67]
                                                                                                          ? 128'h80000000000000000
                                                                                                          : free_list[68]
                                                                                                            & _sels_T[68]
                                                                                                              ? 128'h100000000000000000
                                                                                                              : free_list[69]
                                                                                                                & _sels_T[69]
                                                                                                                  ? 128'h200000000000000000
                                                                                                                  : free_list[70]
                                                                                                                    & _sels_T[70]
                                                                                                                      ? 128'h400000000000000000
                                                                                                                      : free_list[71]
                                                                                                                        & _sels_T[71]
                                                                                                                          ? 128'h800000000000000000
                                                                                                                          : free_list[72]
                                                                                                                            & _sels_T[72]
                                                                                                                              ? 128'h1000000000000000000
                                                                                                                              : free_list[73]
                                                                                                                                & _sels_T[73]
                                                                                                                                  ? 128'h2000000000000000000
                                                                                                                                  : free_list[74]
                                                                                                                                    & _sels_T[74]
                                                                                                                                      ? 128'h4000000000000000000
                                                                                                                                      : free_list[75]
                                                                                                                                        & _sels_T[75]
                                                                                                                                          ? 128'h8000000000000000000
                                                                                                                                          : free_list[76]
                                                                                                                                            & _sels_T[76]
                                                                                                                                              ? 128'h10000000000000000000
                                                                                                                                              : free_list[77]
                                                                                                                                                & _sels_T[77]
                                                                                                                                                  ? 128'h20000000000000000000
                                                                                                                                                  : free_list[78]
                                                                                                                                                    & _sels_T[78]
                                                                                                                                                      ? 128'h40000000000000000000
                                                                                                                                                      : free_list[79]
                                                                                                                                                        & _sels_T[79]
                                                                                                                                                          ? 128'h80000000000000000000
                                                                                                                                                          : free_list[80]
                                                                                                                                                            & _sels_T[80]
                                                                                                                                                              ? 128'h100000000000000000000
                                                                                                                                                              : free_list[81]
                                                                                                                                                                & _sels_T[81]
                                                                                                                                                                  ? 128'h200000000000000000000
                                                                                                                                                                  : free_list[82]
                                                                                                                                                                    & _sels_T[82]
                                                                                                                                                                      ? 128'h400000000000000000000
                                                                                                                                                                      : free_list[83]
                                                                                                                                                                        & _sels_T[83]
                                                                                                                                                                          ? 128'h800000000000000000000
                                                                                                                                                                          : free_list[84]
                                                                                                                                                                            & _sels_T[84]
                                                                                                                                                                              ? 128'h1000000000000000000000
                                                                                                                                                                              : free_list[85]
                                                                                                                                                                                & _sels_T[85]
                                                                                                                                                                                  ? 128'h2000000000000000000000
                                                                                                                                                                                  : free_list[86]
                                                                                                                                                                                    & _sels_T[86]
                                                                                                                                                                                      ? 128'h4000000000000000000000
                                                                                                                                                                                      : free_list[87]
                                                                                                                                                                                        & _sels_T[87]
                                                                                                                                                                                          ? 128'h8000000000000000000000
                                                                                                                                                                                          : free_list[88]
                                                                                                                                                                                            & _sels_T[88]
                                                                                                                                                                                              ? 128'h10000000000000000000000
                                                                                                                                                                                              : free_list[89]
                                                                                                                                                                                                & _sels_T[89]
                                                                                                                                                                                                  ? 128'h20000000000000000000000
                                                                                                                                                                                                  : free_list[90]
                                                                                                                                                                                                    & _sels_T[90]
                                                                                                                                                                                                      ? 128'h40000000000000000000000
                                                                                                                                                                                                      : free_list[91]
                                                                                                                                                                                                        & _sels_T[91]
                                                                                                                                                                                                          ? 128'h80000000000000000000000
                                                                                                                                                                                                          : free_list[92]
                                                                                                                                                                                                            & _sels_T[92]
                                                                                                                                                                                                              ? 128'h100000000000000000000000
                                                                                                                                                                                                              : free_list[93]
                                                                                                                                                                                                                & _sels_T[93]
                                                                                                                                                                                                                  ? 128'h200000000000000000000000
                                                                                                                                                                                                                  : free_list[94]
                                                                                                                                                                                                                    & _sels_T[94]
                                                                                                                                                                                                                      ? 128'h400000000000000000000000
                                                                                                                                                                                                                      : free_list[95]
                                                                                                                                                                                                                        & _sels_T[95]
                                                                                                                                                                                                                          ? 128'h800000000000000000000000
                                                                                                                                                                                                                          : free_list[96]
                                                                                                                                                                                                                            & _sels_T[96]
                                                                                                                                                                                                                              ? 128'h1000000000000000000000000
                                                                                                                                                                                                                              : free_list[97]
                                                                                                                                                                                                                                & _sels_T[97]
                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000
                                                                                                                                                                                                                                  : free_list[98]
                                                                                                                                                                                                                                    & _sels_T[98]
                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000
                                                                                                                                                                                                                                      : free_list[99]
                                                                                                                                                                                                                                        & _sels_T[99]
                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000
                                                                                                                                                                                                                                          : free_list[100]
                                                                                                                                                                                                                                            & _sels_T[100]
                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000
                                                                                                                                                                                                                                              : free_list[101]
                                                                                                                                                                                                                                                & _sels_T[101]
                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000
                                                                                                                                                                                                                                                  : free_list[102]
                                                                                                                                                                                                                                                    & _sels_T[102]
                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000
                                                                                                                                                                                                                                                      : free_list[103]
                                                                                                                                                                                                                                                        & _sels_T[103]
                                                                                                                                                                                                                                                          ? 128'h80000000000000000000000000
                                                                                                                                                                                                                                                          : free_list[104]
                                                                                                                                                                                                                                                            & _sels_T[104]
                                                                                                                                                                                                                                                              ? 128'h100000000000000000000000000
                                                                                                                                                                                                                                                              : free_list[105]
                                                                                                                                                                                                                                                                & _sels_T[105]
                                                                                                                                                                                                                                                                  ? 128'h200000000000000000000000000
                                                                                                                                                                                                                                                                  : free_list[106]
                                                                                                                                                                                                                                                                    & _sels_T[106]
                                                                                                                                                                                                                                                                      ? 128'h400000000000000000000000000
                                                                                                                                                                                                                                                                      : free_list[107]
                                                                                                                                                                                                                                                                        & _sels_T[107]
                                                                                                                                                                                                                                                                          ? 128'h800000000000000000000000000
                                                                                                                                                                                                                                                                          : free_list[108]
                                                                                                                                                                                                                                                                            & _sels_T[108]
                                                                                                                                                                                                                                                                              ? 128'h1000000000000000000000000000
                                                                                                                                                                                                                                                                              : free_list[109]
                                                                                                                                                                                                                                                                                & _sels_T[109]
                                                                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000000
                                                                                                                                                                                                                                                                                  : free_list[110]
                                                                                                                                                                                                                                                                                    & _sels_T[110]
                                                                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000000
                                                                                                                                                                                                                                                                                      : free_list[111]
                                                                                                                                                                                                                                                                                        & _sels_T[111]
                                                                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000000
                                                                                                                                                                                                                                                                                          : free_list[112]
                                                                                                                                                                                                                                                                                            & _sels_T[112]
                                                                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000000
                                                                                                                                                                                                                                                                                              : free_list[113]
                                                                                                                                                                                                                                                                                                & _sels_T[113]
                                                                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[114]
                                                                                                                                                                                                                                                                                                    & _sels_T[114]
                                                                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[115]
                                                                                                                                                                                                                                                                                                        & _sels_T[115]
                                                                                                                                                                                                                                                                                                          ? 128'h80000000000000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[116]
                                                                                                                                                                                                                                                                                                            & _sels_T[116]
                                                                                                                                                                                                                                                                                                              ? 128'h100000000000000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[117]
                                                                                                                                                                                                                                                                                                                & _sels_T[117]
                                                                                                                                                                                                                                                                                                                  ? 128'h200000000000000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[118]
                                                                                                                                                                                                                                                                                                                    & _sels_T[118]
                                                                                                                                                                                                                                                                                                                      ? 128'h400000000000000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[119]
                                                                                                                                                                                                                                                                                                                        & _sels_T[119]
                                                                                                                                                                                                                                                                                                                          ? 128'h800000000000000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[120]
                                                                                                                                                                                                                                                                                                                            & _sels_T[120]
                                                                                                                                                                                                                                                                                                                              ? 128'h1000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                              : free_list[121]
                                                                                                                                                                                                                                                                                                                                & _sels_T[121]
                                                                                                                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                  : free_list[122]
                                                                                                                                                                                                                                                                                                                                    & _sels_T[122]
                                                                                                                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                      : free_list[123]
                                                                                                                                                                                                                                                                                                                                        & _sels_T[123]
                                                                                                                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                          : free_list[124]
                                                                                                                                                                                                                                                                                                                                            & _sels_T[124]
                                                                                                                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                              : free_list[125]
                                                                                                                                                                                                                                                                                                                                                & _sels_T[125]
                                                                                                                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : free_list[126]
                                                                                                                                                                                                                                                                                                                                                    & _sels_T[126]
                                                                                                                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : {free_list[127]
                                                                                                                                                                                                                                                                                                                                                           & _sels_T[127],
                                                                                                                                                                                                                                                                                                                                                         127'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire [127:0]       sels_1 =
    free_list[0] & _sels_T[0]
      ? 128'h1
      : free_list[1] & _sels_T[1]
          ? 128'h2
          : free_list[2] & _sels_T[2]
              ? 128'h4
              : free_list[3] & _sels_T[3]
                  ? 128'h8
                  : free_list[4] & _sels_T[4]
                      ? 128'h10
                      : free_list[5] & _sels_T[5]
                          ? 128'h20
                          : free_list[6] & _sels_T[6]
                              ? 128'h40
                              : free_list[7] & _sels_T[7]
                                  ? 128'h80
                                  : free_list[8] & _sels_T[8]
                                      ? 128'h100
                                      : free_list[9] & _sels_T[9]
                                          ? 128'h200
                                          : free_list[10] & _sels_T[10]
                                              ? 128'h400
                                              : free_list[11] & _sels_T[11]
                                                  ? 128'h800
                                                  : free_list[12] & _sels_T[12]
                                                      ? 128'h1000
                                                      : free_list[13] & _sels_T[13]
                                                          ? 128'h2000
                                                          : free_list[14] & _sels_T[14]
                                                              ? 128'h4000
                                                              : free_list[15]
                                                                & _sels_T[15]
                                                                  ? 128'h8000
                                                                  : free_list[16]
                                                                    & _sels_T[16]
                                                                      ? 128'h10000
                                                                      : free_list[17]
                                                                        & _sels_T[17]
                                                                          ? 128'h20000
                                                                          : free_list[18]
                                                                            & _sels_T[18]
                                                                              ? 128'h40000
                                                                              : free_list[19]
                                                                                & _sels_T[19]
                                                                                  ? 128'h80000
                                                                                  : free_list[20]
                                                                                    & _sels_T[20]
                                                                                      ? 128'h100000
                                                                                      : free_list[21]
                                                                                        & _sels_T[21]
                                                                                          ? 128'h200000
                                                                                          : free_list[22]
                                                                                            & _sels_T[22]
                                                                                              ? 128'h400000
                                                                                              : free_list[23]
                                                                                                & _sels_T[23]
                                                                                                  ? 128'h800000
                                                                                                  : free_list[24]
                                                                                                    & _sels_T[24]
                                                                                                      ? 128'h1000000
                                                                                                      : free_list[25]
                                                                                                        & _sels_T[25]
                                                                                                          ? 128'h2000000
                                                                                                          : free_list[26]
                                                                                                            & _sels_T[26]
                                                                                                              ? 128'h4000000
                                                                                                              : free_list[27]
                                                                                                                & _sels_T[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : free_list[28]
                                                                                                                    & _sels_T[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : free_list[29]
                                                                                                                        & _sels_T[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : free_list[30]
                                                                                                                            & _sels_T[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                & _sels_T[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                    & _sels_T[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                        & _sels_T[33]
                                                                                                                                          ? 128'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                            & _sels_T[34]
                                                                                                                                              ? 128'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                & _sels_T[35]
                                                                                                                                                  ? 128'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                    & _sels_T[36]
                                                                                                                                                      ? 128'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                        & _sels_T[37]
                                                                                                                                                          ? 128'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                            & _sels_T[38]
                                                                                                                                                              ? 128'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                & _sels_T[39]
                                                                                                                                                                  ? 128'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                    & _sels_T[40]
                                                                                                                                                                      ? 128'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                        & _sels_T[41]
                                                                                                                                                                          ? 128'h20000000000
                                                                                                                                                                          : _sels_sels_1_T_213;	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}, util.scala:410:{19,21}
  wire [127:0]       _sels_T_2 = ~sels_1;	// Mux.scala:47:69, util.scala:410:21
  wire               _GEN = free_list[0] & _sels_T[0];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_0 = free_list[1] & _sels_T[1];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_1 = free_list[2] & _sels_T[2];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_2 = free_list[3] & _sels_T[3];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_3 = free_list[4] & _sels_T[4];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_4 = free_list[5] & _sels_T[5];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_5 = free_list[6] & _sels_T[6];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_6 = free_list[7] & _sels_T[7];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_7 = free_list[8] & _sels_T[8];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_8 = free_list[9] & _sels_T[9];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_9 = free_list[10] & _sels_T[10];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_10 = free_list[11] & _sels_T[11];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_11 = free_list[12] & _sels_T[12];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_12 = free_list[13] & _sels_T[13];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_13 = free_list[14] & _sels_T[14];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_14 = free_list[15] & _sels_T[15];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_15 = free_list[16] & _sels_T[16];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_16 = free_list[17] & _sels_T[17];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_17 = free_list[18] & _sels_T[18];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_18 = free_list[19] & _sels_T[19];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_19 = free_list[20] & _sels_T[20];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_20 = free_list[21] & _sels_T[21];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_21 = free_list[22] & _sels_T[22];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_22 = free_list[23] & _sels_T[23];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_23 = free_list[24] & _sels_T[24];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_24 = free_list[25] & _sels_T[25];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_25 = free_list[26] & _sels_T[26];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_26 = free_list[27] & _sels_T[27];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_27 = free_list[28] & _sels_T[28];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_28 = free_list[29] & _sels_T[29];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_29 = free_list[30] & _sels_T[30];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_30 = free_list[31] & _sels_T[31];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_31 = free_list[32] & _sels_T[32];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_32 = free_list[33] & _sels_T[33];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_33 = free_list[34] & _sels_T[34];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_34 = free_list[35] & _sels_T[35];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_35 = free_list[36] & _sels_T[36];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_36 = free_list[37] & _sels_T[37];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_37 = free_list[38] & _sels_T[38];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_38 = free_list[39] & _sels_T[39];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_39 = free_list[40] & _sels_T[40];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_40 = free_list[41] & _sels_T[41];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_41 = free_list[42] & _sels_T[42];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_42 = free_list[43] & _sels_T[43];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_43 = free_list[44] & _sels_T[44];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_44 = free_list[45] & _sels_T[45];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_45 = free_list[46] & _sels_T[46];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_46 = free_list[47] & _sels_T[47];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_47 = free_list[48] & _sels_T[48];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_48 = free_list[49] & _sels_T[49];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_49 = free_list[50] & _sels_T[50];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_50 = free_list[51] & _sels_T[51];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_51 = free_list[52] & _sels_T[52];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_52 = free_list[53] & _sels_T[53];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_53 = free_list[54] & _sels_T[54];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_54 = free_list[55] & _sels_T[55];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_55 = free_list[56] & _sels_T[56];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_56 = free_list[57] & _sels_T[57];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_57 = free_list[58] & _sels_T[58];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_58 = free_list[59] & _sels_T[59];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_59 = free_list[60] & _sels_T[60];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_60 = free_list[61] & _sels_T[61];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_61 = free_list[62] & _sels_T[62];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_62 = free_list[63] & _sels_T[63];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_63 = free_list[64] & _sels_T[64];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_64 = free_list[65] & _sels_T[65];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_65 = free_list[66] & _sels_T[66];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_66 = free_list[67] & _sels_T[67];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_67 = free_list[68] & _sels_T[68];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_68 = free_list[69] & _sels_T[69];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_69 = free_list[70] & _sels_T[70];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_70 = free_list[71] & _sels_T[71];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_71 = free_list[72] & _sels_T[72];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_72 = free_list[73] & _sels_T[73];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_73 = free_list[74] & _sels_T[74];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_74 = free_list[75] & _sels_T[75];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_75 = free_list[76] & _sels_T[76];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_76 = free_list[77] & _sels_T[77];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_77 = free_list[78] & _sels_T[78];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_78 = free_list[79] & _sels_T[79];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_79 = free_list[80] & _sels_T[80];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_80 = free_list[81] & _sels_T[81];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_81 = free_list[82] & _sels_T[82];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_82 = free_list[83] & _sels_T[83];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_83 = free_list[84] & _sels_T[84];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_84 = free_list[85] & _sels_T[85];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_85 = free_list[86] & _sels_T[86];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_86 = free_list[87] & _sels_T[87];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_87 = free_list[88] & _sels_T[88];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_88 = free_list[89] & _sels_T[89];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_89 = free_list[90] & _sels_T[90];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_90 = free_list[91] & _sels_T[91];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_91 = free_list[92] & _sels_T[92];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_92 = free_list[93] & _sels_T[93];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_93 = free_list[94] & _sels_T[94];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_94 = free_list[95] & _sels_T[95];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_95 = free_list[96] & _sels_T[96];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_96 = free_list[97] & _sels_T[97];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_97 = free_list[98] & _sels_T[98];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_98 = free_list[99] & _sels_T[99];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_99 = free_list[100] & _sels_T[100];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_100 = free_list[101] & _sels_T[101];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_101 = free_list[102] & _sels_T[102];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_102 = free_list[103] & _sels_T[103];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_103 = free_list[104] & _sels_T[104];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_104 = free_list[105] & _sels_T[105];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_105 = free_list[106] & _sels_T[106];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_106 = free_list[107] & _sels_T[107];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_107 = free_list[108] & _sels_T[108];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_108 = free_list[109] & _sels_T[109];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_109 = free_list[110] & _sels_T[110];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_110 = free_list[111] & _sels_T[111];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_111 = free_list[112] & _sels_T[112];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_112 = free_list[113] & _sels_T[113];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_113 = free_list[114] & _sels_T[114];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_114 = free_list[115] & _sels_T[115];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_115 = free_list[116] & _sels_T[116];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_116 = free_list[117] & _sels_T[117];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_117 = free_list[118] & _sels_T[118];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_118 = free_list[119] & _sels_T[119];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_119 = free_list[120] & _sels_T[120];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_120 = free_list[121] & _sels_T[121];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_121 = free_list[122] & _sels_T[122];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_122 = free_list[123] & _sels_T[123];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_123 = free_list[124] & _sels_T[124];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_124 = free_list[125] & _sels_T[125];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_125 = free_list[126] & _sels_T[126];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire               _GEN_126 = free_list[127] & _sels_T[127];	// OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire [127:0]       _sels_sels_2_T_213 =
    _GEN_41 & _sels_T_2[42]
      ? 128'h40000000000
      : _GEN_42 & _sels_T_2[43]
          ? 128'h80000000000
          : _GEN_43 & _sels_T_2[44]
              ? 128'h100000000000
              : _GEN_44 & _sels_T_2[45]
                  ? 128'h200000000000
                  : _GEN_45 & _sels_T_2[46]
                      ? 128'h400000000000
                      : _GEN_46 & _sels_T_2[47]
                          ? 128'h800000000000
                          : _GEN_47 & _sels_T_2[48]
                              ? 128'h1000000000000
                              : _GEN_48 & _sels_T_2[49]
                                  ? 128'h2000000000000
                                  : _GEN_49 & _sels_T_2[50]
                                      ? 128'h4000000000000
                                      : _GEN_50 & _sels_T_2[51]
                                          ? 128'h8000000000000
                                          : _GEN_51 & _sels_T_2[52]
                                              ? 128'h10000000000000
                                              : _GEN_52 & _sels_T_2[53]
                                                  ? 128'h20000000000000
                                                  : _GEN_53 & _sels_T_2[54]
                                                      ? 128'h40000000000000
                                                      : _GEN_54 & _sels_T_2[55]
                                                          ? 128'h80000000000000
                                                          : _GEN_55 & _sels_T_2[56]
                                                              ? 128'h100000000000000
                                                              : _GEN_56 & _sels_T_2[57]
                                                                  ? 128'h200000000000000
                                                                  : _GEN_57
                                                                    & _sels_T_2[58]
                                                                      ? 128'h400000000000000
                                                                      : _GEN_58
                                                                        & _sels_T_2[59]
                                                                          ? 128'h800000000000000
                                                                          : _GEN_59
                                                                            & _sels_T_2[60]
                                                                              ? 128'h1000000000000000
                                                                              : _GEN_60
                                                                                & _sels_T_2[61]
                                                                                  ? 128'h2000000000000000
                                                                                  : _GEN_61
                                                                                    & _sels_T_2[62]
                                                                                      ? 128'h4000000000000000
                                                                                      : _GEN_62
                                                                                        & _sels_T_2[63]
                                                                                          ? 128'h8000000000000000
                                                                                          : _GEN_63
                                                                                            & _sels_T_2[64]
                                                                                              ? 128'h10000000000000000
                                                                                              : _GEN_64
                                                                                                & _sels_T_2[65]
                                                                                                  ? 128'h20000000000000000
                                                                                                  : _GEN_65
                                                                                                    & _sels_T_2[66]
                                                                                                      ? 128'h40000000000000000
                                                                                                      : _GEN_66
                                                                                                        & _sels_T_2[67]
                                                                                                          ? 128'h80000000000000000
                                                                                                          : _GEN_67
                                                                                                            & _sels_T_2[68]
                                                                                                              ? 128'h100000000000000000
                                                                                                              : _GEN_68
                                                                                                                & _sels_T_2[69]
                                                                                                                  ? 128'h200000000000000000
                                                                                                                  : _GEN_69
                                                                                                                    & _sels_T_2[70]
                                                                                                                      ? 128'h400000000000000000
                                                                                                                      : _GEN_70
                                                                                                                        & _sels_T_2[71]
                                                                                                                          ? 128'h800000000000000000
                                                                                                                          : _GEN_71
                                                                                                                            & _sels_T_2[72]
                                                                                                                              ? 128'h1000000000000000000
                                                                                                                              : _GEN_72
                                                                                                                                & _sels_T_2[73]
                                                                                                                                  ? 128'h2000000000000000000
                                                                                                                                  : _GEN_73
                                                                                                                                    & _sels_T_2[74]
                                                                                                                                      ? 128'h4000000000000000000
                                                                                                                                      : _GEN_74
                                                                                                                                        & _sels_T_2[75]
                                                                                                                                          ? 128'h8000000000000000000
                                                                                                                                          : _GEN_75
                                                                                                                                            & _sels_T_2[76]
                                                                                                                                              ? 128'h10000000000000000000
                                                                                                                                              : _GEN_76
                                                                                                                                                & _sels_T_2[77]
                                                                                                                                                  ? 128'h20000000000000000000
                                                                                                                                                  : _GEN_77
                                                                                                                                                    & _sels_T_2[78]
                                                                                                                                                      ? 128'h40000000000000000000
                                                                                                                                                      : _GEN_78
                                                                                                                                                        & _sels_T_2[79]
                                                                                                                                                          ? 128'h80000000000000000000
                                                                                                                                                          : _GEN_79
                                                                                                                                                            & _sels_T_2[80]
                                                                                                                                                              ? 128'h100000000000000000000
                                                                                                                                                              : _GEN_80
                                                                                                                                                                & _sels_T_2[81]
                                                                                                                                                                  ? 128'h200000000000000000000
                                                                                                                                                                  : _GEN_81
                                                                                                                                                                    & _sels_T_2[82]
                                                                                                                                                                      ? 128'h400000000000000000000
                                                                                                                                                                      : _GEN_82
                                                                                                                                                                        & _sels_T_2[83]
                                                                                                                                                                          ? 128'h800000000000000000000
                                                                                                                                                                          : _GEN_83
                                                                                                                                                                            & _sels_T_2[84]
                                                                                                                                                                              ? 128'h1000000000000000000000
                                                                                                                                                                              : _GEN_84
                                                                                                                                                                                & _sels_T_2[85]
                                                                                                                                                                                  ? 128'h2000000000000000000000
                                                                                                                                                                                  : _GEN_85
                                                                                                                                                                                    & _sels_T_2[86]
                                                                                                                                                                                      ? 128'h4000000000000000000000
                                                                                                                                                                                      : _GEN_86
                                                                                                                                                                                        & _sels_T_2[87]
                                                                                                                                                                                          ? 128'h8000000000000000000000
                                                                                                                                                                                          : _GEN_87
                                                                                                                                                                                            & _sels_T_2[88]
                                                                                                                                                                                              ? 128'h10000000000000000000000
                                                                                                                                                                                              : _GEN_88
                                                                                                                                                                                                & _sels_T_2[89]
                                                                                                                                                                                                  ? 128'h20000000000000000000000
                                                                                                                                                                                                  : _GEN_89
                                                                                                                                                                                                    & _sels_T_2[90]
                                                                                                                                                                                                      ? 128'h40000000000000000000000
                                                                                                                                                                                                      : _GEN_90
                                                                                                                                                                                                        & _sels_T_2[91]
                                                                                                                                                                                                          ? 128'h80000000000000000000000
                                                                                                                                                                                                          : _GEN_91
                                                                                                                                                                                                            & _sels_T_2[92]
                                                                                                                                                                                                              ? 128'h100000000000000000000000
                                                                                                                                                                                                              : _GEN_92
                                                                                                                                                                                                                & _sels_T_2[93]
                                                                                                                                                                                                                  ? 128'h200000000000000000000000
                                                                                                                                                                                                                  : _GEN_93
                                                                                                                                                                                                                    & _sels_T_2[94]
                                                                                                                                                                                                                      ? 128'h400000000000000000000000
                                                                                                                                                                                                                      : _GEN_94
                                                                                                                                                                                                                        & _sels_T_2[95]
                                                                                                                                                                                                                          ? 128'h800000000000000000000000
                                                                                                                                                                                                                          : _GEN_95
                                                                                                                                                                                                                            & _sels_T_2[96]
                                                                                                                                                                                                                              ? 128'h1000000000000000000000000
                                                                                                                                                                                                                              : _GEN_96
                                                                                                                                                                                                                                & _sels_T_2[97]
                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000
                                                                                                                                                                                                                                  : _GEN_97
                                                                                                                                                                                                                                    & _sels_T_2[98]
                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000
                                                                                                                                                                                                                                      : _GEN_98
                                                                                                                                                                                                                                        & _sels_T_2[99]
                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000
                                                                                                                                                                                                                                          : _GEN_99
                                                                                                                                                                                                                                            & _sels_T_2[100]
                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000
                                                                                                                                                                                                                                              : _GEN_100
                                                                                                                                                                                                                                                & _sels_T_2[101]
                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000
                                                                                                                                                                                                                                                  : _GEN_101
                                                                                                                                                                                                                                                    & _sels_T_2[102]
                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000
                                                                                                                                                                                                                                                      : _GEN_102
                                                                                                                                                                                                                                                        & _sels_T_2[103]
                                                                                                                                                                                                                                                          ? 128'h80000000000000000000000000
                                                                                                                                                                                                                                                          : _GEN_103
                                                                                                                                                                                                                                                            & _sels_T_2[104]
                                                                                                                                                                                                                                                              ? 128'h100000000000000000000000000
                                                                                                                                                                                                                                                              : _GEN_104
                                                                                                                                                                                                                                                                & _sels_T_2[105]
                                                                                                                                                                                                                                                                  ? 128'h200000000000000000000000000
                                                                                                                                                                                                                                                                  : _GEN_105
                                                                                                                                                                                                                                                                    & _sels_T_2[106]
                                                                                                                                                                                                                                                                      ? 128'h400000000000000000000000000
                                                                                                                                                                                                                                                                      : _GEN_106
                                                                                                                                                                                                                                                                        & _sels_T_2[107]
                                                                                                                                                                                                                                                                          ? 128'h800000000000000000000000000
                                                                                                                                                                                                                                                                          : _GEN_107
                                                                                                                                                                                                                                                                            & _sels_T_2[108]
                                                                                                                                                                                                                                                                              ? 128'h1000000000000000000000000000
                                                                                                                                                                                                                                                                              : _GEN_108
                                                                                                                                                                                                                                                                                & _sels_T_2[109]
                                                                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000000
                                                                                                                                                                                                                                                                                  : _GEN_109
                                                                                                                                                                                                                                                                                    & _sels_T_2[110]
                                                                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000000
                                                                                                                                                                                                                                                                                      : _GEN_110
                                                                                                                                                                                                                                                                                        & _sels_T_2[111]
                                                                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000000
                                                                                                                                                                                                                                                                                          : _GEN_111
                                                                                                                                                                                                                                                                                            & _sels_T_2[112]
                                                                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000000
                                                                                                                                                                                                                                                                                              : _GEN_112
                                                                                                                                                                                                                                                                                                & _sels_T_2[113]
                                                                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000000
                                                                                                                                                                                                                                                                                                  : _GEN_113
                                                                                                                                                                                                                                                                                                    & _sels_T_2[114]
                                                                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000000
                                                                                                                                                                                                                                                                                                      : _GEN_114
                                                                                                                                                                                                                                                                                                        & _sels_T_2[115]
                                                                                                                                                                                                                                                                                                          ? 128'h80000000000000000000000000000
                                                                                                                                                                                                                                                                                                          : _GEN_115
                                                                                                                                                                                                                                                                                                            & _sels_T_2[116]
                                                                                                                                                                                                                                                                                                              ? 128'h100000000000000000000000000000
                                                                                                                                                                                                                                                                                                              : _GEN_116
                                                                                                                                                                                                                                                                                                                & _sels_T_2[117]
                                                                                                                                                                                                                                                                                                                  ? 128'h200000000000000000000000000000
                                                                                                                                                                                                                                                                                                                  : _GEN_117
                                                                                                                                                                                                                                                                                                                    & _sels_T_2[118]
                                                                                                                                                                                                                                                                                                                      ? 128'h400000000000000000000000000000
                                                                                                                                                                                                                                                                                                                      : _GEN_118
                                                                                                                                                                                                                                                                                                                        & _sels_T_2[119]
                                                                                                                                                                                                                                                                                                                          ? 128'h800000000000000000000000000000
                                                                                                                                                                                                                                                                                                                          : _GEN_119
                                                                                                                                                                                                                                                                                                                            & _sels_T_2[120]
                                                                                                                                                                                                                                                                                                                              ? 128'h1000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                              : _GEN_120
                                                                                                                                                                                                                                                                                                                                & _sels_T_2[121]
                                                                                                                                                                                                                                                                                                                                  ? 128'h2000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                  : _GEN_121
                                                                                                                                                                                                                                                                                                                                    & _sels_T_2[122]
                                                                                                                                                                                                                                                                                                                                      ? 128'h4000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                      : _GEN_122
                                                                                                                                                                                                                                                                                                                                        & _sels_T_2[123]
                                                                                                                                                                                                                                                                                                                                          ? 128'h8000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                          : _GEN_123
                                                                                                                                                                                                                                                                                                                                            & _sels_T_2[124]
                                                                                                                                                                                                                                                                                                                                              ? 128'h10000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                              : _GEN_124
                                                                                                                                                                                                                                                                                                                                                & _sels_T_2[125]
                                                                                                                                                                                                                                                                                                                                                  ? 128'h20000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : _GEN_125
                                                                                                                                                                                                                                                                                                                                                    & _sels_T_2[126]
                                                                                                                                                                                                                                                                                                                                                      ? 128'h40000000000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : {_GEN_126
                                                                                                                                                                                                                                                                                                                                                           & _sels_T_2[127],
                                                                                                                                                                                                                                                                                                                                                         127'h0};	// Mux.scala:47:69, OneHot.scala:85:71, util.scala:410:{19,21}
  wire [127:0]       sels_2 =
    _GEN & _sels_T_2[0]
      ? 128'h1
      : _GEN_0 & _sels_T_2[1]
          ? 128'h2
          : _GEN_1 & _sels_T_2[2]
              ? 128'h4
              : _GEN_2 & _sels_T_2[3]
                  ? 128'h8
                  : _GEN_3 & _sels_T_2[4]
                      ? 128'h10
                      : _GEN_4 & _sels_T_2[5]
                          ? 128'h20
                          : _GEN_5 & _sels_T_2[6]
                              ? 128'h40
                              : _GEN_6 & _sels_T_2[7]
                                  ? 128'h80
                                  : _GEN_7 & _sels_T_2[8]
                                      ? 128'h100
                                      : _GEN_8 & _sels_T_2[9]
                                          ? 128'h200
                                          : _GEN_9 & _sels_T_2[10]
                                              ? 128'h400
                                              : _GEN_10 & _sels_T_2[11]
                                                  ? 128'h800
                                                  : _GEN_11 & _sels_T_2[12]
                                                      ? 128'h1000
                                                      : _GEN_12 & _sels_T_2[13]
                                                          ? 128'h2000
                                                          : _GEN_13 & _sels_T_2[14]
                                                              ? 128'h4000
                                                              : _GEN_14 & _sels_T_2[15]
                                                                  ? 128'h8000
                                                                  : _GEN_15
                                                                    & _sels_T_2[16]
                                                                      ? 128'h10000
                                                                      : _GEN_16
                                                                        & _sels_T_2[17]
                                                                          ? 128'h20000
                                                                          : _GEN_17
                                                                            & _sels_T_2[18]
                                                                              ? 128'h40000
                                                                              : _GEN_18
                                                                                & _sels_T_2[19]
                                                                                  ? 128'h80000
                                                                                  : _GEN_19
                                                                                    & _sels_T_2[20]
                                                                                      ? 128'h100000
                                                                                      : _GEN_20
                                                                                        & _sels_T_2[21]
                                                                                          ? 128'h200000
                                                                                          : _GEN_21
                                                                                            & _sels_T_2[22]
                                                                                              ? 128'h400000
                                                                                              : _GEN_22
                                                                                                & _sels_T_2[23]
                                                                                                  ? 128'h800000
                                                                                                  : _GEN_23
                                                                                                    & _sels_T_2[24]
                                                                                                      ? 128'h1000000
                                                                                                      : _GEN_24
                                                                                                        & _sels_T_2[25]
                                                                                                          ? 128'h2000000
                                                                                                          : _GEN_25
                                                                                                            & _sels_T_2[26]
                                                                                                              ? 128'h4000000
                                                                                                              : _GEN_26
                                                                                                                & _sels_T_2[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : _GEN_27
                                                                                                                    & _sels_T_2[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : _GEN_28
                                                                                                                        & _sels_T_2[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : _GEN_29
                                                                                                                            & _sels_T_2[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : _GEN_30
                                                                                                                                & _sels_T_2[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : _GEN_31
                                                                                                                                    & _sels_T_2[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : _GEN_32
                                                                                                                                        & _sels_T_2[33]
                                                                                                                                          ? 128'h200000000
                                                                                                                                          : _GEN_33
                                                                                                                                            & _sels_T_2[34]
                                                                                                                                              ? 128'h400000000
                                                                                                                                              : _GEN_34
                                                                                                                                                & _sels_T_2[35]
                                                                                                                                                  ? 128'h800000000
                                                                                                                                                  : _GEN_35
                                                                                                                                                    & _sels_T_2[36]
                                                                                                                                                      ? 128'h1000000000
                                                                                                                                                      : _GEN_36
                                                                                                                                                        & _sels_T_2[37]
                                                                                                                                                          ? 128'h2000000000
                                                                                                                                                          : _GEN_37
                                                                                                                                                            & _sels_T_2[38]
                                                                                                                                                              ? 128'h4000000000
                                                                                                                                                              : _GEN_38
                                                                                                                                                                & _sels_T_2[39]
                                                                                                                                                                  ? 128'h8000000000
                                                                                                                                                                  : _GEN_39
                                                                                                                                                                    & _sels_T_2[40]
                                                                                                                                                                      ? 128'h10000000000
                                                                                                                                                                      : _GEN_40
                                                                                                                                                                        & _sels_T_2[41]
                                                                                                                                                                          ? 128'h20000000000
                                                                                                                                                                          : _sels_sels_2_T_213;	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:45, util.scala:410:{19,21}
  wire [127:0]       _sels_T_4 = ~sels_2;	// Mux.scala:47:69, util.scala:410:21
  wire [127:0]       _sels_sels_3_T_192 =
    _GEN_62 & _sels_T_2[63] & _sels_T_4[63]
      ? 128'h8000000000000000
      : _GEN_63 & _sels_T_2[64] & _sels_T_4[64]
          ? 128'h10000000000000000
          : _GEN_64 & _sels_T_2[65] & _sels_T_4[65]
              ? 128'h20000000000000000
              : _GEN_65 & _sels_T_2[66] & _sels_T_4[66]
                  ? 128'h40000000000000000
                  : _GEN_66 & _sels_T_2[67] & _sels_T_4[67]
                      ? 128'h80000000000000000
                      : _GEN_67 & _sels_T_2[68] & _sels_T_4[68]
                          ? 128'h100000000000000000
                          : _GEN_68 & _sels_T_2[69] & _sels_T_4[69]
                              ? 128'h200000000000000000
                              : _GEN_69 & _sels_T_2[70] & _sels_T_4[70]
                                  ? 128'h400000000000000000
                                  : _GEN_70 & _sels_T_2[71] & _sels_T_4[71]
                                      ? 128'h800000000000000000
                                      : _GEN_71 & _sels_T_2[72] & _sels_T_4[72]
                                          ? 128'h1000000000000000000
                                          : _GEN_72 & _sels_T_2[73] & _sels_T_4[73]
                                              ? 128'h2000000000000000000
                                              : _GEN_73 & _sels_T_2[74] & _sels_T_4[74]
                                                  ? 128'h4000000000000000000
                                                  : _GEN_74 & _sels_T_2[75]
                                                    & _sels_T_4[75]
                                                      ? 128'h8000000000000000000
                                                      : _GEN_75 & _sels_T_2[76]
                                                        & _sels_T_4[76]
                                                          ? 128'h10000000000000000000
                                                          : _GEN_76 & _sels_T_2[77]
                                                            & _sels_T_4[77]
                                                              ? 128'h20000000000000000000
                                                              : _GEN_77 & _sels_T_2[78]
                                                                & _sels_T_4[78]
                                                                  ? 128'h40000000000000000000
                                                                  : _GEN_78
                                                                    & _sels_T_2[79]
                                                                    & _sels_T_4[79]
                                                                      ? 128'h80000000000000000000
                                                                      : _GEN_79
                                                                        & _sels_T_2[80]
                                                                        & _sels_T_4[80]
                                                                          ? 128'h100000000000000000000
                                                                          : _GEN_80
                                                                            & _sels_T_2[81]
                                                                            & _sels_T_4[81]
                                                                              ? 128'h200000000000000000000
                                                                              : _GEN_81
                                                                                & _sels_T_2[82]
                                                                                & _sels_T_4[82]
                                                                                  ? 128'h400000000000000000000
                                                                                  : _GEN_82
                                                                                    & _sels_T_2[83]
                                                                                    & _sels_T_4[83]
                                                                                      ? 128'h800000000000000000000
                                                                                      : _GEN_83
                                                                                        & _sels_T_2[84]
                                                                                        & _sels_T_4[84]
                                                                                          ? 128'h1000000000000000000000
                                                                                          : _GEN_84
                                                                                            & _sels_T_2[85]
                                                                                            & _sels_T_4[85]
                                                                                              ? 128'h2000000000000000000000
                                                                                              : _GEN_85
                                                                                                & _sels_T_2[86]
                                                                                                & _sels_T_4[86]
                                                                                                  ? 128'h4000000000000000000000
                                                                                                  : _GEN_86
                                                                                                    & _sels_T_2[87]
                                                                                                    & _sels_T_4[87]
                                                                                                      ? 128'h8000000000000000000000
                                                                                                      : _GEN_87
                                                                                                        & _sels_T_2[88]
                                                                                                        & _sels_T_4[88]
                                                                                                          ? 128'h10000000000000000000000
                                                                                                          : _GEN_88
                                                                                                            & _sels_T_2[89]
                                                                                                            & _sels_T_4[89]
                                                                                                              ? 128'h20000000000000000000000
                                                                                                              : _GEN_89
                                                                                                                & _sels_T_2[90]
                                                                                                                & _sels_T_4[90]
                                                                                                                  ? 128'h40000000000000000000000
                                                                                                                  : _GEN_90
                                                                                                                    & _sels_T_2[91]
                                                                                                                    & _sels_T_4[91]
                                                                                                                      ? 128'h80000000000000000000000
                                                                                                                      : _GEN_91
                                                                                                                        & _sels_T_2[92]
                                                                                                                        & _sels_T_4[92]
                                                                                                                          ? 128'h100000000000000000000000
                                                                                                                          : _GEN_92
                                                                                                                            & _sels_T_2[93]
                                                                                                                            & _sels_T_4[93]
                                                                                                                              ? 128'h200000000000000000000000
                                                                                                                              : _GEN_93
                                                                                                                                & _sels_T_2[94]
                                                                                                                                & _sels_T_4[94]
                                                                                                                                  ? 128'h400000000000000000000000
                                                                                                                                  : _GEN_94
                                                                                                                                    & _sels_T_2[95]
                                                                                                                                    & _sels_T_4[95]
                                                                                                                                      ? 128'h800000000000000000000000
                                                                                                                                      : _GEN_95
                                                                                                                                        & _sels_T_2[96]
                                                                                                                                        & _sels_T_4[96]
                                                                                                                                          ? 128'h1000000000000000000000000
                                                                                                                                          : _GEN_96
                                                                                                                                            & _sels_T_2[97]
                                                                                                                                            & _sels_T_4[97]
                                                                                                                                              ? 128'h2000000000000000000000000
                                                                                                                                              : _GEN_97
                                                                                                                                                & _sels_T_2[98]
                                                                                                                                                & _sels_T_4[98]
                                                                                                                                                  ? 128'h4000000000000000000000000
                                                                                                                                                  : _GEN_98
                                                                                                                                                    & _sels_T_2[99]
                                                                                                                                                    & _sels_T_4[99]
                                                                                                                                                      ? 128'h8000000000000000000000000
                                                                                                                                                      : _GEN_99
                                                                                                                                                        & _sels_T_2[100]
                                                                                                                                                        & _sels_T_4[100]
                                                                                                                                                          ? 128'h10000000000000000000000000
                                                                                                                                                          : _GEN_100
                                                                                                                                                            & _sels_T_2[101]
                                                                                                                                                            & _sels_T_4[101]
                                                                                                                                                              ? 128'h20000000000000000000000000
                                                                                                                                                              : _GEN_101
                                                                                                                                                                & _sels_T_2[102]
                                                                                                                                                                & _sels_T_4[102]
                                                                                                                                                                  ? 128'h40000000000000000000000000
                                                                                                                                                                  : _GEN_102
                                                                                                                                                                    & _sels_T_2[103]
                                                                                                                                                                    & _sels_T_4[103]
                                                                                                                                                                      ? 128'h80000000000000000000000000
                                                                                                                                                                      : _GEN_103
                                                                                                                                                                        & _sels_T_2[104]
                                                                                                                                                                        & _sels_T_4[104]
                                                                                                                                                                          ? 128'h100000000000000000000000000
                                                                                                                                                                          : _GEN_104
                                                                                                                                                                            & _sels_T_2[105]
                                                                                                                                                                            & _sels_T_4[105]
                                                                                                                                                                              ? 128'h200000000000000000000000000
                                                                                                                                                                              : _GEN_105
                                                                                                                                                                                & _sels_T_2[106]
                                                                                                                                                                                & _sels_T_4[106]
                                                                                                                                                                                  ? 128'h400000000000000000000000000
                                                                                                                                                                                  : _GEN_106
                                                                                                                                                                                    & _sels_T_2[107]
                                                                                                                                                                                    & _sels_T_4[107]
                                                                                                                                                                                      ? 128'h800000000000000000000000000
                                                                                                                                                                                      : _GEN_107
                                                                                                                                                                                        & _sels_T_2[108]
                                                                                                                                                                                        & _sels_T_4[108]
                                                                                                                                                                                          ? 128'h1000000000000000000000000000
                                                                                                                                                                                          : _GEN_108
                                                                                                                                                                                            & _sels_T_2[109]
                                                                                                                                                                                            & _sels_T_4[109]
                                                                                                                                                                                              ? 128'h2000000000000000000000000000
                                                                                                                                                                                              : _GEN_109
                                                                                                                                                                                                & _sels_T_2[110]
                                                                                                                                                                                                & _sels_T_4[110]
                                                                                                                                                                                                  ? 128'h4000000000000000000000000000
                                                                                                                                                                                                  : _GEN_110
                                                                                                                                                                                                    & _sels_T_2[111]
                                                                                                                                                                                                    & _sels_T_4[111]
                                                                                                                                                                                                      ? 128'h8000000000000000000000000000
                                                                                                                                                                                                      : _GEN_111
                                                                                                                                                                                                        & _sels_T_2[112]
                                                                                                                                                                                                        & _sels_T_4[112]
                                                                                                                                                                                                          ? 128'h10000000000000000000000000000
                                                                                                                                                                                                          : _GEN_112
                                                                                                                                                                                                            & _sels_T_2[113]
                                                                                                                                                                                                            & _sels_T_4[113]
                                                                                                                                                                                                              ? 128'h20000000000000000000000000000
                                                                                                                                                                                                              : _GEN_113
                                                                                                                                                                                                                & _sels_T_2[114]
                                                                                                                                                                                                                & _sels_T_4[114]
                                                                                                                                                                                                                  ? 128'h40000000000000000000000000000
                                                                                                                                                                                                                  : _GEN_114
                                                                                                                                                                                                                    & _sels_T_2[115]
                                                                                                                                                                                                                    & _sels_T_4[115]
                                                                                                                                                                                                                      ? 128'h80000000000000000000000000000
                                                                                                                                                                                                                      : _GEN_115
                                                                                                                                                                                                                        & _sels_T_2[116]
                                                                                                                                                                                                                        & _sels_T_4[116]
                                                                                                                                                                                                                          ? 128'h100000000000000000000000000000
                                                                                                                                                                                                                          : _GEN_116
                                                                                                                                                                                                                            & _sels_T_2[117]
                                                                                                                                                                                                                            & _sels_T_4[117]
                                                                                                                                                                                                                              ? 128'h200000000000000000000000000000
                                                                                                                                                                                                                              : _GEN_117
                                                                                                                                                                                                                                & _sels_T_2[118]
                                                                                                                                                                                                                                & _sels_T_4[118]
                                                                                                                                                                                                                                  ? 128'h400000000000000000000000000000
                                                                                                                                                                                                                                  : _GEN_118
                                                                                                                                                                                                                                    & _sels_T_2[119]
                                                                                                                                                                                                                                    & _sels_T_4[119]
                                                                                                                                                                                                                                      ? 128'h800000000000000000000000000000
                                                                                                                                                                                                                                      : _GEN_119
                                                                                                                                                                                                                                        & _sels_T_2[120]
                                                                                                                                                                                                                                        & _sels_T_4[120]
                                                                                                                                                                                                                                          ? 128'h1000000000000000000000000000000
                                                                                                                                                                                                                                          : _GEN_120
                                                                                                                                                                                                                                            & _sels_T_2[121]
                                                                                                                                                                                                                                            & _sels_T_4[121]
                                                                                                                                                                                                                                              ? 128'h2000000000000000000000000000000
                                                                                                                                                                                                                                              : _GEN_121
                                                                                                                                                                                                                                                & _sels_T_2[122]
                                                                                                                                                                                                                                                & _sels_T_4[122]
                                                                                                                                                                                                                                                  ? 128'h4000000000000000000000000000000
                                                                                                                                                                                                                                                  : _GEN_122
                                                                                                                                                                                                                                                    & _sels_T_2[123]
                                                                                                                                                                                                                                                    & _sels_T_4[123]
                                                                                                                                                                                                                                                      ? 128'h8000000000000000000000000000000
                                                                                                                                                                                                                                                      : _GEN_123
                                                                                                                                                                                                                                                        & _sels_T_2[124]
                                                                                                                                                                                                                                                        & _sels_T_4[124]
                                                                                                                                                                                                                                                          ? 128'h10000000000000000000000000000000
                                                                                                                                                                                                                                                          : _GEN_124
                                                                                                                                                                                                                                                            & _sels_T_2[125]
                                                                                                                                                                                                                                                            & _sels_T_4[125]
                                                                                                                                                                                                                                                              ? 128'h20000000000000000000000000000000
                                                                                                                                                                                                                                                              : _GEN_125
                                                                                                                                                                                                                                                                & _sels_T_2[126]
                                                                                                                                                                                                                                                                & _sels_T_4[126]
                                                                                                                                                                                                                                                                  ? 128'h40000000000000000000000000000000
                                                                                                                                                                                                                                                                  : {_GEN_126
                                                                                                                                                                                                                                                                       & _sels_T_2[127]
                                                                                                                                                                                                                                                                       & _sels_T_4[127],
                                                                                                                                                                                                                                                                     127'h0};	// Mux.scala:47:69, OneHot.scala:85:71, util.scala:410:{19,21}
  wire [127:0]       sels_3 =
    _GEN & _sels_T_2[0] & _sels_T_4[0]
      ? 128'h1
      : _GEN_0 & _sels_T_2[1] & _sels_T_4[1]
          ? 128'h2
          : _GEN_1 & _sels_T_2[2] & _sels_T_4[2]
              ? 128'h4
              : _GEN_2 & _sels_T_2[3] & _sels_T_4[3]
                  ? 128'h8
                  : _GEN_3 & _sels_T_2[4] & _sels_T_4[4]
                      ? 128'h10
                      : _GEN_4 & _sels_T_2[5] & _sels_T_4[5]
                          ? 128'h20
                          : _GEN_5 & _sels_T_2[6] & _sels_T_4[6]
                              ? 128'h40
                              : _GEN_6 & _sels_T_2[7] & _sels_T_4[7]
                                  ? 128'h80
                                  : _GEN_7 & _sels_T_2[8] & _sels_T_4[8]
                                      ? 128'h100
                                      : _GEN_8 & _sels_T_2[9] & _sels_T_4[9]
                                          ? 128'h200
                                          : _GEN_9 & _sels_T_2[10] & _sels_T_4[10]
                                              ? 128'h400
                                              : _GEN_10 & _sels_T_2[11] & _sels_T_4[11]
                                                  ? 128'h800
                                                  : _GEN_11 & _sels_T_2[12]
                                                    & _sels_T_4[12]
                                                      ? 128'h1000
                                                      : _GEN_12 & _sels_T_2[13]
                                                        & _sels_T_4[13]
                                                          ? 128'h2000
                                                          : _GEN_13 & _sels_T_2[14]
                                                            & _sels_T_4[14]
                                                              ? 128'h4000
                                                              : _GEN_14 & _sels_T_2[15]
                                                                & _sels_T_4[15]
                                                                  ? 128'h8000
                                                                  : _GEN_15
                                                                    & _sels_T_2[16]
                                                                    & _sels_T_4[16]
                                                                      ? 128'h10000
                                                                      : _GEN_16
                                                                        & _sels_T_2[17]
                                                                        & _sels_T_4[17]
                                                                          ? 128'h20000
                                                                          : _GEN_17
                                                                            & _sels_T_2[18]
                                                                            & _sels_T_4[18]
                                                                              ? 128'h40000
                                                                              : _GEN_18
                                                                                & _sels_T_2[19]
                                                                                & _sels_T_4[19]
                                                                                  ? 128'h80000
                                                                                  : _GEN_19
                                                                                    & _sels_T_2[20]
                                                                                    & _sels_T_4[20]
                                                                                      ? 128'h100000
                                                                                      : _GEN_20
                                                                                        & _sels_T_2[21]
                                                                                        & _sels_T_4[21]
                                                                                          ? 128'h200000
                                                                                          : _GEN_21
                                                                                            & _sels_T_2[22]
                                                                                            & _sels_T_4[22]
                                                                                              ? 128'h400000
                                                                                              : _GEN_22
                                                                                                & _sels_T_2[23]
                                                                                                & _sels_T_4[23]
                                                                                                  ? 128'h800000
                                                                                                  : _GEN_23
                                                                                                    & _sels_T_2[24]
                                                                                                    & _sels_T_4[24]
                                                                                                      ? 128'h1000000
                                                                                                      : _GEN_24
                                                                                                        & _sels_T_2[25]
                                                                                                        & _sels_T_4[25]
                                                                                                          ? 128'h2000000
                                                                                                          : _GEN_25
                                                                                                            & _sels_T_2[26]
                                                                                                            & _sels_T_4[26]
                                                                                                              ? 128'h4000000
                                                                                                              : _GEN_26
                                                                                                                & _sels_T_2[27]
                                                                                                                & _sels_T_4[27]
                                                                                                                  ? 128'h8000000
                                                                                                                  : _GEN_27
                                                                                                                    & _sels_T_2[28]
                                                                                                                    & _sels_T_4[28]
                                                                                                                      ? 128'h10000000
                                                                                                                      : _GEN_28
                                                                                                                        & _sels_T_2[29]
                                                                                                                        & _sels_T_4[29]
                                                                                                                          ? 128'h20000000
                                                                                                                          : _GEN_29
                                                                                                                            & _sels_T_2[30]
                                                                                                                            & _sels_T_4[30]
                                                                                                                              ? 128'h40000000
                                                                                                                              : _GEN_30
                                                                                                                                & _sels_T_2[31]
                                                                                                                                & _sels_T_4[31]
                                                                                                                                  ? 128'h80000000
                                                                                                                                  : _GEN_31
                                                                                                                                    & _sels_T_2[32]
                                                                                                                                    & _sels_T_4[32]
                                                                                                                                      ? 128'h100000000
                                                                                                                                      : _GEN_32
                                                                                                                                        & _sels_T_2[33]
                                                                                                                                        & _sels_T_4[33]
                                                                                                                                          ? 128'h200000000
                                                                                                                                          : _GEN_33
                                                                                                                                            & _sels_T_2[34]
                                                                                                                                            & _sels_T_4[34]
                                                                                                                                              ? 128'h400000000
                                                                                                                                              : _GEN_34
                                                                                                                                                & _sels_T_2[35]
                                                                                                                                                & _sels_T_4[35]
                                                                                                                                                  ? 128'h800000000
                                                                                                                                                  : _GEN_35
                                                                                                                                                    & _sels_T_2[36]
                                                                                                                                                    & _sels_T_4[36]
                                                                                                                                                      ? 128'h1000000000
                                                                                                                                                      : _GEN_36
                                                                                                                                                        & _sels_T_2[37]
                                                                                                                                                        & _sels_T_4[37]
                                                                                                                                                          ? 128'h2000000000
                                                                                                                                                          : _GEN_37
                                                                                                                                                            & _sels_T_2[38]
                                                                                                                                                            & _sels_T_4[38]
                                                                                                                                                              ? 128'h4000000000
                                                                                                                                                              : _GEN_38
                                                                                                                                                                & _sels_T_2[39]
                                                                                                                                                                & _sels_T_4[39]
                                                                                                                                                                  ? 128'h8000000000
                                                                                                                                                                  : _GEN_39
                                                                                                                                                                    & _sels_T_2[40]
                                                                                                                                                                    & _sels_T_4[40]
                                                                                                                                                                      ? 128'h10000000000
                                                                                                                                                                      : _GEN_40
                                                                                                                                                                        & _sels_T_2[41]
                                                                                                                                                                        & _sels_T_4[41]
                                                                                                                                                                          ? 128'h20000000000
                                                                                                                                                                          : _GEN_41
                                                                                                                                                                            & _sels_T_2[42]
                                                                                                                                                                            & _sels_T_4[42]
                                                                                                                                                                              ? 128'h40000000000
                                                                                                                                                                              : _GEN_42
                                                                                                                                                                                & _sels_T_2[43]
                                                                                                                                                                                & _sels_T_4[43]
                                                                                                                                                                                  ? 128'h80000000000
                                                                                                                                                                                  : _GEN_43
                                                                                                                                                                                    & _sels_T_2[44]
                                                                                                                                                                                    & _sels_T_4[44]
                                                                                                                                                                                      ? 128'h100000000000
                                                                                                                                                                                      : _GEN_44
                                                                                                                                                                                        & _sels_T_2[45]
                                                                                                                                                                                        & _sels_T_4[45]
                                                                                                                                                                                          ? 128'h200000000000
                                                                                                                                                                                          : _GEN_45
                                                                                                                                                                                            & _sels_T_2[46]
                                                                                                                                                                                            & _sels_T_4[46]
                                                                                                                                                                                              ? 128'h400000000000
                                                                                                                                                                                              : _GEN_46
                                                                                                                                                                                                & _sels_T_2[47]
                                                                                                                                                                                                & _sels_T_4[47]
                                                                                                                                                                                                  ? 128'h800000000000
                                                                                                                                                                                                  : _GEN_47
                                                                                                                                                                                                    & _sels_T_2[48]
                                                                                                                                                                                                    & _sels_T_4[48]
                                                                                                                                                                                                      ? 128'h1000000000000
                                                                                                                                                                                                      : _GEN_48
                                                                                                                                                                                                        & _sels_T_2[49]
                                                                                                                                                                                                        & _sels_T_4[49]
                                                                                                                                                                                                          ? 128'h2000000000000
                                                                                                                                                                                                          : _GEN_49
                                                                                                                                                                                                            & _sels_T_2[50]
                                                                                                                                                                                                            & _sels_T_4[50]
                                                                                                                                                                                                              ? 128'h4000000000000
                                                                                                                                                                                                              : _GEN_50
                                                                                                                                                                                                                & _sels_T_2[51]
                                                                                                                                                                                                                & _sels_T_4[51]
                                                                                                                                                                                                                  ? 128'h8000000000000
                                                                                                                                                                                                                  : _GEN_51
                                                                                                                                                                                                                    & _sels_T_2[52]
                                                                                                                                                                                                                    & _sels_T_4[52]
                                                                                                                                                                                                                      ? 128'h10000000000000
                                                                                                                                                                                                                      : _GEN_52
                                                                                                                                                                                                                        & _sels_T_2[53]
                                                                                                                                                                                                                        & _sels_T_4[53]
                                                                                                                                                                                                                          ? 128'h20000000000000
                                                                                                                                                                                                                          : _GEN_53
                                                                                                                                                                                                                            & _sels_T_2[54]
                                                                                                                                                                                                                            & _sels_T_4[54]
                                                                                                                                                                                                                              ? 128'h40000000000000
                                                                                                                                                                                                                              : _GEN_54
                                                                                                                                                                                                                                & _sels_T_2[55]
                                                                                                                                                                                                                                & _sels_T_4[55]
                                                                                                                                                                                                                                  ? 128'h80000000000000
                                                                                                                                                                                                                                  : _GEN_55
                                                                                                                                                                                                                                    & _sels_T_2[56]
                                                                                                                                                                                                                                    & _sels_T_4[56]
                                                                                                                                                                                                                                      ? 128'h100000000000000
                                                                                                                                                                                                                                      : _GEN_56
                                                                                                                                                                                                                                        & _sels_T_2[57]
                                                                                                                                                                                                                                        & _sels_T_4[57]
                                                                                                                                                                                                                                          ? 128'h200000000000000
                                                                                                                                                                                                                                          : _GEN_57
                                                                                                                                                                                                                                            & _sels_T_2[58]
                                                                                                                                                                                                                                            & _sels_T_4[58]
                                                                                                                                                                                                                                              ? 128'h400000000000000
                                                                                                                                                                                                                                              : _GEN_58
                                                                                                                                                                                                                                                & _sels_T_2[59]
                                                                                                                                                                                                                                                & _sels_T_4[59]
                                                                                                                                                                                                                                                  ? 128'h800000000000000
                                                                                                                                                                                                                                                  : _GEN_59
                                                                                                                                                                                                                                                    & _sels_T_2[60]
                                                                                                                                                                                                                                                    & _sels_T_4[60]
                                                                                                                                                                                                                                                      ? 128'h1000000000000000
                                                                                                                                                                                                                                                      : _GEN_60
                                                                                                                                                                                                                                                        & _sels_T_2[61]
                                                                                                                                                                                                                                                        & _sels_T_4[61]
                                                                                                                                                                                                                                                          ? 128'h2000000000000000
                                                                                                                                                                                                                                                          : _GEN_61
                                                                                                                                                                                                                                                            & _sels_T_2[62]
                                                                                                                                                                                                                                                            & _sels_T_4[62]
                                                                                                                                                                                                                                                              ? 128'h4000000000000000
                                                                                                                                                                                                                                                              : _sels_sels_3_T_192;	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:45, util.scala:410:{19,21}
  wire [127:0]       allocs_0 = 128'h1 << r_sel;	// OneHot.scala:58:35, Reg.scala:15:16, rename-freelist.scala:50:45
  wire [127:0]       allocs_1 = 128'h1 << r_sel_1;	// OneHot.scala:58:35, Reg.scala:15:16, rename-freelist.scala:50:45
  wire [127:0]       allocs_2 = 128'h1 << r_sel_2;	// OneHot.scala:58:35, Reg.scala:15:16, rename-freelist.scala:50:45
  wire [127:0]       allocs_3 = 128'h1 << r_sel_3;	// OneHot.scala:58:35, Reg.scala:15:16, rename-freelist.scala:50:45
  wire [31:0][127:0] _GEN_127 =
    {{br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_19},
     {br_alloc_lists_18},
     {br_alloc_lists_17},
     {br_alloc_lists_16},
     {br_alloc_lists_15},
     {br_alloc_lists_14},
     {br_alloc_lists_13},
     {br_alloc_lists_12},
     {br_alloc_lists_11},
     {br_alloc_lists_10},
     {br_alloc_lists_9},
     {br_alloc_lists_8},
     {br_alloc_lists_7},
     {br_alloc_lists_6},
     {br_alloc_lists_5},
     {br_alloc_lists_4},
     {br_alloc_lists_3},
     {br_alloc_lists_2},
     {br_alloc_lists_1},
     {br_alloc_lists_0}};	// rename-freelist.scala:51:27, :63:63
  wire [127:0]       br_deallocs =
    _GEN_127[io_brupdate_b2_uop_br_tag] & {128{io_brupdate_b2_mispredict}};	// Bitwise.scala:72:12, rename-freelist.scala:63:63
  wire [127:0]       dealloc_mask =
    128'h1 << io_dealloc_pregs_0_bits & {128{io_dealloc_pregs_0_valid}} | 128'h1
    << io_dealloc_pregs_1_bits & {128{io_dealloc_pregs_1_valid}} | 128'h1
    << io_dealloc_pregs_2_bits & {128{io_dealloc_pregs_2_valid}} | 128'h1
    << io_dealloc_pregs_3_bits & {128{io_dealloc_pregs_3_valid}} | br_deallocs;	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:50:45, :63:63, :64:{79,110}
  reg                r_valid;	// rename-freelist.scala:81:26
  wire               sel_fire_0 = (~r_valid | io_reqs_0) & (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg                r_valid_1;	// rename-freelist.scala:81:26
  wire               sel_fire_1 = (~r_valid_1 | io_reqs_1) & (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg                r_valid_2;	// rename-freelist.scala:81:26
  wire               sel_fire_2 = (~r_valid_2 | io_reqs_2) & (|sels_2);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg                r_valid_3;	// rename-freelist.scala:81:26
  wire               sel_fire_3 = (~r_valid_3 | io_reqs_3) & (|sels_3);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  `ifndef SYNTHESIS	// rename-freelist.scala:94:10
    always @(posedge clock) begin	// rename-freelist.scala:94:10
      automatic logic [127:0] _io_debug_freelist_T_19;	// rename-freelist.scala:91:34
      _io_debug_freelist_T_19 =
        free_list | allocs_0 & {128{r_valid}} | allocs_1 & {128{r_valid_1}} | allocs_2
        & {128{r_valid_2}} | allocs_3 & {128{r_valid_3}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:50:26, :81:26, :91:{34,77}
      if (~((_io_debug_freelist_T_19 & dealloc_mask) == 128'h0 | reset)) begin	// Mux.scala:47:69, rename-freelist.scala:64:110, :91:34, :94:{10,31,47}
        if (`ASSERT_VERBOSE_COND_)	// rename-freelist.scala:94:10
          $error("Assertion failed: [freelist] Returning a free physical register.\n    at rename-freelist.scala:94 assert (!(io.debug.freelist & dealloc_mask).orR, \"[freelist] Returning a free physical register.\")\n");	// rename-freelist.scala:94:10
        if (`STOP_COND_)	// rename-freelist.scala:94:10
          $fatal;	// rename-freelist.scala:94:10
      end
      if (~(~io_debug_pipeline_empty
            | {1'h0,
               {1'h0,
                {1'h0,
                 {1'h0,
                  {1'h0,
                   {1'h0,
                    {1'h0, _io_debug_freelist_T_19[0]}
                      + {1'h0, _io_debug_freelist_T_19[1]}}
                     + {1'h0,
                        {1'h0, _io_debug_freelist_T_19[2]}
                          + {1'h0, _io_debug_freelist_T_19[3]}}}
                    + {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[4]}
                          + {1'h0, _io_debug_freelist_T_19[5]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[6]}
                              + {1'h0, _io_debug_freelist_T_19[7]}}}}
                   + {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[8]}
                          + {1'h0, _io_debug_freelist_T_19[9]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[10]}
                              + {1'h0, _io_debug_freelist_T_19[11]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[12]}
                              + {1'h0, _io_debug_freelist_T_19[13]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[14]}
                                  + {1'h0, _io_debug_freelist_T_19[15]}}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[16]}
                          + {1'h0, _io_debug_freelist_T_19[17]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[18]}
                              + {1'h0, _io_debug_freelist_T_19[19]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[20]}
                              + {1'h0, _io_debug_freelist_T_19[21]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[22]}
                                  + {1'h0, _io_debug_freelist_T_19[23]}}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[24]}
                              + {1'h0, _io_debug_freelist_T_19[25]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[26]}
                                  + {1'h0, _io_debug_freelist_T_19[27]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[28]}
                                  + {1'h0, _io_debug_freelist_T_19[29]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[30]}
                                      + {1'h0, _io_debug_freelist_T_19[31]}}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[32]}
                          + {1'h0, _io_debug_freelist_T_19[33]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[34]}
                              + {1'h0, _io_debug_freelist_T_19[35]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[36]}
                              + {1'h0, _io_debug_freelist_T_19[37]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[38]}
                                  + {1'h0, _io_debug_freelist_T_19[39]}}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[40]}
                              + {1'h0, _io_debug_freelist_T_19[41]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[42]}
                                  + {1'h0, _io_debug_freelist_T_19[43]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[44]}
                                  + {1'h0, _io_debug_freelist_T_19[45]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[46]}
                                      + {1'h0, _io_debug_freelist_T_19[47]}}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[48]}
                              + {1'h0, _io_debug_freelist_T_19[49]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[50]}
                                  + {1'h0, _io_debug_freelist_T_19[51]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[52]}
                                  + {1'h0, _io_debug_freelist_T_19[53]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[54]}
                                      + {1'h0, _io_debug_freelist_T_19[55]}}}}
                           + {1'h0,
                              {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[56]}
                                  + {1'h0, _io_debug_freelist_T_19[57]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[58]}
                                      + {1'h0, _io_debug_freelist_T_19[59]}}}
                                + {1'h0,
                                   {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[60]}
                                      + {1'h0, _io_debug_freelist_T_19[61]}}
                                     + {1'h0,
                                        {1'h0, _io_debug_freelist_T_19[62]}
                                          + {1'h0, _io_debug_freelist_T_19[63]}}}}}}}
            + {1'h0,
               {1'h0,
                {1'h0,
                 {1'h0,
                  {1'h0,
                   {1'h0,
                    {1'h0, _io_debug_freelist_T_19[64]}
                      + {1'h0, _io_debug_freelist_T_19[65]}}
                     + {1'h0,
                        {1'h0, _io_debug_freelist_T_19[66]}
                          + {1'h0, _io_debug_freelist_T_19[67]}}}
                    + {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[68]}
                          + {1'h0, _io_debug_freelist_T_19[69]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[70]}
                              + {1'h0, _io_debug_freelist_T_19[71]}}}}
                   + {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[72]}
                          + {1'h0, _io_debug_freelist_T_19[73]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[74]}
                              + {1'h0, _io_debug_freelist_T_19[75]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[76]}
                              + {1'h0, _io_debug_freelist_T_19[77]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[78]}
                                  + {1'h0, _io_debug_freelist_T_19[79]}}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[80]}
                          + {1'h0, _io_debug_freelist_T_19[81]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[82]}
                              + {1'h0, _io_debug_freelist_T_19[83]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[84]}
                              + {1'h0, _io_debug_freelist_T_19[85]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[86]}
                                  + {1'h0, _io_debug_freelist_T_19[87]}}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[88]}
                              + {1'h0, _io_debug_freelist_T_19[89]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[90]}
                                  + {1'h0, _io_debug_freelist_T_19[91]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[92]}
                                  + {1'h0, _io_debug_freelist_T_19[93]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[94]}
                                      + {1'h0, _io_debug_freelist_T_19[95]}}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0,
                       {1'h0,
                        {1'h0, _io_debug_freelist_T_19[96]}
                          + {1'h0, _io_debug_freelist_T_19[97]}}
                         + {1'h0,
                            {1'h0, _io_debug_freelist_T_19[98]}
                              + {1'h0, _io_debug_freelist_T_19[99]}}}
                        + {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[100]}
                              + {1'h0, _io_debug_freelist_T_19[101]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[102]}
                                  + {1'h0, _io_debug_freelist_T_19[103]}}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[104]}
                              + {1'h0, _io_debug_freelist_T_19[105]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[106]}
                                  + {1'h0, _io_debug_freelist_T_19[107]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[108]}
                                  + {1'h0, _io_debug_freelist_T_19[109]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[110]}
                                      + {1'h0, _io_debug_freelist_T_19[111]}}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0,
                           {1'h0,
                            {1'h0, _io_debug_freelist_T_19[112]}
                              + {1'h0, _io_debug_freelist_T_19[113]}}
                             + {1'h0,
                                {1'h0, _io_debug_freelist_T_19[114]}
                                  + {1'h0, _io_debug_freelist_T_19[115]}}}
                            + {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[116]}
                                  + {1'h0, _io_debug_freelist_T_19[117]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[118]}
                                      + {1'h0, _io_debug_freelist_T_19[119]}}}}
                           + {1'h0,
                              {1'h0,
                               {1'h0,
                                {1'h0, _io_debug_freelist_T_19[120]}
                                  + {1'h0, _io_debug_freelist_T_19[121]}}
                                 + {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[122]}
                                      + {1'h0, _io_debug_freelist_T_19[123]}}}
                                + {1'h0,
                                   {1'h0,
                                    {1'h0, _io_debug_freelist_T_19[124]}
                                      + {1'h0, _io_debug_freelist_T_19[125]}}
                                     + {1'h0,
                                        {1'h0, _io_debug_freelist_T_19[126]}
                                          + {1'h0,
                                             _io_debug_freelist_T_19[127]}}}}}}} > 8'h5F
            | reset)) begin	// Bitwise.scala:47:55, :49:65, rename-freelist.scala:51:27, :91:34, :95:{10,11,67}
        if (`ASSERT_VERBOSE_COND_)	// rename-freelist.scala:95:10
          $error("Assertion failed: [freelist] Leaking physical registers.\n    at rename-freelist.scala:95 assert (!io.debug.pipeline_empty || PopCount(io.debug.freelist) >= (numPregs - numLregs - 1).U,\n");	// rename-freelist.scala:95:10
        if (`STOP_COND_)	// rename-freelist.scala:95:10
          $fatal;	// rename-freelist.scala:95:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [127:0] alloc_masks_3;	// rename-freelist.scala:59:88
    automatic logic [127:0] alloc_masks_2;	// rename-freelist.scala:59:84
    automatic logic [127:0] alloc_masks_1;	// rename-freelist.scala:59:84
    automatic logic [127:0] alloc_masks_0;	// rename-freelist.scala:59:84
    automatic logic [3:0]   br_slots =
      {io_ren_br_tags_3_valid,
       io_ren_br_tags_2_valid,
       io_ren_br_tags_1_valid,
       io_ren_br_tags_0_valid};	// rename-freelist.scala:66:64
    automatic logic         _list_req_WIRE_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_1_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_1_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_1_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_2_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_2_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_2_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_3_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_3_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_3_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_4_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_4_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_4_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_5_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_5_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_5_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_6_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_6_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_6_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_7_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_7_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_7_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_8_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_8_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_8_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_9_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_9_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_9_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_10_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_10_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_10_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_11_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_11_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_11_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_12_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_12_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_12_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_13_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_13_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_13_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_14_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_14_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_14_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_15_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_15_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_15_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_16_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_16_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_16_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_17_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_17_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_17_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_18_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_18_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_18_2;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_19_0;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_19_1;	// rename-freelist.scala:69:72
    automatic logic         _list_req_WIRE_19_2;	// rename-freelist.scala:69:72
    alloc_masks_3 = allocs_3 & {128{io_reqs_3}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:88
    alloc_masks_2 = alloc_masks_3 | allocs_2 & {128{io_reqs_2}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    alloc_masks_1 = alloc_masks_2 | allocs_1 & {128{io_reqs_1}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    alloc_masks_0 = alloc_masks_1 | allocs_0 & {128{io_reqs_0}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    _list_req_WIRE_0 = io_ren_br_tags_0_bits == 5'h0;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_1 = io_ren_br_tags_1_bits == 5'h0;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_2 = io_ren_br_tags_2_bits == 5'h0;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_1_0 = io_ren_br_tags_0_bits == 5'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_1_1 = io_ren_br_tags_1_bits == 5'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_1_2 = io_ren_br_tags_2_bits == 5'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_2_0 = io_ren_br_tags_0_bits == 5'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_2_1 = io_ren_br_tags_1_bits == 5'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_2_2 = io_ren_br_tags_2_bits == 5'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_3_0 = io_ren_br_tags_0_bits == 5'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_3_1 = io_ren_br_tags_1_bits == 5'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_3_2 = io_ren_br_tags_2_bits == 5'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_4_0 = io_ren_br_tags_0_bits == 5'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_4_1 = io_ren_br_tags_1_bits == 5'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_4_2 = io_ren_br_tags_2_bits == 5'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_5_0 = io_ren_br_tags_0_bits == 5'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_5_1 = io_ren_br_tags_1_bits == 5'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_5_2 = io_ren_br_tags_2_bits == 5'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_6_0 = io_ren_br_tags_0_bits == 5'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_6_1 = io_ren_br_tags_1_bits == 5'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_6_2 = io_ren_br_tags_2_bits == 5'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_7_0 = io_ren_br_tags_0_bits == 5'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_7_1 = io_ren_br_tags_1_bits == 5'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_7_2 = io_ren_br_tags_2_bits == 5'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_8_0 = io_ren_br_tags_0_bits == 5'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_8_1 = io_ren_br_tags_1_bits == 5'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_8_2 = io_ren_br_tags_2_bits == 5'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_9_0 = io_ren_br_tags_0_bits == 5'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_9_1 = io_ren_br_tags_1_bits == 5'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_9_2 = io_ren_br_tags_2_bits == 5'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_10_0 = io_ren_br_tags_0_bits == 5'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_10_1 = io_ren_br_tags_1_bits == 5'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_10_2 = io_ren_br_tags_2_bits == 5'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_11_0 = io_ren_br_tags_0_bits == 5'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_11_1 = io_ren_br_tags_1_bits == 5'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_11_2 = io_ren_br_tags_2_bits == 5'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_12_0 = io_ren_br_tags_0_bits == 5'hC;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_12_1 = io_ren_br_tags_1_bits == 5'hC;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_12_2 = io_ren_br_tags_2_bits == 5'hC;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_13_0 = io_ren_br_tags_0_bits == 5'hD;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_13_1 = io_ren_br_tags_1_bits == 5'hD;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_13_2 = io_ren_br_tags_2_bits == 5'hD;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_14_0 = io_ren_br_tags_0_bits == 5'hE;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_14_1 = io_ren_br_tags_1_bits == 5'hE;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_14_2 = io_ren_br_tags_2_bits == 5'hE;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_15_0 = io_ren_br_tags_0_bits == 5'hF;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_15_1 = io_ren_br_tags_1_bits == 5'hF;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_15_2 = io_ren_br_tags_2_bits == 5'hF;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_16_0 = io_ren_br_tags_0_bits == 5'h10;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_16_1 = io_ren_br_tags_1_bits == 5'h10;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_16_2 = io_ren_br_tags_2_bits == 5'h10;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_17_0 = io_ren_br_tags_0_bits == 5'h11;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_17_1 = io_ren_br_tags_1_bits == 5'h11;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_17_2 = io_ren_br_tags_2_bits == 5'h11;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_18_0 = io_ren_br_tags_0_bits == 5'h12;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_18_1 = io_ren_br_tags_1_bits == 5'h12;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_18_2 = io_ren_br_tags_2_bits == 5'h12;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_19_0 = io_ren_br_tags_0_bits == 5'h13;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_19_1 = io_ren_br_tags_1_bits == 5'h13;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    _list_req_WIRE_19_2 = io_ren_br_tags_2_bits == 5'h13;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    if (reset) begin
      free_list <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE;	// rename-freelist.scala:50:{26,45}
      r_valid <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_1 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_2 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_3 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
    end
    else begin
      free_list <=
        (free_list
         & ~(sels_0 & {128{sel_fire_0}} | sels_1 & {128{sel_fire_1}} | sels_2
             & {128{sel_fire_2}} | sels_3 & {128{sel_fire_3}}) | dealloc_mask)
        & 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE;	// Bitwise.scala:72:12, Mux.scala:47:69, rename-freelist.scala:50:{26,45}, :62:{60,82}, :64:110, :76:{27,29,39,55}, :85:45
      r_valid <= r_valid & ~io_reqs_0 | (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_1 <= r_valid_1 & ~io_reqs_1 | (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_2 <= r_valid_2 & ~io_reqs_2 | (|sels_2);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_3 <= r_valid_3 & ~io_reqs_3 | (|sels_3);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
    end
    if (|({io_ren_br_tags_3_bits == 5'h0,
           _list_req_WIRE_2,
           _list_req_WIRE_1,
           _list_req_WIRE_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_0 <=
        (_list_req_WIRE_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_0 <= br_alloc_lists_0 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h1,
           _list_req_WIRE_1_2,
           _list_req_WIRE_1_1,
           _list_req_WIRE_1_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_1 <=
        (_list_req_WIRE_1_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_1_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_1_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_1 <= br_alloc_lists_1 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h2,
           _list_req_WIRE_2_2,
           _list_req_WIRE_2_1,
           _list_req_WIRE_2_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_2 <=
        (_list_req_WIRE_2_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_2_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_2_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_2 <= br_alloc_lists_2 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h3,
           _list_req_WIRE_3_2,
           _list_req_WIRE_3_1,
           _list_req_WIRE_3_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_3 <=
        (_list_req_WIRE_3_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_3_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_3_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_3 <= br_alloc_lists_3 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h4,
           _list_req_WIRE_4_2,
           _list_req_WIRE_4_1,
           _list_req_WIRE_4_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_4 <=
        (_list_req_WIRE_4_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_4_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_4_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_4 <= br_alloc_lists_4 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h5,
           _list_req_WIRE_5_2,
           _list_req_WIRE_5_1,
           _list_req_WIRE_5_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_5 <=
        (_list_req_WIRE_5_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_5_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_5_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_5 <= br_alloc_lists_5 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h6,
           _list_req_WIRE_6_2,
           _list_req_WIRE_6_1,
           _list_req_WIRE_6_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_6 <=
        (_list_req_WIRE_6_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_6_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_6_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_6 <= br_alloc_lists_6 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h7,
           _list_req_WIRE_7_2,
           _list_req_WIRE_7_1,
           _list_req_WIRE_7_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_7 <=
        (_list_req_WIRE_7_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_7_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_7_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_7 <= br_alloc_lists_7 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h8,
           _list_req_WIRE_8_2,
           _list_req_WIRE_8_1,
           _list_req_WIRE_8_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_8 <=
        (_list_req_WIRE_8_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_8_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_8_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_8 <= br_alloc_lists_8 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h9,
           _list_req_WIRE_9_2,
           _list_req_WIRE_9_1,
           _list_req_WIRE_9_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_9 <=
        (_list_req_WIRE_9_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_9_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_9_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_9 <= br_alloc_lists_9 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hA,
           _list_req_WIRE_10_2,
           _list_req_WIRE_10_1,
           _list_req_WIRE_10_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_10 <=
        (_list_req_WIRE_10_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_10_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_10_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_10 <= br_alloc_lists_10 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hB,
           _list_req_WIRE_11_2,
           _list_req_WIRE_11_1,
           _list_req_WIRE_11_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_11 <=
        (_list_req_WIRE_11_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_11_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_11_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_11 <= br_alloc_lists_11 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hC,
           _list_req_WIRE_12_2,
           _list_req_WIRE_12_1,
           _list_req_WIRE_12_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_12 <=
        (_list_req_WIRE_12_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_12_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_12_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_12 <= br_alloc_lists_12 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hD,
           _list_req_WIRE_13_2,
           _list_req_WIRE_13_1,
           _list_req_WIRE_13_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_13 <=
        (_list_req_WIRE_13_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_13_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_13_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_13 <= br_alloc_lists_13 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hE,
           _list_req_WIRE_14_2,
           _list_req_WIRE_14_1,
           _list_req_WIRE_14_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_14 <=
        (_list_req_WIRE_14_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_14_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_14_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_14 <= br_alloc_lists_14 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'hF,
           _list_req_WIRE_15_2,
           _list_req_WIRE_15_1,
           _list_req_WIRE_15_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_15 <=
        (_list_req_WIRE_15_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_15_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_15_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_15 <= br_alloc_lists_15 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h10,
           _list_req_WIRE_16_2,
           _list_req_WIRE_16_1,
           _list_req_WIRE_16_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_16 <=
        (_list_req_WIRE_16_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_16_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_16_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_16 <= br_alloc_lists_16 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h11,
           _list_req_WIRE_17_2,
           _list_req_WIRE_17_1,
           _list_req_WIRE_17_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_17 <=
        (_list_req_WIRE_17_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_17_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_17_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_17 <= br_alloc_lists_17 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h12,
           _list_req_WIRE_18_2,
           _list_req_WIRE_18_1,
           _list_req_WIRE_18_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_18 <=
        (_list_req_WIRE_18_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_18_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_18_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_18 <= br_alloc_lists_18 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (|({io_ren_br_tags_3_bits == 5'h13,
           _list_req_WIRE_19_2,
           _list_req_WIRE_19_1,
           _list_req_WIRE_19_0} & br_slots))	// OneHot.scala:58:35, rename-freelist.scala:66:64, :69:{72,78,85}, :70:29
      br_alloc_lists_19 <=
        (_list_req_WIRE_19_0 & io_ren_br_tags_0_valid ? alloc_masks_1 : 128'h0)
        | (_list_req_WIRE_19_1 & io_ren_br_tags_1_valid ? alloc_masks_2 : 128'h0)
        | (_list_req_WIRE_19_2 & io_ren_br_tags_2_valid ? alloc_masks_3 : 128'h0);	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :69:{72,85}
    else	// rename-freelist.scala:70:29
      br_alloc_lists_19 <= br_alloc_lists_19 & ~br_deallocs | alloc_masks_0;	// rename-freelist.scala:51:27, :59:84, :63:63, :72:{58,60,73}
    if (sel_fire_0) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T = sels_0[127:65] | sels_0[63:1];	// Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:28
      automatic logic [30:0] _r_sel_T_1 = _r_sel_T[62:32] | _r_sel_T[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_2 = _r_sel_T_1[30:16] | _r_sel_T_1[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_3 = _r_sel_T_2[14:8] | _r_sel_T_2[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_4 = _r_sel_T_3[6:4] | _r_sel_T_3[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel <=
        {|(sels_0[127:64]),
         |(_r_sel_T[62:31]),
         |(_r_sel_T_1[30:15]),
         |(_r_sel_T_2[14:7]),
         |(_r_sel_T_3[6:3]),
         |(_r_sel_T_4[2:1]),
         _r_sel_T_4[2] | _r_sel_T_4[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_1) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_7 = sels_1[127:65] | sels_1[63:1];	// Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:28
      automatic logic [30:0] _r_sel_T_8 = _r_sel_T_7[62:32] | _r_sel_T_7[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_9 = _r_sel_T_8[30:16] | _r_sel_T_8[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_10 = _r_sel_T_9[14:8] | _r_sel_T_9[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_11 = _r_sel_T_10[6:4] | _r_sel_T_10[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_1 <=
        {|(sels_1[127:64]),
         |(_r_sel_T_7[62:31]),
         |(_r_sel_T_8[30:15]),
         |(_r_sel_T_9[14:7]),
         |(_r_sel_T_10[6:3]),
         |(_r_sel_T_11[2:1]),
         _r_sel_T_11[2] | _r_sel_T_11[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_2) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_14 = sels_2[127:65] | sels_2[63:1];	// Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:28
      automatic logic [30:0] _r_sel_T_15 = _r_sel_T_14[62:32] | _r_sel_T_14[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_16 = _r_sel_T_15[30:16] | _r_sel_T_15[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_17 = _r_sel_T_16[14:8] | _r_sel_T_16[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_18 = _r_sel_T_17[6:4] | _r_sel_T_17[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_2 <=
        {|(sels_2[127:64]),
         |(_r_sel_T_14[62:31]),
         |(_r_sel_T_15[30:15]),
         |(_r_sel_T_16[14:7]),
         |(_r_sel_T_17[6:3]),
         |(_r_sel_T_18[2:1]),
         _r_sel_T_18[2] | _r_sel_T_18[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_3) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_21 = sels_3[127:65] | sels_3[63:1];	// Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:28
      automatic logic [30:0] _r_sel_T_22 = _r_sel_T_21[62:32] | _r_sel_T_21[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_23 = _r_sel_T_22[30:16] | _r_sel_T_22[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_24 = _r_sel_T_23[14:8] | _r_sel_T_23[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_25 = _r_sel_T_24[6:4] | _r_sel_T_24[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_3 <=
        {|(sels_3[127:64]),
         |(_r_sel_T_21[62:31]),
         |(_r_sel_T_22[30:15]),
         |(_r_sel_T_23[14:7]),
         |(_r_sel_T_24[6:3]),
         |(_r_sel_T_25[2:1]),
         _r_sel_T_25[2] | _r_sel_T_25[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:84];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h55; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        free_list = {_RANDOM[7'h0], _RANDOM[7'h1], _RANDOM[7'h2], _RANDOM[7'h3]};	// rename-freelist.scala:50:26
        br_alloc_lists_0 = {_RANDOM[7'h4], _RANDOM[7'h5], _RANDOM[7'h6], _RANDOM[7'h7]};	// rename-freelist.scala:51:27
        br_alloc_lists_1 = {_RANDOM[7'h8], _RANDOM[7'h9], _RANDOM[7'hA], _RANDOM[7'hB]};	// rename-freelist.scala:51:27
        br_alloc_lists_2 = {_RANDOM[7'hC], _RANDOM[7'hD], _RANDOM[7'hE], _RANDOM[7'hF]};	// rename-freelist.scala:51:27
        br_alloc_lists_3 =
          {_RANDOM[7'h10], _RANDOM[7'h11], _RANDOM[7'h12], _RANDOM[7'h13]};	// rename-freelist.scala:51:27
        br_alloc_lists_4 =
          {_RANDOM[7'h14], _RANDOM[7'h15], _RANDOM[7'h16], _RANDOM[7'h17]};	// rename-freelist.scala:51:27
        br_alloc_lists_5 =
          {_RANDOM[7'h18], _RANDOM[7'h19], _RANDOM[7'h1A], _RANDOM[7'h1B]};	// rename-freelist.scala:51:27
        br_alloc_lists_6 =
          {_RANDOM[7'h1C], _RANDOM[7'h1D], _RANDOM[7'h1E], _RANDOM[7'h1F]};	// rename-freelist.scala:51:27
        br_alloc_lists_7 =
          {_RANDOM[7'h20], _RANDOM[7'h21], _RANDOM[7'h22], _RANDOM[7'h23]};	// rename-freelist.scala:51:27
        br_alloc_lists_8 =
          {_RANDOM[7'h24], _RANDOM[7'h25], _RANDOM[7'h26], _RANDOM[7'h27]};	// rename-freelist.scala:51:27
        br_alloc_lists_9 =
          {_RANDOM[7'h28], _RANDOM[7'h29], _RANDOM[7'h2A], _RANDOM[7'h2B]};	// rename-freelist.scala:51:27
        br_alloc_lists_10 =
          {_RANDOM[7'h2C], _RANDOM[7'h2D], _RANDOM[7'h2E], _RANDOM[7'h2F]};	// rename-freelist.scala:51:27
        br_alloc_lists_11 =
          {_RANDOM[7'h30], _RANDOM[7'h31], _RANDOM[7'h32], _RANDOM[7'h33]};	// rename-freelist.scala:51:27
        br_alloc_lists_12 =
          {_RANDOM[7'h34], _RANDOM[7'h35], _RANDOM[7'h36], _RANDOM[7'h37]};	// rename-freelist.scala:51:27
        br_alloc_lists_13 =
          {_RANDOM[7'h38], _RANDOM[7'h39], _RANDOM[7'h3A], _RANDOM[7'h3B]};	// rename-freelist.scala:51:27
        br_alloc_lists_14 =
          {_RANDOM[7'h3C], _RANDOM[7'h3D], _RANDOM[7'h3E], _RANDOM[7'h3F]};	// rename-freelist.scala:51:27
        br_alloc_lists_15 =
          {_RANDOM[7'h40], _RANDOM[7'h41], _RANDOM[7'h42], _RANDOM[7'h43]};	// rename-freelist.scala:51:27
        br_alloc_lists_16 =
          {_RANDOM[7'h44], _RANDOM[7'h45], _RANDOM[7'h46], _RANDOM[7'h47]};	// rename-freelist.scala:51:27
        br_alloc_lists_17 =
          {_RANDOM[7'h48], _RANDOM[7'h49], _RANDOM[7'h4A], _RANDOM[7'h4B]};	// rename-freelist.scala:51:27
        br_alloc_lists_18 =
          {_RANDOM[7'h4C], _RANDOM[7'h4D], _RANDOM[7'h4E], _RANDOM[7'h4F]};	// rename-freelist.scala:51:27
        br_alloc_lists_19 =
          {_RANDOM[7'h50], _RANDOM[7'h51], _RANDOM[7'h52], _RANDOM[7'h53]};	// rename-freelist.scala:51:27
        r_valid = _RANDOM[7'h54][0];	// rename-freelist.scala:81:26
        r_sel = _RANDOM[7'h54][7:1];	// Reg.scala:15:16, rename-freelist.scala:81:26
        r_valid_1 = _RANDOM[7'h54][8];	// rename-freelist.scala:81:26
        r_sel_1 = _RANDOM[7'h54][15:9];	// Reg.scala:15:16, rename-freelist.scala:81:26
        r_valid_2 = _RANDOM[7'h54][16];	// rename-freelist.scala:81:26
        r_sel_2 = _RANDOM[7'h54][23:17];	// Reg.scala:15:16, rename-freelist.scala:81:26
        r_valid_3 = _RANDOM[7'h54][24];	// rename-freelist.scala:81:26
        r_sel_3 = _RANDOM[7'h54][31:25];	// Reg.scala:15:16, rename-freelist.scala:81:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_alloc_pregs_0_valid = r_valid;	// rename-freelist.scala:81:26
  assign io_alloc_pregs_0_bits = r_sel;	// Reg.scala:15:16
  assign io_alloc_pregs_1_valid = r_valid_1;	// rename-freelist.scala:81:26
  assign io_alloc_pregs_1_bits = r_sel_1;	// Reg.scala:15:16
  assign io_alloc_pregs_2_valid = r_valid_2;	// rename-freelist.scala:81:26
  assign io_alloc_pregs_2_bits = r_sel_2;	// Reg.scala:15:16
  assign io_alloc_pregs_3_valid = r_valid_3;	// rename-freelist.scala:81:26
  assign io_alloc_pregs_3_bits = r_sel_3;	// Reg.scala:15:16
endmodule

