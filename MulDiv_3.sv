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

module MulDiv_3(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_fn,
  input         io_req_bits_dw,
  input  [63:0] io_req_bits_in1,
                io_req_bits_in2,
  input         io_kill,
                io_resp_ready,
  output        io_req_ready,
                io_resp_valid,
  output [63:0] io_resp_bits_data
);

  reg  [2:0]   state;	// Multiplier.scala:52:22
  reg          req_dw;	// Multiplier.scala:54:16
  reg  [6:0]   count;	// Multiplier.scala:55:18
  reg          neg_out;	// Multiplier.scala:58:20
  reg          isHi;	// Multiplier.scala:59:17
  reg          resHi;	// Multiplier.scala:60:18
  reg  [64:0]  divisor;	// Multiplier.scala:61:20
  reg  [129:0] remainder;	// Multiplier.scala:62:22
  wire [63:0]  result = resHi ? remainder[128:65] : remainder[63:0];	// Multiplier.scala:60:18, :62:22, :90:{19,36,57}
  wire [31:0]  loOut = req_dw | state[0] ? result[31:0] : result[63:32];	// Multiplier.scala:52:22, :54:16, :90:19, :176:23, :177:{18,65,82}
  wire         _io_resp_valid_output = state == 3'h6 | (&state);	// Decode.scala:14:65, Multiplier.scala:52:22, :182:{27,42,51}
  wire         _io_req_ready_output = state == 3'h0;	// Multiplier.scala:52:22, :183:25
  always @(posedge clock) begin
    automatic logic [1:0] _GEN;	// Decode.scala:14:65
    automatic logic       _GEN_0 = io_req_bits_fn[2:1] == 2'h0;	// Decode.scala:14:{65,121}, Multiplier.scala:52:22
    automatic logic       lhs_sign;	// Multiplier.scala:82:23
    automatic logic       rhs_sign;	// Multiplier.scala:82:23
    automatic logic       _GEN_1;	// Multiplier.scala:93:39
    automatic logic       _GEN_2;	// Multiplier.scala:102:39
    automatic logic       _GEN_3;	// Multiplier.scala:107:39
    automatic logic       _GEN_4;	// Multiplier.scala:102:57, :107:50, :125:51, :126:13
    automatic logic       _GEN_5;	// Multiplier.scala:130:39
    automatic logic       _GEN_6;	// Multiplier.scala:139:17
    automatic logic       _GEN_7;	// Decoupled.scala:40:37
    _GEN = {io_req_bits_fn[2], io_req_bits_fn[0]};	// Decode.scala:14:65
    lhs_sign =
      (_GEN_0 | ~(io_req_bits_fn[0]))
      & (io_req_bits_dw ? io_req_bits_in1[63] : io_req_bits_in1[31]);	// Decode.scala:14:{65,121}, :15:30, Multiplier.scala:82:{23,29,38,48}
    rhs_sign =
      (_GEN_0 | _GEN == 2'h2)
      & (io_req_bits_dw ? io_req_bits_in2[63] : io_req_bits_in2[31]);	// CircuitMath.scala:32:10, Decode.scala:14:{65,121}, :15:30, Multiplier.scala:82:{23,29,38,48}
    _GEN_1 = state == 3'h1;	// Decode.scala:14:121, Multiplier.scala:52:22, :93:39
    _GEN_2 = state == 3'h5;	// Decode.scala:14:65, Multiplier.scala:52:22, :102:39
    _GEN_3 = state == 3'h2;	// Decode.scala:14:65, Multiplier.scala:52:22, :107:39
    _GEN_4 = _GEN_3 & count == 7'h3F;	// Multiplier.scala:55:18, :102:57, :107:{39,50}, :125:{25,51}, :126:13
    _GEN_5 = state == 3'h3;	// Multiplier.scala:52:22, :100:11, :130:39
    _GEN_6 = count == 7'h40;	// Multiplier.scala:55:18, :120:36, :139:17
    _GEN_7 = _io_req_ready_output & io_req_valid;	// Decoupled.scala:40:37, Multiplier.scala:183:25
    if (reset)
      state <= 3'h0;	// Multiplier.scala:52:22
    else if (_GEN_7) begin	// Decoupled.scala:40:37
      if (io_req_bits_fn[2])	// Decode.scala:14:65
        state <= {1'h0, ~(lhs_sign | rhs_sign), 1'h1};	// Multiplier.scala:52:22, :54:16, :79:50, :82:23, :166:{36,46}
      else	// Decode.scala:14:65
        state <= 3'h2;	// Decode.scala:14:65, Multiplier.scala:52:22
    end
    else if (io_resp_ready & _io_resp_valid_output | io_kill)	// Decoupled.scala:40:37, Multiplier.scala:162:24, :182:42
      state <= 3'h0;	// Multiplier.scala:52:22
    else if (_GEN_5 & _GEN_6)	// Multiplier.scala:107:50, :130:{39,50}, :139:{17,38}, :140:13
      state <= {1'h1, ~neg_out, 1'h1};	// Multiplier.scala:52:22, :58:20, :79:50, :140:19
    else if (_GEN_4)	// Multiplier.scala:102:57, :107:50, :125:51, :126:13
      state <= 3'h6;	// Decode.scala:14:65, Multiplier.scala:52:22
    else if (_GEN_2)	// Multiplier.scala:102:39
      state <= 3'h7;	// Multiplier.scala:52:22, :104:11
    else if (_GEN_1)	// Multiplier.scala:93:39
      state <= 3'h3;	// Multiplier.scala:52:22, :100:11
    if (_GEN_7) begin	// Decoupled.scala:40:37
      automatic logic cmdHi;	// Decode.scala:15:30
      cmdHi = _GEN == 2'h1 | io_req_bits_fn[1];	// Decode.scala:14:{65,121}, :15:30
      req_dw <= io_req_bits_dw;	// Multiplier.scala:54:16
      count <= {1'h0, ~(io_req_bits_fn[2]) & ~io_req_bits_dw, 5'h0};	// Decode.scala:14:{65,121}, Multiplier.scala:54:16, :55:18, :79:60, :169:{11,38,46}
      if (cmdHi)	// Decode.scala:15:30
        neg_out <= lhs_sign;	// Multiplier.scala:58:20, :82:23
      else	// Decode.scala:15:30
        neg_out <= lhs_sign != rhs_sign;	// Multiplier.scala:58:20, :82:23, :170:46
      isHi <= cmdHi;	// Decode.scala:15:30, Multiplier.scala:59:17
      divisor <=
        {rhs_sign,
         io_req_bits_dw ? io_req_bits_in2[63:32] : {32{rhs_sign}},
         io_req_bits_in2[31:0]};	// Bitwise.scala:72:12, Cat.scala:30:58, Multiplier.scala:61:20, :82:23, :83:{17,43}, :84:15
      remainder <=
        {66'h0,
         io_req_bits_dw ? io_req_bits_in1[63:32] : {32{lhs_sign}},
         io_req_bits_in1[31:0]};	// Bitwise.scala:72:12, Multiplier.scala:62:22, :82:23, :83:{17,43}, :84:15, :95:17, :172:15
    end
    else begin	// Decoupled.scala:40:37
      automatic logic [64:0] _subtractor_T_1;	// Multiplier.scala:89:37
      automatic logic        _eOut_T_9;	// Multiplier.scala:147:24
      automatic logic        divby0;	// Multiplier.scala:147:30
      _subtractor_T_1 = remainder[128:64] - divisor;	// Multiplier.scala:61:20, :62:22, :89:{29,37}
      _eOut_T_9 = count == 7'h0;	// Multiplier.scala:55:18, :124:20, :147:24
      divby0 = _eOut_T_9 & ~(_subtractor_T_1[64]);	// Multiplier.scala:89:37, :134:28, :147:{24,30,33}
      if (_GEN_5) begin	// Multiplier.scala:130:39
        automatic logic [5:0] _eOutPos_T;	// Multiplier.scala:153:35
        _eOutPos_T =
          {|(remainder[63:32]),
           (|(remainder[63:32]))
             ? {|(remainder[63:48]),
                (|(remainder[63:48]))
                  ? {|(remainder[63:56]),
                     (|(remainder[63:56]))
                       ? {|(remainder[63:60]),
                          (|(remainder[63:60]))
                            ? (remainder[63]
                                 ? 2'h3
                                 : remainder[62] ? 2'h2 : {1'h0, remainder[61]})
                            : remainder[59]
                                ? 2'h3
                                : remainder[58] ? 2'h2 : {1'h0, remainder[57]}}
                       : {|(remainder[55:52]),
                          (|(remainder[55:52]))
                            ? (remainder[55]
                                 ? 2'h3
                                 : remainder[54] ? 2'h2 : {1'h0, remainder[53]})
                            : remainder[51]
                                ? 2'h3
                                : remainder[50] ? 2'h2 : {1'h0, remainder[49]}}}
                  : {|(remainder[47:40]),
                     (|(remainder[47:40]))
                       ? {|(remainder[47:44]),
                          (|(remainder[47:44]))
                            ? (remainder[47]
                                 ? 2'h3
                                 : remainder[46] ? 2'h2 : {1'h0, remainder[45]})
                            : remainder[43]
                                ? 2'h3
                                : remainder[42] ? 2'h2 : {1'h0, remainder[41]}}
                       : {|(remainder[39:36]),
                          (|(remainder[39:36]))
                            ? (remainder[39]
                                 ? 2'h3
                                 : remainder[38] ? 2'h2 : {1'h0, remainder[37]})
                            : remainder[35]
                                ? 2'h3
                                : remainder[34] ? 2'h2 : {1'h0, remainder[33]}}}}
             : {|(remainder[31:16]),
                (|(remainder[31:16]))
                  ? {|(remainder[31:24]),
                     (|(remainder[31:24]))
                       ? {|(remainder[31:28]),
                          (|(remainder[31:28]))
                            ? (remainder[31]
                                 ? 2'h3
                                 : remainder[30] ? 2'h2 : {1'h0, remainder[29]})
                            : remainder[27]
                                ? 2'h3
                                : remainder[26] ? 2'h2 : {1'h0, remainder[25]}}
                       : {|(remainder[23:20]),
                          (|(remainder[23:20]))
                            ? (remainder[23]
                                 ? 2'h3
                                 : remainder[22] ? 2'h2 : {1'h0, remainder[21]})
                            : remainder[19]
                                ? 2'h3
                                : remainder[18] ? 2'h2 : {1'h0, remainder[17]}}}
                  : {|(remainder[15:8]),
                     (|(remainder[15:8]))
                       ? {|(remainder[15:12]),
                          (|(remainder[15:12]))
                            ? (remainder[15]
                                 ? 2'h3
                                 : remainder[14] ? 2'h2 : {1'h0, remainder[13]})
                            : remainder[11]
                                ? 2'h3
                                : remainder[10] ? 2'h2 : {1'h0, remainder[9]}}
                       : {|(remainder[7:4]),
                          (|(remainder[7:4]))
                            ? (remainder[7]
                                 ? 2'h3
                                 : remainder[6] ? 2'h2 : {1'h0, remainder[5]})
                            : remainder[3]
                                ? 2'h3
                                : remainder[2] ? 2'h2 : {1'h0, remainder[1]}}}}}
          - {|(divisor[63:32]),
             (|(divisor[63:32]))
               ? {|(divisor[63:48]),
                  (|(divisor[63:48]))
                    ? {|(divisor[63:56]),
                       (|(divisor[63:56]))
                         ? {|(divisor[63:60]),
                            (|(divisor[63:60]))
                              ? (divisor[63]
                                   ? 2'h3
                                   : divisor[62] ? 2'h2 : {1'h0, divisor[61]})
                              : divisor[59]
                                  ? 2'h3
                                  : divisor[58] ? 2'h2 : {1'h0, divisor[57]}}
                         : {|(divisor[55:52]),
                            (|(divisor[55:52]))
                              ? (divisor[55]
                                   ? 2'h3
                                   : divisor[54] ? 2'h2 : {1'h0, divisor[53]})
                              : divisor[51]
                                  ? 2'h3
                                  : divisor[50] ? 2'h2 : {1'h0, divisor[49]}}}
                    : {|(divisor[47:40]),
                       (|(divisor[47:40]))
                         ? {|(divisor[47:44]),
                            (|(divisor[47:44]))
                              ? (divisor[47]
                                   ? 2'h3
                                   : divisor[46] ? 2'h2 : {1'h0, divisor[45]})
                              : divisor[43]
                                  ? 2'h3
                                  : divisor[42] ? 2'h2 : {1'h0, divisor[41]}}
                         : {|(divisor[39:36]),
                            (|(divisor[39:36]))
                              ? (divisor[39]
                                   ? 2'h3
                                   : divisor[38] ? 2'h2 : {1'h0, divisor[37]})
                              : divisor[35]
                                  ? 2'h3
                                  : divisor[34] ? 2'h2 : {1'h0, divisor[33]}}}}
               : {|(divisor[31:16]),
                  (|(divisor[31:16]))
                    ? {|(divisor[31:24]),
                       (|(divisor[31:24]))
                         ? {|(divisor[31:28]),
                            (|(divisor[31:28]))
                              ? (divisor[31]
                                   ? 2'h3
                                   : divisor[30] ? 2'h2 : {1'h0, divisor[29]})
                              : divisor[27]
                                  ? 2'h3
                                  : divisor[26] ? 2'h2 : {1'h0, divisor[25]}}
                         : {|(divisor[23:20]),
                            (|(divisor[23:20]))
                              ? (divisor[23]
                                   ? 2'h3
                                   : divisor[22] ? 2'h2 : {1'h0, divisor[21]})
                              : divisor[19]
                                  ? 2'h3
                                  : divisor[18] ? 2'h2 : {1'h0, divisor[17]}}}
                    : {|(divisor[15:8]),
                       (|(divisor[15:8]))
                         ? {|(divisor[15:12]),
                            (|(divisor[15:12]))
                              ? (divisor[15]
                                   ? 2'h3
                                   : divisor[14] ? 2'h2 : {1'h0, divisor[13]})
                              : divisor[11]
                                  ? 2'h3
                                  : divisor[10] ? 2'h2 : {1'h0, divisor[9]}}
                         : {|(divisor[7:4]),
                            (|(divisor[7:4]))
                              ? (divisor[7]
                                   ? 2'h3
                                   : divisor[6] ? 2'h2 : {1'h0, divisor[5]})
                              : divisor[3]
                                  ? 2'h3
                                  : divisor[2] ? 2'h2 : {1'h0, divisor[1]}}}}};	// Cat.scala:30:58, CircuitMath.scala:30:8, :32:{10,12}, :35:17, :36:17, :37:22, :38:21, Multiplier.scala:54:16, :61:20, :62:22, :90:57, :151:36, :153:35
        if (_eOut_T_9 & ~divby0 & _eOutPos_T != 6'h3F) begin	// Multiplier.scala:118:45, :147:{24,30}, :153:35, :154:{33,41,52}
          count <= {1'h0, ~_eOutPos_T};	// Multiplier.scala:54:16, :55:18, :153:{21,35}, :157:15
          remainder <= {3'h0, {63'h0, remainder[63:0]} << ~_eOutPos_T};	// Multiplier.scala:52:22, :62:22, :90:57, :153:{21,35}, :156:{19,39}
        end
        else begin	// Multiplier.scala:154:41
          count <= count + 7'h1;	// Multiplier.scala:55:18, :124:20, :145:20
          remainder <=
            {1'h0,
             _subtractor_T_1[64] ? remainder[127:64] : _subtractor_T_1[63:0],
             remainder[63:0],
             ~(_subtractor_T_1[64])};	// Multiplier.scala:54:16, :62:22, :89:37, :90:57, :134:28, :135:{14,24,45,67}, :138:15
        end
      end
      else if (_GEN_3) begin	// Multiplier.scala:107:39
        automatic logic [65:0] _prod_T_3;	// Multiplier.scala:113:76
        _prod_T_3 =
          {{65{remainder[64]}}, remainder[0]} * {divisor[64], divisor}
          + {remainder[129], remainder[129:65]};	// Multiplier.scala:61:20, :62:22, :108:31, :109:31, :110:24, :113:{38,67,76}
        count <= count + 7'h1;	// Multiplier.scala:55:18, :124:20
        remainder <=
          {_prod_T_3[65:1], count == 7'h3E & neg_out, _prod_T_3[0], remainder[63:1]};	// Cat.scala:30:58, Multiplier.scala:55:18, :58:20, :62:22, :110:24, :113:76, :114:38, :115:{32,57}, :122:{34,67}
      end
      else if (_GEN_2 | _GEN_1 & remainder[63])	// Multiplier.scala:62:22, :93:{39,57}, :94:{20,27}, :95:17, :102:{39,57}, :103:15
        remainder <= {66'h0, 64'h0 - result};	// Multiplier.scala:54:16, :62:22, :90:19, :91:27, :95:17
      neg_out <= ~(_GEN_5 & divby0 & ~isHi) & neg_out;	// Multiplier.scala:58:20, :59:17, :130:{39,50}, :147:30, :160:{21,28,38}
      if (_GEN_1 & divisor[63])	// Multiplier.scala:61:20, :93:{39,57}, :97:{18,25}, :98:15
        divisor <= _subtractor_T_1;	// Multiplier.scala:61:20, :89:37
    end
    resHi <= ~_GEN_7 & (_GEN_5 & _GEN_6 | _GEN_4 ? isHi : ~_GEN_2 & resHi);	// Decoupled.scala:40:37, Multiplier.scala:59:17, :60:18, :102:{39,57}, :105:11, :107:50, :125:51, :126:13, :127:13, :130:{39,50}, :139:{17,38}, :141:13, :165:24, :168:11
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:10];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        state = _RANDOM[4'h0][2:0];	// Multiplier.scala:52:22
        req_dw = _RANDOM[4'h0][7];	// Multiplier.scala:52:22, :54:16
        count = _RANDOM[4'h4][19:13];	// Multiplier.scala:55:18
        neg_out = _RANDOM[4'h4][20];	// Multiplier.scala:55:18, :58:20
        isHi = _RANDOM[4'h4][21];	// Multiplier.scala:55:18, :59:17
        resHi = _RANDOM[4'h4][22];	// Multiplier.scala:55:18, :60:18
        divisor = {_RANDOM[4'h4][31:23], _RANDOM[4'h5], _RANDOM[4'h6][23:0]};	// Multiplier.scala:55:18, :61:20
        remainder =
          {_RANDOM[4'h6][31:24],
           _RANDOM[4'h7],
           _RANDOM[4'h8],
           _RANDOM[4'h9],
           _RANDOM[4'hA][25:0]};	// Multiplier.scala:61:20, :62:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = _io_req_ready_output;	// Multiplier.scala:183:25
  assign io_resp_valid = _io_resp_valid_output;	// Multiplier.scala:182:42
  assign io_resp_bits_data = {req_dw ? result[63:32] : {32{loOut[31]}}, loOut};	// Bitwise.scala:72:12, Cat.scala:30:58, Multiplier.scala:54:16, :90:19, :177:{18,65}, :178:{18,50}
endmodule

