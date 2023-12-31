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

module PipelinedMultiplier(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_fn,
  input         io_req_bits_dw,
  input  [63:0] io_req_bits_in1,
                io_req_bits_in2,
  output [63:0] io_resp_bits_data
);

  reg        inPipe_valid;	// Valid.scala:117:22
  reg [3:0]  inPipe_bits_fn;	// Reg.scala:15:16
  reg        inPipe_bits_dw;	// Reg.scala:15:16
  reg [63:0] inPipe_bits_in1;	// Reg.scala:15:16
  reg [63:0] inPipe_bits_in2;	// Reg.scala:15:16
  reg        io_resp_bits_data_v;	// Valid.scala:117:22
  reg [63:0] io_resp_bits_data_b;	// Reg.scala:15:16
  reg [63:0] io_resp_bits_data_outPipe_bits;	// Reg.scala:15:16
  always @(posedge clock) begin
    if (reset) begin
      inPipe_valid <= 1'h0;	// Valid.scala:117:22
      io_resp_bits_data_v <= 1'h0;	// Valid.scala:117:22
    end
    else begin
      inPipe_valid <= io_req_valid;	// Valid.scala:117:22
      io_resp_bits_data_v <= inPipe_valid;	// Valid.scala:117:22
    end
    if (io_req_valid) begin
      inPipe_bits_fn <= io_req_bits_fn;	// Reg.scala:15:16
      inPipe_bits_dw <= io_req_bits_dw;	// Reg.scala:15:16
      inPipe_bits_in1 <= io_req_bits_in1;	// Reg.scala:15:16
      inPipe_bits_in2 <= io_req_bits_in2;	// Reg.scala:15:16
    end
    if (inPipe_valid) begin	// Valid.scala:117:22
      automatic logic [127:0] prod;	// Multiplier.scala:205:18
      prod =
        {{64{(~(inPipe_bits_fn[1]) | ~(inPipe_bits_fn[0])) & inPipe_bits_in1[63]}},
         inPipe_bits_in1}
        * {{64{~(inPipe_bits_fn[1]) & inPipe_bits_in2[63]}}, inPipe_bits_in2};	// Decode.scala:14:{65,121}, :15:30, Multiplier.scala:203:{27,41}, :204:{27,41}, :205:18, Reg.scala:15:16
      if (inPipe_bits_fn[0] | inPipe_bits_fn[1])	// Decode.scala:14:65, :15:30, Reg.scala:15:16
        io_resp_bits_data_b <= prod[127:64];	// Multiplier.scala:205:18, :206:30, Reg.scala:15:16
      else if (inPipe_bits_dw)	// Reg.scala:15:16
        io_resp_bits_data_b <= prod[63:0];	// Multiplier.scala:205:18, :206:101, Reg.scala:15:16
      else	// Reg.scala:15:16
        io_resp_bits_data_b <= {{32{prod[31]}}, prod[31:0]};	// Bitwise.scala:72:12, Cat.scala:30:58, Multiplier.scala:205:18, :206:67, Reg.scala:15:16, package.scala:123:38
    end
    if (io_resp_bits_data_v)	// Valid.scala:117:22
      io_resp_bits_data_outPipe_bits <= io_resp_bits_data_b;	// Reg.scala:15:16
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:17];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h12; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        inPipe_valid = _RANDOM[5'h0][0];	// Valid.scala:117:22
        inPipe_bits_fn = _RANDOM[5'h0][4:1];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_dw = _RANDOM[5'h0][5];	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_in1 = {_RANDOM[5'h0][31:6], _RANDOM[5'h1], _RANDOM[5'h2][5:0]};	// Reg.scala:15:16, Valid.scala:117:22
        inPipe_bits_in2 = {_RANDOM[5'h2][31:6], _RANDOM[5'h3], _RANDOM[5'h4][5:0]};	// Reg.scala:15:16
        io_resp_bits_data_v = _RANDOM[5'hD][1];	// Valid.scala:117:22
        io_resp_bits_data_b = {_RANDOM[5'hD][31:2], _RANDOM[5'hE], _RANDOM[5'hF][1:0]};	// Reg.scala:15:16, Valid.scala:117:22
        io_resp_bits_data_outPipe_bits =
          {_RANDOM[5'hF][31:3], _RANDOM[5'h10], _RANDOM[5'h11][2:0]};	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_resp_bits_data = io_resp_bits_data_outPipe_bits;	// Reg.scala:15:16
endmodule

