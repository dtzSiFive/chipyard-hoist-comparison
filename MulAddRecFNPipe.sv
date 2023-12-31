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

module MulAddRecFNPipe(
  input         clock,
                reset,
                io_validin,
  input  [1:0]  io_op,
  input  [32:0] io_a,
                io_b,
                io_c,
  input  [2:0]  io_roundingMode,
  output [32:0] io_out,
  output [4:0]  io_exceptionFlags,
  output        io_validout
);

  wire        _mulAddRecFNToRaw_postMul_io_invalidExc;	// FPU.scala:649:42
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isNaN;	// FPU.scala:649:42
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isInf;	// FPU.scala:649:42
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_isZero;	// FPU.scala:649:42
  wire        _mulAddRecFNToRaw_postMul_io_rawOut_sign;	// FPU.scala:649:42
  wire [9:0]  _mulAddRecFNToRaw_postMul_io_rawOut_sExp;	// FPU.scala:649:42
  wire [26:0] _mulAddRecFNToRaw_postMul_io_rawOut_sig;	// FPU.scala:649:42
  wire [23:0] _mulAddRecFNToRaw_preMul_io_mulAddA;	// FPU.scala:648:41
  wire [23:0] _mulAddRecFNToRaw_preMul_io_mulAddB;	// FPU.scala:648:41
  wire [47:0] _mulAddRecFNToRaw_preMul_io_mulAddC;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfA;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfB;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_signProd;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfC;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC;	// FPU.scala:648:41
  wire [9:0]  _mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant;	// FPU.scala:648:41
  wire [4:0]  _mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist;	// FPU.scala:648:41
  wire [25:0] _mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC;	// FPU.scala:648:41
  wire        _mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC;	// FPU.scala:648:41
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isSigNaNAny;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNAOrB;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfA;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroA;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfB;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroB;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_signProd;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNC;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfC;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroC;	// Reg.scala:15:16
  reg  [9:0]  mulAddRecFNToRaw_postMul_io_fromPreMul_b_sExpSum;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_doSubMags;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_CIsDominant;	// Reg.scala:15:16
  reg  [4:0]  mulAddRecFNToRaw_postMul_io_fromPreMul_b_CDom_CAlignDist;	// Reg.scala:15:16
  reg  [25:0] mulAddRecFNToRaw_postMul_io_fromPreMul_b_highAlignedSigC;	// Reg.scala:15:16
  reg         mulAddRecFNToRaw_postMul_io_fromPreMul_b_bit0AlignedSigC;	// Reg.scala:15:16
  reg  [48:0] mulAddRecFNToRaw_postMul_io_mulAddResult_b;	// Reg.scala:15:16
  reg  [2:0]  mulAddRecFNToRaw_postMul_io_roundingMode_b;	// Reg.scala:15:16
  reg  [2:0]  roundingMode_stage0_b;	// Reg.scala:15:16
  reg         valid_stage0_v;	// Valid.scala:117:22
  reg         roundRawFNToRecFN_io_invalidExc_b;	// Reg.scala:15:16
  reg         roundRawFNToRecFN_io_in_b_isNaN;	// Reg.scala:15:16
  reg         roundRawFNToRecFN_io_in_b_isInf;	// Reg.scala:15:16
  reg         roundRawFNToRecFN_io_in_b_isZero;	// Reg.scala:15:16
  reg         roundRawFNToRecFN_io_in_b_sign;	// Reg.scala:15:16
  reg  [9:0]  roundRawFNToRecFN_io_in_b_sExp;	// Reg.scala:15:16
  reg  [26:0] roundRawFNToRecFN_io_in_b_sig;	// Reg.scala:15:16
  reg  [2:0]  roundRawFNToRecFN_io_roundingMode_b;	// Reg.scala:15:16
  reg         roundRawFNToRecFN_io_detectTininess_b;	// Reg.scala:15:16
  reg         io_validout_v;	// Valid.scala:117:22
  always @(posedge clock) begin
    if (io_validin) begin
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isSigNaNAny <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNAOrB <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfA <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfA;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroA <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfB <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfB;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroB <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_signProd <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_signProd;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNC <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfC <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isInfC;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroC <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_sExpSum <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_doSubMags <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_CIsDominant <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_CDom_CAlignDist <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_highAlignedSigC <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_fromPreMul_b_bit0AlignedSigC <=
        _mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC;	// FPU.scala:648:41, Reg.scala:15:16
      mulAddRecFNToRaw_postMul_io_mulAddResult_b <=
        {1'h0,
         {24'h0, _mulAddRecFNToRaw_preMul_io_mulAddA}
           * {24'h0, _mulAddRecFNToRaw_preMul_io_mulAddB}}
        + {1'h0, _mulAddRecFNToRaw_preMul_io_mulAddC};	// FPU.scala:648:41, :657:45, :658:50, Reg.scala:15:16, Valid.scala:117:22
      mulAddRecFNToRaw_postMul_io_roundingMode_b <= io_roundingMode;	// Reg.scala:15:16
      roundingMode_stage0_b <= io_roundingMode;	// Reg.scala:15:16
    end
    if (valid_stage0_v) begin	// Valid.scala:117:22
      roundRawFNToRecFN_io_invalidExc_b <= _mulAddRecFNToRaw_postMul_io_invalidExc;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_isNaN <= _mulAddRecFNToRaw_postMul_io_rawOut_isNaN;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_isInf <= _mulAddRecFNToRaw_postMul_io_rawOut_isInf;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_isZero <= _mulAddRecFNToRaw_postMul_io_rawOut_isZero;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_sign <= _mulAddRecFNToRaw_postMul_io_rawOut_sign;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_sExp <= _mulAddRecFNToRaw_postMul_io_rawOut_sExp;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_in_b_sig <= _mulAddRecFNToRaw_postMul_io_rawOut_sig;	// FPU.scala:649:42, Reg.scala:15:16
      roundRawFNToRecFN_io_roundingMode_b <= roundingMode_stage0_b;	// Reg.scala:15:16
    end
    roundRawFNToRecFN_io_detectTininess_b <=
      valid_stage0_v | roundRawFNToRecFN_io_detectTininess_b;	// Reg.scala:15:16, :16:{19,23}, Valid.scala:117:22
    if (reset) begin
      valid_stage0_v <= 1'h0;	// Valid.scala:117:22
      io_validout_v <= 1'h0;	// Valid.scala:117:22
    end
    else begin
      valid_stage0_v <= io_validin;	// Valid.scala:117:22
      io_validout_v <= valid_stage0_v;	// Valid.scala:117:22
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:5];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isSigNaNAny = _RANDOM[3'h0][1];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNAOrB = _RANDOM[3'h0][2];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfA = _RANDOM[3'h0][3];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroA = _RANDOM[3'h0][4];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfB = _RANDOM[3'h0][5];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroB = _RANDOM[3'h0][6];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_signProd = _RANDOM[3'h0][7];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNC = _RANDOM[3'h0][8];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfC = _RANDOM[3'h0][9];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroC = _RANDOM[3'h0][10];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_sExpSum = _RANDOM[3'h0][20:11];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_doSubMags = _RANDOM[3'h0][21];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_CIsDominant = _RANDOM[3'h0][22];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_CDom_CAlignDist = _RANDOM[3'h0][27:23];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_highAlignedSigC =
          {_RANDOM[3'h0][31:28], _RANDOM[3'h1][21:0]};	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_fromPreMul_b_bit0AlignedSigC = _RANDOM[3'h1][22];	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_mulAddResult_b =
          {_RANDOM[3'h1][31:24], _RANDOM[3'h2], _RANDOM[3'h3][8:0]};	// Reg.scala:15:16
        mulAddRecFNToRaw_postMul_io_roundingMode_b = _RANDOM[3'h3][12:10];	// Reg.scala:15:16
        roundingMode_stage0_b = _RANDOM[3'h3][16:14];	// Reg.scala:15:16
        valid_stage0_v = _RANDOM[3'h3][19];	// Reg.scala:15:16, Valid.scala:117:22
        roundRawFNToRecFN_io_invalidExc_b = _RANDOM[3'h3][22];	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_isNaN = _RANDOM[3'h3][24];	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_isInf = _RANDOM[3'h3][25];	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_isZero = _RANDOM[3'h3][26];	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_sign = _RANDOM[3'h3][27];	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_sExp = {_RANDOM[3'h3][31:28], _RANDOM[3'h4][5:0]};	// Reg.scala:15:16
        roundRawFNToRecFN_io_in_b_sig = {_RANDOM[3'h4][31:6], _RANDOM[3'h5][0]};	// Reg.scala:15:16
        roundRawFNToRecFN_io_roundingMode_b = _RANDOM[3'h5][4:2];	// Reg.scala:15:16
        roundRawFNToRecFN_io_detectTininess_b = _RANDOM[3'h5][6];	// Reg.scala:15:16
        io_validout_v = _RANDOM[3'h5][7];	// Reg.scala:15:16, Valid.scala:117:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  MulAddRecFNToRaw_preMul mulAddRecFNToRaw_preMul (	// FPU.scala:648:41
    .io_op                        (io_op),
    .io_a                         (io_a),
    .io_b                         (io_b),
    .io_c                         (io_c),
    .io_mulAddA                   (_mulAddRecFNToRaw_preMul_io_mulAddA),
    .io_mulAddB                   (_mulAddRecFNToRaw_preMul_io_mulAddB),
    .io_mulAddC                   (_mulAddRecFNToRaw_preMul_io_mulAddC),
    .io_toPostMul_isSigNaNAny     (_mulAddRecFNToRaw_preMul_io_toPostMul_isSigNaNAny),
    .io_toPostMul_isNaNAOrB       (_mulAddRecFNToRaw_preMul_io_toPostMul_isNaNAOrB),
    .io_toPostMul_isInfA          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfA),
    .io_toPostMul_isZeroA         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroA),
    .io_toPostMul_isInfB          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfB),
    .io_toPostMul_isZeroB         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroB),
    .io_toPostMul_signProd        (_mulAddRecFNToRaw_preMul_io_toPostMul_signProd),
    .io_toPostMul_isNaNC          (_mulAddRecFNToRaw_preMul_io_toPostMul_isNaNC),
    .io_toPostMul_isInfC          (_mulAddRecFNToRaw_preMul_io_toPostMul_isInfC),
    .io_toPostMul_isZeroC         (_mulAddRecFNToRaw_preMul_io_toPostMul_isZeroC),
    .io_toPostMul_sExpSum         (_mulAddRecFNToRaw_preMul_io_toPostMul_sExpSum),
    .io_toPostMul_doSubMags       (_mulAddRecFNToRaw_preMul_io_toPostMul_doSubMags),
    .io_toPostMul_CIsDominant     (_mulAddRecFNToRaw_preMul_io_toPostMul_CIsDominant),
    .io_toPostMul_CDom_CAlignDist (_mulAddRecFNToRaw_preMul_io_toPostMul_CDom_CAlignDist),
    .io_toPostMul_highAlignedSigC (_mulAddRecFNToRaw_preMul_io_toPostMul_highAlignedSigC),
    .io_toPostMul_bit0AlignedSigC (_mulAddRecFNToRaw_preMul_io_toPostMul_bit0AlignedSigC)
  );
  MulAddRecFNToRaw_postMul mulAddRecFNToRaw_postMul (	// FPU.scala:649:42
    .io_fromPreMul_isSigNaNAny     (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isSigNaNAny),	// Reg.scala:15:16
    .io_fromPreMul_isNaNAOrB       (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNAOrB),	// Reg.scala:15:16
    .io_fromPreMul_isInfA          (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfA),	// Reg.scala:15:16
    .io_fromPreMul_isZeroA         (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroA),	// Reg.scala:15:16
    .io_fromPreMul_isInfB          (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfB),	// Reg.scala:15:16
    .io_fromPreMul_isZeroB         (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroB),	// Reg.scala:15:16
    .io_fromPreMul_signProd        (mulAddRecFNToRaw_postMul_io_fromPreMul_b_signProd),	// Reg.scala:15:16
    .io_fromPreMul_isNaNC          (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isNaNC),	// Reg.scala:15:16
    .io_fromPreMul_isInfC          (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isInfC),	// Reg.scala:15:16
    .io_fromPreMul_isZeroC         (mulAddRecFNToRaw_postMul_io_fromPreMul_b_isZeroC),	// Reg.scala:15:16
    .io_fromPreMul_sExpSum         (mulAddRecFNToRaw_postMul_io_fromPreMul_b_sExpSum),	// Reg.scala:15:16
    .io_fromPreMul_doSubMags       (mulAddRecFNToRaw_postMul_io_fromPreMul_b_doSubMags),	// Reg.scala:15:16
    .io_fromPreMul_CIsDominant     (mulAddRecFNToRaw_postMul_io_fromPreMul_b_CIsDominant),	// Reg.scala:15:16
    .io_fromPreMul_CDom_CAlignDist
      (mulAddRecFNToRaw_postMul_io_fromPreMul_b_CDom_CAlignDist),	// Reg.scala:15:16
    .io_fromPreMul_highAlignedSigC
      (mulAddRecFNToRaw_postMul_io_fromPreMul_b_highAlignedSigC),	// Reg.scala:15:16
    .io_fromPreMul_bit0AlignedSigC
      (mulAddRecFNToRaw_postMul_io_fromPreMul_b_bit0AlignedSigC),	// Reg.scala:15:16
    .io_mulAddResult               (mulAddRecFNToRaw_postMul_io_mulAddResult_b),	// Reg.scala:15:16
    .io_roundingMode               (mulAddRecFNToRaw_postMul_io_roundingMode_b),	// Reg.scala:15:16
    .io_invalidExc                 (_mulAddRecFNToRaw_postMul_io_invalidExc),
    .io_rawOut_isNaN               (_mulAddRecFNToRaw_postMul_io_rawOut_isNaN),
    .io_rawOut_isInf               (_mulAddRecFNToRaw_postMul_io_rawOut_isInf),
    .io_rawOut_isZero              (_mulAddRecFNToRaw_postMul_io_rawOut_isZero),
    .io_rawOut_sign                (_mulAddRecFNToRaw_postMul_io_rawOut_sign),
    .io_rawOut_sExp                (_mulAddRecFNToRaw_postMul_io_rawOut_sExp),
    .io_rawOut_sig                 (_mulAddRecFNToRaw_postMul_io_rawOut_sig)
  );
  RoundRawFNToRecFN roundRawFNToRecFN (	// FPU.scala:676:35
    .io_invalidExc     (roundRawFNToRecFN_io_invalidExc_b),	// Reg.scala:15:16
    .io_in_isNaN       (roundRawFNToRecFN_io_in_b_isNaN),	// Reg.scala:15:16
    .io_in_isInf       (roundRawFNToRecFN_io_in_b_isInf),	// Reg.scala:15:16
    .io_in_isZero      (roundRawFNToRecFN_io_in_b_isZero),	// Reg.scala:15:16
    .io_in_sign        (roundRawFNToRecFN_io_in_b_sign),	// Reg.scala:15:16
    .io_in_sExp        (roundRawFNToRecFN_io_in_b_sExp),	// Reg.scala:15:16
    .io_in_sig         (roundRawFNToRecFN_io_in_b_sig),	// Reg.scala:15:16
    .io_roundingMode   (roundRawFNToRecFN_io_roundingMode_b),	// Reg.scala:15:16
    .io_detectTininess (roundRawFNToRecFN_io_detectTininess_b),	// Reg.scala:15:16
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
  assign io_validout = io_validout_v;	// Valid.scala:117:22
endmodule

