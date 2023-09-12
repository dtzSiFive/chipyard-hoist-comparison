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

module INToRecFN(
  input         io_signedIn,
  input  [63:0] io_in,
  input  [2:0]  io_roundingMode,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire         intAsRawFloat_sign = io_signedIn & io_in[63];	// rawFloatFromIN.scala:50:{29,34}
  wire [63:0]  intAsRawFloat_extAbsIn_lo = intAsRawFloat_sign ? 64'h0 - io_in : io_in;	// Cat.scala:30:58, rawFloatFromIN.scala:50:29, :51:{24,31}
  wire [5:0]   intAsRawFloat_adjustedNormDist =
    intAsRawFloat_extAbsIn_lo[63]
      ? 6'h0
      : intAsRawFloat_extAbsIn_lo[62]
          ? 6'h1
          : intAsRawFloat_extAbsIn_lo[61]
              ? 6'h2
              : intAsRawFloat_extAbsIn_lo[60]
                  ? 6'h3
                  : intAsRawFloat_extAbsIn_lo[59]
                      ? 6'h4
                      : intAsRawFloat_extAbsIn_lo[58]
                          ? 6'h5
                          : intAsRawFloat_extAbsIn_lo[57]
                              ? 6'h6
                              : intAsRawFloat_extAbsIn_lo[56]
                                  ? 6'h7
                                  : intAsRawFloat_extAbsIn_lo[55]
                                      ? 6'h8
                                      : intAsRawFloat_extAbsIn_lo[54]
                                          ? 6'h9
                                          : intAsRawFloat_extAbsIn_lo[53]
                                              ? 6'hA
                                              : intAsRawFloat_extAbsIn_lo[52]
                                                  ? 6'hB
                                                  : intAsRawFloat_extAbsIn_lo[51]
                                                      ? 6'hC
                                                      : intAsRawFloat_extAbsIn_lo[50]
                                                          ? 6'hD
                                                          : intAsRawFloat_extAbsIn_lo[49]
                                                              ? 6'hE
                                                              : intAsRawFloat_extAbsIn_lo[48]
                                                                  ? 6'hF
                                                                  : intAsRawFloat_extAbsIn_lo[47]
                                                                      ? 6'h10
                                                                      : intAsRawFloat_extAbsIn_lo[46]
                                                                          ? 6'h11
                                                                          : intAsRawFloat_extAbsIn_lo[45]
                                                                              ? 6'h12
                                                                              : intAsRawFloat_extAbsIn_lo[44]
                                                                                  ? 6'h13
                                                                                  : intAsRawFloat_extAbsIn_lo[43]
                                                                                      ? 6'h14
                                                                                      : intAsRawFloat_extAbsIn_lo[42]
                                                                                          ? 6'h15
                                                                                          : intAsRawFloat_extAbsIn_lo[41]
                                                                                              ? 6'h16
                                                                                              : intAsRawFloat_extAbsIn_lo[40]
                                                                                                  ? 6'h17
                                                                                                  : intAsRawFloat_extAbsIn_lo[39]
                                                                                                      ? 6'h18
                                                                                                      : intAsRawFloat_extAbsIn_lo[38]
                                                                                                          ? 6'h19
                                                                                                          : intAsRawFloat_extAbsIn_lo[37]
                                                                                                              ? 6'h1A
                                                                                                              : intAsRawFloat_extAbsIn_lo[36]
                                                                                                                  ? 6'h1B
                                                                                                                  : intAsRawFloat_extAbsIn_lo[35]
                                                                                                                      ? 6'h1C
                                                                                                                      : intAsRawFloat_extAbsIn_lo[34]
                                                                                                                          ? 6'h1D
                                                                                                                          : intAsRawFloat_extAbsIn_lo[33]
                                                                                                                              ? 6'h1E
                                                                                                                              : intAsRawFloat_extAbsIn_lo[32]
                                                                                                                                  ? 6'h1F
                                                                                                                                  : intAsRawFloat_extAbsIn_lo[31]
                                                                                                                                      ? 6'h20
                                                                                                                                      : intAsRawFloat_extAbsIn_lo[30]
                                                                                                                                          ? 6'h21
                                                                                                                                          : intAsRawFloat_extAbsIn_lo[29]
                                                                                                                                              ? 6'h22
                                                                                                                                              : intAsRawFloat_extAbsIn_lo[28]
                                                                                                                                                  ? 6'h23
                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[27]
                                                                                                                                                      ? 6'h24
                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[26]
                                                                                                                                                          ? 6'h25
                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[25]
                                                                                                                                                              ? 6'h26
                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[24]
                                                                                                                                                                  ? 6'h27
                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[23]
                                                                                                                                                                      ? 6'h28
                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[22]
                                                                                                                                                                          ? 6'h29
                                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[21]
                                                                                                                                                                              ? 6'h2A
                                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[20]
                                                                                                                                                                                  ? 6'h2B
                                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[19]
                                                                                                                                                                                      ? 6'h2C
                                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[18]
                                                                                                                                                                                          ? 6'h2D
                                                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[17]
                                                                                                                                                                                              ? 6'h2E
                                                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[16]
                                                                                                                                                                                                  ? 6'h2F
                                                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[15]
                                                                                                                                                                                                      ? 6'h30
                                                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[14]
                                                                                                                                                                                                          ? 6'h31
                                                                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[13]
                                                                                                                                                                                                              ? 6'h32
                                                                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[12]
                                                                                                                                                                                                                  ? 6'h33
                                                                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[11]
                                                                                                                                                                                                                      ? 6'h34
                                                                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[10]
                                                                                                                                                                                                                          ? 6'h35
                                                                                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[9]
                                                                                                                                                                                                                              ? 6'h36
                                                                                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[8]
                                                                                                                                                                                                                                  ? 6'h37
                                                                                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[7]
                                                                                                                                                                                                                                      ? 6'h38
                                                                                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[6]
                                                                                                                                                                                                                                          ? 6'h39
                                                                                                                                                                                                                                          : intAsRawFloat_extAbsIn_lo[5]
                                                                                                                                                                                                                                              ? 6'h3A
                                                                                                                                                                                                                                              : intAsRawFloat_extAbsIn_lo[4]
                                                                                                                                                                                                                                                  ? 6'h3B
                                                                                                                                                                                                                                                  : intAsRawFloat_extAbsIn_lo[3]
                                                                                                                                                                                                                                                      ? 6'h3C
                                                                                                                                                                                                                                                      : intAsRawFloat_extAbsIn_lo[2]
                                                                                                                                                                                                                                                          ? 6'h3D
                                                                                                                                                                                                                                                          : {5'h1F,
                                                                                                                                                                                                                                                             ~(intAsRawFloat_extAbsIn_lo[1])};	// Mux.scala:47:69, primitives.scala:92:52, rawFloatFromIN.scala:51:24, :52:56
  wire [126:0] _intAsRawFloat_sig_T =
    {63'h0, intAsRawFloat_extAbsIn_lo} << intAsRawFloat_adjustedNormDist;	// Mux.scala:47:69, rawFloatFromIN.scala:51:24, :55:22
  RoundAnyRawFNToRecFN_1 roundAnyRawFNToRecFN (	// INToRecFN.scala:59:15
    .io_in_isZero      (~(_intAsRawFloat_sig_T[63])),	// rawFloatFromIN.scala:55:{22,41}, :61:{23,28}
    .io_in_sign        (intAsRawFloat_sign),	// rawFloatFromIN.scala:50:29
    .io_in_sExp        ({3'h2, ~intAsRawFloat_adjustedNormDist}),	// Mux.scala:47:69, rawFloatFromIN.scala:63:{39,75}
    .io_in_sig         ({1'h0, _intAsRawFloat_sig_T[63:0]}),	// rawFloatFromIN.scala:51:31, :55:{22,41}, :64:20
    .io_roundingMode   (io_roundingMode),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
endmodule

