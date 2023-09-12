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

module BoomProbeUnit_2(
  input         clock,
                reset,
                io_req_valid,
  input  [1:0]  io_req_bits_param,
  input  [3:0]  io_req_bits_size,
  input  [1:0]  io_req_bits_source,
  input  [31:0] io_req_bits_address,
  input         io_rep_ready,
                io_meta_read_ready,
                io_meta_write_ready,
                io_wb_req_ready,
  input  [3:0]  io_way_en,
  input         io_wb_rdy,
                io_mshr_rdy,
  input  [1:0]  io_block_state_state,
  input         io_lsu_release_ready,
  output        io_req_ready,
                io_rep_valid,
  output [2:0]  io_rep_bits_param,
  output [3:0]  io_rep_bits_size,
  output [1:0]  io_rep_bits_source,
  output [31:0] io_rep_bits_address,
  output        io_meta_read_valid,
  output [5:0]  io_meta_read_bits_idx,
  output [19:0] io_meta_read_bits_tag,
  output        io_meta_write_valid,
  output [5:0]  io_meta_write_bits_idx,
  output [3:0]  io_meta_write_bits_way_en,
  output [1:0]  io_meta_write_bits_data_coh_state,
  output [19:0] io_meta_write_bits_data_tag,
  output        io_wb_req_valid,
  output [19:0] io_wb_req_bits_tag,
  output [5:0]  io_wb_req_bits_idx,
  output [2:0]  io_wb_req_bits_param,
  output [3:0]  io_wb_req_bits_way_en,
  output        io_mshr_wb_rdy,
                io_lsu_release_valid,
  output [31:0] io_lsu_release_bits_address,
  output        io_state_valid,
  output [39:0] io_state_bits
);

  reg  [3:0]  state;	// dcache.scala:165:22
  reg  [1:0]  req_param;	// dcache.scala:167:16
  reg  [3:0]  req_size;	// dcache.scala:167:16
  reg  [1:0]  req_source;	// dcache.scala:167:16
  reg  [31:0] req_address;	// dcache.scala:167:16
  reg  [3:0]  way_en;	// dcache.scala:171:19
  reg  [1:0]  old_coh_state;	// dcache.scala:173:20
  wire [3:0]  _GEN = {req_param, (|way_en) ? old_coh_state : 2'h0};	// Cat.scala:30:58, dcache.scala:167:16, :171:19, :172:28, :173:20, :175:22
  wire        _GEN_0 = _GEN == 4'hB;	// Cat.scala:30:58, Misc.scala:55:20
  wire        _GEN_1 = _GEN == 4'h4;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:229:17
  wire        _GEN_2 = _GEN == 4'h5;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:209:33
  wire        _GEN_3 = _GEN == 4'h6;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:182:25
  wire        _GEN_4 = _GEN == 4'h7;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:198:28
  wire        _GEN_5 = _GEN == 4'h0;	// Cat.scala:30:58, Misc.scala:55:20
  wire        _GEN_6 = _GEN == 4'h1;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:188:31
  wire        _GEN_7 = _GEN == 4'h2;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:220:13
  wire        _GEN_8 = _GEN == 4'h3;	// Cat.scala:30:58, Misc.scala:55:20, dcache.scala:224:11
  wire        _GEN_9 = _GEN_8 | _GEN_7;	// Misc.scala:37:36, :55:20
  wire [2:0]  io_rep_bits_c_param =
    _GEN_9
      ? 3'h3
      : _GEN_6
          ? 3'h4
          : _GEN_5
              ? 3'h5
              : _GEN_4 | _GEN_3
                  ? 3'h0
                  : _GEN_2
                      ? 3'h4
                      : _GEN_1
                          ? 3'h5
                          : _GEN_0 | _GEN == 4'hA
                              ? 3'h1
                              : _GEN == 4'h9 ? 3'h2 : _GEN == 4'h8 ? 3'h5 : 3'h0;	// Cat.scala:30:58, Misc.scala:37:36, :55:20, dcache.scala:192:32, package.scala:15:47
  wire        _io_req_ready_output = state == 4'h0;	// dcache.scala:165:22, :181:25
  wire        _io_mshr_wb_rdy_T = state == 4'h6;	// dcache.scala:165:22, :182:25
  wire        _io_meta_read_valid_output = state == 4'h1;	// dcache.scala:165:22, :188:31
  wire        _io_meta_write_valid_output = state == 4'h9;	// dcache.scala:165:22, :192:32
  wire        _io_wb_req_valid_output = state == 4'h7;	// dcache.scala:165:22, :198:28
  wire        _io_lsu_release_valid_output = state == 4'h5;	// dcache.scala:165:22, :209:33
  always @(posedge clock) begin
    automatic logic _GEN_10;	// Decoupled.scala:40:37
    _GEN_10 = _io_req_ready_output & io_req_valid;	// Decoupled.scala:40:37, dcache.scala:181:25
    if (reset)
      state <= 4'h0;	// dcache.scala:165:22
    else begin
      automatic logic [15:0][3:0] _GEN_11;	// dcache.scala:165:22, :181:25, :182:25, :188:31, :192:32, :198:28, :209:33, :213:30, :214:26, :218:39, :219:32, :222:{22,39}, :224:11, :225:{22,38}, :229:11, :230:{22,39}, :231:11, :232:41, :233:34, :236:37, :237:25, :240:43, :241:29, :244:44, :246:28, :249:40, :250:33, :253:45, :254:11, package.scala:15:47
      _GEN_11 =
        {{state},
         {state},
         {state},
         {state},
         {state},
         {4'h0},
         {io_meta_write_ready & _io_meta_write_valid_output ? 4'hA : state},
         {io_wb_req_ready ? 4'h9 : state},
         {io_wb_req_ready & _io_wb_req_valid_output ? 4'h8 : state},
         {io_rep_ready ? ((|way_en) ? 4'h9 : 4'h0) : state},
         {io_lsu_release_ready & _io_lsu_release_valid_output ? 4'h6 : state},
         {{2'h1,
           (|way_en)
             & (_GEN_8 | ~(_GEN_7 | _GEN_6 | _GEN_5)
                & (_GEN_4 | ~(_GEN_3 | _GEN_2 | _GEN_1) & _GEN_0)),
           1'h1}},
         {io_mshr_rdy & io_wb_rdy ? 4'h4 : 4'h1},
         {4'h3},
         {io_meta_read_ready & _io_meta_read_valid_output ? 4'h2 : state},
         {_GEN_10 ? 4'h1 : state}};	// Decoupled.scala:40:37, Misc.scala:37:9, :55:20, dcache.scala:165:22, :171:19, :172:28, :181:25, :182:25, :185:9, :188:31, :192:32, :198:28, :209:33, :213:30, :214:26, :215:13, :218:39, :219:32, :220:13, :222:{22,39}, :224:11, :225:{22,38}, :229:{11,17,30}, :230:{22,39}, :231:{11,17,30}, :232:41, :233:34, :234:13, :236:37, :237:25, :238:{13,19}, :240:43, :241:29, :242:13, :244:44, :246:28, :247:13, :249:40, :250:33, :251:13, :253:45, :254:11, package.scala:15:47
      state <= _GEN_11[state];	// dcache.scala:165:22, :181:25, :182:25, :188:31, :192:32, :198:28, :209:33, :213:30, :214:26, :218:39, :219:32, :222:{22,39}, :224:11, :225:{22,38}, :229:11, :230:{22,39}, :231:11, :232:41, :233:34, :236:37, :237:25, :240:43, :241:29, :244:44, :246:28, :249:40, :250:33, :253:45, :254:11, package.scala:15:47
    end
    if (_io_req_ready_output & _GEN_10) begin	// Decoupled.scala:40:37, dcache.scala:167:16, :181:25, :213:30, :214:26, :216:11
      req_param <= io_req_bits_param;	// dcache.scala:167:16
      req_size <= io_req_bits_size;	// dcache.scala:167:16
      req_source <= io_req_bits_source;	// dcache.scala:167:16
      req_address <= io_req_bits_address;	// dcache.scala:167:16
    end
    if (_io_req_ready_output | _io_meta_read_valid_output | state == 4'h2
        | state != 4'h3) begin	// dcache.scala:165:22, :173:20, :181:25, :188:31, :213:30, :218:39, :220:13, :222:{22,39}, :224:11, :225:{22,38}
    end
    else begin	// dcache.scala:173:20, :213:30, :218:39, :222:39, :225:38
      way_en <= io_way_en;	// dcache.scala:171:19
      old_coh_state <= io_block_state_state;	// dcache.scala:173:20
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
        state = _RANDOM[2'h0][3:0];	// dcache.scala:165:22
        req_param = _RANDOM[2'h0][8:7];	// dcache.scala:165:22, :167:16
        req_size = _RANDOM[2'h0][12:9];	// dcache.scala:165:22, :167:16
        req_source = _RANDOM[2'h0][14:13];	// dcache.scala:165:22, :167:16
        req_address = {_RANDOM[2'h0][31:15], _RANDOM[2'h1][14:0]};	// dcache.scala:165:22, :167:16
        way_en = _RANDOM[2'h3][27:24];	// dcache.scala:171:19
        old_coh_state = _RANDOM[2'h3][29:28];	// dcache.scala:171:19, :173:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = _io_req_ready_output;	// dcache.scala:181:25
  assign io_rep_valid = _io_mshr_wb_rdy_T;	// dcache.scala:182:25
  assign io_rep_bits_param = io_rep_bits_c_param;	// Misc.scala:37:36
  assign io_rep_bits_size = req_size;	// dcache.scala:167:16
  assign io_rep_bits_source = req_source;	// dcache.scala:167:16
  assign io_rep_bits_address = req_address;	// dcache.scala:167:16
  assign io_meta_read_valid = _io_meta_read_valid_output;	// dcache.scala:188:31
  assign io_meta_read_bits_idx = req_address[11:6];	// dcache.scala:167:16, :168:28
  assign io_meta_read_bits_tag = req_address[31:12];	// dcache.scala:167:16, :169:29
  assign io_meta_write_valid = _io_meta_write_valid_output;	// dcache.scala:192:32
  assign io_meta_write_bits_idx = req_address[11:6];	// dcache.scala:167:16, :168:28
  assign io_meta_write_bits_way_en = way_en;	// dcache.scala:171:19
  assign io_meta_write_bits_data_coh_state =
    _GEN_9 ? 2'h2 : _GEN_6 ? 2'h1 : _GEN_5 ? 2'h0 : {1'h0, _GEN_4 | _GEN_3 | _GEN_2};	// Misc.scala:37:{36,63}, :55:20, dcache.scala:167:16
  assign io_meta_write_bits_data_tag = req_address[31:12];	// dcache.scala:167:16, :169:29
  assign io_wb_req_valid = _io_wb_req_valid_output;	// dcache.scala:198:28
  assign io_wb_req_bits_tag = req_address[31:12];	// dcache.scala:167:16, :169:29
  assign io_wb_req_bits_idx = req_address[11:6];	// dcache.scala:167:16, :168:28
  assign io_wb_req_bits_param = io_rep_bits_c_param;	// Misc.scala:37:36
  assign io_wb_req_bits_way_en = way_en;	// dcache.scala:171:19
  assign io_mshr_wb_rdy =
    ~(_io_mshr_wb_rdy_T | _io_wb_req_valid_output | state == 4'h8
      | _io_meta_write_valid_output | state == 4'hA);	// dcache.scala:165:22, :182:25, :192:32, :198:28, :207:21, package.scala:15:47, :72:59
  assign io_lsu_release_valid = _io_lsu_release_valid_output;	// dcache.scala:209:33
  assign io_lsu_release_bits_address = req_address;	// dcache.scala:167:16
  assign io_state_valid = |state;	// dcache.scala:165:22, :178:27
  assign io_state_bits = {8'h0, req_address};	// dcache.scala:167:16, :179:18
endmodule

