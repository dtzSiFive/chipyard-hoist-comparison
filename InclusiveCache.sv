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

module InclusiveCache(
  input         clock,
                reset,
                auto_ctl_in_a_valid,
  input  [2:0]  auto_ctl_in_a_bits_opcode,
                auto_ctl_in_a_bits_param,
  input  [1:0]  auto_ctl_in_a_bits_size,
  input  [11:0] auto_ctl_in_a_bits_source,
  input  [25:0] auto_ctl_in_a_bits_address,
  input  [7:0]  auto_ctl_in_a_bits_mask,
  input  [63:0] auto_ctl_in_a_bits_data,
  input         auto_ctl_in_a_bits_corrupt,
                auto_ctl_in_d_ready,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [31:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_b_ready,
                auto_in_c_valid,
  input  [2:0]  auto_in_c_bits_opcode,
                auto_in_c_bits_param,
                auto_in_c_bits_size,
  input  [6:0]  auto_in_c_bits_source,
  input  [31:0] auto_in_c_bits_address,
  input  [63:0] auto_in_c_bits_data,
  input         auto_in_c_bits_corrupt,
                auto_in_d_ready,
                auto_in_e_valid,
  input  [2:0]  auto_in_e_bits_sink,
  input         auto_out_a_ready,
                auto_out_c_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [2:0]  auto_out_d_bits_size,
                auto_out_d_bits_source,
                auto_out_d_bits_sink,
  input         auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_ctl_in_a_ready,
                auto_ctl_in_d_valid,
  output [2:0]  auto_ctl_in_d_bits_opcode,
  output [1:0]  auto_ctl_in_d_bits_size,
  output [11:0] auto_ctl_in_d_bits_source,
  output [63:0] auto_ctl_in_d_bits_data,
  output        auto_in_a_ready,
                auto_in_b_valid,
  output [1:0]  auto_in_b_bits_param,
  output [6:0]  auto_in_b_bits_source,
  output [31:0] auto_in_b_bits_address,
  output        auto_in_c_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [2:0]  auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output [2:0]  auto_in_d_bits_sink,
  output        auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
                auto_out_a_bits_size,
                auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_c_valid,
  output [2:0]  auto_out_c_bits_opcode,
                auto_out_c_bits_param,
                auto_out_c_bits_size,
                auto_out_c_bits_source,
  output [31:0] auto_out_c_bits_address,
  output [63:0] auto_out_c_bits_data,
  output        auto_out_c_bits_corrupt,
                auto_out_d_ready,
                auto_out_e_valid,
  output [2:0]  auto_out_e_bits_sink
);

  wire             flushNoMatch;	// InclusiveCache.scala:140:33, :205:{26,41}
  wire             _out_wofireMux_T_2;	// RegisterRouter.scala:79:24
  wire             out_backSel_3;	// RegisterRouter.scala:79:24
  wire             out_backSel_2;	// RegisterRouter.scala:79:24
  wire             _mods_0_io_in_a_ready;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_in_b_valid;	// InclusiveCache.scala:199:29
  wire [1:0]       _mods_0_io_in_b_bits_param;	// InclusiveCache.scala:199:29
  wire [6:0]       _mods_0_io_in_b_bits_source;	// InclusiveCache.scala:199:29
  wire [31:0]      _mods_0_io_in_b_bits_address;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_in_c_ready;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_in_d_valid;	// InclusiveCache.scala:199:29
  wire [2:0]       _mods_0_io_in_d_bits_opcode;	// InclusiveCache.scala:199:29
  wire [1:0]       _mods_0_io_in_d_bits_param;	// InclusiveCache.scala:199:29
  wire [2:0]       _mods_0_io_in_d_bits_size;	// InclusiveCache.scala:199:29
  wire [6:0]       _mods_0_io_in_d_bits_source;	// InclusiveCache.scala:199:29
  wire [2:0]       _mods_0_io_in_d_bits_sink;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_in_d_bits_denied;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_in_d_bits_corrupt;	// InclusiveCache.scala:199:29
  wire [31:0]      _mods_0_io_out_a_bits_address;	// InclusiveCache.scala:199:29
  wire [31:0]      _mods_0_io_out_c_bits_address;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_req_ready;	// InclusiveCache.scala:199:29
  wire             _mods_0_io_resp_valid;	// InclusiveCache.scala:199:29
  wire             _out_back_io_enq_ready;	// Decoupled.scala:296:21
  wire             _out_back_io_deq_valid;	// Decoupled.scala:296:21
  wire             _out_back_io_deq_bits_read;	// Decoupled.scala:296:21
  wire [8:0]       _out_back_io_deq_bits_index;	// Decoupled.scala:296:21
  wire [7:0]       _out_back_io_deq_bits_mask;	// Decoupled.scala:296:21
  wire [11:0]      _out_back_io_deq_bits_extra_tlrr_extra_source;	// Decoupled.scala:296:21
  wire [1:0]       _out_back_io_deq_bits_extra_tlrr_extra_size;	// Decoupled.scala:296:21
  wire [3:0][63:0] _GEN = {64'h0, 64'h0, 64'h0, 64'h60A0801};	// MuxLiteral.scala:48:10
  reg              flushInValid;	// InclusiveCache.scala:140:33
  reg  [63:0]      flushInAddress;	// InclusiveCache.scala:142:29
  reg              flushOutValid;	// InclusiveCache.scala:144:33
  wire             _GEN_0 = flushNoMatch & flushInValid;	// InclusiveCache.scala:140:33, :150:24, :205:{26,41}
  wire             out_front_bits_read = auto_ctl_in_a_bits_opcode == 3'h4;	// RegisterRouter.scala:68:36
  wire [6:0]       _GEN_1 =
    {auto_ctl_in_a_bits_address[11:10],
     auto_ctl_in_a_bits_address[8:7],
     auto_ctl_in_a_bits_address[5:3]};	// RegisterRouter.scala:79:24
  wire [6:0]       _GEN_2 =
    {_out_back_io_deq_bits_index[8:7],
     _out_back_io_deq_bits_index[5:4],
     _out_back_io_deq_bits_index[2:0]};	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [7:0]       out_frontMask_lo_lo_lo = {8{auto_ctl_in_a_bits_mask[0]}};	// Bitwise.scala:26:51, :72:12
  wire [7:0]       out_frontMask_lo_lo_hi = {8{auto_ctl_in_a_bits_mask[1]}};	// Bitwise.scala:26:51, :72:12
  wire [7:0]       out_frontMask_lo_hi_lo = {8{auto_ctl_in_a_bits_mask[2]}};	// Bitwise.scala:26:51, :72:12
  wire [7:0]       out_frontMask_lo_hi_hi = {8{auto_ctl_in_a_bits_mask[3]}};	// Bitwise.scala:26:51, :72:12
  wire [63:0]      out_frontMask =
    {{8{auto_ctl_in_a_bits_mask[7]}},
     {8{auto_ctl_in_a_bits_mask[6]}},
     {8{auto_ctl_in_a_bits_mask[5]}},
     {8{auto_ctl_in_a_bits_mask[4]}},
     out_frontMask_lo_hi_hi,
     out_frontMask_lo_hi_lo,
     out_frontMask_lo_lo_hi,
     out_frontMask_lo_lo_lo};	// Bitwise.scala:26:51, :72:12, Cat.scala:30:58
  wire [7:0]       out_backMask_lo_lo_lo = {8{_out_back_io_deq_bits_mask[0]}};	// Bitwise.scala:26:51, :72:12, Decoupled.scala:296:21
  wire [7:0]       out_backMask_lo_lo_hi = {8{_out_back_io_deq_bits_mask[1]}};	// Bitwise.scala:26:51, :72:12, Decoupled.scala:296:21
  wire [7:0]       out_backMask_lo_hi_lo = {8{_out_back_io_deq_bits_mask[2]}};	// Bitwise.scala:26:51, :72:12, Decoupled.scala:296:21
  wire [7:0]       out_backMask_lo_hi_hi = {8{_out_back_io_deq_bits_mask[3]}};	// Bitwise.scala:26:51, :72:12, Decoupled.scala:296:21
  wire [63:0]      out_backMask =
    {{8{_out_back_io_deq_bits_mask[7]}},
     {8{_out_back_io_deq_bits_mask[6]}},
     {8{_out_back_io_deq_bits_mask[5]}},
     {8{_out_back_io_deq_bits_mask[4]}},
     out_backMask_lo_hi_hi,
     out_backMask_lo_hi_lo,
     out_backMask_lo_lo_hi,
     out_backMask_lo_lo_lo};	// Bitwise.scala:26:51, :72:12, Cat.scala:30:58, Decoupled.scala:296:21
  wire [31:0]      _out_wimask_T_1 =
    {out_frontMask_lo_hi_hi,
     out_frontMask_lo_hi_lo,
     out_frontMask_lo_lo_hi,
     out_frontMask_lo_lo_lo};	// Bitwise.scala:72:12, RegisterRouter.scala:79:24
  wire [31:0]      _out_womask_T_1 =
    {out_backMask_lo_hi_hi,
     out_backMask_lo_hi_lo,
     out_backMask_lo_lo_hi,
     out_backMask_lo_lo_lo};	// Bitwise.scala:72:12, RegisterRouter.scala:79:24
  wire [1:0]       out_oindex =
    {_out_back_io_deq_bits_index[6], _out_back_io_deq_bits_index[3]};	// Cat.scala:30:58, Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [1:0]       _GEN_3 =
    {auto_ctl_in_a_bits_address[9], auto_ctl_in_a_bits_address[6]};	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire [1:0]       _GEN_4 =
    {_out_back_io_deq_bits_index[6], _out_back_io_deq_bits_index[3]};	// Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_2 = _GEN_4 == 2'h2;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_3 = &_GEN_4;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire             _out_wifireMux_T_2 =
    auto_ctl_in_a_valid & _out_back_io_enq_ready & ~out_front_bits_read;	// Decoupled.scala:296:21, RegisterRouter.scala:68:36, :79:24
  wire [3:0]       _GEN_5 =
    {{~flushInValid | ~(&_out_wimask_T_1) | (|_GEN_1)},
     {~flushInValid | ~(&out_frontMask) | (|_GEN_1)},
     {1'h1},
     {1'h1}};	// Cat.scala:30:58, InclusiveCache.scala:140:33, :165:23, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  assign _out_wofireMux_T_2 =
    _out_back_io_deq_valid & auto_ctl_in_d_ready & ~_out_back_io_deq_bits_read;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [3:0]       _GEN_6 =
    {{flushOutValid | ~(&_out_womask_T_1) | (|_GEN_2)},
     {flushOutValid | ~(&out_backMask) | (|_GEN_2)},
     {1'h1},
     {1'h1}};	// Cat.scala:30:58, InclusiveCache.scala:144:33, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  wire             out_iready =
    out_front_bits_read
    | _GEN_5[{auto_ctl_in_a_bits_address[9], auto_ctl_in_a_bits_address[6]}];	// Cat.scala:30:58, MuxLiteral.scala:48:10, RegisterRouter.scala:68:36, :79:24
  wire             out_oready = _out_back_io_deq_bits_read | _GEN_6[out_oindex];	// Cat.scala:30:58, Decoupled.scala:296:21, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  wire             in_ready = _out_back_io_enq_ready & out_iready;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire             out_valid = _out_back_io_deq_valid & out_oready;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [3:0]       _GEN_7 = {{~(|_GEN_2)}, {~(|_GEN_2)}, {1'h1}, {~(|_GEN_2)}};	// MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  wire [2:0]       bundleIn_0_1_d_bits_opcode = {2'h0, _out_back_io_deq_bits_read};	// Decoupled.scala:296:21, RegisterRouter.scala:94:19
  wire             flushSelect =
    {flushInAddress[63:32], flushInAddress[31:28] ^ 4'h8} == 36'h0
    | {flushInAddress[63:29], flushInAddress[28:12] ^ 17'h10000} == 52'h0
    | {flushInAddress[63:18], flushInAddress[17:16] ^ 2'h2} == 48'h0;	// InclusiveCache.scala:142:29, :204:108, Parameters.scala:137:{31,49,52,67}, RegisterRouter.scala:79:24
  assign flushNoMatch = ~flushSelect;	// InclusiveCache.scala:140:33, :204:108, :205:{26,41}
  `ifndef SYNTHESIS	// InclusiveCache.scala:209:14
    always @(posedge clock) begin	// InclusiveCache.scala:209:14
      if (~(~_mods_0_io_resp_valid | flushSelect | reset)) begin	// InclusiveCache.scala:199:29, :204:108, :209:{14,15}
        if (`ASSERT_VERBOSE_COND_)	// InclusiveCache.scala:209:14
          $error("Assertion failed\n    at InclusiveCache.scala:209 assert (!scheduler.io.resp.valid || flushSelect)\n");	// InclusiveCache.scala:209:14
        if (`STOP_COND_)	// InclusiveCache.scala:209:14
          $fatal;	// InclusiveCache.scala:209:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [31:0]      bundleIn_0_b_bits_address =
    {_mods_0_io_in_b_bits_address[31:29],
     _mods_0_io_in_b_bits_address[28:0]
       | {{_mods_0_io_in_b_bits_address[31], _mods_0_io_in_b_bits_address[17]} == 2'h0,
          28'h0}};	// InclusiveCache.scala:158:55, :199:29, Mux.scala:27:72, Parameters.scala:137:{49,52,67}, :244:14
  always @(posedge clock) begin
    automatic logic out_f_wivalid;	// RegisterRouter.scala:79:24
    automatic logic out_f_wivalid_1;	// RegisterRouter.scala:79:24
    out_f_wivalid = _out_wifireMux_T_2 & _GEN_3 == 2'h2 & ~(|_GEN_1) & (&out_frontMask);	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
    out_f_wivalid_1 = _out_wifireMux_T_2 & (&_GEN_3) & ~(|_GEN_1) & (&_out_wimask_T_1);	// OneHot.scala:58:35, RegisterRouter.scala:79:24
    if (reset) begin
      flushInValid <= 1'h0;	// InclusiveCache.scala:140:33
      flushOutValid <= 1'h0;	// InclusiveCache.scala:140:33, :144:33
    end
    else begin
      flushInValid <=
        out_f_wivalid_1 | out_f_wivalid | ~(flushSelect & _mods_0_io_req_ready | _GEN_0)
        & flushInValid;	// InclusiveCache.scala:140:33, :148:{26,42}, :150:{24,41}, :157:{21,36}, :164:{21,36}, :199:29, :204:108, :207:{25,53,68}, RegisterRouter.scala:79:24
      flushOutValid <=
        _mods_0_io_resp_valid | _GEN_0
        | ~(_out_wofireMux_T_2 & out_backSel_3 & ~(|_GEN_2) & (&_out_womask_T_1)
            | _out_wofireMux_T_2 & out_backSel_2 & ~(|_GEN_2) & (&out_backMask))
        & flushOutValid;	// Cat.scala:30:58, InclusiveCache.scala:144:33, :147:{26,42}, :150:{24,41}, :152:21, :156:{21,37}, :163:21, :199:29, :208:{38,54}, RegisterRouter.scala:79:24
    end
    if (out_f_wivalid_1 & ~flushInValid)	// InclusiveCache.scala:140:33, :158:20, :165:23, RegisterRouter.scala:79:24
      flushInAddress <= {28'h0, auto_ctl_in_a_bits_data[31:0], 4'h0};	// InclusiveCache.scala:142:29, :158:{55,63}, RegisterRouter.scala:79:24
    else if (out_f_wivalid & ~flushInValid)	// InclusiveCache.scala:140:33, :165:{20,23}, RegisterRouter.scala:79:24
      flushInAddress <= auto_ctl_in_a_bits_data;	// InclusiveCache.scala:142:29
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
        flushInValid = _RANDOM[2'h0][0];	// InclusiveCache.scala:140:33
        flushInAddress = {_RANDOM[2'h0][31:1], _RANDOM[2'h1], _RANDOM[2'h2][0]};	// InclusiveCache.scala:140:33, :142:29
        flushOutValid = _RANDOM[2'h2][1];	// InclusiveCache.scala:142:29, :144:33
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_45 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_mods_0_io_in_a_ready),	// InclusiveCache.scala:199:29
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_b_ready        (auto_in_b_ready),
    .io_in_b_valid        (_mods_0_io_in_b_valid),	// InclusiveCache.scala:199:29
    .io_in_b_bits_param   (_mods_0_io_in_b_bits_param),	// InclusiveCache.scala:199:29
    .io_in_b_bits_source  (_mods_0_io_in_b_bits_source),	// InclusiveCache.scala:199:29
    .io_in_b_bits_address (bundleIn_0_b_bits_address),	// Parameters.scala:244:14
    .io_in_c_ready        (_mods_0_io_in_c_ready),	// InclusiveCache.scala:199:29
    .io_in_c_valid        (auto_in_c_valid),
    .io_in_c_bits_opcode  (auto_in_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_c_bits_param),
    .io_in_c_bits_size    (auto_in_c_bits_size),
    .io_in_c_bits_source  (auto_in_c_bits_source),
    .io_in_c_bits_address (auto_in_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_c_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (_mods_0_io_in_d_valid),	// InclusiveCache.scala:199:29
    .io_in_d_bits_opcode  (_mods_0_io_in_d_bits_opcode),	// InclusiveCache.scala:199:29
    .io_in_d_bits_param   (_mods_0_io_in_d_bits_param),	// InclusiveCache.scala:199:29
    .io_in_d_bits_size    (_mods_0_io_in_d_bits_size),	// InclusiveCache.scala:199:29
    .io_in_d_bits_source  (_mods_0_io_in_d_bits_source),	// InclusiveCache.scala:199:29
    .io_in_d_bits_sink    (_mods_0_io_in_d_bits_sink),	// InclusiveCache.scala:199:29
    .io_in_d_bits_denied  (_mods_0_io_in_d_bits_denied),	// InclusiveCache.scala:199:29
    .io_in_d_bits_corrupt (_mods_0_io_in_d_bits_corrupt),	// InclusiveCache.scala:199:29
    .io_in_e_valid        (auto_in_e_valid),
    .io_in_e_bits_sink    (auto_in_e_bits_sink)
  );
  TLMonitor_46 monitor_1 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (in_ready),	// RegisterRouter.scala:79:24
    .io_in_a_valid        (auto_ctl_in_a_valid),
    .io_in_a_bits_opcode  (auto_ctl_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_ctl_in_a_bits_param),
    .io_in_a_bits_size    (auto_ctl_in_a_bits_size),
    .io_in_a_bits_source  (auto_ctl_in_a_bits_source),
    .io_in_a_bits_address (auto_ctl_in_a_bits_address),
    .io_in_a_bits_mask    (auto_ctl_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_ctl_in_a_bits_corrupt),
    .io_in_d_ready        (auto_ctl_in_d_ready),
    .io_in_d_valid        (out_valid),	// RegisterRouter.scala:79:24
    .io_in_d_bits_opcode  (bundleIn_0_1_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (_out_back_io_deq_bits_extra_tlrr_extra_size),	// Decoupled.scala:296:21
    .io_in_d_bits_source  (_out_back_io_deq_bits_extra_tlrr_extra_source)	// Decoupled.scala:296:21
  );
  Queue_19 out_back (	// Decoupled.scala:296:21
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (auto_ctl_in_a_valid & out_iready),	// RegisterRouter.scala:79:24
    .io_enq_bits_read                    (out_front_bits_read),	// RegisterRouter.scala:68:36
    .io_enq_bits_index                   (auto_ctl_in_a_bits_address[11:3]),	// Edges.scala:191:34, RegisterRouter.scala:69:19
    .io_enq_bits_data                    (auto_ctl_in_a_bits_data),
    .io_enq_bits_mask                    (auto_ctl_in_a_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source (auto_ctl_in_a_bits_source),
    .io_enq_bits_extra_tlrr_extra_size   (auto_ctl_in_a_bits_size),
    .io_deq_ready                        (auto_ctl_in_d_ready & out_oready),	// RegisterRouter.scala:79:24
    .io_enq_ready                        (_out_back_io_enq_ready),
    .io_deq_valid                        (_out_back_io_deq_valid),
    .io_deq_bits_read                    (_out_back_io_deq_bits_read),
    .io_deq_bits_index                   (_out_back_io_deq_bits_index),
    .io_deq_bits_mask                    (_out_back_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source (_out_back_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size   (_out_back_io_deq_bits_extra_tlrr_extra_size)
  );
  Scheduler mods_0 (	// InclusiveCache.scala:199:29
    .clock                 (clock),
    .reset                 (reset),
    .io_in_a_valid         (auto_in_a_valid),
    .io_in_a_bits_opcode   (auto_in_a_bits_opcode),
    .io_in_a_bits_param    (auto_in_a_bits_param),
    .io_in_a_bits_size     (auto_in_a_bits_size),
    .io_in_a_bits_source   (auto_in_a_bits_source),
    .io_in_a_bits_address  (auto_in_a_bits_address),
    .io_in_a_bits_mask     (auto_in_a_bits_mask),
    .io_in_a_bits_data     (auto_in_a_bits_data),
    .io_in_a_bits_corrupt  (auto_in_a_bits_corrupt),
    .io_in_b_ready         (auto_in_b_ready),
    .io_in_c_valid         (auto_in_c_valid),
    .io_in_c_bits_opcode   (auto_in_c_bits_opcode),
    .io_in_c_bits_param    (auto_in_c_bits_param),
    .io_in_c_bits_size     (auto_in_c_bits_size),
    .io_in_c_bits_source   (auto_in_c_bits_source),
    .io_in_c_bits_address  (auto_in_c_bits_address),
    .io_in_c_bits_data     (auto_in_c_bits_data),
    .io_in_c_bits_corrupt  (auto_in_c_bits_corrupt),
    .io_in_d_ready         (auto_in_d_ready),
    .io_in_e_valid         (auto_in_e_valid),
    .io_in_e_bits_sink     (auto_in_e_bits_sink),
    .io_out_a_ready        (auto_out_a_ready),
    .io_out_c_ready        (auto_out_c_ready),
    .io_out_d_valid        (auto_out_d_valid),
    .io_out_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_out_d_bits_param   (auto_out_d_bits_param),
    .io_out_d_bits_size    (auto_out_d_bits_size),
    .io_out_d_bits_source  (auto_out_d_bits_source),
    .io_out_d_bits_sink    (auto_out_d_bits_sink),
    .io_out_d_bits_denied  (auto_out_d_bits_denied),
    .io_out_d_bits_data    (auto_out_d_bits_data),
    .io_out_d_bits_corrupt (auto_out_d_bits_corrupt),
    .io_req_valid          (flushInValid & flushSelect),	// InclusiveCache.scala:140:33, :204:108, :211:46
    .io_req_bits_address   (flushInAddress[31:0]),	// InclusiveCache.scala:142:29, Parameters.scala:137:31
    .io_resp_ready         (~flushOutValid),	// InclusiveCache.scala:144:33, :213:34
    .io_in_a_ready         (_mods_0_io_in_a_ready),
    .io_in_b_valid         (_mods_0_io_in_b_valid),
    .io_in_b_bits_param    (_mods_0_io_in_b_bits_param),
    .io_in_b_bits_source   (_mods_0_io_in_b_bits_source),
    .io_in_b_bits_address  (_mods_0_io_in_b_bits_address),
    .io_in_c_ready         (_mods_0_io_in_c_ready),
    .io_in_d_valid         (_mods_0_io_in_d_valid),
    .io_in_d_bits_opcode   (_mods_0_io_in_d_bits_opcode),
    .io_in_d_bits_param    (_mods_0_io_in_d_bits_param),
    .io_in_d_bits_size     (_mods_0_io_in_d_bits_size),
    .io_in_d_bits_source   (_mods_0_io_in_d_bits_source),
    .io_in_d_bits_sink     (_mods_0_io_in_d_bits_sink),
    .io_in_d_bits_denied   (_mods_0_io_in_d_bits_denied),
    .io_in_d_bits_data     (auto_in_d_bits_data),
    .io_in_d_bits_corrupt  (_mods_0_io_in_d_bits_corrupt),
    .io_out_a_valid        (auto_out_a_valid),
    .io_out_a_bits_opcode  (auto_out_a_bits_opcode),
    .io_out_a_bits_param   (auto_out_a_bits_param),
    .io_out_a_bits_size    (auto_out_a_bits_size),
    .io_out_a_bits_source  (auto_out_a_bits_source),
    .io_out_a_bits_address (_mods_0_io_out_a_bits_address),
    .io_out_a_bits_mask    (auto_out_a_bits_mask),
    .io_out_a_bits_data    (auto_out_a_bits_data),
    .io_out_a_bits_corrupt (auto_out_a_bits_corrupt),
    .io_out_c_valid        (auto_out_c_valid),
    .io_out_c_bits_opcode  (auto_out_c_bits_opcode),
    .io_out_c_bits_param   (auto_out_c_bits_param),
    .io_out_c_bits_size    (auto_out_c_bits_size),
    .io_out_c_bits_source  (auto_out_c_bits_source),
    .io_out_c_bits_address (_mods_0_io_out_c_bits_address),
    .io_out_c_bits_data    (auto_out_c_bits_data),
    .io_out_c_bits_corrupt (auto_out_c_bits_corrupt),
    .io_out_d_ready        (auto_out_d_ready),
    .io_out_e_valid        (auto_out_e_valid),
    .io_out_e_bits_sink    (auto_out_e_bits_sink),
    .io_req_ready          (_mods_0_io_req_ready),
    .io_resp_valid         (_mods_0_io_resp_valid)
  );
  assign auto_ctl_in_a_ready = in_ready;	// RegisterRouter.scala:79:24
  assign auto_ctl_in_d_valid = out_valid;	// RegisterRouter.scala:79:24
  assign auto_ctl_in_d_bits_opcode = bundleIn_0_1_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_ctl_in_d_bits_size = _out_back_io_deq_bits_extra_tlrr_extra_size;	// Decoupled.scala:296:21
  assign auto_ctl_in_d_bits_source = _out_back_io_deq_bits_extra_tlrr_extra_source;	// Decoupled.scala:296:21
  assign auto_ctl_in_d_bits_data = _GEN_7[out_oindex] ? _GEN[out_oindex] : 64'h0;	// Cat.scala:30:58, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  assign auto_in_a_ready = _mods_0_io_in_a_ready;	// InclusiveCache.scala:199:29
  assign auto_in_b_valid = _mods_0_io_in_b_valid;	// InclusiveCache.scala:199:29
  assign auto_in_b_bits_param = _mods_0_io_in_b_bits_param;	// InclusiveCache.scala:199:29
  assign auto_in_b_bits_source = _mods_0_io_in_b_bits_source;	// InclusiveCache.scala:199:29
  assign auto_in_b_bits_address = bundleIn_0_b_bits_address;	// Parameters.scala:244:14
  assign auto_in_c_ready = _mods_0_io_in_c_ready;	// InclusiveCache.scala:199:29
  assign auto_in_d_valid = _mods_0_io_in_d_valid;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_opcode = _mods_0_io_in_d_bits_opcode;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_param = _mods_0_io_in_d_bits_param;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_size = _mods_0_io_in_d_bits_size;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_source = _mods_0_io_in_d_bits_source;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_sink = _mods_0_io_in_d_bits_sink;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_denied = _mods_0_io_in_d_bits_denied;	// InclusiveCache.scala:199:29
  assign auto_in_d_bits_corrupt = _mods_0_io_in_d_bits_corrupt;	// InclusiveCache.scala:199:29
  assign auto_out_a_bits_address =
    {_mods_0_io_out_a_bits_address[31:29],
     _mods_0_io_out_a_bits_address[28:0]
       | {{_mods_0_io_out_a_bits_address[31], _mods_0_io_out_a_bits_address[17]} == 2'h0,
          28'h0}};	// InclusiveCache.scala:158:55, :199:29, Mux.scala:27:72, Parameters.scala:137:{49,52,67}, :244:14
  assign auto_out_c_bits_address =
    {_mods_0_io_out_c_bits_address[31:29],
     _mods_0_io_out_c_bits_address[28:0]
       | {{_mods_0_io_out_c_bits_address[31], _mods_0_io_out_c_bits_address[17]} == 2'h0,
          28'h0}};	// InclusiveCache.scala:158:55, :199:29, Mux.scala:27:72, Parameters.scala:137:{49,52,67}, :244:14
endmodule

