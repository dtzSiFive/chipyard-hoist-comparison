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

module FPUFMAPipe_3(
  input         clock,
                reset,
                io_in_valid,
                io_in_bits_ren3,
                io_in_bits_swap23,
  input  [2:0]  io_in_bits_rm,
  input  [1:0]  io_in_bits_fmaCmd,
  input  [64:0] io_in_bits_in1,
                io_in_bits_in2,
                io_in_bits_in3,
  output        io_out_valid,
  output [64:0] io_out_bits_data,
  output [4:0]  io_out_bits_exc
);

  wire [32:0] _fma_io_out;	// FPU.scala:712:19
  wire [4:0]  _fma_io_exceptionFlags;	// FPU.scala:712:19
  wire        _fma_io_validout;	// FPU.scala:712:19
  reg         valid;	// FPU.scala:700:18
  reg  [2:0]  in_rm;	// FPU.scala:701:15
  reg  [1:0]  in_fmaCmd;	// FPU.scala:701:15
  reg  [64:0] in_in1;	// FPU.scala:701:15
  reg  [64:0] in_in2;	// FPU.scala:701:15
  reg  [64:0] in_in3;	// FPU.scala:701:15
  reg         io_out_v;	// Valid.scala:117:22
  reg  [64:0] io_out_b_data;	// Reg.scala:15:16
  reg  [4:0]  io_out_b_exc;	// Reg.scala:15:16
  always @(posedge clock) begin
    valid <= io_in_valid;	// FPU.scala:700:18
    if (io_in_valid) begin
      in_rm <= io_in_bits_rm;	// FPU.scala:701:15
      in_fmaCmd <= io_in_bits_fmaCmd;	// FPU.scala:701:15
      in_in1 <= io_in_bits_in1;	// FPU.scala:701:15
      if (io_in_bits_swap23)
        in_in2 <= 65'h80000000;	// FPU.scala:701:15, :708:32
      else
        in_in2 <= io_in_bits_in2;	// FPU.scala:701:15
      if (io_in_bits_ren3 | io_in_bits_swap23)	// FPU.scala:709:21
        in_in3 <= io_in_bits_in3;	// FPU.scala:701:15
      else	// FPU.scala:709:21
        in_in3 <= {32'h0, (io_in_bits_in1[32:0] ^ io_in_bits_in2[32:0]) & 33'h100000000};	// FPU.scala:701:15, :704:{32,50,61}
    end
    if (_fma_io_validout) begin	// FPU.scala:712:19
      io_out_b_data <= {32'h0, _fma_io_out};	// FPU.scala:704:50, :712:19, :722:12, Reg.scala:15:16
      io_out_b_exc <= _fma_io_exceptionFlags;	// FPU.scala:712:19, Reg.scala:15:16
    end
    if (reset)
      io_out_v <= 1'h0;	// FPU.scala:700:18, Valid.scala:117:22
    else
      io_out_v <= _fma_io_validout;	// FPU.scala:712:19, Valid.scala:117:22
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:9];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hA; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        valid = _RANDOM[4'h0][0];	// FPU.scala:700:18
        in_rm = _RANDOM[4'h0][21:19];	// FPU.scala:700:18, :701:15
        in_fmaCmd = _RANDOM[4'h0][23:22];	// FPU.scala:700:18, :701:15
        in_in1 = {_RANDOM[4'h0][31:28], _RANDOM[4'h1], _RANDOM[4'h2][28:0]};	// FPU.scala:700:18, :701:15
        in_in2 = {_RANDOM[4'h2][31:29], _RANDOM[4'h3], _RANDOM[4'h4][29:0]};	// FPU.scala:701:15
        in_in3 = {_RANDOM[4'h4][31:30], _RANDOM[4'h5], _RANDOM[4'h6][30:0]};	// FPU.scala:701:15
        io_out_v = _RANDOM[4'h6][31];	// FPU.scala:701:15, Valid.scala:117:22
        io_out_b_data = {_RANDOM[4'h7], _RANDOM[4'h8], _RANDOM[4'h9][0]};	// Reg.scala:15:16
        io_out_b_exc = _RANDOM[4'h9][5:1];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  MulAddRecFNPipe fma (	// FPU.scala:712:19
    .clock             (clock),
    .reset             (reset),
    .io_validin        (valid),	// FPU.scala:700:18
    .io_op             (in_fmaCmd),	// FPU.scala:701:15
    .io_a              (in_in1[32:0]),	// FPU.scala:701:15, :717:12
    .io_b              (in_in2[32:0]),	// FPU.scala:701:15, :718:12
    .io_c              (in_in3[32:0]),	// FPU.scala:701:15, :719:12
    .io_roundingMode   (in_rm),	// FPU.scala:701:15
    .io_out            (_fma_io_out),
    .io_exceptionFlags (_fma_io_exceptionFlags),
    .io_validout       (_fma_io_validout)
  );
  assign io_out_valid = io_out_v;	// Valid.scala:117:22
  assign io_out_bits_data = io_out_b_data;	// Reg.scala:15:16
  assign io_out_bits_exc = io_out_b_exc;	// Reg.scala:15:16
endmodule

