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

module RenameFreeList_4(
  input        clock,
               reset,
               io_reqs_0,
               io_reqs_1,
               io_dealloc_pregs_0_valid,
  input  [6:0] io_dealloc_pregs_0_bits,
  input        io_dealloc_pregs_1_valid,
  input  [6:0] io_dealloc_pregs_1_bits,
  input        io_ren_br_tags_0_valid,
  input  [3:0] io_ren_br_tags_0_bits,
  input        io_ren_br_tags_1_valid,
  input  [3:0] io_ren_br_tags_1_bits,
               io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_debug_pipeline_empty,
  output       io_alloc_pregs_0_valid,
  output [6:0] io_alloc_pregs_0_bits,
  output       io_alloc_pregs_1_valid,
  output [6:0] io_alloc_pregs_1_bits
);

  reg  [6:0]        r_sel_1;	// Reg.scala:15:16
  reg  [6:0]        r_sel;	// Reg.scala:15:16
  reg  [79:0]       free_list;	// rename-freelist.scala:50:26
  reg  [79:0]       br_alloc_lists_0;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_1;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_2;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_3;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_4;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_5;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_6;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_7;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_8;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_9;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_10;	// rename-freelist.scala:51:27
  reg  [79:0]       br_alloc_lists_11;	// rename-freelist.scala:51:27
  wire [79:0]       sels_0 =
    free_list[0]
      ? 80'h1
      : free_list[1]
          ? 80'h2
          : free_list[2]
              ? 80'h4
              : free_list[3]
                  ? 80'h8
                  : free_list[4]
                      ? 80'h10
                      : free_list[5]
                          ? 80'h20
                          : free_list[6]
                              ? 80'h40
                              : free_list[7]
                                  ? 80'h80
                                  : free_list[8]
                                      ? 80'h100
                                      : free_list[9]
                                          ? 80'h200
                                          : free_list[10]
                                              ? 80'h400
                                              : free_list[11]
                                                  ? 80'h800
                                                  : free_list[12]
                                                      ? 80'h1000
                                                      : free_list[13]
                                                          ? 80'h2000
                                                          : free_list[14]
                                                              ? 80'h4000
                                                              : free_list[15]
                                                                  ? 80'h8000
                                                                  : free_list[16]
                                                                      ? 80'h10000
                                                                      : free_list[17]
                                                                          ? 80'h20000
                                                                          : free_list[18]
                                                                              ? 80'h40000
                                                                              : free_list[19]
                                                                                  ? 80'h80000
                                                                                  : free_list[20]
                                                                                      ? 80'h100000
                                                                                      : free_list[21]
                                                                                          ? 80'h200000
                                                                                          : free_list[22]
                                                                                              ? 80'h400000
                                                                                              : free_list[23]
                                                                                                  ? 80'h800000
                                                                                                  : free_list[24]
                                                                                                      ? 80'h1000000
                                                                                                      : free_list[25]
                                                                                                          ? 80'h2000000
                                                                                                          : free_list[26]
                                                                                                              ? 80'h4000000
                                                                                                              : free_list[27]
                                                                                                                  ? 80'h8000000
                                                                                                                  : free_list[28]
                                                                                                                      ? 80'h10000000
                                                                                                                      : free_list[29]
                                                                                                                          ? 80'h20000000
                                                                                                                          : free_list[30]
                                                                                                                              ? 80'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                  ? 80'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                      ? 80'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                          ? 80'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                              ? 80'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                  ? 80'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                      ? 80'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                          ? 80'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                              ? 80'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                  ? 80'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                      ? 80'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                          ? 80'h20000000000
                                                                                                                                                                          : free_list[42]
                                                                                                                                                                              ? 80'h40000000000
                                                                                                                                                                              : free_list[43]
                                                                                                                                                                                  ? 80'h80000000000
                                                                                                                                                                                  : free_list[44]
                                                                                                                                                                                      ? 80'h100000000000
                                                                                                                                                                                      : free_list[45]
                                                                                                                                                                                          ? 80'h200000000000
                                                                                                                                                                                          : free_list[46]
                                                                                                                                                                                              ? 80'h400000000000
                                                                                                                                                                                              : free_list[47]
                                                                                                                                                                                                  ? 80'h800000000000
                                                                                                                                                                                                  : free_list[48]
                                                                                                                                                                                                      ? 80'h1000000000000
                                                                                                                                                                                                      : free_list[49]
                                                                                                                                                                                                          ? 80'h2000000000000
                                                                                                                                                                                                          : free_list[50]
                                                                                                                                                                                                              ? 80'h4000000000000
                                                                                                                                                                                                              : free_list[51]
                                                                                                                                                                                                                  ? 80'h8000000000000
                                                                                                                                                                                                                  : free_list[52]
                                                                                                                                                                                                                      ? 80'h10000000000000
                                                                                                                                                                                                                      : free_list[53]
                                                                                                                                                                                                                          ? 80'h20000000000000
                                                                                                                                                                                                                          : free_list[54]
                                                                                                                                                                                                                              ? 80'h40000000000000
                                                                                                                                                                                                                              : free_list[55]
                                                                                                                                                                                                                                  ? 80'h80000000000000
                                                                                                                                                                                                                                  : free_list[56]
                                                                                                                                                                                                                                      ? 80'h100000000000000
                                                                                                                                                                                                                                      : free_list[57]
                                                                                                                                                                                                                                          ? 80'h200000000000000
                                                                                                                                                                                                                                          : free_list[58]
                                                                                                                                                                                                                                              ? 80'h400000000000000
                                                                                                                                                                                                                                              : free_list[59]
                                                                                                                                                                                                                                                  ? 80'h800000000000000
                                                                                                                                                                                                                                                  : free_list[60]
                                                                                                                                                                                                                                                      ? 80'h1000000000000000
                                                                                                                                                                                                                                                      : free_list[61]
                                                                                                                                                                                                                                                          ? 80'h2000000000000000
                                                                                                                                                                                                                                                          : free_list[62]
                                                                                                                                                                                                                                                              ? 80'h4000000000000000
                                                                                                                                                                                                                                                              : free_list[63]
                                                                                                                                                                                                                                                                  ? 80'h8000000000000000
                                                                                                                                                                                                                                                                  : free_list[64]
                                                                                                                                                                                                                                                                      ? 80'h10000000000000000
                                                                                                                                                                                                                                                                      : free_list[65]
                                                                                                                                                                                                                                                                          ? 80'h20000000000000000
                                                                                                                                                                                                                                                                          : free_list[66]
                                                                                                                                                                                                                                                                              ? 80'h40000000000000000
                                                                                                                                                                                                                                                                              : free_list[67]
                                                                                                                                                                                                                                                                                  ? 80'h80000000000000000
                                                                                                                                                                                                                                                                                  : free_list[68]
                                                                                                                                                                                                                                                                                      ? 80'h100000000000000000
                                                                                                                                                                                                                                                                                      : free_list[69]
                                                                                                                                                                                                                                                                                          ? 80'h200000000000000000
                                                                                                                                                                                                                                                                                          : free_list[70]
                                                                                                                                                                                                                                                                                              ? 80'h400000000000000000
                                                                                                                                                                                                                                                                                              : free_list[71]
                                                                                                                                                                                                                                                                                                  ? 80'h800000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[72]
                                                                                                                                                                                                                                                                                                      ? 80'h1000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[73]
                                                                                                                                                                                                                                                                                                          ? 80'h2000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[74]
                                                                                                                                                                                                                                                                                                              ? 80'h4000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[75]
                                                                                                                                                                                                                                                                                                                  ? 80'h8000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[76]
                                                                                                                                                                                                                                                                                                                      ? 80'h10000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[77]
                                                                                                                                                                                                                                                                                                                          ? 80'h20000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[78]
                                                                                                                                                                                                                                                                                                                              ? 80'h40000000000000000000
                                                                                                                                                                                                                                                                                                                              : {free_list[79],
                                                                                                                                                                                                                                                                                                                                 79'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}
  wire [79:0]       _sels_T = ~sels_0;	// Mux.scala:47:69, util.scala:410:21
  wire [79:0]       sels_1 =
    free_list[0] & _sels_T[0]
      ? 80'h1
      : free_list[1] & _sels_T[1]
          ? 80'h2
          : free_list[2] & _sels_T[2]
              ? 80'h4
              : free_list[3] & _sels_T[3]
                  ? 80'h8
                  : free_list[4] & _sels_T[4]
                      ? 80'h10
                      : free_list[5] & _sels_T[5]
                          ? 80'h20
                          : free_list[6] & _sels_T[6]
                              ? 80'h40
                              : free_list[7] & _sels_T[7]
                                  ? 80'h80
                                  : free_list[8] & _sels_T[8]
                                      ? 80'h100
                                      : free_list[9] & _sels_T[9]
                                          ? 80'h200
                                          : free_list[10] & _sels_T[10]
                                              ? 80'h400
                                              : free_list[11] & _sels_T[11]
                                                  ? 80'h800
                                                  : free_list[12] & _sels_T[12]
                                                      ? 80'h1000
                                                      : free_list[13] & _sels_T[13]
                                                          ? 80'h2000
                                                          : free_list[14] & _sels_T[14]
                                                              ? 80'h4000
                                                              : free_list[15]
                                                                & _sels_T[15]
                                                                  ? 80'h8000
                                                                  : free_list[16]
                                                                    & _sels_T[16]
                                                                      ? 80'h10000
                                                                      : free_list[17]
                                                                        & _sels_T[17]
                                                                          ? 80'h20000
                                                                          : free_list[18]
                                                                            & _sels_T[18]
                                                                              ? 80'h40000
                                                                              : free_list[19]
                                                                                & _sels_T[19]
                                                                                  ? 80'h80000
                                                                                  : free_list[20]
                                                                                    & _sels_T[20]
                                                                                      ? 80'h100000
                                                                                      : free_list[21]
                                                                                        & _sels_T[21]
                                                                                          ? 80'h200000
                                                                                          : free_list[22]
                                                                                            & _sels_T[22]
                                                                                              ? 80'h400000
                                                                                              : free_list[23]
                                                                                                & _sels_T[23]
                                                                                                  ? 80'h800000
                                                                                                  : free_list[24]
                                                                                                    & _sels_T[24]
                                                                                                      ? 80'h1000000
                                                                                                      : free_list[25]
                                                                                                        & _sels_T[25]
                                                                                                          ? 80'h2000000
                                                                                                          : free_list[26]
                                                                                                            & _sels_T[26]
                                                                                                              ? 80'h4000000
                                                                                                              : free_list[27]
                                                                                                                & _sels_T[27]
                                                                                                                  ? 80'h8000000
                                                                                                                  : free_list[28]
                                                                                                                    & _sels_T[28]
                                                                                                                      ? 80'h10000000
                                                                                                                      : free_list[29]
                                                                                                                        & _sels_T[29]
                                                                                                                          ? 80'h20000000
                                                                                                                          : free_list[30]
                                                                                                                            & _sels_T[30]
                                                                                                                              ? 80'h40000000
                                                                                                                              : free_list[31]
                                                                                                                                & _sels_T[31]
                                                                                                                                  ? 80'h80000000
                                                                                                                                  : free_list[32]
                                                                                                                                    & _sels_T[32]
                                                                                                                                      ? 80'h100000000
                                                                                                                                      : free_list[33]
                                                                                                                                        & _sels_T[33]
                                                                                                                                          ? 80'h200000000
                                                                                                                                          : free_list[34]
                                                                                                                                            & _sels_T[34]
                                                                                                                                              ? 80'h400000000
                                                                                                                                              : free_list[35]
                                                                                                                                                & _sels_T[35]
                                                                                                                                                  ? 80'h800000000
                                                                                                                                                  : free_list[36]
                                                                                                                                                    & _sels_T[36]
                                                                                                                                                      ? 80'h1000000000
                                                                                                                                                      : free_list[37]
                                                                                                                                                        & _sels_T[37]
                                                                                                                                                          ? 80'h2000000000
                                                                                                                                                          : free_list[38]
                                                                                                                                                            & _sels_T[38]
                                                                                                                                                              ? 80'h4000000000
                                                                                                                                                              : free_list[39]
                                                                                                                                                                & _sels_T[39]
                                                                                                                                                                  ? 80'h8000000000
                                                                                                                                                                  : free_list[40]
                                                                                                                                                                    & _sels_T[40]
                                                                                                                                                                      ? 80'h10000000000
                                                                                                                                                                      : free_list[41]
                                                                                                                                                                        & _sels_T[41]
                                                                                                                                                                          ? 80'h20000000000
                                                                                                                                                                          : free_list[42]
                                                                                                                                                                            & _sels_T[42]
                                                                                                                                                                              ? 80'h40000000000
                                                                                                                                                                              : free_list[43]
                                                                                                                                                                                & _sels_T[43]
                                                                                                                                                                                  ? 80'h80000000000
                                                                                                                                                                                  : free_list[44]
                                                                                                                                                                                    & _sels_T[44]
                                                                                                                                                                                      ? 80'h100000000000
                                                                                                                                                                                      : free_list[45]
                                                                                                                                                                                        & _sels_T[45]
                                                                                                                                                                                          ? 80'h200000000000
                                                                                                                                                                                          : free_list[46]
                                                                                                                                                                                            & _sels_T[46]
                                                                                                                                                                                              ? 80'h400000000000
                                                                                                                                                                                              : free_list[47]
                                                                                                                                                                                                & _sels_T[47]
                                                                                                                                                                                                  ? 80'h800000000000
                                                                                                                                                                                                  : free_list[48]
                                                                                                                                                                                                    & _sels_T[48]
                                                                                                                                                                                                      ? 80'h1000000000000
                                                                                                                                                                                                      : free_list[49]
                                                                                                                                                                                                        & _sels_T[49]
                                                                                                                                                                                                          ? 80'h2000000000000
                                                                                                                                                                                                          : free_list[50]
                                                                                                                                                                                                            & _sels_T[50]
                                                                                                                                                                                                              ? 80'h4000000000000
                                                                                                                                                                                                              : free_list[51]
                                                                                                                                                                                                                & _sels_T[51]
                                                                                                                                                                                                                  ? 80'h8000000000000
                                                                                                                                                                                                                  : free_list[52]
                                                                                                                                                                                                                    & _sels_T[52]
                                                                                                                                                                                                                      ? 80'h10000000000000
                                                                                                                                                                                                                      : free_list[53]
                                                                                                                                                                                                                        & _sels_T[53]
                                                                                                                                                                                                                          ? 80'h20000000000000
                                                                                                                                                                                                                          : free_list[54]
                                                                                                                                                                                                                            & _sels_T[54]
                                                                                                                                                                                                                              ? 80'h40000000000000
                                                                                                                                                                                                                              : free_list[55]
                                                                                                                                                                                                                                & _sels_T[55]
                                                                                                                                                                                                                                  ? 80'h80000000000000
                                                                                                                                                                                                                                  : free_list[56]
                                                                                                                                                                                                                                    & _sels_T[56]
                                                                                                                                                                                                                                      ? 80'h100000000000000
                                                                                                                                                                                                                                      : free_list[57]
                                                                                                                                                                                                                                        & _sels_T[57]
                                                                                                                                                                                                                                          ? 80'h200000000000000
                                                                                                                                                                                                                                          : free_list[58]
                                                                                                                                                                                                                                            & _sels_T[58]
                                                                                                                                                                                                                                              ? 80'h400000000000000
                                                                                                                                                                                                                                              : free_list[59]
                                                                                                                                                                                                                                                & _sels_T[59]
                                                                                                                                                                                                                                                  ? 80'h800000000000000
                                                                                                                                                                                                                                                  : free_list[60]
                                                                                                                                                                                                                                                    & _sels_T[60]
                                                                                                                                                                                                                                                      ? 80'h1000000000000000
                                                                                                                                                                                                                                                      : free_list[61]
                                                                                                                                                                                                                                                        & _sels_T[61]
                                                                                                                                                                                                                                                          ? 80'h2000000000000000
                                                                                                                                                                                                                                                          : free_list[62]
                                                                                                                                                                                                                                                            & _sels_T[62]
                                                                                                                                                                                                                                                              ? 80'h4000000000000000
                                                                                                                                                                                                                                                              : free_list[63]
                                                                                                                                                                                                                                                                & _sels_T[63]
                                                                                                                                                                                                                                                                  ? 80'h8000000000000000
                                                                                                                                                                                                                                                                  : free_list[64]
                                                                                                                                                                                                                                                                    & _sels_T[64]
                                                                                                                                                                                                                                                                      ? 80'h10000000000000000
                                                                                                                                                                                                                                                                      : free_list[65]
                                                                                                                                                                                                                                                                        & _sels_T[65]
                                                                                                                                                                                                                                                                          ? 80'h20000000000000000
                                                                                                                                                                                                                                                                          : free_list[66]
                                                                                                                                                                                                                                                                            & _sels_T[66]
                                                                                                                                                                                                                                                                              ? 80'h40000000000000000
                                                                                                                                                                                                                                                                              : free_list[67]
                                                                                                                                                                                                                                                                                & _sels_T[67]
                                                                                                                                                                                                                                                                                  ? 80'h80000000000000000
                                                                                                                                                                                                                                                                                  : free_list[68]
                                                                                                                                                                                                                                                                                    & _sels_T[68]
                                                                                                                                                                                                                                                                                      ? 80'h100000000000000000
                                                                                                                                                                                                                                                                                      : free_list[69]
                                                                                                                                                                                                                                                                                        & _sels_T[69]
                                                                                                                                                                                                                                                                                          ? 80'h200000000000000000
                                                                                                                                                                                                                                                                                          : free_list[70]
                                                                                                                                                                                                                                                                                            & _sels_T[70]
                                                                                                                                                                                                                                                                                              ? 80'h400000000000000000
                                                                                                                                                                                                                                                                                              : free_list[71]
                                                                                                                                                                                                                                                                                                & _sels_T[71]
                                                                                                                                                                                                                                                                                                  ? 80'h800000000000000000
                                                                                                                                                                                                                                                                                                  : free_list[72]
                                                                                                                                                                                                                                                                                                    & _sels_T[72]
                                                                                                                                                                                                                                                                                                      ? 80'h1000000000000000000
                                                                                                                                                                                                                                                                                                      : free_list[73]
                                                                                                                                                                                                                                                                                                        & _sels_T[73]
                                                                                                                                                                                                                                                                                                          ? 80'h2000000000000000000
                                                                                                                                                                                                                                                                                                          : free_list[74]
                                                                                                                                                                                                                                                                                                            & _sels_T[74]
                                                                                                                                                                                                                                                                                                              ? 80'h4000000000000000000
                                                                                                                                                                                                                                                                                                              : free_list[75]
                                                                                                                                                                                                                                                                                                                & _sels_T[75]
                                                                                                                                                                                                                                                                                                                  ? 80'h8000000000000000000
                                                                                                                                                                                                                                                                                                                  : free_list[76]
                                                                                                                                                                                                                                                                                                                    & _sels_T[76]
                                                                                                                                                                                                                                                                                                                      ? 80'h10000000000000000000
                                                                                                                                                                                                                                                                                                                      : free_list[77]
                                                                                                                                                                                                                                                                                                                        & _sels_T[77]
                                                                                                                                                                                                                                                                                                                          ? 80'h20000000000000000000
                                                                                                                                                                                                                                                                                                                          : free_list[78]
                                                                                                                                                                                                                                                                                                                            & _sels_T[78]
                                                                                                                                                                                                                                                                                                                              ? 80'h40000000000000000000
                                                                                                                                                                                                                                                                                                                              : {free_list[79]
                                                                                                                                                                                                                                                                                                                                   & _sels_T[79],
                                                                                                                                                                                                                                                                                                                                 79'h0};	// Mux.scala:47:69, OneHot.scala:85:71, rename-freelist.scala:50:{26,45}, util.scala:410:{19,21}
  wire [127:0]      allocs_0 = 128'h1 << r_sel;	// OneHot.scala:58:35, Reg.scala:15:16
  wire [127:0]      allocs_1 = 128'h1 << r_sel_1;	// OneHot.scala:58:35, Reg.scala:15:16
  wire [15:0][79:0] _GEN =
    {{br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
     {br_alloc_lists_0},
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
  wire [79:0]       br_deallocs =
    _GEN[io_brupdate_b2_uop_br_tag] & {80{io_brupdate_b2_mispredict}};	// Bitwise.scala:72:12, rename-freelist.scala:63:63
  wire [127:0]      _dealloc_mask_T = 128'h1 << io_dealloc_pregs_0_bits;	// OneHot.scala:58:35
  wire [127:0]      _dealloc_mask_T_5 = 128'h1 << io_dealloc_pregs_1_bits;	// OneHot.scala:58:35
  wire [79:0]       dealloc_mask =
    _dealloc_mask_T[79:0] & {80{io_dealloc_pregs_0_valid}} | _dealloc_mask_T_5[79:0]
    & {80{io_dealloc_pregs_1_valid}} | br_deallocs;	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:63:63, :64:{64,79,110}
  reg               r_valid;	// rename-freelist.scala:81:26
  wire              sel_fire_0 = (~r_valid | io_reqs_0) & (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  reg               r_valid_1;	// rename-freelist.scala:81:26
  wire              sel_fire_1 = (~r_valid_1 | io_reqs_1) & (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :85:{21,30,45}
  `ifndef SYNTHESIS	// rename-freelist.scala:94:10
    always @(posedge clock) begin	// rename-freelist.scala:94:10
      automatic logic [79:0] _GEN_0;	// rename-freelist.scala:91:34
      _GEN_0 =
        free_list | allocs_0[79:0] & {80{r_valid}} | allocs_1[79:0] & {80{r_valid_1}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:50:26, :59:88, :81:26, :91:{34,77}
      if (~((_GEN_0 & dealloc_mask) == 80'h0 | reset)) begin	// Mux.scala:47:69, rename-freelist.scala:64:110, :91:34, :94:{10,31,47}
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
                  {1'h0, {1'h0, _GEN_0[0]} + {1'h0, _GEN_0[1]}}
                    + {1'h0, {1'h0, _GEN_0[2]} + {1'h0, _GEN_0[3]} + {1'h0, _GEN_0[4]}}}
                   + {1'h0,
                      {1'h0, {1'h0, _GEN_0[5]} + {1'h0, _GEN_0[6]}}
                        + {1'h0,
                           {1'h0, _GEN_0[7]} + {1'h0, _GEN_0[8]} + {1'h0, _GEN_0[9]}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[10]} + {1'h0, _GEN_0[11]}}
                        + {1'h0,
                           {1'h0, _GEN_0[12]} + {1'h0, _GEN_0[13]} + {1'h0, _GEN_0[14]}}}
                       + {1'h0,
                          {1'h0, {1'h0, _GEN_0[15]} + {1'h0, _GEN_0[16]}}
                            + {1'h0,
                               {1'h0, _GEN_0[17]} + {1'h0, _GEN_0[18]}
                                 + {1'h0, _GEN_0[19]}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[20]} + {1'h0, _GEN_0[21]}}
                        + {1'h0,
                           {1'h0, _GEN_0[22]} + {1'h0, _GEN_0[23]} + {1'h0, _GEN_0[24]}}}
                       + {1'h0,
                          {1'h0, {1'h0, _GEN_0[25]} + {1'h0, _GEN_0[26]}}
                            + {1'h0,
                               {1'h0, _GEN_0[27]} + {1'h0, _GEN_0[28]}
                                 + {1'h0, _GEN_0[29]}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0, {1'h0, _GEN_0[30]} + {1'h0, _GEN_0[31]}}
                            + {1'h0,
                               {1'h0, _GEN_0[32]} + {1'h0, _GEN_0[33]}
                                 + {1'h0, _GEN_0[34]}}}
                           + {1'h0,
                              {1'h0, {1'h0, _GEN_0[35]} + {1'h0, _GEN_0[36]}}
                                + {1'h0,
                                   {1'h0, _GEN_0[37]} + {1'h0, _GEN_0[38]}
                                     + {1'h0, _GEN_0[39]}}}}}}
            + {1'h0,
               {1'h0,
                {1'h0,
                 {1'h0,
                  {1'h0, {1'h0, _GEN_0[40]} + {1'h0, _GEN_0[41]}}
                    + {1'h0,
                       {1'h0, _GEN_0[42]} + {1'h0, _GEN_0[43]} + {1'h0, _GEN_0[44]}}}
                   + {1'h0,
                      {1'h0, {1'h0, _GEN_0[45]} + {1'h0, _GEN_0[46]}}
                        + {1'h0,
                           {1'h0, _GEN_0[47]} + {1'h0, _GEN_0[48]} + {1'h0, _GEN_0[49]}}}}
                  + {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[50]} + {1'h0, _GEN_0[51]}}
                        + {1'h0,
                           {1'h0, _GEN_0[52]} + {1'h0, _GEN_0[53]} + {1'h0, _GEN_0[54]}}}
                       + {1'h0,
                          {1'h0, {1'h0, _GEN_0[55]} + {1'h0, _GEN_0[56]}}
                            + {1'h0,
                               {1'h0, _GEN_0[57]} + {1'h0, _GEN_0[58]}
                                 + {1'h0, _GEN_0[59]}}}}}
                 + {1'h0,
                    {1'h0,
                     {1'h0,
                      {1'h0, {1'h0, _GEN_0[60]} + {1'h0, _GEN_0[61]}}
                        + {1'h0,
                           {1'h0, _GEN_0[62]} + {1'h0, _GEN_0[63]} + {1'h0, _GEN_0[64]}}}
                       + {1'h0,
                          {1'h0, {1'h0, _GEN_0[65]} + {1'h0, _GEN_0[66]}}
                            + {1'h0,
                               {1'h0, _GEN_0[67]} + {1'h0, _GEN_0[68]}
                                 + {1'h0, _GEN_0[69]}}}}
                      + {1'h0,
                         {1'h0,
                          {1'h0, {1'h0, _GEN_0[70]} + {1'h0, _GEN_0[71]}}
                            + {1'h0,
                               {1'h0, _GEN_0[72]} + {1'h0, _GEN_0[73]}
                                 + {1'h0, _GEN_0[74]}}}
                           + {1'h0,
                              {1'h0, {1'h0, _GEN_0[75]} + {1'h0, _GEN_0[76]}}
                                + {1'h0,
                                   {1'h0, _GEN_0[77]} + {1'h0, _GEN_0[78]}
                                     + {1'h0, _GEN_0[79]}}}}}} > 7'h2F | reset)) begin	// Bitwise.scala:47:55, :49:65, rename-freelist.scala:51:27, :91:34, :95:{10,11,67}
        if (`ASSERT_VERBOSE_COND_)	// rename-freelist.scala:95:10
          $error("Assertion failed: [freelist] Leaking physical registers.\n    at rename-freelist.scala:95 assert (!io.debug.pipeline_empty || PopCount(io.debug.freelist) >= (numPregs - numLregs - 1).U,\n");	// rename-freelist.scala:95:10
        if (`STOP_COND_)	// rename-freelist.scala:95:10
          $fatal;	// rename-freelist.scala:95:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [79:0] _GEN_1 = allocs_1[79:0] & {80{io_reqs_1}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:88
    automatic logic [79:0] _GEN_2 = _GEN_1 | allocs_0[79:0] & {80{io_reqs_0}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-freelist.scala:59:{84,88}
    automatic logic [1:0]  br_slots = {io_ren_br_tags_1_valid, io_ren_br_tags_0_valid};	// rename-freelist.scala:66:64
    automatic logic        _list_req_WIRE_0 = io_ren_br_tags_0_bits == 4'h0;	// rename-freelist.scala:63:63, :69:72
    automatic logic        _list_req_WIRE_1_0 = io_ren_br_tags_0_bits == 4'h1;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_2_0 = io_ren_br_tags_0_bits == 4'h2;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_3_0 = io_ren_br_tags_0_bits == 4'h3;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_4_0 = io_ren_br_tags_0_bits == 4'h4;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_5_0 = io_ren_br_tags_0_bits == 4'h5;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_6_0 = io_ren_br_tags_0_bits == 4'h6;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_7_0 = io_ren_br_tags_0_bits == 4'h7;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_8_0 = io_ren_br_tags_0_bits == 4'h8;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_9_0 = io_ren_br_tags_0_bits == 4'h9;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_10_0 = io_ren_br_tags_0_bits == 4'hA;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    automatic logic        _list_req_WIRE_11_0 = io_ren_br_tags_0_bits == 4'hB;	// OneHot.scala:58:35, rename-freelist.scala:69:72
    if (reset) begin
      free_list <= 80'hFFFFFFFFFFFFFFFFFFFE;	// rename-freelist.scala:50:{26,45}
      r_valid <= 1'h0;	// rename-freelist.scala:51:27, :81:26
      r_valid_1 <= 1'h0;	// rename-freelist.scala:51:27, :81:26
    end
    else begin
      free_list <=
        (free_list & ~(sels_0 & {80{sel_fire_0}} | sels_1 & {80{sel_fire_1}})
         | dealloc_mask) & 80'hFFFFFFFFFFFFFFFFFFFE;	// Bitwise.scala:72:12, Mux.scala:47:69, rename-freelist.scala:50:{26,45}, :62:{60,82}, :64:110, :76:{27,29,39,55}, :85:45
      r_valid <= r_valid & ~io_reqs_0 | (|sels_0);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
      r_valid_1 <= r_valid_1 & ~io_reqs_1 | (|sels_1);	// Mux.scala:47:69, rename-freelist.scala:80:27, :81:26, :84:{24,27,39}
    end
    br_alloc_lists_0 <=
      (|({io_ren_br_tags_1_bits == 4'h0, _list_req_WIRE_0} & br_slots))
        ? (_list_req_WIRE_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_0 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_1 <=
      (|({io_ren_br_tags_1_bits == 4'h1, _list_req_WIRE_1_0} & br_slots))
        ? (_list_req_WIRE_1_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_1 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_2 <=
      (|({io_ren_br_tags_1_bits == 4'h2, _list_req_WIRE_2_0} & br_slots))
        ? (_list_req_WIRE_2_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_2 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_3 <=
      (|({io_ren_br_tags_1_bits == 4'h3, _list_req_WIRE_3_0} & br_slots))
        ? (_list_req_WIRE_3_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_3 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_4 <=
      (|({io_ren_br_tags_1_bits == 4'h4, _list_req_WIRE_4_0} & br_slots))
        ? (_list_req_WIRE_4_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_4 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_5 <=
      (|({io_ren_br_tags_1_bits == 4'h5, _list_req_WIRE_5_0} & br_slots))
        ? (_list_req_WIRE_5_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_5 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_6 <=
      (|({io_ren_br_tags_1_bits == 4'h6, _list_req_WIRE_6_0} & br_slots))
        ? (_list_req_WIRE_6_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_6 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_7 <=
      (|({io_ren_br_tags_1_bits == 4'h7, _list_req_WIRE_7_0} & br_slots))
        ? (_list_req_WIRE_7_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_7 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_8 <=
      (|({io_ren_br_tags_1_bits == 4'h8, _list_req_WIRE_8_0} & br_slots))
        ? (_list_req_WIRE_8_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_8 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_9 <=
      (|({io_ren_br_tags_1_bits == 4'h9, _list_req_WIRE_9_0} & br_slots))
        ? (_list_req_WIRE_9_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_9 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_10 <=
      (|({io_ren_br_tags_1_bits == 4'hA, _list_req_WIRE_10_0} & br_slots))
        ? (_list_req_WIRE_10_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_10 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    br_alloc_lists_11 <=
      (|({io_ren_br_tags_1_bits == 4'hB, _list_req_WIRE_11_0} & br_slots))
        ? (_list_req_WIRE_11_0 & io_ren_br_tags_0_valid ? _GEN_1 : 80'h0)
        : br_alloc_lists_11 & ~br_deallocs | _GEN_2;	// Mux.scala:27:72, :29:36, :47:69, OneHot.scala:58:35, rename-freelist.scala:51:27, :59:{84,88}, :63:63, :66:64, :69:{72,78,85}, :70:29, :71:29, :72:{58,60,73}
    if (sel_fire_0) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T = {48'h0, sels_0[79:65]} | sels_0[63:1];	// Mux.scala:47:69, OneHot.scala:31:18, :32:28, rename-freelist.scala:59:88
      automatic logic [30:0] _r_sel_T_1 = _r_sel_T[62:32] | _r_sel_T[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_2 = _r_sel_T_1[30:16] | _r_sel_T_1[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_3 = _r_sel_T_2[14:8] | _r_sel_T_2[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_4 = _r_sel_T_3[6:4] | _r_sel_T_3[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel <=
        {|(sels_0[79:64]),
         |(_r_sel_T[62:31]),
         |(_r_sel_T_1[30:15]),
         |(_r_sel_T_2[14:7]),
         |(_r_sel_T_3[6:3]),
         |(_r_sel_T_4[2:1]),
         _r_sel_T_4[2] | _r_sel_T_4[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
    if (sel_fire_1) begin	// rename-freelist.scala:85:45
      automatic logic [62:0] _r_sel_T_7 = {48'h0, sels_1[79:65]} | sels_1[63:1];	// Mux.scala:47:69, OneHot.scala:31:18, :32:28, rename-freelist.scala:59:88
      automatic logic [30:0] _r_sel_T_8 = _r_sel_T_7[62:32] | _r_sel_T_7[30:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [14:0] _r_sel_T_9 = _r_sel_T_8[30:16] | _r_sel_T_8[14:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [6:0]  _r_sel_T_10 = _r_sel_T_9[14:8] | _r_sel_T_9[6:0];	// OneHot.scala:30:18, :31:18, :32:28
      automatic logic [2:0]  _r_sel_T_11 = _r_sel_T_10[6:4] | _r_sel_T_10[2:0];	// OneHot.scala:30:18, :31:18, :32:28
      r_sel_1 <=
        {|(sels_1[79:64]),
         |(_r_sel_T_7[62:31]),
         |(_r_sel_T_8[30:15]),
         |(_r_sel_T_9[14:7]),
         |(_r_sel_T_10[6:3]),
         |(_r_sel_T_11[2:1]),
         _r_sel_T_11[2] | _r_sel_T_11[0]};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:30:18, :31:18, :32:{14,28}, Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:32];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h21; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        free_list = {_RANDOM[6'h0], _RANDOM[6'h1], _RANDOM[6'h2][15:0]};	// rename-freelist.scala:50:26
        br_alloc_lists_0 = {_RANDOM[6'h2][31:16], _RANDOM[6'h3], _RANDOM[6'h4]};	// rename-freelist.scala:50:26, :51:27
        br_alloc_lists_1 = {_RANDOM[6'h5], _RANDOM[6'h6], _RANDOM[6'h7][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_2 = {_RANDOM[6'h7][31:16], _RANDOM[6'h8], _RANDOM[6'h9]};	// rename-freelist.scala:51:27
        br_alloc_lists_3 = {_RANDOM[6'hA], _RANDOM[6'hB], _RANDOM[6'hC][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_4 = {_RANDOM[6'hC][31:16], _RANDOM[6'hD], _RANDOM[6'hE]};	// rename-freelist.scala:51:27
        br_alloc_lists_5 = {_RANDOM[6'hF], _RANDOM[6'h10], _RANDOM[6'h11][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_6 = {_RANDOM[6'h11][31:16], _RANDOM[6'h12], _RANDOM[6'h13]};	// rename-freelist.scala:51:27
        br_alloc_lists_7 = {_RANDOM[6'h14], _RANDOM[6'h15], _RANDOM[6'h16][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_8 = {_RANDOM[6'h16][31:16], _RANDOM[6'h17], _RANDOM[6'h18]};	// rename-freelist.scala:51:27
        br_alloc_lists_9 = {_RANDOM[6'h19], _RANDOM[6'h1A], _RANDOM[6'h1B][15:0]};	// rename-freelist.scala:51:27
        br_alloc_lists_10 = {_RANDOM[6'h1B][31:16], _RANDOM[6'h1C], _RANDOM[6'h1D]};	// rename-freelist.scala:51:27
        br_alloc_lists_11 = {_RANDOM[6'h1E], _RANDOM[6'h1F], _RANDOM[6'h20][15:0]};	// rename-freelist.scala:51:27
        r_valid = _RANDOM[6'h20][16];	// rename-freelist.scala:51:27, :81:26
        r_sel = _RANDOM[6'h20][23:17];	// Reg.scala:15:16, rename-freelist.scala:51:27
        r_valid_1 = _RANDOM[6'h20][24];	// rename-freelist.scala:51:27, :81:26
        r_sel_1 = _RANDOM[6'h20][31:25];	// Reg.scala:15:16, rename-freelist.scala:51:27
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
endmodule

