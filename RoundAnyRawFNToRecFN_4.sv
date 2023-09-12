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

module RoundAnyRawFNToRecFN_4(
  input         io_invalidExc,
                io_infiniteExc,
                io_in_isNaN,
                io_in_isInf,
                io_in_isZero,
                io_in_sign,
  input  [12:0] io_in_sExp,
  input  [55:0] io_in_sig,
  input  [2:0]  io_roundingMode,
  input         io_detectTininess,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;	// RoundAnyRawFNToRecFN.scala:88:53, primitives.scala:61:24
  wire        roundingMode_odd = io_roundingMode == 3'h6;	// RoundAnyRawFNToRecFN.scala:93:53
  wire        roundMagUp =
    io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign;	// RoundAnyRawFNToRecFN.scala:90:53, :91:53, :96:{27,42,63,66}, :194:50
  wire [11:0] _roundMask_T_1 = ~(io_in_sExp[11:0]);	// RoundAnyRawFNToRecFN.scala:154:37, primitives.scala:51:21
  wire [64:0] roundMask_shift = $signed(65'sh10000000000000000 >>> _roundMask_T_1[5:0]);	// primitives.scala:51:21, :58:26, :77:58
  wire [7:0]  _GEN =
    {{roundMask_shift[24:21], roundMask_shift[28:27]} & 6'h33, 2'h0}
    | {roundMask_shift[28:25], roundMask_shift[32:29]} & 8'h33;	// Bitwise.scala:103:{21,31,39,75}, :109:18, primitives.scala:77:58, :79:22
  wire [18:0] _GEN_0 =
    {roundMask_shift[18:17],
     roundMask_shift[20:19],
     roundMask_shift[22:21],
     _GEN,
     roundMask_shift[32:31],
     roundMask_shift[34:33],
     roundMask_shift[36]} & 19'h55555;	// Bitwise.scala:103:{21,31,39}, primitives.scala:77:58
  wire [64:0] roundMask_shift_1 = $signed(65'sh10000000000000000 >>> _roundMask_T_1[5:0]);	// primitives.scala:51:21, :58:26, :77:58
  wire [53:0] _roundMask_T_115 =
    _roundMask_T_1[11]
      ? (_roundMask_T_1[10]
           ? {~(_roundMask_T_1[9] | _roundMask_T_1[8] | _roundMask_T_1[7]
                | _roundMask_T_1[6]
                  ? 51'h0
                  : ~{roundMask_shift[13],
                      roundMask_shift[14],
                      roundMask_shift[15],
                      roundMask_shift[16],
                      roundMask_shift[17],
                      _GEN_0[18:15] | {roundMask_shift[20:19], roundMask_shift[22:21]}
                        & 4'h5,
                      _GEN_0[14:7] | _GEN & 8'h55,
                      _GEN[1],
                      _GEN_0[5] | roundMask_shift[31],
                      roundMask_shift[32],
                      roundMask_shift[33],
                      {_GEN_0[2:0], 1'h0}
                        | {roundMask_shift[36:35], roundMask_shift[38:37]} & 4'h5,
                      roundMask_shift[38],
                      roundMask_shift[39],
                      roundMask_shift[40],
                      roundMask_shift[41],
                      roundMask_shift[42],
                      roundMask_shift[43],
                      roundMask_shift[44],
                      roundMask_shift[45],
                      roundMask_shift[46],
                      roundMask_shift[47],
                      roundMask_shift[48],
                      roundMask_shift[49],
                      {{roundMask_shift[50:49], roundMask_shift[52]} & 3'h5, 1'h0}
                        | {roundMask_shift[52:51], roundMask_shift[54:53]} & 4'h5,
                      roundMask_shift[54],
                      roundMask_shift[55],
                      roundMask_shift[56],
                      roundMask_shift[57],
                      roundMask_shift[58],
                      roundMask_shift[59],
                      roundMask_shift[60],
                      roundMask_shift[61],
                      roundMask_shift[62],
                      roundMask_shift[63]}),
              3'h7}
           : {51'h0,
              _roundMask_T_1[9] & _roundMask_T_1[8] & _roundMask_T_1[7]
              & _roundMask_T_1[6]
                ? {roundMask_shift_1[0], roundMask_shift_1[1], roundMask_shift_1[2]}
                : 3'h0})
      : 54'h0;	// Bitwise.scala:103:{21,31,39,46,75}, :109:{18,44}, Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:218:62, primitives.scala:51:21, :57:25, :58:26, :61:24, :66:24, :74:{17,21,36}, :77:58, :79:22
  wire        _common_underflow_T_4 = _roundMask_T_115[0] | io_in_sig[55];	// RoundAnyRawFNToRecFN.scala:118:61, :157:23, primitives.scala:61:24
  wire [54:0] _GEN_1 = {1'h1, ~(_roundMask_T_115[53:1]), ~_common_underflow_T_4};	// Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:157:23, :161:28, :172:49, primitives.scala:61:24
  wire [54:0] _GEN_2 = {_roundMask_T_115[53:1], _common_underflow_T_4, 1'h1};	// Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:157:23, :172:49, primitives.scala:61:24
  wire [54:0] _roundPosBit_T = io_in_sig[55:1] & _GEN_1 & _GEN_2;	// Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:162:40
  wire [54:0] _anyRoundExtra_T = io_in_sig[54:0] & _GEN_2;	// Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:163:42
  wire        anyRound = (|_roundPosBit_T) | (|_anyRoundExtra_T);	// RoundAnyRawFNToRecFN.scala:162:{40,56}, :163:{42,62}, :164:36
  wire        _overflow_roundMagUp_T = roundingMode_near_even | io_roundingMode == 3'h4;	// RoundAnyRawFNToRecFN.scala:88:53, :92:53, :167:38
  wire [54:0] roundedSig =
    _overflow_roundMagUp_T & (|_roundPosBit_T) | roundMagUp & anyRound
      ? {1'h0, io_in_sig[55:2] | {_roundMask_T_115[53:1], _common_underflow_T_4}} + 55'h1
        & ~(roundingMode_near_even & (|_roundPosBit_T) & ~(|_anyRoundExtra_T)
              ? {_roundMask_T_115[53:1], _common_underflow_T_4, 1'h1}
              : 55'h0)
      : {1'h0, io_in_sig[55:2] & {~(_roundMask_T_115[53:1]), ~_common_underflow_T_4}}
        | (roundingMode_odd & anyRound ? _GEN_1 & _GEN_2 : 55'h0);	// Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:88:53, :93:53, :96:42, :157:23, :160:57, :161:{28,46}, :162:{40,56}, :163:{42,62}, :164:36, :167:{38,67}, :168:31, :169:29, :171:16, :172:{32,49,61}, :173:{21,25,64}, :174:30, :178:{30,43,47}, :179:{24,42,67}, :218:62, primitives.scala:61:24
  wire [13:0] sRoundedExp = {io_in_sExp[12], io_in_sExp} + {12'h0, roundedSig[54:53]};	// RoundAnyRawFNToRecFN.scala:171:16, :183:{40,54}, :251:18
  wire        common_totalUnderflow = $signed(sRoundedExp) < 14'sh3CE;	// RoundAnyRawFNToRecFN.scala:183:40, :198:31
  wire        isNaNOut = io_invalidExc | io_in_isNaN;	// RoundAnyRawFNToRecFN.scala:233:34
  wire        notNaN_isSpecialInfOut = io_infiniteExc | io_in_isInf;	// RoundAnyRawFNToRecFN.scala:234:49
  wire        commonCase = ~isNaNOut & ~notNaN_isSpecialInfOut & ~io_in_isZero;	// RoundAnyRawFNToRecFN.scala:233:34, :234:49, :235:{22,36,61,64}
  wire        overflow = commonCase & $signed(sRoundedExp[13:10]) > 4'sh2;	// RoundAnyRawFNToRecFN.scala:183:40, :194:{30,50}, :235:61, :236:32
  wire        overflow_roundMagUp = _overflow_roundMagUp_T | roundMagUp;	// RoundAnyRawFNToRecFN.scala:96:42, :167:38, :241:60
  wire        pegMinNonzeroMagOut =
    commonCase & common_totalUnderflow & (roundMagUp | roundingMode_odd);	// RoundAnyRawFNToRecFN.scala:93:53, :96:42, :198:31, :235:61, :243:{45,60}
  wire        pegMaxFiniteMagOut = overflow & ~overflow_roundMagUp;	// RoundAnyRawFNToRecFN.scala:236:32, :241:60, :244:{39,42}
  wire        notNaN_isInfOut = notNaN_isSpecialInfOut | overflow & overflow_roundMagUp;	// RoundAnyRawFNToRecFN.scala:234:49, :236:32, :241:60, :246:{32,45}
  assign io_out =
    {~isNaNOut & io_in_sign,
     sRoundedExp[11:0] & ~(io_in_isZero | common_totalUnderflow ? 12'hE00 : 12'h0)
       & ~(pegMinNonzeroMagOut ? 12'hC31 : 12'h0) & {1'h1, ~pegMaxFiniteMagOut, 10'h3FF}
       & {2'h3, ~notNaN_isInfOut, 9'h1FF} | (pegMinNonzeroMagOut ? 12'h3CE : 12'h0)
       | (pegMaxFiniteMagOut ? 12'hBFF : 12'h0) | (notNaN_isInfOut ? 12'hC00 : 12'h0)
       | (isNaNOut ? 12'hE00 : 12'h0),
     (isNaNOut | io_in_isZero | common_totalUnderflow
        ? {isNaNOut, 51'h0}
        : io_in_sig[55] ? roundedSig[52:1] : roundedSig[51:0])
       | {52{pegMaxFiniteMagOut}}};	// Bitwise.scala:72:12, Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:118:61, :171:16, :172:49, :183:40, :185:37, :187:16, :188:27, :189:27, :198:31, :233:34, :243:45, :244:39, :246:32, :248:22, :251:{14,18,32}, :255:{14,18}, :256:19, :259:{14,18}, :262:17, :263:{14,18}, :267:16, :271:16, :275:{16,77}, :276:16, :278:{12,38}, :279:16, :281:11, primitives.scala:74:21
  assign io_exceptionFlags =
    {io_invalidExc,
     io_infiniteExc,
     overflow,
     commonCase
       & (common_totalUnderflow | anyRound & io_in_sExp[12:11] != 2'h1
          & (io_in_sig[55] ? _roundMask_T_115[1] : _common_underflow_T_4)
          & ~(io_detectTininess
              & ~(io_in_sig[55] ? _roundMask_T_115[2] : _roundMask_T_115[1])
              & (io_in_sig[55] ? roundedSig[54] : roundedSig[53]) & (|_roundPosBit_T)
              & (_overflow_roundMagUp_T & (io_in_sig[55] ? io_in_sig[2] : io_in_sig[1])
                 | roundMagUp & (io_in_sig[55] & io_in_sig[2] | (|(io_in_sig[1:0])))))),
     overflow | commonCase & (common_totalUnderflow | anyRound)};	// Bitwise.scala:103:75, Cat.scala:30:58, RoundAnyRawFNToRecFN.scala:96:42, :118:61, :157:23, :162:{40,56}, :164:36, :167:38, :171:16, :198:31, :201:{16,45,61}, :203:{30,49,63,70}, :205:67, :206:46, :207:29, :209:16, :210:27, :211:27, :215:40, :218:{48,62}, :219:{30,57,76}, :220:27, :221:{34,39}, :222:49, :225:60, :228:49, :235:61, :236:32, :237:32, :238:{28,43}, primitives.scala:61:24
endmodule

