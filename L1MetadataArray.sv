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

module L1MetadataArray(
  input         clock,
                reset,
                io_read_valid,
  input  [5:0]  io_read_bits_idx,
  input         io_write_valid,
  input  [5:0]  io_write_bits_idx,
  input  [7:0]  io_write_bits_way_en,
  input  [1:0]  io_write_bits_data_coh_state,
  input  [19:0] io_write_bits_data_tag,
  output        io_read_ready,
                io_write_ready,
  output [1:0]  io_resp_0_coh_state,
  output [19:0] io_resp_0_tag,
  output [1:0]  io_resp_1_coh_state,
  output [19:0] io_resp_1_tag,
  output [1:0]  io_resp_2_coh_state,
  output [19:0] io_resp_2_tag,
  output [1:0]  io_resp_3_coh_state,
  output [19:0] io_resp_3_tag,
  output [1:0]  io_resp_4_coh_state,
  output [19:0] io_resp_4_tag,
  output [1:0]  io_resp_5_coh_state,
  output [19:0] io_resp_5_tag,
  output [1:0]  io_resp_6_coh_state,
  output [19:0] io_resp_6_tag,
  output [1:0]  io_resp_7_coh_state,
  output [19:0] io_resp_7_tag
);

  wire [175:0] _tag_array_ext_R0_data;	// HellaCache.scala:322:25
  reg  [6:0]   rst_cnt;	// HellaCache.scala:313:20
  wire [1:0]   _wdata_T_coh_state = rst_cnt[6] ? io_write_bits_data_coh_state : 2'h0;	// HellaCache.scala:313:20, :314:21, :316:18, Metadata.scala:160:16
  wire [19:0]  _wdata_T_tag = rst_cnt[6] ? io_write_bits_data_tag : 20'h0;	// HellaCache.scala:290:14, :313:20, :314:21, :316:18
  wire         tag_array_MPORT_en = ~(rst_cnt[6]) | io_write_valid;	// HellaCache.scala:313:20, :314:21, :323:17
  always @(posedge clock) begin
    if (reset)
      rst_cnt <= 7'h0;	// HellaCache.scala:313:20
    else if (rst_cnt[6]) begin	// HellaCache.scala:313:20, :314:21
    end
    else	// HellaCache.scala:314:21
      rst_cnt <= rst_cnt + 7'h1;	// HellaCache.scala:313:20, :319:34
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        rst_cnt = _RANDOM[/*Zero width*/ 1'b0][6:0];	// HellaCache.scala:313:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  tag_array_64x176 tag_array_ext (	// HellaCache.scala:322:25
    .R0_addr (io_read_bits_idx),
    .R0_en   (~tag_array_MPORT_en & io_read_valid),	// Decoupled.scala:40:37, HellaCache.scala:323:17, :329:20
    .R0_clk  (clock),
    .W0_addr (rst_cnt[6] ? io_write_bits_idx : rst_cnt[5:0]),	// HellaCache.scala:313:20, :314:21, :315:18
    .W0_en   (tag_array_MPORT_en),	// HellaCache.scala:323:17
    .W0_clk  (clock),
    .W0_data
      ({_wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag,
        _wdata_T_coh_state,
        _wdata_T_tag}),	// HellaCache.scala:316:18, :322:25
    .W0_mask (rst_cnt[6] ? io_write_bits_way_en : 8'hFF),	// HellaCache.scala:313:20, :314:21, :317:18
    .R0_data (_tag_array_ext_R0_data)
  );
  assign io_read_ready = ~tag_array_MPORT_en;	// HellaCache.scala:323:17, :329:20
  assign io_write_ready = rst_cnt[6];	// HellaCache.scala:313:20, :314:21
  assign io_resp_0_coh_state = _tag_array_ext_R0_data[21:20];	// HellaCache.scala:322:25, :327:82
  assign io_resp_0_tag = _tag_array_ext_R0_data[19:0];	// HellaCache.scala:322:25, :327:82
  assign io_resp_1_coh_state = _tag_array_ext_R0_data[43:42];	// HellaCache.scala:322:25, :327:82
  assign io_resp_1_tag = _tag_array_ext_R0_data[41:22];	// HellaCache.scala:322:25, :327:82
  assign io_resp_2_coh_state = _tag_array_ext_R0_data[65:64];	// HellaCache.scala:322:25, :327:82
  assign io_resp_2_tag = _tag_array_ext_R0_data[63:44];	// HellaCache.scala:322:25, :327:82
  assign io_resp_3_coh_state = _tag_array_ext_R0_data[87:86];	// HellaCache.scala:322:25, :327:82
  assign io_resp_3_tag = _tag_array_ext_R0_data[85:66];	// HellaCache.scala:322:25, :327:82
  assign io_resp_4_coh_state = _tag_array_ext_R0_data[109:108];	// HellaCache.scala:322:25, :327:82
  assign io_resp_4_tag = _tag_array_ext_R0_data[107:88];	// HellaCache.scala:322:25, :327:82
  assign io_resp_5_coh_state = _tag_array_ext_R0_data[131:130];	// HellaCache.scala:322:25, :327:82
  assign io_resp_5_tag = _tag_array_ext_R0_data[129:110];	// HellaCache.scala:322:25, :327:82
  assign io_resp_6_coh_state = _tag_array_ext_R0_data[153:152];	// HellaCache.scala:322:25, :327:82
  assign io_resp_6_tag = _tag_array_ext_R0_data[151:132];	// HellaCache.scala:322:25, :327:82
  assign io_resp_7_coh_state = _tag_array_ext_R0_data[175:174];	// HellaCache.scala:322:25, :327:82
  assign io_resp_7_tag = _tag_array_ext_R0_data[173:154];	// HellaCache.scala:322:25, :327:82
endmodule

