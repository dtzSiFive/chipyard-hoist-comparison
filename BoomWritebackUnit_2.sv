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

module BoomWritebackUnit_2(
  input         clock,
                reset,
                io_req_valid,
  input  [19:0] io_req_bits_tag,
  input  [5:0]  io_req_bits_idx,
  input  [2:0]  io_req_bits_param,
  input  [3:0]  io_req_bits_way_en,
  input         io_req_bits_voluntary,
                io_meta_read_ready,
                io_data_req_ready,
  input  [63:0] io_data_resp,
  input         io_mem_grant,
                io_release_ready,
                io_lsu_release_ready,
  output        io_req_ready,
                io_meta_read_valid,
  output [5:0]  io_meta_read_bits_idx,
  output [19:0] io_meta_read_bits_tag,
  output        io_resp,
                io_idx_valid,
  output [5:0]  io_idx_bits,
  output        io_data_req_valid,
  output [3:0]  io_data_req_bits_way_en,
  output [11:0] io_data_req_bits_addr,
  output        io_release_valid,
  output [2:0]  io_release_bits_opcode,
                io_release_bits_param,
  output [31:0] io_release_bits_address,
  output [63:0] io_release_bits_data,
  output        io_lsu_release_valid,
  output [31:0] io_lsu_release_bits_address
);

  reg  [19:0]      req_tag;	// dcache.scala:37:16
  reg  [5:0]       req_idx;	// dcache.scala:37:16
  reg  [2:0]       req_param;	// dcache.scala:37:16
  reg  [3:0]       req_way_en;	// dcache.scala:37:16
  reg              req_voluntary;	// dcache.scala:37:16
  reg  [2:0]       state;	// dcache.scala:39:22
  reg              r1_data_req_fired;	// dcache.scala:40:34
  reg              r2_data_req_fired;	// dcache.scala:41:34
  reg  [3:0]       r1_data_req_cnt;	// dcache.scala:42:28
  reg  [3:0]       r2_data_req_cnt;	// dcache.scala:43:28
  reg  [3:0]       data_req_cnt;	// dcache.scala:44:29
  reg  [63:0]      wb_buffer_0;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_1;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_2;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_3;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_4;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_5;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_6;	// dcache.scala:46:22
  reg  [63:0]      wb_buffer_7;	// dcache.scala:46:22
  reg              acked;	// dcache.scala:47:22
  wire [31:0]      voluntaryRelease_address = {req_tag, req_idx, 6'h0};	// dcache.scala:37:16, :63:41
  wire [7:0][63:0] _GEN =
    {{wb_buffer_7},
     {wb_buffer_6},
     {wb_buffer_5},
     {wb_buffer_4},
     {wb_buffer_3},
     {wb_buffer_2},
     {wb_buffer_1},
     {wb_buffer_0}};	// Edges.scala:428:15, dcache.scala:46:22
  wire             _io_req_ready_output = state == 3'h0;	// dcache.scala:39:22, :80:15
  wire             _GEN_0 = state == 3'h1;	// dcache.scala:39:22, :83:13, :88:22
  wire             _io_data_req_valid_output =
    ~_io_req_ready_output & _GEN_0 & ~(data_req_cnt[3]);	// dcache.scala:44:29, :54:22, :80:{15,30}, :88:{22,41}, :89:40
  wire             _GEN_1 = r2_data_req_cnt == 4'h7;	// dcache.scala:43:28, :110:29
  wire             _GEN_2 = state == 3'h2;	// dcache.scala:39:22, :112:15, :116:22
  wire             _io_lsu_release_valid_output =
    ~(_io_req_ready_output | _GEN_0) & _GEN_2;	// dcache.scala:59:24, :80:{15,30}, :88:{22,41}, :116:{22,41}
  wire             _GEN_3 = state == 3'h3;	// dcache.scala:39:22, :120:12, :122:22
  wire             _GEN_4 = _GEN_0 | _GEN_2;	// dcache.scala:51:22, :88:{22,41}, :116:{22,41}, :122:36
  wire             _io_release_valid_output =
    ~(_io_req_ready_output | _GEN_4) & _GEN_3 & ~(data_req_cnt[3]);	// dcache.scala:44:29, :51:22, :80:{15,30}, :88:41, :89:40, :116:41, :122:{22,36}, :123:38
  always @(posedge clock) begin
    automatic logic _GEN_5;	// Decoupled.scala:40:37
    automatic logic _GEN_6;	// dcache.scala:41:34, :80:30, :88:41
    automatic logic _GEN_7;	// dcache.scala:103:30
    _GEN_5 = _io_req_ready_output & io_req_valid;	// Decoupled.scala:40:37, dcache.scala:80:15
    _GEN_6 = _io_req_ready_output | ~_GEN_0;	// dcache.scala:41:34, :80:{15,30}, :88:{22,41}
    _GEN_7 = io_data_req_ready & _io_data_req_valid_output & io_meta_read_ready;	// dcache.scala:54:22, :80:30, :88:41, :103:30
    if (_io_req_ready_output & _GEN_5) begin	// Decoupled.scala:40:37, dcache.scala:37:16, :80:{15,30}, :82:26, :85:11
      req_tag <= io_req_bits_tag;	// dcache.scala:37:16
      req_idx <= io_req_bits_idx;	// dcache.scala:37:16
      req_param <= io_req_bits_param;	// dcache.scala:37:16
      req_way_en <= io_req_bits_way_en;	// dcache.scala:37:16
      req_voluntary <= io_req_bits_voluntary;	// dcache.scala:37:16
    end
    if (_GEN_6) begin	// dcache.scala:41:34, :43:28, :80:30, :88:41
    end
    else begin	// dcache.scala:43:28, :80:30, :88:41
      if (_GEN_7)	// dcache.scala:103:30
        r1_data_req_cnt <= data_req_cnt;	// dcache.scala:42:28, :44:29
      else	// dcache.scala:103:30
        r1_data_req_cnt <= 4'h0;	// dcache.scala:42:28, :44:29
      r2_data_req_cnt <= r1_data_req_cnt;	// dcache.scala:42:28, :43:28
    end
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h0)) begin	// dcache.scala:39:22, :41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_0 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h1)) begin	// dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :83:13, :88:{22,41}, :108:30, :109:34
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_1 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h2)) begin	// dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34, :112:15
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_2 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h3)) begin	// dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34, :120:12
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_3 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h4)) begin	// dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34, :133:19
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_4 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h5)) begin	// Edges.scala:423:15, dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_5 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & r2_data_req_cnt[2:0] == 3'h6)) begin	// Edges.scala:425:15, dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_6 <= io_data_resp;	// dcache.scala:46:22
    if (_io_req_ready_output
        | ~(_GEN_0 & r2_data_req_fired & (&(r2_data_req_cnt[2:0])))) begin	// dcache.scala:41:34, :43:28, :46:22, :80:{15,30}, :88:{22,41}, :108:30, :109:34
    end
    else	// dcache.scala:46:22, :80:30, :88:41
      wb_buffer_7 <= io_data_resp;	// dcache.scala:46:22
    if (reset) begin
      state <= 3'h0;	// dcache.scala:39:22
      r1_data_req_fired <= 1'h0;	// dcache.scala:37:16, :40:34
      r2_data_req_fired <= 1'h0;	// dcache.scala:37:16, :41:34
      data_req_cnt <= 4'h0;	// dcache.scala:44:29
      acked <= 1'h0;	// dcache.scala:37:16, :47:22
    end
    else begin
      if (_io_req_ready_output) begin	// dcache.scala:80:15
        if (_GEN_5) begin	// Decoupled.scala:40:37
          state <= 3'h1;	// dcache.scala:39:22, :83:13
          data_req_cnt <= 4'h0;	// dcache.scala:44:29
        end
        acked <= ~_GEN_5 & acked;	// Decoupled.scala:40:37, dcache.scala:47:22, :82:26, :86:13
      end
      else begin	// dcache.scala:80:15
        automatic logic _GEN_8;	// dcache.scala:135:22
        _GEN_8 = state == 3'h4;	// dcache.scala:39:22, :133:19, :135:22
        if (_GEN_0) begin	// dcache.scala:88:22
          if (r2_data_req_fired & _GEN_1) begin	// dcache.scala:39:22, :41:34, :108:30, :110:{29,53}, :112:15
            state <= 3'h2;	// dcache.scala:39:22, :112:15
            data_req_cnt <= 4'h0;	// dcache.scala:44:29
          end
          else if (_GEN_7)	// dcache.scala:103:30
            data_req_cnt <= data_req_cnt + 4'h1;	// dcache.scala:44:29, :106:36
        end
        else begin	// dcache.scala:88:22
          automatic logic _GEN_9;	// Decoupled.scala:40:37
          _GEN_9 = io_release_ready & _io_release_valid_output;	// Decoupled.scala:40:37, dcache.scala:51:22, :80:30, :88:41, :116:41, :122:36
          if (_GEN_2) begin	// dcache.scala:116:22
            if (io_lsu_release_ready & _io_lsu_release_valid_output)	// Decoupled.scala:40:37, dcache.scala:59:24, :80:30, :88:41, :116:41
              state <= 3'h3;	// dcache.scala:39:22, :120:12
          end
          else if (_GEN_3) begin	// dcache.scala:122:22
            if (data_req_cnt == 4'h7 & _GEN_9)	// Decoupled.scala:40:37, dcache.scala:44:29, :110:29, :132:{25,49}
              state <= {req_voluntary, 2'h0};	// dcache.scala:37:16, :39:22, :133:19
          end
          else if (_GEN_8 & acked)	// dcache.scala:39:22, :47:22, :135:{22,35}, :139:18, :140:13
            state <= 3'h0;	// dcache.scala:39:22
          if (_GEN_2 | ~(_GEN_3 & _GEN_9)) begin	// Decoupled.scala:40:37, dcache.scala:44:29, :116:{22,41}, :122:{22,36}, :129:30, :130:20
          end
          else	// dcache.scala:44:29, :116:41, :122:36
            data_req_cnt <= data_req_cnt + 4'h1;	// dcache.scala:44:29, :106:36, :130:36
        end
        if (~_GEN_4) begin	// dcache.scala:51:22, :88:41, :116:41, :122:36
          if (_GEN_3)	// dcache.scala:122:22
            acked <= io_mem_grant | acked;	// dcache.scala:47:22, :126:25, :127:13
          else	// dcache.scala:122:22
            acked <= _GEN_8 & io_mem_grant | acked;	// dcache.scala:47:22, :135:{22,35}, :136:25, :137:13
        end
      end
      if (_GEN_6) begin	// dcache.scala:41:34, :80:30, :88:41
      end
      else begin	// dcache.scala:41:34, :80:30, :88:41
        r1_data_req_fired <= _GEN_7;	// dcache.scala:40:34, :103:30
        r2_data_req_fired <= r1_data_req_fired;	// dcache.scala:40:34, :41:34
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:17];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h12; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        req_tag = _RANDOM[5'h0][19:0];	// dcache.scala:37:16
        req_idx = _RANDOM[5'h0][25:20];	// dcache.scala:37:16
        req_param = _RANDOM[5'h0][30:28];	// dcache.scala:37:16
        req_way_en = {_RANDOM[5'h0][31], _RANDOM[5'h1][2:0]};	// dcache.scala:37:16
        req_voluntary = _RANDOM[5'h1][3];	// dcache.scala:37:16
        state = _RANDOM[5'h1][6:4];	// dcache.scala:37:16, :39:22
        r1_data_req_fired = _RANDOM[5'h1][7];	// dcache.scala:37:16, :40:34
        r2_data_req_fired = _RANDOM[5'h1][8];	// dcache.scala:37:16, :41:34
        r1_data_req_cnt = _RANDOM[5'h1][12:9];	// dcache.scala:37:16, :42:28
        r2_data_req_cnt = _RANDOM[5'h1][16:13];	// dcache.scala:37:16, :43:28
        data_req_cnt = _RANDOM[5'h1][20:17];	// dcache.scala:37:16, :44:29
        wb_buffer_0 = {_RANDOM[5'h1][31:30], _RANDOM[5'h2], _RANDOM[5'h3][29:0]};	// dcache.scala:37:16, :46:22
        wb_buffer_1 = {_RANDOM[5'h3][31:30], _RANDOM[5'h4], _RANDOM[5'h5][29:0]};	// dcache.scala:46:22
        wb_buffer_2 = {_RANDOM[5'h5][31:30], _RANDOM[5'h6], _RANDOM[5'h7][29:0]};	// dcache.scala:46:22
        wb_buffer_3 = {_RANDOM[5'h7][31:30], _RANDOM[5'h8], _RANDOM[5'h9][29:0]};	// dcache.scala:46:22
        wb_buffer_4 = {_RANDOM[5'h9][31:30], _RANDOM[5'hA], _RANDOM[5'hB][29:0]};	// dcache.scala:46:22
        wb_buffer_5 = {_RANDOM[5'hB][31:30], _RANDOM[5'hC], _RANDOM[5'hD][29:0]};	// dcache.scala:46:22
        wb_buffer_6 = {_RANDOM[5'hD][31:30], _RANDOM[5'hE], _RANDOM[5'hF][29:0]};	// dcache.scala:46:22
        wb_buffer_7 = {_RANDOM[5'hF][31:30], _RANDOM[5'h10], _RANDOM[5'h11][29:0]};	// dcache.scala:46:22
        acked = _RANDOM[5'h11][30];	// dcache.scala:46:22, :47:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = _io_req_ready_output;	// dcache.scala:80:15
  assign io_meta_read_valid = _io_data_req_valid_output;	// dcache.scala:54:22, :80:30, :88:41
  assign io_meta_read_bits_idx = req_idx;	// dcache.scala:37:16
  assign io_meta_read_bits_tag = req_tag;	// dcache.scala:37:16
  assign io_resp = ~_io_req_ready_output & _GEN_0 & r2_data_req_fired & _GEN_1;	// dcache.scala:41:34, :54:22, :58:22, :80:{15,30}, :88:{22,41}, :110:29
  assign io_idx_valid = |state;	// dcache.scala:39:22, :49:31
  assign io_idx_bits = req_idx;	// dcache.scala:37:16
  assign io_data_req_valid = _io_data_req_valid_output;	// dcache.scala:54:22, :80:30, :88:41
  assign io_data_req_bits_way_en = req_way_en;	// dcache.scala:37:16
  assign io_data_req_bits_addr = {req_idx, data_req_cnt[2:0], 3'h0};	// dcache.scala:37:16, :39:22, :44:29, :97:43
  assign io_release_valid = _io_release_valid_output;	// dcache.scala:51:22, :80:30, :88:41, :116:41, :122:36
  assign io_release_bits_opcode = {1'h1, req_voluntary, 1'h1};	// Edges.scala:229:28, dcache.scala:37:16, :124:27
  assign io_release_bits_param = req_param;	// dcache.scala:37:16
  assign io_release_bits_address = voluntaryRelease_address;	// dcache.scala:63:41
  assign io_release_bits_data = _GEN[data_req_cnt[2:0]];	// Edges.scala:428:15, dcache.scala:44:29
  assign io_lsu_release_valid = _io_lsu_release_valid_output;	// dcache.scala:59:24, :80:30, :88:41, :116:41
  assign io_lsu_release_bits_address = voluntaryRelease_address;	// dcache.scala:63:41
endmodule

