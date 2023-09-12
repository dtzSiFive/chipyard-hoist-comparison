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

module TLMonitor_81(
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
  input [2:0]  io_in_a_bits_opcode,
               io_in_a_bits_param,
  input [1:0]  io_in_a_bits_size,
  input [11:0] io_in_a_bits_source,
  input [20:0] io_in_a_bits_address,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
               io_in_d_ready,
               io_in_d_valid,
  input [2:0]  io_in_d_bits_opcode,
  input [1:0]  io_in_d_bits_size,
  input [11:0] io_in_d_bits_source
);

  wire [31:0]   _plusarg_reader_1_out;	// PlusArg.scala:80:11
  wire [31:0]   _plusarg_reader_out;	// PlusArg.scala:80:11
  wire          a_first_done = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg           a_first_counter;	// Edges.scala:228:27
  reg  [2:0]    opcode;	// Monitor.scala:384:22
  reg  [2:0]    param;	// Monitor.scala:385:22
  reg  [1:0]    size;	// Monitor.scala:386:22
  reg  [11:0]   source;	// Monitor.scala:387:22
  reg  [20:0]   address;	// Monitor.scala:388:22
  reg           d_first_counter;	// Edges.scala:228:27
  reg  [2:0]    opcode_1;	// Monitor.scala:535:22
  reg  [1:0]    param_1;	// Monitor.scala:536:22
  reg  [1:0]    size_1;	// Monitor.scala:537:22
  reg  [11:0]   source_1;	// Monitor.scala:538:22
  reg           sink;	// Monitor.scala:539:22
  reg           denied;	// Monitor.scala:540:22
  reg  [2063:0] inflight;	// Monitor.scala:611:27
  reg  [8255:0] inflight_opcodes;	// Monitor.scala:613:35
  reg  [8255:0] inflight_sizes;	// Monitor.scala:615:33
  reg           a_first_counter_1;	// Edges.scala:228:27
  reg           d_first_counter_1;	// Edges.scala:228:27
  wire          _GEN = a_first_done & ~a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:652:27
  wire          d_release_ack = io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :670:46
  reg  [31:0]   watchdog;	// Monitor.scala:706:27
  reg  [2063:0] inflight_1;	// Monitor.scala:723:35
  reg  [8255:0] inflight_sizes_1;	// Monitor.scala:725:35
  reg           d_first_counter_2;	// Edges.scala:228:27
  reg  [31:0]   watchdog_1;	// Monitor.scala:813:27
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN_0 =
        {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:686:39
      automatic logic [7:0][2:0] _GEN_1 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:685:38
      automatic logic            mask_size = io_in_a_bits_size == 2'h2;	// Misc.scala:208:26, OneHot.scala:65:12
      automatic logic            mask_acc =
        (&io_in_a_bits_size) | mask_size & ~(io_in_a_bits_address[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
      automatic logic            mask_acc_1 =
        (&io_in_a_bits_size) | mask_size & io_in_a_bits_address[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
      automatic logic            mask_size_1 = io_in_a_bits_size == 2'h1;	// Edges.scala:229:28, Misc.scala:208:26
      automatic logic            mask_eq_2 =
        ~(io_in_a_bits_address[2]) & ~(io_in_a_bits_address[1]);	// Misc.scala:209:26, :210:20, :213:27
      automatic logic            mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
      automatic logic            mask_eq_3 =
        ~(io_in_a_bits_address[2]) & io_in_a_bits_address[1];	// Misc.scala:209:26, :210:20, :213:27
      automatic logic            mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
      automatic logic            mask_eq_4 =
        io_in_a_bits_address[2] & ~(io_in_a_bits_address[1]);	// Misc.scala:209:26, :210:20, :213:27
      automatic logic            mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
      automatic logic            mask_eq_5 =
        io_in_a_bits_address[2] & io_in_a_bits_address[1];	// Misc.scala:209:26, :213:27
      automatic logic            mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
      automatic logic [7:0]      mask =
        {mask_acc_5 | mask_eq_5 & io_in_a_bits_address[0],
         mask_acc_5 | mask_eq_5 & ~(io_in_a_bits_address[0]),
         mask_acc_4 | mask_eq_4 & io_in_a_bits_address[0],
         mask_acc_4 | mask_eq_4 & ~(io_in_a_bits_address[0]),
         mask_acc_3 | mask_eq_3 & io_in_a_bits_address[0],
         mask_acc_3 | mask_eq_3 & ~(io_in_a_bits_address[0]),
         mask_acc_2 | mask_eq_2 & io_in_a_bits_address[0],
         mask_acc_2 | mask_eq_2 & ~(io_in_a_bits_address[0])};	// Cat.scala:30:58, Misc.scala:209:26, :210:20, :213:27, :214:29
      automatic logic            _GEN_2 = io_in_a_valid & io_in_a_bits_opcode == 3'h6;	// Monitor.scala:81:{25,54}
      automatic logic            _GEN_3 = io_in_a_bits_source < 12'h810 | reset;	// Monitor.scala:42:11, Parameters.scala:57:20
      automatic logic            _GEN_4 = (&io_in_a_bits_size) | reset;	// Misc.scala:205:21, Monitor.scala:42:11
      automatic logic [5:0]      _is_aligned_mask_T_1 = 6'h7 << io_in_a_bits_size;	// package.scala:234:77
      automatic logic            _GEN_5 =
        (io_in_a_bits_address[2:0] & ~(_is_aligned_mask_T_1[2:0])) == 3'h0 | reset;	// Edges.scala:20:{16,24}, Misc.scala:201:34, Monitor.scala:42:11, package.scala:234:{46,77,82}
      automatic logic            _GEN_6 = io_in_a_bits_param < 3'h3 | reset;	// Bundles.scala:108:27, :145:30, Monitor.scala:42:11
      automatic logic            _GEN_7 = (&io_in_a_bits_mask) | reset;	// Monitor.scala:42:11, :88:31
      automatic logic            _GEN_8 = ~io_in_a_bits_corrupt | reset;	// Monitor.scala:42:11, :89:18
      automatic logic            _GEN_9 = io_in_a_valid & (&io_in_a_bits_opcode);	// Monitor.scala:92:{25,53}
      automatic logic            _GEN_10 = io_in_a_valid & io_in_a_bits_opcode == 3'h4;	// Monitor.scala:104:{25,45}
      automatic logic            _GEN_11 = io_in_a_bits_source < 12'h810;	// Parameters.scala:57:20
      automatic logic            _GEN_12 = io_in_a_bits_address[20:12] == 9'h100;	// Parameters.scala:137:{31,49,52,67}
      automatic logic            _GEN_13 = ~(|io_in_a_bits_param) | reset;	// Monitor.scala:42:11, :99:31, :109:31
      automatic logic            _GEN_14 = io_in_a_bits_mask == mask | reset;	// Cat.scala:30:58, Monitor.scala:42:11, :110:30
      automatic logic            _GEN_15 = io_in_a_valid & io_in_a_bits_opcode == 3'h0;	// Misc.scala:201:34, Monitor.scala:114:{25,53}
      automatic logic            _GEN_16 = _GEN_11 & _GEN_12 | reset;	// Monitor.scala:42:11, :115:71, Parameters.scala:57:20, :137:{49,52,67}
      automatic logic            _GEN_17 = io_in_a_valid & io_in_a_bits_opcode == 3'h1;	// Monitor.scala:122:{25,56}, :640:42
      automatic logic            _GEN_18 = io_in_a_valid & io_in_a_bits_opcode == 3'h2;	// Monitor.scala:130:{25,56}, :640:42
      automatic logic            _GEN_19 = io_in_a_valid & io_in_a_bits_opcode == 3'h3;	// Bundles.scala:145:30, Monitor.scala:138:{25,53}
      automatic logic            _GEN_20 = io_in_a_valid & io_in_a_bits_opcode == 3'h5;	// Monitor.scala:146:{25,46}
      automatic logic            _GEN_21 = io_in_d_valid & io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :310:{25,52}
      automatic logic            _GEN_22 = io_in_d_bits_source < 12'h810 | reset;	// Monitor.scala:49:11, Parameters.scala:57:20
      automatic logic            _GEN_23 = (&io_in_d_bits_size) | reset;	// Monitor.scala:49:11, :312:27
      automatic logic            _GEN_24 = io_in_d_valid & io_in_d_bits_opcode == 3'h4;	// Monitor.scala:104:25, :318:{25,47}
      automatic logic            _GEN_25 = io_in_d_valid & io_in_d_bits_opcode == 3'h5;	// Monitor.scala:146:25, :328:{25,51}
      automatic logic            _GEN_26;	// Monitor.scala:389:19
      automatic logic            _GEN_27;	// Monitor.scala:541:19
      automatic logic [8255:0]   _GEN_28 = {8242'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:634:44
      automatic logic [8255:0]   _a_opcode_lookup_T_1;	// Monitor.scala:634:44
      automatic logic            _GEN_29;	// Monitor.scala:671:26
      automatic logic            _GEN_30;	// Monitor.scala:680:71
      automatic logic            same_cycle_resp;	// Monitor.scala:681:88
      automatic logic [2063:0]   _GEN_31 = {2052'h0, io_in_d_bits_source};	// Monitor.scala:658:26, :682:25
      automatic logic            _GEN_32;	// Monitor.scala:684:30
      automatic logic            _GEN_33;	// Monitor.scala:684:30
      automatic logic [3:0]      _GEN_34 = {2'h0, io_in_d_bits_size};	// Monitor.scala:691:36
      automatic logic            _GEN_35;	// Monitor.scala:789:71
      automatic logic [2063:0]   _GEN_36;	// Monitor.scala:658:26
      automatic logic [2063:0]   _GEN_37;	// Monitor.scala:682:25
      automatic logic [8255:0]   _a_size_lookup_T_1;	// Monitor.scala:638:40
      automatic logic [2063:0]   _GEN_38;	// Monitor.scala:791:25
      automatic logic [8255:0]   _c_size_lookup_T_1;	// Monitor.scala:747:42
      _GEN_26 = io_in_a_valid & a_first_counter;	// Edges.scala:228:27, Monitor.scala:389:19
      _GEN_27 = io_in_d_valid & d_first_counter;	// Edges.scala:228:27, Monitor.scala:541:19
      _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_28;	// Monitor.scala:613:35, :634:44
      _GEN_29 = io_in_d_valid & ~d_first_counter_1;	// Edges.scala:228:27, :230:25, Monitor.scala:671:26
      _GEN_30 = _GEN_29 & ~d_release_ack;	// Monitor.scala:670:46, :671:{26,74}, :680:71
      same_cycle_resp =
        io_in_a_valid & ~a_first_counter_1 & io_in_a_bits_source == io_in_d_bits_source;	// Edges.scala:228:27, :230:25, Monitor.scala:681:{88,113}
      _GEN_32 = _GEN_30 & same_cycle_resp;	// Monitor.scala:680:71, :681:88, :684:30
      _GEN_33 = _GEN_30 & ~same_cycle_resp;	// Monitor.scala:680:71, :681:88, :684:30
      _GEN_35 = io_in_d_valid & ~d_first_counter_2 & d_release_ack;	// Edges.scala:228:27, :230:25, Monitor.scala:670:46, :789:71
      if (_GEN_2 & ~reset) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_3) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_4) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_5) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_6) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_7) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_8) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock is corrupt (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~reset) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_3) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_4) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_5) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_6) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~((|io_in_a_bits_param) | reset)) begin	// Monitor.scala:42:11, :92:53, :99:31
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_7) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_9 & ~_GEN_8) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm is corrupt (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~(_GEN_11 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:57:20
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~(_GEN_12 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:137:{49,52,67}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_3) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_5) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_13) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_14) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_10 & ~_GEN_8) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get is corrupt (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_16) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_3) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_5) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_13) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_14) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_16) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_3) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_5) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~_GEN_13) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_17 & ~((io_in_a_bits_mask & ~mask) == 8'h0 | reset)) begin	// Cat.scala:30:58, Monitor.scala:42:11, :88:31, :122:56, :127:{31,33,40}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~reset) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_3) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_5) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~(io_in_a_bits_param < 3'h5 | reset)) begin	// Bundles.scala:138:33, Monitor.scala:42:11, :130:56, :146:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_18 & ~_GEN_14) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~reset) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_3) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_5) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~(~(io_in_a_bits_param[2]) | reset)) begin	// Bundles.scala:145:30, Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid opcode param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_14) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~reset) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_3) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_5) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint address not aligned to size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~(io_in_a_bits_param < 3'h2 | reset)) begin	// Bundles.scala:158:28, Monitor.scala:42:11, :146:46, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid opcode param (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_14) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint contains invalid mask (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_8) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint is corrupt (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid & ~(io_in_d_bits_opcode != 3'h7 | reset)) begin	// Bundles.scala:39:24, :42:24, Monitor.scala:49:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel has invalid opcode (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_21 & ~_GEN_22) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_21 & ~_GEN_23) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~_GEN_22) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~reset) begin	// Monitor.scala:42:11, :49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid sink ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~_GEN_23) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant smaller than a beat (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~_GEN_22) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~reset) begin	// Monitor.scala:42:11, :49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~_GEN_23) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData smaller than a beat (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h0 & ~_GEN_22) begin	// Misc.scala:201:34, Monitor.scala:49:11, :338:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h1 & ~_GEN_22) begin	// Monitor.scala:49:11, :346:25, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (io_in_d_valid & io_in_d_bits_opcode == 3'h2 & ~_GEN_22) begin	// Monitor.scala:49:11, :354:25, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck carries invalid source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_26 & ~(io_in_a_bits_opcode == opcode | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_param == param | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_size == size | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_source == source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_26 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~(io_in_d_bits_opcode == opcode_1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(param_1 == 2'h0 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(io_in_d_bits_source == source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(~sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & ~(~denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _GEN_36 = inflight >> io_in_a_bits_source;	// Monitor.scala:611:27, :658:26
      if (_GEN & ~(~(_GEN_36[0]) | reset)) begin	// Monitor.scala:42:11, :652:27, :658:{17,26}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_37 = inflight >> _GEN_31;	// Monitor.scala:611:27, :682:25
      if (_GEN_30 & ~(_GEN_37[0] | same_cycle_resp | reset)) begin	// Monitor.scala:49:11, :680:71, :681:88, :682:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_32
          & ~(io_in_d_bits_opcode == _GEN_1[io_in_a_bits_opcode]
              | io_in_d_bits_opcode == _GEN_0[io_in_a_bits_opcode] | reset)) begin	// Monitor.scala:49:11, :684:30, :685:38, :686:39
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_32 & ~(io_in_a_bits_size == io_in_d_bits_size | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_33
          & ~(io_in_d_bits_opcode == _GEN_1[_a_opcode_lookup_T_1[3:1]]
              | io_in_d_bits_opcode == _GEN_0[_a_opcode_lookup_T_1[3:1]] | reset)) begin	// Monitor.scala:42:11, :49:11, :634:{44,152}, :684:30, :685:38, :686:39, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _a_size_lookup_T_1 = inflight_sizes >> _GEN_28;	// Monitor.scala:615:33, :634:44, :638:40
      if (_GEN_33 & ~(_GEN_34 == {1'h0, _a_size_lookup_T_1[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :638:{19,40,144}, :684:30, :691:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
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
      if (~(inflight == 2064'h0 | _plusarg_reader_out == 32'h0
            | watchdog < _plusarg_reader_out | reset)) begin	// Monitor.scala:42:11, :611:27, :706:27, :709:{26,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_38 = inflight_1 >> _GEN_31;	// Monitor.scala:682:25, :723:35, :791:25
      if (_GEN_35 & ~(_GEN_38[0] | reset)) begin	// Monitor.scala:49:11, :789:71, :791:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_28;	// Monitor.scala:634:44, :725:35, :747:42
      if (_GEN_35 & ~(_GEN_34 == {1'h0, _c_size_lookup_T_1[3:1]} | reset)) begin	// Monitor.scala:42:11, :49:11, :691:36, :747:{21,42,146}, :789:71, :795:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(inflight_1 == 2064'h0 | _plusarg_reader_1_out == 32'h0
            | watchdog_1 < _plusarg_reader_1_out | reset)) begin	// Monitor.scala:42:11, :611:27, :706:27, :723:35, :813:27, :816:{26,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at TileResetCtrl.scala:28:74)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic d_first_done;	// Decoupled.scala:40:37
    automatic logic _GEN_39;	// Monitor.scala:549:20
    d_first_done = io_in_d_ready & io_in_d_valid;	// Decoupled.scala:40:37
    _GEN_39 = d_first_done & ~d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:549:20
    if (reset) begin
      a_first_counter <= 1'h0;	// Edges.scala:228:27
      d_first_counter <= 1'h0;	// Edges.scala:228:27
      inflight <= 2064'h0;	// Monitor.scala:611:27
      inflight_opcodes <= 8256'h0;	// Monitor.scala:613:35
      inflight_sizes <= 8256'h0;	// Monitor.scala:613:35, :615:33
      a_first_counter_1 <= 1'h0;	// Edges.scala:228:27
      d_first_counter_1 <= 1'h0;	// Edges.scala:228:27
      watchdog <= 32'h0;	// Monitor.scala:706:27
      inflight_1 <= 2064'h0;	// Monitor.scala:611:27, :723:35
      inflight_sizes_1 <= 8256'h0;	// Monitor.scala:613:35, :725:35
      d_first_counter_2 <= 1'h0;	// Edges.scala:228:27
      watchdog_1 <= 32'h0;	// Monitor.scala:706:27, :813:27
    end
    else begin
      automatic logic           _GEN_40;	// Monitor.scala:675:72
      automatic logic [4095:0]  _GEN_41 = {4084'h0, io_in_d_bits_source};	// OneHot.scala:58:35
      automatic logic [32782:0] _GEN_42 = {32769'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:677:76
      automatic logic           _GEN_43;	// Monitor.scala:783:72
      automatic logic [4095:0]  _d_clr_T = 4096'h1 << _GEN_41;	// OneHot.scala:58:35
      automatic logic [4095:0]  _a_set_T = 4096'h1 << io_in_a_bits_source;	// OneHot.scala:58:35
      automatic logic [32782:0] _d_opcodes_clr_T_5 = 32783'hF << _GEN_42;	// Monitor.scala:677:76
      automatic logic [32770:0] _a_opcodes_set_T_1 =
        {32767'h0, _GEN ? {io_in_a_bits_opcode, 1'h1} : 4'h0}
        << {32757'h0, io_in_a_bits_source, 2'h0};	// Monitor.scala:49:11, :652:{27,72}, :654:{28,61}, :656:54
      automatic logic [32782:0] _d_sizes_clr_T_5 = 32783'hF << _GEN_42;	// Monitor.scala:677:76, :678:74
      automatic logic [32769:0] _a_sizes_set_T_1 =
        {32767'h0, _GEN ? {io_in_a_bits_size, 1'h1} : 3'h0}
        << {32756'h0, io_in_a_bits_source, 2'h0};	// Misc.scala:201:34, Monitor.scala:49:11, :652:{27,72}, :655:{28,59}, :656:54, :657:52
      automatic logic [4095:0]  _d_clr_T_1 = 4096'h1 << _GEN_41;	// OneHot.scala:58:35
      automatic logic [32782:0] _d_sizes_clr_T_11 = 32783'hF << _GEN_42;	// Monitor.scala:677:76, :786:74
      _GEN_40 = d_first_done & ~d_first_counter_1 & ~d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :671:74, :675:72
      _GEN_43 = d_first_done & ~d_first_counter_2 & d_release_ack;	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:670:46, :783:72
      a_first_counter <= (~a_first_done | a_first_counter - 1'h1) & a_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter <= (~d_first_done | d_first_counter - 1'h1) & d_first_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      inflight <=
        (inflight | (_GEN ? _a_set_T[2063:0] : 2064'h0))
        & ~(_GEN_40 ? _d_clr_T[2063:0] : 2064'h0);	// Monitor.scala:611:27, :652:{27,72}, :653:28, :675:{72,91}, :676:21, :702:{27,36,38}, OneHot.scala:58:35
      inflight_opcodes <=
        (inflight_opcodes | (_GEN ? _a_opcodes_set_T_1[8255:0] : 8256'h0))
        & ~(_GEN_40 ? _d_opcodes_clr_T_5[8255:0] : 8256'h0);	// Monitor.scala:613:35, :652:{27,72}, :656:{28,54}, :675:{72,91}, :677:{21,76}, :703:{43,60,62}
      inflight_sizes <=
        (inflight_sizes | (_GEN ? _a_sizes_set_T_1[8255:0] : 8256'h0))
        & ~(_GEN_40 ? _d_sizes_clr_T_5[8255:0] : 8256'h0);	// Monitor.scala:613:35, :615:33, :652:{27,72}, :657:{28,52}, :675:{72,91}, :678:{21,74}, :704:{39,54,56}
      a_first_counter_1 <= (~a_first_done | a_first_counter_1 - 1'h1) & a_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      d_first_counter_1 <= (~d_first_done | d_first_counter_1 - 1'h1) & d_first_counter_1;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (a_first_done | d_first_done)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
      inflight_1 <= inflight_1 & ~(_GEN_43 ? _d_clr_T_1[2063:0] : 2064'h0);	// Monitor.scala:611:27, :723:35, :783:{72,90}, :784:21, :809:{44,46}, OneHot.scala:58:35
      inflight_sizes_1 <=
        inflight_sizes_1 & ~(_GEN_43 ? _d_sizes_clr_T_11[8255:0] : 8256'h0);	// Monitor.scala:613:35, :725:35, :783:{72,90}, :786:{21,74}, :811:{56,58}
      d_first_counter_2 <= (~d_first_done | d_first_counter_2 - 1'h1) & d_first_counter_2;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      if (d_first_done)	// Decoupled.scala:40:37
        watchdog_1 <= 32'h0;	// Monitor.scala:706:27, :813:27
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
    if (_GEN_39) begin	// Monitor.scala:549:20
      opcode_1 <= io_in_d_bits_opcode;	// Monitor.scala:535:22
      param_1 <= 2'h0;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      source_1 <= io_in_d_bits_source;	// Monitor.scala:538:22
    end
    sink <= ~_GEN_39 & sink;	// Monitor.scala:539:22, :549:{20,32}, :554:15
    denied <= ~_GEN_39 & denied;	// Monitor.scala:539:22, :540:22, :549:{20,32}, :554:15, :555:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:1165];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [10:0] i = 11'h0; i < 11'h48E; i += 11'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        a_first_counter = _RANDOM[11'h0][0];	// Edges.scala:228:27
        opcode = _RANDOM[11'h0][3:1];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[11'h0][6:4];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[11'h0][8:7];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[11'h0][20:9];	// Edges.scala:228:27, Monitor.scala:387:22
        address = {_RANDOM[11'h0][31:21], _RANDOM[11'h1][9:0]};	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[11'h1][10];	// Edges.scala:228:27, Monitor.scala:388:22
        opcode_1 = _RANDOM[11'h1][13:11];	// Monitor.scala:388:22, :535:22
        param_1 = _RANDOM[11'h1][15:14];	// Monitor.scala:388:22, :536:22
        size_1 = _RANDOM[11'h1][17:16];	// Monitor.scala:388:22, :537:22
        source_1 = _RANDOM[11'h1][29:18];	// Monitor.scala:388:22, :538:22
        sink = _RANDOM[11'h1][30];	// Monitor.scala:388:22, :539:22
        denied = _RANDOM[11'h1][31];	// Monitor.scala:388:22, :540:22
        inflight =
          {_RANDOM[11'h2],
           _RANDOM[11'h3],
           _RANDOM[11'h4],
           _RANDOM[11'h5],
           _RANDOM[11'h6],
           _RANDOM[11'h7],
           _RANDOM[11'h8],
           _RANDOM[11'h9],
           _RANDOM[11'hA],
           _RANDOM[11'hB],
           _RANDOM[11'hC],
           _RANDOM[11'hD],
           _RANDOM[11'hE],
           _RANDOM[11'hF],
           _RANDOM[11'h10],
           _RANDOM[11'h11],
           _RANDOM[11'h12],
           _RANDOM[11'h13],
           _RANDOM[11'h14],
           _RANDOM[11'h15],
           _RANDOM[11'h16],
           _RANDOM[11'h17],
           _RANDOM[11'h18],
           _RANDOM[11'h19],
           _RANDOM[11'h1A],
           _RANDOM[11'h1B],
           _RANDOM[11'h1C],
           _RANDOM[11'h1D],
           _RANDOM[11'h1E],
           _RANDOM[11'h1F],
           _RANDOM[11'h20],
           _RANDOM[11'h21],
           _RANDOM[11'h22],
           _RANDOM[11'h23],
           _RANDOM[11'h24],
           _RANDOM[11'h25],
           _RANDOM[11'h26],
           _RANDOM[11'h27],
           _RANDOM[11'h28],
           _RANDOM[11'h29],
           _RANDOM[11'h2A],
           _RANDOM[11'h2B],
           _RANDOM[11'h2C],
           _RANDOM[11'h2D],
           _RANDOM[11'h2E],
           _RANDOM[11'h2F],
           _RANDOM[11'h30],
           _RANDOM[11'h31],
           _RANDOM[11'h32],
           _RANDOM[11'h33],
           _RANDOM[11'h34],
           _RANDOM[11'h35],
           _RANDOM[11'h36],
           _RANDOM[11'h37],
           _RANDOM[11'h38],
           _RANDOM[11'h39],
           _RANDOM[11'h3A],
           _RANDOM[11'h3B],
           _RANDOM[11'h3C],
           _RANDOM[11'h3D],
           _RANDOM[11'h3E],
           _RANDOM[11'h3F],
           _RANDOM[11'h40],
           _RANDOM[11'h41],
           _RANDOM[11'h42][15:0]};	// Monitor.scala:611:27
        inflight_opcodes =
          {_RANDOM[11'h42][31:16],
           _RANDOM[11'h43],
           _RANDOM[11'h44],
           _RANDOM[11'h45],
           _RANDOM[11'h46],
           _RANDOM[11'h47],
           _RANDOM[11'h48],
           _RANDOM[11'h49],
           _RANDOM[11'h4A],
           _RANDOM[11'h4B],
           _RANDOM[11'h4C],
           _RANDOM[11'h4D],
           _RANDOM[11'h4E],
           _RANDOM[11'h4F],
           _RANDOM[11'h50],
           _RANDOM[11'h51],
           _RANDOM[11'h52],
           _RANDOM[11'h53],
           _RANDOM[11'h54],
           _RANDOM[11'h55],
           _RANDOM[11'h56],
           _RANDOM[11'h57],
           _RANDOM[11'h58],
           _RANDOM[11'h59],
           _RANDOM[11'h5A],
           _RANDOM[11'h5B],
           _RANDOM[11'h5C],
           _RANDOM[11'h5D],
           _RANDOM[11'h5E],
           _RANDOM[11'h5F],
           _RANDOM[11'h60],
           _RANDOM[11'h61],
           _RANDOM[11'h62],
           _RANDOM[11'h63],
           _RANDOM[11'h64],
           _RANDOM[11'h65],
           _RANDOM[11'h66],
           _RANDOM[11'h67],
           _RANDOM[11'h68],
           _RANDOM[11'h69],
           _RANDOM[11'h6A],
           _RANDOM[11'h6B],
           _RANDOM[11'h6C],
           _RANDOM[11'h6D],
           _RANDOM[11'h6E],
           _RANDOM[11'h6F],
           _RANDOM[11'h70],
           _RANDOM[11'h71],
           _RANDOM[11'h72],
           _RANDOM[11'h73],
           _RANDOM[11'h74],
           _RANDOM[11'h75],
           _RANDOM[11'h76],
           _RANDOM[11'h77],
           _RANDOM[11'h78],
           _RANDOM[11'h79],
           _RANDOM[11'h7A],
           _RANDOM[11'h7B],
           _RANDOM[11'h7C],
           _RANDOM[11'h7D],
           _RANDOM[11'h7E],
           _RANDOM[11'h7F],
           _RANDOM[11'h80],
           _RANDOM[11'h81],
           _RANDOM[11'h82],
           _RANDOM[11'h83],
           _RANDOM[11'h84],
           _RANDOM[11'h85],
           _RANDOM[11'h86],
           _RANDOM[11'h87],
           _RANDOM[11'h88],
           _RANDOM[11'h89],
           _RANDOM[11'h8A],
           _RANDOM[11'h8B],
           _RANDOM[11'h8C],
           _RANDOM[11'h8D],
           _RANDOM[11'h8E],
           _RANDOM[11'h8F],
           _RANDOM[11'h90],
           _RANDOM[11'h91],
           _RANDOM[11'h92],
           _RANDOM[11'h93],
           _RANDOM[11'h94],
           _RANDOM[11'h95],
           _RANDOM[11'h96],
           _RANDOM[11'h97],
           _RANDOM[11'h98],
           _RANDOM[11'h99],
           _RANDOM[11'h9A],
           _RANDOM[11'h9B],
           _RANDOM[11'h9C],
           _RANDOM[11'h9D],
           _RANDOM[11'h9E],
           _RANDOM[11'h9F],
           _RANDOM[11'hA0],
           _RANDOM[11'hA1],
           _RANDOM[11'hA2],
           _RANDOM[11'hA3],
           _RANDOM[11'hA4],
           _RANDOM[11'hA5],
           _RANDOM[11'hA6],
           _RANDOM[11'hA7],
           _RANDOM[11'hA8],
           _RANDOM[11'hA9],
           _RANDOM[11'hAA],
           _RANDOM[11'hAB],
           _RANDOM[11'hAC],
           _RANDOM[11'hAD],
           _RANDOM[11'hAE],
           _RANDOM[11'hAF],
           _RANDOM[11'hB0],
           _RANDOM[11'hB1],
           _RANDOM[11'hB2],
           _RANDOM[11'hB3],
           _RANDOM[11'hB4],
           _RANDOM[11'hB5],
           _RANDOM[11'hB6],
           _RANDOM[11'hB7],
           _RANDOM[11'hB8],
           _RANDOM[11'hB9],
           _RANDOM[11'hBA],
           _RANDOM[11'hBB],
           _RANDOM[11'hBC],
           _RANDOM[11'hBD],
           _RANDOM[11'hBE],
           _RANDOM[11'hBF],
           _RANDOM[11'hC0],
           _RANDOM[11'hC1],
           _RANDOM[11'hC2],
           _RANDOM[11'hC3],
           _RANDOM[11'hC4],
           _RANDOM[11'hC5],
           _RANDOM[11'hC6],
           _RANDOM[11'hC7],
           _RANDOM[11'hC8],
           _RANDOM[11'hC9],
           _RANDOM[11'hCA],
           _RANDOM[11'hCB],
           _RANDOM[11'hCC],
           _RANDOM[11'hCD],
           _RANDOM[11'hCE],
           _RANDOM[11'hCF],
           _RANDOM[11'hD0],
           _RANDOM[11'hD1],
           _RANDOM[11'hD2],
           _RANDOM[11'hD3],
           _RANDOM[11'hD4],
           _RANDOM[11'hD5],
           _RANDOM[11'hD6],
           _RANDOM[11'hD7],
           _RANDOM[11'hD8],
           _RANDOM[11'hD9],
           _RANDOM[11'hDA],
           _RANDOM[11'hDB],
           _RANDOM[11'hDC],
           _RANDOM[11'hDD],
           _RANDOM[11'hDE],
           _RANDOM[11'hDF],
           _RANDOM[11'hE0],
           _RANDOM[11'hE1],
           _RANDOM[11'hE2],
           _RANDOM[11'hE3],
           _RANDOM[11'hE4],
           _RANDOM[11'hE5],
           _RANDOM[11'hE6],
           _RANDOM[11'hE7],
           _RANDOM[11'hE8],
           _RANDOM[11'hE9],
           _RANDOM[11'hEA],
           _RANDOM[11'hEB],
           _RANDOM[11'hEC],
           _RANDOM[11'hED],
           _RANDOM[11'hEE],
           _RANDOM[11'hEF],
           _RANDOM[11'hF0],
           _RANDOM[11'hF1],
           _RANDOM[11'hF2],
           _RANDOM[11'hF3],
           _RANDOM[11'hF4],
           _RANDOM[11'hF5],
           _RANDOM[11'hF6],
           _RANDOM[11'hF7],
           _RANDOM[11'hF8],
           _RANDOM[11'hF9],
           _RANDOM[11'hFA],
           _RANDOM[11'hFB],
           _RANDOM[11'hFC],
           _RANDOM[11'hFD],
           _RANDOM[11'hFE],
           _RANDOM[11'hFF],
           _RANDOM[11'h100],
           _RANDOM[11'h101],
           _RANDOM[11'h102],
           _RANDOM[11'h103],
           _RANDOM[11'h104],
           _RANDOM[11'h105],
           _RANDOM[11'h106],
           _RANDOM[11'h107],
           _RANDOM[11'h108],
           _RANDOM[11'h109],
           _RANDOM[11'h10A],
           _RANDOM[11'h10B],
           _RANDOM[11'h10C],
           _RANDOM[11'h10D],
           _RANDOM[11'h10E],
           _RANDOM[11'h10F],
           _RANDOM[11'h110],
           _RANDOM[11'h111],
           _RANDOM[11'h112],
           _RANDOM[11'h113],
           _RANDOM[11'h114],
           _RANDOM[11'h115],
           _RANDOM[11'h116],
           _RANDOM[11'h117],
           _RANDOM[11'h118],
           _RANDOM[11'h119],
           _RANDOM[11'h11A],
           _RANDOM[11'h11B],
           _RANDOM[11'h11C],
           _RANDOM[11'h11D],
           _RANDOM[11'h11E],
           _RANDOM[11'h11F],
           _RANDOM[11'h120],
           _RANDOM[11'h121],
           _RANDOM[11'h122],
           _RANDOM[11'h123],
           _RANDOM[11'h124],
           _RANDOM[11'h125],
           _RANDOM[11'h126],
           _RANDOM[11'h127],
           _RANDOM[11'h128],
           _RANDOM[11'h129],
           _RANDOM[11'h12A],
           _RANDOM[11'h12B],
           _RANDOM[11'h12C],
           _RANDOM[11'h12D],
           _RANDOM[11'h12E],
           _RANDOM[11'h12F],
           _RANDOM[11'h130],
           _RANDOM[11'h131],
           _RANDOM[11'h132],
           _RANDOM[11'h133],
           _RANDOM[11'h134],
           _RANDOM[11'h135],
           _RANDOM[11'h136],
           _RANDOM[11'h137],
           _RANDOM[11'h138],
           _RANDOM[11'h139],
           _RANDOM[11'h13A],
           _RANDOM[11'h13B],
           _RANDOM[11'h13C],
           _RANDOM[11'h13D],
           _RANDOM[11'h13E],
           _RANDOM[11'h13F],
           _RANDOM[11'h140],
           _RANDOM[11'h141],
           _RANDOM[11'h142],
           _RANDOM[11'h143],
           _RANDOM[11'h144][15:0]};	// Monitor.scala:611:27, :613:35
        inflight_sizes =
          {_RANDOM[11'h144][31:16],
           _RANDOM[11'h145],
           _RANDOM[11'h146],
           _RANDOM[11'h147],
           _RANDOM[11'h148],
           _RANDOM[11'h149],
           _RANDOM[11'h14A],
           _RANDOM[11'h14B],
           _RANDOM[11'h14C],
           _RANDOM[11'h14D],
           _RANDOM[11'h14E],
           _RANDOM[11'h14F],
           _RANDOM[11'h150],
           _RANDOM[11'h151],
           _RANDOM[11'h152],
           _RANDOM[11'h153],
           _RANDOM[11'h154],
           _RANDOM[11'h155],
           _RANDOM[11'h156],
           _RANDOM[11'h157],
           _RANDOM[11'h158],
           _RANDOM[11'h159],
           _RANDOM[11'h15A],
           _RANDOM[11'h15B],
           _RANDOM[11'h15C],
           _RANDOM[11'h15D],
           _RANDOM[11'h15E],
           _RANDOM[11'h15F],
           _RANDOM[11'h160],
           _RANDOM[11'h161],
           _RANDOM[11'h162],
           _RANDOM[11'h163],
           _RANDOM[11'h164],
           _RANDOM[11'h165],
           _RANDOM[11'h166],
           _RANDOM[11'h167],
           _RANDOM[11'h168],
           _RANDOM[11'h169],
           _RANDOM[11'h16A],
           _RANDOM[11'h16B],
           _RANDOM[11'h16C],
           _RANDOM[11'h16D],
           _RANDOM[11'h16E],
           _RANDOM[11'h16F],
           _RANDOM[11'h170],
           _RANDOM[11'h171],
           _RANDOM[11'h172],
           _RANDOM[11'h173],
           _RANDOM[11'h174],
           _RANDOM[11'h175],
           _RANDOM[11'h176],
           _RANDOM[11'h177],
           _RANDOM[11'h178],
           _RANDOM[11'h179],
           _RANDOM[11'h17A],
           _RANDOM[11'h17B],
           _RANDOM[11'h17C],
           _RANDOM[11'h17D],
           _RANDOM[11'h17E],
           _RANDOM[11'h17F],
           _RANDOM[11'h180],
           _RANDOM[11'h181],
           _RANDOM[11'h182],
           _RANDOM[11'h183],
           _RANDOM[11'h184],
           _RANDOM[11'h185],
           _RANDOM[11'h186],
           _RANDOM[11'h187],
           _RANDOM[11'h188],
           _RANDOM[11'h189],
           _RANDOM[11'h18A],
           _RANDOM[11'h18B],
           _RANDOM[11'h18C],
           _RANDOM[11'h18D],
           _RANDOM[11'h18E],
           _RANDOM[11'h18F],
           _RANDOM[11'h190],
           _RANDOM[11'h191],
           _RANDOM[11'h192],
           _RANDOM[11'h193],
           _RANDOM[11'h194],
           _RANDOM[11'h195],
           _RANDOM[11'h196],
           _RANDOM[11'h197],
           _RANDOM[11'h198],
           _RANDOM[11'h199],
           _RANDOM[11'h19A],
           _RANDOM[11'h19B],
           _RANDOM[11'h19C],
           _RANDOM[11'h19D],
           _RANDOM[11'h19E],
           _RANDOM[11'h19F],
           _RANDOM[11'h1A0],
           _RANDOM[11'h1A1],
           _RANDOM[11'h1A2],
           _RANDOM[11'h1A3],
           _RANDOM[11'h1A4],
           _RANDOM[11'h1A5],
           _RANDOM[11'h1A6],
           _RANDOM[11'h1A7],
           _RANDOM[11'h1A8],
           _RANDOM[11'h1A9],
           _RANDOM[11'h1AA],
           _RANDOM[11'h1AB],
           _RANDOM[11'h1AC],
           _RANDOM[11'h1AD],
           _RANDOM[11'h1AE],
           _RANDOM[11'h1AF],
           _RANDOM[11'h1B0],
           _RANDOM[11'h1B1],
           _RANDOM[11'h1B2],
           _RANDOM[11'h1B3],
           _RANDOM[11'h1B4],
           _RANDOM[11'h1B5],
           _RANDOM[11'h1B6],
           _RANDOM[11'h1B7],
           _RANDOM[11'h1B8],
           _RANDOM[11'h1B9],
           _RANDOM[11'h1BA],
           _RANDOM[11'h1BB],
           _RANDOM[11'h1BC],
           _RANDOM[11'h1BD],
           _RANDOM[11'h1BE],
           _RANDOM[11'h1BF],
           _RANDOM[11'h1C0],
           _RANDOM[11'h1C1],
           _RANDOM[11'h1C2],
           _RANDOM[11'h1C3],
           _RANDOM[11'h1C4],
           _RANDOM[11'h1C5],
           _RANDOM[11'h1C6],
           _RANDOM[11'h1C7],
           _RANDOM[11'h1C8],
           _RANDOM[11'h1C9],
           _RANDOM[11'h1CA],
           _RANDOM[11'h1CB],
           _RANDOM[11'h1CC],
           _RANDOM[11'h1CD],
           _RANDOM[11'h1CE],
           _RANDOM[11'h1CF],
           _RANDOM[11'h1D0],
           _RANDOM[11'h1D1],
           _RANDOM[11'h1D2],
           _RANDOM[11'h1D3],
           _RANDOM[11'h1D4],
           _RANDOM[11'h1D5],
           _RANDOM[11'h1D6],
           _RANDOM[11'h1D7],
           _RANDOM[11'h1D8],
           _RANDOM[11'h1D9],
           _RANDOM[11'h1DA],
           _RANDOM[11'h1DB],
           _RANDOM[11'h1DC],
           _RANDOM[11'h1DD],
           _RANDOM[11'h1DE],
           _RANDOM[11'h1DF],
           _RANDOM[11'h1E0],
           _RANDOM[11'h1E1],
           _RANDOM[11'h1E2],
           _RANDOM[11'h1E3],
           _RANDOM[11'h1E4],
           _RANDOM[11'h1E5],
           _RANDOM[11'h1E6],
           _RANDOM[11'h1E7],
           _RANDOM[11'h1E8],
           _RANDOM[11'h1E9],
           _RANDOM[11'h1EA],
           _RANDOM[11'h1EB],
           _RANDOM[11'h1EC],
           _RANDOM[11'h1ED],
           _RANDOM[11'h1EE],
           _RANDOM[11'h1EF],
           _RANDOM[11'h1F0],
           _RANDOM[11'h1F1],
           _RANDOM[11'h1F2],
           _RANDOM[11'h1F3],
           _RANDOM[11'h1F4],
           _RANDOM[11'h1F5],
           _RANDOM[11'h1F6],
           _RANDOM[11'h1F7],
           _RANDOM[11'h1F8],
           _RANDOM[11'h1F9],
           _RANDOM[11'h1FA],
           _RANDOM[11'h1FB],
           _RANDOM[11'h1FC],
           _RANDOM[11'h1FD],
           _RANDOM[11'h1FE],
           _RANDOM[11'h1FF],
           _RANDOM[11'h200],
           _RANDOM[11'h201],
           _RANDOM[11'h202],
           _RANDOM[11'h203],
           _RANDOM[11'h204],
           _RANDOM[11'h205],
           _RANDOM[11'h206],
           _RANDOM[11'h207],
           _RANDOM[11'h208],
           _RANDOM[11'h209],
           _RANDOM[11'h20A],
           _RANDOM[11'h20B],
           _RANDOM[11'h20C],
           _RANDOM[11'h20D],
           _RANDOM[11'h20E],
           _RANDOM[11'h20F],
           _RANDOM[11'h210],
           _RANDOM[11'h211],
           _RANDOM[11'h212],
           _RANDOM[11'h213],
           _RANDOM[11'h214],
           _RANDOM[11'h215],
           _RANDOM[11'h216],
           _RANDOM[11'h217],
           _RANDOM[11'h218],
           _RANDOM[11'h219],
           _RANDOM[11'h21A],
           _RANDOM[11'h21B],
           _RANDOM[11'h21C],
           _RANDOM[11'h21D],
           _RANDOM[11'h21E],
           _RANDOM[11'h21F],
           _RANDOM[11'h220],
           _RANDOM[11'h221],
           _RANDOM[11'h222],
           _RANDOM[11'h223],
           _RANDOM[11'h224],
           _RANDOM[11'h225],
           _RANDOM[11'h226],
           _RANDOM[11'h227],
           _RANDOM[11'h228],
           _RANDOM[11'h229],
           _RANDOM[11'h22A],
           _RANDOM[11'h22B],
           _RANDOM[11'h22C],
           _RANDOM[11'h22D],
           _RANDOM[11'h22E],
           _RANDOM[11'h22F],
           _RANDOM[11'h230],
           _RANDOM[11'h231],
           _RANDOM[11'h232],
           _RANDOM[11'h233],
           _RANDOM[11'h234],
           _RANDOM[11'h235],
           _RANDOM[11'h236],
           _RANDOM[11'h237],
           _RANDOM[11'h238],
           _RANDOM[11'h239],
           _RANDOM[11'h23A],
           _RANDOM[11'h23B],
           _RANDOM[11'h23C],
           _RANDOM[11'h23D],
           _RANDOM[11'h23E],
           _RANDOM[11'h23F],
           _RANDOM[11'h240],
           _RANDOM[11'h241],
           _RANDOM[11'h242],
           _RANDOM[11'h243],
           _RANDOM[11'h244],
           _RANDOM[11'h245],
           _RANDOM[11'h246][15:0]};	// Monitor.scala:613:35, :615:33
        a_first_counter_1 = _RANDOM[11'h246][16];	// Edges.scala:228:27, Monitor.scala:615:33
        d_first_counter_1 = _RANDOM[11'h246][17];	// Edges.scala:228:27, Monitor.scala:615:33
        watchdog = {_RANDOM[11'h246][31:18], _RANDOM[11'h247][17:0]};	// Monitor.scala:615:33, :706:27
        inflight_1 =
          {_RANDOM[11'h247][31:18],
           _RANDOM[11'h248],
           _RANDOM[11'h249],
           _RANDOM[11'h24A],
           _RANDOM[11'h24B],
           _RANDOM[11'h24C],
           _RANDOM[11'h24D],
           _RANDOM[11'h24E],
           _RANDOM[11'h24F],
           _RANDOM[11'h250],
           _RANDOM[11'h251],
           _RANDOM[11'h252],
           _RANDOM[11'h253],
           _RANDOM[11'h254],
           _RANDOM[11'h255],
           _RANDOM[11'h256],
           _RANDOM[11'h257],
           _RANDOM[11'h258],
           _RANDOM[11'h259],
           _RANDOM[11'h25A],
           _RANDOM[11'h25B],
           _RANDOM[11'h25C],
           _RANDOM[11'h25D],
           _RANDOM[11'h25E],
           _RANDOM[11'h25F],
           _RANDOM[11'h260],
           _RANDOM[11'h261],
           _RANDOM[11'h262],
           _RANDOM[11'h263],
           _RANDOM[11'h264],
           _RANDOM[11'h265],
           _RANDOM[11'h266],
           _RANDOM[11'h267],
           _RANDOM[11'h268],
           _RANDOM[11'h269],
           _RANDOM[11'h26A],
           _RANDOM[11'h26B],
           _RANDOM[11'h26C],
           _RANDOM[11'h26D],
           _RANDOM[11'h26E],
           _RANDOM[11'h26F],
           _RANDOM[11'h270],
           _RANDOM[11'h271],
           _RANDOM[11'h272],
           _RANDOM[11'h273],
           _RANDOM[11'h274],
           _RANDOM[11'h275],
           _RANDOM[11'h276],
           _RANDOM[11'h277],
           _RANDOM[11'h278],
           _RANDOM[11'h279],
           _RANDOM[11'h27A],
           _RANDOM[11'h27B],
           _RANDOM[11'h27C],
           _RANDOM[11'h27D],
           _RANDOM[11'h27E],
           _RANDOM[11'h27F],
           _RANDOM[11'h280],
           _RANDOM[11'h281],
           _RANDOM[11'h282],
           _RANDOM[11'h283],
           _RANDOM[11'h284],
           _RANDOM[11'h285],
           _RANDOM[11'h286],
           _RANDOM[11'h287],
           _RANDOM[11'h288][1:0]};	// Monitor.scala:706:27, :723:35
        inflight_sizes_1 =
          {_RANDOM[11'h38A][31:2],
           _RANDOM[11'h38B],
           _RANDOM[11'h38C],
           _RANDOM[11'h38D],
           _RANDOM[11'h38E],
           _RANDOM[11'h38F],
           _RANDOM[11'h390],
           _RANDOM[11'h391],
           _RANDOM[11'h392],
           _RANDOM[11'h393],
           _RANDOM[11'h394],
           _RANDOM[11'h395],
           _RANDOM[11'h396],
           _RANDOM[11'h397],
           _RANDOM[11'h398],
           _RANDOM[11'h399],
           _RANDOM[11'h39A],
           _RANDOM[11'h39B],
           _RANDOM[11'h39C],
           _RANDOM[11'h39D],
           _RANDOM[11'h39E],
           _RANDOM[11'h39F],
           _RANDOM[11'h3A0],
           _RANDOM[11'h3A1],
           _RANDOM[11'h3A2],
           _RANDOM[11'h3A3],
           _RANDOM[11'h3A4],
           _RANDOM[11'h3A5],
           _RANDOM[11'h3A6],
           _RANDOM[11'h3A7],
           _RANDOM[11'h3A8],
           _RANDOM[11'h3A9],
           _RANDOM[11'h3AA],
           _RANDOM[11'h3AB],
           _RANDOM[11'h3AC],
           _RANDOM[11'h3AD],
           _RANDOM[11'h3AE],
           _RANDOM[11'h3AF],
           _RANDOM[11'h3B0],
           _RANDOM[11'h3B1],
           _RANDOM[11'h3B2],
           _RANDOM[11'h3B3],
           _RANDOM[11'h3B4],
           _RANDOM[11'h3B5],
           _RANDOM[11'h3B6],
           _RANDOM[11'h3B7],
           _RANDOM[11'h3B8],
           _RANDOM[11'h3B9],
           _RANDOM[11'h3BA],
           _RANDOM[11'h3BB],
           _RANDOM[11'h3BC],
           _RANDOM[11'h3BD],
           _RANDOM[11'h3BE],
           _RANDOM[11'h3BF],
           _RANDOM[11'h3C0],
           _RANDOM[11'h3C1],
           _RANDOM[11'h3C2],
           _RANDOM[11'h3C3],
           _RANDOM[11'h3C4],
           _RANDOM[11'h3C5],
           _RANDOM[11'h3C6],
           _RANDOM[11'h3C7],
           _RANDOM[11'h3C8],
           _RANDOM[11'h3C9],
           _RANDOM[11'h3CA],
           _RANDOM[11'h3CB],
           _RANDOM[11'h3CC],
           _RANDOM[11'h3CD],
           _RANDOM[11'h3CE],
           _RANDOM[11'h3CF],
           _RANDOM[11'h3D0],
           _RANDOM[11'h3D1],
           _RANDOM[11'h3D2],
           _RANDOM[11'h3D3],
           _RANDOM[11'h3D4],
           _RANDOM[11'h3D5],
           _RANDOM[11'h3D6],
           _RANDOM[11'h3D7],
           _RANDOM[11'h3D8],
           _RANDOM[11'h3D9],
           _RANDOM[11'h3DA],
           _RANDOM[11'h3DB],
           _RANDOM[11'h3DC],
           _RANDOM[11'h3DD],
           _RANDOM[11'h3DE],
           _RANDOM[11'h3DF],
           _RANDOM[11'h3E0],
           _RANDOM[11'h3E1],
           _RANDOM[11'h3E2],
           _RANDOM[11'h3E3],
           _RANDOM[11'h3E4],
           _RANDOM[11'h3E5],
           _RANDOM[11'h3E6],
           _RANDOM[11'h3E7],
           _RANDOM[11'h3E8],
           _RANDOM[11'h3E9],
           _RANDOM[11'h3EA],
           _RANDOM[11'h3EB],
           _RANDOM[11'h3EC],
           _RANDOM[11'h3ED],
           _RANDOM[11'h3EE],
           _RANDOM[11'h3EF],
           _RANDOM[11'h3F0],
           _RANDOM[11'h3F1],
           _RANDOM[11'h3F2],
           _RANDOM[11'h3F3],
           _RANDOM[11'h3F4],
           _RANDOM[11'h3F5],
           _RANDOM[11'h3F6],
           _RANDOM[11'h3F7],
           _RANDOM[11'h3F8],
           _RANDOM[11'h3F9],
           _RANDOM[11'h3FA],
           _RANDOM[11'h3FB],
           _RANDOM[11'h3FC],
           _RANDOM[11'h3FD],
           _RANDOM[11'h3FE],
           _RANDOM[11'h3FF],
           _RANDOM[11'h400],
           _RANDOM[11'h401],
           _RANDOM[11'h402],
           _RANDOM[11'h403],
           _RANDOM[11'h404],
           _RANDOM[11'h405],
           _RANDOM[11'h406],
           _RANDOM[11'h407],
           _RANDOM[11'h408],
           _RANDOM[11'h409],
           _RANDOM[11'h40A],
           _RANDOM[11'h40B],
           _RANDOM[11'h40C],
           _RANDOM[11'h40D],
           _RANDOM[11'h40E],
           _RANDOM[11'h40F],
           _RANDOM[11'h410],
           _RANDOM[11'h411],
           _RANDOM[11'h412],
           _RANDOM[11'h413],
           _RANDOM[11'h414],
           _RANDOM[11'h415],
           _RANDOM[11'h416],
           _RANDOM[11'h417],
           _RANDOM[11'h418],
           _RANDOM[11'h419],
           _RANDOM[11'h41A],
           _RANDOM[11'h41B],
           _RANDOM[11'h41C],
           _RANDOM[11'h41D],
           _RANDOM[11'h41E],
           _RANDOM[11'h41F],
           _RANDOM[11'h420],
           _RANDOM[11'h421],
           _RANDOM[11'h422],
           _RANDOM[11'h423],
           _RANDOM[11'h424],
           _RANDOM[11'h425],
           _RANDOM[11'h426],
           _RANDOM[11'h427],
           _RANDOM[11'h428],
           _RANDOM[11'h429],
           _RANDOM[11'h42A],
           _RANDOM[11'h42B],
           _RANDOM[11'h42C],
           _RANDOM[11'h42D],
           _RANDOM[11'h42E],
           _RANDOM[11'h42F],
           _RANDOM[11'h430],
           _RANDOM[11'h431],
           _RANDOM[11'h432],
           _RANDOM[11'h433],
           _RANDOM[11'h434],
           _RANDOM[11'h435],
           _RANDOM[11'h436],
           _RANDOM[11'h437],
           _RANDOM[11'h438],
           _RANDOM[11'h439],
           _RANDOM[11'h43A],
           _RANDOM[11'h43B],
           _RANDOM[11'h43C],
           _RANDOM[11'h43D],
           _RANDOM[11'h43E],
           _RANDOM[11'h43F],
           _RANDOM[11'h440],
           _RANDOM[11'h441],
           _RANDOM[11'h442],
           _RANDOM[11'h443],
           _RANDOM[11'h444],
           _RANDOM[11'h445],
           _RANDOM[11'h446],
           _RANDOM[11'h447],
           _RANDOM[11'h448],
           _RANDOM[11'h449],
           _RANDOM[11'h44A],
           _RANDOM[11'h44B],
           _RANDOM[11'h44C],
           _RANDOM[11'h44D],
           _RANDOM[11'h44E],
           _RANDOM[11'h44F],
           _RANDOM[11'h450],
           _RANDOM[11'h451],
           _RANDOM[11'h452],
           _RANDOM[11'h453],
           _RANDOM[11'h454],
           _RANDOM[11'h455],
           _RANDOM[11'h456],
           _RANDOM[11'h457],
           _RANDOM[11'h458],
           _RANDOM[11'h459],
           _RANDOM[11'h45A],
           _RANDOM[11'h45B],
           _RANDOM[11'h45C],
           _RANDOM[11'h45D],
           _RANDOM[11'h45E],
           _RANDOM[11'h45F],
           _RANDOM[11'h460],
           _RANDOM[11'h461],
           _RANDOM[11'h462],
           _RANDOM[11'h463],
           _RANDOM[11'h464],
           _RANDOM[11'h465],
           _RANDOM[11'h466],
           _RANDOM[11'h467],
           _RANDOM[11'h468],
           _RANDOM[11'h469],
           _RANDOM[11'h46A],
           _RANDOM[11'h46B],
           _RANDOM[11'h46C],
           _RANDOM[11'h46D],
           _RANDOM[11'h46E],
           _RANDOM[11'h46F],
           _RANDOM[11'h470],
           _RANDOM[11'h471],
           _RANDOM[11'h472],
           _RANDOM[11'h473],
           _RANDOM[11'h474],
           _RANDOM[11'h475],
           _RANDOM[11'h476],
           _RANDOM[11'h477],
           _RANDOM[11'h478],
           _RANDOM[11'h479],
           _RANDOM[11'h47A],
           _RANDOM[11'h47B],
           _RANDOM[11'h47C],
           _RANDOM[11'h47D],
           _RANDOM[11'h47E],
           _RANDOM[11'h47F],
           _RANDOM[11'h480],
           _RANDOM[11'h481],
           _RANDOM[11'h482],
           _RANDOM[11'h483],
           _RANDOM[11'h484],
           _RANDOM[11'h485],
           _RANDOM[11'h486],
           _RANDOM[11'h487],
           _RANDOM[11'h488],
           _RANDOM[11'h489],
           _RANDOM[11'h48A],
           _RANDOM[11'h48B],
           _RANDOM[11'h48C][1:0]};	// Monitor.scala:725:35
        d_first_counter_2 = _RANDOM[11'h48C][3];	// Edges.scala:228:27, Monitor.scala:725:35
        watchdog_1 = {_RANDOM[11'h48C][31:4], _RANDOM[11'h48D][3:0]};	// Monitor.scala:725:35, :813:27
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

