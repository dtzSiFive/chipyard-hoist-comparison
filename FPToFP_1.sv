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

module FPToFP_1(
  input         clock,
                reset,
                io_in_valid,
                io_in_bits_ren2,
  input  [1:0]  io_in_bits_typeTagOut,
  input         io_in_bits_wflags,
  input  [2:0]  io_in_bits_rm,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
  input         io_lt,
  output        io_out_valid,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [32:0] _narrower_io_out;	// FPU.scala:614:30
  wire [4:0]  _narrower_io_exceptionFlags;	// FPU.scala:614:30
  reg         inPipe_valid;	// Valid.scala:117:22
  reg         inPipe_bits_ren2;	// Reg.scala:15:16
  reg  [1:0]  inPipe_bits_typeTagOut;	// Reg.scala:15:16
  reg         inPipe_bits_wflags;	// Reg.scala:15:16
  reg  [2:0]  inPipe_bits_rm;	// Reg.scala:15:16
  reg  [64:0] inPipe_bits_in1;	// Reg.scala:15:16
  reg  [64:0] inPipe_bits_in2;	// Reg.scala:15:16
  wire        signNum =
    inPipe_bits_rm[1]
      ? inPipe_bits_in1[64] ^ inPipe_bits_in2[64]
      : inPipe_bits_rm[0] ^ inPipe_bits_in2[64];	// FPU.scala:577:{20,31,48,66,77}, Reg.scala:15:16
  wire        isNaNOut = (&(inPipe_bits_in1[63:61])) & (&(inPipe_bits_in2[63:61]));	// FPU.scala:243:{25,56}, :588:27, Reg.scala:15:16
  wire        isLHS =
    (&(inPipe_bits_in2[63:61])) | inPipe_bits_rm[0] != io_lt
    & ~(&(inPipe_bits_in1[63:61]));	// FPU.scala:243:{25,56}, :577:77, :589:{24,41,51,54}, Reg.scala:15:16
  wire        _GEN = inPipe_bits_wflags & ~inPipe_bits_ren2;	// FPU.scala:603:{24,27}, Reg.scala:15:16
  wire [35:0] fsgnjMux_data =
    _GEN
      ? ((&(inPipe_bits_in1[63:61])) ? 36'h700400000 : inPipe_bits_in1[64:29])
      : inPipe_bits_wflags
          ? (isNaNOut
               ? 36'h700400000
               : isLHS ? inPipe_bits_in1[64:29] : inPipe_bits_in2[64:29])
          : {signNum, inPipe_bits_in1[63:29]};	// Cat.scala:30:58, FPU.scala:243:{25,56}, :577:20, :582:17, :584:25, :588:27, :589:24, :591:{19,25,53}, :603:{24,42}, :606:24, :607:21, Reg.scala:15:16
  reg         io_out_v;	// Valid.scala:117:22
  reg  [64:0] io_out_b_data;	// Reg.scala:15:16
  reg  [4:0]  io_out_b_exc;	// Reg.scala:15:16
  reg         io_out_outPipe_valid;	// Valid.scala:117:22
  reg  [64:0] io_out_outPipe_bits_data;	// Reg.scala:15:16
  reg  [4:0]  io_out_outPipe_bits_exc;	// Reg.scala:15:16
  reg         io_out_outPipe_valid_1;	// Valid.scala:117:22
  reg  [64:0] io_out_outPipe_bits_1_data;	// Reg.scala:15:16
  reg  [4:0]  io_out_outPipe_bits_1_exc;	// Reg.scala:15:16
  always @(posedge clock) begin
    if (reset) begin
      inPipe_valid <= 1'h0;	// Valid.scala:117:22
      io_out_v <= 1'h0;	// Valid.scala:117:22
      io_out_outPipe_valid <= 1'h0;	// Valid.scala:117:22
      io_out_outPipe_valid_1 <= 1'h0;	// Valid.scala:117:22
    end
    else begin
      inPipe_valid <= io_in_valid;	// Valid.scala:117:22
      io_out_v <= inPipe_valid;	// Valid.scala:117:22
      io_out_outPipe_valid <= io_out_v;	// Valid.scala:117:22
      io_out_outPipe_valid_1 <= io_out_outPipe_valid;	// Valid.scala:117:22
    end
    if (io_in_valid) begin
      inPipe_bits_ren2 <= io_in_bits_ren2;	// Reg.scala:15:16
      inPipe_bits_typeTagOut <= io_in_bits_typeTagOut;	// Reg.scala:15:16
      inPipe_bits_wflags <= io_in_bits_wflags;	// Reg.scala:15:16
      inPipe_bits_rm <= io_in_bits_rm;	// Reg.scala:15:16
      inPipe_bits_in1 <= io_in_bits_in1;	// Reg.scala:15:16
      inPipe_bits_in2 <= io_in_bits_in2;	// Reg.scala:15:16
    end
    if (inPipe_valid) begin	// Valid.scala:117:22
      automatic logic _GEN_0;	// FPU.scala:598:18
      _GEN_0 = inPipe_bits_typeTagOut == 2'h0;	// FPU.scala:598:18, Reg.scala:15:16
      if (_GEN_0) begin	// FPU.scala:598:18
        automatic logic [8:0] _mux_data_expOut_commonCase_T =
          fsgnjMux_data[31:23] - 9'h100;	// FPU.scala:270:18, :274:31, :584:25, :603:42, :607:21
        io_out_b_data <=
          _GEN
            ? {fsgnjMux_data[35:4], _narrower_io_out}
            : {fsgnjMux_data[35:4],
               fsgnjMux_data[35],
               fsgnjMux_data[34:32] == 3'h0 | fsgnjMux_data[34:32] > 3'h5
                 ? {fsgnjMux_data[34:32], _mux_data_expOut_commonCase_T[5:0]}
                 : _mux_data_expOut_commonCase_T,
               fsgnjMux_data[22:0]};	// Cat.scala:30:58, FPU.scala:268:17, :270:18, :271:38, :273:26, :274:{31,48}, :275:{10,19,25,36,65}, :584:25, :598:34, :599:{16,37}, :603:{24,42}, :607:21, :613:120, :614:30, :619:{18,39}, Reg.scala:15:16
      end
      else if (_GEN) begin	// FPU.scala:603:24
        if (&(inPipe_bits_in1[63:61]))	// FPU.scala:243:{25,56}, Reg.scala:15:16
          io_out_b_data <= 65'hE008000000000000;	// FPU.scala:591:25, Reg.scala:15:16
        else	// FPU.scala:243:56
          io_out_b_data <= inPipe_bits_in1;	// Reg.scala:15:16
      end
      else if (inPipe_bits_wflags) begin	// Reg.scala:15:16
        if (isNaNOut)	// FPU.scala:588:27
          io_out_b_data <= 65'hE008000000000000;	// FPU.scala:591:25, Reg.scala:15:16
        else if (isLHS)	// FPU.scala:589:24
          io_out_b_data <= inPipe_bits_in1;	// Reg.scala:15:16
        else	// FPU.scala:589:24
          io_out_b_data <= inPipe_bits_in2;	// Reg.scala:15:16
      end
      else	// Reg.scala:15:16
        io_out_b_data <= {signNum, inPipe_bits_in1[63:0]};	// Cat.scala:30:58, FPU.scala:577:20, :578:45, Reg.scala:15:16
      if (_GEN & _GEN_0)	// FPU.scala:598:18, :603:{24,42}, :613:120, :620:17
        io_out_b_exc <= _narrower_io_exceptionFlags;	// FPU.scala:614:30, Reg.scala:15:16
      else if (_GEN)	// FPU.scala:603:24
        io_out_b_exc <= {(&(inPipe_bits_in1[63:61])) & ~(inPipe_bits_in1[51]), 4'h0};	// FPU.scala:243:{25,56}, :244:{34,37,39}, :608:51, Reg.scala:15:16
      else if (inPipe_bits_wflags)	// Reg.scala:15:16
        io_out_b_exc <=
          {(&(inPipe_bits_in1[63:61])) & ~(inPipe_bits_in1[51])
             | (&(inPipe_bits_in2[63:61])) & ~(inPipe_bits_in2[51]),
           4'h0};	// FPU.scala:243:{25,56}, :244:{34,37,39}, :587:49, :590:31, Reg.scala:15:16
      else	// Reg.scala:15:16
        io_out_b_exc <= 5'h0;	// FPU.scala:581:16, Reg.scala:15:16
    end
    if (io_out_v) begin	// Valid.scala:117:22
      io_out_outPipe_bits_data <= io_out_b_data;	// Reg.scala:15:16
      io_out_outPipe_bits_exc <= io_out_b_exc;	// Reg.scala:15:16
    end
    if (io_out_outPipe_valid) begin	// Valid.scala:117:22
      io_out_outPipe_bits_1_data <= io_out_outPipe_bits_data;	// Reg.scala:15:16
      io_out_outPipe_bits_1_exc <= io_out_outPipe_bits_exc;	// Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:13];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hE; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        inPipe_valid = _RANDOM[4'h0][0];	// Valid.scala:117:22
        inPipe_bits_ren2 = _RANDOM[4'h0][4];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_typeTagOut = _RANDOM[4'h0][11:10];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_wflags = _RANDOM[4'h0][18];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_rm = _RANDOM[4'h0][21:19];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_in1 = {_RANDOM[4'h0][31:28], _RANDOM[4'h1], _RANDOM[4'h2][28:0]};	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_in2 = {_RANDOM[4'h2][31:29], _RANDOM[4'h3], _RANDOM[4'h4][29:0]};	// Reg.scala:15:16
        io_out_v = _RANDOM[4'h6][31];	// Valid.scala:117:22
        io_out_b_data = {_RANDOM[4'h7], _RANDOM[4'h8], _RANDOM[4'h9][0]};	// Reg.scala:15:16
        io_out_b_exc = _RANDOM[4'h9][5:1];	// Reg.scala:15:16
        io_out_outPipe_valid = _RANDOM[4'h9][6];	// Reg.scala:15:16, Valid.scala:117:22
        io_out_outPipe_bits_data =
          {_RANDOM[4'h9][31:7], _RANDOM[4'hA], _RANDOM[4'hB][7:0]};	// Reg.scala:15:16
        io_out_outPipe_bits_exc = _RANDOM[4'hB][12:8];	// Reg.scala:15:16
        io_out_outPipe_valid_1 = _RANDOM[4'hB][13];	// Reg.scala:15:16, Valid.scala:117:22
        io_out_outPipe_bits_1_data =
          {_RANDOM[4'hB][31:14], _RANDOM[4'hC], _RANDOM[4'hD][14:0]};	// Reg.scala:15:16
        io_out_outPipe_bits_1_exc = _RANDOM[4'hD][19:15];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RecFNToRecFN narrower (	// FPU.scala:614:30
    .io_in             (inPipe_bits_in1),	// Reg.scala:15:16
    .io_roundingMode   (inPipe_bits_rm),	// Reg.scala:15:16
    .io_detectTininess (1'h1),	// FPU.scala:613:100
    .io_out            (_narrower_io_out),
    .io_exceptionFlags (_narrower_io_exceptionFlags)
  );
  assign io_out_valid = io_out_outPipe_valid_1;	// Valid.scala:117:22
  assign io_out_bits_data = io_out_outPipe_bits_1_data;	// Reg.scala:15:16
  assign io_out_bits_exc = io_out_outPipe_bits_1_exc;	// Reg.scala:15:16
endmodule

