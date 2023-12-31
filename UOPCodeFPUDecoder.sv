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

module UOPCodeFPUDecoder(
  input  [6:0] io_uopc,
  output       io_sigs_ren2,
               io_sigs_ren3,
               io_sigs_swap23,
  output [1:0] io_sigs_typeTagIn,
               io_sigs_typeTagOut,
  output       io_sigs_fromint,
               io_sigs_toint,
               io_sigs_fastpipe,
               io_sigs_fma,
               io_sigs_wflags
);

  wire _decoder_bit_T_86 = io_uopc == 7'h46;	// Decode.scala:14:121
  wire _decoder_bit_T_2 = io_uopc == 7'h4E;	// Decode.scala:14:121
  wire _decoder_bit_T_55 = io_uopc == 7'h50;	// Decode.scala:14:121
  wire _decoder_bit_T_130 = io_uopc == 7'h48;	// Decode.scala:14:121
  wire _decoder_bit_T_5 = io_uopc == 7'h54;	// Decode.scala:14:121
  wire _decoder_bit_T_135 = io_uopc == 7'h57;	// Decode.scala:14:121
  wire _decoder_bit_T_7 = io_uopc == 7'h58;	// Decode.scala:14:121
  wire _decoder_bit_T_8 = io_uopc == 7'h59;	// Decode.scala:14:121
  wire _decoder_bit_T_74 = io_uopc == 7'h5D;	// Decode.scala:14:121
  wire _decoder_bit_T_10 = io_uopc == 7'h5E;	// Decode.scala:14:121
  wire _decoder_bit_T_11 = io_uopc == 7'h5F;	// Decode.scala:14:121
  wire _decoder_bit_T_12 = io_uopc == 7'h60;	// Decode.scala:14:121
  wire _decoder_bit_T_13 = io_uopc == 7'h53;	// Decode.scala:14:121
  wire _decoder_bit_T_14 = io_uopc == 7'h47;	// Decode.scala:14:121
  wire _decoder_bit_T_15 = io_uopc == 7'h4A;	// Decode.scala:14:121
  wire _decoder_bit_T_16 = io_uopc == 7'h4B;	// Decode.scala:14:121
  wire _decoder_bit_T_17 = io_uopc == 7'h4F;	// Decode.scala:14:121
  wire _decoder_bit_T_18 = io_uopc == 7'h51;	// Decode.scala:14:121
  wire _decoder_bit_T_19 = io_uopc == 7'h49;	// Decode.scala:14:121
  wire _decoder_bit_T_20 = io_uopc == 7'h55;	// Decode.scala:14:121
  wire _decoder_bit_T_21 = io_uopc == 7'h5A;	// Decode.scala:14:121
  wire _decoder_bit_T_22 = io_uopc == 7'h5B;	// Decode.scala:14:121
  wire _decoder_bit_T_23 = io_uopc == 7'h5C;	// Decode.scala:14:121
  wire _decoder_bit_T_24 = io_uopc == 7'h61;	// Decode.scala:14:121
  wire _decoder_bit_T_25 = io_uopc == 7'h62;	// Decode.scala:14:121
  wire _decoder_bit_T_26 = io_uopc == 7'h63;	// Decode.scala:14:121
  wire _decoder_bit_T_27 = io_uopc == 7'h64;	// Decode.scala:14:121
  wire _decoder_bit_T_84 = io_uopc == 7'h45;	// Decode.scala:14:121
  wire _decoder_bit_T_85 = io_uopc == 7'h4D;	// Decode.scala:14:121
  wire _decoder_bit_T_120 = io_uopc == 7'h44;	// Decode.scala:14:121
  wire _decoder_bit_T_148 = io_uopc == 7'h4C;	// Decode.scala:14:121
  assign io_sigs_ren2 =
    _decoder_bit_T_55 | _decoder_bit_T_130 | _decoder_bit_T_5 | _decoder_bit_T_135
    | _decoder_bit_T_7 | _decoder_bit_T_8 | _decoder_bit_T_74 | _decoder_bit_T_10
    | _decoder_bit_T_11 | _decoder_bit_T_12 | _decoder_bit_T_18 | _decoder_bit_T_19
    | _decoder_bit_T_20 | _decoder_bit_T_21 | _decoder_bit_T_22 | _decoder_bit_T_23
    | _decoder_bit_T_24 | _decoder_bit_T_25 | _decoder_bit_T_26 | _decoder_bit_T_27;	// Decode.scala:14:121, :15:30
  assign io_sigs_ren3 =
    _decoder_bit_T_74 | _decoder_bit_T_10 | _decoder_bit_T_11 | _decoder_bit_T_12
    | _decoder_bit_T_24 | _decoder_bit_T_25 | _decoder_bit_T_26 | _decoder_bit_T_27;	// Decode.scala:14:121, :15:30
  assign io_sigs_swap23 =
    _decoder_bit_T_135 | _decoder_bit_T_7 | _decoder_bit_T_21 | _decoder_bit_T_22;	// Decode.scala:14:121, :15:30
  assign io_sigs_typeTagIn =
    {1'h0,
     _decoder_bit_T_86 | _decoder_bit_T_13 | _decoder_bit_T_84 | _decoder_bit_T_14
       | _decoder_bit_T_15 | _decoder_bit_T_85 | _decoder_bit_T_17 | _decoder_bit_T_18
       | _decoder_bit_T_19 | _decoder_bit_T_20 | _decoder_bit_T_21 | _decoder_bit_T_22
       | _decoder_bit_T_23 | _decoder_bit_T_24 | _decoder_bit_T_25 | _decoder_bit_T_26
       | _decoder_bit_T_27};	// Decode.scala:14:121, :15:30, fpu.scala:115:40
  assign io_sigs_typeTagOut =
    {1'h0,
     _decoder_bit_T_120 | _decoder_bit_T_13 | _decoder_bit_T_84 | _decoder_bit_T_14
       | _decoder_bit_T_16 | _decoder_bit_T_85 | _decoder_bit_T_17 | _decoder_bit_T_18
       | _decoder_bit_T_19 | _decoder_bit_T_20 | _decoder_bit_T_21 | _decoder_bit_T_22
       | _decoder_bit_T_23 | _decoder_bit_T_24 | _decoder_bit_T_25 | _decoder_bit_T_26
       | _decoder_bit_T_27};	// Decode.scala:14:121, :15:30, fpu.scala:115:40
  assign io_sigs_fromint =
    _decoder_bit_T_120 | _decoder_bit_T_148 | _decoder_bit_T_84 | _decoder_bit_T_85;	// Decode.scala:14:121, :15:30
  assign io_sigs_toint =
    io_uopc == 7'h52 | _decoder_bit_T_86 | _decoder_bit_T_2 | _decoder_bit_T_55
    | _decoder_bit_T_13 | _decoder_bit_T_14 | _decoder_bit_T_17 | _decoder_bit_T_18;	// Decode.scala:14:121, :15:30
  assign io_sigs_fastpipe =
    _decoder_bit_T_130 | _decoder_bit_T_5 | _decoder_bit_T_15 | _decoder_bit_T_16
    | _decoder_bit_T_19 | _decoder_bit_T_20;	// Decode.scala:14:121, :15:30
  assign io_sigs_fma =
    _decoder_bit_T_135 | _decoder_bit_T_7 | _decoder_bit_T_8 | _decoder_bit_T_74
    | _decoder_bit_T_10 | _decoder_bit_T_11 | _decoder_bit_T_12 | _decoder_bit_T_21
    | _decoder_bit_T_22 | _decoder_bit_T_23 | _decoder_bit_T_24 | _decoder_bit_T_25
    | _decoder_bit_T_26 | _decoder_bit_T_27;	// Decode.scala:14:121, :15:30
  assign io_sigs_wflags =
    _decoder_bit_T_148 | _decoder_bit_T_2 | _decoder_bit_T_55 | _decoder_bit_T_5
    | _decoder_bit_T_135 | _decoder_bit_T_7 | _decoder_bit_T_8 | _decoder_bit_T_74
    | _decoder_bit_T_10 | _decoder_bit_T_11 | _decoder_bit_T_12 | _decoder_bit_T_15
    | _decoder_bit_T_16 | _decoder_bit_T_85 | _decoder_bit_T_17 | _decoder_bit_T_18
    | _decoder_bit_T_20 | _decoder_bit_T_21 | _decoder_bit_T_22 | _decoder_bit_T_23
    | _decoder_bit_T_24 | _decoder_bit_T_25 | _decoder_bit_T_26 | _decoder_bit_T_27;	// Decode.scala:14:121, :15:30
endmodule

