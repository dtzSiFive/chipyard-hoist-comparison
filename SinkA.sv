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

module SinkA(
  input         clock,
                reset,
                io_req_ready,
                io_a_valid,
  input  [2:0]  io_a_bits_opcode,
                io_a_bits_size,
  input  [31:0] io_a_bits_address,
  input  [7:0]  io_a_bits_mask,
  input  [63:0] io_a_bits_data,
  input         io_a_bits_corrupt,
                io_pb_pop_valid,
  input  [5:0]  io_pb_pop_bits_index,
  input         io_pb_pop_bits_last,
  output        io_req_valid,
  output [12:0] io_req_bits_tag,
  output [5:0]  io_req_bits_offset,
                io_req_bits_put,
  output [9:0]  io_req_bits_set,
  output        io_a_ready,
                io_pb_pop_ready,
  output [63:0] io_pb_beat_data,
  output [7:0]  io_pb_beat_mask,
  output        io_pb_beat_corrupt
);

  wire        _io_pb_pop_ready_output;	// SinkA.scala:104:40
  wire        _putbuffer_io_push_ready;	// SinkA.scala:50:25
  wire [39:0] _putbuffer_io_valid;	// SinkA.scala:50:25
  reg  [39:0] lists;	// SinkA.scala:51:22
  wire [39:0] _freeOH_T_22 = ~lists;	// SinkA.scala:51:22, :58:25
  wire [38:0] _freeOH_T_3 = _freeOH_T_22[38:0] | {_freeOH_T_22[37:0], 1'h0};	// SinkA.scala:58:25, package.scala:244:{43,53}
  wire [38:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[36:0], 2'h0};	// package.scala:244:{43,53}
  wire [38:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[34:0], 4'h0};	// package.scala:244:{43,48,53}
  wire [38:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[30:0], 8'h0};	// package.scala:244:{43,48,53}
  wire [38:0] _freeOH_T_15 = _freeOH_T_12 | {_freeOH_T_12[22:0], 16'h0};	// package.scala:244:{43,48,53}
  wire [39:0] _GEN = {~(_freeOH_T_15 | {_freeOH_T_15[6:0], 32'h0}), 1'h1} & _freeOH_T_22;	// SinkA.scala:58:{16,25,39}, package.scala:244:{43,48,53}
  wire [30:0] _freeIdx_T = {24'h0, _GEN[39:33]} | _GEN[31:1];	// OneHot.scala:31:18, :32:28, SinkA.scala:58:39
  wire [14:0] _freeIdx_T_1 = _freeIdx_T[30:16] | _freeIdx_T[14:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [6:0]  _freeIdx_T_2 = _freeIdx_T_1[14:8] | _freeIdx_T_1[6:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [2:0]  _freeIdx_T_3 = _freeIdx_T_2[6:4] | _freeIdx_T_2[2:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [5:0]  freeIdx =
    {|(_GEN[39:32]),
     |(_freeIdx_T[30:15]),
     |(_freeIdx_T_1[14:7]),
     |(_freeIdx_T_2[6:3]),
     |(_freeIdx_T_3[2:1]),
     _freeIdx_T_3[2] | _freeIdx_T_3[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, SinkA.scala:58:39
  reg  [2:0]  first_counter;	// Edges.scala:228:27
  wire        first = first_counter == 3'h0;	// Edges.scala:228:27, :230:25
  wire        req_block = first & ~io_req_ready;	// Edges.scala:230:25, SinkA.scala:69:{25,28}
  wire        buf_block = ~(io_a_bits_opcode[2]) & ~_putbuffer_io_push_ready;	// Edges.scala:91:{28,37}, SinkA.scala:50:25, :70:{27,30}
  wire        set_block = ~(io_a_bits_opcode[2]) & first & (&lists);	// Edges.scala:91:{28,37}, :230:25, SinkA.scala:51:22, :57:25, :71:36
  wire        _io_a_ready_output = ~req_block & ~buf_block & ~set_block;	// SinkA.scala:69:25, :70:27, :71:36, :77:{14,28,39,42}
  wire        _io_req_valid_T = io_a_valid & first;	// Edges.scala:230:25, SinkA.scala:78:27
  reg  [5:0]  put_r;	// Reg.scala:15:16
  wire [5:0]  put = first ? freeIdx : put_r;	// Cat.scala:30:58, Edges.scala:230:25, Reg.scala:15:16, SinkA.scala:83:16
  wire        _putbuffer_io_pop_valid_T = _io_pb_pop_ready_output & io_pb_pop_valid;	// Decoupled.scala:40:37, SinkA.scala:104:40
  wire [39:0] _io_pb_pop_ready_T = _putbuffer_io_valid >> io_pb_pop_bits_index;	// SinkA.scala:50:25, :104:40
  assign _io_pb_pop_ready_output = _io_pb_pop_ready_T[0];	// SinkA.scala:104:40
  wire [63:0] _lists_clr_T = 64'h1 << io_pb_pop_bits_index;	// OneHot.scala:65:12
  always @(posedge clock) begin
    if (reset) begin
      lists <= 40'h0;	// SinkA.scala:51:22
      first_counter <= 3'h0;	// Edges.scala:228:27
    end
    else begin
      lists <=
        (lists
         | (_io_req_valid_T & ~(io_a_bits_opcode[2]) & ~req_block & ~buf_block
              ? _GEN
              : 40'h0))
        & ~(_putbuffer_io_pop_valid_T & io_pb_pop_bits_last ? _lists_clr_T[39:0] : 40'h0);	// Decoupled.scala:40:37, Edges.scala:91:{28,37}, OneHot.scala:65:{12,27}, SinkA.scala:51:22, :55:{19,32,34}, :58:39, :69:25, :70:27, :77:{14,28}, :78:27, :80:{51,66,78}, :107:{26,50}, :108:15
      if (_io_a_ready_output & io_a_valid) begin	// Decoupled.scala:40:37, SinkA.scala:77:39
        if (first) begin	// Edges.scala:230:25
          if (io_a_bits_opcode[2])	// Edges.scala:91:37
            first_counter <= 3'h0;	// Edges.scala:228:27
          else begin	// Edges.scala:91:37
            automatic logic [12:0] _first_beats1_decode_T_1 = 13'h3F << io_a_bits_size;	// package.scala:234:77
            first_counter <= ~(_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
        end
        else	// Edges.scala:230:25
          first_counter <= first_counter - 3'h1;	// Edges.scala:228:27, :229:28
      end
    end
    if (first)	// Edges.scala:230:25
      put_r <= freeIdx;	// Cat.scala:30:58, Reg.scala:15:16
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:1];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        lists = {_RANDOM[1'h0], _RANDOM[1'h1][7:0]};	// SinkA.scala:51:22
        first_counter = _RANDOM[1'h1][10:8];	// Edges.scala:228:27, SinkA.scala:51:22
        put_r = _RANDOM[1'h1][16:11];	// Reg.scala:15:16, SinkA.scala:51:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ListBuffer putbuffer (	// SinkA.scala:50:25
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid
      (io_a_valid & ~(io_a_bits_opcode[2]) & ~req_block & ~set_block),	// Edges.scala:91:{28,37}, SinkA.scala:69:25, :71:36, :77:{14,42}, :79:63
    .io_push_bits_index        (put),	// SinkA.scala:83:16
    .io_push_bits_data_data    (io_a_bits_data),
    .io_push_bits_data_mask    (io_a_bits_mask),
    .io_push_bits_data_corrupt (io_a_bits_corrupt),
    .io_pop_valid              (_putbuffer_io_pop_valid_T),	// Decoupled.scala:40:37
    .io_pop_bits               (io_pb_pop_bits_index),
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_valid                  (_putbuffer_io_valid),
    .io_data_data              (io_pb_beat_data),
    .io_data_mask              (io_pb_beat_mask),
    .io_data_corrupt           (io_pb_beat_corrupt)
  );
  assign io_req_valid = _io_req_valid_T & ~buf_block & ~set_block;	// SinkA.scala:70:27, :71:36, :77:{28,42}, :78:{27,50}
  assign io_req_bits_tag = {io_a_bits_address[31], io_a_bits_address[27:16]};	// Parameters.scala:211:47, :212:22, :213:19
  assign io_req_bits_offset = io_a_bits_address[5:0];	// Parameters.scala:214:50
  assign io_req_bits_put = put;	// SinkA.scala:83:16
  assign io_req_bits_set = io_a_bits_address[15:6];	// Parameters.scala:212:22, :214:28
  assign io_a_ready = _io_a_ready_output;	// SinkA.scala:77:39
  assign io_pb_pop_ready = _io_pb_pop_ready_output;	// SinkA.scala:104:40
endmodule

