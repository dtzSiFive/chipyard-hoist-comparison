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

module IntToFP(
  input         clock,
                reset,
                io_in_valid,
  input  [1:0]  io_in_bits_typeTagIn,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_typ,
  input  [63:0] io_in_bits_in1,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [64:0] _i2f_1_io_out;	// FPU.scala:551:23
  wire [4:0]  _i2f_1_io_exceptionFlags;	// FPU.scala:551:23
  wire [32:0] _i2f_io_out;	// FPU.scala:551:23
  wire [4:0]  _i2f_io_exceptionFlags;	// FPU.scala:551:23
  reg         inPipe_valid;	// Valid.scala:117:22
  reg  [1:0]  inPipe_bits_typeTagIn;	// Reg.scala:15:16
  reg         inPipe_bits_wflags;	// Reg.scala:15:16
  reg  [2:0]  inPipe_bits_rm;	// Reg.scala:15:16
  reg  [1:0]  inPipe_bits_typ;	// Reg.scala:15:16
  reg  [63:0] inPipe_bits_in1;	// Reg.scala:15:16
  wire [63:0] intValue_res =
    inPipe_bits_typ[1]
      ? inPipe_bits_in1
      : {{32{~(inPipe_bits_typ[0]) & inPipe_bits_in1[31]}}, inPipe_bits_in1[31:0]};	// FPU.scala:539:33, :540:64, :541:{13,19,31}, Reg.scala:15:16, package.scala:154:13
  reg  [64:0] io_out_b_data;	// Reg.scala:15:16
  reg  [4:0]  io_out_b_exc;	// Reg.scala:15:16
  always @(posedge clock) begin
    if (reset)
      inPipe_valid <= 1'h0;	// Valid.scala:117:22
    else
      inPipe_valid <= io_in_valid;	// Valid.scala:117:22
    if (io_in_valid) begin
      inPipe_bits_typeTagIn <= io_in_bits_typeTagIn;	// Reg.scala:15:16
      inPipe_bits_wflags <= io_in_bits_wflags;	// Reg.scala:15:16
      inPipe_bits_rm <= io_in_bits_rm;	// Reg.scala:15:16
      inPipe_bits_typ <= io_in_bits_typ;	// Reg.scala:15:16
      inPipe_bits_in1 <= io_in_bits_in1;	// Reg.scala:15:16
    end
    if (inPipe_valid) begin	// Valid.scala:117:22
      if (inPipe_bits_wflags) begin	// Reg.scala:15:16
        automatic logic [64:0] _GEN;	// FPU.scala:409:10
        _GEN =
          ({65{_i2f_1_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF) & _i2f_1_io_out;	// FPU.scala:243:{25,56}, :408:27, :409:10, :551:23
        if (inPipe_bits_typeTagIn[0])	// Reg.scala:15:16, package.scala:31:49
          io_out_b_data <= _GEN;	// FPU.scala:409:10, Reg.scala:15:16
        else	// package.scala:31:49
          io_out_b_data <= {_GEN[64:33], _i2f_io_out};	// Cat.scala:30:58, FPU.scala:409:10, :551:23, :560:55, Reg.scala:15:16
        if (inPipe_bits_typeTagIn[0])	// Reg.scala:15:16, package.scala:31:49
          io_out_b_exc <= _i2f_1_io_exceptionFlags;	// FPU.scala:551:23, Reg.scala:15:16
        else	// package.scala:31:49
          io_out_b_exc <= _i2f_io_exceptionFlags;	// FPU.scala:551:23, Reg.scala:15:16
      end
      else begin	// Reg.scala:15:16
        automatic logic [63:0]  _mux_data_T_2;	// FPU.scala:426:23
        automatic logic         mux_data_rawIn_isZeroExpIn;	// rawFloatFromFN.scala:50:34
        automatic logic [5:0]   mux_data_rawIn_normDist;	// Mux.scala:47:69
        automatic logic [11:0]  _mux_data_rawIn_adjustedExp_T_4;	// rawFloatFromFN.scala:59:15
        automatic logic [114:0] _mux_data_rawIn_subnormFract_T;	// rawFloatFromFN.scala:54:36
        automatic logic [51:0]  mux_data_rawIn_out_sig_lo;	// rawFloatFromFN.scala:72:42
        automatic logic [2:0]   _mux_data_T_4;	// recFNFromFN.scala:48:16
        automatic logic         _GEN_0;	// recFNFromFN.scala:48:79
        automatic logic         mux_data_rawIn_isZeroExpIn_1;	// rawFloatFromFN.scala:50:34
        automatic logic [4:0]   mux_data_rawIn_normDist_1;	// Mux.scala:47:69
        automatic logic [8:0]   _mux_data_rawIn_adjustedExp_T_9;	// rawFloatFromFN.scala:59:15
        automatic logic [2:0]   _mux_data_T_8;	// recFNFromFN.scala:48:16
        automatic logic [53:0]  _mux_data_rawIn_subnormFract_T_2;	// rawFloatFromFN.scala:54:36
        _mux_data_T_2 =
          (inPipe_bits_typeTagIn[0] ? 64'h0 : 64'hFFFFFFFF00000000) | inPipe_bits_in1;	// FPU.scala:426:23, Reg.scala:15:16, package.scala:31:49, :32:76
        mux_data_rawIn_isZeroExpIn = _mux_data_T_2[62:52] == 11'h0;	// FPU.scala:426:23, rawFloatFromFN.scala:47:23, :50:34
        mux_data_rawIn_normDist =
          _mux_data_T_2[51]
            ? 6'h0
            : _mux_data_T_2[50]
                ? 6'h1
                : _mux_data_T_2[49]
                    ? 6'h2
                    : _mux_data_T_2[48]
                        ? 6'h3
                        : _mux_data_T_2[47]
                            ? 6'h4
                            : _mux_data_T_2[46]
                                ? 6'h5
                                : _mux_data_T_2[45]
                                    ? 6'h6
                                    : _mux_data_T_2[44]
                                        ? 6'h7
                                        : _mux_data_T_2[43]
                                            ? 6'h8
                                            : _mux_data_T_2[42]
                                                ? 6'h9
                                                : _mux_data_T_2[41]
                                                    ? 6'hA
                                                    : _mux_data_T_2[40]
                                                        ? 6'hB
                                                        : _mux_data_T_2[39]
                                                            ? 6'hC
                                                            : _mux_data_T_2[38]
                                                                ? 6'hD
                                                                : _mux_data_T_2[37]
                                                                    ? 6'hE
                                                                    : _mux_data_T_2[36]
                                                                        ? 6'hF
                                                                        : _mux_data_T_2[35]
                                                                            ? 6'h10
                                                                            : _mux_data_T_2[34]
                                                                                ? 6'h11
                                                                                : _mux_data_T_2[33]
                                                                                    ? 6'h12
                                                                                    : _mux_data_T_2[32]
                                                                                        ? 6'h13
                                                                                        : _mux_data_T_2[31]
                                                                                            ? 6'h14
                                                                                            : _mux_data_T_2[30]
                                                                                                ? 6'h15
                                                                                                : _mux_data_T_2[29]
                                                                                                    ? 6'h16
                                                                                                    : _mux_data_T_2[28]
                                                                                                        ? 6'h17
                                                                                                        : _mux_data_T_2[27]
                                                                                                            ? 6'h18
                                                                                                            : _mux_data_T_2[26]
                                                                                                                ? 6'h19
                                                                                                                : _mux_data_T_2[25]
                                                                                                                    ? 6'h1A
                                                                                                                    : _mux_data_T_2[24]
                                                                                                                        ? 6'h1B
                                                                                                                        : _mux_data_T_2[23]
                                                                                                                            ? 6'h1C
                                                                                                                            : _mux_data_T_2[22]
                                                                                                                                ? 6'h1D
                                                                                                                                : _mux_data_T_2[21]
                                                                                                                                    ? 6'h1E
                                                                                                                                    : _mux_data_T_2[20]
                                                                                                                                        ? 6'h1F
                                                                                                                                        : _mux_data_T_2[19]
                                                                                                                                            ? 6'h20
                                                                                                                                            : _mux_data_T_2[18]
                                                                                                                                                ? 6'h21
                                                                                                                                                : _mux_data_T_2[17]
                                                                                                                                                    ? 6'h22
                                                                                                                                                    : _mux_data_T_2[16]
                                                                                                                                                        ? 6'h23
                                                                                                                                                        : _mux_data_T_2[15]
                                                                                                                                                            ? 6'h24
                                                                                                                                                            : _mux_data_T_2[14]
                                                                                                                                                                ? 6'h25
                                                                                                                                                                : _mux_data_T_2[13]
                                                                                                                                                                    ? 6'h26
                                                                                                                                                                    : _mux_data_T_2[12]
                                                                                                                                                                        ? 6'h27
                                                                                                                                                                        : _mux_data_T_2[11]
                                                                                                                                                                            ? 6'h28
                                                                                                                                                                            : _mux_data_T_2[10]
                                                                                                                                                                                ? 6'h29
                                                                                                                                                                                : _mux_data_T_2[9]
                                                                                                                                                                                    ? 6'h2A
                                                                                                                                                                                    : _mux_data_T_2[8]
                                                                                                                                                                                        ? 6'h2B
                                                                                                                                                                                        : _mux_data_T_2[7]
                                                                                                                                                                                            ? 6'h2C
                                                                                                                                                                                            : _mux_data_T_2[6]
                                                                                                                                                                                                ? 6'h2D
                                                                                                                                                                                                : _mux_data_T_2[5]
                                                                                                                                                                                                    ? 6'h2E
                                                                                                                                                                                                    : _mux_data_T_2[4]
                                                                                                                                                                                                        ? 6'h2F
                                                                                                                                                                                                        : _mux_data_T_2[3]
                                                                                                                                                                                                            ? 6'h30
                                                                                                                                                                                                            : _mux_data_T_2[2]
                                                                                                                                                                                                                ? 6'h31
                                                                                                                                                                                                                : {5'h19,
                                                                                                                                                                                                                   ~(_mux_data_T_2[1])};	// FPU.scala:426:23, Mux.scala:47:69, primitives.scala:92:52, rawFloatFromFN.scala:48:25
        _mux_data_rawIn_adjustedExp_T_4 =
          (mux_data_rawIn_isZeroExpIn
             ? {6'h3F, ~mux_data_rawIn_normDist}
             : {1'h0, _mux_data_T_2[62:52]})
          + {10'h100, mux_data_rawIn_isZeroExpIn ? 2'h2 : 2'h1};	// FPU.scala:426:23, Mux.scala:47:69, Valid.scala:117:22, rawFloatFromFN.scala:47:23, :50:34, :56:16, :57:26, :59:15, :60:27
        _mux_data_rawIn_subnormFract_T =
          {63'h0, _mux_data_T_2[51:0]} << mux_data_rawIn_normDist;	// FPU.scala:426:23, Mux.scala:47:69, rawFloatFromFN.scala:48:25, :54:36
        mux_data_rawIn_out_sig_lo =
          mux_data_rawIn_isZeroExpIn
            ? {_mux_data_rawIn_subnormFract_T[50:0], 1'h0}
            : _mux_data_T_2[51:0];	// FPU.scala:426:23, Valid.scala:117:22, rawFloatFromFN.scala:48:25, :50:34, :54:{36,47,64}, :72:42
        _mux_data_T_4 =
          mux_data_rawIn_isZeroExpIn & ~(|(_mux_data_T_2[51:0]))
            ? 3'h0
            : _mux_data_rawIn_adjustedExp_T_4[11:9];	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :50:34, :51:38, :59:15, :62:34, recFNFromFN.scala:48:{16,53}
        _GEN_0 =
          _mux_data_T_4[0] | (&(_mux_data_rawIn_adjustedExp_T_4[11:10]))
          & (|(_mux_data_T_2[51:0]));	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :51:38, :59:15, :63:{37,62}, :66:33, recFNFromFN.scala:48:{16,79}
        mux_data_rawIn_isZeroExpIn_1 = _mux_data_T_2[30:23] == 8'h0;	// FPU.scala:426:23, rawFloatFromFN.scala:47:23, :50:34
        mux_data_rawIn_normDist_1 =
          _mux_data_T_2[22]
            ? 5'h0
            : _mux_data_T_2[21]
                ? 5'h1
                : _mux_data_T_2[20]
                    ? 5'h2
                    : _mux_data_T_2[19]
                        ? 5'h3
                        : _mux_data_T_2[18]
                            ? 5'h4
                            : _mux_data_T_2[17]
                                ? 5'h5
                                : _mux_data_T_2[16]
                                    ? 5'h6
                                    : _mux_data_T_2[15]
                                        ? 5'h7
                                        : _mux_data_T_2[14]
                                            ? 5'h8
                                            : _mux_data_T_2[13]
                                                ? 5'h9
                                                : _mux_data_T_2[12]
                                                    ? 5'hA
                                                    : _mux_data_T_2[11]
                                                        ? 5'hB
                                                        : _mux_data_T_2[10]
                                                            ? 5'hC
                                                            : _mux_data_T_2[9]
                                                                ? 5'hD
                                                                : _mux_data_T_2[8]
                                                                    ? 5'hE
                                                                    : _mux_data_T_2[7]
                                                                        ? 5'hF
                                                                        : _mux_data_T_2[6]
                                                                            ? 5'h10
                                                                            : _mux_data_T_2[5]
                                                                                ? 5'h11
                                                                                : _mux_data_T_2[4]
                                                                                    ? 5'h12
                                                                                    : _mux_data_T_2[3]
                                                                                        ? 5'h13
                                                                                        : _mux_data_T_2[2]
                                                                                            ? 5'h14
                                                                                            : _mux_data_T_2[1]
                                                                                                ? 5'h15
                                                                                                : 5'h16;	// FPU.scala:426:23, :533:11, Mux.scala:47:69, primitives.scala:92:52, rawFloatFromFN.scala:48:25
        _mux_data_rawIn_adjustedExp_T_9 =
          (mux_data_rawIn_isZeroExpIn_1
             ? {4'hF, ~mux_data_rawIn_normDist_1}
             : {1'h0, _mux_data_T_2[30:23]})
          + {7'h20, mux_data_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};	// FPU.scala:426:23, Mux.scala:47:69, Valid.scala:117:22, rawFloatFromFN.scala:47:23, :50:34, :56:16, :57:26, :59:15, :60:27
        _mux_data_T_8 =
          mux_data_rawIn_isZeroExpIn_1 & ~(|(_mux_data_T_2[22:0]))
            ? 3'h0
            : _mux_data_rawIn_adjustedExp_T_9[8:6];	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :50:34, :51:38, :59:15, :62:34, recFNFromFN.scala:48:{16,53}
        _mux_data_rawIn_subnormFract_T_2 =
          {31'h0, _mux_data_T_2[22:0]} << mux_data_rawIn_normDist_1;	// FPU.scala:426:23, Mux.scala:47:69, rawFloatFromFN.scala:48:25, :54:36
        io_out_b_data <=
          {_mux_data_T_2[63],
           _mux_data_T_4[2:1],
           _GEN_0,
           (&{_mux_data_T_4[2:1], _GEN_0})
             ? {&(mux_data_rawIn_out_sig_lo[51:32]),
                _mux_data_rawIn_adjustedExp_T_4[7:1],
                _mux_data_T_8[2],
                mux_data_rawIn_out_sig_lo[51:32],
                _mux_data_T_2[31],
                _mux_data_T_8[1],
                _mux_data_T_8[0] | (&(_mux_data_rawIn_adjustedExp_T_9[8:7]))
                  & (|(_mux_data_T_2[22:0])),
                _mux_data_rawIn_adjustedExp_T_9[5:0],
                mux_data_rawIn_isZeroExpIn_1
                  ? {_mux_data_rawIn_subnormFract_T_2[21:0], 1'h0}
                  : _mux_data_T_2[22:0]}
             : {_mux_data_rawIn_adjustedExp_T_4[8:0], mux_data_rawIn_out_sig_lo}};	// Cat.scala:30:58, FPU.scala:243:{25,56}, :333:{8,42}, :334:8, :335:8, :338:8, :339:8, :426:23, Reg.scala:15:16, Valid.scala:117:22, rawFloatFromFN.scala:46:22, :48:25, :50:34, :51:38, :54:{36,47,64}, :59:15, :63:{37,62}, :66:33, :72:42, recFNFromFN.scala:48:{16,79}, :50:23
        io_out_b_exc <= 5'h0;	// FPU.scala:533:11, Reg.scala:15:16
      end
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
        inPipe_valid = _RANDOM[3'h0][0];	// Valid.scala:117:22
        inPipe_bits_typeTagIn = _RANDOM[3'h0][9:8];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_wflags = _RANDOM[3'h0][18];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_rm = _RANDOM[3'h0][21:19];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_typ = _RANDOM[3'h0][23:22];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_in1 = {_RANDOM[3'h0][31:24], _RANDOM[3'h1], _RANDOM[3'h2][23:0]};	// Reg.scala:15:16, Valid.scala:117:22
        io_out_b_data = {_RANDOM[3'h2][31:25], _RANDOM[3'h3], _RANDOM[3'h4][25:0]};	// Reg.scala:15:16
        io_out_b_exc = _RANDOM[3'h4][30:26];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  INToRecFN i2f (	// FPU.scala:551:23
    .io_signedIn       (~(inPipe_bits_typ[0])),	// FPU.scala:552:{26,38}, Reg.scala:15:16
    .io_in             (intValue_res),	// FPU.scala:540:64, :541:13
    .io_roundingMode   (inPipe_bits_rm),	// Reg.scala:15:16
    .io_out            (_i2f_io_out),
    .io_exceptionFlags (_i2f_io_exceptionFlags)
  );
  INToRecFN_1 i2f_1 (	// FPU.scala:551:23
    .io_signedIn       (~(inPipe_bits_typ[0])),	// FPU.scala:552:{26,38}, Reg.scala:15:16
    .io_in             (intValue_res),	// FPU.scala:540:64, :541:13
    .io_roundingMode   (inPipe_bits_rm),	// Reg.scala:15:16
    .io_out            (_i2f_1_io_out),
    .io_exceptionFlags (_i2f_1_io_exceptionFlags)
  );
  assign io_out_bits_data = io_out_b_data;	// Reg.scala:15:16
  assign io_out_bits_exc = io_out_b_exc;	// Reg.scala:15:16
endmodule

