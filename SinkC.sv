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

module SinkC(
  input         clock,
                reset,
                io_req_ready,
                io_c_valid,
  input  [2:0]  io_c_bits_opcode,
                io_c_bits_param,
                io_c_bits_size,
  input  [6:0]  io_c_bits_source,
  input  [31:0] io_c_bits_address,
  input  [63:0] io_c_bits_data,
  input         io_c_bits_corrupt,
  input  [2:0]  io_way,
  input         io_bs_adr_ready,
                io_rel_pop_valid,
  input  [5:0]  io_rel_pop_bits_index,
  input         io_rel_pop_bits_last,
  output        io_req_valid,
  output [2:0]  io_req_bits_opcode,
                io_req_bits_param,
                io_req_bits_size,
  output [6:0]  io_req_bits_source,
  output [12:0] io_req_bits_tag,
  output [5:0]  io_req_bits_offset,
                io_req_bits_put,
  output [9:0]  io_req_bits_set,
  output        io_resp_valid,
                io_resp_bits_last,
  output [9:0]  io_resp_bits_set,
  output [12:0] io_resp_bits_tag,
  output [6:0]  io_resp_bits_source,
  output [2:0]  io_resp_bits_param,
  output        io_resp_bits_data,
                io_c_ready,
  output [9:0]  io_set,
  output        io_bs_adr_valid,
                io_bs_adr_bits_noop,
  output [2:0]  io_bs_adr_bits_way,
  output [9:0]  io_bs_adr_bits_set,
  output [2:0]  io_bs_adr_bits_beat,
  output        io_bs_adr_bits_mask,
  output [63:0] io_bs_dat_data,
  output        io_rel_pop_ready,
  output [63:0] io_rel_beat_data,
  output        io_rel_beat_corrupt
);

  wire        _io_rel_pop_ready_output;	// SinkC.scala:154:43
  wire        _putbuffer_io_push_ready;	// SinkC.scala:109:27
  wire [1:0]  _putbuffer_io_valid;	// SinkC.scala:109:27
  wire        _io_bs_adr_q_io_enq_ready;	// Decoupled.scala:296:21
  wire        _c_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0]  _c_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [2:0]  _c_io_deq_bits_param;	// Decoupled.scala:296:21
  wire [2:0]  _c_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [6:0]  _c_io_deq_bits_source;	// Decoupled.scala:296:21
  wire [31:0] _c_io_deq_bits_address;	// Decoupled.scala:296:21
  wire [63:0] _c_io_deq_bits_data;	// Decoupled.scala:296:21
  wire        _c_io_deq_bits_corrupt;	// Decoupled.scala:296:21
  wire [12:0] tag = {_c_io_deq_bits_address[31], _c_io_deq_bits_address[27:16]};	// Decoupled.scala:296:21, Parameters.scala:211:47, :212:22, :213:19
  wire [12:0] _beats1_decode_T_1 = 13'h3F << _c_io_deq_bits_size;	// Decoupled.scala:296:21, package.scala:234:77
  wire [2:0]  beats1 = _c_io_deq_bits_opcode[0] ? ~(_beats1_decode_T_1[5:3]) : 3'h0;	// Decoupled.scala:296:21, Edges.scala:101:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [2:0]  counter;	// Edges.scala:228:27
  wire [2:0]  _counter1_T = counter - 3'h1;	// Edges.scala:228:27, :229:28
  wire        last = counter == 3'h1 | beats1 == 3'h0;	// Edges.scala:220:14, :228:27, :231:{25,37,47}
  wire [2:0]  beat = beats1 & ~_counter1_T;	// Edges.scala:220:14, :229:28, :233:{25,27}
  wire        raw_resp = _c_io_deq_bits_opcode == 3'h4 | _c_io_deq_bits_opcode == 3'h5;	// Decoupled.scala:296:21, SinkC.scala:72:{34,58,75}
  reg         resp_r;	// Reg.scala:15:16
  wire        resp = _c_io_deq_valid ? raw_resp : resp_r;	// Decoupled.scala:296:21, Reg.scala:15:16, SinkC.scala:72:58, :73:19
  `ifndef SYNTHESIS	// SinkC.scala:84:12
    always @(posedge clock) begin	// SinkC.scala:84:12
      if (~(~(_c_io_deq_valid & _c_io_deq_bits_corrupt) | reset)) begin	// Decoupled.scala:296:21, SinkC.scala:84:{12,13,23}
        if (`ASSERT_VERBOSE_COND_)	// SinkC.scala:84:12
          $error("Assertion failed: Data poisoning unavailable\n    at SinkC.scala:84 assert (!(c.valid && c.bits.corrupt), \"Data poisoning unavailable\")\n");	// SinkC.scala:84:12
        if (`STOP_COND_)	// SinkC.scala:84:12
          $fatal;	// SinkC.scala:84:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg  [9:0]  io_set_r;	// Reg.scala:15:16
  wire [9:0]  _io_set_output = _c_io_deq_valid ? _c_io_deq_bits_address[15:6] : io_set_r;	// Decoupled.scala:296:21, Parameters.scala:212:22, :214:28, Reg.scala:15:16, SinkC.scala:86:18
  reg  [63:0] io_bs_dat_data_r;	// Reg.scala:15:16
  wire        bs_adr_valid =
    resp & ((|counter) | _c_io_deq_valid & _c_io_deq_bits_opcode[0]);	// Decoupled.scala:296:21, Edges.scala:101:36, :228:27, :230:25, SinkC.scala:73:19, :93:{30,41,53}
  reg  [2:0]  bs_adr_bits_beat_r;	// Reg.scala:15:16
  reg  [1:0]  lists;	// SinkC.scala:110:24
  wire [1:0]  _freeOH_T_7 = ~lists;	// SinkC.scala:110:24, :117:27
  wire [1:0]  freeIdx_lo = {~(_freeOH_T_7[0]), 1'h1} & _freeOH_T_7;	// Edges.scala:229:28, SinkC.scala:117:{18,27,41}
  wire [1:0]  freeIdx = {1'h0, freeIdx_lo[1]};	// Cat.scala:30:58, CircuitMath.scala:30:8, Edges.scala:229:28, SinkC.scala:117:41
  wire        req_block = ~(|counter) & ~io_req_ready;	// Edges.scala:228:27, :230:25, SinkC.scala:120:{27,30}
  wire        buf_block = _c_io_deq_bits_opcode[0] & ~_putbuffer_io_push_ready;	// Decoupled.scala:296:21, Edges.scala:101:36, SinkC.scala:109:27, :121:{29,32}
  wire        set_block = _c_io_deq_bits_opcode[0] & ~(|counter) & (&lists);	// Decoupled.scala:296:21, Edges.scala:101:36, :228:27, :230:25, SinkC.scala:110:24, :116:27, :122:38
  wire        _c_io_deq_ready_T_7 =
    raw_resp
      ? ~(_c_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready
      : ~req_block & ~buf_block & ~set_block;	// Decoupled.scala:296:21, Edges.scala:101:36, SinkC.scala:72:58, :101:61, :120:27, :121:29, :122:38, :128:{19,39,56,70,81,84}
  reg  [1:0]  put_r;	// Reg.scala:15:16
  wire [1:0]  put = (|counter) ? put_r : freeIdx;	// Cat.scala:30:58, Edges.scala:228:27, :230:25, Reg.scala:15:16, SinkC.scala:134:18
  wire        _putbuffer_io_pop_valid_T = _io_rel_pop_ready_output & io_rel_pop_valid;	// Decoupled.scala:40:37, SinkC.scala:154:43
  wire [5:0]  _io_rel_pop_ready_T = {4'h0, _putbuffer_io_valid} >> io_rel_pop_bits_index;	// SinkC.scala:109:27, :145:24, :154:43
  assign _io_rel_pop_ready_output = _io_rel_pop_ready_T[0];	// SinkC.scala:154:43
  always @(posedge clock) begin
    if (reset) begin
      counter <= 3'h0;	// Edges.scala:228:27
      lists <= 2'h0;	// SinkC.scala:110:24
    end
    else begin
      if (_c_io_deq_ready_T_7 & _c_io_deq_valid) begin	// Decoupled.scala:40:37, :296:21, SinkC.scala:128:19
        if (|counter)	// Edges.scala:228:27, :230:25
          counter <= _counter1_T;	// Edges.scala:228:27, :229:28
        else if (_c_io_deq_bits_opcode[0])	// Decoupled.scala:296:21, Edges.scala:101:36
          counter <= ~(_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        else	// Edges.scala:101:36
          counter <= 3'h0;	// Edges.scala:228:27
      end
      lists <=
        (lists
         | (~resp & _c_io_deq_valid & ~(|counter) & _c_io_deq_bits_opcode[0] & ~req_block
            & ~buf_block
              ? freeIdx_lo
              : 2'h0))
        & ~(_putbuffer_io_pop_valid_T & io_rel_pop_bits_last
              ? 2'h1 << io_rel_pop_bits_index[0]
              : 2'h0);	// Decoupled.scala:40:37, :296:21, Edges.scala:101:36, :228:27, :230:25, OneHot.scala:64:49, :65:12, SinkC.scala:73:19, :110:24, :114:{21,34,36}, :117:41, :120:27, :121:29, :128:{56,70}, :130:21, :132:{62,77,89}, :157:{29,54}, :158:17
    end
    if (_c_io_deq_valid) begin	// Decoupled.scala:296:21
      resp_r <= raw_resp;	// Reg.scala:15:16, SinkC.scala:72:58
      io_set_r <= _c_io_deq_bits_address[15:6];	// Decoupled.scala:296:21, Parameters.scala:212:22, :214:28, Reg.scala:15:16
      bs_adr_bits_beat_r <= beat + {2'h0, _io_bs_adr_q_io_enq_ready};	// Decoupled.scala:296:21, Edges.scala:233:25, Reg.scala:15:16, SinkC.scala:97:59
    end
    if (_io_bs_adr_q_io_enq_ready & bs_adr_valid)	// Decoupled.scala:40:37, :296:21, SinkC.scala:93:30
      io_bs_dat_data_r <= _c_io_deq_bits_data;	// Decoupled.scala:296:21, Reg.scala:15:16
    if (~(|counter))	// Edges.scala:228:27, :230:25
      put_r <= freeIdx;	// Cat.scala:30:58, Reg.scala:15:16
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:2];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        counter = _RANDOM[2'h0][2:0];	// Edges.scala:228:27
        resp_r = _RANDOM[2'h0][3];	// Edges.scala:228:27, Reg.scala:15:16
        io_set_r = _RANDOM[2'h0][13:4];	// Edges.scala:228:27, Reg.scala:15:16
        io_bs_dat_data_r = {_RANDOM[2'h0][31:14], _RANDOM[2'h1], _RANDOM[2'h2][13:0]};	// Edges.scala:228:27, Reg.scala:15:16
        bs_adr_bits_beat_r = _RANDOM[2'h2][16:14];	// Reg.scala:15:16
        lists = _RANDOM[2'h2][18:17];	// Reg.scala:15:16, SinkC.scala:110:24
        put_r = _RANDOM[2'h2][20:19];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Queue_23 c (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_c_valid),
    .io_enq_bits_opcode  (io_c_bits_opcode),
    .io_enq_bits_param   (io_c_bits_param),
    .io_enq_bits_size    (io_c_bits_size),
    .io_enq_bits_source  (io_c_bits_source),
    .io_enq_bits_address (io_c_bits_address),
    .io_enq_bits_data    (io_c_bits_data),
    .io_enq_bits_corrupt (io_c_bits_corrupt),
    .io_deq_ready        (_c_io_deq_ready_T_7),	// SinkC.scala:128:19
    .io_enq_ready        (io_c_ready),
    .io_deq_valid        (_c_io_deq_valid),
    .io_deq_bits_opcode  (_c_io_deq_bits_opcode),
    .io_deq_bits_param   (_c_io_deq_bits_param),
    .io_deq_bits_size    (_c_io_deq_bits_size),
    .io_deq_bits_source  (_c_io_deq_bits_source),
    .io_deq_bits_address (_c_io_deq_bits_address),
    .io_deq_bits_data    (_c_io_deq_bits_data),
    .io_deq_bits_corrupt (_c_io_deq_bits_corrupt)
  );
  Queue_24 io_bs_adr_q (	// Decoupled.scala:296:21
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (bs_adr_valid),	// SinkC.scala:93:30
    .io_enq_bits_noop (~_c_io_deq_valid),	// Decoupled.scala:296:21, SinkC.scala:94:25
    .io_enq_bits_way  (io_way),
    .io_enq_bits_set  (_io_set_output),	// SinkC.scala:86:18
    .io_enq_bits_beat (_c_io_deq_valid ? beat : bs_adr_bits_beat_r),	// Decoupled.scala:296:21, Edges.scala:233:25, Reg.scala:15:16, SinkC.scala:97:28
    .io_deq_ready     (io_bs_adr_ready),
    .io_enq_ready     (_io_bs_adr_q_io_enq_ready),
    .io_deq_valid     (io_bs_adr_valid),
    .io_deq_bits_noop (io_bs_adr_bits_noop),
    .io_deq_bits_way  (io_bs_adr_bits_way),
    .io_deq_bits_set  (io_bs_adr_bits_set),
    .io_deq_bits_beat (io_bs_adr_bits_beat),
    .io_deq_bits_mask (io_bs_adr_bits_mask)
  );
  ListBuffer_1 putbuffer (	// SinkC.scala:109:27
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid
      (~resp & _c_io_deq_valid & _c_io_deq_bits_opcode[0] & ~req_block & ~set_block),	// Decoupled.scala:296:21, Edges.scala:101:36, SinkC.scala:73:19, :120:27, :122:38, :128:{56,84}, :130:21, :131:74
    .io_push_bits_index        (put[0]),	// SinkC.scala:134:18, :147:34
    .io_push_bits_data_data    (_c_io_deq_bits_data),	// Decoupled.scala:296:21
    .io_push_bits_data_corrupt (_c_io_deq_bits_corrupt),	// Decoupled.scala:296:21
    .io_pop_valid              (_putbuffer_io_pop_valid_T),	// Decoupled.scala:40:37
    .io_pop_bits               (io_rel_pop_bits_index[0]),	// SinkC.scala:152:27
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_valid                  (_putbuffer_io_valid),
    .io_data_data              (io_rel_beat_data),
    .io_data_corrupt           (io_rel_beat_corrupt)
  );
  assign io_req_valid = ~resp & _c_io_deq_valid & ~(|counter) & ~buf_block & ~set_block;	// Decoupled.scala:296:21, Edges.scala:228:27, :230:25, SinkC.scala:73:19, :121:29, :122:38, :128:{70,84}, :130:{21,61}
  assign io_req_bits_opcode = _c_io_deq_bits_opcode;	// Decoupled.scala:296:21
  assign io_req_bits_param = _c_io_deq_bits_param;	// Decoupled.scala:296:21
  assign io_req_bits_size = _c_io_deq_bits_size;	// Decoupled.scala:296:21
  assign io_req_bits_source = _c_io_deq_bits_source;	// Decoupled.scala:296:21
  assign io_req_bits_tag = tag;	// Parameters.scala:212:22, :213:19
  assign io_req_bits_offset = _c_io_deq_bits_address[5:0];	// Decoupled.scala:296:21, Parameters.scala:214:50
  assign io_req_bits_put = {4'h0, put};	// SinkC.scala:134:18, :145:24
  assign io_req_bits_set = _c_io_deq_bits_address[15:6];	// Decoupled.scala:296:21, Parameters.scala:212:22, :214:28
  assign io_resp_valid =
    resp & _c_io_deq_valid & (~(|counter) | last)
    & (~(_c_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready);	// Decoupled.scala:296:21, Edges.scala:101:36, :228:27, :230:25, :231:37, SinkC.scala:73:19, :101:{48,57,61,70}
  assign io_resp_bits_last = last;	// Edges.scala:231:37
  assign io_resp_bits_set = _c_io_deq_bits_address[15:6];	// Decoupled.scala:296:21, Parameters.scala:212:22, :214:28
  assign io_resp_bits_tag = tag;	// Parameters.scala:212:22, :213:19
  assign io_resp_bits_source = _c_io_deq_bits_source;	// Decoupled.scala:296:21
  assign io_resp_bits_param = _c_io_deq_bits_param;	// Decoupled.scala:296:21
  assign io_resp_bits_data = _c_io_deq_bits_opcode[0];	// Decoupled.scala:296:21, Edges.scala:101:36
  assign io_set = _io_set_output;	// SinkC.scala:86:18
  assign io_bs_dat_data = io_bs_dat_data_r;	// Reg.scala:15:16
  assign io_rel_pop_ready = _io_rel_pop_ready_output;	// SinkC.scala:154:43
endmodule

