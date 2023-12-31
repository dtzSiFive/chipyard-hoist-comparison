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

module MulAddRecFNToRaw_preMul(
  input  [1:0]  io_op,
  input  [32:0] io_a,
                io_b,
                io_c,
  output [23:0] io_mulAddA,
                io_mulAddB,
  output [47:0] io_mulAddC,
  output        io_toPostMul_isSigNaNAny,
                io_toPostMul_isNaNAOrB,
                io_toPostMul_isInfA,
                io_toPostMul_isZeroA,
                io_toPostMul_isInfB,
                io_toPostMul_isZeroB,
                io_toPostMul_signProd,
                io_toPostMul_isNaNC,
                io_toPostMul_isInfC,
                io_toPostMul_isZeroC,
  output [9:0]  io_toPostMul_sExpSum,
  output        io_toPostMul_doSubMags,
                io_toPostMul_CIsDominant,
  output [4:0]  io_toPostMul_CDom_CAlignDist,
  output [25:0] io_toPostMul_highAlignedSigC,
  output        io_toPostMul_bit0AlignedSigC
);

  wire        rawA_isNaN = (&(io_a[31:30])) & io_a[29];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire        rawB_isNaN = (&(io_b[31:30])) & io_b[29];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire        rawC_isNaN = (&(io_c[31:30])) & io_c[29];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire        signProd = io_a[32] ^ io_b[32] ^ io_op[1];	// MulAddRecFN.scala:98:{42,49}, rawFloatFromRecFN.scala:58:25
  wire [10:0] _sExpAlignedProd_T_1 = {2'h0, io_a[31:23]} + {2'h0, io_b[31:23]} - 11'hE5;	// MulAddRecFN.scala:101:{19,32}, :125:30, rawFloatFromRecFN.scala:50:21
  wire        doSubMags = signProd ^ io_c[32] ^ io_op[0];	// MulAddRecFN.scala:98:42, :103:{42,49}, rawFloatFromRecFN.scala:58:25
  wire [10:0] _sNatCAlignDist_T = _sExpAlignedProd_T_1 - {2'h0, io_c[31:23]};	// MulAddRecFN.scala:101:32, :107:42, :125:30, rawFloatFromRecFN.scala:50:21
  wire        isMinCAlign =
    ~(|(io_a[31:29])) | ~(|(io_b[31:29])) | $signed(_sNatCAlignDist_T) < 11'sh0;	// MulAddRecFN.scala:107:42, :109:{50,69}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire        CIsDominant =
    (|(io_c[31:29])) & (isMinCAlign | _sNatCAlignDist_T[9:0] < 10'h19);	// MulAddRecFN.scala:107:42, :108:42, :109:50, :111:{23,39,60}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [6:0]  CAlignDist =
    isMinCAlign ? 7'h0 : _sNatCAlignDist_T[9:0] < 10'h4A ? _sNatCAlignDist_T[6:0] : 7'h4A;	// MulAddRecFN.scala:107:42, :108:42, :109:50, :113:12, :115:{16,34}, :116:33
  wire [77:0] mainAlignedSigC =
    $signed($signed({doSubMags
                       ? {1'h1, ~(|(io_c[31:29])), ~(io_c[22:0])}
                       : {1'h0, |(io_c[31:29]), io_c[22:0]},
                     {53{doSubMags}}}) >>> CAlignDist);	// Bitwise.scala:72:12, Cat.scala:30:58, MulAddRecFN.scala:103:42, :109:69, :113:12, :121:{16,28}, :123:17, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  wire [32:0] reduced4CExtra_shift = $signed(33'sh100000000 >>> CAlignDist[6:2]);	// MulAddRecFN.scala:113:12, :127:28, primitives.scala:77:58
  wire [5:0]  _GEN =
    {|(io_c[21:18]),
     |(io_c[17:14]),
     |(io_c[13:10]),
     |(io_c[9:6]),
     |(io_c[5:2]),
     |(io_c[1:0])}
    & {reduced4CExtra_shift[14],
       reduced4CExtra_shift[15],
       reduced4CExtra_shift[16],
       reduced4CExtra_shift[17],
       reduced4CExtra_shift[18],
       reduced4CExtra_shift[19]};	// Bitwise.scala:109:{18,44}, Cat.scala:30:58, MulAddRecFN.scala:125:68, primitives.scala:77:58, :79:22, :121:{33,54}
  assign io_mulAddA = {|(io_a[31:29]), io_a[22:0]};	// MulAddRecFN.scala:144:16, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  assign io_mulAddB = {|(io_b[31:29]), io_b[22:0]};	// MulAddRecFN.scala:145:16, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  assign io_mulAddC = mainAlignedSigC[50:3];	// MulAddRecFN.scala:123:17, :146:30
  assign io_toPostMul_isSigNaNAny =
    rawA_isNaN & ~(io_a[22]) | rawB_isNaN & ~(io_b[22]) | rawC_isNaN & ~(io_c[22]);	// MulAddRecFN.scala:149:58, common.scala:81:{46,49,56}, rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isNaNAOrB = rawA_isNaN | rawB_isNaN;	// MulAddRecFN.scala:151:42, rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isInfA = (&(io_a[31:30])) & ~(io_a[29]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroA = ~(|(io_a[31:29]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_isInfB = (&(io_b[31:30])) & ~(io_b[29]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroB = ~(|(io_b[31:29]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_signProd = signProd;	// MulAddRecFN.scala:98:42
  assign io_toPostMul_isNaNC = rawC_isNaN;	// rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isInfC = (&(io_c[31:30])) & ~(io_c[29]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroC = ~(|(io_c[31:29]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_sExpSum =
    CIsDominant ? {1'h0, io_c[31:23]} : _sExpAlignedProd_T_1[9:0] - 10'h18;	// MulAddRecFN.scala:101:32, :109:69, :111:23, :161:{12,53}, rawFloatFromRecFN.scala:50:21
  assign io_toPostMul_doSubMags = doSubMags;	// MulAddRecFN.scala:103:42
  assign io_toPostMul_CIsDominant = CIsDominant;	// MulAddRecFN.scala:111:23
  assign io_toPostMul_CDom_CAlignDist = CAlignDist[4:0];	// MulAddRecFN.scala:113:12, :164:47
  assign io_toPostMul_highAlignedSigC = mainAlignedSigC[76:51];	// MulAddRecFN.scala:123:17, :166:20
  assign io_toPostMul_bit0AlignedSigC =
    doSubMags
      ? (&(mainAlignedSigC[2:0])) & ~(|_GEN)
      : (|(mainAlignedSigC[2:0])) | (|_GEN);	// MulAddRecFN.scala:103:42, :123:17, :125:68, :133:11, :136:16, :137:{32,39,44,47}, :138:{39,44}
endmodule

