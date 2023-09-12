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

module TLMonitor_48(
  input        clock,
               reset,
               io_in_a_ready,
               io_in_a_valid,
  input [2:0]  io_in_a_bits_opcode,
               io_in_a_bits_param,
               io_in_a_bits_size,
               io_in_a_bits_source,
  input [31:0] io_in_a_bits_address,
  input [7:0]  io_in_a_bits_mask,
  input        io_in_a_bits_corrupt,
               io_in_c_ready,
               io_in_c_valid,
  input [2:0]  io_in_c_bits_opcode,
               io_in_c_bits_param,
               io_in_c_bits_size,
               io_in_c_bits_source,
  input [31:0] io_in_c_bits_address,
  input        io_in_c_bits_corrupt,
               io_in_d_ready,
               io_in_d_valid,
  input [2:0]  io_in_d_bits_opcode,
  input [1:0]  io_in_d_bits_param,
  input [2:0]  io_in_d_bits_size,
               io_in_d_bits_source,
               io_in_d_bits_sink,
  input        io_in_d_bits_denied,
               io_in_d_bits_corrupt,
               io_in_e_valid,
  input [2:0]  io_in_e_bits_sink
);

  wire [31:0] _plusarg_reader_1_out;	// PlusArg.scala:80:11
  wire [31:0] _plusarg_reader_out;	// PlusArg.scala:80:11
  wire [12:0] _GEN = {10'h0, io_in_a_bits_size};	// package.scala:234:77
  wire [12:0] _GEN_0 = {10'h0, io_in_c_bits_size};	// package.scala:234:77
  wire        _a_first_T_1 = io_in_a_ready & io_in_a_valid;	// Decoupled.scala:40:37
  reg  [2:0]  a_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode;	// Monitor.scala:384:22
  reg  [2:0]  param;	// Monitor.scala:385:22
  reg  [2:0]  size;	// Monitor.scala:386:22
  reg  [2:0]  source;	// Monitor.scala:387:22
  reg  [31:0] address;	// Monitor.scala:388:22
  wire        _d_first_T_3 = io_in_d_ready & io_in_d_valid;	// Decoupled.scala:40:37
  reg  [2:0]  d_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode_1;	// Monitor.scala:535:22
  reg  [1:0]  param_1;	// Monitor.scala:536:22
  reg  [2:0]  size_1;	// Monitor.scala:537:22
  reg  [2:0]  source_1;	// Monitor.scala:538:22
  reg  [2:0]  sink;	// Monitor.scala:539:22
  reg         denied;	// Monitor.scala:540:22
  wire        _c_first_T_1 = io_in_c_ready & io_in_c_valid;	// Decoupled.scala:40:37
  reg  [2:0]  c_first_counter;	// Edges.scala:228:27
  reg  [2:0]  opcode_3;	// Monitor.scala:512:22
  reg  [2:0]  param_3;	// Monitor.scala:513:22
  reg  [2:0]  size_3;	// Monitor.scala:514:22
  reg  [2:0]  source_3;	// Monitor.scala:515:22
  reg  [31:0] address_2;	// Monitor.scala:516:22
  reg  [4:0]  inflight;	// Monitor.scala:611:27
  reg  [19:0] inflight_opcodes;	// Monitor.scala:613:35
  reg  [19:0] inflight_sizes;	// Monitor.scala:615:33
  reg  [2:0]  a_first_counter_1;	// Edges.scala:228:27
  wire        a_first_1 = a_first_counter_1 == 3'h0;	// Edges.scala:228:27, :230:25
  reg  [2:0]  d_first_counter_1;	// Edges.scala:228:27
  wire        d_first_1 = d_first_counter_1 == 3'h0;	// Edges.scala:228:27, :230:25
  wire [7:0]  _GEN_1 = {5'h0, io_in_a_bits_source};	// Monitor.scala:611:27, OneHot.scala:58:35
  wire        _GEN_2 = _a_first_T_1 & a_first_1;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:652:27
  wire        d_release_ack = io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :670:46
  wire [7:0]  _GEN_3 = {5'h0, io_in_d_bits_source};	// Monitor.scala:611:27, OneHot.scala:58:35
  reg  [31:0] watchdog;	// Monitor.scala:706:27
  reg  [4:0]  inflight_1;	// Monitor.scala:723:35
  reg  [19:0] inflight_sizes_1;	// Monitor.scala:725:35
  reg  [2:0]  c_first_counter_1;	// Edges.scala:228:27
  wire        c_first_1 = c_first_counter_1 == 3'h0;	// Edges.scala:228:27, :230:25
  reg  [2:0]  d_first_counter_2;	// Edges.scala:228:27
  wire        d_first_2 = d_first_counter_2 == 3'h0;	// Edges.scala:228:27, :230:25
  wire        _GEN_4 = io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1];	// Edges.scala:67:{36,40,51}
  wire [7:0]  _GEN_5 = {5'h0, io_in_c_bits_source};	// Monitor.scala:611:27, OneHot.scala:58:35
  wire        _GEN_6 = _c_first_T_1 & c_first_1 & _GEN_4;	// Decoupled.scala:40:37, Edges.scala:67:40, :230:25, Monitor.scala:760:38
  reg  [31:0] watchdog_1;	// Monitor.scala:813:27
  reg  [7:0]  inflight_2;	// Monitor.scala:823:27
  reg  [2:0]  d_first_counter_3;	// Edges.scala:228:27
  wire        d_first_3 = d_first_counter_3 == 3'h0;	// Edges.scala:228:27, :230:25
  wire        _GEN_7 =
    _d_first_T_3 & d_first_3 & io_in_d_bits_opcode[2] & ~(io_in_d_bits_opcode[1]);	// Decoupled.scala:40:37, Edges.scala:70:{36,43,52}, :230:25, Monitor.scala:829:38
  wire [7:0]  _GEN_8 = {5'h0, io_in_d_bits_sink};	// Monitor.scala:611:27, OneHot.scala:58:35
  wire [7:0]  d_set = _GEN_7 ? 8'h1 << _GEN_8 : 8'h0;	// Monitor.scala:823:27, :829:{38,72}, :830:13, OneHot.scala:58:35
  wire [7:0]  _GEN_9 = {5'h0, io_in_e_bits_sink};	// Monitor.scala:611:27, OneHot.scala:58:35
  `ifndef SYNTHESIS	// Monitor.scala:42:11
    always @(posedge clock) begin	// Monitor.scala:42:11
      automatic logic [7:0][2:0] _GEN_10 =
        {3'h4, 3'h5, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:686:39
      automatic logic [7:0][2:0] _GEN_11 =
        {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Monitor.scala:685:38
      automatic logic            _mask_T = io_in_a_bits_size > 3'h2;	// Misc.scala:205:21, Monitor.scala:640:42
      automatic logic            mask_size = io_in_a_bits_size[1:0] == 2'h2;	// Bundles.scala:108:27, Misc.scala:208:26, OneHot.scala:64:49
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
      automatic logic            _GEN_12 = io_in_a_valid & io_in_a_bits_opcode == 3'h6;	// Monitor.scala:81:{25,54}
      automatic logic            _GEN_13 = io_in_a_bits_source < 3'h5;	// Monitor.scala:146:25, Parameters.scala:57:20
      automatic logic            _GEN_14 = io_in_a_bits_size != 3'h7;	// Monitor.scala:92:25, Parameters.scala:92:42
      automatic logic            _GEN_15 =
        {io_in_a_bits_address[31:29], io_in_a_bits_address[28:12] ^ 17'h10000} == 20'h0;	// Monitor.scala:613:35, Parameters.scala:137:{31,49,52,67}
      automatic logic            _GEN_16 = io_in_a_bits_address[31:28] == 4'h8;	// Parameters.scala:137:{49,52,67}
      automatic logic            _GEN_17 =
        {io_in_a_bits_address[31:18], io_in_a_bits_address[17:16] ^ 2'h2} == 16'h0
        | _GEN_15 | _GEN_16;	// Bundles.scala:108:27, Parameters.scala:137:{31,49,52,67}, :671:42
      automatic logic            _GEN_18 = _GEN_14 & _GEN_17;	// Parameters.scala:92:42, :670:56, :671:42
      automatic logic            _GEN_19 = _GEN_13 & _GEN_18 | reset;	// Monitor.scala:42:11, :82:72, Parameters.scala:57:20, :670:56
      automatic logic            _GEN_20 = io_in_a_bits_size == 3'h6 & _GEN_17 | reset;	// Monitor.scala:42:11, :81:25, :83:78, Parameters.scala:91:48, :671:42
      automatic logic            _GEN_21 = io_in_a_bits_source < 3'h5 | reset;	// Monitor.scala:42:11, :146:25, Parameters.scala:57:20
      automatic logic            _GEN_22 = _mask_T | reset;	// Misc.scala:205:21, Monitor.scala:42:11
      automatic logic [12:0]     _is_aligned_mask_T_1 = 13'h3F << _GEN;	// package.scala:234:77
      automatic logic            _GEN_23 =
        (io_in_a_bits_address[5:0] & ~(_is_aligned_mask_T_1[5:0])) == 6'h0 | reset;	// Edges.scala:20:{16,24}, Monitor.scala:42:11, package.scala:234:{46,77,82}
      automatic logic            _GEN_24 = io_in_a_bits_param < 3'h3 | reset;	// Bundles.scala:108:27, :145:30, Monitor.scala:42:11
      automatic logic            _GEN_25 = (&io_in_a_bits_mask) | reset;	// Monitor.scala:42:11, :88:31
      automatic logic            _GEN_26 = ~io_in_a_bits_corrupt | reset;	// Monitor.scala:42:11, :89:18
      automatic logic            _GEN_27 = io_in_a_valid & (&io_in_a_bits_opcode);	// Monitor.scala:92:{25,53}
      automatic logic            _GEN_28 = io_in_a_valid & io_in_a_bits_opcode == 3'h4;	// Monitor.scala:104:{25,45}, Parameters.scala:57:20
      automatic logic            _GEN_29 = ~(|io_in_a_bits_param) | reset;	// Monitor.scala:42:11, :99:31, :109:31
      automatic logic            _GEN_30 = io_in_a_bits_mask == mask | reset;	// Cat.scala:30:58, Monitor.scala:42:11, :110:30
      automatic logic            _GEN_31 = io_in_a_valid & io_in_a_bits_opcode == 3'h0;	// Monitor.scala:114:{25,53}
      automatic logic            _GEN_32 =
        _GEN_13 & _GEN_14 & (_GEN_15 | _GEN_16) | reset;	// Monitor.scala:42:11, :115:71, Parameters.scala:57:20, :92:42, :137:{49,52,67}, :671:42
      automatic logic            _GEN_33 = io_in_a_valid & io_in_a_bits_opcode == 3'h1;	// Monitor.scala:122:{25,56}, :640:42
      automatic logic            _GEN_34 = io_in_a_valid & io_in_a_bits_opcode == 3'h2;	// Monitor.scala:130:{25,56}, :640:42
      automatic logic            _GEN_35 = io_in_a_valid & io_in_a_bits_opcode == 3'h3;	// Bundles.scala:145:30, Monitor.scala:138:{25,53}
      automatic logic            _GEN_36 = io_in_a_valid & io_in_a_bits_opcode == 3'h5;	// Monitor.scala:146:{25,46}
      automatic logic            _GEN_37 = io_in_d_valid & io_in_d_bits_opcode == 3'h6;	// Monitor.scala:81:25, :310:{25,52}
      automatic logic            _GEN_38 = io_in_d_bits_source < 3'h5 | reset;	// Monitor.scala:49:11, :146:25, Parameters.scala:57:20
      automatic logic            _GEN_39 = io_in_d_bits_size > 3'h2 | reset;	// Monitor.scala:49:11, :312:27, :640:42
      automatic logic            _GEN_40 = io_in_d_bits_param == 2'h0 | reset;	// Monitor.scala:49:11, :313:28, OneHot.scala:65:12
      automatic logic            _GEN_41 = ~io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :314:15
      automatic logic            _GEN_42 = io_in_d_valid & io_in_d_bits_opcode == 3'h4;	// Monitor.scala:318:{25,47}, Parameters.scala:57:20
      automatic logic            _GEN_43 = io_in_d_bits_param != 2'h3 | reset;	// Bundles.scala:102:26, Monitor.scala:49:11
      automatic logic            _GEN_44 = io_in_d_bits_param != 2'h2 | reset;	// Bundles.scala:108:27, Monitor.scala:49:11, :323:28
      automatic logic            _GEN_45 = io_in_d_valid & io_in_d_bits_opcode == 3'h5;	// Monitor.scala:146:25, :328:{25,51}
      automatic logic            _GEN_46 =
        ~io_in_d_bits_denied | io_in_d_bits_corrupt | reset;	// Monitor.scala:49:11, :315:15
      automatic logic            _GEN_47 = io_in_d_valid & io_in_d_bits_opcode == 3'h0;	// Monitor.scala:338:{25,51}
      automatic logic            _GEN_48 = io_in_d_valid & io_in_d_bits_opcode == 3'h1;	// Monitor.scala:346:{25,55}, :640:42
      automatic logic            _GEN_49 = io_in_d_valid & io_in_d_bits_opcode == 3'h2;	// Monitor.scala:354:{25,49}, :640:42
      automatic logic            _GEN_50 = io_in_c_bits_address[31:28] != 4'h8;	// Parameters.scala:137:{49,52,67}
      automatic logic [19:0]     _GEN_51 =
        {io_in_c_bits_address[31:29], io_in_c_bits_address[28:12] ^ 17'h10000};	// Parameters.scala:137:{31,49,52}
      automatic logic [15:0]     _GEN_52 =
        {io_in_c_bits_address[31:18], io_in_c_bits_address[17:16] ^ 2'h2};	// Bundles.scala:108:27, Parameters.scala:137:{31,49,52}
      automatic logic            _GEN_53 = io_in_c_valid & io_in_c_bits_opcode == 3'h4;	// Monitor.scala:242:{25,50}, Parameters.scala:57:20
      automatic logic            _GEN_54 = ~_GEN_50 | ~(|_GEN_51) | ~(|_GEN_52) | reset;	// Monitor.scala:42:11, Parameters.scala:137:{49,52,67}
      automatic logic            _GEN_55 = io_in_c_bits_source < 3'h5 | reset;	// Monitor.scala:42:11, :146:25, Parameters.scala:57:20
      automatic logic            _GEN_56 = io_in_c_bits_size > 3'h2 | reset;	// Monitor.scala:42:11, :245:30, :640:42
      automatic logic [12:0]     _is_aligned_mask_T_7 = 13'h3F << _GEN_0;	// package.scala:234:77
      automatic logic            _GEN_57 =
        (io_in_c_bits_address[5:0] & ~(_is_aligned_mask_T_7[5:0])) == 6'h0 | reset;	// Edges.scala:20:{16,24}, Monitor.scala:42:11, package.scala:234:{46,77,82}
      automatic logic            _GEN_58 = io_in_c_bits_param[2:1] != 2'h3 | reset;	// Bundles.scala:102:26, :120:29, Monitor.scala:42:11
      automatic logic            _GEN_59 = ~io_in_c_bits_corrupt | reset;	// Monitor.scala:42:11, :248:18
      automatic logic            _GEN_60 = io_in_c_valid & io_in_c_bits_opcode == 3'h5;	// Monitor.scala:146:25, :251:{25,54}
      automatic logic            _GEN_61 = io_in_c_valid & io_in_c_bits_opcode == 3'h6;	// Monitor.scala:81:25, :259:{25,49}
      automatic logic            _GEN_62 = ~(|_GEN_52) | ~(|_GEN_51) | ~_GEN_50;	// Parameters.scala:137:{49,52,67}, :671:42
      automatic logic            _GEN_63 =
        io_in_c_bits_source < 3'h5 & io_in_c_bits_size != 3'h7 & _GEN_62 | reset;	// Monitor.scala:42:11, :92:25, :146:25, :260:78, Parameters.scala:57:20, :92:42, :671:42
      automatic logic            _GEN_64 = io_in_c_bits_size == 3'h6 & _GEN_62 | reset;	// Monitor.scala:42:11, :81:25, :261:78, Parameters.scala:91:48, :671:42
      automatic logic            _GEN_65 = io_in_c_valid & (&io_in_c_bits_opcode);	// Monitor.scala:269:{25,53}
      automatic logic            _GEN_66 = io_in_c_valid & io_in_c_bits_opcode == 3'h0;	// Monitor.scala:278:{25,51}
      automatic logic            _GEN_67 = io_in_c_bits_param == 3'h0 | reset;	// Monitor.scala:42:11, :282:31
      automatic logic            _GEN_68 = io_in_c_valid & io_in_c_bits_opcode == 3'h1;	// Monitor.scala:286:{25,55}, :640:42
      automatic logic            _GEN_69 = io_in_c_valid & io_in_c_bits_opcode == 3'h2;	// Monitor.scala:293:{25,49}, :640:42
      automatic logic            _GEN_70;	// Monitor.scala:389:19
      automatic logic            _GEN_71;	// Monitor.scala:541:19
      automatic logic            _GEN_72;	// Monitor.scala:517:19
      automatic logic [19:0]     _GEN_73 = {15'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:634:44, OneHot.scala:65:12
      automatic logic [19:0]     _a_opcode_lookup_T_1;	// Monitor.scala:634:44
      automatic logic            _same_cycle_resp_T_1 = io_in_a_valid & a_first_1;	// Edges.scala:230:25, Monitor.scala:648:26
      automatic logic [7:0]      _a_set_wo_ready_T = 8'h1 << _GEN_1;	// OneHot.scala:58:35
      automatic logic [4:0]      a_set_wo_ready =
        _same_cycle_resp_T_1 ? _a_set_wo_ready_T[4:0] : 5'h0;	// Monitor.scala:611:27, :648:{26,71}, :649:22, OneHot.scala:58:35
      automatic logic            _GEN_74 = io_in_d_valid & d_first_1;	// Edges.scala:230:25, Monitor.scala:671:26
      automatic logic            _GEN_75 = _GEN_74 & ~d_release_ack;	// Monitor.scala:670:46, :671:{26,71,74}
      automatic logic            same_cycle_resp =
        _same_cycle_resp_T_1 & io_in_a_bits_source == io_in_d_bits_source;	// Monitor.scala:648:26, :681:{88,113}
      automatic logic [4:0]      _GEN_76 = {2'h0, io_in_d_bits_source};	// Monitor.scala:682:25, OneHot.scala:65:12
      automatic logic            _GEN_77 = _GEN_75 & same_cycle_resp;	// Monitor.scala:671:71, :681:88, :684:30
      automatic logic            _GEN_78 = _GEN_75 & ~same_cycle_resp;	// Monitor.scala:671:71, :681:88, :684:30
      automatic logic            _same_cycle_resp_T_3 = io_in_c_valid & c_first_1;	// Edges.scala:230:25, Monitor.scala:756:26
      automatic logic [7:0]      _c_set_wo_ready_T = 8'h1 << _GEN_5;	// OneHot.scala:58:35
      automatic logic [4:0]      c_set_wo_ready =
        _same_cycle_resp_T_3 & _GEN_4 ? _c_set_wo_ready_T[4:0] : 5'h0;	// Edges.scala:67:40, Monitor.scala:611:27, :756:{26,37,71}, :757:22, OneHot.scala:58:35
      automatic logic            _GEN_79 = io_in_d_valid & d_first_2;	// Edges.scala:230:25, Monitor.scala:779:26
      automatic logic            _GEN_80 = _GEN_79 & d_release_ack;	// Monitor.scala:670:46, :779:{26,71}
      automatic logic            same_cycle_resp_1 =
        _same_cycle_resp_T_3 & io_in_c_bits_opcode[2] & io_in_c_bits_opcode[1]
        & io_in_c_bits_source == io_in_d_bits_source;	// Edges.scala:67:{36,51}, Monitor.scala:756:26, :790:{88,113}
      automatic logic [4:0]      _GEN_81;	// Monitor.scala:658:26
      automatic logic [4:0]      _GEN_82;	// Monitor.scala:682:25
      automatic logic [19:0]     _a_size_lookup_T_1;	// Monitor.scala:638:40
      automatic logic [7:0]      _d_clr_wo_ready_T = 8'h1 << _GEN_3;	// OneHot.scala:58:35
      automatic logic [4:0]      _GEN_83;	// Monitor.scala:766:26
      automatic logic [4:0]      _GEN_84;	// Monitor.scala:791:25
      automatic logic [19:0]     _c_size_lookup_T_1;	// Monitor.scala:747:42
      automatic logic [7:0]      _d_clr_wo_ready_T_1 = 8'h1 << _GEN_3;	// OneHot.scala:58:35
      automatic logic [7:0]      _GEN_85;	// Monitor.scala:831:23
      automatic logic [7:0]      _GEN_86;	// Monitor.scala:837:35
      _GEN_70 = io_in_a_valid & (|a_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:389:19
      _GEN_71 = io_in_d_valid & (|d_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:541:19
      _GEN_72 = io_in_c_valid & (|c_first_counter);	// Edges.scala:228:27, :230:25, Monitor.scala:517:19
      _a_opcode_lookup_T_1 = inflight_opcodes >> _GEN_73;	// Monitor.scala:613:35, :634:44
      if (_GEN_12 & ~_GEN_19) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_20) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_21) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_22) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_23) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_24) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_25) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_12 & ~_GEN_26) begin	// Monitor.scala:42:11, :81:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquireBlock is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_19) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_20) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_21) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_22) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_23) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_24) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~((|io_in_a_bits_param) | reset)) begin	// Monitor.scala:42:11, :92:53, :99:31
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_25) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_27 & ~_GEN_26) begin	// Monitor.scala:42:11, :92:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel AcquirePerm is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~(_GEN_13 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:57:20
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~(_GEN_18 | reset)) begin	// Monitor.scala:42:11, :104:45, Parameters.scala:670:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~_GEN_21) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~_GEN_23) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~_GEN_29) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~_GEN_30) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_28 & ~_GEN_26) begin	// Monitor.scala:42:11, :104:45
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Get is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_31 & ~_GEN_32) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_31 & ~_GEN_21) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_31 & ~_GEN_23) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_31 & ~_GEN_29) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_31 & ~_GEN_30) begin	// Monitor.scala:42:11, :114:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutFull contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_33 & ~_GEN_32) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_33 & ~_GEN_21) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_33 & ~_GEN_23) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_33 & ~_GEN_29) begin	// Monitor.scala:42:11, :122:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_33 & ~((io_in_a_bits_mask & ~mask) == 8'h0 | reset)) begin	// Cat.scala:30:58, Monitor.scala:42:11, :122:56, :127:{31,33,40}, :823:27
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel PutPartial contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~reset) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~_GEN_21) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~_GEN_23) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~(io_in_a_bits_param < 3'h5 | reset)) begin	// Bundles.scala:138:33, Monitor.scala:42:11, :130:56, :146:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_34 & ~_GEN_30) begin	// Monitor.scala:42:11, :130:56
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_35 & ~reset) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_35 & ~_GEN_21) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_35 & ~_GEN_23) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_35 & ~(~(io_in_a_bits_param[2]) | reset)) begin	// Bundles.scala:145:30, Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical carries invalid opcode param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_35 & ~_GEN_30) begin	// Monitor.scala:42:11, :138:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Logical contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~reset) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~_GEN_21) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~_GEN_23) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~(io_in_a_bits_param < 3'h2 | reset)) begin	// Bundles.scala:158:28, Monitor.scala:42:11, :146:46, :640:42
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint carries invalid opcode param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~_GEN_30) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint contains invalid mask (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_36 & ~_GEN_26) begin	// Monitor.scala:42:11, :146:46
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel Hint is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (io_in_d_valid & ~(io_in_d_bits_opcode != 3'h7 | reset)) begin	// Bundles.scala:42:24, Monitor.scala:49:11, :92:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel has invalid opcode (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_37 & ~_GEN_38) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_37 & ~_GEN_39) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_37 & ~_GEN_40) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseeAck carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_37 & ~_GEN_41) begin	// Monitor.scala:49:11, :310:52
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_37 & ~(~io_in_d_bits_denied | reset)) begin	// Monitor.scala:49:11, :310:52, :315:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel ReleaseAck is denied (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_42 & ~_GEN_38) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_42 & ~_GEN_39) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_42 & ~_GEN_43) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries invalid cap param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_42 & ~_GEN_44) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant carries toN param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_42 & ~_GEN_41) begin	// Monitor.scala:49:11, :318:47
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel Grant is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_45 & ~_GEN_38) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_45 & ~_GEN_39) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_45 & ~_GEN_43) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries invalid cap param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_45 & ~_GEN_44) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData carries toN param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_45 & ~_GEN_46) begin	// Monitor.scala:49:11, :328:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel GrantData is denied but not corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_47 & ~_GEN_38) begin	// Monitor.scala:49:11, :338:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_47 & ~_GEN_40) begin	// Monitor.scala:49:11, :338:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_47 & ~_GEN_41) begin	// Monitor.scala:49:11, :338:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_48 & ~_GEN_38) begin	// Monitor.scala:49:11, :346:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_48 & ~_GEN_40) begin	// Monitor.scala:49:11, :346:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_48 & ~_GEN_46) begin	// Monitor.scala:49:11, :346:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel AccessAckData is denied but not corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_49 & ~_GEN_38) begin	// Monitor.scala:49:11, :354:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_49 & ~_GEN_40) begin	// Monitor.scala:49:11, :354:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_49 & ~_GEN_41) begin	// Monitor.scala:49:11, :354:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel HintAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_53 & ~_GEN_54) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck carries unmanaged address (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_53 & ~_GEN_55) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_53 & ~_GEN_56) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_53 & ~_GEN_57) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_53 & ~_GEN_58) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck carries invalid report param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_53 & ~_GEN_59) begin	// Monitor.scala:42:11, :242:50
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_60 & ~_GEN_54) begin	// Monitor.scala:42:11, :251:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAckData carries unmanaged address (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_60 & ~_GEN_55) begin	// Monitor.scala:42:11, :251:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAckData carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_60 & ~_GEN_56) begin	// Monitor.scala:42:11, :251:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAckData smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_60 & ~_GEN_57) begin	// Monitor.scala:42:11, :251:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAckData address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_60 & ~_GEN_58) begin	// Monitor.scala:42:11, :251:54
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ProbeAckData carries invalid report param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_63) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel carries Release type unsupported by manager (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_64) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_55) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel Release carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_56) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel Release smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_57) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel Release address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_58) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel Release carries invalid report param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_61 & ~_GEN_59) begin	// Monitor.scala:42:11, :259:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel Release is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_63) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel carries ReleaseData type unsupported by manager (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_64) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel carries Release from a client which does not support Probe (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_55) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ReleaseData carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_56) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ReleaseData smaller than a beat (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_57) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ReleaseData address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_65 & ~_GEN_58) begin	// Monitor.scala:42:11, :269:53
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel ReleaseData carries invalid report param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_66 & ~_GEN_54) begin	// Monitor.scala:42:11, :278:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAck carries unmanaged address (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_66 & ~_GEN_55) begin	// Monitor.scala:42:11, :278:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_66 & ~_GEN_57) begin	// Monitor.scala:42:11, :278:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAck address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_66 & ~_GEN_67) begin	// Monitor.scala:42:11, :278:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAck carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_66 & ~_GEN_59) begin	// Monitor.scala:42:11, :278:51
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_68 & ~_GEN_54) begin	// Monitor.scala:42:11, :286:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAckData carries unmanaged address (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_68 & ~_GEN_55) begin	// Monitor.scala:42:11, :286:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAckData carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_68 & ~_GEN_57) begin	// Monitor.scala:42:11, :286:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAckData address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_68 & ~_GEN_67) begin	// Monitor.scala:42:11, :286:55
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel AccessAckData carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_69 & ~_GEN_54) begin	// Monitor.scala:42:11, :293:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel HintAck carries unmanaged address (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_69 & ~_GEN_55) begin	// Monitor.scala:42:11, :293:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel HintAck carries invalid source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_69 & ~_GEN_57) begin	// Monitor.scala:42:11, :293:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel HintAck address not aligned to size (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_69 & ~_GEN_67) begin	// Monitor.scala:42:11, :293:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel HintAck carries invalid param (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_69 & ~_GEN_59) begin	// Monitor.scala:42:11, :293:49
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel HintAck is corrupt (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_70 & ~(io_in_a_bits_opcode == opcode | reset)) begin	// Monitor.scala:42:11, :384:22, :389:19, :390:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel opcode changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_70 & ~(io_in_a_bits_param == param | reset)) begin	// Monitor.scala:42:11, :385:22, :389:19, :391:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel param changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_70 & ~(io_in_a_bits_size == size | reset)) begin	// Monitor.scala:42:11, :386:22, :389:19, :392:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel size changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_70 & ~(io_in_a_bits_source == source | reset)) begin	// Monitor.scala:42:11, :387:22, :389:19, :393:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel source changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_70 & ~(io_in_a_bits_address == address | reset)) begin	// Monitor.scala:42:11, :388:22, :389:19, :394:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel address changed with multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_71 & ~(io_in_d_bits_opcode == opcode_1 | reset)) begin	// Monitor.scala:49:11, :535:22, :541:19, :542:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel opcode changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_71 & ~(io_in_d_bits_param == param_1 | reset)) begin	// Monitor.scala:49:11, :536:22, :541:19, :543:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel param changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_71 & ~(io_in_d_bits_size == size_1 | reset)) begin	// Monitor.scala:49:11, :537:22, :541:19, :544:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel size changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_71 & ~(io_in_d_bits_source == source_1 | reset)) begin	// Monitor.scala:49:11, :538:22, :541:19, :545:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel source changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_71 & ~(io_in_d_bits_sink == sink | reset)) begin	// Monitor.scala:49:11, :539:22, :541:19, :546:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel sink changed with multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_71 & ~(io_in_d_bits_denied == denied | reset)) begin	// Monitor.scala:49:11, :540:22, :541:19, :547:29
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel denied changed with multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_72 & ~(io_in_c_bits_opcode == opcode_3 | reset)) begin	// Monitor.scala:42:11, :512:22, :517:19, :518:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel opcode changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_72 & ~(io_in_c_bits_param == param_3 | reset)) begin	// Monitor.scala:42:11, :513:22, :517:19, :519:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel param changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_72 & ~(io_in_c_bits_size == size_3 | reset)) begin	// Monitor.scala:42:11, :514:22, :517:19, :520:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel size changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_72 & ~(io_in_c_bits_source == source_3 | reset)) begin	// Monitor.scala:42:11, :515:22, :517:19, :521:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel source changed within multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      if (_GEN_72 & ~(io_in_c_bits_address == address_2 | reset)) begin	// Monitor.scala:42:11, :516:22, :517:19, :522:32
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel address changed with multibeat operation (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_81 = inflight >> io_in_a_bits_source;	// Monitor.scala:611:27, :658:26
      if (_GEN_2 & ~(~(_GEN_81[0]) | reset)) begin	// Monitor.scala:42:11, :652:27, :658:{17,26}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'A' channel re-used a source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_82 = inflight >> _GEN_76;	// Monitor.scala:611:27, :682:25
      if (_GEN_75 & ~(_GEN_82[0] | same_cycle_resp | reset)) begin	// Monitor.scala:49:11, :671:71, :681:88, :682:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_77
          & ~(io_in_d_bits_opcode == _GEN_11[io_in_a_bits_opcode]
              | io_in_d_bits_opcode == _GEN_10[io_in_a_bits_opcode] | reset)) begin	// Monitor.scala:49:11, :684:30, :685:38, :686:39
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_77 & ~(io_in_a_bits_size == io_in_d_bits_size | reset)) begin	// Monitor.scala:49:11, :684:30, :687:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_78
          & ~(io_in_d_bits_opcode == _GEN_11[_a_opcode_lookup_T_1[3:1]]
              | io_in_d_bits_opcode == _GEN_10[_a_opcode_lookup_T_1[3:1]] | reset)) begin	// Monitor.scala:42:11, :49:11, :634:{44,152}, :684:30, :685:38, :686:39, :689:38, :690:38
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper opcode response (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _a_size_lookup_T_1 = inflight_sizes >> _GEN_73;	// Monitor.scala:615:33, :634:44, :638:40
      if (_GEN_78 & ~(io_in_d_bits_size == _a_size_lookup_T_1[3:1] | reset)) begin	// Monitor.scala:42:11, :49:11, :638:{40,144}, :684:30, :691:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_74 & a_first_1 & io_in_a_valid & io_in_a_bits_source == io_in_d_bits_source
          & ~d_release_ack & ~(~io_in_d_ready | io_in_a_ready | reset)) begin	// Edges.scala:230:25, Monitor.scala:49:11, :670:46, :671:{26,74}, :694:90, :695:15
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(a_set_wo_ready != (_GEN_75 ? _d_clr_wo_ready_T[4:0] : 5'h0)
            | a_set_wo_ready == 5'h0 | reset)) begin	// Monitor.scala:49:11, :611:27, :648:71, :649:22, :671:{71,90}, :672:22, :699:{29,67}, OneHot.scala:58:35
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'A' and 'D' concurrent, despite minlatency 1 (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(inflight == 5'h0 | _plusarg_reader_out == 32'h0
            | watchdog < _plusarg_reader_out | reset)) begin	// Monitor.scala:42:11, :611:27, :706:27, :709:{26,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_83 = inflight_1 >> io_in_c_bits_source;	// Monitor.scala:723:35, :766:26
      if (_GEN_6 & ~(~(_GEN_83[0]) | reset)) begin	// Monitor.scala:42:11, :760:38, :766:{17,26}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'C' channel re-used a source ID (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_84 = inflight_1 >> _GEN_76;	// Monitor.scala:682:25, :723:35, :791:25
      if (_GEN_80 & ~(_GEN_84[0] | same_cycle_resp_1 | reset)) begin	// Monitor.scala:49:11, :779:71, :790:88, :791:25
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_80 & same_cycle_resp_1
          & ~(io_in_d_bits_size == io_in_c_bits_size | reset)) begin	// Monitor.scala:49:11, :779:71, :790:88, :793:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _c_size_lookup_T_1 = inflight_sizes_1 >> _GEN_73;	// Monitor.scala:634:44, :725:35, :747:42
      if (_GEN_80 & ~same_cycle_resp_1
          & ~(io_in_d_bits_size == _c_size_lookup_T_1[3:1] | reset)) begin	// Monitor.scala:42:11, :49:11, :747:{42,146}, :779:71, :790:88, :792:30, :795:36
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel contains improper response size (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (_GEN_79 & c_first_1 & io_in_c_valid & io_in_c_bits_source == io_in_d_bits_source
          & d_release_ack & ~(~io_in_d_ready | io_in_c_ready | reset)) begin	// Edges.scala:230:25, Monitor.scala:49:11, :670:46, :695:15, :779:26, :799:90
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if ((|c_set_wo_ready)
          & ~(c_set_wo_ready != (_GEN_80 ? _d_clr_wo_ready_T_1[4:0] : 5'h0)
              | reset)) begin	// Monitor.scala:49:11, :611:27, :756:71, :757:22, :779:{71,89}, :780:22, :804:28, :805:31, OneHot.scala:58:35
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'C' and 'D' concurrent, despite minlatency 1 (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      if (~(inflight_1 == 5'h0 | _plusarg_reader_1_out == 32'h0
            | watchdog_1 < _plusarg_reader_1_out | reset)) begin	// Monitor.scala:42:11, :611:27, :723:35, :813:27, :816:{26,39,59}, PlusArg.scala:80:11
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: TileLink timeout expired (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
      _GEN_85 = inflight_2 >> _GEN_8;	// Monitor.scala:823:27, :831:23, OneHot.scala:58:35
      if (_GEN_7 & ~(~(_GEN_85[0]) | reset)) begin	// Monitor.scala:49:11, :829:38, :831:{14,23}
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:49:11
          $error("Assertion failed: 'D' channel re-used a sink ID (connected at Configs.scala:117:34)\n    at Monitor.scala:49 assert(cond, message)\n");	// Monitor.scala:49:11
        if (`STOP_COND_)	// Monitor.scala:49:11
          $fatal;	// Monitor.scala:49:11
      end
      _GEN_86 = (d_set | inflight_2) >> _GEN_9;	// Monitor.scala:823:27, :829:72, :830:13, :837:{24,35}, OneHot.scala:58:35
      if (io_in_e_valid & ~(_GEN_86[0] | reset)) begin	// Monitor.scala:42:11, :837:35
        if (`ASSERT_VERBOSE_COND_)	// Monitor.scala:42:11
          $error("Assertion failed: 'E' channel acknowledged for nothing inflight (connected at Configs.scala:117:34)\n    at Monitor.scala:42 assert(cond, message)\n");	// Monitor.scala:42:11
        if (`STOP_COND_)	// Monitor.scala:42:11
          $fatal;	// Monitor.scala:42:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      a_first_counter <= 3'h0;	// Edges.scala:228:27
      d_first_counter <= 3'h0;	// Edges.scala:228:27
      c_first_counter <= 3'h0;	// Edges.scala:228:27
      inflight <= 5'h0;	// Monitor.scala:611:27
      inflight_opcodes <= 20'h0;	// Monitor.scala:613:35
      inflight_sizes <= 20'h0;	// Monitor.scala:613:35, :615:33
      a_first_counter_1 <= 3'h0;	// Edges.scala:228:27
      d_first_counter_1 <= 3'h0;	// Edges.scala:228:27
      watchdog <= 32'h0;	// Monitor.scala:706:27
      inflight_1 <= 5'h0;	// Monitor.scala:611:27, :723:35
      inflight_sizes_1 <= 20'h0;	// Monitor.scala:613:35, :725:35
      c_first_counter_1 <= 3'h0;	// Edges.scala:228:27
      d_first_counter_2 <= 3'h0;	// Edges.scala:228:27
      watchdog_1 <= 32'h0;	// Monitor.scala:813:27
      inflight_2 <= 8'h0;	// Monitor.scala:823:27
      d_first_counter_3 <= 3'h0;	// Edges.scala:228:27
    end
    else begin
      automatic logic [66:0] _GEN_87 = {62'h0, io_in_a_bits_source, 2'h0};	// Monitor.scala:656:54, OneHot.scala:65:12
      automatic logic        _GEN_88 = _d_first_T_3 & d_first_1 & ~d_release_ack;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:670:46, :671:74, :675:72
      automatic logic [78:0] _GEN_89 = {74'h0, io_in_d_bits_source, 2'h0};	// Monitor.scala:677:76, OneHot.scala:65:12
      automatic logic        _GEN_90 = _d_first_T_3 & d_first_2 & d_release_ack;	// Decoupled.scala:40:37, Edges.scala:230:25, Monitor.scala:670:46, :783:72
      automatic logic [7:0]  _d_clr_T = 8'h1 << _GEN_3;	// OneHot.scala:58:35
      automatic logic [7:0]  _a_set_T = 8'h1 << _GEN_1;	// OneHot.scala:58:35
      automatic logic [78:0] _d_opcodes_clr_T_5 = 79'hF << _GEN_89;	// Monitor.scala:677:76
      automatic logic [66:0] _a_opcodes_set_T_1 =
        {63'h0, _GEN_2 ? {io_in_a_bits_opcode, 1'h1} : 4'h0} << _GEN_87;	// Monitor.scala:42:11, :49:11, :652:{27,72}, :654:{28,61}, :656:54
      automatic logic [78:0] _d_sizes_clr_T_5 = 79'hF << _GEN_89;	// Monitor.scala:677:76, :678:74
      automatic logic [66:0] _a_sizes_set_T_1 =
        {63'h0, _GEN_2 ? {io_in_a_bits_size, 1'h1} : 4'h0} << _GEN_87;	// Monitor.scala:42:11, :49:11, :652:{27,72}, :655:{28,59}, :656:54, :657:52
      automatic logic [7:0]  _d_clr_T_1 = 8'h1 << _GEN_3;	// OneHot.scala:58:35
      automatic logic [7:0]  _c_set_T = 8'h1 << _GEN_5;	// OneHot.scala:58:35
      automatic logic [78:0] _d_sizes_clr_T_11 = 79'hF << _GEN_89;	// Monitor.scala:677:76, :786:74
      automatic logic [66:0] _c_sizes_set_T_1 =
        {63'h0, _GEN_6 ? {io_in_c_bits_size, 1'h1} : 4'h0}
        << {62'h0, io_in_c_bits_source, 2'h0};	// Monitor.scala:42:11, :49:11, :656:54, :760:{38,72}, :763:{28,59}, :765:52, OneHot.scala:65:12
      if (_a_first_T_1) begin	// Decoupled.scala:40:37
        if (|a_first_counter)	// Edges.scala:228:27, :230:25
          a_first_counter <= a_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else if (io_in_a_bits_opcode[2])	// Edges.scala:91:37
          a_first_counter <= 3'h0;	// Edges.scala:228:27
        else begin	// Edges.scala:91:37
          automatic logic [12:0] _a_first_beats1_decode_T_1 = 13'h3F << _GEN;	// package.scala:234:77
          a_first_counter <= ~(_a_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        if (a_first_1) begin	// Edges.scala:230:25
          if (io_in_a_bits_opcode[2])	// Edges.scala:91:37
            a_first_counter_1 <= 3'h0;	// Edges.scala:228:27
          else begin	// Edges.scala:91:37
            automatic logic [12:0] _a_first_beats1_decode_T_5 = 13'h3F << _GEN;	// package.scala:234:77
            a_first_counter_1 <= ~(_a_first_beats1_decode_T_5[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
        end
        else	// Edges.scala:230:25
          a_first_counter_1 <= a_first_counter_1 - 3'h1;	// Edges.scala:228:27, :229:28
      end
      if (_d_first_T_3) begin	// Decoupled.scala:40:37
        automatic logic [12:0] _GEN_91;	// package.scala:234:77
        _GEN_91 = {10'h0, io_in_d_bits_size};	// package.scala:234:77
        if (|d_first_counter)	// Edges.scala:228:27, :230:25
          d_first_counter <= d_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
          automatic logic [12:0] _d_first_beats1_decode_T_1;	// package.scala:234:77
          _d_first_beats1_decode_T_1 = 13'h3F << _GEN_91;	// package.scala:234:77
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:105:36
          d_first_counter <= 3'h0;	// Edges.scala:228:27
        if (d_first_1) begin	// Edges.scala:230:25
          if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [12:0] _d_first_beats1_decode_T_5;	// package.scala:234:77
            _d_first_beats1_decode_T_5 = 13'h3F << _GEN_91;	// package.scala:234:77
            d_first_counter_1 <= ~(_d_first_beats1_decode_T_5[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter_1 <= 3'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          d_first_counter_1 <= d_first_counter_1 - 3'h1;	// Edges.scala:228:27, :229:28
        if (d_first_2) begin	// Edges.scala:230:25
          if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [12:0] _d_first_beats1_decode_T_9;	// package.scala:234:77
            _d_first_beats1_decode_T_9 = 13'h3F << _GEN_91;	// package.scala:234:77
            d_first_counter_2 <= ~(_d_first_beats1_decode_T_9[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter_2 <= 3'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          d_first_counter_2 <= d_first_counter_2 - 3'h1;	// Edges.scala:228:27, :229:28
        if (d_first_3) begin	// Edges.scala:230:25
          if (io_in_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [12:0] _d_first_beats1_decode_T_13;	// package.scala:234:77
            _d_first_beats1_decode_T_13 = 13'h3F << _GEN_91;	// package.scala:234:77
            d_first_counter_3 <= ~(_d_first_beats1_decode_T_13[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter_3 <= 3'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          d_first_counter_3 <= d_first_counter_3 - 3'h1;	// Edges.scala:228:27, :229:28
      end
      if (_c_first_T_1) begin	// Decoupled.scala:40:37
        if (|c_first_counter)	// Edges.scala:228:27, :230:25
          c_first_counter <= c_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else if (io_in_c_bits_opcode[0]) begin	// Edges.scala:101:36
          automatic logic [12:0] _c_first_beats1_decode_T_1 = 13'h3F << _GEN_0;	// package.scala:234:77
          c_first_counter <= ~(_c_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:101:36
          c_first_counter <= 3'h0;	// Edges.scala:228:27
        if (c_first_1) begin	// Edges.scala:230:25
          if (io_in_c_bits_opcode[0]) begin	// Edges.scala:101:36
            automatic logic [12:0] _c_first_beats1_decode_T_5 = 13'h3F << _GEN_0;	// package.scala:234:77
            c_first_counter_1 <= ~(_c_first_beats1_decode_T_5[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:101:36
            c_first_counter_1 <= 3'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          c_first_counter_1 <= c_first_counter_1 - 3'h1;	// Edges.scala:228:27, :229:28
      end
      inflight <=
        (inflight | (_GEN_2 ? _a_set_T[4:0] : 5'h0)) & ~(_GEN_88 ? _d_clr_T[4:0] : 5'h0);	// Monitor.scala:611:27, :652:{27,72}, :653:28, :675:{72,91}, :676:21, :702:{27,36,38}, OneHot.scala:58:35
      inflight_opcodes <=
        (inflight_opcodes | (_GEN_2 ? _a_opcodes_set_T_1[19:0] : 20'h0))
        & ~(_GEN_88 ? _d_opcodes_clr_T_5[19:0] : 20'h0);	// Monitor.scala:613:35, :652:{27,72}, :656:{28,54}, :675:{72,91}, :677:{21,76}, :703:{43,60,62}
      inflight_sizes <=
        (inflight_sizes | (_GEN_2 ? _a_sizes_set_T_1[19:0] : 20'h0))
        & ~(_GEN_88 ? _d_sizes_clr_T_5[19:0] : 20'h0);	// Monitor.scala:613:35, :615:33, :652:{27,72}, :657:{28,52}, :675:{72,91}, :678:{21,74}, :704:{39,54,56}
      if (_a_first_T_1 | _d_first_T_3)	// Decoupled.scala:40:37, Monitor.scala:712:27
        watchdog <= 32'h0;	// Monitor.scala:706:27
      else	// Monitor.scala:712:27
        watchdog <= watchdog + 32'h1;	// Monitor.scala:706:27, :711:26
      inflight_1 <=
        (inflight_1 | (_GEN_6 ? _c_set_T[4:0] : 5'h0))
        & ~(_GEN_90 ? _d_clr_T_1[4:0] : 5'h0);	// Monitor.scala:611:27, :723:35, :760:{38,72}, :761:28, :783:{72,90}, :784:21, :809:{35,44,46}, OneHot.scala:58:35
      inflight_sizes_1 <=
        (inflight_sizes_1 | (_GEN_6 ? _c_sizes_set_T_1[19:0] : 20'h0))
        & ~(_GEN_90 ? _d_sizes_clr_T_11[19:0] : 20'h0);	// Monitor.scala:613:35, :725:35, :760:{38,72}, :765:{28,52}, :783:{72,90}, :786:{21,74}, :811:{41,56,58}
      if (_c_first_T_1 | _d_first_T_3)	// Decoupled.scala:40:37, Monitor.scala:819:27
        watchdog_1 <= 32'h0;	// Monitor.scala:813:27
      else	// Monitor.scala:819:27
        watchdog_1 <= watchdog_1 + 32'h1;	// Monitor.scala:711:26, :813:27, :818:26
      inflight_2 <= (inflight_2 | d_set) & ~(io_in_e_valid ? 8'h1 << _GEN_9 : 8'h0);	// Monitor.scala:823:27, :829:72, :830:13, :835:73, :836:13, :842:{27,36,38}, OneHot.scala:58:35
    end
    if (_a_first_T_1 & ~(|a_first_counter)) begin	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:396:20
      opcode <= io_in_a_bits_opcode;	// Monitor.scala:384:22
      param <= io_in_a_bits_param;	// Monitor.scala:385:22
      size <= io_in_a_bits_size;	// Monitor.scala:386:22
      source <= io_in_a_bits_source;	// Monitor.scala:387:22
      address <= io_in_a_bits_address;	// Monitor.scala:388:22
    end
    if (_d_first_T_3 & ~(|d_first_counter)) begin	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:549:20
      opcode_1 <= io_in_d_bits_opcode;	// Monitor.scala:535:22
      param_1 <= io_in_d_bits_param;	// Monitor.scala:536:22
      size_1 <= io_in_d_bits_size;	// Monitor.scala:537:22
      source_1 <= io_in_d_bits_source;	// Monitor.scala:538:22
      sink <= io_in_d_bits_sink;	// Monitor.scala:539:22
      denied <= io_in_d_bits_denied;	// Monitor.scala:540:22
    end
    if (_c_first_T_1 & ~(|c_first_counter)) begin	// Decoupled.scala:40:37, Edges.scala:228:27, :230:25, Monitor.scala:524:20
      opcode_3 <= io_in_c_bits_opcode;	// Monitor.scala:512:22
      param_3 <= io_in_c_bits_param;	// Monitor.scala:513:22
      size_3 <= io_in_c_bits_size;	// Monitor.scala:514:22
      source_3 <= io_in_c_bits_source;	// Monitor.scala:515:22
      address_2 <= io_in_c_bits_address;	// Monitor.scala:516:22
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:10];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        a_first_counter = _RANDOM[4'h0][2:0];	// Edges.scala:228:27
        opcode = _RANDOM[4'h0][5:3];	// Edges.scala:228:27, Monitor.scala:384:22
        param = _RANDOM[4'h0][8:6];	// Edges.scala:228:27, Monitor.scala:385:22
        size = _RANDOM[4'h0][11:9];	// Edges.scala:228:27, Monitor.scala:386:22
        source = _RANDOM[4'h0][14:12];	// Edges.scala:228:27, Monitor.scala:387:22
        address = {_RANDOM[4'h0][31:15], _RANDOM[4'h1][14:0]};	// Edges.scala:228:27, Monitor.scala:388:22
        d_first_counter = _RANDOM[4'h1][17:15];	// Edges.scala:228:27, Monitor.scala:388:22
        opcode_1 = _RANDOM[4'h1][20:18];	// Monitor.scala:388:22, :535:22
        param_1 = _RANDOM[4'h1][22:21];	// Monitor.scala:388:22, :536:22
        size_1 = _RANDOM[4'h1][25:23];	// Monitor.scala:388:22, :537:22
        source_1 = _RANDOM[4'h1][28:26];	// Monitor.scala:388:22, :538:22
        sink = _RANDOM[4'h1][31:29];	// Monitor.scala:388:22, :539:22
        denied = _RANDOM[4'h2][0];	// Monitor.scala:540:22
        c_first_counter = _RANDOM[4'h3][17:15];	// Edges.scala:228:27
        opcode_3 = _RANDOM[4'h3][20:18];	// Edges.scala:228:27, Monitor.scala:512:22
        param_3 = _RANDOM[4'h3][23:21];	// Edges.scala:228:27, Monitor.scala:513:22
        size_3 = _RANDOM[4'h3][26:24];	// Edges.scala:228:27, Monitor.scala:514:22
        source_3 = _RANDOM[4'h3][29:27];	// Edges.scala:228:27, Monitor.scala:515:22
        address_2 = {_RANDOM[4'h3][31:30], _RANDOM[4'h4][29:0]};	// Edges.scala:228:27, Monitor.scala:516:22
        inflight = {_RANDOM[4'h4][31:30], _RANDOM[4'h5][2:0]};	// Monitor.scala:516:22, :611:27
        inflight_opcodes = _RANDOM[4'h5][22:3];	// Monitor.scala:611:27, :613:35
        inflight_sizes = {_RANDOM[4'h5][31:23], _RANDOM[4'h6][10:0]};	// Monitor.scala:611:27, :615:33
        a_first_counter_1 = _RANDOM[4'h6][13:11];	// Edges.scala:228:27, Monitor.scala:615:33
        d_first_counter_1 = _RANDOM[4'h6][16:14];	// Edges.scala:228:27, Monitor.scala:615:33
        watchdog = {_RANDOM[4'h6][31:17], _RANDOM[4'h7][16:0]};	// Monitor.scala:615:33, :706:27
        inflight_1 = _RANDOM[4'h7][21:17];	// Monitor.scala:706:27, :723:35
        inflight_sizes_1 = _RANDOM[4'h8][29:10];	// Monitor.scala:725:35
        c_first_counter_1 = {_RANDOM[4'h8][31:30], _RANDOM[4'h9][0]};	// Edges.scala:228:27, Monitor.scala:725:35
        d_first_counter_2 = _RANDOM[4'h9][3:1];	// Edges.scala:228:27
        watchdog_1 = {_RANDOM[4'h9][31:4], _RANDOM[4'hA][3:0]};	// Edges.scala:228:27, Monitor.scala:813:27
        inflight_2 = _RANDOM[4'hA][11:4];	// Monitor.scala:813:27, :823:27
        d_first_counter_3 = _RANDOM[4'hA][14:12];	// Edges.scala:228:27, Monitor.scala:813:27
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

