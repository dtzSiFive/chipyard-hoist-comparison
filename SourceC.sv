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

module SourceC(
  input         clock,
                reset,
                io_req_valid,
  input  [2:0]  io_req_bits_opcode,
                io_req_bits_param,
                io_req_bits_source,
  input  [12:0] io_req_bits_tag,
  input  [9:0]  io_req_bits_set,
  input  [2:0]  io_req_bits_way,
  input         io_req_bits_dirty,
                io_c_ready,
                io_bs_adr_ready,
  input  [63:0] io_bs_dat_data,
  input         io_evict_safe,
  output        io_req_ready,
                io_c_valid,
  output [2:0]  io_c_bits_opcode,
                io_c_bits_param,
                io_c_bits_size,
                io_c_bits_source,
  output [31:0] io_c_bits_address,
  output [63:0] io_c_bits_data,
  output        io_c_bits_corrupt,
                io_bs_adr_valid,
  output [2:0]  io_bs_adr_bits_way,
  output [9:0]  io_bs_adr_bits_set,
  output [2:0]  io_bs_adr_bits_beat,
  output [9:0]  io_evict_req_set,
  output [2:0]  io_evict_req_way
);

  wire        _queue_io_enq_ready;	// SourceC.scala:53:21
  wire        _queue_io_deq_valid;	// SourceC.scala:53:21
  wire [3:0]  _queue_io_count;	// SourceC.scala:53:21
  reg  [3:0]  fill;	// SourceC.scala:57:21
  reg         room;	// SourceC.scala:58:21
  reg         busy;	// SourceC.scala:65:21
  reg  [2:0]  beat;	// SourceC.scala:66:21
  reg  [2:0]  req_r_opcode;	// Reg.scala:15:16
  reg  [2:0]  req_r_param;	// Reg.scala:15:16
  reg  [2:0]  req_r_source;	// Reg.scala:15:16
  reg  [12:0] req_r_tag;	// Reg.scala:15:16
  reg  [9:0]  req_r_set;	// Reg.scala:15:16
  reg  [2:0]  req_r_way;	// Reg.scala:15:16
  wire [9:0]  req_set = busy ? req_r_set : io_req_bits_set;	// Reg.scala:15:16, SourceC.scala:65:21, :68:17
  wire [2:0]  req_way = busy ? req_r_way : io_req_bits_way;	// Reg.scala:15:16, SourceC.scala:65:21, :68:17
  wire        _want_data_T = io_req_valid & room;	// SourceC.scala:58:21, :69:41
  wire        want_data = busy | _want_data_T & io_req_bits_dirty;	// SourceC.scala:65:21, :69:{24,41,49}
  wire        _io_req_ready_output = ~busy & room;	// SourceC.scala:58:21, :65:21, :68:18, :71:25
  wire        _io_bs_adr_valid_output = ((|beat) | io_evict_safe) & want_data;	// SourceC.scala:66:21, :69:24, :76:{28,32,50}
  reg         s2_valid;	// SourceC.scala:93:25
  reg  [2:0]  s2_req_opcode;	// Reg.scala:15:16
  reg  [2:0]  s2_req_param;	// Reg.scala:15:16
  reg  [2:0]  s2_req_source;	// Reg.scala:15:16
  reg  [12:0] s2_req_tag;	// Reg.scala:15:16
  reg  [9:0]  s2_req_set;	// Reg.scala:15:16
  reg         s3_valid;	// SourceC.scala:99:25
  reg  [2:0]  s3_req_opcode;	// Reg.scala:15:16
  reg  [2:0]  s3_req_param;	// Reg.scala:15:16
  reg  [2:0]  s3_req_source;	// Reg.scala:15:16
  reg  [12:0] s3_req_tag;	// Reg.scala:15:16
  reg  [9:0]  s3_req_set;	// Reg.scala:15:16
  `ifndef SYNTHESIS	// SourceC.scala:63:10
    always @(posedge clock) begin	// SourceC.scala:63:10
      if (~(room == (_queue_io_count < 4'h2) | reset)) begin	// SourceC.scala:53:21, :58:21, :61:60, :63:{10,16,35}
        if (`ASSERT_VERBOSE_COND_)	// SourceC.scala:63:10
          $error("Assertion failed\n    at SourceC.scala:63 assert (room === queue.io.count <= UInt(1))\n");	// SourceC.scala:63:10
        if (`STOP_COND_)	// SourceC.scala:63:10
          $fatal;	// SourceC.scala:63:10
      end
      if (~(~s3_valid | _queue_io_enq_ready | reset)) begin	// SourceC.scala:53:21, :99:25, :115:{9,10}
        if (`ASSERT_VERBOSE_COND_)	// SourceC.scala:115:9
          $error("Assertion failed\n    at SourceC.scala:115 assert(!c.valid || c.ready)\n");	// SourceC.scala:115:9
        if (`STOP_COND_)	// SourceC.scala:115:9
          $fatal;	// SourceC.scala:115:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic _s2_latch_T;	// Decoupled.scala:40:37
    automatic logic _s2_latch_T_1;	// Decoupled.scala:40:37
    _s2_latch_T = io_bs_adr_ready & _io_bs_adr_valid_output;	// Decoupled.scala:40:37, SourceC.scala:76:50
    _s2_latch_T_1 = _io_req_ready_output & io_req_valid;	// Decoupled.scala:40:37, SourceC.scala:71:25
    if (reset) begin
      fill <= 4'h0;	// SourceC.scala:57:21
      room <= 1'h1;	// SourceC.scala:58:21
      busy <= 1'h0;	// SourceC.scala:61:18, :65:21
      beat <= 3'h0;	// SourceC.scala:66:21
    end
    else begin
      automatic logic _room_T_4;	// Decoupled.scala:40:37
      _room_T_4 = _queue_io_enq_ready & s3_valid;	// Decoupled.scala:40:37, SourceC.scala:53:21, :99:25
      if (_room_T_4 != (io_c_ready & _queue_io_deq_valid)) begin	// Decoupled.scala:40:37, SourceC.scala:53:21, :59:29
        fill <= fill + (_room_T_4 ? 4'h1 : 4'hF);	// Decoupled.scala:40:37, SourceC.scala:57:21, :60:{18,23,54}
        room <= fill == 4'h0 | (fill == 4'h1 | fill == 4'h2) & ~_room_T_4;	// Decoupled.scala:40:37, SourceC.scala:57:21, :58:21, :60:23, :61:{18,30,40,52,60,73,76}
      end
      busy <= ~(_s2_latch_T & (&beat)) & (_want_data_T & io_req_bits_dirty | busy);	// Decoupled.scala:40:37, SourceC.scala:65:21, :66:21, :67:19, :69:41, :86:{30,52,59}, :87:27, :88:{17,24}
      if (_s2_latch_T)	// Decoupled.scala:40:37
        beat <= beat + 3'h1;	// SourceC.scala:66:21, :89:18
    end
    if (~busy & io_req_valid) begin	// SourceC.scala:65:21, :68:{18,67}
      req_r_opcode <= io_req_bits_opcode;	// Reg.scala:15:16
      req_r_param <= io_req_bits_param;	// Reg.scala:15:16
      req_r_source <= io_req_bits_source;	// Reg.scala:15:16
      req_r_tag <= io_req_bits_tag;	// Reg.scala:15:16
      req_r_set <= io_req_bits_set;	// Reg.scala:15:16
      req_r_way <= io_req_bits_way;	// Reg.scala:15:16
    end
    if (want_data)	// SourceC.scala:69:24
      s2_valid <= _s2_latch_T;	// Decoupled.scala:40:37, SourceC.scala:93:25
    else	// SourceC.scala:69:24
      s2_valid <= _s2_latch_T_1;	// Decoupled.scala:40:37, SourceC.scala:93:25
    if (want_data ? _s2_latch_T : _s2_latch_T_1) begin	// Decoupled.scala:40:37, SourceC.scala:69:24, :92:21
      if (busy) begin	// SourceC.scala:65:21
        s2_req_opcode <= req_r_opcode;	// Reg.scala:15:16
        s2_req_param <= req_r_param;	// Reg.scala:15:16
        s2_req_source <= req_r_source;	// Reg.scala:15:16
        s2_req_tag <= req_r_tag;	// Reg.scala:15:16
        s2_req_set <= req_r_set;	// Reg.scala:15:16
      end
      else begin	// SourceC.scala:65:21
        s2_req_opcode <= io_req_bits_opcode;	// Reg.scala:15:16
        s2_req_param <= io_req_bits_param;	// Reg.scala:15:16
        s2_req_source <= io_req_bits_source;	// Reg.scala:15:16
        s2_req_tag <= io_req_bits_tag;	// Reg.scala:15:16
        s2_req_set <= io_req_bits_set;	// Reg.scala:15:16
      end
    end
    s3_valid <= s2_valid;	// SourceC.scala:93:25, :99:25
    if (s2_valid) begin	// SourceC.scala:93:25
      s3_req_opcode <= s2_req_opcode;	// Reg.scala:15:16
      s3_req_param <= s2_req_param;	// Reg.scala:15:16
      s3_req_source <= s2_req_source;	// Reg.scala:15:16
      s3_req_tag <= s2_req_tag;	// Reg.scala:15:16
      s3_req_set <= s2_req_set;	// Reg.scala:15:16
    end
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
        fill = _RANDOM[2'h0][3:0];	// SourceC.scala:57:21
        room = _RANDOM[2'h0][4];	// SourceC.scala:57:21, :58:21
        busy = _RANDOM[2'h0][5];	// SourceC.scala:57:21, :65:21
        beat = _RANDOM[2'h0][8:6];	// SourceC.scala:57:21, :66:21
        req_r_opcode = _RANDOM[2'h0][11:9];	// Reg.scala:15:16, SourceC.scala:57:21
        req_r_param = _RANDOM[2'h0][14:12];	// Reg.scala:15:16, SourceC.scala:57:21
        req_r_source = _RANDOM[2'h0][17:15];	// Reg.scala:15:16, SourceC.scala:57:21
        req_r_tag = _RANDOM[2'h0][30:18];	// Reg.scala:15:16, SourceC.scala:57:21
        req_r_set = {_RANDOM[2'h0][31], _RANDOM[2'h1][8:0]};	// Reg.scala:15:16, SourceC.scala:57:21
        req_r_way = _RANDOM[2'h1][11:9];	// Reg.scala:15:16
        s2_valid = _RANDOM[2'h1][13];	// Reg.scala:15:16, SourceC.scala:93:25
        s2_req_opcode = _RANDOM[2'h1][16:14];	// Reg.scala:15:16
        s2_req_param = _RANDOM[2'h1][19:17];	// Reg.scala:15:16
        s2_req_source = _RANDOM[2'h1][22:20];	// Reg.scala:15:16
        s2_req_tag = {_RANDOM[2'h1][31:23], _RANDOM[2'h2][3:0]};	// Reg.scala:15:16
        s2_req_set = _RANDOM[2'h2][13:4];	// Reg.scala:15:16
        s3_valid = _RANDOM[2'h2][22];	// Reg.scala:15:16, SourceC.scala:99:25
        s3_req_opcode = _RANDOM[2'h2][25:23];	// Reg.scala:15:16
        s3_req_param = _RANDOM[2'h2][28:26];	// Reg.scala:15:16
        s3_req_source = _RANDOM[2'h2][31:29];	// Reg.scala:15:16
        s3_req_tag = _RANDOM[2'h3][12:0];	// Reg.scala:15:16
        s3_req_set = _RANDOM[2'h3][22:13];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  QueueCompatibility_20 queue (	// SourceC.scala:53:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (s3_valid),	// SourceC.scala:99:25
    .io_enq_bits_opcode  (s3_req_opcode),	// Reg.scala:15:16
    .io_enq_bits_param   (s3_req_param),	// Reg.scala:15:16
    .io_enq_bits_source  (s3_req_source),	// Reg.scala:15:16
    .io_enq_bits_address ({s3_req_tag[12], 3'h0, s3_req_tag[11:0], s3_req_set, 6'h0}),	// Cat.scala:30:58, Parameters.scala:218:15, :226:72, Reg.scala:15:16
    .io_enq_bits_data    (io_bs_dat_data),
    .io_deq_ready        (io_c_ready),
    .io_enq_ready        (_queue_io_enq_ready),
    .io_deq_valid        (_queue_io_deq_valid),
    .io_deq_bits_opcode  (io_c_bits_opcode),
    .io_deq_bits_param   (io_c_bits_param),
    .io_deq_bits_size    (io_c_bits_size),
    .io_deq_bits_source  (io_c_bits_source),
    .io_deq_bits_address (io_c_bits_address),
    .io_deq_bits_data    (io_c_bits_data),
    .io_deq_bits_corrupt (io_c_bits_corrupt),
    .io_count            (_queue_io_count)
  );
  assign io_req_ready = _io_req_ready_output;	// SourceC.scala:71:25
  assign io_c_valid = _queue_io_deq_valid;	// SourceC.scala:53:21
  assign io_bs_adr_valid = _io_bs_adr_valid_output;	// SourceC.scala:76:50
  assign io_bs_adr_bits_way = req_way;	// SourceC.scala:68:17
  assign io_bs_adr_bits_set = req_set;	// SourceC.scala:68:17
  assign io_bs_adr_bits_beat = beat;	// SourceC.scala:66:21
  assign io_evict_req_set = req_set;	// SourceC.scala:68:17
  assign io_evict_req_way = req_way;	// SourceC.scala:68:17
endmodule

