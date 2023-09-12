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

module TLDebugModuleOuterAsync(
  input         auto_asource_out_a_ridx,
                auto_asource_out_a_safe_ridx_valid,
                auto_asource_out_a_safe_sink_reset_n,
  input  [2:0]  auto_asource_out_d_mem_0_opcode,
  input  [1:0]  auto_asource_out_d_mem_0_param,
                auto_asource_out_d_mem_0_size,
  input         auto_asource_out_d_mem_0_source,
                auto_asource_out_d_mem_0_sink,
                auto_asource_out_d_mem_0_denied,
  input  [31:0] auto_asource_out_d_mem_0_data,
  input         auto_asource_out_d_mem_0_corrupt,
                auto_asource_out_d_widx,
                auto_asource_out_d_safe_widx_valid,
                auto_asource_out_d_safe_source_reset_n,
                io_dmi_clock,
                io_dmi_reset,
                io_dmi_req_valid,
  input  [6:0]  io_dmi_req_bits_addr,
  input  [31:0] io_dmi_req_bits_data,
  input  [1:0]  io_dmi_req_bits_op,
  input         io_dmi_resp_ready,
                io_ctrl_dmactiveAck,
                io_innerCtrl_ridx,
                io_innerCtrl_safe_ridx_valid,
                io_innerCtrl_safe_sink_reset_n,
                io_hgDebugInt_0,
                io_hgDebugInt_1,
                io_hgDebugInt_2,
                io_hgDebugInt_3,
                io_hgDebugInt_4,
                io_hgDebugInt_5,
  output [2:0]  auto_asource_out_a_mem_0_opcode,
                auto_asource_out_a_mem_0_param,
  output [1:0]  auto_asource_out_a_mem_0_size,
  output        auto_asource_out_a_mem_0_source,
  output [8:0]  auto_asource_out_a_mem_0_address,
  output [3:0]  auto_asource_out_a_mem_0_mask,
  output [31:0] auto_asource_out_a_mem_0_data,
  output        auto_asource_out_a_mem_0_corrupt,
                auto_asource_out_a_widx,
                auto_asource_out_a_safe_widx_valid,
                auto_asource_out_a_safe_source_reset_n,
                auto_asource_out_d_ridx,
                auto_asource_out_d_safe_ridx_valid,
                auto_asource_out_d_safe_sink_reset_n,
                auto_intsource_out_5_sync_0,
                auto_intsource_out_4_sync_0,
                auto_intsource_out_3_sync_0,
                auto_intsource_out_2_sync_0,
                auto_intsource_out_1_sync_0,
                auto_intsource_out_0_sync_0,
                io_dmi_req_ready,
                io_dmi_resp_valid,
  output [31:0] io_dmi_resp_bits_data,
  output [1:0]  io_dmi_resp_bits_resp,
  output        io_ctrl_dmactive,
                io_innerCtrl_mem_0_resumereq,
  output [9:0]  io_innerCtrl_mem_0_hartsel,
  output        io_innerCtrl_mem_0_ackhavereset,
                io_innerCtrl_mem_0_hasel,
                io_innerCtrl_mem_0_hamask_0,
                io_innerCtrl_mem_0_hamask_1,
                io_innerCtrl_mem_0_hamask_2,
                io_innerCtrl_mem_0_hamask_3,
                io_innerCtrl_mem_0_hamask_4,
                io_innerCtrl_mem_0_hamask_5,
                io_innerCtrl_mem_0_hrmask_0,
                io_innerCtrl_mem_0_hrmask_1,
                io_innerCtrl_mem_0_hrmask_2,
                io_innerCtrl_mem_0_hrmask_3,
                io_innerCtrl_mem_0_hrmask_4,
                io_innerCtrl_mem_0_hrmask_5,
                io_innerCtrl_widx,
                io_innerCtrl_safe_widx_valid,
                io_innerCtrl_safe_source_reset_n
);

  wire        _io_innerCtrl_source_io_enq_ready;	// AsyncQueue.scala:216:24
  wire        _dmactiveAck_dmactiveAckSync_io_q;	// ShiftReg.scala:45:23
  wire        _asource_auto_in_a_ready;	// AsyncCrossing.scala:87:29
  wire        _asource_auto_in_d_valid;	// AsyncCrossing.scala:87:29
  wire [2:0]  _asource_auto_in_d_bits_opcode;	// AsyncCrossing.scala:87:29
  wire [1:0]  _asource_auto_in_d_bits_param;	// AsyncCrossing.scala:87:29
  wire [1:0]  _asource_auto_in_d_bits_size;	// AsyncCrossing.scala:87:29
  wire        _asource_auto_in_d_bits_source;	// AsyncCrossing.scala:87:29
  wire        _asource_auto_in_d_bits_sink;	// AsyncCrossing.scala:87:29
  wire        _asource_auto_in_d_bits_denied;	// AsyncCrossing.scala:87:29
  wire [31:0] _asource_auto_in_d_bits_data;	// AsyncCrossing.scala:87:29
  wire        _asource_auto_in_d_bits_corrupt;	// AsyncCrossing.scala:87:29
  wire        _dmiBypass_auto_node_out_out_a_valid;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_out_out_d_ready;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_in_in_a_ready;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_in_in_d_valid;	// Debug.scala:652:29
  wire [2:0]  _dmiBypass_auto_node_in_in_d_bits_opcode;	// Debug.scala:652:29
  wire [1:0]  _dmiBypass_auto_node_in_in_d_bits_param;	// Debug.scala:652:29
  wire [1:0]  _dmiBypass_auto_node_in_in_d_bits_size;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_in_in_d_bits_sink;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_in_in_d_bits_denied;	// Debug.scala:652:29
  wire [31:0] _dmiBypass_auto_node_in_in_d_bits_data;	// Debug.scala:652:29
  wire        _dmiBypass_auto_node_in_in_d_bits_corrupt;	// Debug.scala:652:29
  wire [2:0]  _dmOuter_auto_dmi_in_d_bits_opcode;	// Debug.scala:649:27
  wire [31:0] _dmOuter_auto_dmi_in_d_bits_data;	// Debug.scala:649:27
  wire        _dmOuter_io_ctrl_dmactive;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_valid;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_resumereq;	// Debug.scala:649:27
  wire [9:0]  _dmOuter_io_innerCtrl_bits_hartsel;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_ackhavereset;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hasel;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_0;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_1;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_2;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_3;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_4;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hamask_5;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_0;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_1;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_2;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_3;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_4;	// Debug.scala:649:27
  wire        _dmOuter_io_innerCtrl_bits_hrmask_5;	// Debug.scala:649:27
  wire [2:0]  _dmi2tl_auto_out_a_bits_opcode;	// Debug.scala:627:28
  wire [8:0]  _dmi2tl_auto_out_a_bits_address;	// Debug.scala:627:28
  wire [31:0] _dmi2tl_auto_out_a_bits_data;	// Debug.scala:627:28
  wire        _dmiXbar_auto_in_d_bits_denied;	// Debug.scala:624:28
  wire        _dmiXbar_auto_in_d_bits_corrupt;	// Debug.scala:624:28
  wire        _dmiXbar_auto_out_1_a_valid;	// Debug.scala:624:28
  wire [6:0]  _dmiXbar_auto_out_1_a_bits_address;	// Debug.scala:624:28
  wire        _dmiXbar_auto_out_1_d_ready;	// Debug.scala:624:28
  wire        _dmiXbar_auto_out_0_a_valid;	// Debug.scala:624:28
  wire        _dmiXbar_auto_out_0_d_ready;	// Debug.scala:624:28
  TLXbar_19 dmiXbar (	// Debug.scala:624:28
    .clock                     (io_dmi_clock),
    .reset                     (io_dmi_reset),
    .auto_in_a_valid           (io_dmi_req_valid),
    .auto_in_a_bits_opcode     (_dmi2tl_auto_out_a_bits_opcode),	// Debug.scala:627:28
    .auto_in_a_bits_address    (_dmi2tl_auto_out_a_bits_address),	// Debug.scala:627:28
    .auto_in_d_ready           (io_dmi_resp_ready),
    .auto_out_1_a_ready        (_dmiXbar_auto_out_1_d_ready),	// Debug.scala:624:28
    .auto_out_1_d_valid        (_dmiXbar_auto_out_1_a_valid),	// Debug.scala:624:28
    .auto_out_1_d_bits_opcode  (_dmOuter_auto_dmi_in_d_bits_opcode),	// Debug.scala:649:27
    .auto_out_1_d_bits_data    (_dmOuter_auto_dmi_in_d_bits_data),	// Debug.scala:649:27
    .auto_out_0_a_ready        (_dmiBypass_auto_node_in_in_a_ready),	// Debug.scala:652:29
    .auto_out_0_d_valid        (_dmiBypass_auto_node_in_in_d_valid),	// Debug.scala:652:29
    .auto_out_0_d_bits_opcode  (_dmiBypass_auto_node_in_in_d_bits_opcode),	// Debug.scala:652:29
    .auto_out_0_d_bits_param   (_dmiBypass_auto_node_in_in_d_bits_param),	// Debug.scala:652:29
    .auto_out_0_d_bits_size    (_dmiBypass_auto_node_in_in_d_bits_size),	// Debug.scala:652:29
    .auto_out_0_d_bits_sink    (_dmiBypass_auto_node_in_in_d_bits_sink),	// Debug.scala:652:29
    .auto_out_0_d_bits_denied  (_dmiBypass_auto_node_in_in_d_bits_denied),	// Debug.scala:652:29
    .auto_out_0_d_bits_data    (_dmiBypass_auto_node_in_in_d_bits_data),	// Debug.scala:652:29
    .auto_out_0_d_bits_corrupt (_dmiBypass_auto_node_in_in_d_bits_corrupt),	// Debug.scala:652:29
    .auto_in_a_ready           (io_dmi_req_ready),
    .auto_in_d_valid           (io_dmi_resp_valid),
    .auto_in_d_bits_denied     (_dmiXbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data       (io_dmi_resp_bits_data),
    .auto_in_d_bits_corrupt    (_dmiXbar_auto_in_d_bits_corrupt),
    .auto_out_1_a_valid        (_dmiXbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_address (_dmiXbar_auto_out_1_a_bits_address),
    .auto_out_1_d_ready        (_dmiXbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_dmiXbar_auto_out_0_a_valid),
    .auto_out_0_d_ready        (_dmiXbar_auto_out_0_d_ready)
  );
  DMIToTL dmi2tl (	// Debug.scala:627:28
    .auto_out_d_bits_denied  (_dmiXbar_auto_in_d_bits_denied),	// Debug.scala:624:28
    .auto_out_d_bits_corrupt (_dmiXbar_auto_in_d_bits_corrupt),	// Debug.scala:624:28
    .io_dmi_req_bits_addr    (io_dmi_req_bits_addr),
    .io_dmi_req_bits_data    (io_dmi_req_bits_data),
    .io_dmi_req_bits_op      (io_dmi_req_bits_op),
    .auto_out_a_bits_opcode  (_dmi2tl_auto_out_a_bits_opcode),
    .auto_out_a_bits_address (_dmi2tl_auto_out_a_bits_address),
    .auto_out_a_bits_data    (_dmi2tl_auto_out_a_bits_data),
    .io_dmi_resp_bits_resp   (io_dmi_resp_bits_resp)
  );
  TLDebugModuleOuter dmOuter (	// Debug.scala:649:27
    .clock                          (io_dmi_clock),
    .reset                          (io_dmi_reset),
    .auto_dmi_in_a_valid            (_dmiXbar_auto_out_1_a_valid),	// Debug.scala:624:28
    .auto_dmi_in_a_bits_opcode      (_dmi2tl_auto_out_a_bits_opcode),	// Debug.scala:627:28
    .auto_dmi_in_a_bits_address     (_dmiXbar_auto_out_1_a_bits_address),	// Debug.scala:624:28
    .auto_dmi_in_a_bits_data        (_dmi2tl_auto_out_a_bits_data),	// Debug.scala:627:28
    .auto_dmi_in_d_ready            (_dmiXbar_auto_out_1_d_ready),	// Debug.scala:624:28
    .io_ctrl_dmactiveAck            (_dmactiveAck_dmactiveAckSync_io_q),	// ShiftReg.scala:45:23
    .io_innerCtrl_ready             (_io_innerCtrl_source_io_enq_ready),	// AsyncQueue.scala:216:24
    .io_hgDebugInt_0                (io_hgDebugInt_0),
    .io_hgDebugInt_1                (io_hgDebugInt_1),
    .io_hgDebugInt_2                (io_hgDebugInt_2),
    .io_hgDebugInt_3                (io_hgDebugInt_3),
    .io_hgDebugInt_4                (io_hgDebugInt_4),
    .io_hgDebugInt_5                (io_hgDebugInt_5),
    .auto_dmi_in_d_bits_opcode      (_dmOuter_auto_dmi_in_d_bits_opcode),
    .auto_dmi_in_d_bits_data        (_dmOuter_auto_dmi_in_d_bits_data),
    .auto_int_out_5_0               (auto_intsource_out_5_sync_0),
    .auto_int_out_4_0               (auto_intsource_out_4_sync_0),
    .auto_int_out_3_0               (auto_intsource_out_3_sync_0),
    .auto_int_out_2_0               (auto_intsource_out_2_sync_0),
    .auto_int_out_1_0               (auto_intsource_out_1_sync_0),
    .auto_int_out_0_0               (auto_intsource_out_0_sync_0),
    .io_ctrl_dmactive               (_dmOuter_io_ctrl_dmactive),
    .io_innerCtrl_valid             (_dmOuter_io_innerCtrl_valid),
    .io_innerCtrl_bits_resumereq    (_dmOuter_io_innerCtrl_bits_resumereq),
    .io_innerCtrl_bits_hartsel      (_dmOuter_io_innerCtrl_bits_hartsel),
    .io_innerCtrl_bits_ackhavereset (_dmOuter_io_innerCtrl_bits_ackhavereset),
    .io_innerCtrl_bits_hasel        (_dmOuter_io_innerCtrl_bits_hasel),
    .io_innerCtrl_bits_hamask_0     (_dmOuter_io_innerCtrl_bits_hamask_0),
    .io_innerCtrl_bits_hamask_1     (_dmOuter_io_innerCtrl_bits_hamask_1),
    .io_innerCtrl_bits_hamask_2     (_dmOuter_io_innerCtrl_bits_hamask_2),
    .io_innerCtrl_bits_hamask_3     (_dmOuter_io_innerCtrl_bits_hamask_3),
    .io_innerCtrl_bits_hamask_4     (_dmOuter_io_innerCtrl_bits_hamask_4),
    .io_innerCtrl_bits_hamask_5     (_dmOuter_io_innerCtrl_bits_hamask_5),
    .io_innerCtrl_bits_hrmask_0     (_dmOuter_io_innerCtrl_bits_hrmask_0),
    .io_innerCtrl_bits_hrmask_1     (_dmOuter_io_innerCtrl_bits_hrmask_1),
    .io_innerCtrl_bits_hrmask_2     (_dmOuter_io_innerCtrl_bits_hrmask_2),
    .io_innerCtrl_bits_hrmask_3     (_dmOuter_io_innerCtrl_bits_hrmask_3),
    .io_innerCtrl_bits_hrmask_4     (_dmOuter_io_innerCtrl_bits_hrmask_4),
    .io_innerCtrl_bits_hrmask_5     (_dmOuter_io_innerCtrl_bits_hrmask_5)
  );
  TLBusBypass dmiBypass (	// Debug.scala:652:29
    .clock                            (io_dmi_clock),
    .reset                            (io_dmi_reset),
    .auto_node_out_out_a_ready        (_asource_auto_in_a_ready),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_valid        (_asource_auto_in_d_valid),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_opcode  (_asource_auto_in_d_bits_opcode),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_param   (_asource_auto_in_d_bits_param),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_size    (_asource_auto_in_d_bits_size),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_source  (_asource_auto_in_d_bits_source),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_sink    (_asource_auto_in_d_bits_sink),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_denied  (_asource_auto_in_d_bits_denied),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_data    (_asource_auto_in_d_bits_data),	// AsyncCrossing.scala:87:29
    .auto_node_out_out_d_bits_corrupt (_asource_auto_in_d_bits_corrupt),	// AsyncCrossing.scala:87:29
    .auto_node_in_in_a_valid          (_dmiXbar_auto_out_0_a_valid),	// Debug.scala:624:28
    .auto_node_in_in_a_bits_opcode    (_dmi2tl_auto_out_a_bits_opcode),	// Debug.scala:627:28
    .auto_node_in_in_a_bits_address   (_dmi2tl_auto_out_a_bits_address),	// Debug.scala:627:28
    .auto_node_in_in_d_ready          (_dmiXbar_auto_out_0_d_ready),	// Debug.scala:624:28
    .io_bypass
      (~_dmOuter_io_ctrl_dmactive | ~_dmactiveAck_dmactiveAckSync_io_q),	// Debug.scala:649:27, :680:{37,55,57}, ShiftReg.scala:45:23
    .auto_node_out_out_a_valid        (_dmiBypass_auto_node_out_out_a_valid),
    .auto_node_out_out_d_ready        (_dmiBypass_auto_node_out_out_d_ready),
    .auto_node_in_in_a_ready          (_dmiBypass_auto_node_in_in_a_ready),
    .auto_node_in_in_d_valid          (_dmiBypass_auto_node_in_in_d_valid),
    .auto_node_in_in_d_bits_opcode    (_dmiBypass_auto_node_in_in_d_bits_opcode),
    .auto_node_in_in_d_bits_param     (_dmiBypass_auto_node_in_in_d_bits_param),
    .auto_node_in_in_d_bits_size      (_dmiBypass_auto_node_in_in_d_bits_size),
    .auto_node_in_in_d_bits_sink      (_dmiBypass_auto_node_in_in_d_bits_sink),
    .auto_node_in_in_d_bits_denied    (_dmiBypass_auto_node_in_in_d_bits_denied),
    .auto_node_in_in_d_bits_data      (_dmiBypass_auto_node_in_in_d_bits_data),
    .auto_node_in_in_d_bits_corrupt   (_dmiBypass_auto_node_in_in_d_bits_corrupt)
  );
  TLAsyncCrossingSource asource (	// AsyncCrossing.scala:87:29
    .clock                          (io_dmi_clock),
    .reset                          (io_dmi_reset),
    .auto_in_a_valid                (_dmiBypass_auto_node_out_out_a_valid),	// Debug.scala:652:29
    .auto_in_a_bits_opcode          (_dmi2tl_auto_out_a_bits_opcode),	// Debug.scala:627:28
    .auto_in_a_bits_address         (_dmi2tl_auto_out_a_bits_address),	// Debug.scala:627:28
    .auto_in_a_bits_data            (_dmi2tl_auto_out_a_bits_data),	// Debug.scala:627:28
    .auto_in_d_ready                (_dmiBypass_auto_node_out_out_d_ready),	// Debug.scala:652:29
    .auto_out_a_ridx                (auto_asource_out_a_ridx),
    .auto_out_a_safe_ridx_valid     (auto_asource_out_a_safe_ridx_valid),
    .auto_out_a_safe_sink_reset_n   (auto_asource_out_a_safe_sink_reset_n),
    .auto_out_d_mem_0_opcode        (auto_asource_out_d_mem_0_opcode),
    .auto_out_d_mem_0_param         (auto_asource_out_d_mem_0_param),
    .auto_out_d_mem_0_size          (auto_asource_out_d_mem_0_size),
    .auto_out_d_mem_0_source        (auto_asource_out_d_mem_0_source),
    .auto_out_d_mem_0_sink          (auto_asource_out_d_mem_0_sink),
    .auto_out_d_mem_0_denied        (auto_asource_out_d_mem_0_denied),
    .auto_out_d_mem_0_data          (auto_asource_out_d_mem_0_data),
    .auto_out_d_mem_0_corrupt       (auto_asource_out_d_mem_0_corrupt),
    .auto_out_d_widx                (auto_asource_out_d_widx),
    .auto_out_d_safe_widx_valid     (auto_asource_out_d_safe_widx_valid),
    .auto_out_d_safe_source_reset_n (auto_asource_out_d_safe_source_reset_n),
    .auto_in_a_ready                (_asource_auto_in_a_ready),
    .auto_in_d_valid                (_asource_auto_in_d_valid),
    .auto_in_d_bits_opcode          (_asource_auto_in_d_bits_opcode),
    .auto_in_d_bits_param           (_asource_auto_in_d_bits_param),
    .auto_in_d_bits_size            (_asource_auto_in_d_bits_size),
    .auto_in_d_bits_source          (_asource_auto_in_d_bits_source),
    .auto_in_d_bits_sink            (_asource_auto_in_d_bits_sink),
    .auto_in_d_bits_denied          (_asource_auto_in_d_bits_denied),
    .auto_in_d_bits_data            (_asource_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt         (_asource_auto_in_d_bits_corrupt),
    .auto_out_a_mem_0_opcode        (auto_asource_out_a_mem_0_opcode),
    .auto_out_a_mem_0_param         (auto_asource_out_a_mem_0_param),
    .auto_out_a_mem_0_size          (auto_asource_out_a_mem_0_size),
    .auto_out_a_mem_0_source        (auto_asource_out_a_mem_0_source),
    .auto_out_a_mem_0_address       (auto_asource_out_a_mem_0_address),
    .auto_out_a_mem_0_mask          (auto_asource_out_a_mem_0_mask),
    .auto_out_a_mem_0_data          (auto_asource_out_a_mem_0_data),
    .auto_out_a_mem_0_corrupt       (auto_asource_out_a_mem_0_corrupt),
    .auto_out_a_widx                (auto_asource_out_a_widx),
    .auto_out_a_safe_widx_valid     (auto_asource_out_a_safe_widx_valid),
    .auto_out_a_safe_source_reset_n (auto_asource_out_a_safe_source_reset_n),
    .auto_out_d_ridx                (auto_asource_out_d_ridx),
    .auto_out_d_safe_ridx_valid     (auto_asource_out_d_safe_ridx_valid),
    .auto_out_d_safe_sink_reset_n   (auto_asource_out_d_safe_sink_reset_n)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 dmactiveAck_dmactiveAckSync (	// ShiftReg.scala:45:23
    .clock (io_dmi_clock),
    .reset (io_dmi_reset),
    .io_d  (io_ctrl_dmactiveAck),
    .io_q  (_dmactiveAck_dmactiveAckSync_io_q)
  );
  AsyncQueueSource_1 io_innerCtrl_source (	// AsyncQueue.scala:216:24
    .clock                        (io_dmi_clock),
    .reset                        (io_dmi_reset),
    .io_enq_valid                 (_dmOuter_io_innerCtrl_valid),	// Debug.scala:649:27
    .io_enq_bits_resumereq        (_dmOuter_io_innerCtrl_bits_resumereq),	// Debug.scala:649:27
    .io_enq_bits_hartsel          (_dmOuter_io_innerCtrl_bits_hartsel),	// Debug.scala:649:27
    .io_enq_bits_ackhavereset     (_dmOuter_io_innerCtrl_bits_ackhavereset),	// Debug.scala:649:27
    .io_enq_bits_hasel            (_dmOuter_io_innerCtrl_bits_hasel),	// Debug.scala:649:27
    .io_enq_bits_hamask_0         (_dmOuter_io_innerCtrl_bits_hamask_0),	// Debug.scala:649:27
    .io_enq_bits_hamask_1         (_dmOuter_io_innerCtrl_bits_hamask_1),	// Debug.scala:649:27
    .io_enq_bits_hamask_2         (_dmOuter_io_innerCtrl_bits_hamask_2),	// Debug.scala:649:27
    .io_enq_bits_hamask_3         (_dmOuter_io_innerCtrl_bits_hamask_3),	// Debug.scala:649:27
    .io_enq_bits_hamask_4         (_dmOuter_io_innerCtrl_bits_hamask_4),	// Debug.scala:649:27
    .io_enq_bits_hamask_5         (_dmOuter_io_innerCtrl_bits_hamask_5),	// Debug.scala:649:27
    .io_enq_bits_hrmask_0         (_dmOuter_io_innerCtrl_bits_hrmask_0),	// Debug.scala:649:27
    .io_enq_bits_hrmask_1         (_dmOuter_io_innerCtrl_bits_hrmask_1),	// Debug.scala:649:27
    .io_enq_bits_hrmask_2         (_dmOuter_io_innerCtrl_bits_hrmask_2),	// Debug.scala:649:27
    .io_enq_bits_hrmask_3         (_dmOuter_io_innerCtrl_bits_hrmask_3),	// Debug.scala:649:27
    .io_enq_bits_hrmask_4         (_dmOuter_io_innerCtrl_bits_hrmask_4),	// Debug.scala:649:27
    .io_enq_bits_hrmask_5         (_dmOuter_io_innerCtrl_bits_hrmask_5),	// Debug.scala:649:27
    .io_async_ridx                (io_innerCtrl_ridx),
    .io_async_safe_ridx_valid     (io_innerCtrl_safe_ridx_valid),
    .io_async_safe_sink_reset_n   (io_innerCtrl_safe_sink_reset_n),
    .io_enq_ready                 (_io_innerCtrl_source_io_enq_ready),
    .io_async_mem_0_resumereq     (io_innerCtrl_mem_0_resumereq),
    .io_async_mem_0_hartsel       (io_innerCtrl_mem_0_hartsel),
    .io_async_mem_0_ackhavereset  (io_innerCtrl_mem_0_ackhavereset),
    .io_async_mem_0_hasel         (io_innerCtrl_mem_0_hasel),
    .io_async_mem_0_hamask_0      (io_innerCtrl_mem_0_hamask_0),
    .io_async_mem_0_hamask_1      (io_innerCtrl_mem_0_hamask_1),
    .io_async_mem_0_hamask_2      (io_innerCtrl_mem_0_hamask_2),
    .io_async_mem_0_hamask_3      (io_innerCtrl_mem_0_hamask_3),
    .io_async_mem_0_hamask_4      (io_innerCtrl_mem_0_hamask_4),
    .io_async_mem_0_hamask_5      (io_innerCtrl_mem_0_hamask_5),
    .io_async_mem_0_hrmask_0      (io_innerCtrl_mem_0_hrmask_0),
    .io_async_mem_0_hrmask_1      (io_innerCtrl_mem_0_hrmask_1),
    .io_async_mem_0_hrmask_2      (io_innerCtrl_mem_0_hrmask_2),
    .io_async_mem_0_hrmask_3      (io_innerCtrl_mem_0_hrmask_3),
    .io_async_mem_0_hrmask_4      (io_innerCtrl_mem_0_hrmask_4),
    .io_async_mem_0_hrmask_5      (io_innerCtrl_mem_0_hrmask_5),
    .io_async_widx                (io_innerCtrl_widx),
    .io_async_safe_widx_valid     (io_innerCtrl_safe_widx_valid),
    .io_async_safe_source_reset_n (io_innerCtrl_safe_source_reset_n)
  );
  assign io_ctrl_dmactive = _dmOuter_io_ctrl_dmactive;	// Debug.scala:649:27
endmodule

