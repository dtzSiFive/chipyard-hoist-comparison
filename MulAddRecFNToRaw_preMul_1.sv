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

module MulAddRecFNToRaw_preMul_1(
  input  [1:0]   io_op,
  input  [64:0]  io_a,
                 io_b,
                 io_c,
  output [52:0]  io_mulAddA,
                 io_mulAddB,
  output [105:0] io_mulAddC,
  output         io_toPostMul_isSigNaNAny,
                 io_toPostMul_isNaNAOrB,
                 io_toPostMul_isInfA,
                 io_toPostMul_isZeroA,
                 io_toPostMul_isInfB,
                 io_toPostMul_isZeroB,
                 io_toPostMul_signProd,
                 io_toPostMul_isNaNC,
                 io_toPostMul_isInfC,
                 io_toPostMul_isZeroC,
  output [12:0]  io_toPostMul_sExpSum,
  output         io_toPostMul_doSubMags,
                 io_toPostMul_CIsDominant,
  output [5:0]   io_toPostMul_CDom_CAlignDist,
  output [54:0]  io_toPostMul_highAlignedSigC,
  output         io_toPostMul_bit0AlignedSigC
);

  wire         rawA_isNaN = (&(io_a[63:62])) & io_a[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire         rawB_isNaN = (&(io_b[63:62])) & io_b[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire         rawC_isNaN = (&(io_c[63:62])) & io_c[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire         signProd = io_a[64] ^ io_b[64] ^ io_op[1];	// MulAddRecFN.scala:98:{42,49}, rawFloatFromRecFN.scala:58:25
  wire [13:0]  _sExpAlignedProd_T_1 = {2'h0, io_a[63:52]} + {2'h0, io_b[63:52]} - 14'h7C8;	// MulAddRecFN.scala:101:{19,32}, primitives.scala:124:57, rawFloatFromRecFN.scala:50:21
  wire         doSubMags = signProd ^ io_c[64] ^ io_op[0];	// MulAddRecFN.scala:98:42, :103:{42,49}, rawFloatFromRecFN.scala:58:25
  wire [13:0]  _sNatCAlignDist_T = _sExpAlignedProd_T_1 - {2'h0, io_c[63:52]};	// MulAddRecFN.scala:101:32, :107:42, primitives.scala:124:57, rawFloatFromRecFN.scala:50:21
  wire         isMinCAlign =
    ~(|(io_a[63:61])) | ~(|(io_b[63:61])) | $signed(_sNatCAlignDist_T) < 14'sh0;	// MulAddRecFN.scala:107:42, :109:{50,69}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire         CIsDominant =
    (|(io_c[63:61])) & (isMinCAlign | _sNatCAlignDist_T[12:0] < 13'h36);	// MulAddRecFN.scala:107:42, :108:42, :109:50, :111:{23,39,60}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [7:0]   CAlignDist =
    isMinCAlign
      ? 8'h0
      : _sNatCAlignDist_T[12:0] < 13'hA1 ? _sNatCAlignDist_T[7:0] : 8'hA1;	// MulAddRecFN.scala:107:42, :108:42, :109:50, :113:12, :115:{16,34}, :116:33
  wire [164:0] mainAlignedSigC =
    $signed($signed({doSubMags
                       ? {1'h1, ~(|(io_c[63:61])), ~(io_c[51:0])}
                       : {1'h0, |(io_c[63:61]), io_c[51:0]},
                     {111{doSubMags}}}) >>> CAlignDist);	// Bitwise.scala:72:12, Cat.scala:30:58, MulAddRecFN.scala:103:42, :109:69, :113:12, :121:{16,28}, :123:17, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  wire [64:0]  reduced4CExtra_shift = $signed(65'sh10000000000000000 >>> CAlignDist[7:2]);	// MulAddRecFN.scala:113:12, :127:28, primitives.scala:77:58
  wire [12:0]  _GEN =
    {|(io_c[51:48]),
     |(io_c[47:44]),
     |(io_c[43:40]),
     |(io_c[39:36]),
     |(io_c[35:32]),
     |(io_c[31:28]),
     |(io_c[27:24]),
     |(io_c[23:20]),
     |(io_c[19:16]),
     |(io_c[15:12]),
     |(io_c[11:8]),
     |(io_c[7:4]),
     |(io_c[3:0])}
    & {reduced4CExtra_shift[24],
       reduced4CExtra_shift[25],
       reduced4CExtra_shift[26],
       reduced4CExtra_shift[27],
       reduced4CExtra_shift[28],
       reduced4CExtra_shift[29],
       reduced4CExtra_shift[30],
       reduced4CExtra_shift[31],
       reduced4CExtra_shift[32],
       reduced4CExtra_shift[33],
       reduced4CExtra_shift[34],
       reduced4CExtra_shift[35],
       reduced4CExtra_shift[36]};	// Bitwise.scala:103:{21,39,46}, :109:{18,44}, Cat.scala:30:58, MulAddRecFN.scala:125:68, primitives.scala:77:58, :79:22, :121:{33,54}
  assign io_mulAddA = {|(io_a[63:61]), io_a[51:0]};	// MulAddRecFN.scala:144:16, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  assign io_mulAddB = {|(io_b[63:61]), io_b[51:0]};	// MulAddRecFN.scala:145:16, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  assign io_mulAddC = mainAlignedSigC[108:3];	// MulAddRecFN.scala:123:17, :146:30
  assign io_toPostMul_isSigNaNAny =
    rawA_isNaN & ~(io_a[51]) | rawB_isNaN & ~(io_b[51]) | rawC_isNaN & ~(io_c[51]);	// MulAddRecFN.scala:149:58, common.scala:81:{46,49,56}, rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isNaNAOrB = rawA_isNaN | rawB_isNaN;	// MulAddRecFN.scala:151:42, rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isInfA = (&(io_a[63:62])) & ~(io_a[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroA = ~(|(io_a[63:61]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_isInfB = (&(io_b[63:62])) & ~(io_b[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroB = ~(|(io_b[63:61]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_signProd = signProd;	// MulAddRecFN.scala:98:42
  assign io_toPostMul_isNaNC = rawC_isNaN;	// rawFloatFromRecFN.scala:55:33
  assign io_toPostMul_isInfC = (&(io_c[63:62])) & ~(io_c[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  assign io_toPostMul_isZeroC = ~(|(io_c[63:61]));	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
  assign io_toPostMul_sExpSum =
    CIsDominant ? {1'h0, io_c[63:52]} : _sExpAlignedProd_T_1[12:0] - 13'h35;	// MulAddRecFN.scala:101:32, :109:69, :111:23, :161:{12,53}, rawFloatFromRecFN.scala:50:21
  assign io_toPostMul_doSubMags = doSubMags;	// MulAddRecFN.scala:103:42
  assign io_toPostMul_CIsDominant = CIsDominant;	// MulAddRecFN.scala:111:23
  assign io_toPostMul_CDom_CAlignDist = CAlignDist[5:0];	// MulAddRecFN.scala:113:12, :164:47
  assign io_toPostMul_highAlignedSigC = mainAlignedSigC[163:109];	// MulAddRecFN.scala:123:17, :166:20
  assign io_toPostMul_bit0AlignedSigC =
    doSubMags
      ? (&(mainAlignedSigC[2:0])) & ~(|_GEN)
      : (|(mainAlignedSigC[2:0])) | (|_GEN);	// MulAddRecFN.scala:103:42, :123:17, :125:68, :133:11, :136:16, :137:{32,39,44,47}, :138:{39,44}
endmodule

