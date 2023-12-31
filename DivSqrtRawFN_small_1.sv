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

module DivSqrtRawFN_small_1(
  input         clock,
                reset,
                io_inValid,
                io_sqrtOp,
                io_a_isNaN,
                io_a_isInf,
                io_a_isZero,
                io_a_sign,
  input  [12:0] io_a_sExp,
  input  [53:0] io_a_sig,
  input         io_b_isNaN,
                io_b_isInf,
                io_b_isZero,
                io_b_sign,
  input  [12:0] io_b_sExp,
  input  [53:0] io_b_sig,
  input  [2:0]  io_roundingMode,
  output        io_inReady,
                io_rawOutValid_div,
                io_rawOutValid_sqrt,
  output [2:0]  io_roundingModeOut,
  output        io_invalidExc,
                io_infiniteExc,
                io_rawOut_isNaN,
                io_rawOut_isInf,
                io_rawOut_isZero,
                io_rawOut_sign,
  output [12:0] io_rawOut_sExp,
  output [55:0] io_rawOut_sig
);

  reg  [55:0] cycleNum;	// DivSqrtRecFN_small.scala:223:33
  reg         sqrtOp_Z;	// DivSqrtRecFN_small.scala:225:29
  reg         majorExc_Z;	// DivSqrtRecFN_small.scala:226:29
  reg         isNaN_Z;	// DivSqrtRecFN_small.scala:228:29
  reg         isInf_Z;	// DivSqrtRecFN_small.scala:229:29
  reg         isZero_Z;	// DivSqrtRecFN_small.scala:230:29
  reg         sign_Z;	// DivSqrtRecFN_small.scala:231:29
  reg  [12:0] sExp_Z;	// DivSqrtRecFN_small.scala:232:29
  reg  [51:0] fractB_Z;	// DivSqrtRecFN_small.scala:233:29
  reg  [2:0]  roundingMode_Z;	// DivSqrtRecFN_small.scala:234:29
  reg  [54:0] rem_Z;	// DivSqrtRecFN_small.scala:240:29
  reg         notZeroRem_Z;	// DivSqrtRecFN_small.scala:241:29
  reg  [54:0] sigX_Z;	// DivSqrtRecFN_small.scala:242:29
  wire        inReady = cycleNum[0] | cycleNum[1];	// DivSqrtRecFN_small.scala:223:33, :293:24, :294:{24,35}
  always @(posedge clock) begin
    automatic logic        specialCaseA_S = io_a_isNaN | io_a_isInf | io_a_isZero;	// DivSqrtRecFN_small.scala:270:55
    automatic logic        normalCase_S;	// DivSqrtRecFN_small.scala:274:27
    automatic logic        oddSqrt_S = io_sqrtOp & io_a_sExp[0];	// DivSqrtRecFN_small.scala:288:48, :289:32
    automatic logic        entering;	// DivSqrtRecFN_small.scala:295:28
    automatic logic        entering_normalCase;	// DivSqrtRecFN_small.scala:296:40
    automatic logic        _sigX_Z_T_7;	// DivSqrtRecFN_small.scala:342:21
    automatic logic [55:0] rem;	// DivSqrtRecFN_small.scala:347:11
    automatic logic [54:0] _trialTerm_T_3 =
      inReady & ~io_sqrtOp ? {io_b_sig, 1'h0} : 55'h0;	// DivSqrtRecFN_small.scala:268:33, :294:24, :310:16, :351:{12,21,47}, :357:23
    automatic logic [54:0] _trialTerm_T_9;	// DivSqrtRecFN_small.scala:352:73
    automatic logic [56:0] _trialRem_T_2;	// DivSqrtRecFN_small.scala:356:29
    automatic logic        newBit;	// DivSqrtRecFN_small.scala:357:23
    normalCase_S =
      io_sqrtOp
        ? ~specialCaseA_S & ~io_a_sign
        : ~specialCaseA_S & ~(io_b_isNaN | io_b_isInf | io_b_isZero);	// DivSqrtRecFN_small.scala:270:55, :271:55, :272:{28,45,48}, :273:{46,49}, :274:27
    entering = inReady & io_inValid;	// DivSqrtRecFN_small.scala:294:24, :295:28
    entering_normalCase = entering & normalCase_S;	// DivSqrtRecFN_small.scala:274:27, :295:28, :296:40
    _sigX_Z_T_7 = inReady & oddSqrt_S;	// DivSqrtRecFN_small.scala:289:32, :294:24, :342:21
    rem =
      {1'h0, inReady & ~oddSqrt_S ? {io_a_sig, 1'h0} : 55'h0}
      | (_sigX_Z_T_7 ? {io_a_sig[52:51] - 2'h1, io_a_sig[50:0], 3'h0} : 56'h0)
      | (inReady ? 56'h0 : {rem_Z, 1'h0});	// Cat.scala:30:58, DivSqrtRecFN_small.scala:240:29, :289:32, :294:24, :303:16, :310:16, :341:{12,21,24,47,57}, :342:{12,21}, :343:{27,56}, :344:27, :347:11, :348:{12,29}, :357:23
    _trialTerm_T_9 =
      {_trialTerm_T_3[54],
       _trialTerm_T_3[53:0] | {inReady & io_sqrtOp & ~(io_a_sExp[0]), 53'h0}}
      | (_sigX_Z_T_7 ? 55'h50000000000000 : 55'h0);	// DivSqrtRecFN_small.scala:288:{35,48}, :294:24, :310:16, :342:21, :351:{12,73}, :352:{12,21,73}, :353:12, :367:16
    _trialRem_T_2 =
      {1'h0, rem}
      - {1'h0,
         {1'h0,
          _trialTerm_T_9[54],
          _trialTerm_T_9[53:0] | (inReady | sqrtOp_Z ? 54'h0 : {1'h1, fractB_Z, 1'h0})}
           | (~inReady & sqrtOp_Z
                ? {sigX_Z[54:53], {sigX_Z[52:0], 1'h0} | cycleNum[55:2]}
                : 56'h0)};	// DivSqrtRecFN_small.scala:223:33, :225:29, :233:29, :242:29, :294:24, :303:16, :343:56, :347:11, :348:13, :349:27, :352:{12,73}, :353:73, :354:{12,56,73}, :355:{12,23,48}, :356:29, :357:23
    newBit = $signed(_trialRem_T_2) > -57'sh1;	// DivSqrtRecFN_small.scala:356:29, :357:23
    if (reset)
      cycleNum <= 56'h1;	// DivSqrtRecFN_small.scala:223:33
    else if (~(cycleNum[0]) | entering) begin	// DivSqrtRecFN_small.scala:223:33, :293:24, :295:28, :300:{11,18}
      automatic logic        skipCycle2;	// DivSqrtRecFN_small.scala:298:34
      automatic logic [55:0] _cycleNum_T_7;	// DivSqrtRecFN_small.scala:302:59
      automatic logic [54:0] _GEN;	// DivSqrtRecFN_small.scala:309:15
      skipCycle2 = cycleNum[3] & sigX_Z[54];	// DivSqrtRecFN_small.scala:223:33, :242:29, :298:{30,34,43}
      _cycleNum_T_7 =
        {54'h0, entering & ~normalCase_S, 1'h0}
        | (entering_normalCase
             ? (io_sqrtOp
                  ? {1'h0, io_a_sExp[0] ? 55'h20000000000000 : 55'h40000000000000}
                  : 56'h80000000000000)
             : 56'h0);	// DivSqrtRecFN_small.scala:274:27, :288:48, :295:28, :296:40, :302:{26,28,59}, :303:16, :304:20, :305:24, :352:12, :357:23
      _GEN = _cycleNum_T_7[54:0] | (entering | skipCycle2 ? 55'h0 : cycleNum[55:1]);	// DivSqrtRecFN_small.scala:223:33, :295:28, :298:34, :302:59, :309:15, :310:{16,53}
      cycleNum <= {_cycleNum_T_7[55], _GEN[54:2], _GEN[1:0] | {skipCycle2, 1'h0}};	// DivSqrtRecFN_small.scala:223:33, :298:34, :302:59, :309:15, :310:63, :311:16, :357:23
    end
    if (entering) begin	// DivSqrtRecFN_small.scala:295:28
      sqrtOp_Z <= io_sqrtOp;	// DivSqrtRecFN_small.scala:225:29
      if (io_sqrtOp) begin
        automatic logic notSigNaNIn_invalidExc_S_sqrt =
          ~io_a_isNaN & ~io_a_isZero & io_a_sign;	// DivSqrtRecFN_small.scala:253:{9,27,43}
        majorExc_Z <= io_a_isNaN & ~(io_a_sig[51]) | notSigNaNIn_invalidExc_S_sqrt;	// DivSqrtRecFN_small.scala:226:29, :253:43, :256:38, common.scala:81:{46,49,56}
        isNaN_Z <= io_a_isNaN | notSigNaNIn_invalidExc_S_sqrt;	// DivSqrtRecFN_small.scala:228:29, :253:43, :263:26
      end
      else begin
        automatic logic notSigNaNIn_invalidExc_S_div =
          io_a_isZero & io_b_isZero | io_a_isInf & io_b_isInf;	// DivSqrtRecFN_small.scala:251:{24,42,59}
        majorExc_Z <=
          io_a_isNaN & ~(io_a_sig[51]) | io_b_isNaN & ~(io_b_sig[51])
          | notSigNaNIn_invalidExc_S_div | ~io_a_isNaN & ~io_a_isInf & io_b_isZero;	// DivSqrtRecFN_small.scala:226:29, :251:42, :253:9, :258:46, :259:{36,51}, common.scala:81:{46,49,56}
        isNaN_Z <= io_a_isNaN | io_b_isNaN | notSigNaNIn_invalidExc_S_div;	// DivSqrtRecFN_small.scala:228:29, :251:42, :264:42
      end
      isInf_Z <= ~io_sqrtOp & io_b_isZero | io_a_isInf;	// DivSqrtRecFN_small.scala:229:29, :266:23
      isZero_Z <= ~io_sqrtOp & io_b_isInf | io_a_isZero;	// DivSqrtRecFN_small.scala:230:29, :266:23, :267:23
      sign_Z <= io_a_sign ^ ~io_sqrtOp & io_b_sign;	// DivSqrtRecFN_small.scala:231:29, :268:{30,33,45}
    end
    if (entering_normalCase) begin	// DivSqrtRecFN_small.scala:296:40
      if (io_sqrtOp)
        sExp_Z <= {io_a_sExp[12], io_a_sExp[12:1]} + 13'h400;	// DivSqrtRecFN_small.scala:232:29, :277:21, :329:{29,34}
      else begin
        automatic logic [13:0] sExpQuot_S_div =
          {io_a_sExp[12], io_a_sExp} + {{3{io_b_sExp[11]}}, ~(io_b_sExp[10:0])};	// DivSqrtRecFN_small.scala:277:21, :278:{28,40,52}
        sExp_Z <=
          {$signed(sExpQuot_S_div) > 14'shDFF ? 4'h6 : sExpQuot_S_div[12:9],
           sExpQuot_S_div[8:0]};	// Cat.scala:30:58, DivSqrtRecFN_small.scala:232:29, :277:21, :281:{16,48}, :283:31, :285:27
      end
      roundingMode_Z <= io_roundingMode;	// DivSqrtRecFN_small.scala:234:29
    end
    if (entering_normalCase & ~io_sqrtOp)	// DivSqrtRecFN_small.scala:268:33, :296:40, :334:31
      fractB_Z <= io_b_sig[51:0];	// DivSqrtRecFN_small.scala:233:29, :335:31
    if (entering_normalCase | ~(cycleNum[0] | cycleNum[2]))	// DivSqrtRecFN_small.scala:223:33, :293:24, :296:40, :359:{31,34,41,52}
      rem_Z <= newBit ? _trialRem_T_2[54:0] : rem[54:0];	// DivSqrtRecFN_small.scala:240:29, :347:11, :356:{24,29}, :357:23, :360:21
    if (entering_normalCase | ~inReady & newBit) begin	// DivSqrtRecFN_small.scala:294:24, :296:40, :348:13, :357:23, :362:{31,45}
      automatic logic [54:0] _sigX_Z_T_3;	// DivSqrtRecFN_small.scala:365:16
      automatic logic [53:0] _GEN_0;	// DivSqrtRecFN_small.scala:365:71
      _sigX_Z_T_3 = inReady & ~io_sqrtOp ? {newBit, 54'h0} : 55'h0;	// DivSqrtRecFN_small.scala:268:33, :294:24, :310:16, :352:12, :357:23, :365:{16,25,47}
      _GEN_0 = _sigX_Z_T_3[53:0] | {inReady & io_sqrtOp, 53'h0};	// DivSqrtRecFN_small.scala:294:24, :365:{16,71}, :366:{16,25}, :367:16
      notZeroRem_Z <= |_trialRem_T_2;	// DivSqrtRecFN_small.scala:241:29, :356:29, :363:35
      sigX_Z <=
        {_sigX_Z_T_3[54],
         _GEN_0[53],
         _GEN_0[52:0] | (_sigX_Z_T_7 ? {newBit, 52'h0} : 53'h0)}
        | (inReady ? 55'h0 : {sigX_Z[54], sigX_Z[53:0] | cycleNum[55:2]});	// DivSqrtRecFN_small.scala:223:33, :242:29, :294:24, :310:16, :342:21, :349:27, :357:23, :365:{16,71}, :366:71, :367:{16,47,71}, :368:{16,48}
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:7];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h8; i += 4'h1) begin
          _RANDOM[i[2:0]] = `RANDOM;
        end
        cycleNum = {_RANDOM[3'h0], _RANDOM[3'h1][23:0]};	// DivSqrtRecFN_small.scala:223:33
        sqrtOp_Z = _RANDOM[3'h1][24];	// DivSqrtRecFN_small.scala:223:33, :225:29
        majorExc_Z = _RANDOM[3'h1][25];	// DivSqrtRecFN_small.scala:223:33, :226:29
        isNaN_Z = _RANDOM[3'h1][26];	// DivSqrtRecFN_small.scala:223:33, :228:29
        isInf_Z = _RANDOM[3'h1][27];	// DivSqrtRecFN_small.scala:223:33, :229:29
        isZero_Z = _RANDOM[3'h1][28];	// DivSqrtRecFN_small.scala:223:33, :230:29
        sign_Z = _RANDOM[3'h1][29];	// DivSqrtRecFN_small.scala:223:33, :231:29
        sExp_Z = {_RANDOM[3'h1][31:30], _RANDOM[3'h2][10:0]};	// DivSqrtRecFN_small.scala:223:33, :232:29
        fractB_Z = {_RANDOM[3'h2][31:11], _RANDOM[3'h3][30:0]};	// DivSqrtRecFN_small.scala:232:29, :233:29
        roundingMode_Z = {_RANDOM[3'h3][31], _RANDOM[3'h4][1:0]};	// DivSqrtRecFN_small.scala:233:29, :234:29
        rem_Z = {_RANDOM[3'h4][31:2], _RANDOM[3'h5][24:0]};	// DivSqrtRecFN_small.scala:234:29, :240:29
        notZeroRem_Z = _RANDOM[3'h5][25];	// DivSqrtRecFN_small.scala:240:29, :241:29
        sigX_Z = {_RANDOM[3'h5][31:26], _RANDOM[3'h6], _RANDOM[3'h7][16:0]};	// DivSqrtRecFN_small.scala:240:29, :242:29
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_inReady = inReady;	// DivSqrtRecFN_small.scala:294:24
  assign io_rawOutValid_div = cycleNum[1] & ~sqrtOp_Z;	// DivSqrtRecFN_small.scala:223:33, :225:29, :294:35, :354:26, :375:40
  assign io_rawOutValid_sqrt = cycleNum[1] & sqrtOp_Z;	// DivSqrtRecFN_small.scala:223:33, :225:29, :294:35, :376:40
  assign io_roundingModeOut = roundingMode_Z;	// DivSqrtRecFN_small.scala:234:29
  assign io_invalidExc = majorExc_Z & isNaN_Z;	// DivSqrtRecFN_small.scala:226:29, :228:29, :378:36
  assign io_infiniteExc = majorExc_Z & ~isNaN_Z;	// DivSqrtRecFN_small.scala:226:29, :228:29, :379:{36,39}
  assign io_rawOut_isNaN = isNaN_Z;	// DivSqrtRecFN_small.scala:228:29
  assign io_rawOut_isInf = isInf_Z;	// DivSqrtRecFN_small.scala:229:29
  assign io_rawOut_isZero = isZero_Z;	// DivSqrtRecFN_small.scala:230:29
  assign io_rawOut_sign = sign_Z;	// DivSqrtRecFN_small.scala:231:29
  assign io_rawOut_sExp = sExp_Z;	// DivSqrtRecFN_small.scala:232:29
  assign io_rawOut_sig = {sigX_Z, notZeroRem_Z};	// DivSqrtRecFN_small.scala:241:29, :242:29, :385:35
endmodule

