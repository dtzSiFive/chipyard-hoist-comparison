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

module ForwardingAgeLogic_2(
  input  [23:0] io_addr_matches,
  input  [4:0]  io_youngest_st_idx,
  output [4:0]  io_forwarding_idx
);

  wire [23:0] matches_hi_1 =
    io_addr_matches
    & {&(io_youngest_st_idx[4:3]),
       io_youngest_st_idx > 5'h16,
       io_youngest_st_idx > 5'h15,
       io_youngest_st_idx > 5'h14,
       io_youngest_st_idx > 5'h13,
       io_youngest_st_idx > 5'h12,
       io_youngest_st_idx > 5'h11,
       io_youngest_st_idx > 5'h10,
       io_youngest_st_idx[4],
       io_youngest_st_idx > 5'hE,
       io_youngest_st_idx > 5'hD,
       io_youngest_st_idx > 5'hC,
       io_youngest_st_idx > 5'hB,
       io_youngest_st_idx > 5'hA,
       io_youngest_st_idx > 5'h9,
       io_youngest_st_idx > 5'h8,
       |(io_youngest_st_idx[4:3]),
       io_youngest_st_idx > 5'h6,
       io_youngest_st_idx > 5'h5,
       io_youngest_st_idx > 5'h4,
       |(io_youngest_st_idx[4:2]),
       io_youngest_st_idx > 5'h2,
       |(io_youngest_st_idx[4:1]),
       |io_youngest_st_idx};	// lsu.scala:1691:17, :1699:{35,46}, :1712:28
  assign io_forwarding_idx =
    matches_hi_1[23]
      ? 5'h17
      : matches_hi_1[22]
          ? 5'h16
          : matches_hi_1[21]
              ? 5'h15
              : matches_hi_1[20]
                  ? 5'h14
                  : matches_hi_1[19]
                      ? 5'h13
                      : matches_hi_1[18]
                          ? 5'h12
                          : matches_hi_1[17]
                              ? 5'h11
                              : matches_hi_1[16]
                                  ? 5'h10
                                  : matches_hi_1[15]
                                      ? 5'hF
                                      : matches_hi_1[14]
                                          ? 5'hE
                                          : matches_hi_1[13]
                                              ? 5'hD
                                              : matches_hi_1[12]
                                                  ? 5'hC
                                                  : matches_hi_1[11]
                                                      ? 5'hB
                                                      : matches_hi_1[10]
                                                          ? 5'hA
                                                          : matches_hi_1[9]
                                                              ? 5'h9
                                                              : matches_hi_1[8]
                                                                  ? 5'h8
                                                                  : matches_hi_1[7]
                                                                      ? 5'h7
                                                                      : matches_hi_1[6]
                                                                          ? 5'h6
                                                                          : matches_hi_1[5]
                                                                              ? 5'h5
                                                                              : matches_hi_1[4]
                                                                                  ? 5'h4
                                                                                  : matches_hi_1[3]
                                                                                      ? 5'h3
                                                                                      : matches_hi_1[2]
                                                                                          ? 5'h2
                                                                                          : matches_hi_1[1]
                                                                                              ? 5'h1
                                                                                              : matches_hi_1[0]
                                                                                                  ? 5'h0
                                                                                                  : io_addr_matches[23]
                                                                                                      ? 5'h17
                                                                                                      : io_addr_matches[22]
                                                                                                          ? 5'h16
                                                                                                          : io_addr_matches[21]
                                                                                                              ? 5'h15
                                                                                                              : io_addr_matches[20]
                                                                                                                  ? 5'h14
                                                                                                                  : io_addr_matches[19]
                                                                                                                      ? 5'h13
                                                                                                                      : io_addr_matches[18]
                                                                                                                          ? 5'h12
                                                                                                                          : io_addr_matches[17]
                                                                                                                              ? 5'h11
                                                                                                                              : io_addr_matches[16]
                                                                                                                                  ? 5'h10
                                                                                                                                  : io_addr_matches[15]
                                                                                                                                      ? 5'hF
                                                                                                                                      : io_addr_matches[14]
                                                                                                                                          ? 5'hE
                                                                                                                                          : io_addr_matches[13]
                                                                                                                                              ? 5'hD
                                                                                                                                              : io_addr_matches[12]
                                                                                                                                                  ? 5'hC
                                                                                                                                                  : io_addr_matches[11]
                                                                                                                                                      ? 5'hB
                                                                                                                                                      : io_addr_matches[10]
                                                                                                                                                          ? 5'hA
                                                                                                                                                          : io_addr_matches[9]
                                                                                                                                                              ? 5'h9
                                                                                                                                                              : io_addr_matches[8]
                                                                                                                                                                  ? 5'h8
                                                                                                                                                                  : io_addr_matches[7]
                                                                                                                                                                      ? 5'h7
                                                                                                                                                                      : io_addr_matches[6]
                                                                                                                                                                          ? 5'h6
                                                                                                                                                                          : io_addr_matches[5]
                                                                                                                                                                              ? 5'h5
                                                                                                                                                                              : io_addr_matches[4]
                                                                                                                                                                                  ? 5'h4
                                                                                                                                                                                  : io_addr_matches[3]
                                                                                                                                                                                      ? 5'h3
                                                                                                                                                                                      : io_addr_matches[2]
                                                                                                                                                                                          ? 5'h2
                                                                                                                                                                                          : {4'h0,
                                                                                                                                                                                             io_addr_matches[1]};	// lsu.scala:1691:17, :1699:35, :1704:22, :1709:20, :1710:7, :1712:28
endmodule

