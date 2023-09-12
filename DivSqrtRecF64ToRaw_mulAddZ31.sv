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

module DivSqrtRecF64ToRaw_mulAddZ31(
  input          clock,
                 reset,
                 io_inValid,
                 io_sqrtOp,
  input  [64:0]  io_a,
                 io_b,
  input  [2:0]   io_roundingMode,
  input  [104:0] io_mulAddResult_3,
  output         io_inReady_div,
                 io_inReady_sqrt,
  output [3:0]   io_usingMulAdd,
  output         io_latchMulAddA_0,
  output [53:0]  io_mulAddA_0,
  output         io_latchMulAddB_0,
  output [53:0]  io_mulAddB_0,
  output [104:0] io_mulAddC_2,
  output         io_rawOutValid_div,
                 io_rawOutValid_sqrt,
  output [2:0]   io_roundingModeOut,
  output         io_invalidExc,
                 io_infiniteExc,
                 io_rawOut_isNaN,
                 io_rawOut_isInf,
                 io_rawOut_isZero,
                 io_rawOut_sign,
  output [12:0]  io_rawOut_sExp,
  output [55:0]  io_rawOut_sig
);

  wire [53:0]  zComplSigT_C1_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:643:12
  wire [52:0]  _GEN;	// DivSqrtRecF64_mulAddZ31.scala:640:11
  wire         _zComplSigT_C1_T_5_53;	// DivSqrtRecF64_mulAddZ31.scala:640:11
  wire [45:0]  zSigma1_B4;	// DivSqrtRecF64_mulAddZ31.scala:632:22
  wire         _io_inReady_sqrt_output;	// DivSqrtRecF64_mulAddZ31.scala:434:26
  wire         _io_inReady_div_output;	// DivSqrtRecF64_mulAddZ31.scala:431:22
  wire         ready_PC;	// DivSqrtRecF64_mulAddZ31.scala:422:28
  wire         ready_PB;	// DivSqrtRecF64_mulAddZ31.scala:389:28
  reg  [2:0]   cycleNum_A;	// DivSqrtRecF64_mulAddZ31.scala:85:30
  reg  [3:0]   cycleNum_B;	// DivSqrtRecF64_mulAddZ31.scala:86:30
  reg  [2:0]   cycleNum_C;	// DivSqrtRecF64_mulAddZ31.scala:87:30
  reg  [2:0]   cycleNum_E;	// DivSqrtRecF64_mulAddZ31.scala:88:30
  reg          valid_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30
  reg          sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:91:30
  reg          majorExc_PA;	// DivSqrtRecF64_mulAddZ31.scala:92:30
  reg          isNaN_PA;	// DivSqrtRecF64_mulAddZ31.scala:94:30
  reg          isInf_PA;	// DivSqrtRecF64_mulAddZ31.scala:95:30
  reg          isZero_PA;	// DivSqrtRecF64_mulAddZ31.scala:96:30
  reg          sign_PA;	// DivSqrtRecF64_mulAddZ31.scala:97:30
  reg  [12:0]  sExp_PA;	// DivSqrtRecF64_mulAddZ31.scala:98:30
  reg  [51:0]  fractB_PA;	// DivSqrtRecF64_mulAddZ31.scala:99:30
  reg  [51:0]  fractA_PA;	// DivSqrtRecF64_mulAddZ31.scala:100:30
  reg  [2:0]   roundingMode_PA;	// DivSqrtRecF64_mulAddZ31.scala:101:30
  reg          valid_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30
  reg          sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30
  reg          majorExc_PB;	// DivSqrtRecF64_mulAddZ31.scala:105:30
  reg          isNaN_PB;	// DivSqrtRecF64_mulAddZ31.scala:107:30
  reg          isInf_PB;	// DivSqrtRecF64_mulAddZ31.scala:108:30
  reg          isZero_PB;	// DivSqrtRecF64_mulAddZ31.scala:109:30
  reg          sign_PB;	// DivSqrtRecF64_mulAddZ31.scala:110:30
  reg  [12:0]  sExp_PB;	// DivSqrtRecF64_mulAddZ31.scala:111:30
  reg          bit0FractA_PB;	// DivSqrtRecF64_mulAddZ31.scala:112:30
  reg  [51:0]  fractB_PB;	// DivSqrtRecF64_mulAddZ31.scala:113:30
  reg  [2:0]   roundingMode_PB;	// DivSqrtRecF64_mulAddZ31.scala:114:30
  reg          valid_PC;	// DivSqrtRecF64_mulAddZ31.scala:116:30
  reg          sqrtOp_PC;	// DivSqrtRecF64_mulAddZ31.scala:117:30
  reg          majorExc_PC;	// DivSqrtRecF64_mulAddZ31.scala:118:30
  reg          isNaN_PC;	// DivSqrtRecF64_mulAddZ31.scala:120:30
  reg          isInf_PC;	// DivSqrtRecF64_mulAddZ31.scala:121:30
  reg          isZero_PC;	// DivSqrtRecF64_mulAddZ31.scala:122:30
  reg          sign_PC;	// DivSqrtRecF64_mulAddZ31.scala:123:30
  reg  [12:0]  sExp_PC;	// DivSqrtRecF64_mulAddZ31.scala:124:30
  reg          bit0FractA_PC;	// DivSqrtRecF64_mulAddZ31.scala:125:30
  reg  [51:0]  fractB_PC;	// DivSqrtRecF64_mulAddZ31.scala:126:30
  reg  [2:0]   roundingMode_PC;	// DivSqrtRecF64_mulAddZ31.scala:127:30
  reg  [8:0]   fractR0_A;	// DivSqrtRecF64_mulAddZ31.scala:129:30
  reg  [9:0]   hiSqrR0_A_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:131:30
  reg  [20:0]  partNegSigma0_A;	// DivSqrtRecF64_mulAddZ31.scala:132:30
  reg  [8:0]   nextMulAdd9A_A;	// DivSqrtRecF64_mulAddZ31.scala:133:30
  reg  [8:0]   nextMulAdd9B_A;	// DivSqrtRecF64_mulAddZ31.scala:134:30
  reg  [16:0]  ER1_B_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:135:30
  reg  [31:0]  ESqrR1_B_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:137:30
  reg  [57:0]  sigX1_B;	// DivSqrtRecF64_mulAddZ31.scala:138:30
  reg  [32:0]  sqrSigma1_C;	// DivSqrtRecF64_mulAddZ31.scala:139:30
  reg  [57:0]  sigXN_C;	// DivSqrtRecF64_mulAddZ31.scala:140:30
  reg  [30:0]  u_C_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:141:30
  reg          E_E_div;	// DivSqrtRecF64_mulAddZ31.scala:142:30
  reg  [53:0]  sigT_E;	// DivSqrtRecF64_mulAddZ31.scala:143:30
  reg          isNegRemT_E;	// DivSqrtRecF64_mulAddZ31.scala:144:30
  reg          isZeroRemT_E;	// DivSqrtRecF64_mulAddZ31.scala:145:30
  wire         cyc_S_div = _io_inReady_div_output & io_inValid & ~io_sqrtOp;	// DivSqrtRecF64_mulAddZ31.scala:163:{52,55}, :431:22
  wire         cyc_S_sqrt = _io_inReady_sqrt_output & io_inValid & io_sqrtOp;	// DivSqrtRecF64_mulAddZ31.scala:164:52, :434:26
  wire         cyc_S = cyc_S_div | cyc_S_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:163:52, :164:52, :165:27
  wire         rawA_S_isZero = io_a[63:61] == 3'h0;	// DivSqrtRecF64_mulAddZ31.scala:85:30, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire         rawA_S_isNaN = (&(io_a[63:62])) & io_a[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire         rawA_S_isInf = (&(io_a[63:62])) & ~(io_a[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire         rawB_S_isNaN = (&(io_b[63:62])) & io_b[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire         rawB_S_isInf = (&(io_b[63:62])) & ~(io_b[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire         specialCaseB_S = rawB_S_isNaN | rawB_S_isInf | ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:191:55, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :55:33, :56:33
  wire         normalCase_S_div =
    ~(rawA_S_isNaN | rawA_S_isInf | rawA_S_isZero) & ~specialCaseB_S;	// DivSqrtRecF64_mulAddZ31.scala:190:55, :191:55, :192:{28,45,48}, rawFloatFromRecFN.scala:51:54, :55:33, :56:33
  wire         normalCase_S_sqrt = ~specialCaseB_S & ~(io_b[64]);	// DivSqrtRecF64_mulAddZ31.scala:191:55, :192:48, :193:{46,49}, rawFloatFromRecFN.scala:58:25
  wire         cyc_A4_div = cyc_S_div & normalCase_S_div;	// DivSqrtRecF64_mulAddZ31.scala:163:52, :192:45, :209:50
  wire         cyc_A7_sqrt = cyc_S_sqrt & normalCase_S_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:164:52, :193:46, :210:50
  wire         cyc_A6_sqrt = cycleNum_A == 3'h6;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :200:16, :224:35
  wire         cyc_A5_sqrt = cycleNum_A == 3'h5;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :225:35
  wire         cyc_A4_sqrt = cycleNum_A == 3'h4;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :226:35
  wire         cyc_A4 = cyc_A4_sqrt | cyc_A4_div;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :226:35, :230:30
  wire         cyc_A3 = cycleNum_A == 3'h3;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :231:30
  wire         cyc_A2 = cycleNum_A == 3'h2;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :232:30
  wire         cyc_A1 = cycleNum_A == 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :233:30
  wire         cyc_A3_div = cyc_A3 & ~sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:91:30, :231:30, :235:{29,32}
  wire         cyc_A1_div = cyc_A1 & ~sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:91:30, :233:30, :235:32, :237:29
  wire         cyc_A1_sqrt = cyc_A1 & sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:91:30, :233:30, :241:30
  wire         cyc_B9_sqrt = cycleNum_B == 4'h9;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :252:36
  wire         cyc_B8_sqrt = cycleNum_B == 4'h8;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :253:36
  wire         cyc_B7_sqrt = cycleNum_B == 4'h7;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :254:36
  wire         cyc_B6 = cycleNum_B == 4'h6;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :200:16, :256:30
  wire         cyc_B5 = cycleNum_B == 4'h5;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :257:30
  wire         cyc_B4 = cycleNum_B == 4'h4;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :258:30
  wire         cyc_B3 = cycleNum_B == 4'h3;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :259:30
  wire         cyc_B2 = cycleNum_B == 4'h2;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :260:30
  wire         cyc_B1 = cycleNum_B == 4'h1;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :220:57, :261:30
  wire         cyc_B6_div = cyc_B6 & valid_PA & ~sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :91:30, :235:32, :256:30, :263:41
  wire         cyc_B2_div = cyc_B2 & ~sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :260:30, :266:32, :267:29
  wire         cyc_B6_sqrt = cyc_B6 & valid_PB & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :104:30, :256:30, :270:42
  wire         cyc_B5_sqrt = cyc_B5 & valid_PB & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :104:30, :257:30, :271:42
  wire         cyc_B4_sqrt = cyc_B4 & valid_PB & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :104:30, :258:30, :272:42
  wire         cyc_B3_sqrt = cyc_B3 & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :259:30, :273:30
  wire         cyc_B2_sqrt = cyc_B2 & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :260:30, :274:30
  wire         cyc_B1_sqrt = cyc_B1 & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :261:30, :275:30
  wire         cyc_C6_sqrt = cycleNum_C == 3'h6;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :200:16, :282:35
  wire         cyc_C5 = cycleNum_C == 3'h5;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :225:35, :284:30
  wire         cyc_C4 = cycleNum_C == 3'h4;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :226:35, :285:30
  wire         cyc_C3 = cycleNum_C == 3'h3;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :231:30, :286:30
  wire         cyc_C2 = cycleNum_C == 3'h2;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :232:30, :287:30
  wire         cyc_C1 = cycleNum_C == 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :233:30, :288:30
  wire         cyc_C1_div = cyc_C1 & ~sqrtOp_PC;	// DivSqrtRecF64_mulAddZ31.scala:117:30, :288:30, :293:32, :294:29
  wire         cyc_C4_sqrt = cyc_C4 & sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :285:30, :297:30
  wire         cyc_C1_sqrt = cyc_C1 & sqrtOp_PC;	// DivSqrtRecF64_mulAddZ31.scala:117:30, :288:30, :300:30
  wire         cyc_E3 = cycleNum_E == 3'h3;	// DivSqrtRecF64_mulAddZ31.scala:88:30, :231:30, :307:30
  wire         normalCase_PA = ~isNaN_PA & ~isInf_PA & ~isZero_PA;	// DivSqrtRecF64_mulAddZ31.scala:94:30, :95:30, :96:30, :346:{25,39,50,53}
  wire         valid_normalCase_leaving_PA = cyc_B4 & valid_PA & ~sqrtOp_PA | cyc_B7_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :91:30, :235:32, :254:36, :258:30, :265:41, :350:50
  wire         valid_leaving_PA = normalCase_PA ? valid_normalCase_leaving_PA : ready_PB;	// DivSqrtRecF64_mulAddZ31.scala:346:50, :350:50, :352:12, :389:28
  wire         leaving_PA = valid_PA & valid_leaving_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :352:12, :353:28
  wire         ready_PA = ~valid_PA | valid_leaving_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :352:12, :354:{17,28}
  wire         normalCase_PB = ~isNaN_PB & ~isInf_PB & ~isZero_PB;	// DivSqrtRecF64_mulAddZ31.scala:107:30, :108:30, :109:30, :383:{25,39,50,53}
  wire         valid_leaving_PB = normalCase_PB ? cyc_C3 : ready_PC;	// DivSqrtRecF64_mulAddZ31.scala:286:30, :383:50, :387:12, :422:28
  wire         leaving_PB = valid_PB & valid_leaving_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :387:12, :388:28
  assign ready_PB = ~valid_PB | valid_leaving_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :360:29, :387:12, :389:28
  wire         valid_leaving_PC =
    ~(~isNaN_PC & ~isInf_PC & ~isZero_PC) | cycleNum_E == 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:88:30, :120:30, :121:30, :122:30, :233:30, :309:30, :417:{25,39,50,53}, :420:{28,44}
  wire         leaving_PC = valid_PC & valid_leaving_PC;	// DivSqrtRecF64_mulAddZ31.scala:116:30, :420:44, :421:28
  assign ready_PC = ~valid_PC | valid_leaving_PC;	// DivSqrtRecF64_mulAddZ31.scala:116:30, :420:44, :422:{17,28}
  assign _io_inReady_div_output =
    ready_PA & ~cyc_B7_sqrt & ~cyc_B6_sqrt & ~cyc_B5_sqrt & ~cyc_B4_sqrt & ~cyc_B3
    & ~cyc_B2 & ~cyc_B1_sqrt & ~cyc_C5 & ~cyc_C4;	// DivSqrtRecF64_mulAddZ31.scala:254:36, :259:30, :260:30, :270:42, :271:42, :272:42, :275:30, :284:30, :285:30, :354:28, :429:{21,38,55}, :430:{13,30,42,54}, :431:{13,22,25}
  assign _io_inReady_sqrt_output =
    ready_PA & ~cyc_B6_sqrt & ~cyc_B5_sqrt & ~cyc_B4_sqrt & ~cyc_B2_div & ~cyc_B1_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:267:29, :270:42, :271:42, :272:42, :275:30, :354:28, :429:{38,55}, :430:{13,54}, :434:{13,26}
  wire [13:0]  zFractB_A4_div = cyc_A4_div ? io_b[48:35] : 14'h0;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :439:29, :534:12, rawFloatFromRecFN.scala:60:51
  wire         zLinPiece_0_A4_div = cyc_A4_div & io_b[51:49] == 3'h0;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :209:50, :441:{41,55,64}
  wire         zLinPiece_1_A4_div = cyc_A4_div & io_b[51:49] == 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :233:30, :441:55, :442:{41,64}
  wire         zLinPiece_2_A4_div = cyc_A4_div & io_b[51:49] == 3'h2;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :232:30, :441:55, :443:{41,64}
  wire         zLinPiece_3_A4_div = cyc_A4_div & io_b[51:49] == 3'h3;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :231:30, :441:55, :444:{41,64}
  wire         zLinPiece_4_A4_div = cyc_A4_div & io_b[51:49] == 3'h4;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :226:35, :441:55, :445:{41,64}
  wire         zLinPiece_5_A4_div = cyc_A4_div & io_b[51:49] == 3'h5;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :225:35, :441:55, :446:{41,64}
  wire         zLinPiece_6_A4_div = cyc_A4_div & io_b[51:49] == 3'h6;	// DivSqrtRecF64_mulAddZ31.scala:200:16, :209:50, :441:55, :447:{41,64}
  wire         zLinPiece_7_A4_div = cyc_A4_div & (&(io_b[51:49]));	// DivSqrtRecF64_mulAddZ31.scala:209:50, :441:55, :448:{41,64}
  wire [8:0]   _zK1_A4_div_T_4 =
    (zLinPiece_0_A4_div ? 9'h1C7 : 9'h0) | (zLinPiece_1_A4_div ? 9'h16C : 9'h0)
    | (zLinPiece_2_A4_div ? 9'h12A : 9'h0);	// DivSqrtRecF64_mulAddZ31.scala:441:41, :442:41, :443:41, :450:12, :451:{12,56}, :452:12
  wire [8:0]   zFractB_A7_sqrt = cyc_A7_sqrt ? io_b[50:42] : 9'h0;	// DivSqrtRecF64_mulAddZ31.scala:210:50, :450:12, :468:30, rawFloatFromRecFN.scala:60:51
  wire         zQuadPiece_0_A7_sqrt = cyc_A7_sqrt & ~(io_b[52]) & ~(io_b[51]);	// DivSqrtRecF64_mulAddZ31.scala:210:50, :471:{24,37,41,44}, common.scala:81:56
  wire         zQuadPiece_1_A7_sqrt = cyc_A7_sqrt & ~(io_b[52]) & io_b[51];	// DivSqrtRecF64_mulAddZ31.scala:210:50, :471:37, :473:{24,41}, common.scala:81:56
  wire         zQuadPiece_2_A7_sqrt = cyc_A7_sqrt & io_b[52] & ~(io_b[51]);	// DivSqrtRecF64_mulAddZ31.scala:210:50, :471:37, :475:{41,44}, common.scala:81:56
  wire         zQuadPiece_3_A7_sqrt = cyc_A7_sqrt & io_b[52] & io_b[51];	// DivSqrtRecF64_mulAddZ31.scala:210:50, :471:37, :476:62, common.scala:81:56
  wire [8:0]   _zK2_A7_sqrt_T_4 =
    {zQuadPiece_0_A7_sqrt,
     (zQuadPiece_0_A7_sqrt ? 8'hC8 : 8'h0) | (zQuadPiece_1_A7_sqrt ? 8'hC1 : 8'h0)}
    | (zQuadPiece_2_A7_sqrt ? 9'h143 : 9'h0);	// Bitwise.scala:72:12, DivSqrtRecF64_mulAddZ31.scala:450:12, :471:41, :473:41, :475:41, :478:{12,58}, :479:{12,58}, :480:12
  wire [19:0]  _mulAdd9C_A_T_4 =
    {(zQuadPiece_0_A7_sqrt ? 10'h2F : 10'h0) | (zQuadPiece_1_A7_sqrt ? 10'h1DF : 10'h0)
       | (zQuadPiece_2_A7_sqrt ? 10'h14D : 10'h0)
       | (zQuadPiece_3_A7_sqrt ? 10'h27E : 10'h0),
     {10{cyc_A7_sqrt}}}
    | {cyc_A6_sqrt,
       (cyc_A6_sqrt & ~(sExp_PA[0]) & ~(fractB_PA[51]) ? 13'h1A : 13'h0)
         | (cyc_A6_sqrt & ~(sExp_PA[0]) & fractB_PA[51] ? 13'hBCA : 13'h0)
         | (cyc_A6_sqrt & sExp_PA[0] & ~(fractB_PA[51]) ? 13'h12D3 : 13'h0)
         | (cyc_A6_sqrt & sExp_PA[0] & fractB_PA[51] ? 13'h1B17 : 13'h0),
       {6{cyc_A6_sqrt}}};	// Bitwise.scala:72:12, Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:98:30, :99:30, :210:50, :224:35, :471:41, :473:41, :475:41, :476:62, :483:{12,35}, :484:{12,35}, :485:{12,35,63}, :486:{12,35}, :488:{47,56,60,63,72}, :489:{47,60}, :490:{60,63}, :491:60, :493:{12,35}, :494:{12,35}, :495:{12,35,64}, :496:{12,35}, :506:71, :708:12
  wire [19:0]  _GEN_0 =
    {_mulAdd9C_A_T_4[19:8] | (zLinPiece_0_A4_div ? 12'h1C : 12'h0)
       | (zLinPiece_1_A4_div ? 12'h3A2 : 12'h0) | (zLinPiece_2_A4_div ? 12'h675 : 12'h0)
       | (zLinPiece_3_A4_div ? 12'h8C6 : 12'h0) | (zLinPiece_4_A4_div ? 12'hAB4 : 12'h0)
       | (zLinPiece_5_A4_div ? 12'hC56 : 12'h0) | (zLinPiece_6_A4_div ? 12'hDBD : 12'h0)
       | (zLinPiece_7_A4_div ? 12'hEF4 : 12'h0),
     _mulAdd9C_A_T_4[7:0] | {8{cyc_A4_div}}}
    | (cyc_A5_sqrt ? {1'h0, fractR0_A, 10'h0} + 20'h40000 : 20'h0);	// Bitwise.scala:72:12, DivSqrtRecF64_mulAddZ31.scala:90:30, :129:30, :209:50, :225:35, :441:41, :442:41, :443:41, :444:41, :445:41, :446:41, :447:41, :448:41, :459:{12,33}, :460:{12,33}, :461:{12,33}, :462:{12,33}, :463:{12,33}, :464:{12,33}, :465:{12,33}, :466:{12,33}, :506:71, :507:71, :508:71, :509:{12,42}
  wire [24:0]  _mulAdd9C_A_T_30 =
    {4'h0,
     {cyc_A4_div,
      _GEN_0[19:11],
      _GEN_0[10:0] | {cyc_A4_sqrt & ~(hiSqrR0_A_sqrt[9]), 10'h0}}
       | (cyc_A4_sqrt & hiSqrR0_A_sqrt[9] | cyc_A3_div
            ? fractB_PA[46:26] + 21'h400
            : 21'h0) | (cyc_A3 & sqrtOp_PA | cyc_A2 ? partNegSigma0_A : 21'h0)}
    | (cyc_A1_sqrt ? {fractR0_A, 16'h0} : 25'h0);	// Bitwise.scala:72:12, DivSqrtRecF64_mulAddZ31.scala:86:30, :91:30, :99:30, :129:30, :131:30, :132:30, :209:50, :226:35, :231:30, :232:30, :235:29, :239:30, :241:30, :508:71, :509:71, :510:{12,25,28,44}, :511:{12,26,48}, :512:{20,29}, :514:11, :515:{12,25,62}, :516:{12,45}
  wire [23:0]  _GEN_1 =
    _mulAdd9C_A_T_30[23:0] | (cyc_A1_div ? {fractR0_A, 15'h0} : 24'h0);	// DivSqrtRecF64_mulAddZ31.scala:129:30, :237:29, :515:62, :516:62, :517:{12,45}, :528:12
  wire [18:0]  loMulAdd9Out_A =
    {1'h0,
     {9'h0,
      zFractB_A4_div[13:5]
        | {_zK2_A7_sqrt_T_4[8],
           _zK2_A7_sqrt_T_4[7:0] | (zQuadPiece_3_A7_sqrt ? 8'h89 : 8'h0)}
        | (cyc_S ? 9'h0 : nextMulAdd9A_A)}
       * {9'h0,
          {_zK1_A4_div_T_4[8],
           _zK1_A4_div_T_4[7:0] | (zLinPiece_3_A4_div ? 8'hF8 : 8'h0)
             | (zLinPiece_4_A4_div ? 8'hD2 : 8'h0) | (zLinPiece_5_A4_div ? 8'hB4 : 8'h0)
             | (zLinPiece_6_A4_div ? 8'h9C : 8'h0) | (zLinPiece_7_A4_div ? 8'h89 : 8'h0)}
            | zFractB_A7_sqrt | (cyc_S ? 9'h0 : nextMulAdd9B_A)}} + {1'h0, _GEN_1[17:0]};	// Bitwise.scala:72:12, DivSqrtRecF64_mulAddZ31.scala:90:30, :133:30, :134:30, :165:27, :439:29, :444:41, :445:41, :446:41, :447:41, :448:41, :450:12, :451:56, :452:56, :453:12, :454:12, :455:12, :456:{12,56}, :457:12, :468:30, :476:62, :479:58, :480:58, :481:12, :499:{23,46}, :500:16, :502:46, :503:16, :516:62, :518:{37,50,63}
  wire [6:0]   mulAdd9Out_A_hi =
    loMulAdd9Out_A[18]
      ? {_mulAdd9C_A_T_30[24], _GEN_1[23:18]} + 7'h1
      : {_mulAdd9C_A_T_30[24], _GEN_1[23:18]};	// DivSqrtRecF64_mulAddZ31.scala:515:62, :516:62, :518:50, :520:{16,31}, :521:{27,36}
  wire [15:0]  r1_A1 =
    (sqrtOp_PA
       ? {1'h0, mulAdd9Out_A_hi, loMulAdd9Out_A[17:10]}
       : {mulAdd9Out_A_hi, loMulAdd9Out_A[17:9]}) | 16'h8000;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :91:30, :518:50, :520:16, :528:60, :537:{29,34,76}
  wire [16:0]  _ER1_A1_sqrt_T_1 = {r1_A1, 1'h0};	// DivSqrtRecF64_mulAddZ31.scala:90:30, :537:29, :538:44
  wire [16:0]  _GEN_2 = {1'h0, r1_A1};	// DivSqrtRecF64_mulAddZ31.scala:90:30, :537:29, :538:26
  wire         _io_latchMulAddB_0_T = cyc_A1 | cyc_B7_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:233:30, :254:36, :576:16
  wire         _io_latchMulAddA_0_output =
    _io_latchMulAddB_0_T | cyc_B6_div | cyc_B4 | cyc_B3 | cyc_C6_sqrt | cyc_C4 | cyc_C1;	// DivSqrtRecF64_mulAddZ31.scala:258:30, :259:30, :263:41, :282:35, :285:30, :288:30, :576:16, :577:35
  wire [52:0]  _io_mulAddA_0_T_6 =
    (cyc_A1_sqrt ? {sExp_PA[0] ? _ER1_A1_sqrt_T_1 : _GEN_2, 36'h0} : 53'h0)
    | (cyc_B7_sqrt | cyc_A1_div ? {1'h1, fractB_PA} : 53'h0)
    | (cyc_B6_div ? {1'h1, fractA_PA} : 53'h0);	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:98:30, :99:30, :100:30, :220:57, :237:29, :241:30, :254:36, :263:41, :488:56, :538:{26,44}, :579:{12,51}, :580:{12,25,67}, :581:12
  wire [51:0]  _io_mulAddB_0_T_1 = cyc_A1 ? {r1_A1, 36'h0} : 52'h0;	// DivSqrtRecF64_mulAddZ31.scala:233:30, :439:29, :537:29, :579:51, :593:{12,31}
  wire [52:0]  _io_mulAddB_0_T_7 =
    {1'h0,
     _io_mulAddB_0_T_1[51],
     _io_mulAddB_0_T_1[50:0] | (cyc_B7_sqrt ? {ESqrR1_B_sqrt, 19'h0} : 51'h0)}
    | (cyc_B6_sqrt ? {ER1_B_sqrt, 36'h0} : 53'h0);	// DivSqrtRecF64_mulAddZ31.scala:90:30, :135:30, :137:30, :254:36, :270:42, :579:{12,51}, :593:{12,55}, :594:{12,39,55}, :595:{12,36}
  wire [45:0]  _GEN_3 = _io_mulAddB_0_T_7[45:0] | zSigma1_B4;	// DivSqrtRecF64_mulAddZ31.scala:594:55, :595:55, :632:22
  wire [104:0] _io_mulAddC_2_T_1 = cyc_B1 ? {sigX1_B, 47'h0} : 105'h0;	// DivSqrtRecF64_mulAddZ31.scala:138:30, :261:30, :618:{12,45}
  wire [104:0] _io_mulAddC_2_T_8 =
    {_io_mulAddC_2_T_1[104],
     _io_mulAddC_2_T_1[103:0] | (cyc_C6_sqrt ? {sigX1_B, 46'h0} : 104'h0)}
    | (cyc_C4_sqrt | cyc_C2 ? {sigXN_C, 47'h0} : 105'h0);	// DivSqrtRecF64_mulAddZ31.scala:138:30, :140:30, :282:35, :287:30, :297:30, :584:12, :618:{12,45,66}, :619:{12,45,66}, :620:{12,25,45}
  assign zSigma1_B4 = cyc_B4 ? ~(io_mulAddResult_3[90:45]) : 46'h0;	// DivSqrtRecF64_mulAddZ31.scala:258:30, :584:12, :632:{22,31,49}
  wire [53:0]  _zComplSigT_C1_T_5 =
    cyc_C1_div & io_mulAddResult_3[104] | cyc_C1_sqrt
      ? ~(io_mulAddResult_3[104:51])
      : 54'h0;	// DivSqrtRecF64_mulAddZ31.scala:294:29, :300:30, :621:12, :635:39, :637:{12,25,40}, :638:{13,31}
  assign _zComplSigT_C1_T_5_53 = _zComplSigT_C1_T_5[53];	// DivSqrtRecF64_mulAddZ31.scala:637:12, :640:11
  assign _GEN =
    _zComplSigT_C1_T_5[52:0]
    | (cyc_C1_div & ~(io_mulAddResult_3[104]) ? ~(io_mulAddResult_3[102:50]) : 53'h0);	// DivSqrtRecF64_mulAddZ31.scala:294:29, :579:12, :635:{20,39}, :637:12, :640:11, :641:{12,24,37,55}
  assign zComplSigT_C1_sqrt = cyc_C1_sqrt ? ~(io_mulAddResult_3[104:51]) : 54'h0;	// DivSqrtRecF64_mulAddZ31.scala:300:30, :621:12, :638:31, :643:{12,26}
  wire [54:0]  _GEN_4 = {1'h0, sigT_E};	// DivSqrtRecF64_mulAddZ31.scala:90:30, :143:30, :694:27
  always @(posedge clock) begin
    automatic logic        notSigNaNIn_invalidExc_S_div =
      rawA_S_isZero & ~(|(io_b[63:61])) | rawA_S_isInf & rawB_S_isInf;	// DivSqrtRecF64_mulAddZ31.scala:171:{24,42,59}, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :56:33
    automatic logic        notSigNaNIn_invalidExc_S_sqrt =
      ~rawB_S_isNaN & (|(io_b[63:61])) & io_b[64];	// DivSqrtRecF64_mulAddZ31.scala:173:{9,43}, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :55:33, :58:25
    automatic logic        _majorExc_S_T_3;	// DivSqrtRecF64_mulAddZ31.scala:176:38
    automatic logic        _majorExc_S_T_16;	// DivSqrtRecF64_mulAddZ31.scala:178:46
    automatic logic        _isNaN_S_T;	// DivSqrtRecF64_mulAddZ31.scala:183:26
    automatic logic        _isNaN_S_T_2;	// DivSqrtRecF64_mulAddZ31.scala:184:42
    automatic logic        _isInf_S_T;	// DivSqrtRecF64_mulAddZ31.scala:186:63
    automatic logic        _isZero_S_T;	// DivSqrtRecF64_mulAddZ31.scala:187:64
    automatic logic        sign_S;	// DivSqrtRecF64_mulAddZ31.scala:188:47
    automatic logic        normalCase_S =
      io_sqrtOp ? normalCase_S_sqrt : normalCase_S_div;	// DivSqrtRecF64_mulAddZ31.scala:192:45, :193:46, :194:27
    automatic logic        entering_PA_normalCase;	// DivSqrtRecF64_mulAddZ31.scala:212:36
    automatic logic        entering_PA;	// DivSqrtRecF64_mulAddZ31.scala:324:32
    automatic logic        entering_PB;	// DivSqrtRecF64_mulAddZ31.scala:363:37
    automatic logic        entering_PC;	// DivSqrtRecF64_mulAddZ31.scala:397:37
    automatic logic [8:0]  zFractR0_A6_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:528:12
    automatic logic [18:0] sqrR0_A5_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:532:28
    automatic logic [8:0]  _GEN_5;	// DivSqrtRecF64_mulAddZ31.scala:534:59
    automatic logic [8:0]  zFractR0_A4_div;	// DivSqrtRecF64_mulAddZ31.scala:534:12
    automatic logic        _GEN_6 = cyc_A7_sqrt | cyc_A6_sqrt | cyc_A5_sqrt | cyc_A4;	// DivSqrtRecF64_mulAddZ31.scala:210:50, :224:35, :225:35, :230:30, :550:51
    _majorExc_S_T_3 = rawB_S_isNaN & ~(io_b[51]) | notSigNaNIn_invalidExc_S_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:173:43, :176:38, common.scala:81:{46,49,56}, rawFloatFromRecFN.scala:55:33
    _majorExc_S_T_16 =
      rawA_S_isNaN & ~(io_a[51]) | rawB_S_isNaN & ~(io_b[51])
      | notSigNaNIn_invalidExc_S_div | ~rawA_S_isNaN & ~rawA_S_isInf & ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:171:42, :178:46, :179:{18,36,51}, common.scala:81:{46,49,56}, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :55:33, :56:33
    _isNaN_S_T = rawB_S_isNaN | notSigNaNIn_invalidExc_S_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:173:43, :183:26, rawFloatFromRecFN.scala:55:33
    _isNaN_S_T_2 = rawA_S_isNaN | rawB_S_isNaN | notSigNaNIn_invalidExc_S_div;	// DivSqrtRecF64_mulAddZ31.scala:171:42, :184:42, rawFloatFromRecFN.scala:55:33
    _isInf_S_T = rawA_S_isInf | ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:186:63, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :56:33
    _isZero_S_T = rawA_S_isZero | rawB_S_isInf;	// DivSqrtRecF64_mulAddZ31.scala:187:64, rawFloatFromRecFN.scala:51:54, :56:33
    sign_S = ~io_sqrtOp & io_a[64] ^ io_b[64];	// DivSqrtRecF64_mulAddZ31.scala:163:55, :188:{31,47}, rawFloatFromRecFN.scala:58:25
    entering_PA_normalCase = cyc_A4_div | cyc_A7_sqrt;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :210:50, :212:36
    entering_PA = entering_PA_normalCase | cyc_S & (valid_PA | ~ready_PB);	// DivSqrtRecF64_mulAddZ31.scala:90:30, :165:27, :212:36, :324:{32,42,55,58}, :389:28
    entering_PB =
      cyc_S & ~normalCase_S & ~valid_PA & (leaving_PB | ~valid_PB & ~ready_PC)
      | leaving_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :103:30, :165:27, :194:27, :353:28, :354:17, :359:{18,47}, :360:{25,29,40,43}, :363:37, :388:28, :422:28
    entering_PC = cyc_S & ~normalCase_S & ~valid_PA & ~valid_PB & ready_PC | leaving_PB;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :103:30, :165:27, :194:27, :354:17, :359:18, :360:29, :388:28, :394:61, :397:37, :422:28
    zFractR0_A6_sqrt =
      cyc_A6_sqrt & mulAdd9Out_A_hi[1]
        ? ~{mulAdd9Out_A_hi[0], loMulAdd9Out_A[17:10]}
        : 9'h0;	// DivSqrtRecF64_mulAddZ31.scala:224:35, :450:12, :518:50, :520:16, :528:{12,25,40,46,60}
    sqrR0_A5_sqrt =
      sExp_PA[0]
        ? {mulAdd9Out_A_hi[0], loMulAdd9Out_A[17:0]}
        : {mulAdd9Out_A_hi[1:0], loMulAdd9Out_A[17:1]};	// DivSqrtRecF64_mulAddZ31.scala:98:30, :488:56, :518:50, :520:16, :524:27, :528:60, :532:{28,53}
    _GEN_5 = {mulAdd9Out_A_hi[1:0], loMulAdd9Out_A[17:11]};	// DivSqrtRecF64_mulAddZ31.scala:518:50, :520:16, :532:28, :534:59
    zFractR0_A4_div = cyc_A4_div & mulAdd9Out_A_hi[2] ? ~_GEN_5 : 9'h0;	// DivSqrtRecF64_mulAddZ31.scala:209:50, :450:12, :520:16, :534:{12,24,39,45,59}
    if (reset) begin
      cycleNum_A <= 3'h0;	// DivSqrtRecF64_mulAddZ31.scala:85:30
      cycleNum_B <= 4'h0;	// DivSqrtRecF64_mulAddZ31.scala:86:30
      cycleNum_C <= 3'h0;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :87:30
      cycleNum_E <= 3'h0;	// DivSqrtRecF64_mulAddZ31.scala:85:30, :88:30
      valid_PA <= 1'h0;	// DivSqrtRecF64_mulAddZ31.scala:90:30
      valid_PB <= 1'h0;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :103:30
      valid_PC <= 1'h0;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :116:30
    end
    else begin
      if (entering_PA_normalCase | (|cycleNum_A))	// DivSqrtRecF64_mulAddZ31.scala:85:30, :212:36, :216:{34,49}
        cycleNum_A <=
          {1'h0, {2{cyc_A4_div}}} | (cyc_A7_sqrt ? 3'h6 : 3'h0)
          | (entering_PA_normalCase ? 3'h0 : cycleNum_A - 3'h1);	// DivSqrtRecF64_mulAddZ31.scala:85:30, :90:30, :200:16, :209:50, :210:50, :212:36, :218:{16,77}, :219:{16,77}, :220:{16,57}
      if (cyc_A1 | (|cycleNum_B)) begin	// DivSqrtRecF64_mulAddZ31.scala:86:30, :233:30, :243:{18,33}
        if (cyc_A1) begin	// DivSqrtRecF64_mulAddZ31.scala:233:30
          if (sqrtOp_PA)	// DivSqrtRecF64_mulAddZ31.scala:91:30
            cycleNum_B <= 4'hA;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :246:20
          else	// DivSqrtRecF64_mulAddZ31.scala:91:30
            cycleNum_B <= 4'h6;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :200:16
        end
        else	// DivSqrtRecF64_mulAddZ31.scala:233:30
          cycleNum_B <= cycleNum_B - 4'h1;	// DivSqrtRecF64_mulAddZ31.scala:86:30, :247:28
      end
      if (cyc_B1 | (|cycleNum_C)) begin	// DivSqrtRecF64_mulAddZ31.scala:87:30, :261:30, :277:{18,33}
        if (cyc_B1) begin	// DivSqrtRecF64_mulAddZ31.scala:261:30
          if (sqrtOp_PB)	// DivSqrtRecF64_mulAddZ31.scala:104:30
            cycleNum_C <= 3'h6;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :200:16
          else	// DivSqrtRecF64_mulAddZ31.scala:104:30
            cycleNum_C <= 3'h5;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :225:35
        end
        else	// DivSqrtRecF64_mulAddZ31.scala:261:30
          cycleNum_C <= cycleNum_C - 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:87:30, :279:70
      end
      if (cyc_C1 | (|cycleNum_E)) begin	// DivSqrtRecF64_mulAddZ31.scala:88:30, :288:30, :302:{18,33}
        if (cyc_C1)	// DivSqrtRecF64_mulAddZ31.scala:288:30
          cycleNum_E <= 3'h4;	// DivSqrtRecF64_mulAddZ31.scala:88:30, :226:35
        else	// DivSqrtRecF64_mulAddZ31.scala:288:30
          cycleNum_E <= cycleNum_E - 3'h1;	// DivSqrtRecF64_mulAddZ31.scala:88:30, :303:55
      end
      if (entering_PA | leaving_PA)	// DivSqrtRecF64_mulAddZ31.scala:324:32, :326:23, :353:28
        valid_PA <= entering_PA;	// DivSqrtRecF64_mulAddZ31.scala:90:30, :324:32
      if (entering_PB | leaving_PB)	// DivSqrtRecF64_mulAddZ31.scala:363:37, :365:23, :388:28
        valid_PB <= entering_PB;	// DivSqrtRecF64_mulAddZ31.scala:103:30, :363:37
      if (entering_PC | leaving_PC)	// DivSqrtRecF64_mulAddZ31.scala:397:37, :399:23, :421:28
        valid_PC <= entering_PC;	// DivSqrtRecF64_mulAddZ31.scala:116:30, :397:37
    end
    if (entering_PA) begin	// DivSqrtRecF64_mulAddZ31.scala:324:32
      sqrtOp_PA <= io_sqrtOp;	// DivSqrtRecF64_mulAddZ31.scala:91:30
      if (io_sqrtOp) begin
        majorExc_PA <= _majorExc_S_T_3;	// DivSqrtRecF64_mulAddZ31.scala:92:30, :176:38
        isNaN_PA <= _isNaN_S_T;	// DivSqrtRecF64_mulAddZ31.scala:94:30, :183:26
        isInf_PA <= rawB_S_isInf;	// DivSqrtRecF64_mulAddZ31.scala:95:30, rawFloatFromRecFN.scala:56:33
        isZero_PA <= ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:96:30, rawFloatFromRecFN.scala:50:21, :51:{29,54}
      end
      else begin
        majorExc_PA <= _majorExc_S_T_16;	// DivSqrtRecF64_mulAddZ31.scala:92:30, :178:46
        isNaN_PA <= _isNaN_S_T_2;	// DivSqrtRecF64_mulAddZ31.scala:94:30, :184:42
        isInf_PA <= _isInf_S_T;	// DivSqrtRecF64_mulAddZ31.scala:95:30, :186:63
        isZero_PA <= _isZero_S_T;	// DivSqrtRecF64_mulAddZ31.scala:96:30, :187:64
      end
      sign_PA <= sign_S;	// DivSqrtRecF64_mulAddZ31.scala:97:30, :188:47
    end
    if (entering_PA_normalCase) begin	// DivSqrtRecF64_mulAddZ31.scala:212:36
      if (io_sqrtOp)
        sExp_PA <= {1'h0, io_b[63:52]};	// DivSqrtRecF64_mulAddZ31.scala:90:30, :98:30, rawFloatFromRecFN.scala:50:21, :59:27
      else begin
        automatic logic [13:0] sExpQuot_S_div =
          {2'h0, io_a[63:52]} + {{3{io_b[63]}}, ~(io_b[62:52])};	// DivSqrtRecF64_mulAddZ31.scala:197:{21,39,45,57}, :218:16, rawFloatFromRecFN.scala:50:21
        sExp_PA <=
          {$signed(sExpQuot_S_div) > 14'shDFF ? 4'h6 : sExpQuot_S_div[12:9],
           sExpQuot_S_div[8:0]};	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:98:30, :197:21, :200:{16,29}, :202:31, :204:27
      end
      fractB_PA <= io_b[51:0];	// DivSqrtRecF64_mulAddZ31.scala:99:30, rawFloatFromRecFN.scala:60:51
      roundingMode_PA <= io_roundingMode;	// DivSqrtRecF64_mulAddZ31.scala:101:30
    end
    if (cyc_A4_div)	// DivSqrtRecF64_mulAddZ31.scala:209:50
      fractA_PA <= io_a[51:0];	// DivSqrtRecF64_mulAddZ31.scala:100:30, rawFloatFromRecFN.scala:60:51
    if (entering_PB) begin	// DivSqrtRecF64_mulAddZ31.scala:363:37
      if (valid_PA) begin	// DivSqrtRecF64_mulAddZ31.scala:90:30
        sqrtOp_PB <= sqrtOp_PA;	// DivSqrtRecF64_mulAddZ31.scala:91:30, :104:30
        majorExc_PB <= majorExc_PA;	// DivSqrtRecF64_mulAddZ31.scala:92:30, :105:30
        isNaN_PB <= isNaN_PA;	// DivSqrtRecF64_mulAddZ31.scala:94:30, :107:30
        isInf_PB <= isInf_PA;	// DivSqrtRecF64_mulAddZ31.scala:95:30, :108:30
        isZero_PB <= isZero_PA;	// DivSqrtRecF64_mulAddZ31.scala:96:30, :109:30
        sign_PB <= sign_PA;	// DivSqrtRecF64_mulAddZ31.scala:97:30, :110:30
      end
      else begin	// DivSqrtRecF64_mulAddZ31.scala:90:30
        sqrtOp_PB <= io_sqrtOp;	// DivSqrtRecF64_mulAddZ31.scala:104:30
        if (io_sqrtOp) begin
          majorExc_PB <= _majorExc_S_T_3;	// DivSqrtRecF64_mulAddZ31.scala:105:30, :176:38
          isNaN_PB <= _isNaN_S_T;	// DivSqrtRecF64_mulAddZ31.scala:107:30, :183:26
          isInf_PB <= rawB_S_isInf;	// DivSqrtRecF64_mulAddZ31.scala:108:30, rawFloatFromRecFN.scala:56:33
          isZero_PB <= ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:109:30, rawFloatFromRecFN.scala:50:21, :51:{29,54}
        end
        else begin
          majorExc_PB <= _majorExc_S_T_16;	// DivSqrtRecF64_mulAddZ31.scala:105:30, :178:46
          isNaN_PB <= _isNaN_S_T_2;	// DivSqrtRecF64_mulAddZ31.scala:107:30, :184:42
          isInf_PB <= _isInf_S_T;	// DivSqrtRecF64_mulAddZ31.scala:108:30, :186:63
          isZero_PB <= _isZero_S_T;	// DivSqrtRecF64_mulAddZ31.scala:109:30, :187:64
        end
        sign_PB <= sign_S;	// DivSqrtRecF64_mulAddZ31.scala:110:30, :188:47
      end
    end
    if (valid_PA & normalCase_PA & valid_normalCase_leaving_PA) begin	// DivSqrtRecF64_mulAddZ31.scala:90:30, :346:50, :350:50, :362:35
      sExp_PB <= sExp_PA;	// DivSqrtRecF64_mulAddZ31.scala:98:30, :111:30
      bit0FractA_PB <= fractA_PA[0];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :112:30, :378:37
      fractB_PB <= fractB_PA;	// DivSqrtRecF64_mulAddZ31.scala:99:30, :113:30
      if (valid_PA)	// DivSqrtRecF64_mulAddZ31.scala:90:30
        roundingMode_PB <= roundingMode_PA;	// DivSqrtRecF64_mulAddZ31.scala:101:30, :114:30
      else	// DivSqrtRecF64_mulAddZ31.scala:90:30
        roundingMode_PB <= io_roundingMode;	// DivSqrtRecF64_mulAddZ31.scala:114:30
    end
    if (entering_PC) begin	// DivSqrtRecF64_mulAddZ31.scala:397:37
      if (valid_PB) begin	// DivSqrtRecF64_mulAddZ31.scala:103:30
        sqrtOp_PC <= sqrtOp_PB;	// DivSqrtRecF64_mulAddZ31.scala:104:30, :117:30
        majorExc_PC <= majorExc_PB;	// DivSqrtRecF64_mulAddZ31.scala:105:30, :118:30
        isNaN_PC <= isNaN_PB;	// DivSqrtRecF64_mulAddZ31.scala:107:30, :120:30
        isInf_PC <= isInf_PB;	// DivSqrtRecF64_mulAddZ31.scala:108:30, :121:30
        isZero_PC <= isZero_PB;	// DivSqrtRecF64_mulAddZ31.scala:109:30, :122:30
        sign_PC <= sign_PB;	// DivSqrtRecF64_mulAddZ31.scala:110:30, :123:30
      end
      else begin	// DivSqrtRecF64_mulAddZ31.scala:103:30
        sqrtOp_PC <= io_sqrtOp;	// DivSqrtRecF64_mulAddZ31.scala:117:30
        if (io_sqrtOp) begin
          majorExc_PC <= _majorExc_S_T_3;	// DivSqrtRecF64_mulAddZ31.scala:118:30, :176:38
          isNaN_PC <= _isNaN_S_T;	// DivSqrtRecF64_mulAddZ31.scala:120:30, :183:26
          isInf_PC <= rawB_S_isInf;	// DivSqrtRecF64_mulAddZ31.scala:121:30, rawFloatFromRecFN.scala:56:33
          isZero_PC <= ~(|(io_b[63:61]));	// DivSqrtRecF64_mulAddZ31.scala:122:30, rawFloatFromRecFN.scala:50:21, :51:{29,54}
        end
        else begin
          majorExc_PC <= _majorExc_S_T_16;	// DivSqrtRecF64_mulAddZ31.scala:118:30, :178:46
          isNaN_PC <= _isNaN_S_T_2;	// DivSqrtRecF64_mulAddZ31.scala:120:30, :184:42
          isInf_PC <= _isInf_S_T;	// DivSqrtRecF64_mulAddZ31.scala:121:30, :186:63
          isZero_PC <= _isZero_S_T;	// DivSqrtRecF64_mulAddZ31.scala:122:30, :187:64
        end
        sign_PC <= sign_S;	// DivSqrtRecF64_mulAddZ31.scala:123:30, :188:47
      end
    end
    if (valid_PB & normalCase_PB & cyc_C3) begin	// DivSqrtRecF64_mulAddZ31.scala:103:30, :286:30, :383:50, :396:35
      sExp_PC <= sExp_PB;	// DivSqrtRecF64_mulAddZ31.scala:111:30, :124:30
      bit0FractA_PC <= bit0FractA_PB;	// DivSqrtRecF64_mulAddZ31.scala:112:30, :125:30
      fractB_PC <= fractB_PB;	// DivSqrtRecF64_mulAddZ31.scala:113:30, :126:30
      if (valid_PB)	// DivSqrtRecF64_mulAddZ31.scala:103:30
        roundingMode_PC <= roundingMode_PB;	// DivSqrtRecF64_mulAddZ31.scala:114:30, :127:30
      else	// DivSqrtRecF64_mulAddZ31.scala:103:30
        roundingMode_PC <= io_roundingMode;	// DivSqrtRecF64_mulAddZ31.scala:127:30
    end
    if (cyc_A6_sqrt | cyc_A4_div)	// DivSqrtRecF64_mulAddZ31.scala:209:50, :224:35, :540:23
      fractR0_A <= zFractR0_A6_sqrt | zFractR0_A4_div;	// DivSqrtRecF64_mulAddZ31.scala:129:30, :528:12, :534:12, :541:39
    if (cyc_A5_sqrt)	// DivSqrtRecF64_mulAddZ31.scala:225:35
      hiSqrR0_A_sqrt <= sqrR0_A5_sqrt[18:9];	// DivSqrtRecF64_mulAddZ31.scala:131:30, :532:28, :544:{24,40}
    if (cyc_A4_sqrt | cyc_A3)	// DivSqrtRecF64_mulAddZ31.scala:226:35, :231:30, :546:23
      partNegSigma0_A <=
        cyc_A4_sqrt
          ? {mulAdd9Out_A_hi[2:0], loMulAdd9Out_A[17:0]}
          : {5'h0, mulAdd9Out_A_hi, loMulAdd9Out_A[17:9]};	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:132:30, :226:35, :518:50, :520:16, :524:27, :537:76, :547:31
    if (_GEN_6 | cyc_A3 | cyc_A2)	// DivSqrtRecF64_mulAddZ31.scala:231:30, :232:30, :550:{51,71}
      nextMulAdd9A_A <=
        (cyc_A7_sqrt ? ~_GEN_5 : 9'h0) | zFractR0_A6_sqrt
        | (cyc_A4_sqrt ? fractB_PA[43:35] : 9'h0) | zFractB_A4_div[8:0]
        | (cyc_A5_sqrt | cyc_A3 ? {1'h1, fractB_PA[51:44]} : 9'h0)
        | (cyc_A2 & loMulAdd9Out_A[11] ? ~(loMulAdd9Out_A[10:2]) : 9'h0);	// DivSqrtRecF64_mulAddZ31.scala:99:30, :133:30, :210:50, :220:57, :225:35, :226:35, :231:30, :232:30, :439:29, :450:12, :518:50, :528:12, :534:59, :536:{12,20,35,41,55}, :553:{16,40}, :555:{16,47}, :556:27, :557:{16,29,47,68}
    if (_GEN_6 | cyc_A2)	// DivSqrtRecF64_mulAddZ31.scala:232:30, :550:51, :560:63
      nextMulAdd9B_A <=
        zFractB_A7_sqrt | zFractR0_A6_sqrt | (cyc_A5_sqrt ? sqrR0_A5_sqrt[8:0] : 9'h0)
        | zFractR0_A4_div | (cyc_A4_sqrt ? hiSqrR0_A_sqrt[8:0] : 9'h0)
        | (cyc_A2 ? {1'h1, fractR0_A[8:1]} : 9'h0);	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:129:30, :131:30, :134:30, :220:57, :225:35, :226:35, :232:30, :450:12, :468:30, :528:12, :532:28, :534:12, :564:{16,43}, :566:{16,44,73}, :567:{16,55}
    if (cyc_A1_sqrt) begin	// DivSqrtRecF64_mulAddZ31.scala:241:30
      if (sExp_PA[0])	// DivSqrtRecF64_mulAddZ31.scala:98:30, :488:56
        ER1_B_sqrt <= _ER1_A1_sqrt_T_1;	// DivSqrtRecF64_mulAddZ31.scala:135:30, :538:44
      else	// DivSqrtRecF64_mulAddZ31.scala:488:56
        ER1_B_sqrt <= _GEN_2;	// DivSqrtRecF64_mulAddZ31.scala:135:30, :538:26
    end
    if (cyc_B8_sqrt)	// DivSqrtRecF64_mulAddZ31.scala:253:36
      ESqrR1_B_sqrt <= io_mulAddResult_3[103:72];	// DivSqrtRecF64_mulAddZ31.scala:137:30, :631:43
    if (cyc_B3)	// DivSqrtRecF64_mulAddZ31.scala:259:30
      sigX1_B <= io_mulAddResult_3[104:47];	// DivSqrtRecF64_mulAddZ31.scala:138:30, :634:38
    if (cyc_B1)	// DivSqrtRecF64_mulAddZ31.scala:261:30
      sqrSigma1_C <= io_mulAddResult_3[79:47];	// DivSqrtRecF64_mulAddZ31.scala:139:30, :633:41
    if (cyc_C6_sqrt | cyc_C5 & ~sqrtOp_PB | cyc_C3 & sqrtOp_PB)	// DivSqrtRecF64_mulAddZ31.scala:104:30, :266:32, :282:35, :284:30, :286:30, :290:29, :298:30, :660:37
      sigXN_C <= io_mulAddResult_3[104:47];	// DivSqrtRecF64_mulAddZ31.scala:140:30, :634:38
    if (cyc_C5 & sqrtOp_PB)	// DivSqrtRecF64_mulAddZ31.scala:104:30, :284:30, :296:30
      u_C_sqrt <= io_mulAddResult_3[103:73];	// DivSqrtRecF64_mulAddZ31.scala:141:30, :664:33
    if (cyc_C1) begin	// DivSqrtRecF64_mulAddZ31.scala:288:30
      E_E_div <= ~(io_mulAddResult_3[104]);	// DivSqrtRecF64_mulAddZ31.scala:142:30, :635:{20,39}
      sigT_E <= ~{_zComplSigT_C1_T_5_53, _GEN};	// DivSqrtRecF64_mulAddZ31.scala:143:30, :640:11, :647:19
    end
    if (cycleNum_E == 3'h2) begin	// DivSqrtRecF64_mulAddZ31.scala:88:30, :232:30, :308:30
      if (sqrtOp_PC)	// DivSqrtRecF64_mulAddZ31.scala:117:30
        isNegRemT_E <= io_mulAddResult_3[55];	// DivSqrtRecF64_mulAddZ31.scala:144:30, :648:36, :672:47
      else	// DivSqrtRecF64_mulAddZ31.scala:117:30
        isNegRemT_E <= io_mulAddResult_3[53];	// DivSqrtRecF64_mulAddZ31.scala:144:30, :648:36, :672:61
      isZeroRemT_E <=
        io_mulAddResult_3[53:0] == 54'h0
        & (~sqrtOp_PC | io_mulAddResult_3[55:54] == 2'h0);	// DivSqrtRecF64_mulAddZ31.scala:117:30, :145:30, :218:16, :293:32, :621:12, :648:36, :674:{21,29,42}, :675:{30,41,50}
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:19];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h14; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        cycleNum_A = _RANDOM[5'h0][2:0];	// DivSqrtRecF64_mulAddZ31.scala:85:30
        cycleNum_B = _RANDOM[5'h0][6:3];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :86:30
        cycleNum_C = _RANDOM[5'h0][9:7];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :87:30
        cycleNum_E = _RANDOM[5'h0][12:10];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :88:30
        valid_PA = _RANDOM[5'h0][13];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :90:30
        sqrtOp_PA = _RANDOM[5'h0][14];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :91:30
        majorExc_PA = _RANDOM[5'h0][15];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :92:30
        isNaN_PA = _RANDOM[5'h0][16];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :94:30
        isInf_PA = _RANDOM[5'h0][17];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :95:30
        isZero_PA = _RANDOM[5'h0][18];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :96:30
        sign_PA = _RANDOM[5'h0][19];	// DivSqrtRecF64_mulAddZ31.scala:85:30, :97:30
        sExp_PA = {_RANDOM[5'h0][31:20], _RANDOM[5'h1][0]};	// DivSqrtRecF64_mulAddZ31.scala:85:30, :98:30
        fractB_PA = {_RANDOM[5'h1][31:1], _RANDOM[5'h2][20:0]};	// DivSqrtRecF64_mulAddZ31.scala:98:30, :99:30
        fractA_PA = {_RANDOM[5'h2][31:21], _RANDOM[5'h3], _RANDOM[5'h4][8:0]};	// DivSqrtRecF64_mulAddZ31.scala:99:30, :100:30
        roundingMode_PA = _RANDOM[5'h4][11:9];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :101:30
        valid_PB = _RANDOM[5'h4][12];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :103:30
        sqrtOp_PB = _RANDOM[5'h4][13];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :104:30
        majorExc_PB = _RANDOM[5'h4][14];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :105:30
        isNaN_PB = _RANDOM[5'h4][15];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :107:30
        isInf_PB = _RANDOM[5'h4][16];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :108:30
        isZero_PB = _RANDOM[5'h4][17];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :109:30
        sign_PB = _RANDOM[5'h4][18];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :110:30
        sExp_PB = _RANDOM[5'h4][31:19];	// DivSqrtRecF64_mulAddZ31.scala:100:30, :111:30
        bit0FractA_PB = _RANDOM[5'h5][0];	// DivSqrtRecF64_mulAddZ31.scala:112:30
        fractB_PB = {_RANDOM[5'h5][31:1], _RANDOM[5'h6][20:0]};	// DivSqrtRecF64_mulAddZ31.scala:112:30, :113:30
        roundingMode_PB = _RANDOM[5'h6][23:21];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :114:30
        valid_PC = _RANDOM[5'h6][24];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :116:30
        sqrtOp_PC = _RANDOM[5'h6][25];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :117:30
        majorExc_PC = _RANDOM[5'h6][26];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :118:30
        isNaN_PC = _RANDOM[5'h6][27];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :120:30
        isInf_PC = _RANDOM[5'h6][28];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :121:30
        isZero_PC = _RANDOM[5'h6][29];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :122:30
        sign_PC = _RANDOM[5'h6][30];	// DivSqrtRecF64_mulAddZ31.scala:113:30, :123:30
        sExp_PC = {_RANDOM[5'h6][31], _RANDOM[5'h7][11:0]};	// DivSqrtRecF64_mulAddZ31.scala:113:30, :124:30
        bit0FractA_PC = _RANDOM[5'h7][12];	// DivSqrtRecF64_mulAddZ31.scala:124:30, :125:30
        fractB_PC = {_RANDOM[5'h7][31:13], _RANDOM[5'h8], _RANDOM[5'h9][0]};	// DivSqrtRecF64_mulAddZ31.scala:124:30, :126:30
        roundingMode_PC = _RANDOM[5'h9][3:1];	// DivSqrtRecF64_mulAddZ31.scala:126:30, :127:30
        fractR0_A = _RANDOM[5'h9][12:4];	// DivSqrtRecF64_mulAddZ31.scala:126:30, :129:30
        hiSqrR0_A_sqrt = _RANDOM[5'h9][22:13];	// DivSqrtRecF64_mulAddZ31.scala:126:30, :131:30
        partNegSigma0_A = {_RANDOM[5'h9][31:23], _RANDOM[5'hA][11:0]};	// DivSqrtRecF64_mulAddZ31.scala:126:30, :132:30
        nextMulAdd9A_A = _RANDOM[5'hA][20:12];	// DivSqrtRecF64_mulAddZ31.scala:132:30, :133:30
        nextMulAdd9B_A = _RANDOM[5'hA][29:21];	// DivSqrtRecF64_mulAddZ31.scala:132:30, :134:30
        ER1_B_sqrt = {_RANDOM[5'hA][31:30], _RANDOM[5'hB][14:0]};	// DivSqrtRecF64_mulAddZ31.scala:132:30, :135:30
        ESqrR1_B_sqrt = {_RANDOM[5'hB][31:15], _RANDOM[5'hC][14:0]};	// DivSqrtRecF64_mulAddZ31.scala:135:30, :137:30
        sigX1_B = {_RANDOM[5'hC][31:15], _RANDOM[5'hD], _RANDOM[5'hE][8:0]};	// DivSqrtRecF64_mulAddZ31.scala:137:30, :138:30
        sqrSigma1_C = {_RANDOM[5'hE][31:9], _RANDOM[5'hF][9:0]};	// DivSqrtRecF64_mulAddZ31.scala:138:30, :139:30
        sigXN_C = {_RANDOM[5'hF][31:10], _RANDOM[5'h10], _RANDOM[5'h11][3:0]};	// DivSqrtRecF64_mulAddZ31.scala:139:30, :140:30
        u_C_sqrt = {_RANDOM[5'h11][31:4], _RANDOM[5'h12][2:0]};	// DivSqrtRecF64_mulAddZ31.scala:140:30, :141:30
        E_E_div = _RANDOM[5'h12][3];	// DivSqrtRecF64_mulAddZ31.scala:141:30, :142:30
        sigT_E = {_RANDOM[5'h12][31:4], _RANDOM[5'h13][25:0]};	// DivSqrtRecF64_mulAddZ31.scala:141:30, :143:30
        isNegRemT_E = _RANDOM[5'h13][26];	// DivSqrtRecF64_mulAddZ31.scala:143:30, :144:30
        isZeroRemT_E = _RANDOM[5'h13][27];	// DivSqrtRecF64_mulAddZ31.scala:143:30, :145:30
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_inReady_div = _io_inReady_div_output;	// DivSqrtRecF64_mulAddZ31.scala:431:22
  assign io_inReady_sqrt = _io_inReady_sqrt_output;	// DivSqrtRecF64_mulAddZ31.scala:434:26
  assign io_usingMulAdd =
    {cyc_A4 | cyc_A3_div | cyc_A1_div | cycleNum_B == 4'hA | cyc_B9_sqrt | cyc_B7_sqrt
       | cyc_B6 | cyc_B5_sqrt | cyc_B3_sqrt | cyc_B2_div | cyc_B1_sqrt | cyc_C4,
     cyc_A3 | cyc_A2 & ~sqrtOp_PA | cyc_B9_sqrt | cyc_B8_sqrt | cyc_B6 | cyc_B5
       | cyc_B4_sqrt | cyc_B2_sqrt | cyc_B1 & ~sqrtOp_PB | cyc_C6_sqrt | cyc_C3,
     cyc_A2 | cyc_A1_div | cyc_B8_sqrt | cyc_B7_sqrt | cyc_B5 | cyc_B4 | cyc_B3_sqrt
       | cyc_B1_sqrt | cyc_C5 | cyc_C2,
     _io_latchMulAddA_0_output | cyc_B6 | cyc_B2_sqrt};	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:86:30, :91:30, :104:30, :230:30, :231:30, :232:30, :235:{29,32}, :236:29, :237:29, :246:20, :251:36, :252:36, :253:36, :254:36, :256:30, :257:30, :258:30, :261:30, :266:32, :267:29, :268:29, :271:42, :272:42, :273:30, :274:30, :275:30, :282:35, :284:30, :285:30, :286:30, :287:30, :577:35, :604:73, :608:73, :612:54, :614:41
  assign io_latchMulAddA_0 = _io_latchMulAddA_0_output;	// DivSqrtRecF64_mulAddZ31.scala:577:35
  assign io_mulAddA_0 =
    {1'h0,
     {_io_mulAddA_0_T_6[52:46],
      {_io_mulAddA_0_T_6[45:34], _io_mulAddA_0_T_6[33:0] | zSigma1_B4[45:12]}
        | (cyc_B3 | cyc_C6_sqrt ? io_mulAddResult_3[104:59] : 46'h0)
        | (cyc_C4 & ~sqrtOp_PB ? {sigXN_C[57:25], 13'h0} : 46'h0)
        | (cyc_C4_sqrt ? {u_C_sqrt, 15'h0} : 46'h0)}
       | (cyc_C1_div ? {1'h1, fractB_PC} : 53'h0)} | zComplSigT_C1_sqrt;	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:90:30, :104:30, :126:30, :140:30, :141:30, :220:57, :259:30, :266:32, :282:35, :285:30, :291:29, :294:29, :297:30, :528:12, :579:12, :580:67, :581:67, :582:{19,67}, :584:{12,20,48}, :585:{12,43,51,67}, :586:{12,44,67}, :587:{12,67}, :632:22, :643:12, :708:12
  assign io_latchMulAddB_0 =
    _io_latchMulAddB_0_T | cyc_B6_sqrt | cyc_B4 | cyc_C6_sqrt | cyc_C4 | cyc_C1;	// DivSqrtRecF64_mulAddZ31.scala:258:30, :270:42, :282:35, :285:30, :288:30, :576:16, :591:35
  assign io_mulAddB_0 =
    {_zComplSigT_C1_T_5_53,
     _io_mulAddB_0_T_7[52:46] | _GEN[52:46],
     _GEN_3[45:33] | _GEN[45:33],
     {_GEN_3[32:30], _GEN_3[29:0] | (cyc_C6_sqrt ? sqrSigma1_C[30:1] : 30'h0)}
       | (cyc_C4 ? sqrSigma1_C : 33'h0) | _GEN[32:0]};	// DivSqrtRecF64_mulAddZ31.scala:139:30, :282:35, :285:30, :594:55, :595:55, :596:55, :597:{12,37,55}, :598:{12,55}, :640:11
  assign io_mulAddC_2 =
    {_io_mulAddC_2_T_8[104:56],
     {_io_mulAddC_2_T_8[55:54],
      _io_mulAddC_2_T_8[53:0]
        | (cyc_E3 & ~sqrtOp_PC & ~E_E_div ? {bit0FractA_PC, 53'h0} : 54'h0)}
       | (cyc_E3 & sqrtOp_PC
            ? {(sExp_PC[0]
                  ? {fractB_PC[0], 1'h0}
                  : {fractB_PC[1] ^ fractB_PC[0], fractB_PC[0]}) ^ {~(sigT_E[0]), 1'h0},
               54'h0}
            : 56'h0)};	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:90:30, :117:30, :124:30, :125:30, :126:30, :142:30, :143:30, :293:32, :307:30, :317:30, :579:12, :619:66, :620:66, :621:{12,24,27,51,66}, :622:12, :623:{17,25}, :624:{25,28}, :625:{29,33}, :626:{16,20,28,32}, :627:14
  assign io_rawOutValid_div = leaving_PC & ~sqrtOp_PC;	// DivSqrtRecF64_mulAddZ31.scala:117:30, :293:32, :421:28, :698:39
  assign io_rawOutValid_sqrt = leaving_PC & sqrtOp_PC;	// DivSqrtRecF64_mulAddZ31.scala:117:30, :421:28, :699:39
  assign io_roundingModeOut = roundingMode_PC;	// DivSqrtRecF64_mulAddZ31.scala:127:30
  assign io_invalidExc = majorExc_PC & isNaN_PC;	// DivSqrtRecF64_mulAddZ31.scala:118:30, :120:30, :701:40
  assign io_infiniteExc = majorExc_PC & ~isNaN_PC;	// DivSqrtRecF64_mulAddZ31.scala:118:30, :120:30, :417:25, :702:40
  assign io_rawOut_isNaN = isNaN_PC;	// DivSqrtRecF64_mulAddZ31.scala:120:30
  assign io_rawOut_isInf = isInf_PC;	// DivSqrtRecF64_mulAddZ31.scala:121:30
  assign io_rawOut_isZero = isZero_PC;	// DivSqrtRecF64_mulAddZ31.scala:122:30
  assign io_rawOut_sign = sign_PC;	// DivSqrtRecF64_mulAddZ31.scala:123:30
  assign io_rawOut_sExp =
    (~sqrtOp_PC & E_E_div ? sExp_PC : 13'h0)
    | (sqrtOp_PC | E_E_div ? 13'h0 : sExp_PC + 13'h1)
    | (sqrtOp_PC ? {sExp_PC[12], sExp_PC[12:1]} + 13'h400 : 13'h0);	// DivSqrtRecF64_mulAddZ31.scala:117:30, :124:30, :142:30, :293:32, :693:29, :708:{12,25}, :709:{12,76}, :710:{12,47,52}
  assign io_rawOut_sig =
    {(sqrtOp_PC ? ~isNegRemT_E & ~isZeroRemT_E : isNegRemT_E) ? _GEN_4 : _GEN_4 + 55'h1,
     ~isZeroRemT_E};	// Cat.scala:30:58, DivSqrtRecF64_mulAddZ31.scala:117:30, :144:30, :145:30, :685:{12,24,38,41}, :694:27, :711:29
endmodule

