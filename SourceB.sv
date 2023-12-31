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

module SourceB(
  input         clock,
                reset,
                io_req_valid,
  input  [2:0]  io_req_bits_param,
  input  [12:0] io_req_bits_tag,
  input  [9:0]  io_req_bits_set,
  input  [5:0]  io_req_bits_clients,
  input         io_b_ready,
  output        io_req_ready,
                io_b_valid,
  output [1:0]  io_b_bits_param,
  output [6:0]  io_b_bits_source,
  output [31:0] io_b_bits_address
);

  reg  [5:0]  remain;	// SourceB.scala:44:25
  wire [5:0]  todo = (|remain) ? remain : io_req_bits_clients;	// SourceB.scala:44:25, :49:26, :50:19
  wire [4:0]  _next_T_2 = todo[4:0] | {todo[3:0], 1'h0};	// SourceB.scala:50:19, package.scala:244:{43,53}
  wire [4:0]  _next_T_5 = _next_T_2 | {_next_T_2[2:0], 2'h0};	// Cat.scala:30:58, package.scala:244:{43,53}
  wire [5:0]  _GEN = {~(_next_T_5 | {_next_T_5[0], 4'h0}), 1'h1} & todo;	// SourceB.scala:50:19, :51:{16,37}, package.scala:244:{43,48,53}
  `ifndef SYNTHESIS	// SourceB.scala:57:12
    always @(posedge clock) begin	// SourceB.scala:57:12
      if (~(~io_req_valid | (|io_req_bits_clients) | reset)) begin	// SourceB.scala:57:{12,13,50}
        if (`ASSERT_VERBOSE_COND_)	// SourceB.scala:57:12
          $error("Assertion failed\n    at SourceB.scala:57 assert (!io.req.valid || io.req.bits.clients =/= UInt(0))\n");	// SourceB.scala:57:12
        if (`STOP_COND_)	// SourceB.scala:57:12
          $fatal;	// SourceB.scala:57:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _param_T_1 = ~(|remain) & io_req_valid;	// Decoupled.scala:40:37, SourceB.scala:44:25, :49:26, :59:21
  wire        b_valid = (|remain) | io_req_valid;	// SourceB.scala:44:25, :49:26, :66:21
  reg  [12:0] tag_r;	// Reg.scala:15:16
  wire [12:0] tag = (|remain) ? tag_r : io_req_bits_tag;	// Reg.scala:15:16, SourceB.scala:44:25, :49:26, :70:18
  reg  [9:0]  set_r;	// Reg.scala:15:16
  reg  [2:0]  param_r;	// Reg.scala:15:16
  always @(posedge clock) begin
    if (reset)
      remain <= 6'h0;	// SourceB.scala:44:25
    else
      remain <=
        (remain | (_param_T_1 ? io_req_bits_clients : 6'h0))
        & ~(io_b_ready & b_valid ? _GEN : 6'h0);	// Decoupled.scala:40:37, SourceB.scala:44:25, :47:{23,37,39}, :51:37, :60:{26,39}, :66:21, :67:{21,34}
    if (_param_T_1) begin	// Decoupled.scala:40:37
      tag_r <= io_req_bits_tag;	// Reg.scala:15:16
      set_r <= io_req_bits_set;	// Reg.scala:15:16
      param_r <= io_req_bits_param;	// Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        remain = _RANDOM[/*Zero width*/ 1'b0][5:0];	// SourceB.scala:44:25
        tag_r = _RANDOM[/*Zero width*/ 1'b0][18:6];	// Reg.scala:15:16, SourceB.scala:44:25
        set_r = _RANDOM[/*Zero width*/ 1'b0][28:19];	// Reg.scala:15:16, SourceB.scala:44:25
        param_r = _RANDOM[/*Zero width*/ 1'b0][31:29];	// Reg.scala:15:16, SourceB.scala:44:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = ~(|remain);	// SourceB.scala:44:25, :49:26, :59:21
  assign io_b_valid = b_valid;	// SourceB.scala:66:21
  assign io_b_bits_param = (|remain) ? param_r[1:0] : io_req_bits_param[1:0];	// Reg.scala:15:16, SourceB.scala:44:25, :49:26, :72:20
  assign io_b_bits_source =
    {_GEN[0],
     (_GEN[1] ? 6'h3C : 6'h0) | (_GEN[2] ? 6'h38 : 6'h0) | {_GEN[4], 5'h0}
       | (_GEN[5] ? 6'h30 : 6'h0)};	// Mux.scala:27:72, :29:36, SourceB.scala:44:25, :51:37
  assign io_b_bits_address =
    {tag[12], 3'h0, tag[11:0], (|remain) ? set_r : io_req_bits_set, 6'h0};	// Cat.scala:30:58, Parameters.scala:226:72, Reg.scala:15:16, SourceB.scala:44:25, :49:26, :70:18, :71:18
endmodule

