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

module TLMonitor_73(
  input         clock,
                reset,
                io_in_a_ready,
                io_in_a_valid,
  input [2:0]   io_in_a_bits_opcode,
  input [127:0] io_in_a_bits_address,
  input         io_in_d_ready,
                io_in_d_valid,
  input [2:0]   io_in_d_bits_opcode,
  input [1:0]   io_in_d_bits_size,
  input         io_in_d_bits_denied,
                io_in_d_bits_corrupt
);

  wire [31:0]  _plusarg_reader_1_out;	// PlusArg.scala:80:11
  wire [31:0]  _plusarg_reader_out;	// PlusArg.scala:80:11
  wire         a_first_done = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg          a_first_counter;	// Edges.scala:228:27
  reg  [2:0]   opcode;	// Monitor.scala:384:22
  reg  [2:0]   param;	// Monitor.scala:385:22
  reg  [1:0]   size;	// Monitor.scala:386:22
  reg          source;	// Monitor.scala:387:22
  reg  [127:0] address;	// Monitor.scala:388:22
  reg          d_first_counter;	// Edges.scala:228:27
  reg  [2:0]   opcode_1;	// Monitor.scala:535:22
  reg  [1:0]   param_1;	// Monitor.scala:536:22
  reg  [1:0]   size_1;	// Monitor.scala:537:22
  reg          source_1;	// Monitor.scala:538:22
  reg          sink;	// Monitor.scala:539:22
  reg          denied;	// Monitor.scala:540:22
  reg          inflight;	// Monitor.scala:611:27
  reg  [3:0]   inflight_opcodes;	// Monitor.scala:613:35
  reg  [3:0]   inflight_sizes;	// Monitor.scala:615:33
  reg          a_first_counter_1;	// Edges.scala:228:27
  reg          d_first_counter_1;	// Edges.scala:228:27
  wire         a_set = a_first_done & ~a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:652:27
  wire         d_release_ack = io_in_d_bits_opcode == 3'h6;	// Monitor.scala:670:46
  reg  [31:0]  watchdog;	// Monitor.scala:706:27
  reg          inflight_1;	// Monitor.scala:723:35
  reg  [3:0]   inflight_sizes_1;	// Monitor.scala:725:35
  reg          d_first_counter_2;	// Edges.scala:228:27
  reg  [31:0]  watchdog_1;	// Monitor.scala:813:27
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN = {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:686:39
      automatic logic [7:0][2:0] _GEN_0 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:685:38
      automatic logic            _GEN_1 = io_in_a_valid & io_in_a_bits_opcode == 3'h6;	// Monitor.scala:81:{25,54}
      automatic logic            _GEN_2 = io_in_a_bits_address[1:0] == 2'h0 | reset;	// Edges.scala:20:{16,24}, Monitor.scala:42:11
      automatic logic            _GEN_3 = io_in_a_valid & (&io_in_a_bits_opcode);	// Monitor.scala:92:{25,53}
      automatic logic            _GEN_4 = _GEN_3 & ~reset;	// Monitor.scala:42:11, :92:53
      automatic logic            _GEN_5 = io_in_a_valid & io_in_a_bits_opcode == 3'h1;	// Monitor.scala:122:{25,56}
      automatic logic            _GEN_6 = io_in_a_valid & io_in_a_bits_opcode == 3'h2;	// Monitor.scala:130:{25,56}
      automatic logic            _GEN_7 = io_in_a_valid & io_in_a_bits_opcode == 3'h3;	// Monitor.scala:138:{25,53}
      automatic logic            _GEN_8 = io_in_a_valid & io_in_a_bits_opcode == 3'h5;	// Monitor.scala:146:{25,46}
      automatic logic            _GEN_9 = io_in_d_valid & io_in_d_bits_opcode == 3'h6;	// Monitor.scala:310:{25,52}
      automatic logic            _GEN_10 = io_in_d_bits_size[1] | reset;	// Monitor.scala:49:11, :312:27
      automatic logic            _GEN_11 = ~io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :314:15
      automatic logic            _GEN_12 = io_in_d_valid & io_in_d_bits_opcode == 3'h4;	// Monitor.scala:318:{25,47}
      automatic logic            _GEN_13 = io_in_d_valid & io_in_d_bits_opcode == 3'h5;	// Monitor.scala:328:{25,51}
      automatic logic            _GEN_14 =
        ~io_in_d_bits_denied | io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :315:15
      automatic logic            _GEN_15;	// Monitor.scala:389:19
      automatic logic            _GEN_16;	// Monitor.scala:541:19
      automatic logic            _same_cycle_resp_T_1;	// Monitor.scala:648:26
      automatic logic            _GEN_17;	// Monitor.scala:671:26
      automatic logic            _GEN_18;	// Monitor.scala:680:71
      automatic logic            _GEN_19;	// Monitor.scala:684:30
      automatic logic            _GEN_20;	// Monitor.scala:684:30
      automatic logic [3:0]      _GEN_21 = {2'h0, io_in_d_bits_size};	// Monitor.scala:691:36
      automatic logic            _GEN_22;	// Monitor.scala:789:71
      _GEN_15 = io_in_a_valid & a_first_counter;	// Edges.scala:228:27, Monitor.scala:389:19
      _GEN_16 = io_in_d_valid & d_first_counter;	// Edges.scala:228:27, Monitor.scala:541:19
      _same_cycle_resp_T_1 = io_in_a_valid & ~a_first_counter_1;	// Edges.scala:228:27, :230:25, Monitor.scala:648:26
      _GEN_17 = io_in_d_valid & ~d_first_counter_1;	// Edges.scala:228:27, :230:25, Monitor.scala:671:26
      _GEN_18 = _GEN_17 & ~d_release_ack;	// Monitor.scala:670:46, :671:{26,74}, :680:71
      _GEN_19 = _GEN_18 & _same_cycle_resp_T_1;	// Monitor.scala:648:26, :680:71, :684:30
      _GEN_20 = _GEN_18 & ~_same_cycle_resp_T_1;	// Monitor.scala:648:26, :680:71, :684:30
      _GEN_22 = io_in_d_valid & ~d_first_counter_2 & d_release_ack;	// Edges.scala:228:27, :230:25, Monitor.scala:670:46, :789:71
      if (_GEN_1 & ~reset) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_1 & ~_GEN_2) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_4) begin	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_3 & ~_GEN_2) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_4) begin	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_a_valid & io_in_a_bits_opcode == 3'h4 & ~_GEN_2) begin	// Monitor.scala:42:11, :104:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_a_valid & io_in_a_bits_opcode == 3'h0 & ~_GEN_2) begin	// Monitor.scala:42:11, :114:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_5 & ~reset) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_5 & ~_GEN_2) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_6 & ~reset) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_6 & ~_GEN_2) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_7 & ~reset) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_7 & ~_GEN_2) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_8 & ~reset) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_8 & ~_GEN_2) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint address not aligned to size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid & ~(io_in_d_bits_opcode != 3'h7 | reset)) begin	// Bundles.scala:42:24, Monitor.scala:49:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel has invalid opcode (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_10) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~_GEN_11) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_9 & ~(~io_in_d_bits_denied | reset)) begin	// Monitor.scala:49:11, :310:52, :315:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is denied (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_12 & ~_GEN_10) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant smaller than a beat (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_12 & ~_GEN_11) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant is corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_13 & ~_GEN_10) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData smaller than a beat (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_13 & ~_GEN_14) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~_GEN_11) begin	// Monitor.scala:49:11, :338:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck is corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~_GEN_14) begin	// Monitor.scala:49:11, :346:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~_GEN_11) begin	// Monitor.scala:49:11, :354:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck is corrupt (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_15 & ~(io_in_a_bits_opcode == opcode | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(param == 3'h0 | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(size == 2'h2 | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(~source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~(io_in_d_bits_opcode == opcode_1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(param_1 == 2'h0 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(~source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(~sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_16 & ~(io_in_d_bits_denied == denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (a_set & ~(~inflight | reset)) begin	// Monitor.scala:42:11, :611:27, :652:27, :658:17
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~(inflight | _same_cycle_resp_T_1 | reset)) begin	// Monitor.scala:49:11, :611:27, :648:26, :680:71
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_19
          & ~(io_in_d_bits_opcode == _GEN_0[io_in_a_bits_opcode]
              | io_in_d_bits_opcode == _GEN[io_in_a_bits_opcode] | reset)) begin	// Monitor.scala:49:11, :684:30, :685:38, :686:39
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_19 & ~(io_in_d_bits_size == 2'h2 | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_20
          & ~(io_in_d_bits_opcode == _GEN_0[inflight_opcodes[3:1]]
              | io_in_d_bits_opcode == _GEN[inflight_opcodes[3:1]] | reset)) begin	// Monitor.scala:42:11, :49:11, :613:35, :634:152, :684:30, :685:38, :686:39, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_20 & ~(_GEN_21 == {1'h0, inflight_sizes[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :99:31, :615:33, :638:{19,144}, :684:30, :691:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_17 & ~a_first_counter_1 & io_in_a_valid & ~d_release_ack
          & ~(~io_in_d_ready | io_in_a_ready | reset)) begin	// Edges.scala:228:27, :230:25, Monitor.scala:49:11, :670:46, :671:{26,74}, :695:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out
            | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :611:27, :658:17, :706:27, :709:{39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~(inflight_1 | reset)) begin	// Monitor.scala:49:11, :723:35, :789:71
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_22 & ~(_GEN_21 == {1'h0, inflight_sizes_1[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :99:31, :691:36, :725:35, :747:{21,146}, :789:71, :795:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at BusBypass.scala:33:14)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight_1 | _plusarg_reader_1_out == 32'h0
            | watchdog_1 < _plusarg_reader_1_out | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :723:35, :813:27, :816:{16,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at BusBypass.scala:33:14)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic _GEN_23;	// Monitor.scala:396:20
    automatic logic d_first_done;	// Decoupled.scala:40:37
    automatic logic _GEN_24;	// Monitor.scala:549:20
    _GEN_23 = a_first_done & ~a_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:396:20
    d_first_done = io_in_d_ready & io_in_d_valid;	// Decoupled.scala:40:37
    _GEN_24 = d_first_done & ~d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:549:20
    if (reset) begin
      a_first_counter <= 1'h0;	// Edges.scala:228:27, Monitor.scala:99:31
      d_first_counter <= 1'h0;	// Edges.scala:228:27, Monitor.scala:99:31
      inflight <= 1'h0;	// Monitor.scala:99:31, :611:27
      inflight_opcodes <= 4'h0;	// Monitor.scala:613:35
      inflight_sizes <= 4'h0;	// Monitor.scala:615:33
      a_first_counter_1 <= 1'h0;	// Edges.scala:228:27, Monitor.scala:99:31
      d_first_counter_1 <= 1'h0;	// Edges.scala:228:27, Monitor.scala:99:31
      watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      inflight_1 <= 1'h0;	// Monitor.scala:99:31, :723:35
      inflight_sizes_1 <= 4'h0;	// Monitor.scala:725:35
      d_first_counter_2 <= 1'h0;	// Edges.scala:228:27, Monitor.scala:99:31
      watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
    end
    else begin
      automatic logic       d_clr;	// Monitor.scala:675:72
      automatic logic [3:0] d_sizes_clr;	// Monitor.scala:675:91, :677:21
      automatic logic       d_clr_1;	// Monitor.scala:783:72
      d_clr = d_first_done & ~d_first_counter_1 & ~d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :671:74, :675:72
      d_sizes_clr = {4{d_clr}};	// Monitor.scala:675:{72,91}, :677:21
      d_clr_1 = d_first_done & ~d_first_counter_2 & d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :783:72
      a_first_counter <= (~a_first_done | a_first_counter - 1'h1) & a_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter <= (~d_first_done | d_first_counter - 1'h1) & d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      inflight <= (inflight | a_set) & ~d_clr;	// Monitor.scala:611:27, :652:27, :675:72, :702:{27,36,38}
      inflight_opcodes <=
        (inflight_opcodes | (a_set ? {io_in_a_bits_opcode, 1'h1} : 4'h0)) & ~d_sizes_clr;	// Monitor.scala:42:11, :49:11, :613:35, :649:22, :652:{27,72}, :653:28, :654:61, :656:28, :672:22, :675:91, :676:21, :677:21, :681:113, :694:90, :703:{43,60,62}, :780:22, :784:21
      inflight_sizes <=
        (inflight_sizes | (a_set ? {1'h0, a_set ? 3'h5 : 3'h0} : 4'h0)) & ~d_sizes_clr;	// Monitor.scala:99:31, :615:33, :652:{27,72}, :655:28, :657:28, :675:91, :677:21, :704:{39,54,56}
      a_first_counter_1 <= (~a_first_done | a_first_counter_1 - 1'h1) & a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter_1 <= (~d_first_done | d_first_counter_1 - 1'h1) & d_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (a_first_done | d_first_done)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
      inflight_1 <= inflight_1 & ~d_clr_1;	// Monitor.scala:723:35, :783:72, :809:{44,46}
      inflight_sizes_1 <= inflight_sizes_1 & ~{4{d_clr_1}};	// Monitor.scala:725:35, :783:{72,90}, :786:21, :811:{56,58}
      d_first_counter_2 <= (~d_first_done | d_first_counter_2 - 1'h1) & d_first_counter_2;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (d_first_done)	// Decoupled.scala:40:37
        watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
      else	// Decoupled.scala:40:37
        watchdog_1 <= watchdog_1 + 32'h1;	// Monitor.scala:711:26, :813:27, :818:26
    end
    if (_GEN_23) begin	// Monitor.scala:396:20
      opcode <= io_in_a_bits_opcode;	// Monitor.scala:384:22
      param <= 3'h0;	// Monitor.scala:385:22
      size <= 2'h2;	// Monitor.scala:386:22
      address <= io_in_a_bits_address;	// Monitor.scala:388:22
    end
    source <= ~_GEN_23 & source;	// Monitor.scala:387:22, :396:{20,32}, :400:15
    if (_GEN_24) begin	// Monitor.scala:549:20
      opcode_1 <= io_in_d_bits_opcode;	// Monitor.scala:535:22
      param_1 <= 2'h0;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      denied <= io_in_d_bits_denied;	// Monitor.scala:540:22
    end
    source_1 <= ~_GEN_24 & source_1;	// Monitor.scala:538:22, :549:{20,32}, :553:15
    sink <= ~_GEN_24 & sink;	// Monitor.scala:538:22, :539:22, :549:{20,32}, :553:15, :554:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:7];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h8; i += 4'h1) begin
          _RANDOM[i[2:0]] = `RANDOM;
        end
        a_first_counter = _RANDOM[3'h0][0];	// Edges.scala:228:27
        opcode = _RANDOM[3'h0][3:1];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[3'h0][6:4];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[3'h0][8:7];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[3'h0][9];	// Edges.scala:228:27, Monitor.scala:387:22
        address =
          {_RANDOM[3'h0][31:10],
           _RANDOM[3'h1],
           _RANDOM[3'h2],
           _RANDOM[3'h3],
           _RANDOM[3'h4][9:0]};	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[3'h4][10];	// Edges.scala:228:27, Monitor.scala:388:22
        opcode_1 = _RANDOM[3'h4][13:11];	// Monitor.scala:388:22, :535:22
        param_1 = _RANDOM[3'h4][15:14];	// Monitor.scala:388:22, :536:22
        size_1 = _RANDOM[3'h4][17:16];	// Monitor.scala:388:22, :537:22
        source_1 = _RANDOM[3'h4][18];	// Monitor.scala:388:22, :538:22
        sink = _RANDOM[3'h4][19];	// Monitor.scala:388:22, :539:22
        denied = _RANDOM[3'h4][20];	// Monitor.scala:388:22, :540:22
        inflight = _RANDOM[3'h4][21];	// Monitor.scala:388:22, :611:27
        inflight_opcodes = _RANDOM[3'h4][25:22];	// Monitor.scala:388:22, :613:35
        inflight_sizes = _RANDOM[3'h4][29:26];	// Monitor.scala:388:22, :615:33
        a_first_counter_1 = _RANDOM[3'h4][30];	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter_1 = _RANDOM[3'h4][31];	// Edges.scala:228:27, Monitor.scala:388:22
        watchdog = _RANDOM[3'h5];	// Monitor.scala:706:27
        inflight_1 = _RANDOM[3'h6][0];	// Monitor.scala:723:35
        inflight_sizes_1 = _RANDOM[3'h6][8:5];	// Monitor.scala:723:35, :725:35
        d_first_counter_2 = _RANDOM[3'h6][10];	// Edges.scala:228:27, Monitor.scala:723:35
        watchdog_1 = {_RANDOM[3'h6][31:11], _RANDOM[3'h7][10:0]};	// Monitor.scala:723:35, :813:27
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

