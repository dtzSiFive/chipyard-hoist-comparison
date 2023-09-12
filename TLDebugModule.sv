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

module TLDebugModule(
  input         auto_dmInner_dmInner_tl_in_a_valid,
  input  [2:0]  auto_dmInner_dmInner_tl_in_a_bits_opcode,
                auto_dmInner_dmInner_tl_in_a_bits_param,
  input  [1:0]  auto_dmInner_dmInner_tl_in_a_bits_size,
  input  [11:0] auto_dmInner_dmInner_tl_in_a_bits_source,
                auto_dmInner_dmInner_tl_in_a_bits_address,
  input  [7:0]  auto_dmInner_dmInner_tl_in_a_bits_mask,
  input  [63:0] auto_dmInner_dmInner_tl_in_a_bits_data,
  input         auto_dmInner_dmInner_tl_in_a_bits_corrupt,
                auto_dmInner_dmInner_tl_in_d_ready,
                io_debug_clock,
                io_debug_reset,
                io_ctrl_dmactiveAck,
                io_dmi_dmi_req_valid,
  input  [6:0]  io_dmi_dmi_req_bits_addr,
  input  [31:0] io_dmi_dmi_req_bits_data,
  input  [1:0]  io_dmi_dmi_req_bits_op,
  input         io_dmi_dmi_resp_ready,
                io_dmi_dmiClock,
                io_dmi_dmiReset,
                io_hartIsInReset_0,
                io_hartIsInReset_1,
                io_hartIsInReset_2,
                io_hartIsInReset_3,
                io_hartIsInReset_4,
                io_hartIsInReset_5,
  output        auto_dmInner_dmInner_tl_in_a_ready,
                auto_dmInner_dmInner_tl_in_d_valid,
  output [2:0]  auto_dmInner_dmInner_tl_in_d_bits_opcode,
  output [1:0]  auto_dmInner_dmInner_tl_in_d_bits_size,
  output [11:0] auto_dmInner_dmInner_tl_in_d_bits_source,
  output [63:0] auto_dmInner_dmInner_tl_in_d_bits_data,
  output        auto_dmOuter_intsource_out_5_sync_0,
                auto_dmOuter_intsource_out_4_sync_0,
                auto_dmOuter_intsource_out_3_sync_0,
                auto_dmOuter_intsource_out_2_sync_0,
                auto_dmOuter_intsource_out_1_sync_0,
                auto_dmOuter_intsource_out_0_sync_0,
                io_ctrl_dmactive,
                io_dmi_dmi_req_ready,
                io_dmi_dmi_resp_valid,
  output [31:0] io_dmi_dmi_resp_bits_data,
  output [1:0]  io_dmi_dmi_resp_bits_resp
);

  wire        _dmInner_auto_dmiXing_in_a_ridx;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_a_safe_ridx_valid;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_a_safe_sink_reset_n;	// Debug.scala:1820:53
  wire [2:0]  _dmInner_auto_dmiXing_in_d_mem_0_opcode;	// Debug.scala:1820:53
  wire [1:0]  _dmInner_auto_dmiXing_in_d_mem_0_param;	// Debug.scala:1820:53
  wire [1:0]  _dmInner_auto_dmiXing_in_d_mem_0_size;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_mem_0_source;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_mem_0_sink;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_mem_0_denied;	// Debug.scala:1820:53
  wire [31:0] _dmInner_auto_dmiXing_in_d_mem_0_data;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_mem_0_corrupt;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_widx;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_safe_widx_valid;	// Debug.scala:1820:53
  wire        _dmInner_auto_dmiXing_in_d_safe_source_reset_n;	// Debug.scala:1820:53
  wire        _dmInner_io_innerCtrl_ridx;	// Debug.scala:1820:53
  wire        _dmInner_io_innerCtrl_safe_ridx_valid;	// Debug.scala:1820:53
  wire        _dmInner_io_innerCtrl_safe_sink_reset_n;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_0;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_1;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_2;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_3;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_4;	// Debug.scala:1820:53
  wire        _dmInner_io_hgDebugInt_5;	// Debug.scala:1820:53
  wire [2:0]  _dmOuter_auto_asource_out_a_mem_0_opcode;	// Debug.scala:1819:53
  wire [2:0]  _dmOuter_auto_asource_out_a_mem_0_param;	// Debug.scala:1819:53
  wire [1:0]  _dmOuter_auto_asource_out_a_mem_0_size;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_a_mem_0_source;	// Debug.scala:1819:53
  wire [8:0]  _dmOuter_auto_asource_out_a_mem_0_address;	// Debug.scala:1819:53
  wire [3:0]  _dmOuter_auto_asource_out_a_mem_0_mask;	// Debug.scala:1819:53
  wire [31:0] _dmOuter_auto_asource_out_a_mem_0_data;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_a_mem_0_corrupt;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_a_widx;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_a_safe_widx_valid;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_a_safe_source_reset_n;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_d_ridx;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_d_safe_ridx_valid;	// Debug.scala:1819:53
  wire        _dmOuter_auto_asource_out_d_safe_sink_reset_n;	// Debug.scala:1819:53
  wire        _dmOuter_io_ctrl_dmactive;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_resumereq;	// Debug.scala:1819:53
  wire [9:0]  _dmOuter_io_innerCtrl_mem_0_hartsel;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_ackhavereset;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hasel;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_0;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_1;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_2;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_3;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_4;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hamask_5;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_0;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_1;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_2;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_3;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_4;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_mem_0_hrmask_5;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_widx;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_safe_widx_valid;	// Debug.scala:1819:53
  wire        _dmOuter_io_innerCtrl_safe_source_reset_n;	// Debug.scala:1819:53
  TLDebugModuleOuterAsync dmOuter (	// Debug.scala:1819:53
    .auto_asource_out_a_ridx                (_dmInner_auto_dmiXing_in_a_ridx),	// Debug.scala:1820:53
    .auto_asource_out_a_safe_ridx_valid     (_dmInner_auto_dmiXing_in_a_safe_ridx_valid),	// Debug.scala:1820:53
    .auto_asource_out_a_safe_sink_reset_n
      (_dmInner_auto_dmiXing_in_a_safe_sink_reset_n),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_opcode        (_dmInner_auto_dmiXing_in_d_mem_0_opcode),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_param         (_dmInner_auto_dmiXing_in_d_mem_0_param),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_size          (_dmInner_auto_dmiXing_in_d_mem_0_size),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_source        (_dmInner_auto_dmiXing_in_d_mem_0_source),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_sink          (_dmInner_auto_dmiXing_in_d_mem_0_sink),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_denied        (_dmInner_auto_dmiXing_in_d_mem_0_denied),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_data          (_dmInner_auto_dmiXing_in_d_mem_0_data),	// Debug.scala:1820:53
    .auto_asource_out_d_mem_0_corrupt       (_dmInner_auto_dmiXing_in_d_mem_0_corrupt),	// Debug.scala:1820:53
    .auto_asource_out_d_widx                (_dmInner_auto_dmiXing_in_d_widx),	// Debug.scala:1820:53
    .auto_asource_out_d_safe_widx_valid     (_dmInner_auto_dmiXing_in_d_safe_widx_valid),	// Debug.scala:1820:53
    .auto_asource_out_d_safe_source_reset_n
      (_dmInner_auto_dmiXing_in_d_safe_source_reset_n),	// Debug.scala:1820:53
    .io_dmi_clock                           (io_dmi_dmiClock),
    .io_dmi_reset                           (io_dmi_dmiReset),
    .io_dmi_req_valid                       (io_dmi_dmi_req_valid),
    .io_dmi_req_bits_addr                   (io_dmi_dmi_req_bits_addr),
    .io_dmi_req_bits_data                   (io_dmi_dmi_req_bits_data),
    .io_dmi_req_bits_op                     (io_dmi_dmi_req_bits_op),
    .io_dmi_resp_ready                      (io_dmi_dmi_resp_ready),
    .io_ctrl_dmactiveAck                    (io_ctrl_dmactiveAck),
    .io_innerCtrl_ridx                      (_dmInner_io_innerCtrl_ridx),	// Debug.scala:1820:53
    .io_innerCtrl_safe_ridx_valid           (_dmInner_io_innerCtrl_safe_ridx_valid),	// Debug.scala:1820:53
    .io_innerCtrl_safe_sink_reset_n         (_dmInner_io_innerCtrl_safe_sink_reset_n),	// Debug.scala:1820:53
    .io_hgDebugInt_0                        (_dmInner_io_hgDebugInt_0),	// Debug.scala:1820:53
    .io_hgDebugInt_1                        (_dmInner_io_hgDebugInt_1),	// Debug.scala:1820:53
    .io_hgDebugInt_2                        (_dmInner_io_hgDebugInt_2),	// Debug.scala:1820:53
    .io_hgDebugInt_3                        (_dmInner_io_hgDebugInt_3),	// Debug.scala:1820:53
    .io_hgDebugInt_4                        (_dmInner_io_hgDebugInt_4),	// Debug.scala:1820:53
    .io_hgDebugInt_5                        (_dmInner_io_hgDebugInt_5),	// Debug.scala:1820:53
    .auto_asource_out_a_mem_0_opcode        (_dmOuter_auto_asource_out_a_mem_0_opcode),
    .auto_asource_out_a_mem_0_param         (_dmOuter_auto_asource_out_a_mem_0_param),
    .auto_asource_out_a_mem_0_size          (_dmOuter_auto_asource_out_a_mem_0_size),
    .auto_asource_out_a_mem_0_source        (_dmOuter_auto_asource_out_a_mem_0_source),
    .auto_asource_out_a_mem_0_address       (_dmOuter_auto_asource_out_a_mem_0_address),
    .auto_asource_out_a_mem_0_mask          (_dmOuter_auto_asource_out_a_mem_0_mask),
    .auto_asource_out_a_mem_0_data          (_dmOuter_auto_asource_out_a_mem_0_data),
    .auto_asource_out_a_mem_0_corrupt       (_dmOuter_auto_asource_out_a_mem_0_corrupt),
    .auto_asource_out_a_widx                (_dmOuter_auto_asource_out_a_widx),
    .auto_asource_out_a_safe_widx_valid     (_dmOuter_auto_asource_out_a_safe_widx_valid),
    .auto_asource_out_a_safe_source_reset_n
      (_dmOuter_auto_asource_out_a_safe_source_reset_n),
    .auto_asource_out_d_ridx                (_dmOuter_auto_asource_out_d_ridx),
    .auto_asource_out_d_safe_ridx_valid     (_dmOuter_auto_asource_out_d_safe_ridx_valid),
    .auto_asource_out_d_safe_sink_reset_n
      (_dmOuter_auto_asource_out_d_safe_sink_reset_n),
    .auto_intsource_out_5_sync_0            (auto_dmOuter_intsource_out_5_sync_0),
    .auto_intsource_out_4_sync_0            (auto_dmOuter_intsource_out_4_sync_0),
    .auto_intsource_out_3_sync_0            (auto_dmOuter_intsource_out_3_sync_0),
    .auto_intsource_out_2_sync_0            (auto_dmOuter_intsource_out_2_sync_0),
    .auto_intsource_out_1_sync_0            (auto_dmOuter_intsource_out_1_sync_0),
    .auto_intsource_out_0_sync_0            (auto_dmOuter_intsource_out_0_sync_0),
    .io_dmi_req_ready                       (io_dmi_dmi_req_ready),
    .io_dmi_resp_valid                      (io_dmi_dmi_resp_valid),
    .io_dmi_resp_bits_data                  (io_dmi_dmi_resp_bits_data),
    .io_dmi_resp_bits_resp                  (io_dmi_dmi_resp_bits_resp),
    .io_ctrl_dmactive                       (_dmOuter_io_ctrl_dmactive),
    .io_innerCtrl_mem_0_resumereq           (_dmOuter_io_innerCtrl_mem_0_resumereq),
    .io_innerCtrl_mem_0_hartsel             (_dmOuter_io_innerCtrl_mem_0_hartsel),
    .io_innerCtrl_mem_0_ackhavereset        (_dmOuter_io_innerCtrl_mem_0_ackhavereset),
    .io_innerCtrl_mem_0_hasel               (_dmOuter_io_innerCtrl_mem_0_hasel),
    .io_innerCtrl_mem_0_hamask_0            (_dmOuter_io_innerCtrl_mem_0_hamask_0),
    .io_innerCtrl_mem_0_hamask_1            (_dmOuter_io_innerCtrl_mem_0_hamask_1),
    .io_innerCtrl_mem_0_hamask_2            (_dmOuter_io_innerCtrl_mem_0_hamask_2),
    .io_innerCtrl_mem_0_hamask_3            (_dmOuter_io_innerCtrl_mem_0_hamask_3),
    .io_innerCtrl_mem_0_hamask_4            (_dmOuter_io_innerCtrl_mem_0_hamask_4),
    .io_innerCtrl_mem_0_hamask_5            (_dmOuter_io_innerCtrl_mem_0_hamask_5),
    .io_innerCtrl_mem_0_hrmask_0            (_dmOuter_io_innerCtrl_mem_0_hrmask_0),
    .io_innerCtrl_mem_0_hrmask_1            (_dmOuter_io_innerCtrl_mem_0_hrmask_1),
    .io_innerCtrl_mem_0_hrmask_2            (_dmOuter_io_innerCtrl_mem_0_hrmask_2),
    .io_innerCtrl_mem_0_hrmask_3            (_dmOuter_io_innerCtrl_mem_0_hrmask_3),
    .io_innerCtrl_mem_0_hrmask_4            (_dmOuter_io_innerCtrl_mem_0_hrmask_4),
    .io_innerCtrl_mem_0_hrmask_5            (_dmOuter_io_innerCtrl_mem_0_hrmask_5),
    .io_innerCtrl_widx                      (_dmOuter_io_innerCtrl_widx),
    .io_innerCtrl_safe_widx_valid           (_dmOuter_io_innerCtrl_safe_widx_valid),
    .io_innerCtrl_safe_source_reset_n       (_dmOuter_io_innerCtrl_safe_source_reset_n)
  );
  TLDebugModuleInnerAsync dmInner (	// Debug.scala:1820:53
    .auto_dmiXing_in_a_mem_0_opcode        (_dmOuter_auto_asource_out_a_mem_0_opcode),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_param         (_dmOuter_auto_asource_out_a_mem_0_param),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_size          (_dmOuter_auto_asource_out_a_mem_0_size),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_source        (_dmOuter_auto_asource_out_a_mem_0_source),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_address       (_dmOuter_auto_asource_out_a_mem_0_address),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_mask          (_dmOuter_auto_asource_out_a_mem_0_mask),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_data          (_dmOuter_auto_asource_out_a_mem_0_data),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_mem_0_corrupt       (_dmOuter_auto_asource_out_a_mem_0_corrupt),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_widx                (_dmOuter_auto_asource_out_a_widx),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_safe_widx_valid     (_dmOuter_auto_asource_out_a_safe_widx_valid),	// Debug.scala:1819:53
    .auto_dmiXing_in_a_safe_source_reset_n
      (_dmOuter_auto_asource_out_a_safe_source_reset_n),	// Debug.scala:1819:53
    .auto_dmiXing_in_d_ridx                (_dmOuter_auto_asource_out_d_ridx),	// Debug.scala:1819:53
    .auto_dmiXing_in_d_safe_ridx_valid     (_dmOuter_auto_asource_out_d_safe_ridx_valid),	// Debug.scala:1819:53
    .auto_dmiXing_in_d_safe_sink_reset_n
      (_dmOuter_auto_asource_out_d_safe_sink_reset_n),	// Debug.scala:1819:53
    .auto_dmInner_tl_in_a_valid            (auto_dmInner_dmInner_tl_in_a_valid),
    .auto_dmInner_tl_in_a_bits_opcode      (auto_dmInner_dmInner_tl_in_a_bits_opcode),
    .auto_dmInner_tl_in_a_bits_param       (auto_dmInner_dmInner_tl_in_a_bits_param),
    .auto_dmInner_tl_in_a_bits_size        (auto_dmInner_dmInner_tl_in_a_bits_size),
    .auto_dmInner_tl_in_a_bits_source      (auto_dmInner_dmInner_tl_in_a_bits_source),
    .auto_dmInner_tl_in_a_bits_address     (auto_dmInner_dmInner_tl_in_a_bits_address),
    .auto_dmInner_tl_in_a_bits_mask        (auto_dmInner_dmInner_tl_in_a_bits_mask),
    .auto_dmInner_tl_in_a_bits_data        (auto_dmInner_dmInner_tl_in_a_bits_data),
    .auto_dmInner_tl_in_a_bits_corrupt     (auto_dmInner_dmInner_tl_in_a_bits_corrupt),
    .auto_dmInner_tl_in_d_ready            (auto_dmInner_dmInner_tl_in_d_ready),
    .io_debug_clock                        (io_debug_clock),
    .io_debug_reset                        (io_debug_reset),
    .io_dmactive                           (_dmOuter_io_ctrl_dmactive),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_resumereq          (_dmOuter_io_innerCtrl_mem_0_resumereq),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hartsel            (_dmOuter_io_innerCtrl_mem_0_hartsel),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_ackhavereset       (_dmOuter_io_innerCtrl_mem_0_ackhavereset),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hasel              (_dmOuter_io_innerCtrl_mem_0_hasel),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_0           (_dmOuter_io_innerCtrl_mem_0_hamask_0),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_1           (_dmOuter_io_innerCtrl_mem_0_hamask_1),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_2           (_dmOuter_io_innerCtrl_mem_0_hamask_2),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_3           (_dmOuter_io_innerCtrl_mem_0_hamask_3),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_4           (_dmOuter_io_innerCtrl_mem_0_hamask_4),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hamask_5           (_dmOuter_io_innerCtrl_mem_0_hamask_5),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_0           (_dmOuter_io_innerCtrl_mem_0_hrmask_0),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_1           (_dmOuter_io_innerCtrl_mem_0_hrmask_1),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_2           (_dmOuter_io_innerCtrl_mem_0_hrmask_2),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_3           (_dmOuter_io_innerCtrl_mem_0_hrmask_3),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_4           (_dmOuter_io_innerCtrl_mem_0_hrmask_4),	// Debug.scala:1819:53
    .io_innerCtrl_mem_0_hrmask_5           (_dmOuter_io_innerCtrl_mem_0_hrmask_5),	// Debug.scala:1819:53
    .io_innerCtrl_widx                     (_dmOuter_io_innerCtrl_widx),	// Debug.scala:1819:53
    .io_innerCtrl_safe_widx_valid          (_dmOuter_io_innerCtrl_safe_widx_valid),	// Debug.scala:1819:53
    .io_innerCtrl_safe_source_reset_n      (_dmOuter_io_innerCtrl_safe_source_reset_n),	// Debug.scala:1819:53
    .io_hartIsInReset_0                    (io_hartIsInReset_0),
    .io_hartIsInReset_1                    (io_hartIsInReset_1),
    .io_hartIsInReset_2                    (io_hartIsInReset_2),
    .io_hartIsInReset_3                    (io_hartIsInReset_3),
    .io_hartIsInReset_4                    (io_hartIsInReset_4),
    .io_hartIsInReset_5                    (io_hartIsInReset_5),
    .auto_dmiXing_in_a_ridx                (_dmInner_auto_dmiXing_in_a_ridx),
    .auto_dmiXing_in_a_safe_ridx_valid     (_dmInner_auto_dmiXing_in_a_safe_ridx_valid),
    .auto_dmiXing_in_a_safe_sink_reset_n   (_dmInner_auto_dmiXing_in_a_safe_sink_reset_n),
    .auto_dmiXing_in_d_mem_0_opcode        (_dmInner_auto_dmiXing_in_d_mem_0_opcode),
    .auto_dmiXing_in_d_mem_0_param         (_dmInner_auto_dmiXing_in_d_mem_0_param),
    .auto_dmiXing_in_d_mem_0_size          (_dmInner_auto_dmiXing_in_d_mem_0_size),
    .auto_dmiXing_in_d_mem_0_source        (_dmInner_auto_dmiXing_in_d_mem_0_source),
    .auto_dmiXing_in_d_mem_0_sink          (_dmInner_auto_dmiXing_in_d_mem_0_sink),
    .auto_dmiXing_in_d_mem_0_denied        (_dmInner_auto_dmiXing_in_d_mem_0_denied),
    .auto_dmiXing_in_d_mem_0_data          (_dmInner_auto_dmiXing_in_d_mem_0_data),
    .auto_dmiXing_in_d_mem_0_corrupt       (_dmInner_auto_dmiXing_in_d_mem_0_corrupt),
    .auto_dmiXing_in_d_widx                (_dmInner_auto_dmiXing_in_d_widx),
    .auto_dmiXing_in_d_safe_widx_valid     (_dmInner_auto_dmiXing_in_d_safe_widx_valid),
    .auto_dmiXing_in_d_safe_source_reset_n
      (_dmInner_auto_dmiXing_in_d_safe_source_reset_n),
    .auto_dmInner_tl_in_a_ready            (auto_dmInner_dmInner_tl_in_a_ready),
    .auto_dmInner_tl_in_d_valid            (auto_dmInner_dmInner_tl_in_d_valid),
    .auto_dmInner_tl_in_d_bits_opcode      (auto_dmInner_dmInner_tl_in_d_bits_opcode),
    .auto_dmInner_tl_in_d_bits_size        (auto_dmInner_dmInner_tl_in_d_bits_size),
    .auto_dmInner_tl_in_d_bits_source      (auto_dmInner_dmInner_tl_in_d_bits_source),
    .auto_dmInner_tl_in_d_bits_data        (auto_dmInner_dmInner_tl_in_d_bits_data),
    .io_innerCtrl_ridx                     (_dmInner_io_innerCtrl_ridx),
    .io_innerCtrl_safe_ridx_valid          (_dmInner_io_innerCtrl_safe_ridx_valid),
    .io_innerCtrl_safe_sink_reset_n        (_dmInner_io_innerCtrl_safe_sink_reset_n),
    .io_hgDebugInt_0                       (_dmInner_io_hgDebugInt_0),
    .io_hgDebugInt_1                       (_dmInner_io_hgDebugInt_1),
    .io_hgDebugInt_2                       (_dmInner_io_hgDebugInt_2),
    .io_hgDebugInt_3                       (_dmInner_io_hgDebugInt_3),
    .io_hgDebugInt_4                       (_dmInner_io_hgDebugInt_4),
    .io_hgDebugInt_5                       (_dmInner_io_hgDebugInt_5)
  );
  assign io_ctrl_dmactive = _dmOuter_io_ctrl_dmactive;	// Debug.scala:1819:53
endmodule

