// Generated by CIRCT firtool-1.54.0-30-g7bb1650e3
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

module TLMonitor_60(
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
  input [31:0] io_in_a_bits_address,
  input        io_in_d_valid,
  input [2:0]  io_in_d_bits_opcode,
  input [1:0]  io_in_d_bits_param,
  input [3:0]  io_in_d_bits_size,
  input [2:0]  io_in_d_bits_sink,
  input        io_in_d_bits_denied,
               io_in_d_bits_corrupt
);

  wire [31:0] _plusarg_reader_1_out;	// PlusArg.scala:80:11
  wire [31:0] _plusarg_reader_out;	// PlusArg.scala:80:11
  wire        _a_first_T_1 = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg  [8:0]  a_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode;	// Monitor.scala:384:22
  reg  [2:0]  param;	// Monitor.scala:385:22
  reg  [3:0]  size;	// Monitor.scala:386:22
  reg         source;	// Monitor.scala:387:22
  reg  [31:0] address;	// Monitor.scala:388:22
  reg  [8:0]  d_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode_1;	// Monitor.scala:535:22
  reg  [1:0]  param_1;	// Monitor.scala:536:22
  reg  [3:0]  size_1;	// Monitor.scala:537:22
  reg         source_1;	// Monitor.scala:538:22
  reg  [2:0]  sink;	// Monitor.scala:539:22
  reg         denied;	// Monitor.scala:540:22
  reg         inflight;	// Monitor.scala:611:27
  reg  [3:0]  inflight_opcodes;	// Monitor.scala:613:35
  reg  [7:0]  inflight_sizes;	// Monitor.scala:615:33
  reg  [8:0]  a_first_counter_1;	// Edges.scala:228:27
  wire        a_first_1 = a_first_counter_1 == 9'h0;	// Edges.scala:220:14, :228:27, :230:25
  reg  [8:0]  d_first_counter_1;	// Edges.scala:228:27
  wire        d_first_1 = d_first_counter_1 == 9'h0;	// Edges.scala:220:14, :228:27, :230:25
  wire        a_set = _a_first_T_1 & a_first_1;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:652:27
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;	// Monitor.scala:670:46
  wire        _GEN = io_in_d_valid & d_first_1;	// Edges.scala:230:25, Monitor.scala:671:26
  wire        d_clr_wo_ready = _GEN & ~d_release_ack;	// Monitor.scala:670:46, :671:{26,71,74}
  reg  [31:0] watchdog;	// Monitor.scala:706:27
  reg         inflight_1;	// Monitor.scala:723:35
  reg  [7:0]  inflight_sizes_1;	// Monitor.scala:725:35
  reg  [8:0]  d_first_counter_2;	// Edges.scala:228:27
  wire        d_first_2 = d_first_counter_2 == 9'h0;	// Edges.scala:220:14, :228:27, :230:25
  wire        d_clr_1 = io_in_d_valid & d_first_2 & d_release_ack;	// Edges.scala:230:25, Monitor.scala:670:46, :783:72
  reg  [31:0] watchdog_1;	// Monitor.scala:813:27
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN_0 =
        {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:690:38
      automatic logic [7:0][2:0] _GEN_1 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:689:38
      automatic logic            _GEN_2 = io_in_d_valid & io_in_d_bits_opcode == 3'h6;	// Monitor.scala:310:{25,52}
      automatic logic            _GEN_3 = io_in_d_bits_size > 4'h2 | reset;	// Monitor.scala:49:11, :312:27
      automatic logic            _GEN_4 = io_in_d_bits_param == 2'h0 | reset;	// Monitor.scala:49:11, :312:27, :313:28
      automatic logic            _GEN_5 = ~io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :314:15
      automatic logic            _GEN_6 = io_in_d_valid & io_in_d_bits_opcode == 3'h4;	// Monitor.scala:318:{25,47}
      automatic logic            _GEN_7 = io_in_d_bits_param != 2'h3 | reset;	// Bundles.scala:102:26, Monitor.scala:49:11
      automatic logic            _GEN_8 = io_in_d_bits_param != 2'h2 | reset;	// Bundles.scala:108:27, Monitor.scala:49:11, :323:28
      automatic logic            _GEN_9 = io_in_d_valid & io_in_d_bits_opcode == 3'h5;	// Monitor.scala:328:{25,51}
      automatic logic            _GEN_10 =
        ~io_in_d_bits_denied | io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :315:15
      automatic logic            _GEN_11 = io_in_d_valid & io_in_d_bits_opcode == 3'h0;	// Monitor.scala:338:{25,51}
      automatic logic            _GEN_12 = io_in_d_bits_opcode == 3'h1;	// Monitor.scala:346:25
      automatic logic            _GEN_13 = io_in_d_valid & _GEN_12;	// Monitor.scala:346:{25,55}
      automatic logic            _GEN_14 = io_in_d_valid & io_in_d_bits_opcode == 3'h2;	// Monitor.scala:354:{25,49}
      automatic logic            _GEN_15;	// Monitor.scala:389:19
      automatic logic            _GEN_16;	// Monitor.scala:541:19
      automatic logic            a_set_wo_ready = io_in_a_valid & a_first_1;	// Edges.scala:230:25, Monitor.scala:648:26
      automatic logic            _GEN_17 = d_clr_wo_ready & a_set_wo_ready;	// Monitor.scala:648:26, :671:71, :684:30
      automatic logic            _GEN_18 = d_clr_wo_ready & ~a_set_wo_ready;	// Monitor.scala:648:26, :671:71, :684:30
      automatic logic [7:0]      _GEN_19 = {4'h0, io_in_d_bits_size};	// Bundles.scala:108:27, Misc.scala:205:21, Monitor.scala:634:69, :638:65, :656:79, :657:77, :691:36
      _GEN_15 = io_in_a_valid & (|a_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:389:19
      _GEN_16 = io_in_d_valid & (|d_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:541:19
      if (io_in_a_valid
          & ~({io_in_a_bits_address[31:14], ~(io_in_a_bits_address[13:12])} == 20'h0
              | {io_in_a_bits_address[31:15], io_in_a_bits_address[13:12]} == 19'h0
              | {io_in_a_bits_address[31:17], ~(io_in_a_bits_address[16])} == 16'h0
              | {io_in_a_bits_address[31:18], io_in_a_bits_address[17:16] ^ 2'h2} == 16'h0
              | {io_in_a_bits_address[31:21],
                 io_in_a_bits_address[20:12] ^ 9'h100} == 20'h0
              | {io_in_a_bits_address[31:26],
                 io_in_a_bits_address[25:16] ^ 10'h200} == 16'h0
              | {io_in_a_bits_address[31:26],
                 io_in_a_bits_address[25:12] ^ 14'h2010} == 20'h0
              | {io_in_a_bits_address[31:28], ~(io_in_a_bits_address[27:26])} == 6'h0
              | {io_in_a_bits_address[31:29],
                 io_in_a_bits_address[28:12] ^ 17'h10000} == 20'h0
              | {io_in_a_bits_address[31],
                 io_in_a_bits_address[30:12] ^ 19'h54000} == 20'h0
              | io_in_a_bits_address[31:28] == 4'h8 | reset)) begin	// Bundles.scala:108:27, :256:54, Edges.scala:20:16, Monitor.scala:42:11, Parameters.scala:137:{31,49,52,67}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_a_valid & ~(io_in_a_bits_address[5:0] == 6'h0 | reset)) begin	// Edges.scala:20:{16,24}, Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid & ~(io_in_d_bits_opcode != 3'h7 | reset)) begin	// Bundles.scala:42:24, Monitor.scala:49:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel has invalid opcode (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_2 & ~_GEN_3) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_2 & ~_GEN_4) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_2 & ~_GEN_5) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_2 & ~(~io_in_d_bits_denied | reset)) begin	// Monitor.scala:49:11, :310:52, :315:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is denied (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_6 & ~_GEN_3) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant smaller than a beat (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_6 & ~_GEN_7) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid cap param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_6 & ~_GEN_8) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries toN param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_6 & ~_GEN_5) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant is corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_3) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData smaller than a beat (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_7) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid cap param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_8) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries toN param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_10) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_11 & ~_GEN_4) begin	// Monitor.scala:49:11, :338:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck carries invalid param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_11 & ~_GEN_5) begin	// Monitor.scala:49:11, :338:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck is corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_13 & ~_GEN_4) begin	// Monitor.scala:49:11, :346:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_13 & ~_GEN_10) begin	// Monitor.scala:49:11, :346:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_14 & ~_GEN_4) begin	// Monitor.scala:49:11, :354:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck carries invalid param (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_14 & ~_GEN_5) begin	// Monitor.scala:49:11, :354:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck is corrupt (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_15 & ~(opcode == 3'h4 | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(param == 3'h0 | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(size == 4'h6 | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(~source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~(io_in_d_bits_opcode == opcode_1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_param == param_1 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(~source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_sink == sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_denied == denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (a_set & ~(~inflight | reset)) begin	// Monitor.scala:42:11, :611:27, :652:27, :658:17
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (d_clr_wo_ready & ~(inflight | a_set_wo_ready | reset)) begin	// Monitor.scala:49:11, :611:27, :648:26, :671:71
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_17 & ~(_GEN_12 | reset)) begin	// Monitor.scala:49:11, :346:25, :684:30
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_17 & ~(io_in_d_bits_size == 4'h6 | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_18
          & ~(io_in_d_bits_opcode == _GEN_1[inflight_opcodes[3:1]]
              | io_in_d_bits_opcode == _GEN_0[inflight_opcodes[3:1]] | reset)) begin	// Monitor.scala:42:11, :49:11, :613:35, :634:152, :684:30, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_18 & ~(_GEN_19 == {1'h0, inflight_sizes[7:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :81:54, :92:53, :99:31, :114:53, :122:56, :130:56, :131:74, :138:53, :139:71, :146:46, :615:33, :638:{19,144}, :684:30, :691:36, :695:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN & a_first_1 & io_in_a_valid & ~d_release_ack
          & ~(io_in_a_ready | reset)) begin	// Edges.scala:230:25, Monitor.scala:49:11, :670:46, :671:{26,74}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(a_set_wo_ready != d_clr_wo_ready | ~a_set_wo_ready | reset)) begin	// Monitor.scala:49:11, :648:26, :671:71, :684:30, :699:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'A' and 'D' concurrent, despite minlatency 4 (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out
            | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :611:27, :658:17, :706:27, :709:{39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (d_clr_1 & ~(inflight_1 | reset)) begin	// Monitor.scala:49:11, :723:35, :783:72
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (d_clr_1 & ~(_GEN_19 == {1'h0, inflight_sizes_1[7:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :81:54, :92:53, :99:31, :114:53, :122:56, :130:56, :131:74, :138:53, :139:71, :146:46, :691:36, :695:15, :725:35, :747:{21,146}, :783:72, :795:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at tile.scala:142:21)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight_1 | _plusarg_reader_1_out == 32'h0
            | watchdog_1 < _plusarg_reader_1_out | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :723:35, :813:27, :816:{16,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at tile.scala:142:21)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic _GEN_20;	// Monitor.scala:396:20
    automatic logic _GEN_21;	// Monitor.scala:549:20
    _GEN_20 = _a_first_T_1 & ~(|a_first_counter);	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:396:20
    _GEN_21 = io_in_d_valid & ~(|d_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:549:20
    if (reset) begin
      a_first_counter <= 9'h0;	// Edges.scala:220:14, :228:27
      d_first_counter <= 9'h0;	// Edges.scala:220:14, :228:27
      inflight <= 1'h0;	// Monitor.scala:81:54, :92:53, :99:31, :114:53, :122:56, :130:56, :131:74, :138:53, :139:71, :146:46, :611:27, :695:15
      inflight_opcodes <= 4'h0;	// Bundles.scala:108:27, Misc.scala:205:21, Monitor.scala:613:35, :634:69, :638:65, :656:79, :657:77
      inflight_sizes <= 8'h0;	// Bundles.scala:256:54, Monitor.scala:615:33
      a_first_counter_1 <= 9'h0;	// Edges.scala:220:14, :228:27
      d_first_counter_1 <= 9'h0;	// Edges.scala:220:14, :228:27
      watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      inflight_1 <= 1'h0;	// Monitor.scala:81:54, :92:53, :99:31, :114:53, :122:56, :130:56, :131:74, :138:53, :139:71, :146:46, :695:15, :723:35
      inflight_sizes_1 <= 8'h0;	// Bundles.scala:256:54, Monitor.scala:725:35
      d_first_counter_2 <= 9'h0;	// Edges.scala:220:14, :228:27
      watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
    end
    else begin
      if (_a_first_T_1) begin	// Decoupled.scala:40:37
        if (|a_first_counter)	// Edges.scala:228:27, :230:25
          a_first_counter <= a_first_counter - 9'h1;	// Edges.scala:228:27, :229:28
        else	// Edges.scala:230:25
          a_first_counter <= 9'h0;	// Edges.scala:220:14, :228:27
        if (a_first_1)	// Edges.scala:230:25
          a_first_counter_1 <= 9'h0;	// Edges.scala:220:14, :228:27
        else	// Edges.scala:230:25
          a_first_counter_1 <= a_first_counter_1 - 9'h1;	// Edges.scala:228:27, :229:28
      end
      if (io_in_d_valid) begin
        automatic logic [26:0] _GEN_22;	// package.scala:234:77
        _GEN_22 = {23'h0, io_in_d_bits_size};	// package.scala:234:77
        if (|d_first_counter)	// Edges.scala:228:27, :230:25
          d_first_counter <= d_first_counter - 9'h1;	// Edges.scala:228:27, :229:28
        else if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
          automatic logic [26:0] _d_first_beats1_decode_T_1;	// package.scala:234:77
          _d_first_beats1_decode_T_1 = 27'hFFF << _GEN_22;	// package.scala:234:77
          d_first_counter <= ~(_d_first_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:105:36
          d_first_counter <= 9'h0;	// Edges.scala:220:14, :228:27
        if (d_first_1) begin	// Edges.scala:230:25
          if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [26:0] _d_first_beats1_decode_T_5;	// package.scala:234:77
            _d_first_beats1_decode_T_5 = 27'hFFF << _GEN_22;	// package.scala:234:77
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter_1 <= 9'h0;	// Edges.scala:220:14, :228:27
        end
        else	// Edges.scala:230:25
          d_first_counter_1 <= d_first_counter_1 - 9'h1;	// Edges.scala:228:27, :229:28
        if (d_first_2) begin	// Edges.scala:230:25
          if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [26:0] _d_first_beats1_decode_T_9;	// package.scala:234:77
            _d_first_beats1_decode_T_9 = 27'hFFF << _GEN_22;	// package.scala:234:77
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter_2 <= 9'h0;	// Edges.scala:220:14, :228:27
        end
        else	// Edges.scala:230:25
          d_first_counter_2 <= d_first_counter_2 - 9'h1;	// Edges.scala:228:27, :229:28
        watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
      end
      else
        watchdog_1 <= watchdog_1 + 32'h1;	// Monitor.scala:711:26, :813:27, :818:26
      inflight <= (inflight | a_set) & ~d_clr_wo_ready;	// Monitor.scala:611:27, :652:27, :671:71, :702:{27,36,38}
      inflight_opcodes <=
        (inflight_opcodes | (a_set ? 4'h9 : 4'h0)) & ~{4{d_clr_wo_ready}};	// Bundles.scala:108:27, Misc.scala:205:21, Monitor.scala:613:35, :634:69, :638:65, :652:{27,72}, :654:61, :656:{28,79}, :657:77, :671:71, :675:91, :677:21, :703:{43,60,62}
      inflight_sizes <=
        (inflight_sizes | (a_set ? {3'h0, a_set ? 5'hD : 5'h0} : 8'h0))
        & ~{8{d_clr_wo_ready}};	// Bundles.scala:256:54, Monitor.scala:615:33, :652:{27,72}, :655:{28,59}, :657:28, :671:71, :675:91, :678:21, :704:{39,54,56}
      if (_a_first_T_1 | io_in_d_valid)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
      inflight_1 <= inflight_1 & ~d_clr_1;	// Monitor.scala:723:35, :783:72, :809:{44,46}
      inflight_sizes_1 <= inflight_sizes_1 & ~{8{d_clr_1}};	// Monitor.scala:725:35, :783:{72,90}, :786:21, :811:{56,58}
    end
    if (_GEN_20) begin	// Monitor.scala:396:20
      opcode <= 3'h4;	// Monitor.scala:384:22
      param <= 3'h0;	// Monitor.scala:385:22
      size <= 4'h6;	// Monitor.scala:386:22
      address <= io_in_a_bits_address;	// Monitor.scala:388:22
    end
    source <= ~_GEN_20 & source;	// Monitor.scala:387:22, :396:{20,32}, :400:15
    if (_GEN_21) begin	// Monitor.scala:549:20
      opcode_1 <= io_in_d_bits_opcode;	// Monitor.scala:535:22
      param_1 <= io_in_d_bits_param;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      sink <= io_in_d_bits_sink;	// Monitor.scala:539:22
      denied <= io_in_d_bits_denied;	// Monitor.scala:540:22
    end
    source_1 <= ~_GEN_21 & source_1;	// Monitor.scala:538:22, :549:{20,32}, :553:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:6];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h7; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        a_first_counter = _RANDOM[3'h0][8:0];	// Edges.scala:228:27
        opcode = _RANDOM[3'h0][11:9];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[3'h0][14:12];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[3'h0][18:15];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[3'h0][19];	// Edges.scala:228:27, Monitor.scala:387:22
        address = {_RANDOM[3'h0][31:20], _RANDOM[3'h1][19:0]};	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[3'h1][28:20];	// Edges.scala:228:27, Monitor.scala:388:22
        opcode_1 = _RANDOM[3'h1][31:29];	// Monitor.scala:388:22, :535:22
        param_1 = _RANDOM[3'h2][1:0];	// Monitor.scala:536:22
        size_1 = _RANDOM[3'h2][5:2];	// Monitor.scala:536:22, :537:22
        source_1 = _RANDOM[3'h2][6];	// Monitor.scala:536:22, :538:22
        sink = _RANDOM[3'h2][9:7];	// Monitor.scala:536:22, :539:22
        denied = _RANDOM[3'h2][10];	// Monitor.scala:536:22, :540:22
        inflight = _RANDOM[3'h2][11];	// Monitor.scala:536:22, :611:27
        inflight_opcodes = _RANDOM[3'h2][15:12];	// Monitor.scala:536:22, :613:35
        inflight_sizes = _RANDOM[3'h2][23:16];	// Monitor.scala:536:22, :615:33
        a_first_counter_1 = {_RANDOM[3'h2][31:24], _RANDOM[3'h3][0]};	// Edges.scala:228:27, Monitor.scala:536:22
        d_first_counter_1 = _RANDOM[3'h3][9:1];	// Edges.scala:228:27
        watchdog = {_RANDOM[3'h3][31:10], _RANDOM[3'h4][9:0]};	// Edges.scala:228:27, Monitor.scala:706:27
        inflight_1 = _RANDOM[3'h4][10];	// Monitor.scala:706:27, :723:35
        inflight_sizes_1 = _RANDOM[3'h4][22:15];	// Monitor.scala:706:27, :725:35
        d_first_counter_2 = _RANDOM[3'h5][8:0];	// Edges.scala:228:27
        watchdog_1 = {_RANDOM[3'h5][31:9], _RANDOM[3'h6][8:0]};	// Edges.scala:228:27, Monitor.scala:813:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  plusarg_reader #(
    .FORMAT("tilelink_timeout=%d"),
    .DEFAULT(0),
    .WIDTH(32)
  ) plusarg_reader (	// PlusArg.scala:80:11
    .out (_plusarg_reader_out)
  );
  plusarg_reader #(
    .FORMAT("tilelink_timeout=%d"),
    .DEFAULT(0),
    .WIDTH(32)
  ) plusarg_reader_1 (	// PlusArg.scala:80:11
    .out (_plusarg_reader_1_out)
  );
endmodule

