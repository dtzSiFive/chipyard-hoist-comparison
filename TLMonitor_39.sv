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

module TLMonitor_39(
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
  input [2:0]  io_in_a_bits_opcode,
               io_in_a_bits_param,
               io_in_a_bits_size,
  input [7:0]  io_in_a_bits_source,
  input [16:0] io_in_a_bits_address,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
               io_in_d_ready,
               io_in_d_valid,
  input [2:0]  io_in_d_bits_size,
  input [7:0]  io_in_d_bits_source
);

  wire [31:0]  _plusarg_reader_out;	// PlusArg.scala:80:11
  wire         a_first_done = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg  [2:0]   a_first_counter;	// Edges.scala:228:27
  reg  [2:0]   opcode;	// Monitor.scala:384:22
  reg  [2:0]   param;	// Monitor.scala:385:22
  reg  [2:0]   size;	// Monitor.scala:386:22
  reg  [7:0]   source;	// Monitor.scala:387:22
  reg  [16:0]  address;	// Monitor.scala:388:22
  reg  [2:0]   d_first_counter;	// Edges.scala:228:27
  reg  [2:0]   opcode_1;	// Monitor.scala:535:22
  reg  [1:0]   param_1;	// Monitor.scala:536:22
  reg  [2:0]   size_1;	// Monitor.scala:537:22
  reg  [7:0]   source_1;	// Monitor.scala:538:22
  reg          sink;	// Monitor.scala:539:22
  reg          denied;	// Monitor.scala:540:22
  reg  [128:0] inflight;	// Monitor.scala:611:27
  reg  [515:0] inflight_opcodes;	// Monitor.scala:613:35
  reg  [515:0] inflight_sizes;	// Monitor.scala:615:33
  reg  [2:0]   a_first_counter_1;	// Edges.scala:228:27
  wire         a_first_1 = a_first_counter_1 == 3'h0;	// Edges.scala:228:27, :230:25, Parameters.scala:52:29
  reg  [2:0]   d_first_counter_1;	// Edges.scala:228:27
  wire         d_first_1 = d_first_counter_1 == 3'h0;	// Edges.scala:228:27, :230:25, Parameters.scala:52:29
  wire         _GEN = a_first_done & a_first_1;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:652:27
  reg  [31:0]  watchdog;	// Monitor.scala:706:27
  reg  [31:0]  watchdog_1;	// Monitor.scala:813:27
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN_0 =
        {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:686:39
      automatic logic [7:0][2:0] _GEN_1 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:685:38
      automatic logic            _source_ok_WIRE_0 = io_in_a_bits_source == 8'h44;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_1 = io_in_a_bits_source == 8'h40;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_2 = io_in_a_bits_source == 8'h41;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_3 = io_in_a_bits_source == 8'h42;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_4 = io_in_a_bits_source == 8'h3C;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_5 = io_in_a_bits_source == 8'h3D;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_6 = io_in_a_bits_source == 8'h3E;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_7 = io_in_a_bits_source == 8'h38;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_8 = io_in_a_bits_source == 8'h39;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_9 = io_in_a_bits_source == 8'h3A;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_11 = io_in_a_bits_source == 8'h9;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_12 = io_in_a_bits_source == 8'h10;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_14 = io_in_a_bits_source == 8'h25;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_15 = io_in_a_bits_source == 8'h28;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_17 = io_in_a_bits_source == 8'h33;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_18 = io_in_a_bits_source == 8'h34;	// Parameters.scala:46:9
      automatic logic            _source_ok_WIRE_19 = io_in_a_bits_source == 8'h80;	// Parameters.scala:46:9
      automatic logic            _mask_T = io_in_a_bits_size > 3'h2;	// Misc.scala:205:21, Monitor.scala:640:42
      automatic logic            mask_size = io_in_a_bits_size[1:0] == 2'h2;	// Misc.scala:208:26, OneHot.scala:64:49, Parameters.scala:57:20
      automatic logic            mask_acc =
        _mask_T | mask_size & ~(io_in_a_bits_address[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
      automatic logic            mask_acc_1 =
        _mask_T | mask_size & io_in_a_bits_address[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
      automatic logic            mask_size_1 = io_in_a_bits_size[1:0] == 2'h1;	// Misc.scala:208:26, OneHot.scala:64:49, :65:12
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
      automatic logic            _GEN_3 = io_in_a_bits_source[7:3] == 5'h4;	// Parameters.scala:54:{10,32}
      automatic logic            _GEN_4 = io_in_a_bits_source[7:2] == 6'hC;	// Parameters.scala:54:{10,32}
      automatic logic            _GEN_5 = io_in_a_bits_size == 3'h6;	// Monitor.scala:81:25, Parameters.scala:91:48
      automatic logic            _GEN_6 = _source_ok_WIRE_1 & _GEN_5;	// Mux.scala:27:72, Parameters.scala:46:9, :91:48
      automatic logic            _GEN_7 = _source_ok_WIRE_4 & _GEN_5;	// Mux.scala:27:72, Parameters.scala:46:9, :91:48
      automatic logic            _GEN_8 = _source_ok_WIRE_7 & _GEN_5;	// Mux.scala:27:72, Parameters.scala:46:9, :91:48
      automatic logic            _GEN_9 =
        _source_ok_WIRE_0 | _source_ok_WIRE_1 | _source_ok_WIRE_2 | _source_ok_WIRE_3
        | _source_ok_WIRE_4 | _source_ok_WIRE_5 | _source_ok_WIRE_6 | _source_ok_WIRE_7
        | _source_ok_WIRE_8 | _source_ok_WIRE_9 | ~(|(io_in_a_bits_source[7:4]))
        & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE_11 | _source_ok_WIRE_12
        | io_in_a_bits_source[7:3] == 5'h4 & io_in_a_bits_source[2:0] < 3'h5
        | _source_ok_WIRE_14 | _source_ok_WIRE_15 | io_in_a_bits_source[7:2] == 6'hC
        & io_in_a_bits_source[1:0] != 2'h3 | _source_ok_WIRE_17 | _source_ok_WIRE_18
        | _source_ok_WIRE_19 | reset;	// Monitor.scala:42:11, :146:25, Parameters.scala:46:9, :52:64, :54:{10,32}, :56:50, :57:20
      automatic logic            _GEN_10 = _mask_T | reset;	// Misc.scala:205:21, Monitor.scala:42:11
      automatic logic [12:0]     _is_aligned_mask_T_1 = 13'h3F << io_in_a_bits_size;	// package.scala:234:77
      automatic logic            _GEN_11 =
        (io_in_a_bits_address[5:0] & ~(_is_aligned_mask_T_1[5:0])) == 6'h0 | reset;	// Edges.scala:20:{16,24}, Monitor.scala:42:11, package.scala:234:{46,77,82}
      automatic logic            _GEN_12 = io_in_a_bits_param < 3'h3 | reset;	// Bundles.scala:108:27, :145:30, Monitor.scala:42:11
      automatic logic            _GEN_13 = (&io_in_a_bits_mask) | reset;	// Monitor.scala:42:11, :88:31
      automatic logic            _GEN_14 = ~io_in_a_bits_corrupt | reset;	// Monitor.scala:42:11, :89:18
      automatic logic            _GEN_15 = io_in_a_valid & (&io_in_a_bits_opcode);	// Monitor.scala:92:{25,53}
      automatic logic            _GEN_16 = io_in_a_valid & io_in_a_bits_opcode == 3'h4;	// Monitor.scala:104:{25,45}, Parameters.scala:54:32
      automatic logic            _GEN_17 = ~(|io_in_a_bits_param) | reset;	// Monitor.scala:42:11, :99:31, :109:31
      automatic logic            _GEN_18 = io_in_a_bits_mask == mask | reset;	// Cat.scala:30:58, Monitor.scala:42:11, :110:30
      automatic logic            _GEN_19 = io_in_a_valid & io_in_a_bits_opcode == 3'h0;	// Monitor.scala:114:{25,53}, Parameters.scala:52:29
      automatic logic            _GEN_20 = io_in_a_valid & io_in_a_bits_opcode == 3'h1;	// Monitor.scala:122:{25,56}
      automatic logic            _GEN_21 = io_in_a_valid & io_in_a_bits_opcode == 3'h2;	// Monitor.scala:130:{25,56}, :640:42
      automatic logic            _GEN_22 = io_in_a_valid & io_in_a_bits_opcode == 3'h3;	// Bundles.scala:145:30, Monitor.scala:138:{25,53}
      automatic logic            _GEN_23 = io_in_a_valid & io_in_a_bits_opcode == 3'h5;	// Monitor.scala:146:{25,46}
      automatic logic            _GEN_24;	// Monitor.scala:389:19
      automatic logic            _GEN_25;	// Monitor.scala:541:19
      automatic logic [515:0]    _GEN_26 = {506'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:634:44
      automatic logic [515:0]    _a_opcode_lookup_T_1;	// Monitor.scala:634:44
      automatic logic            _GEN_27 = io_in_d_valid & d_first_1;	// Edges.scala:230:25, Monitor.scala:671:26
      automatic logic            same_cycle_resp =
        io_in_a_valid & a_first_1 & io_in_a_bits_source == io_in_d_bits_source;	// Edges.scala:230:25, Monitor.scala:681:{88,113}
      automatic logic            _GEN_28 = _GEN_27 & same_cycle_resp;	// Monitor.scala:671:26, :681:88, :684:30
      automatic logic            _GEN_29 = _GEN_27 & ~same_cycle_resp;	// Monitor.scala:671:26, :681:88, :684:30
      automatic logic [128:0]    _GEN_30;	// Monitor.scala:658:26
      automatic logic [128:0]    _GEN_31;	// Monitor.scala:682:25
      automatic logic [515:0]    _a_size_lookup_T_1;	// Monitor.scala:638:40
      _GEN_24 = io_in_a_valid & (|a_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:389:19
      _GEN_25 = io_in_d_valid & (|d_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:541:19
      _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_26;	// Monitor.scala:613:35, :634:44
      if (_GEN_2 & ~reset) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2
          & ~((_GEN_6 | _GEN_7 | _GEN_8 | ~(|(io_in_a_bits_source[7:4]))
               & io_in_a_bits_source[3:0] < 4'h9 & _GEN_5 | _GEN_3
               & io_in_a_bits_source[2:0] < 3'h5 & _GEN_5 | _GEN_4
               & io_in_a_bits_source[1:0] != 2'h3 & _GEN_5) & io_in_a_bits_address[16]
              | reset)) begin	// Monitor.scala:42:11, :81:54, :83:78, :146:25, Mux.scala:27:72, Parameters.scala:52:64, :54:{10,32}, :57:20, :91:48
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_9) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_10) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_11) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_12) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_13) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_2 & ~_GEN_14) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock is corrupt (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~reset) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15
          & ~((_GEN_6 | _GEN_7 | _GEN_8 | ~(|(io_in_a_bits_source[7:4]))
               & io_in_a_bits_source[3:0] < 4'h9 & _GEN_5 | _GEN_3
               & io_in_a_bits_source[2:0] < 3'h5 & _GEN_5 | _GEN_4
               & io_in_a_bits_source[1:0] != 2'h3 & _GEN_5) & io_in_a_bits_address[16]
              | reset)) begin	// Monitor.scala:42:11, :92:53, :94:78, :146:25, Mux.scala:27:72, Parameters.scala:52:64, :54:{10,32}, :57:20, :91:48
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_9) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_10) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_11) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_12) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~((|io_in_a_bits_param) | reset)) begin	// Monitor.scala:42:11, :92:53, :99:31
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_13) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_15 & ~_GEN_14) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm is corrupt (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16
          & ~(_source_ok_WIRE_0 | _source_ok_WIRE_1 | _source_ok_WIRE_2
              | _source_ok_WIRE_3 | _source_ok_WIRE_4 | _source_ok_WIRE_5
              | _source_ok_WIRE_6 | _source_ok_WIRE_7 | _source_ok_WIRE_8
              | _source_ok_WIRE_9 | ~(|(io_in_a_bits_source[7:4]))
              & io_in_a_bits_source[3:0] < 4'h9 | _source_ok_WIRE_11 | _source_ok_WIRE_12
              | _GEN_3 & io_in_a_bits_source[2:0] < 3'h5 | _source_ok_WIRE_14
              | _source_ok_WIRE_15 | _GEN_4 & io_in_a_bits_source[1:0] != 2'h3
              | _source_ok_WIRE_17 | _source_ok_WIRE_18 | _source_ok_WIRE_19
              | reset)) begin	// Monitor.scala:42:11, :104:45, :146:25, Parameters.scala:46:9, :52:64, :54:{10,32}, :56:50, :57:20
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~(io_in_a_bits_size != 3'h7 & io_in_a_bits_address[16] | reset)) begin	// Monitor.scala:42:11, :92:25, :104:45, Parameters.scala:92:42, :670:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_9) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_11) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_17) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_18) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_16 & ~_GEN_14) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get is corrupt (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~reset) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_9) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_11) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_17) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_19 & ~_GEN_18) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~reset) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_9) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_11) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~_GEN_17) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_20 & ~((io_in_a_bits_mask & ~mask) == 8'h0 | reset)) begin	// Cat.scala:30:58, Monitor.scala:42:11, :88:31, :122:56, :127:{31,33,40}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_21 & ~reset) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_21 & ~_GEN_9) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_21 & ~_GEN_11) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_21 & ~(io_in_a_bits_param < 3'h5 | reset)) begin	// Bundles.scala:138:33, Monitor.scala:42:11, :130:56, :146:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_21 & ~_GEN_18) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~reset) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~_GEN_9) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~_GEN_11) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~(~(io_in_a_bits_param[2]) | reset)) begin	// Bundles.scala:145:30, Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid opcode param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_22 & ~_GEN_18) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~reset) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~_GEN_9) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~_GEN_11) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint address not aligned to size (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~(io_in_a_bits_param < 3'h2 | reset)) begin	// Bundles.scala:158:28, Monitor.scala:42:11, :146:46, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid opcode param (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~_GEN_18) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint contains invalid mask (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_23 & ~_GEN_14) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint is corrupt (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid
          & ~(io_in_d_bits_source == 8'h44 | io_in_d_bits_source == 8'h40
              | io_in_d_bits_source == 8'h41 | io_in_d_bits_source == 8'h42
              | io_in_d_bits_source == 8'h3C | io_in_d_bits_source == 8'h3D
              | io_in_d_bits_source == 8'h3E | io_in_d_bits_source == 8'h38
              | io_in_d_bits_source == 8'h39 | io_in_d_bits_source == 8'h3A
              | io_in_d_bits_source[7:4] == 4'h0 & io_in_d_bits_source[3:0] < 4'h9
              | io_in_d_bits_source == 8'h9 | io_in_d_bits_source == 8'h10
              | io_in_d_bits_source[7:3] == 5'h4 & io_in_d_bits_source[2:0] < 3'h5
              | io_in_d_bits_source == 8'h25 | io_in_d_bits_source == 8'h28
              | io_in_d_bits_source[7:2] == 6'hC & io_in_d_bits_source[1:0] != 2'h3
              | io_in_d_bits_source == 8'h33 | io_in_d_bits_source == 8'h34
              | io_in_d_bits_source == 8'h80 | reset)) begin	// Monitor.scala:49:11, :146:25, Parameters.scala:46:9, :52:{29,64}, :54:{10,32}, :56:50, :57:20
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_24 & ~(io_in_a_bits_opcode == opcode | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_24 & ~(io_in_a_bits_param == param | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_24 & ~(io_in_a_bits_size == size | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_24 & ~(io_in_a_bits_source == source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_24 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_25 & ~(opcode_1 == 3'h1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~(param_1 == 2'h0 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~(io_in_d_bits_source == source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~(~sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_25 & ~(~denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _GEN_30 = inflight >> io_in_a_bits_source;	// Monitor.scala:611:27, :658:26
      if (_GEN & ~(~(_GEN_30[0]) | reset)) begin	// Monitor.scala:42:11, :652:27, :658:{17,26}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_31 = inflight >> io_in_d_bits_source;	// Monitor.scala:611:27, :682:25
      if (_GEN_27 & ~(_GEN_31[0] | same_cycle_resp | reset)) begin	// Monitor.scala:49:11, :671:26, :681:88, :682:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_28
          & ~(_GEN_1[io_in_a_bits_opcode] == 3'h1 | _GEN_0[io_in_a_bits_opcode] == 3'h1
              | reset)) begin	// Monitor.scala:49:11, :684:30, :685:38, :686:39
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_28 & ~(io_in_a_bits_size == io_in_d_bits_size | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_29
          & ~(_GEN_1[_a_opcode_lookup_T_1[3:1]] == 3'h1
              | _GEN_0[_a_opcode_lookup_T_1[3:1]] == 3'h1 | reset)) begin	// Monitor.scala:42:11, :49:11, :634:{44,152}, :684:30, :685:38, :686:39, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _a_size_lookup_T_1 = inflight_sizes >> _GEN_26;	// Monitor.scala:615:33, :634:44, :638:40
      if (_GEN_29 & ~(io_in_d_bits_size == _a_size_lookup_T_1[3:1] | reset)) begin	// Monitor.scala:42:11, :49:11, :638:{40,144}, :684:30, :691:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at BootROM.scala:84:68)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_27 & a_first_1 & io_in_a_valid & io_in_a_bits_source == io_in_d_bits_source
          & ~(~io_in_d_ready | io_in_a_ready | reset)) begin	// Edges.scala:230:25, Monitor.scala:49:11, :671:26, :694:90, :695:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(inflight == 129'h0 | _plusarg_reader_out == 32'h0
            | watchdog < _plusarg_reader_out | reset)) begin	// Monitor.scala:42:11, :611:27, :706:27, :709:{26,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at BootROM.scala:84:68)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic _d_first_T_2;	// Decoupled.scala:40:37
    automatic logic _GEN_32;	// Monitor.scala:549:20
    _d_first_T_2 = io_in_d_ready & io_in_d_valid;	// Decoupled.scala:40:37
    _GEN_32 = _d_first_T_2 & ~(|d_first_counter);	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:549:20
    if (reset) begin
      a_first_counter <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
      d_first_counter <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
      inflight <= 129'h0;	// Monitor.scala:611:27
      inflight_opcodes <= 516'h0;	// Monitor.scala:613:35
      inflight_sizes <= 516'h0;	// Monitor.scala:613:35, :615:33
      a_first_counter_1 <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
      d_first_counter_1 <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
      watchdog <= 32'h0;	// Monitor.scala:706:27
      watchdog_1 <= 32'h0;	// Monitor.scala:706:27, :813:27
    end
    else begin
      automatic logic [2050:0] _GEN_33 = {2041'h0, io_in_a_bits_source, 2'h0};	// Monitor.scala:656:54
      automatic logic          _GEN_34;	// Monitor.scala:675:27
      automatic logic [2062:0] _GEN_35 = {2053'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:677:76
      automatic logic [255:0]  _d_clr_T = 256'h1 << io_in_d_bits_source;	// OneHot.scala:58:35
      automatic logic [255:0]  _a_set_T = 256'h1 << io_in_a_bits_source;	// OneHot.scala:58:35
      automatic logic [2062:0] _d_opcodes_clr_T_5 = 2063'hF << _GEN_35;	// Monitor.scala:677:76
      automatic logic [2050:0] _a_opcodes_set_T_1 =
        {2047'h0, _GEN ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << _GEN_33;	// Monitor.scala:49:11, :346:25, :652:{27,72}, :654:{28,61}, :656:54, :671:74, Parameters.scala:52:29
      automatic logic [2062:0] _d_sizes_clr_T_5 = 2063'hF << _GEN_35;	// Monitor.scala:677:76, :678:74
      automatic logic [2050:0] _a_sizes_set_T_1 =
        {2047'h0, _GEN ? {io_in_a_bits_size, 1'h1} : 4'h0} << _GEN_33;	// Monitor.scala:49:11, :346:25, :652:{27,72}, :655:{28,59}, :656:54, :657:52, :671:74, Parameters.scala:52:29
      _GEN_34 = _d_first_T_2 & d_first_1;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:675:27
      if (a_first_done) begin	// Decoupled.scala:40:37
        if (|a_first_counter)	// Edges.scala:228:27, :230:25
          a_first_counter <= a_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else	// Edges.scala:230:25
          a_first_counter <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
        if (a_first_1)	// Edges.scala:230:25
          a_first_counter_1 <= 3'h0;	// Edges.scala:228:27, Parameters.scala:52:29
        else	// Edges.scala:230:25
          a_first_counter_1 <= a_first_counter_1 - 3'h1;	// Edges.scala:228:27, :229:28
      end
      if (_d_first_T_2) begin	// Decoupled.scala:40:37
        automatic logic [12:0] _GEN_36;	// package.scala:234:77
        _GEN_36 = {10'h0, io_in_d_bits_size};	// package.scala:234:77
        if (|d_first_counter)	// Edges.scala:228:27, :230:25
          d_first_counter <= d_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else begin	// Edges.scala:230:25
          automatic logic [12:0] _d_first_beats1_decode_T_1;	// package.scala:234:77
          _d_first_beats1_decode_T_1 = 13'h3F << _GEN_36;	// package.scala:234:77
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        if (d_first_1) begin	// Edges.scala:230:25
          automatic logic [12:0] _d_first_beats1_decode_T_5;	// package.scala:234:77
          _d_first_beats1_decode_T_5 = 13'h3F << _GEN_36;	// package.scala:234:77
          d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:230:25
          d_first_counter_1 <= d_first_counter_1 - 3'h1;	// Edges.scala:228:27, :229:28
        watchdog_1 <= 32'h0;	// Monitor.scala:706:27, :813:27
      end
      else	// Decoupled.scala:40:37
        watchdog_1 <= watchdog_1 + 32'h1;	// Monitor.scala:711:26, :813:27, :818:26
      inflight <=
        (inflight | (_GEN ? _a_set_T[128:0] : 129'h0))
        & ~(_GEN_34 ? _d_clr_T[128:0] : 129'h0);	// Monitor.scala:611:27, :652:{27,72}, :653:28, :675:{27,91}, :676:21, :702:{27,36,38}, OneHot.scala:58:35
      inflight_opcodes <=
        (inflight_opcodes | (_GEN ? _a_opcodes_set_T_1[515:0] : 516'h0))
        & ~(_GEN_34 ? _d_opcodes_clr_T_5[515:0] : 516'h0);	// Monitor.scala:613:35, :652:{27,72}, :656:{28,54}, :675:{27,91}, :677:{21,76}, :703:{43,60,62}
      inflight_sizes <=
        (inflight_sizes | (_GEN ? _a_sizes_set_T_1[515:0] : 516'h0))
        & ~(_GEN_34 ? _d_sizes_clr_T_5[515:0] : 516'h0);	// Monitor.scala:613:35, :615:33, :652:{27,72}, :657:{28,52}, :675:{27,91}, :678:{21,74}, :704:{39,54,56}
      if (a_first_done | _d_first_T_2)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
    end
    if (a_first_done & ~(|a_first_counter)) begin	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:396:20
      opcode <= io_in_a_bits_opcode;	// Monitor.scala:384:22
      param <= io_in_a_bits_param;	// Monitor.scala:385:22
      size <= io_in_a_bits_size;	// Monitor.scala:386:22
      source <= io_in_a_bits_source;	// Monitor.scala:387:22
      address <= io_in_a_bits_address;	// Monitor.scala:388:22
    end
    if (_GEN_32) begin	// Monitor.scala:549:20
      opcode_1 <= 3'h1;	// Monitor.scala:535:22
      param_1 <= 2'h0;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      source_1 <= io_in_d_bits_source;	// Monitor.scala:538:22
    end
    sink <= ~_GEN_32 & sink;	// Monitor.scala:539:22, :549:{20,32}, :554:15
    denied <= ~_GEN_32 & denied;	// Monitor.scala:539:22, :540:22, :549:{20,32}, :554:15, :555:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:76];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h4D; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        a_first_counter = _RANDOM[7'h0][2:0];	// Edges.scala:228:27
        opcode = _RANDOM[7'h0][5:3];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[7'h0][8:6];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[7'h0][11:9];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[7'h0][19:12];	// Edges.scala:228:27, Monitor.scala:387:22
        address = {_RANDOM[7'h0][31:20], _RANDOM[7'h1][4:0]};	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[7'h1][7:5];	// Edges.scala:228:27, Monitor.scala:388:22
        opcode_1 = _RANDOM[7'h1][10:8];	// Monitor.scala:388:22, :535:22
        param_1 = _RANDOM[7'h1][12:11];	// Monitor.scala:388:22, :536:22
        size_1 = _RANDOM[7'h1][15:13];	// Monitor.scala:388:22, :537:22
        source_1 = _RANDOM[7'h1][23:16];	// Monitor.scala:388:22, :538:22
        sink = _RANDOM[7'h1][24];	// Monitor.scala:388:22, :539:22
        denied = _RANDOM[7'h1][25];	// Monitor.scala:388:22, :540:22
        inflight =
          {_RANDOM[7'h1][31:26],
           _RANDOM[7'h2],
           _RANDOM[7'h3],
           _RANDOM[7'h4],
           _RANDOM[7'h5][26:0]};	// Monitor.scala:388:22, :611:27
        inflight_opcodes =
          {_RANDOM[7'h5][31:27],
           _RANDOM[7'h6],
           _RANDOM[7'h7],
           _RANDOM[7'h8],
           _RANDOM[7'h9],
           _RANDOM[7'hA],
           _RANDOM[7'hB],
           _RANDOM[7'hC],
           _RANDOM[7'hD],
           _RANDOM[7'hE],
           _RANDOM[7'hF],
           _RANDOM[7'h10],
           _RANDOM[7'h11],
           _RANDOM[7'h12],
           _RANDOM[7'h13],
           _RANDOM[7'h14],
           _RANDOM[7'h15][30:0]};	// Monitor.scala:611:27, :613:35
        inflight_sizes =
          {_RANDOM[7'h15][31],
           _RANDOM[7'h16],
           _RANDOM[7'h17],
           _RANDOM[7'h18],
           _RANDOM[7'h19],
           _RANDOM[7'h1A],
           _RANDOM[7'h1B],
           _RANDOM[7'h1C],
           _RANDOM[7'h1D],
           _RANDOM[7'h1E],
           _RANDOM[7'h1F],
           _RANDOM[7'h20],
           _RANDOM[7'h21],
           _RANDOM[7'h22],
           _RANDOM[7'h23],
           _RANDOM[7'h24],
           _RANDOM[7'h25],
           _RANDOM[7'h26][2:0]};	// Monitor.scala:613:35, :615:33
        a_first_counter_1 = _RANDOM[7'h26][5:3];	// Edges.scala:228:27, Monitor.scala:615:33
        d_first_counter_1 = _RANDOM[7'h26][8:6];	// Edges.scala:228:27, Monitor.scala:615:33
        watchdog = {_RANDOM[7'h26][31:9], _RANDOM[7'h27][8:0]};	// Monitor.scala:615:33, :706:27
        watchdog_1 = {_RANDOM[7'h4B][31:24], _RANDOM[7'h4C][23:0]};	// Monitor.scala:813:27
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
    .out (/* unused */)
  );
endmodule

