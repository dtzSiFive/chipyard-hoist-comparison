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

module TLMonitor_75(
  input       clock,
              reset,
              io_in_a_ready,
              io_in_a_valid,
  input [2:0] io_in_a_bits_opcode,
              io_in_a_bits_param,
  input [1:0] io_in_a_bits_size,
  input       io_in_a_bits_source,
  input [8:0] io_in_a_bits_address,
  input [3:0] io_in_a_bits_mask,
  input       io_in_a_bits_corrupt,
              io_in_d_ready,
              io_in_d_valid,
  input [2:0] io_in_d_bits_opcode,
  input [1:0] io_in_d_bits_size,
  input       io_in_d_bits_source
);

  wire [31:0] _plusarg_reader_1_out;	// PlusArg.scala:80:11
  wire [31:0] _plusarg_reader_out;	// PlusArg.scala:80:11
  wire        a_first_done = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg         a_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode;	// Monitor.scala:384:22
  reg  [2:0]  param;	// Monitor.scala:385:22
  reg  [1:0]  size;	// Monitor.scala:386:22
  reg         source;	// Monitor.scala:387:22
  reg  [8:0]  address;	// Monitor.scala:388:22
  reg         d_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode_1;	// Monitor.scala:535:22
  reg  [1:0]  param_1;	// Monitor.scala:536:22
  reg  [1:0]  size_1;	// Monitor.scala:537:22
  reg         source_1;	// Monitor.scala:538:22
  reg         sink;	// Monitor.scala:539:22
  reg         denied;	// Monitor.scala:540:22
  reg         inflight;	// Monitor.scala:611:27
  reg  [3:0]  inflight_opcodes;	// Monitor.scala:613:35
  reg  [3:0]  inflight_sizes;	// Monitor.scala:615:33
  reg         a_first_counter_1;	// Edges.scala:228:27
  reg         d_first_counter_1;	// Edges.scala:228:27
  wire        _GEN = a_first_done & ~a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:652:27
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :670:46
  reg  [31:0] watchdog;	// Monitor.scala:706:27
  reg         inflight_1;	// Monitor.scala:723:35
  reg  [3:0]  inflight_sizes_1;	// Monitor.scala:725:35
  reg         d_first_counter_2;	// Edges.scala:228:27
  reg  [31:0] watchdog_1;	// Monitor.scala:813:27
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN_0 =
        {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:686:39
      automatic logic [7:0][2:0] _GEN_1 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:685:38
      automatic logic            mask_acc =
        io_in_a_bits_size[1] | io_in_a_bits_size[0] & ~(io_in_a_bits_address[1]);	// Misc.scala:205:21, :209:26, :210:20, :214:{29,38}, OneHot.scala:64:49
      automatic logic            mask_acc_1 =
        io_in_a_bits_size[1] | io_in_a_bits_size[0] & io_in_a_bits_address[1];	// Misc.scala:205:21, :209:26, :214:{29,38}, OneHot.scala:64:49
      automatic logic [3:0]      mask =
        {mask_acc_1 | io_in_a_bits_address[1] & io_in_a_bits_address[0],
         mask_acc_1 | io_in_a_bits_address[1] & ~(io_in_a_bits_address[0]),
         mask_acc | ~(io_in_a_bits_address[1]) & io_in_a_bits_address[0],
         mask_acc | ~(io_in_a_bits_address[1]) & ~(io_in_a_bits_address[0])};	// Cat.scala:30:58, Misc.scala:209:26, :210:20, :213:27, :214:29
      automatic logic            _GEN_2 = io_in_a_valid & io_in_a_bits_opcode == 3'h6;	// Monitor.scala:81:{25,54}
      automatic logic            _GEN_3 = ~io_in_a_bits_source | reset;	// Monitor.scala:42:11, Parameters.scala:46:9
      automatic logic            _GEN_4 = io_in_a_bits_size[1] | reset;	// Misc.scala:205:21, Monitor.scala:42:11
      automatic logic [4:0]      _is_aligned_mask_T_1 = 5'h3 << io_in_a_bits_size;	// package.scala:234:77
      automatic logic            _GEN_5 =
        (io_in_a_bits_address[1:0] & ~(_is_aligned_mask_T_1[1:0])) == 2'h0 | reset;	// Edges.scala:20:{16,24}, Monitor.scala:42:11, package.scala:234:{46,77,82}
      automatic logic            _GEN_6 = io_in_a_bits_param < 3'h3 | reset;	// Bundles.scala:108:27, :145:30, Monitor.scala:42:11
      automatic logic            _GEN_7 = (&io_in_a_bits_mask) | reset;	// Monitor.scala:42:11, :88:31
      automatic logic            _GEN_8 = ~io_in_a_bits_corrupt | reset;	// Monitor.scala:42:11, :89:18
      automatic logic            _GEN_9 = io_in_a_valid & (&io_in_a_bits_opcode);	// Monitor.scala:92:{25,53}
      automatic logic            _GEN_10 = io_in_a_valid & io_in_a_bits_opcode == 3'h4;	// Monitor.scala:104:{25,45}
      automatic logic            _GEN_11 =
        io_in_a_bits_size == 2'h2 & ~io_in_a_bits_source;	// Parameters.scala:46:9, :91:48, :1160:30
      automatic logic [4:0]      _GEN_12 = io_in_a_bits_address[6:2] ^ 5'h11;	// Parameters.scala:137:31
      automatic logic            _GEN_13 =
        io_in_a_bits_size != 2'h3
        & (io_in_a_bits_address[8:6] == 3'h0
           | {io_in_a_bits_address[8:7], _GEN_12[4:2], _GEN_12[0]} == 6'h0
           | {io_in_a_bits_address[8:7], io_in_a_bits_address[6:3] ^ 4'hB} == 6'h0
           | {io_in_a_bits_address[8:7], ~(io_in_a_bits_address[6:5])} == 4'h0
           | {io_in_a_bits_address[8], ~(io_in_a_bits_address[7])} == 2'h0
           | io_in_a_bits_address[8]);	// Bundles.scala:256:54, Parameters.scala:92:42, :137:{31,49,52,67}, :670:56, :671:42
      automatic logic            _GEN_14 = ~(|io_in_a_bits_param) | reset;	// Monitor.scala:42:11, :99:31, :109:31
      automatic logic            _GEN_15 = io_in_a_bits_mask == mask | reset;	// Cat.scala:30:58, Monitor.scala:42:11, :110:30
      automatic logic            _GEN_16 = io_in_a_valid & io_in_a_bits_opcode == 3'h0;	// Monitor.scala:114:{25,53}
      automatic logic            _GEN_17 = io_in_a_valid & io_in_a_bits_opcode == 3'h1;	// Monitor.scala:122:{25,56}
      automatic logic            _GEN_18 = io_in_a_valid & io_in_a_bits_opcode == 3'h2;	// Monitor.scala:130:{25,56}, :640:42
      automatic logic            _GEN_19 = io_in_a_valid & io_in_a_bits_opcode == 3'h3;	// Bundles.scala:145:30, Monitor.scala:138:{25,53}
      automatic logic            _GEN_20 = io_in_a_valid & io_in_a_bits_opcode == 3'h5;	// Monitor.scala:146:{25,46}
      automatic logic            _GEN_21 = io_in_d_valid & io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :310:{25,52}
      automatic logic            _GEN_22 = ~io_in_d_bits_source | reset;	// Monitor.scala:49:11, Parameters.scala:46:9
      automatic logic            _GEN_23 = io_in_d_bits_size[1] | reset;	// Monitor.scala:49:11, :312:27
      automatic logic            _GEN_24 = io_in_d_valid & io_in_d_bits_opcode == 3'h4;	// Monitor.scala:318:{25,47}
      automatic logic            _GEN_25 = io_in_d_valid & io_in_d_bits_opcode == 3'h5;	// Monitor.scala:146:25, :328:{25,51}
      automatic logic            _GEN_26;	// Monitor.scala:389:19
      automatic logic            _GEN_27;	// Monitor.scala:541:19
      automatic logic [3:0]      _GEN_28 = {1'h0, io_in_d_bits_source, 2'h0};	// Misc.scala:205:21, Monitor.scala:634:69
      automatic logic [3:0]      _a_opcode_lookup_T_1;	// Monitor.scala:634:44
      automatic logic            _GEN_29;	// Monitor.scala:671:26
      automatic logic            _GEN_30;	// Monitor.scala:680:71
      automatic logic            same_cycle_resp;	// Monitor.scala:681:88
      automatic logic            _GEN_31;	// Monitor.scala:684:30
      automatic logic            _GEN_32;	// Monitor.scala:684:30
      automatic logic [3:0]      _GEN_33 = {2'h0, io_in_d_bits_size};	// Monitor.scala:691:36
      automatic logic            _GEN_34;	// Monitor.scala:789:71
      automatic logic [3:0]      _a_size_lookup_T_1;	// Monitor.scala:638:40
      automatic logic [3:0]      _c_size_lookup_T_1;	// Monitor.scala:747:42
      _GEN_26 = io_in_a_valid & a_first_counter;	// Edges.scala:228:27, Monitor.scala:389:19
      _GEN_27 = io_in_d_valid & d_first_counter;	// Edges.scala:228:27, Monitor.scala:541:19
      _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_28;	// Misc.scala:205:21, Monitor.scala:613:35, :634:{44,69}
      _GEN_29 = io_in_d_valid & ~d_first_counter_1;	// Edges.scala:228:27, :230:25, Monitor.scala:671:26
      _GEN_30 = _GEN_29 & ~d_release_ack;	// Monitor.scala:670:46, :671:{26,74}, :680:71
      same_cycle_resp =
        io_in_a_valid & ~a_first_counter_1 & io_in_a_bits_source == io_in_d_bits_source;	// Edges.scala:228:27, :230:25, Monitor.scala:681:{88,113}
      _GEN_31 = _GEN_30 & same_cycle_resp;	// Monitor.scala:680:71, :681:88, :684:30
      _GEN_32 = _GEN_30 & ~same_cycle_resp;	// Monitor.scala:680:71, :681:88, :684:30
      _GEN_34 = io_in_d_valid & ~d_first_counter_2 & d_release_ack;	// Edges.scala:228:27, :230:25, Monitor.scala:670:46, :789:71
      if (_GEN_2 & ~reset) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_3) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_4) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_5) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_6) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_7) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_8) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock is corrupt (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~reset) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_3) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_4) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_5) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_6) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~((|io_in_a_bits_param) | reset)) begin	// Monitor.scala:42:11, :92:53, :99:31
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_7) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_8) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm is corrupt (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~(_GEN_11 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:1160:30
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~(_GEN_13 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:670:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_3) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_5) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_14) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_15) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_8) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get is corrupt (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~(_GEN_11 & _GEN_13 | reset)) begin	// Monitor.scala:42:11, :114:53, :115:71, Parameters.scala:670:56, :1160:30
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_3) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_5) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_14) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_15) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~reset) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_3) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_5) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_14) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~((io_in_a_bits_mask & ~mask) == 4'h0 | reset)) begin	// Bundles.scala:256:54, Cat.scala:30:58, Monitor.scala:42:11, :122:56, :127:{31,33,40}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~reset) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_3) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_5) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~(io_in_a_bits_param < 3'h5 | reset)) begin	// Bundles.scala:138:33, Monitor.scala:42:11, :130:56, :146:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_15) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~reset) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_3) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_5) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~(~(io_in_a_bits_param[2]) | reset)) begin	// Bundles.scala:145:30, Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid opcode param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_15) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~reset) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_3) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_5) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint address not aligned to size (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~(io_in_a_bits_param < 3'h2 | reset)) begin	// Bundles.scala:158:28, Monitor.scala:42:11, :146:46, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid opcode param (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_15) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint contains invalid mask (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_8) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint is corrupt (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid & ~(io_in_d_bits_opcode != 3'h7 | reset)) begin	// Bundles.scala:42:24, Monitor.scala:49:11, :92:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel has invalid opcode (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_21 & ~_GEN_22) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_21 & ~_GEN_23) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~_GEN_22) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~reset) begin	// Monitor.scala:42:11, :49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid sink ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~_GEN_23) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant smaller than a beat (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~_GEN_22) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~reset) begin	// Monitor.scala:42:11, :49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~_GEN_23) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData smaller than a beat (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~_GEN_22) begin	// Monitor.scala:49:11, :338:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~_GEN_22) begin	// Monitor.scala:49:11, :346:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~_GEN_22) begin	// Monitor.scala:49:11, :354:25, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck carries invalid source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_26 & ~(io_in_a_bits_opcode == opcode | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_param == param | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_size == size | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_source == source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~(io_in_d_bits_opcode == opcode_1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(param_1 == 2'h0 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(io_in_d_bits_source == source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(~sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(~denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN & ~(~(inflight >> io_in_a_bits_source) | reset)) begin	// Monitor.scala:42:11, :611:27, :652:27, :658:{17,26}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_30 & ~(inflight >> io_in_d_bits_source | same_cycle_resp | reset)) begin	// Monitor.scala:49:11, :611:27, :680:71, :681:88, :682:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_31
          & ~(io_in_d_bits_opcode == _GEN_1[io_in_a_bits_opcode]
              | io_in_d_bits_opcode == _GEN_0[io_in_a_bits_opcode] | reset)) begin	// Monitor.scala:49:11, :684:30, :685:38, :686:39
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_31 & ~(io_in_a_bits_size == io_in_d_bits_size | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_32
          & ~(io_in_d_bits_opcode == _GEN_1[_a_opcode_lookup_T_1[3:1]]
              | io_in_d_bits_opcode == _GEN_0[_a_opcode_lookup_T_1[3:1]] | reset)) begin	// Monitor.scala:42:11, :49:11, :634:{44,152}, :684:30, :685:38, :686:39, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _a_size_lookup_T_1 = inflight_sizes >> _GEN_28;	// Misc.scala:205:21, Monitor.scala:615:33, :634:69, :638:40
      if (_GEN_32 & ~(_GEN_33 == {1'h0, _a_size_lookup_T_1[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :638:{19,40,144}, :684:30, :691:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_29 & ~a_first_counter_1 & io_in_a_valid
          & io_in_a_bits_source == io_in_d_bits_source & ~d_release_ack
          & ~(~io_in_d_ready | io_in_a_ready | reset)) begin	// Edges.scala:228:27, :230:25, Monitor.scala:49:11, :670:46, :671:{26,74}, :694:90, :695:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight | _plusarg_reader_out == 32'h0 | watchdog < _plusarg_reader_out
            | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :611:27, :706:27, :709:{16,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~(inflight_1 >> io_in_d_bits_source | reset)) begin	// Monitor.scala:49:11, :723:35, :789:71, :791:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_28;	// Misc.scala:205:21, Monitor.scala:634:69, :725:35, :747:42
      if (_GEN_34 & ~(_GEN_33 == {1'h0, _c_size_lookup_T_1[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :691:36, :747:{21,42,146}, :789:71, :795:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Debug.scala:1746:19)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(~inflight_1 | _plusarg_reader_1_out == 32'h0
            | watchdog_1 < _plusarg_reader_1_out | reset)) begin	// Bundles.scala:256:54, Monitor.scala:42:11, :723:35, :813:27, :816:{16,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at Debug.scala:1746:19)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic d_first_done;	// Decoupled.scala:40:37
    automatic logic _GEN_35;	// Monitor.scala:549:20
    d_first_done = io_in_d_ready & io_in_d_valid;	// Decoupled.scala:40:37
    _GEN_35 = d_first_done & ~d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:549:20
    if (reset) begin
      a_first_counter <= 1'h0;	// Edges.scala:228:27
      d_first_counter <= 1'h0;	// Edges.scala:228:27
      inflight <= 1'h0;	// Monitor.scala:611:27
      inflight_opcodes <= 4'h0;	// Bundles.scala:256:54, Monitor.scala:613:35
      inflight_sizes <= 4'h0;	// Bundles.scala:256:54, Monitor.scala:615:33
      a_first_counter_1 <= 1'h0;	// Edges.scala:228:27
      d_first_counter_1 <= 1'h0;	// Edges.scala:228:27
      watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      inflight_1 <= 1'h0;	// Monitor.scala:723:35
      inflight_sizes_1 <= 4'h0;	// Bundles.scala:256:54, Monitor.scala:725:35
      d_first_counter_2 <= 1'h0;	// Edges.scala:228:27
      watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
    end
    else begin
      automatic logic        _GEN_36;	// Monitor.scala:675:72
      automatic logic [30:0] _GEN_37 = {28'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:677:76
      automatic logic        _GEN_38;	// Monitor.scala:783:72
      automatic logic [30:0] _d_opcodes_clr_T_5 = 31'hF << _GEN_37;	// Monitor.scala:677:76
      automatic logic [18:0] _a_opcodes_set_T_1 =
        {15'h0, _GEN ? {io_in_a_bits_opcode, 1'h1} : 4'h0}
        << {16'h0, io_in_a_bits_source, 2'h0};	// Bundles.scala:256:54, Monitor.scala:49:11, :652:{27,72}, :654:{28,61}, :656:54
      automatic logic [30:0] _d_sizes_clr_T_5 = 31'hF << _GEN_37;	// Monitor.scala:677:76, :678:74
      automatic logic [17:0] _a_sizes_set_T_1 =
        {15'h0, _GEN ? {io_in_a_bits_size, 1'h1} : 3'h0}
        << {15'h0, io_in_a_bits_source, 2'h0};	// Monitor.scala:49:11, :652:{27,72}, :655:{28,59}, :656:54, :657:52
      automatic logic [30:0] _d_sizes_clr_T_11 = 31'hF << _GEN_37;	// Monitor.scala:677:76, :786:74
      _GEN_36 = d_first_done & ~d_first_counter_1 & ~d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :671:74, :675:72
      _GEN_38 = d_first_done & ~d_first_counter_2 & d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :783:72
      a_first_counter <= (~a_first_done | a_first_counter - 1'h1) & a_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter <= (~d_first_done | d_first_counter - 1'h1) & d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      inflight <=
        (inflight | _GEN & ~io_in_a_bits_source) & ~(_GEN_36 & ~io_in_d_bits_source);	// Monitor.scala:611:27, :652:{27,72}, :653:28, :675:{72,91}, :676:21, :702:{27,36,38}
      inflight_opcodes <=
        (inflight_opcodes | (_GEN ? _a_opcodes_set_T_1[3:0] : 4'h0))
        & ~(_GEN_36 ? _d_opcodes_clr_T_5[3:0] : 4'h0);	// Bundles.scala:256:54, Monitor.scala:613:35, :652:{27,72}, :656:{28,54}, :675:{72,91}, :677:{21,76}, :703:{43,60,62}
      inflight_sizes <=
        (inflight_sizes | (_GEN ? _a_sizes_set_T_1[3:0] : 4'h0))
        & ~(_GEN_36 ? _d_sizes_clr_T_5[3:0] : 4'h0);	// Bundles.scala:256:54, Monitor.scala:615:33, :652:{27,72}, :657:{28,52}, :675:{72,91}, :678:{21,74}, :704:{39,54,56}
      a_first_counter_1 <= (~a_first_done | a_first_counter_1 - 1'h1) & a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter_1 <= (~d_first_done | d_first_counter_1 - 1'h1) & d_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (a_first_done | d_first_done)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
      inflight_1 <= inflight_1 & ~(_GEN_38 & ~io_in_d_bits_source);	// Monitor.scala:676:21, :723:35, :783:{72,90}, :784:21, :809:{44,46}
      inflight_sizes_1 <= inflight_sizes_1 & ~(_GEN_38 ? _d_sizes_clr_T_11[3:0] : 4'h0);	// Bundles.scala:256:54, Monitor.scala:725:35, :783:{72,90}, :786:{21,74}, :811:{56,58}
      d_first_counter_2 <= (~d_first_done | d_first_counter_2 - 1'h1) & d_first_counter_2;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (d_first_done)	// Decoupled.scala:40:37
        watchdog_1 <= 32'h0;	// Bundles.scala:256:54, Monitor.scala:813:27
      else	// Decoupled.scala:40:37
        watchdog_1 <= watchdog_1 + 32'h1;	// Monitor.scala:711:26, :813:27, :818:26
    end
    if (a_first_done & ~a_first_counter) begin	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:396:20
      opcode <= io_in_a_bits_opcode;	// Monitor.scala:384:22
      param <= io_in_a_bits_param;	// Monitor.scala:385:22
      size <= io_in_a_bits_size;	// Monitor.scala:386:22
      source <= io_in_a_bits_source;	// Monitor.scala:387:22
      address <= io_in_a_bits_address;	// Monitor.scala:388:22
    end
    if (_GEN_35) begin	// Monitor.scala:549:20
      opcode_1 <= io_in_d_bits_opcode;	// Monitor.scala:535:22
      param_1 <= 2'h0;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      source_1 <= io_in_d_bits_source;	// Monitor.scala:538:22
    end
    sink <= ~_GEN_35 & sink;	// Monitor.scala:539:22, :549:{20,32}, :554:15
    denied <= ~_GEN_35 & denied;	// Monitor.scala:539:22, :540:22, :549:{20,32}, :554:15, :555:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:3];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        a_first_counter = _RANDOM[2'h0][0];	// Edges.scala:228:27
        opcode = _RANDOM[2'h0][3:1];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[2'h0][6:4];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[2'h0][8:7];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[2'h0][9];	// Edges.scala:228:27, Monitor.scala:387:22
        address = _RANDOM[2'h0][18:10];	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[2'h0][19];	// Edges.scala:228:27
        opcode_1 = _RANDOM[2'h0][22:20];	// Edges.scala:228:27, Monitor.scala:535:22
        param_1 = _RANDOM[2'h0][24:23];	// Edges.scala:228:27, Monitor.scala:536:22
        size_1 = _RANDOM[2'h0][26:25];	// Edges.scala:228:27, Monitor.scala:537:22
        source_1 = _RANDOM[2'h0][27];	// Edges.scala:228:27, Monitor.scala:538:22
        sink = _RANDOM[2'h0][28];	// Edges.scala:228:27, Monitor.scala:539:22
        denied = _RANDOM[2'h0][29];	// Edges.scala:228:27, Monitor.scala:540:22
        inflight = _RANDOM[2'h0][30];	// Edges.scala:228:27, Monitor.scala:611:27
        inflight_opcodes = {_RANDOM[2'h0][31], _RANDOM[2'h1][2:0]};	// Edges.scala:228:27, Monitor.scala:613:35
        inflight_sizes = _RANDOM[2'h1][6:3];	// Monitor.scala:613:35, :615:33
        a_first_counter_1 = _RANDOM[2'h1][7];	// Edges.scala:228:27, Monitor.scala:613:35
        d_first_counter_1 = _RANDOM[2'h1][8];	// Edges.scala:228:27, Monitor.scala:613:35
        watchdog = {_RANDOM[2'h1][31:9], _RANDOM[2'h2][8:0]};	// Monitor.scala:613:35, :706:27
        inflight_1 = _RANDOM[2'h2][9];	// Monitor.scala:706:27, :723:35
        inflight_sizes_1 = _RANDOM[2'h2][17:14];	// Monitor.scala:706:27, :725:35
        d_first_counter_2 = _RANDOM[2'h2][19];	// Edges.scala:228:27, Monitor.scala:706:27
        watchdog_1 = {_RANDOM[2'h2][31:20], _RANDOM[2'h3][19:0]};	// Monitor.scala:706:27, :813:27
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

