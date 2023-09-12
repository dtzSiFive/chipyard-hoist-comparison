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

module TLTileResetCtrl(
  input         clock,
                reset,
                auto_async_reset_sink_in_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_reset,
                auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_clock,
                auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_reset,
                auto_tile_reset_provider_in_member_allClocks_implicit_clock_clock,
                auto_tile_reset_provider_in_member_allClocks_implicit_clock_reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [11:0] auto_in_a_bits_source,
  input  [20:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
  output        auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_reset,
                auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_reset,
                auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_reset,
                auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_reset,
                auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_reset,
                auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_clock,
                auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_reset,
                auto_tile_reset_provider_out_member_allClocks_implicit_clock_clock,
                auto_tile_reset_provider_out_member_allClocks_implicit_clock_reset,
                auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_size,
  output [11:0] auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data
);

  wire             out_woready_1;	// RegisterRouter.scala:79:24
  wire             out_woready_3;	// RegisterRouter.scala:79:24
  wire             out_woready_5;	// RegisterRouter.scala:79:24
  wire             _r_tile_resets_5_io_q;	// TileResetCtrl.scala:44:15
  wire             _r_tile_resets_4_io_q;	// TileResetCtrl.scala:44:15
  wire             _r_tile_resets_3_io_q;	// TileResetCtrl.scala:44:15
  wire             _r_tile_resets_2_io_q;	// TileResetCtrl.scala:44:15
  wire             _r_tile_resets_1_io_q;	// TileResetCtrl.scala:44:15
  wire             _r_tile_resets_0_io_q;	// TileResetCtrl.scala:44:15
  wire             out_front_bits_read = auto_in_a_bits_opcode == 3'h4;	// RegisterRouter.scala:68:36
  wire             _out_out_bits_data_WIRE_2 = auto_in_a_bits_address[11:5] == 7'h0;	// Edges.scala:191:34, RegisterRouter.scala:69:19, :79:24
  wire             _out_wofireMux_T_2 =
    auto_in_a_valid & auto_in_d_ready & ~out_front_bits_read;	// RegisterRouter.scala:68:36, :79:24
  assign out_woready_5 =
    _out_wofireMux_T_2 & auto_in_a_bits_address[4:3] == 2'h0 & _out_out_bits_data_WIRE_2;	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_3 =
    _out_wofireMux_T_2 & auto_in_a_bits_address[4:3] == 2'h1 & _out_out_bits_data_WIRE_2;	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_1 =
    _out_wofireMux_T_2 & auto_in_a_bits_address[4:3] == 2'h2 & _out_out_bits_data_WIRE_2;	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire [3:0]       _GEN =
    {{1'h1},
     {_out_out_bits_data_WIRE_2},
     {_out_out_bits_data_WIRE_2},
     {_out_out_bits_data_WIRE_2}};	// MuxLiteral.scala:48:10, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire [3:0][32:0] _GEN_0 =
    {{33'h0},
     {{_r_tile_resets_5_io_q, 31'h0, _r_tile_resets_4_io_q}},
     {{_r_tile_resets_3_io_q, 31'h0, _r_tile_resets_2_io_q}},
     {{_r_tile_resets_1_io_q, 31'h0, _r_tile_resets_0_io_q}}};	// Cat.scala:30:58, MuxLiteral.scala:48:{10,48}, RegisterRouter.scala:79:24, TileResetCtrl.scala:44:15
  wire [2:0]       bundleIn_0_d_bits_opcode = {2'h0, out_front_bits_read};	// OneHot.scala:58:35, RegisterRouter.scala:68:36, :94:19
  TLMonitor_81 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_in_d_ready),
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (auto_in_a_valid),
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (auto_in_a_bits_size),
    .io_in_d_bits_source  (auto_in_a_bits_source)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_0 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[0]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_5 & auto_in_a_bits_mask[0]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_0_io_q)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_1 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[32]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_5 & auto_in_a_bits_mask[4]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_1_io_q)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_2 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[0]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_3 & auto_in_a_bits_mask[0]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_2_io_q)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_3 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[32]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_3 & auto_in_a_bits_mask[4]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_3_io_q)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_4 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[0]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_1 & auto_in_a_bits_mask[0]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_4_io_q)
  );
  AsyncResetRegVec_w1_i0_30 r_tile_resets_5 (	// TileResetCtrl.scala:44:15
    .clock (clock),
    .reset (auto_async_reset_sink_in_reset),
    .io_d  (auto_in_a_bits_data[32]),	// RegisterRouter.scala:79:24
    .io_en (out_woready_1 & auto_in_a_bits_mask[4]),	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
    .io_q  (_r_tile_resets_5_io_q)
  );
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_reset;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_reset;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_reset;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_reset;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_reset;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_clock =
    auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_clock;
  assign auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_reset =
    auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_reset;
  assign auto_tile_reset_provider_out_member_allClocks_implicit_clock_clock =
    auto_tile_reset_provider_in_member_allClocks_implicit_clock_clock;
  assign auto_tile_reset_provider_out_member_allClocks_implicit_clock_reset =
    auto_tile_reset_provider_in_member_allClocks_implicit_clock_reset;
  assign auto_in_a_ready = auto_in_d_ready;
  assign auto_in_d_valid = auto_in_a_valid;
  assign auto_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_in_d_bits_size = auto_in_a_bits_size;
  assign auto_in_d_bits_source = auto_in_a_bits_source;
  assign auto_in_d_bits_data =
    {31'h0,
     _GEN[auto_in_a_bits_address[4:3]] ? _GEN_0[auto_in_a_bits_address[4:3]] : 33'h0};	// Cat.scala:30:58, MuxLiteral.scala:48:{10,48}, RegisterRouter.scala:79:24
endmodule

