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

module FPToInt_1(
  input         clock,
                io_in_valid,
                io_in_bits_ren2,
  input  [1:0]  io_in_bits_typeTagOut,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_typ,
                io_in_bits_fmt,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
  output        io_out_bits_lt,
  output [63:0] io_out_bits_toint,
  output [4:0]  io_out_bits_exc
);

  wire [63:0] toint;	// FPU.scala:479:19, :485:20, :490:21
  wire        _narrow_io_signedOut_T;	// FPU.scala:496:35
  wire        intType;	// FPU.scala:479:19, :485:20, :490:21
  wire [2:0]  _narrow_io_intExceptionFlags;	// FPU.scala:503:30
  wire [63:0] _conv_io_out;	// FPU.scala:493:24
  wire [2:0]  _conv_io_intExceptionFlags;	// FPU.scala:493:24
  wire        _dcmp_io_lt;	// FPU.scala:465:20
  wire        _dcmp_io_eq;	// FPU.scala:465:20
  wire [4:0]  _dcmp_io_exceptionFlags;	// FPU.scala:465:20
  reg         in_ren2;	// Reg.scala:15:16
  reg  [1:0]  in_typeTagOut;	// Reg.scala:15:16
  reg         in_wflags;	// Reg.scala:15:16
  reg  [2:0]  in_rm;	// Reg.scala:15:16
  reg  [1:0]  in_typ;	// Reg.scala:15:16
  reg  [1:0]  in_fmt;	// Reg.scala:15:16
  reg  [64:0] in_in1;	// Reg.scala:15:16
  reg  [64:0] in_in2;	// Reg.scala:15:16
  wire [12:0] store_unrecoded_rawIn_1_sExp = {1'h0, in_in1[63:52]};	// FPU.scala:519:53, Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :59:27
  wire [52:0] _store_unrecoded_denormFract_T_1 =
    {1'h0, |(in_in1[63:61]), in_in1[51:1]} >> 6'h1 - in_in1[57:52];	// FPU.scala:519:53, Reg.scala:15:16, fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [1:0]  _store_prevUnrecoded_rawIn_isSpecial_T = {in_in1[52], in_in1[30]};	// FPU.scala:438:10, Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :52:29
  wire        store_prevUnrecoded_rawIn_isInf =
    (&_store_prevUnrecoded_rawIn_isSpecial_T) & ~(in_in1[29]);	// Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire        store_prevUnrecoded_isSubnormal =
    $signed({1'h0, in_in1[52], in_in1[30:23]}) < 10'sh82;	// FPU.scala:438:10, :519:53, Reg.scala:15:16, fNFromRecFN.scala:50:39, rawFloatFromRecFN.scala:50:21, :59:27
  wire [23:0] _store_prevUnrecoded_denormFract_T_1 =
    {1'h0, |{in_in1[52], in_in1[30:29]}, in_in1[22:1]} >> 5'h1 - in_in1[27:23];	// FPU.scala:438:10, :519:53, Reg.scala:15:16, fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire        store_unrecoded_rawIn_1_isInf = (&(in_in1[63:62])) & ~(in_in1[61]);	// Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire        store_unrecoded_isSubnormal_1 =
    $signed(store_unrecoded_rawIn_1_sExp) < 13'sh402;	// fNFromRecFN.scala:50:39, rawFloatFromRecFN.scala:59:27
  wire [52:0] _store_unrecoded_denormFract_T_3 =
    {1'h0, |(in_in1[63:61]), in_in1[51:1]} >> 6'h1 - in_in1[57:52];	// FPU.scala:519:53, Reg.scala:15:16, fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [51:0] store_unrecoded_lo_1 =
    store_unrecoded_isSubnormal_1
      ? _store_unrecoded_denormFract_T_3[51:0]
      : store_unrecoded_rawIn_1_isInf ? 52'h0 : in_in1[51:0];	// Reg.scala:15:16, fNFromRecFN.scala:50:39, :52:{42,60}, :61:16, :63:20, rawFloatFromRecFN.scala:56:33, :60:51
  wire [1:0]  _store_prevUnrecoded_rawIn_isSpecial_T_1 = {in_in1[52], in_in1[30]};	// FPU.scala:438:10, Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :52:29
  wire        store_prevUnrecoded_rawIn_1_isInf =
    (&_store_prevUnrecoded_rawIn_isSpecial_T_1) & ~(in_in1[29]);	// Reg.scala:15:16, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire        store_prevUnrecoded_isSubnormal_1 =
    $signed({1'h0, in_in1[52], in_in1[30:23]}) < 10'sh82;	// FPU.scala:438:10, :519:53, Reg.scala:15:16, fNFromRecFN.scala:50:39, rawFloatFromRecFN.scala:50:21, :59:27
  wire [23:0] _store_prevUnrecoded_denormFract_T_3 =
    {1'h0, |{in_in1[52], in_in1[30:29]}, in_in1[22:1]} >> 5'h1 - in_in1[27:23];	// FPU.scala:438:10, :519:53, Reg.scala:15:16, fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [63:0] store =
    in_typeTagOut[0]
      ? {in_in1[64],
         (store_unrecoded_isSubnormal_1 ? 11'h0 : in_in1[62:52] + 11'h3FF)
           | {11{(&(in_in1[63:62])) & in_in1[61] | store_unrecoded_rawIn_1_isInf}},
         store_unrecoded_lo_1[51:32],
         (&(in_in1[63:61]))
           ? {in_in1[31],
              (store_prevUnrecoded_isSubnormal_1 ? 8'h0 : in_in1[30:23] + 8'h7F)
                | {8{(&_store_prevUnrecoded_rawIn_isSpecial_T_1) & in_in1[29]
                       | store_prevUnrecoded_rawIn_1_isInf}},
              store_prevUnrecoded_isSubnormal_1
                ? _store_prevUnrecoded_denormFract_T_3[22:0]
                : store_prevUnrecoded_rawIn_1_isInf ? 23'h0 : in_in1[22:0]}
           : store_unrecoded_lo_1[31:0]}
      : {2{(&(in_in1[63:61]))
             ? {in_in1[31],
                (store_prevUnrecoded_isSubnormal ? 8'h0 : in_in1[30:23] + 8'h7F)
                  | {8{(&_store_prevUnrecoded_rawIn_isSpecial_T) & in_in1[29]
                         | store_prevUnrecoded_rawIn_isInf}},
                store_prevUnrecoded_isSubnormal
                  ? _store_prevUnrecoded_denormFract_T_1[22:0]
                  : store_prevUnrecoded_rawIn_isInf ? 23'h0 : in_in1[22:0]}
             : $signed(store_unrecoded_rawIn_1_sExp) < 13'sh402
                 ? _store_unrecoded_denormFract_T_1[31:0]
                 : (&(in_in1[63:62])) & ~(in_in1[61]) ? 32'h0 : in_in1[31:0]}};	// Bitwise.scala:72:12, Cat.scala:30:58, FPU.scala:243:{25,56}, :437:10, :441:{21,44,81}, Reg.scala:15:16, fNFromRecFN.scala:50:39, :52:{42,60}, :55:16, :57:{27,45}, :59:{15,44}, :61:16, :63:20, package.scala:31:49, :32:76, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}, :56:{33,36}, :58:25, :59:27, :60:51
  wire [8:0]  _classify_out_expOut_commonCase_T = in_in1[60:52] - 9'h100;	// FPU.scala:274:31, Reg.scala:15:16, rawFloatFromRecFN.scala:50:21
  wire [8:0]  classify_out_hi_lo =
    in_in1[63:61] == 3'h0 | in_in1[63:61] > 3'h5
      ? {in_in1[63:61], _classify_out_expOut_commonCase_T[5:0]}
      : _classify_out_expOut_commonCase_T;	// Cat.scala:30:58, FPU.scala:273:26, :274:{31,48}, :275:{10,19,25,36,65}, Reg.scala:15:16, rawFloatFromRecFN.scala:50:21
  wire        classify_out_isHighSubnormalIn = classify_out_hi_lo[6:0] < 7'h2;	// FPU.scala:252:{30,55}, :275:10
  wire        _classify_out_isNormal_T = classify_out_hi_lo[8:7] == 2'h1;	// FPU.scala:248:17, :249:22, :253:50, :275:10
  wire        classify_out_isSubnormal =
    classify_out_hi_lo[8:6] == 3'h1 | _classify_out_isNormal_T
    & classify_out_isHighSubnormalIn;	// FPU.scala:248:17, :252:55, :253:{28,40,50,62}, :275:10
  wire        classify_out_isNormal =
    _classify_out_isNormal_T & ~classify_out_isHighSubnormalIn
    | classify_out_hi_lo[8:7] == 2'h2;	// FPU.scala:248:17, :249:22, :252:55, :253:50, :254:{39,42,61,71}, :275:10
  wire        classify_out_isZero = classify_out_hi_lo[8:6] == 3'h0;	// FPU.scala:248:17, :255:23, :275:10
  wire        classify_out_isInf =
    (&(classify_out_hi_lo[8:7])) & ~(classify_out_hi_lo[6]);	// FPU.scala:248:17, :249:22, :250:28, :256:{27,30,35}, :275:10
  wire        classify_out_isHighSubnormalIn_1 = in_in1[61:52] < 10'h2;	// FPU.scala:252:{30,55}, Reg.scala:15:16
  wire        _classify_out_isNormal_T_4 = in_in1[63:62] == 2'h1;	// FPU.scala:243:25, :249:22, :253:50, Reg.scala:15:16
  wire        classify_out_isSubnormal_1 =
    in_in1[63:61] == 3'h1 | _classify_out_isNormal_T_4 & classify_out_isHighSubnormalIn_1;	// FPU.scala:243:25, :252:55, :253:{28,40,50,62}, Reg.scala:15:16
  wire        classify_out_isNormal_1 =
    _classify_out_isNormal_T_4 & ~classify_out_isHighSubnormalIn_1
    | in_in1[63:62] == 2'h2;	// FPU.scala:243:25, :249:22, :252:55, :253:50, :254:{39,42,61,71}, Reg.scala:15:16
  wire        classify_out_isZero_1 = in_in1[63:61] == 3'h0;	// FPU.scala:243:25, :255:23, Reg.scala:15:16
  wire        classify_out_isInf_1 = (&(in_in1[63:62])) & ~(in_in1[61]);	// FPU.scala:243:25, :249:22, :250:28, :256:{27,30,35}, Reg.scala:15:16
  assign intType = in_wflags ? ~in_ren2 & in_typ[1] : ~(in_rm[0]) & in_fmt[0];	// FPU.scala:474:35, :479:{14,19}, :482:13, :485:20, :488:13, :490:{11,21}, :492:15, Reg.scala:15:16, package.scala:154:13
  assign _narrow_io_signedOut_T = in_typ[0];	// FPU.scala:496:35, Reg.scala:15:16
  wire        excSign = in_in1[64] & in_in1[63:61] != 3'h7;	// FPU.scala:243:{25,56}, :508:59, Reg.scala:15:16, rawFloatFromRecFN.scala:58:25
  wire        io_out_bits_exc_hi_hi_1 =
    _conv_io_intExceptionFlags[2] | _narrow_io_intExceptionFlags[1];	// FPU.scala:493:24, :503:30, :510:{50,54,84}
  assign toint =
    in_wflags
      ? (in_ren2
           ? {store[63:32], 31'h0, |(~(in_rm[1:0]) & {_dcmp_io_lt, _dcmp_io_eq})}
           : ~(in_typ[1]) & io_out_bits_exc_hi_hi_1
               ? {_conv_io_out[63:32], ~_narrow_io_signedOut_T == excSign, {31{~excSign}}}
               : _conv_io_out)
      : in_rm[0]
          ? {store[63:32],
             22'h0,
             in_typeTagOut[0]
               ? {(&(in_in1[63:61])) & in_in1[51],
                  (&(in_in1[63:61])) & ~(in_in1[51]),
                  classify_out_isInf_1 & ~(in_in1[64]),
                  classify_out_isNormal_1 & ~(in_in1[64]),
                  classify_out_isSubnormal_1 & ~(in_in1[64]),
                  classify_out_isZero_1 & ~(in_in1[64]),
                  classify_out_isZero_1 & in_in1[64],
                  classify_out_isSubnormal_1 & in_in1[64],
                  classify_out_isNormal_1 & in_in1[64],
                  classify_out_isInf_1 & in_in1[64]}
               : {(&(classify_out_hi_lo[8:6])) & in_in1[51],
                  (&(classify_out_hi_lo[8:6])) & ~(in_in1[51]),
                  classify_out_isInf & ~(in_in1[64]),
                  classify_out_isNormal & ~(in_in1[64]),
                  classify_out_isSubnormal & ~(in_in1[64]),
                  classify_out_isZero & ~(in_in1[64]),
                  classify_out_isZero & in_in1[64],
                  classify_out_isSubnormal & in_in1[64],
                  classify_out_isNormal & in_in1[64],
                  classify_out_isInf & in_in1[64]}}
          : store;	// Bitwise.scala:72:12, Cat.scala:30:58, FPU.scala:243:25, :248:17, :253:40, :254:61, :255:23, :256:27, :257:22, :258:{24,27,29}, :259:24, :261:{31,34,50}, :262:{21,38,55}, :263:{21,39,54}, :275:10, :465:20, :479:{14,19}, :481:{11,27,36}, :485:20, :486:{11,15,22,53,57,66}, :490:21, :493:24, :496:{28,35}, :497:13, :502:{23,30}, :508:59, :509:{46,69}, :510:54, :511:{26,34,53}, Reg.scala:15:16, package.scala:31:49, :32:76, :154:13, rawFloatFromRecFN.scala:58:25
  always @(posedge clock) begin
    if (io_in_valid) begin
      in_ren2 <= io_in_bits_ren2;	// Reg.scala:15:16
      in_typeTagOut <= io_in_bits_typeTagOut;	// Reg.scala:15:16
      in_wflags <= io_in_bits_wflags;	// Reg.scala:15:16
      in_rm <= io_in_bits_rm;	// Reg.scala:15:16
      in_typ <= io_in_bits_typ;	// Reg.scala:15:16
      in_fmt <= io_in_bits_fmt;	// Reg.scala:15:16
      in_in1 <= io_in_bits_in1;	// Reg.scala:15:16
      in_in2 <= io_in_bits_in2;	// Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:4];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        in_ren2 = _RANDOM[3'h0][3];	// Reg.scala:15:16
        in_typeTagOut = _RANDOM[3'h0][10:9];	// Reg.scala:15:16
        in_wflags = _RANDOM[3'h0][17];	// Reg.scala:15:16
        in_rm = _RANDOM[3'h0][20:18];	// Reg.scala:15:16
        in_typ = _RANDOM[3'h0][24:23];	// Reg.scala:15:16
        in_fmt = _RANDOM[3'h0][26:25];	// Reg.scala:15:16
        in_in1 = {_RANDOM[3'h0][31:27], _RANDOM[3'h1], _RANDOM[3'h2][27:0]};	// Reg.scala:15:16
        in_in2 = {_RANDOM[3'h2][31:28], _RANDOM[3'h3], _RANDOM[3'h4][28:0]};	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  CompareRecFN dcmp (	// FPU.scala:465:20
    .io_a              (in_in1),	// Reg.scala:15:16
    .io_b              (in_in2),	// Reg.scala:15:16
    .io_signaling      (~(in_rm[1])),	// FPU.scala:468:{24,30}, Reg.scala:15:16
    .io_lt             (_dcmp_io_lt),
    .io_eq             (_dcmp_io_eq),
    .io_exceptionFlags (_dcmp_io_exceptionFlags)
  );
  RecFNToIN conv (	// FPU.scala:493:24
    .io_in                (in_in1),	// Reg.scala:15:16
    .io_roundingMode      (in_rm),	// Reg.scala:15:16
    .io_signedOut         (~_narrow_io_signedOut_T),	// FPU.scala:496:{28,35}
    .io_out               (_conv_io_out),
    .io_intExceptionFlags (_conv_io_intExceptionFlags)
  );
  RecFNToIN_1 narrow (	// FPU.scala:503:30
    .io_in                (in_in1),	// Reg.scala:15:16
    .io_roundingMode      (in_rm),	// Reg.scala:15:16
    .io_signedOut         (~_narrow_io_signedOut_T),	// FPU.scala:496:35, :506:34
    .io_intExceptionFlags (_narrow_io_intExceptionFlags)
  );
  assign io_out_bits_lt =
    _dcmp_io_lt | $signed(in_in1) < 65'sh0 & $signed(in_in2) > -65'sh1;	// FPU.scala:465:20, :519:{32,53,59,79}, Reg.scala:15:16
  assign io_out_bits_toint = intType ? toint : {{32{toint[31]}}, toint[31:0]};	// Bitwise.scala:72:12, Cat.scala:30:58, FPU.scala:476:59, :479:19, :485:20, :490:21, package.scala:32:76, :123:38
  assign io_out_bits_exc =
    in_wflags
      ? (in_ren2
           ? _dcmp_io_exceptionFlags
           : in_typ[1]
               ? {|(_conv_io_intExceptionFlags[2:1]), 3'h0, _conv_io_intExceptionFlags[0]}
               : {io_out_bits_exc_hi_hi_1,
                  3'h0,
                  ~io_out_bits_exc_hi_hi_1 & _conv_io_intExceptionFlags[0]})
      : 5'h0;	// Cat.scala:30:58, FPU.scala:465:20, :477:19, :485:20, :487:21, :490:21, :493:24, :498:{23,55,62,104}, :502:30, :510:54, :512:{27,55,64}, Reg.scala:15:16, package.scala:154:13
endmodule

