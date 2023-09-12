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

module SinkD(
  input         clock,
                reset,
                io_d_valid,
  input  [2:0]  io_d_bits_opcode,
  input  [1:0]  io_d_bits_param,
  input  [2:0]  io_d_bits_size,
                io_d_bits_source,
                io_d_bits_sink,
  input         io_d_bits_denied,
  input  [63:0] io_d_bits_data,
  input         io_d_bits_corrupt,
                io_bs_adr_ready,
                io_grant_safe,
  output        io_resp_valid,
                io_resp_bits_last,
  output [2:0]  io_resp_bits_opcode,
                io_resp_bits_param,
                io_resp_bits_source,
                io_resp_bits_sink,
  output        io_resp_bits_denied,
                io_d_ready,
  output [2:0]  io_source,
  output        io_bs_adr_valid,
                io_bs_adr_bits_noop,
  output [2:0]  io_bs_adr_bits_beat,
  output [63:0] io_bs_dat_data
);

  wire        _d_io_deq_ready_T_2;	// SinkD.scala:62:30
  wire        _d_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0]  _d_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [1:0]  _d_io_deq_bits_param;	// Decoupled.scala:296:21
  wire [2:0]  _d_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [2:0]  _d_io_deq_bits_source;	// Decoupled.scala:296:21
  wire        _d_io_deq_bits_denied;	// Decoupled.scala:296:21
  wire        _d_io_deq_bits_corrupt;	// Decoupled.scala:296:21
  wire        _io_resp_valid_T_1 = _d_io_deq_ready_T_2 & _d_io_deq_valid;	// Decoupled.scala:40:37, :296:21, SinkD.scala:62:30
  wire [12:0] _beats1_decode_T_1 = 13'h3F << _d_io_deq_bits_size;	// Decoupled.scala:296:21, package.scala:234:77
  wire [2:0]  beats1 = _d_io_deq_bits_opcode[0] ? ~(_beats1_decode_T_1[5:3]) : 3'h0;	// Decoupled.scala:296:21, Edges.scala:105:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [2:0]  counter;	// Edges.scala:228:27
  wire [2:0]  _counter1_T = counter - 3'h1;	// Edges.scala:228:27, :229:28
  wire        last = counter == 3'h1 | beats1 == 3'h0;	// Edges.scala:220:14, :228:27, :231:{25,37,47}
  wire [2:0]  beat = beats1 & ~_counter1_T;	// Edges.scala:220:14, :229:28, :233:{25,27}
  reg  [2:0]  io_source_r;	// Reg.scala:15:16
  assign _d_io_deq_ready_T_2 = io_bs_adr_ready & ((|counter) | io_grant_safe);	// Edges.scala:228:27, :230:25, SinkD.scala:62:{30,41}
  reg  [2:0]  io_bs_adr_bits_beat_r;	// Reg.scala:15:16
  `ifndef SYNTHESIS	// SinkD.scala:81:10
    always @(posedge clock) begin	// SinkD.scala:81:10
      if (~(~(_d_io_deq_valid & _d_io_deq_bits_corrupt & ~_d_io_deq_bits_denied)
            | reset)) begin	// Decoupled.scala:296:21, SinkD.scala:81:{10,11,39,42}
        if (`ASSERT_VERBOSE_COND_)	// SinkD.scala:81:10
          $error("Assertion failed: Data poisoning unsupported\n    at SinkD.scala:81 assert (!(d.valid && d.bits.corrupt && !d.bits.denied), \"Data poisoning unsupported\")\n");	// SinkD.scala:81:10
        if (`STOP_COND_)	// SinkD.scala:81:10
          $fatal;	// SinkD.scala:81:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (reset)
      counter <= 3'h0;	// Edges.scala:228:27
    else if (_io_resp_valid_T_1) begin	// Decoupled.scala:40:37
      if (|counter)	// Edges.scala:228:27, :230:25
        counter <= _counter1_T;	// Edges.scala:228:27, :229:28
      else if (_d_io_deq_bits_opcode[0])	// Decoupled.scala:296:21, Edges.scala:105:36
        counter <= ~(_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
      else	// Edges.scala:105:36
        counter <= 3'h0;	// Edges.scala:228:27
    end
    if (_d_io_deq_valid) begin	// Decoupled.scala:296:21
      io_source_r <= _d_io_deq_bits_source;	// Decoupled.scala:296:21, Reg.scala:15:16
      io_bs_adr_bits_beat_r <= beat + {2'h0, io_bs_adr_ready};	// Edges.scala:233:25, Reg.scala:15:16, SinkD.scala:77:60
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
        counter = _RANDOM[/*Zero width*/ 1'b0][2:0];	// Edges.scala:228:27
        io_source_r = _RANDOM[/*Zero width*/ 1'b0][5:3];	// Edges.scala:228:27, Reg.scala:15:16
        io_bs_adr_bits_beat_r = _RANDOM[/*Zero width*/ 1'b0][8:6];	// Edges.scala:228:27, Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Queue_25 d (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_d_valid),
    .io_enq_bits_opcode  (io_d_bits_opcode),
    .io_enq_bits_param   (io_d_bits_param),
    .io_enq_bits_size    (io_d_bits_size),
    .io_enq_bits_source  (io_d_bits_source),
    .io_enq_bits_sink    (io_d_bits_sink),
    .io_enq_bits_denied  (io_d_bits_denied),
    .io_enq_bits_data    (io_d_bits_data),
    .io_enq_bits_corrupt (io_d_bits_corrupt),
    .io_deq_ready        (_d_io_deq_ready_T_2),	// SinkD.scala:62:30
    .io_enq_ready        (io_d_ready),
    .io_deq_valid        (_d_io_deq_valid),
    .io_deq_bits_opcode  (_d_io_deq_bits_opcode),
    .io_deq_bits_param   (_d_io_deq_bits_param),
    .io_deq_bits_size    (_d_io_deq_bits_size),
    .io_deq_bits_source  (_d_io_deq_bits_source),
    .io_deq_bits_sink    (io_resp_bits_sink),
    .io_deq_bits_denied  (_d_io_deq_bits_denied),
    .io_deq_bits_data    (io_bs_dat_data),
    .io_deq_bits_corrupt (_d_io_deq_bits_corrupt)
  );
  assign io_resp_valid = (~(|counter) | last) & _io_resp_valid_T_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, :231:37, SinkD.scala:61:{27,36}
  assign io_resp_bits_last = last;	// Edges.scala:231:37
  assign io_resp_bits_opcode = _d_io_deq_bits_opcode;	// Decoupled.scala:296:21
  assign io_resp_bits_param = {1'h0, _d_io_deq_bits_param};	// Decoupled.scala:296:21, SinkD.scala:69:23
  assign io_resp_bits_source = _d_io_deq_bits_source;	// Decoupled.scala:296:21
  assign io_resp_bits_denied = _d_io_deq_bits_denied;	// Decoupled.scala:296:21
  assign io_source = _d_io_deq_valid ? _d_io_deq_bits_source : io_source_r;	// Decoupled.scala:296:21, Reg.scala:15:16, SinkD.scala:56:19
  assign io_bs_adr_valid = (|counter) | _d_io_deq_valid & io_grant_safe;	// Decoupled.scala:296:21, Edges.scala:228:27, :230:25, SinkD.scala:63:{29,41}
  assign io_bs_adr_bits_noop = ~_d_io_deq_valid | ~(_d_io_deq_bits_opcode[0]);	// Decoupled.scala:296:21, Edges.scala:105:36, SinkD.scala:74:{26,35,38}
  assign io_bs_adr_bits_beat = _d_io_deq_valid ? beat : io_bs_adr_bits_beat_r;	// Decoupled.scala:296:21, Edges.scala:233:25, Reg.scala:15:16, SinkD.scala:77:29
endmodule

