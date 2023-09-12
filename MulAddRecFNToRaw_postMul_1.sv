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

module MulAddRecFNToRaw_postMul_1(
  input          io_fromPreMul_isSigNaNAny,
                 io_fromPreMul_isNaNAOrB,
                 io_fromPreMul_isInfA,
                 io_fromPreMul_isZeroA,
                 io_fromPreMul_isInfB,
                 io_fromPreMul_isZeroB,
                 io_fromPreMul_signProd,
                 io_fromPreMul_isNaNC,
                 io_fromPreMul_isInfC,
                 io_fromPreMul_isZeroC,
  input  [12:0]  io_fromPreMul_sExpSum,
  input          io_fromPreMul_doSubMags,
                 io_fromPreMul_CIsDominant,
  input  [5:0]   io_fromPreMul_CDom_CAlignDist,
  input  [54:0]  io_fromPreMul_highAlignedSigC,
  input          io_fromPreMul_bit0AlignedSigC,
  input  [106:0] io_mulAddResult,
  input  [2:0]   io_roundingMode,
  output         io_invalidExc,
                 io_rawOut_isNaN,
                 io_rawOut_isInf,
                 io_rawOut_isZero,
                 io_rawOut_sign,
  output [12:0]  io_rawOut_sExp,
  output [55:0]  io_rawOut_sig
);

  wire         roundingMode_min = io_roundingMode == 3'h2;	// MulAddRecFN.scala:188:45
  wire         CDom_sign = io_fromPreMul_signProd ^ io_fromPreMul_doSubMags;	// MulAddRecFN.scala:192:42
  wire [54:0]  sigSum_hi_hi =
    io_mulAddResult[106]
      ? io_fromPreMul_highAlignedSigC + 55'h1
      : io_fromPreMul_highAlignedSigC;	// MulAddRecFN.scala:194:{16,32}, :195:47
  wire [107:0] CDom_absSigSum =
    io_fromPreMul_doSubMags
      ? ~{sigSum_hi_hi, io_mulAddResult[105:53]}
      : {1'h0,
         io_fromPreMul_highAlignedSigC[54:53],
         sigSum_hi_hi[52:0],
         io_mulAddResult[105:54]};	// Cat.scala:30:58, MulAddRecFN.scala:194:16, :207:12, :208:{13,20}, :211:46, :212:23
  wire [170:0] _CDom_mainSig_T = {63'h0, CDom_absSigSum} << io_fromPreMul_CDom_CAlignDist;	// MulAddRecFN.scala:207:12, :221:24
  wire [16:0]  CDom_reduced4SigExtra_shift =
    $signed(17'sh10000 >>> ~(io_fromPreMul_CDom_CAlignDist[5:2]));	// MulAddRecFN.scala:225:51, primitives.scala:51:21, :77:58
  wire [108:0] notCDom_absSigSum =
    sigSum_hi_hi[2]
      ? ~{sigSum_hi_hi[1:0], io_mulAddResult[105:0], io_fromPreMul_bit0AlignedSigC}
      : {sigSum_hi_hi[1:0], io_mulAddResult[105:0], io_fromPreMul_bit0AlignedSigC}
        + {108'h0, io_fromPreMul_doSubMags};	// MulAddRecFN.scala:194:16, :198:28, :234:36, :236:12, :237:{13,20}, :238:41
  wire [5:0]   notCDom_normDistReduced2 =
    notCDom_absSigSum[108]
      ? 6'h0
      : (|(notCDom_absSigSum[107:106]))
          ? 6'h1
          : (|(notCDom_absSigSum[105:104]))
              ? 6'h2
              : (|(notCDom_absSigSum[103:102]))
                  ? 6'h3
                  : (|(notCDom_absSigSum[101:100]))
                      ? 6'h4
                      : (|(notCDom_absSigSum[99:98]))
                          ? 6'h5
                          : (|(notCDom_absSigSum[97:96]))
                              ? 6'h6
                              : (|(notCDom_absSigSum[95:94]))
                                  ? 6'h7
                                  : (|(notCDom_absSigSum[93:92]))
                                      ? 6'h8
                                      : (|(notCDom_absSigSum[91:90]))
                                          ? 6'h9
                                          : (|(notCDom_absSigSum[89:88]))
                                              ? 6'hA
                                              : (|(notCDom_absSigSum[87:86]))
                                                  ? 6'hB
                                                  : (|(notCDom_absSigSum[85:84]))
                                                      ? 6'hC
                                                      : (|(notCDom_absSigSum[83:82]))
                                                          ? 6'hD
                                                          : (|(notCDom_absSigSum[81:80]))
                                                              ? 6'hE
                                                              : (|(notCDom_absSigSum[79:78]))
                                                                  ? 6'hF
                                                                  : (|(notCDom_absSigSum[77:76]))
                                                                      ? 6'h10
                                                                      : (|(notCDom_absSigSum[75:74]))
                                                                          ? 6'h11
                                                                          : (|(notCDom_absSigSum[73:72]))
                                                                              ? 6'h12
                                                                              : (|(notCDom_absSigSum[71:70]))
                                                                                  ? 6'h13
                                                                                  : (|(notCDom_absSigSum[69:68]))
                                                                                      ? 6'h14
                                                                                      : (|(notCDom_absSigSum[67:66]))
                                                                                          ? 6'h15
                                                                                          : (|(notCDom_absSigSum[65:64]))
                                                                                              ? 6'h16
                                                                                              : (|(notCDom_absSigSum[63:62]))
                                                                                                  ? 6'h17
                                                                                                  : (|(notCDom_absSigSum[61:60]))
                                                                                                      ? 6'h18
                                                                                                      : (|(notCDom_absSigSum[59:58]))
                                                                                                          ? 6'h19
                                                                                                          : (|(notCDom_absSigSum[57:56]))
                                                                                                              ? 6'h1A
                                                                                                              : (|(notCDom_absSigSum[55:54]))
                                                                                                                  ? 6'h1B
                                                                                                                  : (|(notCDom_absSigSum[53:52]))
                                                                                                                      ? 6'h1C
                                                                                                                      : (|(notCDom_absSigSum[51:50]))
                                                                                                                          ? 6'h1D
                                                                                                                          : (|(notCDom_absSigSum[49:48]))
                                                                                                                              ? 6'h1E
                                                                                                                              : (|(notCDom_absSigSum[47:46]))
                                                                                                                                  ? 6'h1F
                                                                                                                                  : (|(notCDom_absSigSum[45:44]))
                                                                                                                                      ? 6'h20
                                                                                                                                      : (|(notCDom_absSigSum[43:42]))
                                                                                                                                          ? 6'h21
                                                                                                                                          : (|(notCDom_absSigSum[41:40]))
                                                                                                                                              ? 6'h22
                                                                                                                                              : (|(notCDom_absSigSum[39:38]))
                                                                                                                                                  ? 6'h23
                                                                                                                                                  : (|(notCDom_absSigSum[37:36]))
                                                                                                                                                      ? 6'h24
                                                                                                                                                      : (|(notCDom_absSigSum[35:34]))
                                                                                                                                                          ? 6'h25
                                                                                                                                                          : (|(notCDom_absSigSum[33:32]))
                                                                                                                                                              ? 6'h26
                                                                                                                                                              : (|(notCDom_absSigSum[31:30]))
                                                                                                                                                                  ? 6'h27
                                                                                                                                                                  : (|(notCDom_absSigSum[29:28]))
                                                                                                                                                                      ? 6'h28
                                                                                                                                                                      : (|(notCDom_absSigSum[27:26]))
                                                                                                                                                                          ? 6'h29
                                                                                                                                                                          : (|(notCDom_absSigSum[25:24]))
                                                                                                                                                                              ? 6'h2A
                                                                                                                                                                              : (|(notCDom_absSigSum[23:22]))
                                                                                                                                                                                  ? 6'h2B
                                                                                                                                                                                  : (|(notCDom_absSigSum[21:20]))
                                                                                                                                                                                      ? 6'h2C
                                                                                                                                                                                      : (|(notCDom_absSigSum[19:18]))
                                                                                                                                                                                          ? 6'h2D
                                                                                                                                                                                          : (|(notCDom_absSigSum[17:16]))
                                                                                                                                                                                              ? 6'h2E
                                                                                                                                                                                              : (|(notCDom_absSigSum[15:14]))
                                                                                                                                                                                                  ? 6'h2F
                                                                                                                                                                                                  : (|(notCDom_absSigSum[13:12]))
                                                                                                                                                                                                      ? 6'h30
                                                                                                                                                                                                      : (|(notCDom_absSigSum[11:10]))
                                                                                                                                                                                                          ? 6'h31
                                                                                                                                                                                                          : (|(notCDom_absSigSum[9:8]))
                                                                                                                                                                                                              ? 6'h32
                                                                                                                                                                                                              : (|(notCDom_absSigSum[7:6]))
                                                                                                                                                                                                                  ? 6'h33
                                                                                                                                                                                                                  : (|(notCDom_absSigSum[5:4]))
                                                                                                                                                                                                                      ? 6'h34
                                                                                                                                                                                                                      : (|(notCDom_absSigSum[3:2]))
                                                                                                                                                                                                                          ? 6'h35
                                                                                                                                                                                                                          : 6'h36;	// MulAddRecFN.scala:236:12, Mux.scala:47:69, primitives.scala:104:{33,54}, :107:15
  wire [235:0] _notCDom_mainSig_T =
    {127'h0, notCDom_absSigSum} << {229'h0, notCDom_normDistReduced2, 1'h0};	// Cat.scala:30:58, MulAddRecFN.scala:236:12, :245:27, Mux.scala:47:69
  wire [32:0]  notCDom_reduced4SigExtra_shift =
    $signed(33'sh100000000 >>> ~(notCDom_normDistReduced2[5:1]));	// MulAddRecFN.scala:250:46, Mux.scala:47:69, primitives.scala:51:21, :77:58
  wire         notCDom_completeCancellation = _notCDom_mainSig_T[109:108] == 2'h0;	// MulAddRecFN.scala:224:53, :245:27, :257:{21,50}
  wire         notNaN_isInfProd = io_fromPreMul_isInfA | io_fromPreMul_isInfB;	// MulAddRecFN.scala:266:49
  wire         notNaN_isInfOut = notNaN_isInfProd | io_fromPreMul_isInfC;	// MulAddRecFN.scala:266:49, :267:44
  wire         notNaN_addZeros =
    (io_fromPreMul_isZeroA | io_fromPreMul_isZeroB) & io_fromPreMul_isZeroC;	// MulAddRecFN.scala:269:{32,58}
  assign io_invalidExc =
    io_fromPreMul_isSigNaNAny | io_fromPreMul_isInfA & io_fromPreMul_isZeroB
    | io_fromPreMul_isZeroA & io_fromPreMul_isInfB | ~io_fromPreMul_isNaNAOrB
    & notNaN_isInfProd & io_fromPreMul_isInfC & io_fromPreMul_doSubMags;	// MulAddRecFN.scala:266:49, :274:31, :275:{32,57}, :276:10, :278:35
  assign io_rawOut_isNaN = io_fromPreMul_isNaNAOrB | io_fromPreMul_isNaNC;	// MulAddRecFN.scala:280:48
  assign io_rawOut_isInf = notNaN_isInfOut;	// MulAddRecFN.scala:267:44
  assign io_rawOut_isZero =
    notNaN_addZeros | ~io_fromPreMul_CIsDominant & notCDom_completeCancellation;	// MulAddRecFN.scala:257:50, :269:58, :284:25, :285:{14,42}
  assign io_rawOut_sign =
    notNaN_isInfProd & io_fromPreMul_signProd | io_fromPreMul_isInfC & CDom_sign
    | notNaN_addZeros & ~roundingMode_min & io_fromPreMul_signProd & CDom_sign
    | notNaN_addZeros & roundingMode_min & (io_fromPreMul_signProd | CDom_sign)
    | ~notNaN_isInfOut & ~notNaN_addZeros
    & (io_fromPreMul_CIsDominant
         ? CDom_sign
         : notCDom_completeCancellation
             ? roundingMode_min
             : io_fromPreMul_signProd ^ sigSum_hi_hi[2]);	// MulAddRecFN.scala:188:45, :192:42, :194:16, :234:36, :257:50, :259:12, :261:36, :266:49, :267:44, :269:58, :287:27, :288:31, :289:29, :290:36, :291:46, :292:{37,50}, :293:{10,31,49}, :294:17
  assign io_rawOut_sExp =
    io_fromPreMul_CIsDominant
      ? io_fromPreMul_sExpSum - {12'h0, io_fromPreMul_doSubMags}
      : io_fromPreMul_sExpSum - {6'h0, notCDom_normDistReduced2, 1'h0};	// Cat.scala:30:58, MulAddRecFN.scala:205:43, :243:46, :295:26, Mux.scala:47:69
  assign io_rawOut_sig =
    io_fromPreMul_CIsDominant
      ? {_CDom_mainSig_T[107:53],
         (|(_CDom_mainSig_T[52:50]))
           | (|({|(CDom_absSigSum[49:46]),
                 |(CDom_absSigSum[45:42]),
                 |(CDom_absSigSum[41:38]),
                 |(CDom_absSigSum[37:34]),
                 |(CDom_absSigSum[33:30]),
                 |(CDom_absSigSum[29:26]),
                 |(CDom_absSigSum[25:22]),
                 |(CDom_absSigSum[21:18]),
                 |(CDom_absSigSum[17:14]),
                 |(CDom_absSigSum[13:10]),
                 |(CDom_absSigSum[9:6]),
                 |(CDom_absSigSum[5:2]),
                 |(CDom_absSigSum[1:0])}
                & {CDom_reduced4SigExtra_shift[1],
                   CDom_reduced4SigExtra_shift[2],
                   CDom_reduced4SigExtra_shift[3],
                   CDom_reduced4SigExtra_shift[4],
                   CDom_reduced4SigExtra_shift[5],
                   CDom_reduced4SigExtra_shift[6],
                   CDom_reduced4SigExtra_shift[7],
                   CDom_reduced4SigExtra_shift[8],
                   CDom_reduced4SigExtra_shift[9],
                   CDom_reduced4SigExtra_shift[10],
                   CDom_reduced4SigExtra_shift[11],
                   CDom_reduced4SigExtra_shift[12],
                   CDom_reduced4SigExtra_shift[13]}))
           | (io_fromPreMul_doSubMags
                ? io_mulAddResult[52:0] != 53'h1FFFFFFFFFFFFF
                : (|(io_mulAddResult[53:0])))}
      : {_notCDom_mainSig_T[109:55],
         (|(_notCDom_mainSig_T[54:52]))
           | (|({|{|(notCDom_absSigSum[51:50]), |(notCDom_absSigSum[49:48])},
                 |{|(notCDom_absSigSum[47:46]), |(notCDom_absSigSum[45:44])},
                 |{|(notCDom_absSigSum[43:42]), |(notCDom_absSigSum[41:40])},
                 |{|(notCDom_absSigSum[39:38]), |(notCDom_absSigSum[37:36])},
                 |{|(notCDom_absSigSum[35:34]), |(notCDom_absSigSum[33:32])},
                 |{|(notCDom_absSigSum[31:30]), |(notCDom_absSigSum[29:28])},
                 |{|(notCDom_absSigSum[27:26]), |(notCDom_absSigSum[25:24])},
                 |{|(notCDom_absSigSum[23:22]), |(notCDom_absSigSum[21:20])},
                 |{|(notCDom_absSigSum[19:18]), |(notCDom_absSigSum[17:16])},
                 |{|(notCDom_absSigSum[15:14]), |(notCDom_absSigSum[13:12])},
                 |{|(notCDom_absSigSum[11:10]), |(notCDom_absSigSum[9:8])},
                 |{|(notCDom_absSigSum[7:6]), |(notCDom_absSigSum[5:4])},
                 |{|(notCDom_absSigSum[3:2]), |(notCDom_absSigSum[1:0])}}
                & {notCDom_reduced4SigExtra_shift[1],
                   notCDom_reduced4SigExtra_shift[2],
                   notCDom_reduced4SigExtra_shift[3],
                   notCDom_reduced4SigExtra_shift[4],
                   notCDom_reduced4SigExtra_shift[5],
                   notCDom_reduced4SigExtra_shift[6],
                   notCDom_reduced4SigExtra_shift[7],
                   notCDom_reduced4SigExtra_shift[8],
                   notCDom_reduced4SigExtra_shift[9],
                   notCDom_reduced4SigExtra_shift[10],
                   notCDom_reduced4SigExtra_shift[11],
                   notCDom_reduced4SigExtra_shift[12],
                   notCDom_reduced4SigExtra_shift[13]}))};	// Bitwise.scala:103:{21,39,46}, :109:{18,44}, Cat.scala:30:58, MulAddRecFN.scala:207:12, :216:12, :217:{14,21,36}, :218:{19,37}, :221:{24,56}, :224:72, :225:73, :227:25, :228:{25,32,61}, :236:12, :245:{27,50}, :249:{39,78}, :251:11, :253:28, :254:{28,35,39}, :296:25, primitives.scala:77:58, :79:22, :104:{33,54}, :121:{33,54}
endmodule

