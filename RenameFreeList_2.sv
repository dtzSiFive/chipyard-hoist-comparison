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

module RenameFreeList_2(
  input        clock,
               reset,
               io_reqs_0,
               io_reqs_1,
               io_reqs_2,
               io_dealloc_pregs_0_valid,
  input  [6:0] io_dealloc_pregs_0_bits,
  input        io_dealloc_pregs_1_valid,
  input  [6:0] io_dealloc_pregs_1_bits,
  input        io_dealloc_pregs_2_valid,
  input  [6:0] io_dealloc_pregs_2_bits,
  input        io_ren_br_tags_0_valid,
  input  [3:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [3:0] io_ren_br_tags_1_bits,
  input        io_ren_br_tags_2_valid,
  input  [3:0] io_ren_br_tags_2_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_debug_pipeline_empty,
  output       io_alloc_pregs_0_valid,
  output [6:0] io_alloc_pregs_0_bits,
  output       io_alloc_pregs_1_valid,
  output [6:0] io_alloc_pregs_1_bits,
  output       io_alloc_pregs_2_valid,
  output [6:0] io_alloc_pregs_2_bits
);

  reg  [6:0]        r_sel_2;	// Reg.scala:15:16
  reg  [6:0]        r_sel_1;	// Reg.scala:15:16
  reg  [6:0]        r_sel;	// Reg.scala:15:16
  reg  [99:0]       free_list;	// rename-freelist.scala:50:26
  reg  [99:0]       br_alloc_lists_0;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_1;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_2;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_3;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_4;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_5;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_6;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_7;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_8;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_9;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_10;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_11;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_12;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_13;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_14;	// rename-freelist.scala:51:27
  reg  [99:0]       br_alloc_lists_15;	// rename-freelist.scala:51:27
  wire [99:0]       sels_0 =
    free_list[0]
      ? 100'h1
      : free_list[1]
          ? 100'h2
          : free_list[2]
              ? 100'h4
              : free_list[3]
                  ? 100'h8
                  : free_list[4]
                      ? 100'h10
                      : free_list[5]
                          ? 100'h20
                          : free_list[6]
                              ? 100'h40
                              : free_list[7]
                                  ? 100'h80
                                  : free_list[8]
                                      ? 100'h100
                                      : free_list[9]
                                          ? 100'h200
                                          : free_list[10]
                                              ? 100'h400
                                              : free_list[11]
                                                  ? 100'h800
                                                  : free_list[12]
                                                      ? 100'h1000
                                                      : free_list[13]
                                                          ? 100'h2000
                                                          : free_list[14]
                                                              ? 100'h4000
                                                              : free_list[15]
                                                                  ? 100'h8000
                                                                  : free_list[16]
                                                                      ? 100'h10000
                                                                      : free_list[17]
                                                                          ? 100'h20000
                                                                          : free_list[18]
                                                                              ? 100'h40000
                                                                              : free_list[19]
                                                                                  ? 100'h80000
                                                                                  : free_list[20]
                                                                                      ? 100'h100000
                                                                                      : free_list[21]
                                                                                          ? 100'h200000
                                                                                          : free_list[22]
                                                                                              ? 100'h400000
                                                                                              : free_list[23]
                                                                                                  ? 100'h800000
                                                                                                  : free_list[24]
                                                                                                      ? 100'h1000000
                                                                                                      : free_list[25]
                                                                                                          ? 100'h2000000
                                                                                                          : free_list[26]
                                                                                                              ? 100'h4000000
                                                                                                              : free_list[27]
                                                                                                                  ? 100'h8000000
                                                                                                                  : free_list[28]
                                                                                                                      ? 100'h10000000
                                                                                                                      : free_list[29]
                                                                                                                          ? 100'h20000000
                                                                                                                          : free_list[30]
                                                                                                                              ? 100'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                  ? 100'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                      ? 100'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                          ? 100'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                              ? 100'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                  ? 100'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                      ? 100'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                          ? 100'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                              ? 100'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                  ? 100'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                      ? 100'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                          ? 100'h20000000000
                                                                                                                                                                          : free_list[42]
                                                                                                                                                                              ? 100'h40000000000
                                                                                                                                                                              : free_list[43]
                                                                                                                                                                                  ? 100'h80000000000
                                                                                                                                                                                  : free_list[44]
                                                                                                                                                                                      ? 100'h100000000000
                                                                                                                                                                                      : free_list[45]
                                                                                                                                                                                          ? 100'h200000000000
                                                                                                                                                                                          : free_list[46]
                                                                                                                                                                                              ? 100'h400000000000
                                                                                                                                                                                              : free_list[47]
                                                                                                                                                                                                  ? 100'h800000000000
                                                                                                                                                                                                  : free_list[48]
                                                                                                                                                                                                      ? 100'h1000000000000
                                                                                                                                                                                                      : free_list[49]
                                                                                                                                                                                                          ? 100'h2000000000000
                                                                                                                                                                                                          : free_list[50]
                                                                                                                                                                                                              ? 100'h4000000000000
                                                                                                                                                                                                              : free_list[51]
                                                                                                                                                                                                                  ? 100'h8000000000000
                                                                                                                                                                                                                  : free_list[52]
                                                                                                                                                                                                                      ? 100'h10000000000000
                                                                                                                                                                                                                      : free_list[53]
                                                                                                                                                                                                                          ? 100'h20000000000000
                                                                                                                                                                                                                          : free_list[54]
                                                                                                                                                                                                                              ? 100'h40000000000000
                                                                                                                                                                                                                              : free_list[55]
                                                                                                                                                                                                                                  ? 100'h80000000000000
                                                                                                                                                                                                                                  : free_list[56]
                                                                                                                                                                                                                                      ? 100'h100000000000000
                                                                                                                                                                                                                                      : free_list[57]
                                                                                                                                                                                                                                          ? 100'h200000000000000
                                                                                                                                                                                                                                          : free_list[58]
                                                                                                                                                                                                                                              ? 100'h400000000000000
                                                                                                                                                                                                                                              : free_list[59]
                                                                                                                                                                                                                                                  ? 100'h800000000000000
                                                                                                                                                                                                                                                  : free_list[60]
                                                                                                                                                                                                                                                      ? 100'h1000000000000000
                                                                                                                                                                                                                                                      : free_list[61]
                                                                                                                                                                                                                                                          ? 100'h2000000000000000
                                                                                                                                                                                                                                                          : free_list[62]
                                                                                                                                                                                                                                                              ? 100'h4000000000000000
                                                                                                                                                                                                                                                              : free_list[63]
                                                                                                                                                                                                                                                                  ? 100'h8000000000000000
                                                                                                                                                                                                                                                                  : free_list[64]
                                                                                                                                                                                                                                                                      ? 100'h10000000000000000
                                                                                                                                                                                                                                                                      : free_list[65]
                                                                                                                                                                                                                                                                          ? 100'h20000000000000000
                                                                                                                                                                                                                                                                          : free_list[66]
                                                                                                                                                                                                                                                                              ? 100'h40000000000000000
                                                                                                                                                                                                                                                                              : free_list[67]
                                                                                                                                                                                                                                                                                  ? 100'h80000000000000000
                                                                                                                                                                                                                                                                                  : free_list[68]
                                                                                                                                                                                                                                                                                      ? 100'h100000000000000000
                                                                                                                                                                                                                                                                                      : free_list[69]
                                                                                                                                                                                                                                                                                          ? 100'h200000000000000000
                                                                                                                                                                                                                                                                                          : free_list[70]
                                                                                                                                                                                                                                                                                              ? 100'h400000000000000000
                                                                                                                                                                                                                                                                                              : free_list[71]
                                                                                                                                                                                                                                                                                                  ? 100'h800000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[72]
                                                                                                                                                                                                                                                                                                      ? 100'h1000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[73]
                                                                                                                                                                                                                                                                                                          ? 100'h2000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[74]
                                                                                                                                                                                                                                                                                                              ? 100'h4000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[75]
                                                                                                                                                                                                                                                                                                                  ? 100'h8000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[76]
                                                                                                                                                                                                                                                                                                                      ? 100'h10000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[77]
                                                                                                                                                                                                                                                                                                                          ? 100'h20000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[78]
                                                                                                                                                                                                                                                                                                                              ? 100'h40000000000000000000
                                                                                                                                                                                                                                                                                                                              : free_list[79]
                                                                                                                                                                                                                                                                                                                                  ? 100'h80000000000000000000
                                                                                                                                                                                                                                                                                                                                  : free_list[80]
                                                                                                                                                                                                                                                                                                                                      ? 100'h100000000000000000000
                                                                                                                                                                                                                                                                                                                                      : free_list[81]
                                                                                                                                                                                                                                                                                                                                          ? 100'h200000000000000000000
                                                                                                                                                                                                                                                                                                                                          : free_list[82]
                                                                                                                                                                                                                                                                                                                                              ? 100'h400000000000000000000
                                                                                                                                                                                                                                                                                                                                              : free_list[83]
                                                                                                                                                                                                                                                                                                                                                  ? 100'h800000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : free_list[84]
                                                                                                                                                                                                                                                                                                                                                      ? 100'h1000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : free_list[85]
                                                                                                                                                                                                                                                                                                                                                          ? 100'h2000000000000000000000
                                                                                                                                                                                                                                                                                                                                                          : free_list[86]
                                                                                                                                                                                                                                                                                                                                                              ? 100'h4000000000000000000000
                                                                                                                                                                                                                                                                                                                                                              : free_list[87]
                                                                                                                                                                                                                                                                                                                                                                  ? 100'h8000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                  : free_list[88]
                                                                                                                                                                                                                                                                                                                                                                      ? 100'h10000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                      : free_list[89]
                                                                                                                                                                                                                                                                                                                                                                          ? 100'h20000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                          : free_list[90]
                                                                                                                                                                                                                                                                                                                                                                              ? 100'h40000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                              : free_list[91]
                                                                                                                                                                                                                                                                                                                                                                                  ? 100'h80000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                  : free_list[92]
                                                                                                                                                                                                                                                                                                                                                                                      ? 100'h100000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                      : free_list[93]
                                                                                                                                                                                                                                                                                                                                                                                          ? 100'h200000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                          : free_list[94]
                                                                                                                                                                                                                                                                                                                                                                                              ? 100'h400000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                              : free_list[95]
                                                                                                                                                                                                                                                                                                                                                                                                  ? 100'h800000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                  : free_list[96]
                                                                                                                                                                                                                                                                                                                                                                                                      ? 100'h1000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                      : free_list[97]
                                                                                                                                                                                                                                                                                                                                                                                                          ? 100'h2000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                          : free_list[98]
                                                                                                                                                                                                                                                                                                                                                                                                              ? 100'h4000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                                                                              : {free_list[99],
                                                                                                                                                                                                                                                                                                                                                                                                                 99'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}
  wire [99:0]       _sels_T = ~sels_0;	// Mux.scala:47:69, util.scala:410:21
  wire [99:0]       _sels_sels_1_T_185 =
    free_list[14] & _sels_T[14]
      ? 100'h4000
      : free_list[15] & _sels_T[15]
          ? 100'h8000
          : free_list[16] & _sels_T[16]
              ? 100'h10000
              : free_list[17] & _sels_T[17]
                  ? 100'h20000
                  : free_list[18] & _sels_T[18]
                      ? 100'h40000
                      : free_list[19] & _sels_T[19]
                          ? 100'h80000
                          : free_list[20] & _sels_T[20]
                              ? 100'h100000
                              : free_list[21] & _sels_T[21]
                                  ? 100'h200000
                                  : free_list[22] & _sels_T[22]
                                      ? 100'h400000
                                      : free_list[23] & _sels_T[23]
                                          ? 100'h800000
                                          : free_list[24] & _sels_T[24]
                                              ? 100'h1000000
                                              : free_list[25] & _sels_T[25]
                                                  ? 100'h2000000
                                                  : free_list[26] & _sels_T[26]
                                                      ? 100'h4000000
                                                      : free_list[27] & _sels_T[27]
                                                          ? 100'h8000000
                                                          : free_list[28] & _sels_T[28]
                                                              ? 100'h10000000
                                                              : free_list[29]
                                                                & _sels_T[29]
                                                                  ? 100'h20000000
                                                                  : free_list[30]
                                                                    & _sels_T[30]
                                                                      ? 100'h40000000
                                                                      : free_list[31]
                                                                        & _sels_T[31]
                                                                          ? 100'h80000000
                                                                          : free_list[32]
                                                                            & _sels_T[32]
                                                                              ? 100'h100000000
                                                                              : free_list[33]
                                                                                & _sels_T[33]
                                                                                  ? 100'h200000000
                                                                                  : free_list[34]
                                                                                    & _sels_T[34]
                                                                                      ? 100'h400000000
                                                                                      : free_list[35]
                                                                                        & _sels_T[35]
                                                                                          ? 100'h800000000
                                                                                          : free_list[36]
                                                                                            & _sels_T[36]
                                                                                              ? 100'h1000000000
                                                                                              : free_list[37]
                                                                                                & _sels_T[37]
                                                                                                  ? 100'h2000000000
                                                                                                  : free_list[38]
                                                                                                    & _sels_T[38]
                                                                                                      ? 100'h4000000000
                                                                                                      : free_list[39]
                                                                                                        & _sels_T[39]
                                                                                                          ? 100'h8000000000
                                                                                                          : free_list[40]
                                                                                                            & _sels_T[40]
                                                                                                              ? 100'h10000000000
                                                                                                              : free_list[41]
                                                                                                                & _sels_T[41]
                                                                                                                  ? 100'h20000000000
                                                                                                                  : free_list[42]
                                                                                                                    & _sels_T[42]
                                                                                                                      ? 100'h40000000000
                                                                                                                      : free_list[43]
                                                                                                                        & _sels_T[43]
                                                                                                                          ? 100'h80000000000
                                                                                                                          : free_list[44]
                                                                                                                            & _sels_T[44]
                                                                                                                              ? 100'h100000000000
                                                                                                                              : free_list[45]
                                                                                                                                & _sels_T[45]
                                                                                                                                  ? 100'h200000000000
                                                                                                                                  : free_list[46]
                                                                                                                                    & _sels_T[46]
                                                                                                                                      ? 100'h400000000000
                                                                                                                                      : free_list[47]
                                                                                                                                        & _sels_T[47]
                                                                                                                                          ? 100'h800000000000
                                                                                                                                          : free_list[48]
                                                                                                                                            & _sels_T[48]
                                                                                                                                              ? 100'h1000000000000
                                                                                                                                              : free_list[49]
                                                                                                                                                & _sels_T[49]
                                                                                                                                                  ? 100'h2000000000000
                                                                                                                                                  : free_list[50]
                                                                                                                                                    & _sels_T[50]
                                                                                                                                                      ? 100'h4000000000000
                                                                                                                                                      : free_list[51]
                                                                                                                                                        & _sels_T[51]
                                                                                                                                                          ? 100'h8000000000000
                                                                                                                                                          : free_list[52]
                                                                                                                                                            & _sels_T[52]
                                                                                                                                                              ? 100'h10000000000000
                                                                                                                                                              : free_list[53]
                                                                                                                                                                & _sels_T[53]
                                                                                                                                                                  ? 100'h20000000000000
                                                                                                                                                                  : free_list[54]
                                                                                                                                                                    & _sels_T[54]
                                                                                                                                                                      ? 100'h40000000000000
                                                                                                                                                                      : free_list[55]
                                                                                                                                                                        & _sels_T[55]
                                                                                                                                                                          ? 100'h80000000000000
                                                                                                                                                                          : free_list[56]
                                                                                                                                                                            & _sels_T[56]
                                                                                                                                                                              ? 100'h100000000000000
                                                                                                                                                                              : free_list[57]
                                                                                                                                                                                & _sels_T[57]
                                                                                                                                                                                  ? 100'h200000000000000
                                                                                                                                                                                  : free_list[58]
                                                                                                                                                                                    & _sels_T[58]
                                                                                                                                                                                      ? 100'h400000000000000
                                                                                                                                                                                      : free_list[59]
                                                                                                                                                                                        & _sels_T[59]
                                                                                                                                                                                          ? 100'h800000000000000
                                                                                                                                                                                          : free_list[60]
                                                                                                                                                                                            & _sels_T[60]
                                                                                                                                                                                              ? 100'h1000000000000000
                                                                                                                                                                                              : free_list[61]
                                                                                                                                                                                                & _sels_T[61]
                                                                                                                                                                                                  ? 100'h2000000000000000
                                                                                                                                                                                                  : free_list[62]
                                                                                                                                                                                                    & _sels_T[62]
                                                                                                                                                                                                      ? 100'h4000000000000000
                                                                                                                                                                                                      : free_list[63]
                                                                                                                                                                                                        & _sels_T[63]
                                                                                                                                                                                                          ? 100'h8000000000000000
                                                                                                                                                                                                          : free_list[64]
                                                                                                                                                                                                            & _sels_T[64]
                                                                                                                                                                                                              ? 100'h10000000000000000
                                                                                                                                                                                                              : free_list[65]
                                                                                                                                                                                                                & _sels_T[65]
                                                                                                                                                                                                                  ? 100'h20000000000000000
                                                                                                                                                                                                                  : free_list[66]
                                                                                                                                                                                                                    & _sels_T[66]
                                                                                                                                                                                                                      ? 100'h40000000000000000
                                                                                                                                                                                                                      : free_list[67]
                                                                                                                                                                                                                        & _sels_T[67]
                                                                                                                                                                                                                          ? 100'h80000000000000000
                                                                                                                                                                                                                          : free_list[68]
                                                                                                                                                                                                                            & _sels_T[68]
                                                                                                                                                                                                                              ? 100'h100000000000000000
                                                                                                                                                                                                                              : free_list[69]
                                                                                                                                                                                                                                & _sels_T[69]
                                                                                                                                                                                                                                  ? 100'h200000000000000000
                                                                                                                                                                                                                                  : free_list[70]
                                                                                                                                                                                                                                    & _sels_T[70]
                                                                                                                                                                                                                                      ? 100'h400000000000000000
                                                                                                                                                                                                                                      : free_list[71]
                                                                                                                                                                                                                                        & _sels_T[71]
                                                                                                                                                                                                                                          ? 100'h800000000000000000
                                                                                                                                                                                                                                          : free_list[72]
                                                                                                                                                                                                                                            & _sels_T[72]
                                                                                                                                                                                                                                              ? 100'h1000000000000000000
                                                                                                                                                                                                                                              : free_list[73]
                                                                                                                                                                                                                                                & _sels_T[73]
                                                                                                                                                                                                                                                  ? 100'h2000000000000000000
                                                                                                                                                                                                                                                  : free_list[74]
                                                                                                                                                                                                                                                    & _sels_T[74]
                                                                                                                                                                                                                                                      ? 100'h4000000000000000000
                                                                                                                                                                                                                                                      : free_list[75]
                                                                                                                                                                                                                                                        & _sels_T[75]
                                                                                                                                                                                                                                                          ? 100'h8000000000000000000
                                                                                                                                                                                                                                                          : free_list[76]
                                                                                                                                                                                                                                                            & _sels_T[76]
                                                                                                                                                                                                                                                              ? 100'h10000000000000000000
                                                                                                                                                                                                                                                              : free_list[77]
                                                                                                                                                                                                                                                                & _sels_T[77]
                                                                                                                                                                                                                                                                  ? 100'h20000000000000000000
                                                                                                                                                                                                                                                                  : free_list[78]
                                                                                                                                                                                                                                                                    & _sels_T[78]
                                                                                                                                                                                                                                                                      ? 100'h40000000000000000000
                                                                                                                                                                                                                                                                      : free_list[79]
                                                                                                                                                                                                                                                                        & _sels_T[79]
                                                                                                                                                                                                                                                                          ? 100'h80000000000000000000
                                                                                                                                                                                                                                                                          : free_list[80]
                                                                                                                                                                                                                                                                            & _sels_T[80]
                                                                                                                                                                                                                                                                              ? 100'h100000000000000000000
                                                                                                                                                                                                                                                                              : free_list[81]
                                                                                                                                                                                                                                                                                & _sels_T[81]
                                                                                                                                                                                                                                                                                  ? 100'h200000000000000000000
                                                                                                                                                                                                                                                                                  : free_list[82]
                                                                                                                                                                                                                                                                                    & _sels_T[82]
                                                                                                                                                                                                                                                                                      ? 100'h400000000000000000000
                                                                                                                                                                                                                                                                                      : free_list[83]
                                                                                                                                                                                                                                                                                        & _sels_T[83]
                                                                                                                                                                                                                                                                                          ? 100'h800000000000000000000
                                                                                                                                                                                                                                                                                          : free_list[84]
                                                                                                                                                                                                                                                                                            & _sels_T[84]
                                                                                                                                                                                                                                                                                              ? 100'h1000000000000000000000
                                                                                                                                                                                                                                                                                              : free_list[85]
                                                                                                                                                                                                                                                                                                & _sels_T[85]
                                                                                                                                                                                                                                                                                                  ? 100'h2000000000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[86]
                                                                                                                                                                                                                                                                                                    & _sels_T[86]
                                                                                                                                                                                                                                                                                                      ? 100'h4000000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[87]
                                                                                                                                                                                                                                                                                                        & _sels_T[87]
                                                                                                                                                                                                                                                                                                          ? 100'h8000000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[88]
                                                                                                                                                                                                                                                                                                            & _sels_T[88]
                                                                                                                                                                                                                                                                                                              ? 100'h10000000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[89]
                                                                                                                                                                                                                                                                                                                & _sels_T[89]
                                                                                                                                                                                                                                                                                                                  ? 100'h20000000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[90]
                                                                                                                                                                                                                                                                                                                    & _sels_T[90]
                                                                                                                                                                                                                                                                                                                      ? 100'h40000000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[91]
                                                                                                                                                                                                                                                                                                                        & _sels_T[91]
                                                                                                                                                                                                                                                                                                                          ? 100'h80000000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[92]
                                                                                                                                                                                                                                                                                                                            & _sels_T[92]
                                                                                                                                                                                                                                                                                                                              ? 100'h100000000000000000000000
                                                                                                                                                                                                                                                                                                                              : free_list[93]
                                                                                                                                                                                                                                                                                                                                & _sels_T[93]
                                                                                                                                                                                                                                                                                                                                  ? 100'h200000000000000000000000
                                                                                                                                                                                                                                                                                                                                  : free_list[94]
                                                                                                                                                                                                                                                                                                                                    & _sels_T[94]
                                                                                                                                                                                                                                                                                                                                      ? 100'h400000000000000000000000
                                                                                                                                                                                                                                                                                                                                      : free_list[95]
                                                                                                                                                                                                                                                                                                                                        & _sels_T[95]
                                                                                                                                                                                                                                                                                                                                          ? 100'h800000000000000000000000
                                                                                                                                                                                                                                                                                                                                          : free_list[96]
                                                                                                                                                                                                                                                                                                                                            & _sels_T[96]
                                                                                                                                                                                                                                                                                                                                              ? 100'h1000000000000000000000000
                                                                                                                                                                                                                                                                                                                                              : free_list[97]
                                                                                                                                                                                                                                                                                                                                                & _sels_T[97]
                                                                                                                                                                                                                                                                                                                                                  ? 100'h2000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                  : free_list[98]
                                                                                                                                                                                                                                                                                                                                                    & _sels_T[98]
                                                                                                                                                                                                                                                                                                                                                      ? 100'h4000000000000000000000000
                                                                                                                                                                                                                                                                                                                                                      : {free_list[99]
                                                                                                                                                                                                                                                                                                                                                           & _sels_T[99],
                                                                                                                                                                                                                                                                                                                                                         99'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire [99:0]       sels_1 =
    free_list[0] & _sels_T[0]
      ? 100'h1
      : free_list[1] & _sels_T[1]
          ? 100'h2
          : free_list[2] & _sels_T[2]
              ? 100'h4
              : free_list[3] & _sels_T[3]
                  ? 100'h8
                  : free_list[4] & _sels_T[4]
                      ? 100'h10
                      : free_list[5] & _sels_T[5]
                          ? 100'h20
                          : free_list[6] & _sels_T[6]
                              ? 100'h40
                              : free_list[7] & _sels_T[7]
                                  ? 100'h80
                                  : free_list[8] & _sels_T[8]
                                      ? 100'h100
                                      : free_list[9] & _sels_T[9]
                                          ? 100'h200
                                          : free_list[10] & _sels_T[10]
                                              ? 100'h400
                                              : free_list[11] & _sels_T[11]
                                                  ? 100'h800
                                                  : free_list[12] & _sels_T[12]
                                                      ? 100'h1000
                                                      : free_list[13] & _sels_T[13]
                                                          ? 100'h2000
                                                          : _sels_sels_1_T_185;	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}, util.scala:410:{19,21}
  wire [99:0]       _sels_T_2 = ~sels_1;	// Mux.scala:47:69, util.scala:410:21
  wire [99:0]       _sels_sels_2_T_164 =
    free_list[35] & _sels_T[35] & _sels_T_2[35]
      ? 100'h800000000
      : free_list[36] & _sels_T[36] & _sels_T_2[36]
          ? 100'h1000000000
          : free_list[37] & _sels_T[37] & _sels_T_2[37]
              ? 100'h2000000000
              : free_list[38] & _sels_T[38] & _sels_T_2[38]
                  ? 100'h4000000000
                  : free_list[39] & _sels_T[39] & _sels_T_2[39]
                      ? 100'h8000000000
                      : free_list[40] & _sels_T[40] & _sels_T_2[40]
                          ? 100'h10000000000
                          : free_list[41] & _sels_T[41] & _sels_T_2[41]
                              ? 100'h20000000000
                              : free_list[42] & _sels_T[42] & _sels_T_2[42]
                                  ? 100'h40000000000
                                  : free_list[43] & _sels_T[43] & _sels_T_2[43]
                                      ? 100'h80000000000
                                      : free_list[44] & _sels_T[44] & _sels_T_2[44]
                                          ? 100'h100000000000
                                          : free_list[45] & _sels_T[45] & _sels_T_2[45]
                                              ? 100'h200000000000
                                              : free_list[46] & _sels_T[46]
                                                & _sels_T_2[46]
                                                  ? 100'h400000000000
                                                  : free_list[47] & _sels_T[47]
                                                    & _sels_T_2[47]
                                                      ? 100'h800000000000
                                                      : free_list[48] & _sels_T[48]
                                                        & _sels_T_2[48]
                                                          ? 100'h1000000000000
                                                          : free_list[49] & _sels_T[49]
                                                            & _sels_T_2[49]
                                                              ? 100'h2000000000000
                                                              : free_list[50]
                                                                & _sels_T[50]
                                                                & _sels_T_2[50]
                                                                  ? 100'h4000000000000
                                                                  : free_list[51]
                                                                    & _sels_T[51]
                                                                    & _sels_T_2[51]
                                                                      ? 100'h8000000000000
                                                                      : free_list[52]
                                                                        & _sels_T[52]
                                                                        & _sels_T_2[52]
                                                                          ? 100'h10000000000000
                                                                          : free_list[53]
                                                                            & _sels_T[53]
                                                                            & _sels_T_2[53]
                                                                              ? 100'h20000000000000
                                                                              : free_list[54]
                                                                                & _sels_T[54]
                                                                                & _sels_T_2[54]
                                                                                  ? 100'h40000000000000
                                                                                  : free_list[55]
                                                                                    & _sels_T[55]
                                                                                    & _sels_T_2[55]
                                                                                      ? 100'h80000000000000
                                                                                      : free_list[56]
                                                                                        & _sels_T[56]
                                                                                        & _sels_T_2[56]
                                                                                          ? 100'h100000000000000
                                                                                          : free_list[57]
                                                                                            & _sels_T[57]
                                                                                            & _sels_T_2[57]
                                                                                              ? 100'h200000000000000
                                                                                              : free_list[58]
                                                                                                & _sels_T[58]
                                                                                                & _sels_T_2[58]
                                                                                                  ? 100'h400000000000000
                                                                                                  : free_list[59]
                                                                                                    & _sels_T[59]
                                                                                                    & _sels_T_2[59]
                                                                                                      ? 100'h800000000000000
                                                                                                      : free_list[60]
                                                                                                        & _sels_T[60]
                                                                                                        & _sels_T_2[60]
                                                                                                          ? 100'h1000000000000000
                                                                                                          : free_list[61]
                                                                                                            & _sels_T[61]
                                                                                                            & _sels_T_2[61]
                                                                                                              ? 100'h2000000000000000
                                                                                                              : free_list[62]
                                                                                                                & _sels_T[62]
                                                                                                                & _sels_T_2[62]
                                                                                                                  ? 100'h4000000000000000
                                                                                                                  : free_list[63]
                                                                                                                    & _sels_T[63]
                                                                                                                    & _sels_T_2[63]
                                                                                                                      ? 100'h8000000000000000
                                                                                                                      : free_list[64]
                                                                                                                        & _sels_T[64]
                                                                                                                        & _sels_T_2[64]
                                                                                                                          ? 100'h10000000000000000
                                                                                                                          : free_list[65]
                                                                                                                            & _sels_T[65]
                                                                                                                            & _sels_T_2[65]
                                                                                                                              ? 100'h20000000000000000
                                                                                                                              : free_list[66]
                                                                                                                                & _sels_T[66]
                                                                                                                                & _sels_T_2[66]
                                                                                                                                  ? 100'h40000000000000000
                                                                                                                                  : free_list[67]
                                                                                                                                    & _sels_T[67]
                                                                                                                                    & _sels_T_2[67]
                                                                                                                                      ? 100'h80000000000000000
                                                                                                                                      : free_list[68]
                                                                                                                                        & _sels_T[68]
                                                                                                                                        & _sels_T_2[68]
                                                                                                                                          ? 100'h100000000000000000
                                                                                                                                          : free_list[69]
                                                                                                                                            & _sels_T[69]
                                                                                                                                            & _sels_T_2[69]
                                                                                                                                              ? 100'h200000000000000000
                                                                                                                                              : free_list[70]
                                                                                                                                                & _sels_T[70]
                                                                                                                                                & _sels_T_2[70]
                                                                                                                                                  ? 100'h400000000000000000
                                                                                                                                                  : free_list[71]
                                                                                                                                                    & _sels_T[71]
                                                                                                                                                    & _sels_T_2[71]
                                                                                                                                                      ? 100'h800000000000000000
                                                                                                                                                      : free_list[72]
                                                                                                                                                        & _sels_T[72]
                                                                                                                                                        & _sels_T_2[72]
                                                                                                                                                          ? 100'h1000000000000000000
                                                                                                                                                          : free_list[73]
                                                                                                                                                            & _sels_T[73]
                                                                                                                                                            & _sels_T_2[73]
                                                                                                                                                              ? 100'h2000000000000000000
                                                                                                                                                              : free_list[74]
                                                                                                                                                                & _sels_T[74]
                                                                                                                                                                & _sels_T_2[74]
                                                                                                                                                                  ? 100'h4000000000000000000
                                                                                                                                                                  : free_list[75]
                                                                                                                                                                    & _sels_T[75]
                                                                                                                                                                    & _sels_T_2[75]
                                                                                                                                                                      ? 100'h8000000000000000000
                                                                                                                                                                      : free_list[76]
                                                                                                                                                                        & _sels_T[76]
                                                                                                                                                                        & _sels_T_2[76]
                                                                                                                                                                          ? 100'h10000000000000000000
                                                                                                                                                                          : free_list[77]
                                                                                                                                                                            & _sels_T[77]
                                                                                                                                                                            & _sels_T_2[77]
                                                                                                                                                                              ? 100'h20000000000000000000
                                                                                                                                                                              : free_list[78]
                                                                                                                                                                                & _sels_T[78]
                                                                                                                                                                                & _sels_T_2[78]
                                                                                                                                                                                  ? 100'h40000000000000000000
                                                                                                                                                                                  : free_list[79]
                                                                                                                                                                                    & _sels_T[79]
                                                                                                                                                                                    & _sels_T_2[79]
                                                                                                                                                                                      ? 100'h80000000000000000000
                                                                                                                                                                                      : free_list[80]
                                                                                                                                                                                        & _sels_T[80]
                                                                                                                                                                                        & _sels_T_2[80]
                                                                                                                                                                                          ? 100'h100000000000000000000
                                                                                                                                                                                          : free_list[81]
                                                                                                                                                                                            & _sels_T[81]
                                                                                                                                                                                            & _sels_T_2[81]
                                                                                                                                                                                              ? 100'h200000000000000000000
                                                                                                                                                                                              : free_list[82]
                                                                                                                                                                                                & _sels_T[82]
                                                                                                                                                                                                & _sels_T_2[82]
                                                                                                                                                                                                  ? 100'h400000000000000000000
                                                                                                                                                                                                  : free_list[83]
                                                                                                                                                                                                    & _sels_T[83]
                                                                                                                                                                                                    & _sels_T_2[83]
                                                                                                                                                                                                      ? 100'h800000000000000000000
                                                                                                                                                                                                      : free_list[84]
                                                                                                                                                                                                        & _sels_T[84]
                                                                                                                                                                                                        & _sels_T_2[84]
                                                                                                                                                                                                          ? 100'h1000000000000000000000
                                                                                                                                                                                                          : free_list[85]
                                                                                                                                                                                                            & _sels_T[85]
                                                                                                                                                                                                            & _sels_T_2[85]
                                                                                                                                                                                                              ? 100'h2000000000000000000000
                                                                                                                                                                                                              : free_list[86]
                                                                                                                                                                                                                & _sels_T[86]
                                                                                                                                                                                                                & _sels_T_2[86]
                                                                                                                                                                                                                  ? 100'h4000000000000000000000
                                                                                                                                                                                                                  : free_list[87]
                                                                                                                                                                                                                    & _sels_T[87]
                                                                                                                                                                                                                    & _sels_T_2[87]
                                                                                                                                                                                                                      ? 100'h8000000000000000000000
                                                                                                                                                                                                                      : free_list[88]
                                                                                                                                                                                                                        & _sels_T[88]
                                                                                                                                                                                                                        & _sels_T_2[88]
                                                                                                                                                                                                                          ? 100'h10000000000000000000000
                                                                                                                                                                                                                          : free_list[89]
                                                                                                                                                                                                                            & _sels_T[89]
                                                                                                                                                                                                                            & _sels_T_2[89]
                                                                                                                                                                                                                              ? 100'h20000000000000000000000
                                                                                                                                                                                                                              : free_list[90]
                                                                                                                                                                                                                                & _sels_T[90]
                                                                                                                                                                                                                                & _sels_T_2[90]
                                                                                                                                                                                                                                  ? 100'h40000000000000000000000
                                                                                                                                                                                                                                  : free_list[91]
                                                                                                                                                                                                                                    & _sels_T[91]
                                                                                                                                                                                                                                    & _sels_T_2[91]
                                                                                                                                                                                                                                      ? 100'h80000000000000000000000
                                                                                                                                                                                                                                      : free_list[92]
                                                                                                                                                                                                                                        & _sels_T[92]
                                                                                                                                                                                                                                        & _sels_T_2[92]
                                                                                                                                                                                                                                          ? 100'h100000000000000000000000
                                                                                                                                                                                                                                          : free_list[93]
                                                                                                                                                                                                                                            & _sels_T[93]
                                                                                                                                                                                                                                            & _sels_T_2[93]
                                                                                                                                                                                                                                              ? 100'h200000000000000000000000
                                                                                                                                                                                                                                              : free_list[94]
                                                                                                                                                                                                                                                & _sels_T[94]
                                                                                                                                                                                                                                                & _sels_T_2[94]
                                                                                                                                                                                                                                                  ? 100'h400000000000000000000000
                                                                                                                                                                                                                                                  : free_list[95]
                                                                                                                                                                                                                                                    & _sels_T[95]
                                                                                                                                                                                                                                                    & _sels_T_2[95]
                                                                                                                                                                                                                                                      ? 100'h800000000000000000000000
                                                                                                                                                                                                                                                      : free_list[96]
                                                                                                                                                                                                                                                        & _sels_T[96]
                                                                                                                                                                                                                                                        & _sels_T_2[96]
                                                                                                                                                                                                                                                          ? 100'h1000000000000000000000000
                                                                                                                                                                                                                                                          : free_list[97]
                                                                                                                                                                                                                                                            & _sels_T[97]
                                                                                                                                                                                                                                                            & _sels_T_2[97]
                                                                                                                                                                                                                                                              ? 100'h2000000000000000000000000
                                                                                                                                                                                                                                                              : free_list[98]
                                                                                                                                                                                                                                                                & _sels_T[98]
                                                                                                                                                                                                                                                                & _sels_T_2[98]
                                                                                                                                                                                                                                                                  ? 100'h4000000000000000000000000
                                                                                                                                                                                                                                                                  : {free_list[99]
                                                                                                                                                                                                                                                                       & _sels_T[99]
                                                                                                                                                                                                                                                                       & _sels_T_2[99],
                                                                                                                                                                                                                                                                     99'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:26, util.scala:410:{19,21}
  wire [99:0]       sels_2 =
    free_list[0] & _sels_T[0] & _sels_T_2[0]
      ? 100'h1
      : free_list[1] & _sels_T[1] & _sels_T_2[1]
          ? 100'h2
          : free_list[2] & _sels_T[2] & _sels_T_2[2]
              ? 100'h4
              : free_list[3] & _sels_T[3] & _sels_T_2[3]
                  ? 100'h8
                  : free_list[4] & _sels_T[4] & _sels_T_2[4]
                      ? 100'h10
                      : free_list[5] & _sels_T[5] & _sels_T_2[5]
                          ? 100'h20
                          : free_list[6] & _sels_T[6] & _sels_T_2[6]
                              ? 100'h40
                              : free_list[7] & _sels_T[7] & _sels_T_2[7]
                                  ? 100'h80
                                  : free_list[8] & _sels_T[8] & _sels_T_2[8]
                                      ? 100'h100
                                      : free_list[9] & _sels_T[9] & _sels_T_2[9]
                                          ? 100'h200
                                          : free_list[10] & _sels_T[10] & _sels_T_2[10]
                                              ? 100'h400
                                              : free_list[11] & _sels_T[11]
                                                & _sels_T_2[11]
                                                  ? 100'h800
                                                  : free_list[12] & _sels_T[12]
                                                    & _sels_T_2[12]
                                                      ? 100'h1000
                                                      : free_list[13] & _sels_T[13]
                                                        & _sels_T_2[13]
                                                          ? 100'h2000
                                                          : free_list[14] & _sels_T[14]
                                                            & _sels_T_2[14]
                                                              ? 100'h4000
                                                              : free_list[15]
                                                                & _sels_T[15]
                                                                & _sels_T_2[15]
                                                                  ? 100'h8000
                                                                  : free_list[16]
                                                                    & _sels_T[16]
                                                                    & _sels_T_2[16]
                                                                      ? 100'h10000
                                                                      : free_list[17]
                                                                        & _sels_T[17]
                                                                        & _sels_T_2[17]
                                                                          ? 100'h20000
                                                                          : free_list[18]
                                                                            & _sels_T[18]
                                                                            & _sels_T_2[18]
                                                                              ? 100'h40000
                                                                              : free_list[19]
                                                                                & _sels_T[19]
                                                                                & _sels_T_2[19]
                                                                                  ? 100'h80000
                                                                                  : free_list[20]
                                                                                    & _sels_T[20]
                                                                                    & _sels_T_2[20]
                                                                                      ? 100'h100000
                                                                                      : free_list[21]
                                                                                        & _sels_T[21]
                                                                                        & _sels_T_2[21]
                                                                                          ? 100'h200000
                                                                                          : free_list[22]
                                                                                            & _sels_T[22]
                                                                                            & _sels_T_2[22]
                                                                                              ? 100'h400000
                                                                                              : free_list[23]
                                                                                                & _sels_T[23]
                                                                                                & _sels_T_2[23]
                                                                                                  ? 100'h800000
                                                                                                  : free_list[24]
                                                                                                    & _sels_T[24]
                                                                                                    & _sels_T_2[24]
                                                                                                      ? 100'h1000000
                                                                                                      : free_list[25]
                                                                                                        & _sels_T[25]
                                                                                                        & _sels_T_2[25]
                                                                                                          ? 100'h2000000
                                                                                                          : free_list[26]
                                                                                                            & _sels_T[26]
                                                                                                            & _sels_T_2[26]
                                                                                                              ? 100'h4000000
                                                                                                              : free_list[27]
                                                                                                                & _sels_T[27]
                                                                                                                & _sels_T_2[27]
                                                                                                                  ? 100'h8000000
                                                                                                                  : free_list[28]
                                                                                                                    & _sels_T[28]
                                                                                                                    & _sels_T_2[28]
                                                                                                                      ? 100'h10000000
                                                                                                                      : free_list[29]
                                                                                                                        & _sels_T[29]
                                                                                                                        & _sels_T_2[29]
                                                                                                                          ? 100'h20000000
                                                                                                                          : free_list[30]
                                                                                                                            & _sels_T[30]
                                                                                                                            & _sels_T_2[30]
                                                                                                                              ? 100'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                & _sels_T[31]
                                                                                                                                & _sels_T_2[31]
                                                                                                                                  ? 100'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                    & _sels_T[32]
                                                                                                                                    & _sels_T_2[32]
                                                                                                                                      ? 100'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                        & _sels_T[33]
                                                                                                                                        & _sels_T_2[33]
                                                                                                                                          ? 100'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                            & _sels_T[34]
                                                                                                                                            & _sels_T_2[34]
                                                                                                                                              ? 100'h400000000
                                                                                                                                              : _sels_sels_2_T_164;	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}, util.scala:410:{19,21}
  wire [127:0]      allocs_0 = 128'h1 << r_sel;	// OneHot.scala:58:35, Reg.scala:15:16
  wire [127:0]      allocs_1 = 128'h1 << r_sel_1;	// OneHot.scala:58:35, Reg.scala:15:16
  wire [127:0]      allocs_2 = 128'h1 << r_sel_2;	// OneHot.scala:58:35, Reg.scala:15:16
  wire [15:0][99:0] _GEN =
    {{br_alloc_lists_15},
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
  wire [99:0]       br_deallocs =
    _GEN[io_brupdate_b2_uop_br_tag] & {100{io_brupdate_b2_mispredict}};	// Bitwise.scala:72:12, rename-freelist.scala:63:63
  wire [127:0]      _dealloc_mask_T = 128'h1 << io_dealloc_pregs_0_bits;	// OneHot.scala:58:35
  wire [127:0]      _dealloc_mask_T_5 = 128'h1 << io_dealloc_pregs_1_bits;	// OneHot.scala:58:35
  wire [127:0]      _dealloc_mask_T_10 = 128'h1 << io_dealloc_pregs_2_bits;	// OneHot.scala:58:35
  wire [99:0]       dealloc_mask =
    _dealloc_mask_T[99:0] & {100{io_dealloc_pregs_0_valid}} | _dealloc_mask_T_5[99:0]
    & {100{io_dealloc_pregs_1_valid}} | _dealloc_mask_T_10[99:0]
    & {100{io_dealloc_pregs_2_valid}} | br_deallocs;	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:63:63, :64:{64,79,110}
  reg               r_valid;	// rename-freelist.scala:81:26
  wire              sel_fire_0 = (~r_valid | io_reqs_0) & (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg               r_valid_1;	// rename-freelist.scala:81:26
  wire              sel_fire_1 = (~r_valid_1 | io_reqs_1) & (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg               r_valid_2;	// rename-freelist.scala:81:26
  wire              sel_fire_2 = (~r_valid_2 | io_reqs_2) & (|sels_2);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  `ifndef SYNTHESIS	// rename-freelist.scala:94:10
    always @(posedge clock) begin	// rename-freelist.scala:94:10
      automatic logic [99:0] _GEN_0;	// rename-freelist.scala:91:34
      _GEN_0 =
        free_list | allocs_0[99:0] & {100{r_valid}} | allocs_1[99:0] & {100{r_valid_1}}
        | allocs_2[99:0] & {100{r_valid_2}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:50:26, :59:88, :81:26, :91:{34,77}
      if (~((_GEN_0 & dealloc_mask) == 100'h0 | reset)) begin	// Mux.scala:47:69, rename-freelist.scala:64:110, :91:34, :94:{10,31,47}
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
                  {1'h0, {1'h0, _GEN_0[0]} + {1'h0, _GEN_0[1]} + {1'h0, _GEN_0[2]}}
                    + {1'h0, {1'h0, _GEN_0[3]} + {1'h0, _GEN_0[4]} + {1'h0, _GEN_0[5]}}}
                   + {1'h0,
                      {1'h0, {1'h0, _GEN_0[6]} + {1'h0, _GEN_0[7]} + {1'h0, _GEN_0[8]}}
                        + {1'h0,
                           {1'h0, _GEN_0[9]} + {1'h0, _GEN_0[10]} + {1'h0, _GEN_0[11]}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[12]} + {1'h0, _GEN_0[13]} + {1'h0, _GEN_0[14]}}
                        + {1'h0,
                           {1'h0, _GEN_0[15]} + {1'h0, _GEN_0[16]} + {1'h0, _GEN_0[17]}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[18]} + {1'h0, _GEN_0[19]} + {1'h0, _GEN_0[20]}}
                            + {1'h0, {1'h0, _GEN_0[21]} + {1'h0, _GEN_0[22]}}
                            + {1'h0, {1'h0, _GEN_0[23]} + {1'h0, _GEN_0[24]}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[25]} + {1'h0, _GEN_0[26]} + {1'h0, _GEN_0[27]}}
                        + {1'h0,
                           {1'h0, _GEN_0[28]} + {1'h0, _GEN_0[29]} + {1'h0, _GEN_0[30]}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[31]} + {1'h0, _GEN_0[32]} + {1'h0, _GEN_0[33]}}
                            + {1'h0,
                               {1'h0, _GEN_0[34]} + {1'h0, _GEN_0[35]}
                                 + {1'h0, _GEN_0[36]}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[37]} + {1'h0, _GEN_0[38]} + {1'h0, _GEN_0[39]}}
                            + {1'h0,
                               {1'h0, _GEN_0[40]} + {1'h0, _GEN_0[41]}
                                 + {1'h0, _GEN_0[42]}}}
                           + {1'h0,
                              {1'h0,
                               {1'h0, _GEN_0[43]} + {1'h0, _GEN_0[44]}
                                 + {1'h0, _GEN_0[45]}}
                                + {1'h0, {1'h0, _GEN_0[46]} + {1'h0, _GEN_0[47]}}
                                + {1'h0, {1'h0, _GEN_0[48]} + {1'h0, _GEN_0[49]}}}}}}
            + {1'h0,
               {1'h0,
                {1'h0,
                 {1'h0,
                  {1'h0, {1'h0, _GEN_0[50]} + {1'h0, _GEN_0[51]} + {1'h0, _GEN_0[52]}}
                    + {1'h0,
                       {1'h0, _GEN_0[53]} + {1'h0, _GEN_0[54]} + {1'h0, _GEN_0[55]}}}
                   + {1'h0,
                      {1'h0, {1'h0, _GEN_0[56]} + {1'h0, _GEN_0[57]} + {1'h0, _GEN_0[58]}}
                        + {1'h0,
                           {1'h0, _GEN_0[59]} + {1'h0, _GEN_0[60]} + {1'h0, _GEN_0[61]}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[62]} + {1'h0, _GEN_0[63]} + {1'h0, _GEN_0[64]}}
                        + {1'h0,
                           {1'h0, _GEN_0[65]} + {1'h0, _GEN_0[66]} + {1'h0, _GEN_0[67]}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[68]} + {1'h0, _GEN_0[69]} + {1'h0, _GEN_0[70]}}
                            + {1'h0, {1'h0, _GEN_0[71]} + {1'h0, _GEN_0[72]}}
                            + {1'h0, {1'h0, _GEN_0[73]} + {1'h0, _GEN_0[74]}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[75]} + {1'h0, _GEN_0[76]} + {1'h0, _GEN_0[77]}}
                        + {1'h0,
                           {1'h0, _GEN_0[78]} + {1'h0, _GEN_0[79]} + {1'h0, _GEN_0[80]}}}
                       + {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[81]} + {1'h0, _GEN_0[82]} + {1'h0, _GEN_0[83]}}
                            + {1'h0,
                               {1'h0, _GEN_0[84]} + {1'h0, _GEN_0[85]}
                                 + {1'h0, _GEN_0[86]}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0,
                           {1'h0, _GEN_0[87]} + {1'h0, _GEN_0[88]} + {1'h0, _GEN_0[89]}}
                            + {1'h0,
                               {1'h0, _GEN_0[90]} + {1'h0, _GEN_0[91]}
                                 + {1'h0, _GEN_0[92]}}}
                           + {1'h0,
                              {1'h0,
                               {1'h0, _GEN_0[93]} + {1'h0, _GEN_0[94]}
                                 + {1'h0, _GEN_0[95]}}
                                + {1'h0, {1'h0, _GEN_0[96]} + {1'h0, _GEN_0[97]}}
                                + {1'h0,
                                   {1'h0, _GEN_0[98]} + {1'h0, _GEN_0[99]}}}}}} > 7'h43
            | reset)) begin	// Bitwise.scala:47:55, :49:65, rename-freelist.scala:51:27, :91:34, :95:{10,11,67}
        if (`ASSERT_VERBOSE_COND_)	// rename-freelist.scala:95:10
          $error("Assertion failed: [freelist] Leaking physical registers.\n    at rename-freelist.scala:95 assert (!io.debug.pipeline_empty || PopCount(io.debug.freelist) >= (numPregs - numLregs - 1).U,\n");	// rename-freelist.scala:95:10
        if (`STOP_COND_)	// rename-freelist.scala:95:10
          $fatal;	// rename-freelist.scala:95:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [99:0] _GEN_1 = allocs_2[99:0] & {100{io_reqs_2}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:88
    automatic logic [99:0] _GEN_2 = _GEN_1 | allocs_1[99:0] & {100{io_reqs_1}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    automatic logic [99:0] _GEN_3 = _GEN_2 | allocs_0[99:0] & {100{io_reqs_0}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    automatic logic [2:0]  br_slots =
      {io_ren_br_tags_2_valid, io_ren_br_tags_1_valid, io_ren_br_tags_0_valid};	// rename-freelist.scala:66:64
    automatic logic        _list_req_WIRE_0 = io_ren_br_tags_0_bits == 4'h0;	// OneHot.scala:32:14, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_1 = io_ren_br_tags_1_bits == 4'h0;	// OneHot.scala:32:14, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_1_0 = io_ren_br_tags_0_bits == 4'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_1_1 = io_ren_br_tags_1_bits == 4'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_2_0 = io_ren_br_tags_0_bits == 4'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_2_1 = io_ren_br_tags_1_bits == 4'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_3_0 = io_ren_br_tags_0_bits == 4'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_3_1 = io_ren_br_tags_1_bits == 4'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_4_0 = io_ren_br_tags_0_bits == 4'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_4_1 = io_ren_br_tags_1_bits == 4'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_5_0 = io_ren_br_tags_0_bits == 4'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_5_1 = io_ren_br_tags_1_bits == 4'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_6_0 = io_ren_br_tags_0_bits == 4'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_6_1 = io_ren_br_tags_1_bits == 4'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_7_0 = io_ren_br_tags_0_bits == 4'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_7_1 = io_ren_br_tags_1_bits == 4'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_8_0 = io_ren_br_tags_0_bits == 4'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_8_1 = io_ren_br_tags_1_bits == 4'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_9_0 = io_ren_br_tags_0_bits == 4'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_9_1 = io_ren_br_tags_1_bits == 4'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_10_0 = io_ren_br_tags_0_bits == 4'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_10_1 = io_ren_br_tags_1_bits == 4'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_11_0 = io_ren_br_tags_0_bits == 4'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_11_1 = io_ren_br_tags_1_bits == 4'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_12_0 = io_ren_br_tags_0_bits == 4'hC;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_12_1 = io_ren_br_tags_1_bits == 4'hC;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_13_0 = io_ren_br_tags_0_bits == 4'hD;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_13_1 = io_ren_br_tags_1_bits == 4'hD;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_14_0 = io_ren_br_tags_0_bits == 4'hE;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_14_1 = io_ren_br_tags_1_bits == 4'hE;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    if (reset) begin
      free_list <= 100'hFFFFFFFFFFFFFFFFFFFFFFFFE;	// rename-freelist.scala:50:{26,45}
      r_valid <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_1 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_2 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
    end
    else begin
      free_list <=
        (free_list
         & ~(sels_0 & {100{sel_fire_0}} | sels_1 & {100{sel_fire_1}} | sels_2
             & {100{sel_fire_2}}) | dealloc_mask) & 100'hFFFFFFFFFFFFFFFFFFFFFFFFE;	// Bitwise.scala:72:12, Mux.scala:47:69, rename-freelist.scala:50:{26,45}, :62:{60,82}, :64:110, :76:{27,29,39,55}, :85:45
      r_valid <= r_valid & ~io_reqs_0 | (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_1 <= r_valid_1 & ~io_reqs_1 | (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_2 <= r_valid_2 & ~io_reqs_2 | (|sels_2);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
    end
    br_alloc_lists_0 <=
      (|({io_ren_br_tags_2_bits == 4'h0, _list_req_WIRE_1, _list_req_WIRE_0} & br_slots))
        ? (_list_req_WIRE_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_0 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:32:14, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_1 <=
      (|({io_ren_br_tags_2_bits == 4'h1, _list_req_WIRE_1_1, _list_req_WIRE_1_0}
         & br_slots))
        ? (_list_req_WIRE_1_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_1_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_1 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_2 <=
      (|({io_ren_br_tags_2_bits == 4'h2, _list_req_WIRE_2_1, _list_req_WIRE_2_0}
         & br_slots))
        ? (_list_req_WIRE_2_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_2_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_2 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_3 <=
      (|({io_ren_br_tags_2_bits == 4'h3, _list_req_WIRE_3_1, _list_req_WIRE_3_0}
         & br_slots))
        ? (_list_req_WIRE_3_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_3_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_3 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_4 <=
      (|({io_ren_br_tags_2_bits == 4'h4, _list_req_WIRE_4_1, _list_req_WIRE_4_0}
         & br_slots))
        ? (_list_req_WIRE_4_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_4_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_4 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_5 <=
      (|({io_ren_br_tags_2_bits == 4'h5, _list_req_WIRE_5_1, _list_req_WIRE_5_0}
         & br_slots))
        ? (_list_req_WIRE_5_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_5_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_5 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_6 <=
      (|({io_ren_br_tags_2_bits == 4'h6, _list_req_WIRE_6_1, _list_req_WIRE_6_0}
         & br_slots))
        ? (_list_req_WIRE_6_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_6_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_6 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_7 <=
      (|({io_ren_br_tags_2_bits == 4'h7, _list_req_WIRE_7_1, _list_req_WIRE_7_0}
         & br_slots))
        ? (_list_req_WIRE_7_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_7_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_7 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_8 <=
      (|({io_ren_br_tags_2_bits == 4'h8, _list_req_WIRE_8_1, _list_req_WIRE_8_0}
         & br_slots))
        ? (_list_req_WIRE_8_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_8_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_8 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_9 <=
      (|({io_ren_br_tags_2_bits == 4'h9, _list_req_WIRE_9_1, _list_req_WIRE_9_0}
         & br_slots))
        ? (_list_req_WIRE_9_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_9_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_9 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_10 <=
      (|({io_ren_br_tags_2_bits == 4'hA, _list_req_WIRE_10_1, _list_req_WIRE_10_0}
         & br_slots))
        ? (_list_req_WIRE_10_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_10_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_10 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_11 <=
      (|({io_ren_br_tags_2_bits == 4'hB, _list_req_WIRE_11_1, _list_req_WIRE_11_0}
         & br_slots))
        ? (_list_req_WIRE_11_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_11_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_11 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_12 <=
      (|({io_ren_br_tags_2_bits == 4'hC, _list_req_WIRE_12_1, _list_req_WIRE_12_0}
         & br_slots))
        ? (_list_req_WIRE_12_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_12_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_12 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_13 <=
      (|({io_ren_br_tags_2_bits == 4'hD, _list_req_WIRE_13_1, _list_req_WIRE_13_0}
         & br_slots))
        ? (_list_req_WIRE_13_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_13_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_13 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_14 <=
      (|({io_ren_br_tags_2_bits == 4'hE, _list_req_WIRE_14_1, _list_req_WIRE_14_0}
         & br_slots))
        ? (_list_req_WIRE_14_0 & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | (_list_req_WIRE_14_1 & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_14 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_15 <=
      (|({&io_ren_br_tags_2_bits, &io_ren_br_tags_1_bits, &io_ren_br_tags_0_bits}
         & br_slots))
        ? ((&io_ren_br_tags_0_bits) & io_ren_br_tags_0_valid ? _GEN_2 : 100'h0)
          | ((&io_ren_br_tags_1_bits) & io_ren_br_tags_1_valid ? _GEN_1 : 100'h0)
        : br_alloc_lists_15 & ~br_deallocs | _GEN_3;	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    if (sel_fire_0) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T = {28'h0, sels_0[99:65]} | sels_0[63:1];	// Mux.scala:47:69, OneHot.scala:31:18, :32:28, rename-freelist.scala:59:88
      automatic logic [30:0] _r_sel_T_1 = _r_sel_T[62:32] | _r_sel_T[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_2 = _r_sel_T_1[30:16] | _r_sel_T_1[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_3 = _r_sel_T_2[14:8] | _r_sel_T_2[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_4 = _r_sel_T_3[6:4] | _r_sel_T_3[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel <=
        {|(sels_0[99:64]),
         |(_r_sel_T[62:31]),
         |(_r_sel_T_1[30:15]),
         |(_r_sel_T_2[14:7]),
         |(_r_sel_T_3[6:3]),
         |(_r_sel_T_4[2:1]),
         _r_sel_T_4[2] | _r_sel_T_4[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_1) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_7 = {28'h0, sels_1[99:65]} | sels_1[63:1];	// Mux.scala:47:69, OneHot.scala:31:18, :32:28, rename-freelist.scala:59:88
      automatic logic [30:0] _r_sel_T_8 = _r_sel_T_7[62:32] | _r_sel_T_7[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_9 = _r_sel_T_8[30:16] | _r_sel_T_8[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_10 = _r_sel_T_9[14:8] | _r_sel_T_9[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_11 = _r_sel_T_10[6:4] | _r_sel_T_10[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_1 <=
        {|(sels_1[99:64]),
         |(_r_sel_T_7[62:31]),
         |(_r_sel_T_8[30:15]),
         |(_r_sel_T_9[14:7]),
         |(_r_sel_T_10[6:3]),
         |(_r_sel_T_11[2:1]),
         _r_sel_T_11[2] | _r_sel_T_11[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_2) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_14 = {28'h0, sels_2[99:65]} | sels_2[63:1];	// Mux.scala:47:69, OneHot.scala:31:18, :32:28, rename-freelist.scala:59:88
      automatic logic [30:0] _r_sel_T_15 = _r_sel_T_14[62:32] | _r_sel_T_14[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_16 = _r_sel_T_15[30:16] | _r_sel_T_15[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_17 = _r_sel_T_16[14:8] | _r_sel_T_16[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_18 = _r_sel_T_17[6:4] | _r_sel_T_17[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_2 <=
        {|(sels_2[99:64]),
         |(_r_sel_T_14[62:31]),
         |(_r_sel_T_15[30:15]),
         |(_r_sel_T_16[14:7]),
         |(_r_sel_T_17[6:3]),
         |(_r_sel_T_18[2:1]),
         _r_sel_T_18[2] | _r_sel_T_18[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:53];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h36; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        free_list = {_RANDOM[6'h0], _RANDOM[6'h1], _RANDOM[6'h2], _RANDOM[6'h3][3:0]};	// rename-freelist.scala:50:26
        br_alloc_lists_0 =
          {_RANDOM[6'h3][31:4], _RANDOM[6'h4], _RANDOM[6'h5], _RANDOM[6'h6][7:0]};	// rename-freelist.scala:50:26, :51:27
        br_alloc_lists_1 =
          {_RANDOM[6'h6][31:8], _RANDOM[6'h7], _RANDOM[6'h8], _RANDOM[6'h9][11:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_2 =
          {_RANDOM[6'h9][31:12], _RANDOM[6'hA], _RANDOM[6'hB], _RANDOM[6'hC][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_3 =
          {_RANDOM[6'hC][31:16], _RANDOM[6'hD], _RANDOM[6'hE], _RANDOM[6'hF][19:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_4 =
          {_RANDOM[6'hF][31:20], _RANDOM[6'h10], _RANDOM[6'h11], _RANDOM[6'h12][23:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_5 =
          {_RANDOM[6'h12][31:24], _RANDOM[6'h13], _RANDOM[6'h14], _RANDOM[6'h15][27:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_6 =
          {_RANDOM[6'h15][31:28], _RANDOM[6'h16], _RANDOM[6'h17], _RANDOM[6'h18]};	// rename-freelist.scala:51:27
        br_alloc_lists_7 =
          {_RANDOM[6'h19], _RANDOM[6'h1A], _RANDOM[6'h1B], _RANDOM[6'h1C][3:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_8 =
          {_RANDOM[6'h1C][31:4], _RANDOM[6'h1D], _RANDOM[6'h1E], _RANDOM[6'h1F][7:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_9 =
          {_RANDOM[6'h1F][31:8], _RANDOM[6'h20], _RANDOM[6'h21], _RANDOM[6'h22][11:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_10 =
          {_RANDOM[6'h22][31:12], _RANDOM[6'h23], _RANDOM[6'h24], _RANDOM[6'h25][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_11 =
          {_RANDOM[6'h25][31:16], _RANDOM[6'h26], _RANDOM[6'h27], _RANDOM[6'h28][19:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_12 =
          {_RANDOM[6'h28][31:20], _RANDOM[6'h29], _RANDOM[6'h2A], _RANDOM[6'h2B][23:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_13 =
          {_RANDOM[6'h2B][31:24], _RANDOM[6'h2C], _RANDOM[6'h2D], _RANDOM[6'h2E][27:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_14 =
          {_RANDOM[6'h2E][31:28], _RANDOM[6'h2F], _RANDOM[6'h30], _RANDOM[6'h31]};	// rename-freelist.scala:51:27
        br_alloc_lists_15 =
          {_RANDOM[6'h32], _RANDOM[6'h33], _RANDOM[6'h34], _RANDOM[6'h35][3:0]};	// rename-freelist.scala:51:27
        r_valid = _RANDOM[6'h35][4];	// rename-freelist.scala:51:27, :81:26
        r_sel = _RANDOM[6'h35][11:5];	// Reg.scala:15:16, rename-freelist.scala:51:27
        r_valid_1 = _RANDOM[6'h35][12];	// rename-freelist.scala:51:27, :81:26
        r_sel_1 = _RANDOM[6'h35][19:13];	// Reg.scala:15:16, rename-freelist.scala:51:27
        r_valid_2 = _RANDOM[6'h35][20];	// rename-freelist.scala:51:27, :81:26
        r_sel_2 = _RANDOM[6'h35][27:21];	// Reg.scala:15:16, rename-freelist.scala:51:27
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
endmodule

