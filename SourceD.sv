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

module SourceD(
  input         clock,
                reset,
                io_req_valid,
                io_req_bits_prio_0,
                io_req_bits_prio_2,
  input  [2:0]  io_req_bits_opcode,
                io_req_bits_param,
                io_req_bits_size,
  input  [6:0]  io_req_bits_source,
  input  [5:0]  io_req_bits_offset,
                io_req_bits_put,
  input  [9:0]  io_req_bits_set,
  input  [2:0]  io_req_bits_sink,
                io_req_bits_way,
  input         io_req_bits_bad,
                io_d_ready,
                io_pb_pop_ready,
  input  [63:0] io_pb_beat_data,
  input  [7:0]  io_pb_beat_mask,
  input         io_pb_beat_corrupt,
                io_rel_pop_ready,
  input  [63:0] io_rel_beat_data,
  input         io_rel_beat_corrupt,
                io_bs_radr_ready,
  input  [63:0] io_bs_rdat_data,
  input         io_bs_wadr_ready,
  input  [9:0]  io_evict_req_set,
  input  [2:0]  io_evict_req_way,
  input  [9:0]  io_grant_req_set,
  input  [2:0]  io_grant_req_way,
  output        io_req_ready,
                io_d_valid,
  output [2:0]  io_d_bits_opcode,
  output [1:0]  io_d_bits_param,
  output [2:0]  io_d_bits_size,
  output [6:0]  io_d_bits_source,
  output [2:0]  io_d_bits_sink,
  output        io_d_bits_denied,
  output [63:0] io_d_bits_data,
  output        io_d_bits_corrupt,
                io_pb_pop_valid,
  output [5:0]  io_pb_pop_bits_index,
  output        io_pb_pop_bits_last,
                io_rel_pop_valid,
  output [5:0]  io_rel_pop_bits_index,
  output        io_rel_pop_bits_last,
                io_bs_radr_valid,
  output [2:0]  io_bs_radr_bits_way,
  output [9:0]  io_bs_radr_bits_set,
  output [2:0]  io_bs_radr_bits_beat,
  output        io_bs_radr_bits_mask,
                io_bs_wadr_valid,
  output [2:0]  io_bs_wadr_bits_way,
  output [9:0]  io_bs_wadr_bits_set,
  output [2:0]  io_bs_wadr_bits_beat,
  output        io_bs_wadr_bits_mask,
  output [63:0] io_bs_wdat_data,
  output        io_evict_safe,
                io_grant_safe
);

  wire            s1_x_bypass;	// SourceD.scala:358:44
  wire [63:0]     s3_bypass_data;	// SourceD.scala:209:75
  wire            s4_ready;	// SourceD.scala:291:59
  wire            s3_ready;	// SourceD.scala:241:24
  wire            s3_valid;	// SourceD.scala:240:23
  wire [63:0]     _atomics_io_data_out;	// SourceD.scala:257:23
  wire            _queue_io_enq_ready;	// SourceD.scala:119:21
  wire            _queue_io_deq_valid;	// SourceD.scala:119:21
  wire [63:0]     _queue_io_deq_bits_data;	// SourceD.scala:119:21
  reg             busy;	// SourceD.scala:83:21
  reg             s1_block_r;	// SourceD.scala:84:27
  reg  [2:0]      s1_counter;	// SourceD.scala:85:27
  reg             s1_req_reg_prio_0;	// Reg.scala:15:16
  reg             s1_req_reg_prio_2;	// Reg.scala:15:16
  reg  [2:0]      s1_req_reg_opcode;	// Reg.scala:15:16
  reg  [2:0]      s1_req_reg_param;	// Reg.scala:15:16
  reg  [2:0]      s1_req_reg_size;	// Reg.scala:15:16
  reg  [6:0]      s1_req_reg_source;	// Reg.scala:15:16
  reg  [5:0]      s1_req_reg_offset;	// Reg.scala:15:16
  reg  [5:0]      s1_req_reg_put;	// Reg.scala:15:16
  reg  [9:0]      s1_req_reg_set;	// Reg.scala:15:16
  reg  [2:0]      s1_req_reg_sink;	// Reg.scala:15:16
  reg  [2:0]      s1_req_reg_way;	// Reg.scala:15:16
  reg             s1_req_reg_bad;	// Reg.scala:15:16
  wire            s1_req_prio_0 = busy ? s1_req_reg_prio_0 : io_req_bits_prio_0;	// Reg.scala:15:16, SourceD.scala:83:21, :87:19
  wire [2:0]      s1_req_opcode = busy ? s1_req_reg_opcode : io_req_bits_opcode;	// Reg.scala:15:16, SourceD.scala:83:21, :87:19
  wire [2:0]      s1_req_size = busy ? s1_req_reg_size : io_req_bits_size;	// Reg.scala:15:16, SourceD.scala:83:21, :87:19
  wire [9:0]      s1_req_set = busy ? s1_req_reg_set : io_req_bits_set;	// Reg.scala:15:16, SourceD.scala:83:21, :87:19
  wire [2:0]      s1_req_way = busy ? s1_req_reg_way : io_req_bits_way;	// Reg.scala:15:16, SourceD.scala:83:21, :87:19
  wire            _s1_valid_T = busy | io_req_valid;	// SourceD.scala:83:21, :89:40
  reg             s1_latch_bypass;	// SourceD.scala:89:32
  reg             s1_bypass_r;	// Reg.scala:15:16
  wire            s1_bypass = s1_latch_bypass ? s1_x_bypass : s1_bypass_r;	// Reg.scala:15:16, SourceD.scala:89:32, :90:22, :358:44
  wire            _s1_single_T_2 = s1_req_opcode == 3'h6;	// SourceD.scala:87:19, :92:33
  wire            s1_grant =
    _s1_single_T_2 & (busy ? s1_req_reg_param : io_req_bits_param) == 3'h2
    | (&s1_req_opcode);	// Reg.scala:15:16, SourceD.scala:83:21, :87:19, :92:{33,50,66,76,93}, :280:84
  wire            s1_need_r =
    ~s1_bypass & s1_req_prio_0 & s1_req_opcode != 3'h5 & ~s1_grant
    & ((|s1_req_opcode) | s1_req_size < 3'h3);	// SourceD.scala:87:19, :90:22, :91:78, :92:76, :93:{66,78,88}, :94:{34,50,65}
  wire            _io_bs_radr_valid_output = _s1_valid_T & s1_need_r & ~s1_block_r;	// SourceD.scala:84:27, :89:40, :93:88, :95:{56,59}
  wire [2:0]      s1_beat =
    (busy ? s1_req_reg_offset[5:3] : io_req_bits_offset[5:3]) | s1_counter;	// Reg.scala:15:16, SourceD.scala:83:21, :85:27, :87:19, :101:56
  reg             queue_io_enq_valid_REG;	// SourceD.scala:120:40
  reg             queue_io_enq_valid_REG_1;	// SourceD.scala:120:32
  reg             s2_full;	// SourceD.scala:146:24
  reg             s2_valid_pb;	// SourceD.scala:147:28
  reg  [2:0]      s2_beat;	// Reg.scala:15:16
  reg             s2_bypass;	// Reg.scala:15:16
  reg             s2_req_prio_0;	// Reg.scala:15:16
  reg             s2_req_prio_2;	// Reg.scala:15:16
  reg  [2:0]      s2_req_opcode;	// Reg.scala:15:16
  reg  [2:0]      s2_req_param;	// Reg.scala:15:16
  reg  [2:0]      s2_req_size;	// Reg.scala:15:16
  reg  [6:0]      s2_req_source;	// Reg.scala:15:16
  reg  [5:0]      s2_req_put;	// Reg.scala:15:16
  reg  [9:0]      s2_req_set;	// Reg.scala:15:16
  reg  [2:0]      s2_req_sink;	// Reg.scala:15:16
  reg  [2:0]      s2_req_way;	// Reg.scala:15:16
  reg             s2_req_bad;	// Reg.scala:15:16
  reg             s2_last;	// Reg.scala:15:16
  reg             s2_need_r;	// Reg.scala:15:16
  reg             s2_need_pb;	// Reg.scala:15:16
  reg             s2_retires;	// Reg.scala:15:16
  reg             s2_need_d;	// Reg.scala:15:16
  reg  [63:0]     s2_pdata_r_data;	// Reg.scala:15:16
  reg  [7:0]      s2_pdata_r_mask;	// Reg.scala:15:16
  reg             s2_pdata_r_corrupt;	// Reg.scala:15:16
  wire            pb_ready = s2_req_prio_0 ? io_pb_pop_ready : io_rel_pop_ready;	// Reg.scala:15:16, SourceD.scala:174:21
  wire            s2_ready = ~s2_full | s3_ready & (~s2_valid_pb | pb_ready);	// SourceD.scala:146:24, :147:28, :174:21, :182:27, :183:{15,24,37,54}, :241:24
  reg             s3_full;	// SourceD.scala:189:24
  reg             s3_valid_d;	// SourceD.scala:190:27
  reg  [2:0]      s3_beat;	// Reg.scala:15:16
  reg             s3_bypass;	// Reg.scala:15:16
  reg             s3_req_prio_0;	// Reg.scala:15:16
  reg             s3_req_prio_2;	// Reg.scala:15:16
  reg  [2:0]      s3_req_opcode;	// Reg.scala:15:16
  reg  [2:0]      s3_req_param;	// Reg.scala:15:16
  reg  [2:0]      s3_req_size;	// Reg.scala:15:16
  reg  [6:0]      s3_req_source;	// Reg.scala:15:16
  reg  [9:0]      s3_req_set;	// Reg.scala:15:16
  reg  [2:0]      s3_req_sink;	// Reg.scala:15:16
  reg  [2:0]      s3_req_way;	// Reg.scala:15:16
  reg             s3_req_bad;	// Reg.scala:15:16
  reg  [63:0]     s3_pdata_data;	// Reg.scala:15:16
  reg  [7:0]      s3_pdata_mask;	// Reg.scala:15:16
  reg             s3_pdata_corrupt;	// Reg.scala:15:16
  reg             s3_need_bs;	// Reg.scala:15:16
  reg             s3_retires;	// Reg.scala:15:16
  reg             s3_need_r;	// Reg.scala:15:16
  wire [7:0][2:0] _GEN =
    {{3'h4},
     {{2'h2, s3_req_param != 3'h2}},
     {3'h2},
     {3'h1},
     {3'h1},
     {3'h1},
     {3'h0},
     {3'h0}};	// Reg.scala:15:16, SourceD.scala:85:27, :194:31, :213:{18,32}, :221:24, :279:84, :280:84
  wire [2:0]      d_bits_opcode = s3_req_prio_0 ? _GEN[s3_req_opcode] : 3'h6;	// Reg.scala:15:16, SourceD.scala:92:33, :221:24
  wire            _queue_io_deq_ready_T = s3_valid & s4_ready;	// SourceD.scala:230:34, :240:23, :291:59
  assign s3_valid = s3_full & (~s3_valid_d | io_d_ready);	// SourceD.scala:189:24, :190:27, :240:{23,27,39}
  assign s3_ready = ~s3_full | s4_ready & (~s3_valid_d | io_d_ready);	// SourceD.scala:189:24, :190:27, :231:11, :240:27, :241:{24,37,53}, :291:59
  reg             s4_full;	// SourceD.scala:247:24
  reg  [2:0]      s4_beat;	// Reg.scala:15:16
  reg             s4_need_bs;	// Reg.scala:15:16
  reg             s4_need_pb;	// Reg.scala:15:16
  reg             s4_req_prio_2;	// Reg.scala:15:16
  reg  [2:0]      s4_req_param;	// Reg.scala:15:16
  reg  [9:0]      s4_req_set;	// Reg.scala:15:16
  reg  [2:0]      s4_req_way;	// Reg.scala:15:16
  reg  [2:0]      s4_adjusted_opcode;	// Reg.scala:15:16
  reg  [63:0]     s4_pdata_data;	// Reg.scala:15:16
  reg  [7:0]      s4_pdata_mask;	// Reg.scala:15:16
  reg             s4_pdata_corrupt;	// Reg.scala:15:16
  reg  [63:0]     s4_rdata;	// Reg.scala:15:16
  `ifndef SYNTHESIS	// SourceD.scala:122:10
    always @(posedge clock) begin	// SourceD.scala:122:10
      if (~(~queue_io_enq_valid_REG_1 | _queue_io_enq_ready | reset)) begin	// SourceD.scala:119:21, :120:32, :122:{10,11}
        if (`ASSERT_VERBOSE_COND_)	// SourceD.scala:122:10
          $error("Assertion failed\n    at SourceD.scala:122 assert (!queue.io.enq.valid || queue.io.enq.ready)\n");	// SourceD.scala:122:10
        if (`STOP_COND_)	// SourceD.scala:122:10
          $fatal;	// SourceD.scala:122:10
      end
      if (~(~s3_full | ~s3_need_r | _queue_io_deq_valid | reset)) begin	// Reg.scala:15:16, SourceD.scala:119:21, :189:24, :231:{10,11,23}
        if (`ASSERT_VERBOSE_COND_)	// SourceD.scala:231:10
          $error("Assertion failed\n    at SourceD.scala:231 assert (!s3_full || !s3_need_r || queue.io.deq.valid)\n");	// SourceD.scala:231:10
        if (`STOP_COND_)	// SourceD.scala:231:10
          $fatal;	// SourceD.scala:231:10
      end
      if (~(~(s4_full & s4_need_pb & s4_pdata_corrupt) | reset)) begin	// Reg.scala:15:16, SourceD.scala:247:24, :275:{10,11,35}
        if (`ASSERT_VERBOSE_COND_)	// SourceD.scala:275:10
          $error("Assertion failed: Data poisoning unsupported\n    at SourceD.scala:275 assert (!(s4_full && s4_need_pb && s4_pdata.corrupt), \"Data poisoning unsupported\")\n");	// SourceD.scala:275:10
        if (`STOP_COND_)	// SourceD.scala:275:10
          $fatal;	// SourceD.scala:275:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign s4_ready = ~s3_retires | ~s4_full | io_bs_wadr_ready | ~s4_need_bs;	// Reg.scala:15:16, SourceD.scala:247:24, :288:29, :291:{15,30,59}
  reg  [9:0]      s5_req_set;	// Reg.scala:15:16
  reg  [2:0]      s5_req_way;	// Reg.scala:15:16
  reg  [2:0]      s5_beat;	// Reg.scala:15:16
  reg  [63:0]     s5_dat;	// Reg.scala:15:16
  reg  [9:0]      s6_req_set;	// Reg.scala:15:16
  reg  [2:0]      s6_req_way;	// Reg.scala:15:16
  reg  [2:0]      s6_beat;	// Reg.scala:15:16
  reg  [63:0]     s6_dat;	// Reg.scala:15:16
  reg  [63:0]     s7_dat;	// Reg.scala:15:16
  reg             s3_bypass_data_REG;	// SourceD.scala:335:19
  reg  [63:0]     s3_bypass_data_REG_1;	// SourceD.scala:335:66
  assign s3_bypass_data =
    s3_bypass_data_REG ? _atomics_io_data_out : s3_bypass_data_REG_1;	// SourceD.scala:209:75, :257:23, :335:{19,66}
  assign s1_x_bypass =
    s2_req_set == s1_req_set & s2_req_way == s1_req_way & s2_beat == s1_beat & s2_full
    & s2_retires | s3_req_set == s1_req_set & s3_req_way == s1_req_way
    & s3_beat == s1_beat & s3_full & s3_retires | s4_req_set == s1_req_set
    & s4_req_way == s1_req_way & s4_beat == s1_beat & s4_full;	// Reg.scala:15:16, SourceD.scala:87:19, :101:56, :146:24, :189:24, :247:24, :342:{32,61,87,110}, :343:{32,61,87,110}, :344:{32,61,87,99}, :358:44
  always @(posedge clock) begin
    automatic logic        s1_single;	// SourceD.scala:97:22
    automatic logic [12:0] _s1_beats1_T_1 = 13'h3F << s1_req_size;	// SourceD.scala:87:19, package.scala:234:77
    automatic logic        s1_last;	// SourceD.scala:102:28
    automatic logic        _queue_io_enq_valid_T;	// Decoupled.scala:40:37
    automatic logic        s2_latch;	// SourceD.scala:128:18
    automatic logic        s3_latch;	// SourceD.scala:176:18
    automatic logic        s4_latch;	// SourceD.scala:246:41
    automatic logic        retire;	// SourceD.scala:298:24
    automatic logic [9:0]  pre_s3_req_set;	// SourceD.scala:313:24
    automatic logic [2:0]  pre_s3_req_way;	// SourceD.scala:313:24
    automatic logic [2:0]  pre_s3_beat;	// SourceD.scala:317:24
    s1_single = s1_req_prio_0 ? s1_req_opcode == 3'h5 | s1_grant : _s1_single_T_2;	// SourceD.scala:87:19, :92:{33,76}, :93:66, :97:{22,53,62}
    s1_last = s1_counter == (s1_single ? 3'h0 : ~(_s1_beats1_T_1[5:3]));	// SourceD.scala:85:27, :97:22, :100:22, :102:28, package.scala:234:{46,77,82}
    _queue_io_enq_valid_T = io_bs_radr_ready & _io_bs_radr_valid_output;	// Decoupled.scala:40:37, SourceD.scala:95:56
    s2_latch = _s1_valid_T & (~_io_bs_radr_valid_output | io_bs_radr_ready) & s2_ready;	// SourceD.scala:89:40, :95:56, :128:18, :140:{42,54}, :183:24
    s3_latch = s2_full & (~s2_valid_pb | pb_ready) & s3_ready;	// SourceD.scala:146:24, :147:28, :174:21, :176:18, :182:{27,40}, :241:24
    s4_latch = s3_valid & s3_retires & s4_ready;	// Reg.scala:15:16, SourceD.scala:240:23, :246:41, :291:59
    retire = s4_full & (io_bs_wadr_ready | ~s4_need_bs);	// Reg.scala:15:16, SourceD.scala:247:24, :288:29, :298:{24,45}
    pre_s3_req_set = s3_latch ? s2_req_set : s3_req_set;	// Reg.scala:15:16, SourceD.scala:176:18, :313:24
    pre_s3_req_way = s3_latch ? s2_req_way : s3_req_way;	// Reg.scala:15:16, SourceD.scala:176:18, :313:24
    pre_s3_beat = s3_latch ? s2_beat : s3_beat;	// Reg.scala:15:16, SourceD.scala:176:18, :317:24
    if (reset) begin
      busy <= 1'h0;	// SourceD.scala:83:21
      s1_block_r <= 1'h0;	// SourceD.scala:83:21, :84:27
      s1_counter <= 3'h0;	// SourceD.scala:85:27
      s2_full <= 1'h0;	// SourceD.scala:83:21, :146:24
      s2_valid_pb <= 1'h0;	// SourceD.scala:83:21, :147:28
      s3_full <= 1'h0;	// SourceD.scala:83:21, :189:24
      s3_valid_d <= 1'h0;	// SourceD.scala:83:21, :190:27
      s4_full <= 1'h0;	// SourceD.scala:83:21, :247:24
    end
    else begin
      busy <= ~(s2_latch & s1_last) & (io_req_valid | busy);	// SourceD.scala:83:21, :102:28, :127:{23,30}, :128:{18,31}, :131:20, :133:12
      s1_block_r <= ~s2_latch & (_queue_io_enq_valid_T | s1_block_r);	// Decoupled.scala:40:37, SourceD.scala:84:27, :126:{28,41}, :128:{18,31}, :130:16
      if (s2_latch) begin	// SourceD.scala:128:18
        if (s1_last)	// SourceD.scala:102:28
          s1_counter <= 3'h0;	// SourceD.scala:85:27
        else	// SourceD.scala:102:28
          s1_counter <= s1_counter + 3'h1;	// SourceD.scala:85:27, :129:30, :279:84
        if (s1_req_prio_0)	// SourceD.scala:87:19
          s2_valid_pb <= ~(s1_req_opcode[2]);	// SourceD.scala:87:19, :96:{40,54}, :147:28
        else	// SourceD.scala:87:19
          s2_valid_pb <= s1_req_opcode[0];	// SourceD.scala:87:19, :96:72, :147:28
      end
      else	// SourceD.scala:128:18
        s2_valid_pb <= ~pb_ready & s2_valid_pb;	// SourceD.scala:147:28, :174:21, :175:{19,33}
      s2_full <= s2_latch | ~s3_latch & s2_full;	// SourceD.scala:128:18, :146:24, :176:{18,31,41}, :178:{19,29}
      s3_full <= s3_latch | ~_queue_io_deq_ready_T & s3_full;	// SourceD.scala:176:18, :189:24, :230:34, :234:{31,41}, :236:{19,29}
      if (s3_latch)	// SourceD.scala:176:18
        s3_valid_d <= s2_need_d;	// Reg.scala:15:16, SourceD.scala:190:27
      else	// SourceD.scala:176:18
        s3_valid_d <= ~io_d_ready & s3_valid_d;	// SourceD.scala:190:27, :233:{18,31}
      s4_full <= s4_latch | ~(io_bs_wadr_ready | ~s4_need_bs) & s4_full;	// Reg.scala:15:16, SourceD.scala:246:41, :247:24, :288:{26,29,42,52}, :289:{19,29}
    end
    if (~busy & io_req_valid) begin	// SourceD.scala:83:21, :86:{43,49}
      s1_req_reg_prio_0 <= io_req_bits_prio_0;	// Reg.scala:15:16
      s1_req_reg_prio_2 <= io_req_bits_prio_2;	// Reg.scala:15:16
      s1_req_reg_opcode <= io_req_bits_opcode;	// Reg.scala:15:16
      s1_req_reg_param <= io_req_bits_param;	// Reg.scala:15:16
      s1_req_reg_size <= io_req_bits_size;	// Reg.scala:15:16
      s1_req_reg_source <= io_req_bits_source;	// Reg.scala:15:16
      s1_req_reg_offset <= io_req_bits_offset;	// Reg.scala:15:16
      s1_req_reg_put <= io_req_bits_put;	// Reg.scala:15:16
      s1_req_reg_set <= io_req_bits_set;	// Reg.scala:15:16
      s1_req_reg_sink <= io_req_bits_sink;	// Reg.scala:15:16
      s1_req_reg_way <= io_req_bits_way;	// Reg.scala:15:16
      s1_req_reg_bad <= io_req_bits_bad;	// Reg.scala:15:16
    end
    s1_latch_bypass <= ~_s1_valid_T | s2_ready;	// SourceD.scala:89:{32,33,40,57}, :183:24
    if (s1_latch_bypass)	// SourceD.scala:89:32
      s1_bypass_r <= s1_x_bypass;	// Reg.scala:15:16, SourceD.scala:358:44
    queue_io_enq_valid_REG <= _queue_io_enq_valid_T;	// Decoupled.scala:40:37, SourceD.scala:120:40
    queue_io_enq_valid_REG_1 <= queue_io_enq_valid_REG;	// SourceD.scala:120:{32,40}
    if (s2_latch) begin	// SourceD.scala:128:18
      s2_beat <= s1_beat;	// Reg.scala:15:16, SourceD.scala:101:56
      if (s1_latch_bypass)	// SourceD.scala:89:32
        s2_bypass <= s1_x_bypass;	// Reg.scala:15:16, SourceD.scala:358:44
      else	// SourceD.scala:89:32
        s2_bypass <= s1_bypass_r;	// Reg.scala:15:16
      if (busy) begin	// SourceD.scala:83:21
        s2_req_prio_0 <= s1_req_reg_prio_0;	// Reg.scala:15:16
        s2_req_prio_2 <= s1_req_reg_prio_2;	// Reg.scala:15:16
        s2_req_opcode <= s1_req_reg_opcode;	// Reg.scala:15:16
        s2_req_param <= s1_req_reg_param;	// Reg.scala:15:16
        s2_req_size <= s1_req_reg_size;	// Reg.scala:15:16
        s2_req_source <= s1_req_reg_source;	// Reg.scala:15:16
        s2_req_put <= s1_req_reg_put;	// Reg.scala:15:16
        s2_req_set <= s1_req_reg_set;	// Reg.scala:15:16
        s2_req_sink <= s1_req_reg_sink;	// Reg.scala:15:16
        s2_req_way <= s1_req_reg_way;	// Reg.scala:15:16
        s2_req_bad <= s1_req_reg_bad;	// Reg.scala:15:16
      end
      else begin	// SourceD.scala:83:21
        s2_req_prio_0 <= io_req_bits_prio_0;	// Reg.scala:15:16
        s2_req_prio_2 <= io_req_bits_prio_2;	// Reg.scala:15:16
        s2_req_opcode <= io_req_bits_opcode;	// Reg.scala:15:16
        s2_req_param <= io_req_bits_param;	// Reg.scala:15:16
        s2_req_size <= io_req_bits_size;	// Reg.scala:15:16
        s2_req_source <= io_req_bits_source;	// Reg.scala:15:16
        s2_req_put <= io_req_bits_put;	// Reg.scala:15:16
        s2_req_set <= io_req_bits_set;	// Reg.scala:15:16
        s2_req_sink <= io_req_bits_sink;	// Reg.scala:15:16
        s2_req_way <= io_req_bits_way;	// Reg.scala:15:16
        s2_req_bad <= io_req_bits_bad;	// Reg.scala:15:16
      end
      s2_last <= s1_last;	// Reg.scala:15:16, SourceD.scala:102:28
      s2_need_r <= s1_need_r;	// Reg.scala:15:16, SourceD.scala:93:88
      if (s1_req_prio_0)	// SourceD.scala:87:19
        s2_need_pb <= ~(s1_req_opcode[2]);	// Reg.scala:15:16, SourceD.scala:87:19, :96:{40,54}
      else	// SourceD.scala:87:19
        s2_need_pb <= s1_req_opcode[0];	// Reg.scala:15:16, SourceD.scala:87:19, :96:72
      s2_retires <= ~s1_single;	// Reg.scala:15:16, SourceD.scala:97:22, :98:20
      s2_need_d <=
        ~(s1_req_prio_0 ? ~(s1_req_opcode[2]) : s1_req_opcode[0]) | s1_counter == 3'h0;	// Reg.scala:15:16, SourceD.scala:85:27, :87:19, :96:{23,40,54,72}, :103:29, :155:{29,41}
    end
    if (s2_valid_pb) begin	// SourceD.scala:147:28
      if (s2_req_prio_0) begin	// Reg.scala:15:16
        s2_pdata_r_data <= io_pb_beat_data;	// Reg.scala:15:16
        s2_pdata_r_mask <= io_pb_beat_mask;	// Reg.scala:15:16
        s2_pdata_r_corrupt <= io_pb_beat_corrupt;	// Reg.scala:15:16
      end
      else begin	// Reg.scala:15:16
        s2_pdata_r_data <= io_rel_beat_data;	// Reg.scala:15:16
        s2_pdata_r_mask <= 8'hFF;	// Reg.scala:15:16, SourceD.scala:160:64
        s2_pdata_r_corrupt <= io_rel_beat_corrupt;	// Reg.scala:15:16
      end
    end
    if (s3_latch) begin	// SourceD.scala:176:18
      s3_beat <= s2_beat;	// Reg.scala:15:16
      s3_bypass <= s2_bypass;	// Reg.scala:15:16
      s3_req_prio_0 <= s2_req_prio_0;	// Reg.scala:15:16
      s3_req_prio_2 <= s2_req_prio_2;	// Reg.scala:15:16
      s3_req_opcode <= s2_req_opcode;	// Reg.scala:15:16
      s3_req_param <= s2_req_param;	// Reg.scala:15:16
      s3_req_size <= s2_req_size;	// Reg.scala:15:16
      s3_req_source <= s2_req_source;	// Reg.scala:15:16
      s3_req_set <= s2_req_set;	// Reg.scala:15:16
      s3_req_sink <= s2_req_sink;	// Reg.scala:15:16
      s3_req_way <= s2_req_way;	// Reg.scala:15:16
      s3_req_bad <= s2_req_bad;	// Reg.scala:15:16
      if (s2_valid_pb) begin	// SourceD.scala:147:28
        if (s2_req_prio_0) begin	// Reg.scala:15:16
          s3_pdata_data <= io_pb_beat_data;	// Reg.scala:15:16
          s3_pdata_mask <= io_pb_beat_mask;	// Reg.scala:15:16
          s3_pdata_corrupt <= io_pb_beat_corrupt;	// Reg.scala:15:16
        end
        else begin	// Reg.scala:15:16
          s3_pdata_data <= io_rel_beat_data;	// Reg.scala:15:16
          s3_pdata_mask <= 8'hFF;	// Reg.scala:15:16, SourceD.scala:160:64
          s3_pdata_corrupt <= io_rel_beat_corrupt;	// Reg.scala:15:16
        end
      end
      else begin	// SourceD.scala:147:28
        s3_pdata_data <= s2_pdata_r_data;	// Reg.scala:15:16
        s3_pdata_mask <= s2_pdata_r_mask;	// Reg.scala:15:16
        s3_pdata_corrupt <= s2_pdata_r_corrupt;	// Reg.scala:15:16
      end
      s3_need_bs <= s2_need_pb;	// Reg.scala:15:16
      s3_retires <= s2_retires;	// Reg.scala:15:16
      s3_need_r <= s2_need_r;	// Reg.scala:15:16
    end
    if (s4_latch) begin	// SourceD.scala:246:41
      s4_beat <= s3_beat;	// Reg.scala:15:16
      s4_need_bs <= s3_need_bs;	// Reg.scala:15:16
      s4_need_pb <= s3_need_bs;	// Reg.scala:15:16
      s4_req_prio_2 <= s3_req_prio_2;	// Reg.scala:15:16
      s4_req_param <= s3_req_param;	// Reg.scala:15:16
      s4_req_set <= s3_req_set;	// Reg.scala:15:16
      s4_req_way <= s3_req_way;	// Reg.scala:15:16
      if (s3_req_bad)	// Reg.scala:15:16
        s4_adjusted_opcode <= 3'h4;	// Reg.scala:15:16, SourceD.scala:194:31
      else	// Reg.scala:15:16
        s4_adjusted_opcode <= s3_req_opcode;	// Reg.scala:15:16
      s4_pdata_data <= s3_pdata_data;	// Reg.scala:15:16
      s4_pdata_mask <= s3_pdata_mask;	// Reg.scala:15:16
      s4_pdata_corrupt <= s3_pdata_corrupt;	// Reg.scala:15:16
      if (s3_bypass) begin	// Reg.scala:15:16
        if (s3_bypass_data_REG)	// SourceD.scala:335:19
          s4_rdata <= _atomics_io_data_out;	// Reg.scala:15:16, SourceD.scala:257:23
        else	// SourceD.scala:335:19
          s4_rdata <= s3_bypass_data_REG_1;	// Reg.scala:15:16, SourceD.scala:335:66
      end
      else	// Reg.scala:15:16
        s4_rdata <= _queue_io_deq_bits_data;	// Reg.scala:15:16, SourceD.scala:119:21
    end
    if (retire) begin	// SourceD.scala:298:24
      s5_req_set <= s4_req_set;	// Reg.scala:15:16
      s5_req_way <= s4_req_way;	// Reg.scala:15:16
      s5_beat <= s4_beat;	// Reg.scala:15:16
      s5_dat <= _atomics_io_data_out;	// Reg.scala:15:16, SourceD.scala:257:23
      s6_req_set <= s5_req_set;	// Reg.scala:15:16
      s6_req_way <= s5_req_way;	// Reg.scala:15:16
      s6_beat <= s5_beat;	// Reg.scala:15:16
      s6_dat <= s5_dat;	// Reg.scala:15:16
      s7_dat <= s6_dat;	// Reg.scala:15:16
    end
    s3_bypass_data_REG <=
      (s4_latch ? s3_req_set : s4_req_set) == pre_s3_req_set
      & (s4_latch ? s3_req_way : s4_req_way) == pre_s3_req_way
      & (s4_latch ? s3_beat : s4_beat) == pre_s3_beat
      & (s4_latch | ~(io_bs_wadr_ready | ~s4_need_bs) & s4_full);	// Reg.scala:15:16, SourceD.scala:246:41, :247:24, :288:29, :313:24, :314:24, :317:24, :318:24, :324:{30,34,53,69}, :326:{40,77,111,127}, :335:19
    if ((retire ? s4_req_set : s5_req_set) == pre_s3_req_set
        & (retire ? s4_req_way : s5_req_way) == pre_s3_req_way
        & (retire ? s4_beat : s5_beat) == pre_s3_beat) begin	// Reg.scala:15:16, SourceD.scala:298:24, :313:24, :315:24, :317:24, :319:24, :327:{40,77,96,111}
      if (retire)	// SourceD.scala:298:24
        s3_bypass_data_REG_1 <= _atomics_io_data_out;	// SourceD.scala:257:23, :335:66
      else	// SourceD.scala:298:24
        s3_bypass_data_REG_1 <= s5_dat;	// Reg.scala:15:16, SourceD.scala:335:66
    end
    else if ((retire ? s5_req_set : s6_req_set) == pre_s3_req_set
             & (retire ? s5_req_way : s6_req_way) == pre_s3_req_way
             & (retire ? s5_beat : s6_beat) == pre_s3_beat) begin	// Reg.scala:15:16, SourceD.scala:298:24, :313:24, :316:24, :317:24, :320:24, :328:{40,77,96,111}
      if (retire)	// SourceD.scala:298:24
        s3_bypass_data_REG_1 <= s5_dat;	// Reg.scala:15:16, SourceD.scala:335:66
      else	// SourceD.scala:298:24
        s3_bypass_data_REG_1 <= s6_dat;	// Reg.scala:15:16, SourceD.scala:335:66
    end
    else if (retire)	// SourceD.scala:298:24
      s3_bypass_data_REG_1 <= s6_dat;	// Reg.scala:15:16, SourceD.scala:335:66
    else	// SourceD.scala:298:24
      s3_bypass_data_REG_1 <= s7_dat;	// Reg.scala:15:16, SourceD.scala:335:66
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:29];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h1E; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        busy = _RANDOM[5'h0][0];	// SourceD.scala:83:21
        s1_block_r = _RANDOM[5'h0][1];	// SourceD.scala:83:21, :84:27
        s1_counter = _RANDOM[5'h0][4:2];	// SourceD.scala:83:21, :85:27
        s1_req_reg_prio_0 = _RANDOM[5'h0][5];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_prio_2 = _RANDOM[5'h0][7];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_opcode = _RANDOM[5'h0][11:9];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_param = _RANDOM[5'h0][14:12];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_size = _RANDOM[5'h0][17:15];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_source = _RANDOM[5'h0][24:18];	// Reg.scala:15:16, SourceD.scala:83:21
        s1_req_reg_offset = _RANDOM[5'h1][11:6];	// Reg.scala:15:16
        s1_req_reg_put = _RANDOM[5'h1][17:12];	// Reg.scala:15:16
        s1_req_reg_set = _RANDOM[5'h1][27:18];	// Reg.scala:15:16
        s1_req_reg_sink = _RANDOM[5'h1][30:28];	// Reg.scala:15:16
        s1_req_reg_way = {_RANDOM[5'h1][31], _RANDOM[5'h2][1:0]};	// Reg.scala:15:16
        s1_req_reg_bad = _RANDOM[5'h2][2];	// Reg.scala:15:16
        s1_latch_bypass = _RANDOM[5'h2][3];	// Reg.scala:15:16, SourceD.scala:89:32
        s1_bypass_r = _RANDOM[5'h2][4];	// Reg.scala:15:16
        queue_io_enq_valid_REG = _RANDOM[5'h2][5];	// Reg.scala:15:16, SourceD.scala:120:40
        queue_io_enq_valid_REG_1 = _RANDOM[5'h2][6];	// Reg.scala:15:16, SourceD.scala:120:32
        s2_full = _RANDOM[5'h2][7];	// Reg.scala:15:16, SourceD.scala:146:24
        s2_valid_pb = _RANDOM[5'h2][8];	// Reg.scala:15:16, SourceD.scala:147:28
        s2_beat = _RANDOM[5'h2][11:9];	// Reg.scala:15:16
        s2_bypass = _RANDOM[5'h2][12];	// Reg.scala:15:16
        s2_req_prio_0 = _RANDOM[5'h2][13];	// Reg.scala:15:16
        s2_req_prio_2 = _RANDOM[5'h2][15];	// Reg.scala:15:16
        s2_req_opcode = _RANDOM[5'h2][19:17];	// Reg.scala:15:16
        s2_req_param = _RANDOM[5'h2][22:20];	// Reg.scala:15:16
        s2_req_size = _RANDOM[5'h2][25:23];	// Reg.scala:15:16
        s2_req_source = {_RANDOM[5'h2][31:26], _RANDOM[5'h3][0]};	// Reg.scala:15:16
        s2_req_put = _RANDOM[5'h3][25:20];	// Reg.scala:15:16
        s2_req_set = {_RANDOM[5'h3][31:26], _RANDOM[5'h4][3:0]};	// Reg.scala:15:16
        s2_req_sink = _RANDOM[5'h4][6:4];	// Reg.scala:15:16
        s2_req_way = _RANDOM[5'h4][9:7];	// Reg.scala:15:16
        s2_req_bad = _RANDOM[5'h4][10];	// Reg.scala:15:16
        s2_last = _RANDOM[5'h4][11];	// Reg.scala:15:16
        s2_need_r = _RANDOM[5'h4][12];	// Reg.scala:15:16
        s2_need_pb = _RANDOM[5'h4][13];	// Reg.scala:15:16
        s2_retires = _RANDOM[5'h4][14];	// Reg.scala:15:16
        s2_need_d = _RANDOM[5'h4][15];	// Reg.scala:15:16
        s2_pdata_r_data = {_RANDOM[5'h4][31:16], _RANDOM[5'h5], _RANDOM[5'h6][15:0]};	// Reg.scala:15:16
        s2_pdata_r_mask = _RANDOM[5'h6][23:16];	// Reg.scala:15:16
        s2_pdata_r_corrupt = _RANDOM[5'h6][24];	// Reg.scala:15:16
        s3_full = _RANDOM[5'h6][25];	// Reg.scala:15:16, SourceD.scala:189:24
        s3_valid_d = _RANDOM[5'h6][26];	// Reg.scala:15:16, SourceD.scala:190:27
        s3_beat = _RANDOM[5'h6][29:27];	// Reg.scala:15:16
        s3_bypass = _RANDOM[5'h6][30];	// Reg.scala:15:16
        s3_req_prio_0 = _RANDOM[5'h6][31];	// Reg.scala:15:16
        s3_req_prio_2 = _RANDOM[5'h7][1];	// Reg.scala:15:16
        s3_req_opcode = _RANDOM[5'h7][5:3];	// Reg.scala:15:16
        s3_req_param = _RANDOM[5'h7][8:6];	// Reg.scala:15:16
        s3_req_size = _RANDOM[5'h7][11:9];	// Reg.scala:15:16
        s3_req_source = _RANDOM[5'h7][18:12];	// Reg.scala:15:16
        s3_req_set = _RANDOM[5'h8][21:12];	// Reg.scala:15:16
        s3_req_sink = _RANDOM[5'h8][24:22];	// Reg.scala:15:16
        s3_req_way = _RANDOM[5'h8][27:25];	// Reg.scala:15:16
        s3_req_bad = _RANDOM[5'h8][28];	// Reg.scala:15:16
        s3_pdata_data = {_RANDOM[5'h8][31:30], _RANDOM[5'h9], _RANDOM[5'hA][29:0]};	// Reg.scala:15:16
        s3_pdata_mask = {_RANDOM[5'hA][31:30], _RANDOM[5'hB][5:0]};	// Reg.scala:15:16
        s3_pdata_corrupt = _RANDOM[5'hB][6];	// Reg.scala:15:16
        s3_need_bs = _RANDOM[5'hB][7];	// Reg.scala:15:16
        s3_retires = _RANDOM[5'hB][8];	// Reg.scala:15:16
        s3_need_r = _RANDOM[5'hB][9];	// Reg.scala:15:16
        s4_full = _RANDOM[5'hB][10];	// Reg.scala:15:16, SourceD.scala:247:24
        s4_beat = _RANDOM[5'hB][13:11];	// Reg.scala:15:16
        s4_need_bs = _RANDOM[5'hB][15];	// Reg.scala:15:16
        s4_need_pb = _RANDOM[5'hB][16];	// Reg.scala:15:16
        s4_req_prio_2 = _RANDOM[5'hB][19];	// Reg.scala:15:16
        s4_req_param = _RANDOM[5'hB][26:24];	// Reg.scala:15:16
        s4_req_set = {_RANDOM[5'hC][31:30], _RANDOM[5'hD][7:0]};	// Reg.scala:15:16
        s4_req_way = _RANDOM[5'hD][13:11];	// Reg.scala:15:16
        s4_adjusted_opcode = _RANDOM[5'hD][17:15];	// Reg.scala:15:16
        s4_pdata_data = {_RANDOM[5'hD][31:18], _RANDOM[5'hE], _RANDOM[5'hF][17:0]};	// Reg.scala:15:16
        s4_pdata_mask = _RANDOM[5'hF][25:18];	// Reg.scala:15:16
        s4_pdata_corrupt = _RANDOM[5'hF][26];	// Reg.scala:15:16
        s4_rdata = {_RANDOM[5'hF][31:27], _RANDOM[5'h10], _RANDOM[5'h11][26:0]};	// Reg.scala:15:16
        s5_req_set = _RANDOM[5'h13][17:8];	// Reg.scala:15:16
        s5_req_way = _RANDOM[5'h13][23:21];	// Reg.scala:15:16
        s5_beat = _RANDOM[5'h13][27:25];	// Reg.scala:15:16
        s5_dat = {_RANDOM[5'h13][31:28], _RANDOM[5'h14], _RANDOM[5'h15][27:0]};	// Reg.scala:15:16
        s6_req_set = _RANDOM[5'h17][18:9];	// Reg.scala:15:16
        s6_req_way = _RANDOM[5'h17][24:22];	// Reg.scala:15:16
        s6_beat = _RANDOM[5'h17][28:26];	// Reg.scala:15:16
        s6_dat = {_RANDOM[5'h17][31:29], _RANDOM[5'h18], _RANDOM[5'h19][28:0]};	// Reg.scala:15:16
        s7_dat = {_RANDOM[5'h19][31:29], _RANDOM[5'h1A], _RANDOM[5'h1B][28:0]};	// Reg.scala:15:16
        s3_bypass_data_REG = _RANDOM[5'h1B][29];	// Reg.scala:15:16, SourceD.scala:335:19
        s3_bypass_data_REG_1 =
          {_RANDOM[5'h1B][31:30], _RANDOM[5'h1C], _RANDOM[5'h1D][29:0]};	// Reg.scala:15:16, SourceD.scala:335:66
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  QueueCompatibility_21 queue (	// SourceD.scala:119:21
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (queue_io_enq_valid_REG_1),	// SourceD.scala:120:32
    .io_enq_bits_data (io_bs_rdat_data),
    .io_deq_ready     (_queue_io_deq_ready_T & s3_need_r),	// Reg.scala:15:16, SourceD.scala:230:{34,46}
    .io_enq_ready     (_queue_io_enq_ready),
    .io_deq_valid     (_queue_io_deq_valid),
    .io_deq_bits_data (_queue_io_deq_bits_data)
  );
  Atomics atomics (	// SourceD.scala:257:23
    .io_write    (s4_req_prio_2),	// Reg.scala:15:16
    .io_a_opcode (s4_adjusted_opcode),	// Reg.scala:15:16
    .io_a_param  (s4_req_param),	// Reg.scala:15:16
    .io_a_mask   (s4_pdata_mask),	// Reg.scala:15:16
    .io_a_data   (s4_pdata_data),	// Reg.scala:15:16
    .io_data_in  (s4_rdata),	// Reg.scala:15:16
    .io_data_out (_atomics_io_data_out)
  );
  assign io_req_ready = ~busy;	// SourceD.scala:83:21, :86:43
  assign io_d_valid = s3_valid_d;	// SourceD.scala:190:27
  assign io_d_bits_opcode = d_bits_opcode;	// SourceD.scala:221:24
  assign io_d_bits_param =
    s3_req_prio_0 & (s3_req_opcode == 3'h6 | (&s3_req_opcode))
      ? {1'h0, s3_req_param == 3'h0}
      : 2'h0;	// Reg.scala:15:16, SourceD.scala:83:21, :85:27, :92:33, :201:{30,47,64}, :222:{24,40,54,68}
  assign io_d_bits_size = s3_req_size;	// Reg.scala:15:16
  assign io_d_bits_source = s3_req_source;	// Reg.scala:15:16
  assign io_d_bits_sink = s3_req_sink;	// Reg.scala:15:16
  assign io_d_bits_denied = s3_req_bad;	// Reg.scala:15:16
  assign io_d_bits_data = s3_bypass ? s3_bypass_data : _queue_io_deq_bits_data;	// Reg.scala:15:16, SourceD.scala:119:21, :209:75
  assign io_d_bits_corrupt = s3_req_bad & d_bits_opcode[0];	// Reg.scala:15:16, SourceD.scala:221:24, :228:{32,48}
  assign io_pb_pop_valid = s2_valid_pb & s2_req_prio_0;	// Reg.scala:15:16, SourceD.scala:147:28, :163:34
  assign io_pb_pop_bits_index = s2_req_put;	// Reg.scala:15:16
  assign io_pb_pop_bits_last = s2_last;	// Reg.scala:15:16
  assign io_rel_pop_valid = s2_valid_pb & ~s2_req_prio_0;	// Reg.scala:15:16, SourceD.scala:147:28, :166:{35,38}
  assign io_rel_pop_bits_index = s2_req_put;	// Reg.scala:15:16
  assign io_rel_pop_bits_last = s2_last;	// Reg.scala:15:16
  assign io_bs_radr_valid = _io_bs_radr_valid_output;	// SourceD.scala:95:56
  assign io_bs_radr_bits_way = s1_req_way;	// SourceD.scala:87:19
  assign io_bs_radr_bits_set = s1_req_set;	// SourceD.scala:87:19
  assign io_bs_radr_bits_beat = s1_beat;	// SourceD.scala:101:56
  assign io_bs_radr_bits_mask = ~s1_bypass;	// SourceD.scala:90:22, :91:78
  assign io_bs_wadr_valid = s4_full & s4_need_bs;	// Reg.scala:15:16, SourceD.scala:247:24, :268:31
  assign io_bs_wadr_bits_way = s4_req_way;	// Reg.scala:15:16
  assign io_bs_wadr_bits_set = s4_req_set;	// Reg.scala:15:16
  assign io_bs_wadr_bits_beat = s4_beat;	// Reg.scala:15:16
  assign io_bs_wadr_bits_mask = |s4_pdata_mask;	// Reg.scala:15:16, SourceD.scala:273:87
  assign io_bs_wdat_data = _atomics_io_data_out;	// SourceD.scala:257:23
  assign io_evict_safe =
    (~busy | io_evict_req_way != s1_req_reg_way | io_evict_req_set != s1_req_reg_set)
    & (~s2_full | io_evict_req_way != s2_req_way | io_evict_req_set != s2_req_set)
    & (~s3_full | io_evict_req_way != s3_req_way | io_evict_req_set != s3_req_set)
    & (~s4_full | io_evict_req_way != s4_req_way | io_evict_req_set != s4_req_set);	// Reg.scala:15:16, SourceD.scala:83:21, :86:43, :146:24, :183:15, :189:24, :231:11, :247:24, :291:30, :374:{35,54,74}, :375:{35,54,74}, :376:{35,54,74,90}, :377:{35,54,74}
  assign io_grant_safe =
    (~busy | io_grant_req_way != s1_req_reg_way | io_grant_req_set != s1_req_reg_set)
    & (~s2_full | io_grant_req_way != s2_req_way | io_grant_req_set != s2_req_set)
    & (~s3_full | io_grant_req_way != s3_req_way | io_grant_req_set != s3_req_set)
    & (~s4_full | io_grant_req_way != s4_req_way | io_grant_req_set != s4_req_set);	// Reg.scala:15:16, SourceD.scala:83:21, :86:43, :146:24, :183:15, :189:24, :231:11, :247:24, :291:30, :381:{35,54,74}, :382:{35,54,74}, :383:{35,54,74,90}, :384:{35,54,74}
endmodule

