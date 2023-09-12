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

module ClockSinkDomain_4(
  input         auto_resetCtrl_async_reset_sink_in_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_reset,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_implicit_clock_clock,
                auto_resetCtrl_tile_reset_provider_in_member_allClocks_implicit_clock_reset,
                auto_resetCtrl_in_a_valid,
  input  [2:0]  auto_resetCtrl_in_a_bits_opcode,
                auto_resetCtrl_in_a_bits_param,
  input  [1:0]  auto_resetCtrl_in_a_bits_size,
  input  [11:0] auto_resetCtrl_in_a_bits_source,
  input  [20:0] auto_resetCtrl_in_a_bits_address,
  input  [7:0]  auto_resetCtrl_in_a_bits_mask,
  input  [63:0] auto_resetCtrl_in_a_bits_data,
  input         auto_resetCtrl_in_a_bits_corrupt,
                auto_resetCtrl_in_d_ready,
                auto_clock_in_clock,
                auto_clock_in_reset,
  output        auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_reset,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_implicit_clock_clock,
                auto_resetCtrl_tile_reset_provider_out_member_allClocks_implicit_clock_reset,
                auto_resetCtrl_in_a_ready,
                auto_resetCtrl_in_d_valid,
  output [2:0]  auto_resetCtrl_in_d_bits_opcode,
  output [1:0]  auto_resetCtrl_in_d_bits_size,
  output [11:0] auto_resetCtrl_in_d_bits_source,
  output [63:0] auto_resetCtrl_in_d_bits_data
);

  TLTileResetCtrl resetCtrl (	// TileResetCtrl.scala:26:17
    .clock
      (auto_clock_in_clock),
    .reset
      (auto_clock_in_reset),
    .auto_async_reset_sink_in_reset
      (auto_resetCtrl_async_reset_sink_in_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_cbus_0_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_mbus_0_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_fbus_0_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_pbus_0_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_1_reset),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_clock),
    .auto_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_subsystem_sbus_0_reset),
    .auto_tile_reset_provider_in_member_allClocks_implicit_clock_clock
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_implicit_clock_clock),
    .auto_tile_reset_provider_in_member_allClocks_implicit_clock_reset
      (auto_resetCtrl_tile_reset_provider_in_member_allClocks_implicit_clock_reset),
    .auto_in_a_valid
      (auto_resetCtrl_in_a_valid),
    .auto_in_a_bits_opcode
      (auto_resetCtrl_in_a_bits_opcode),
    .auto_in_a_bits_param
      (auto_resetCtrl_in_a_bits_param),
    .auto_in_a_bits_size
      (auto_resetCtrl_in_a_bits_size),
    .auto_in_a_bits_source
      (auto_resetCtrl_in_a_bits_source),
    .auto_in_a_bits_address
      (auto_resetCtrl_in_a_bits_address),
    .auto_in_a_bits_mask
      (auto_resetCtrl_in_a_bits_mask),
    .auto_in_a_bits_data
      (auto_resetCtrl_in_a_bits_data),
    .auto_in_a_bits_corrupt
      (auto_resetCtrl_in_a_bits_corrupt),
    .auto_in_d_ready
      (auto_resetCtrl_in_d_ready),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_cbus_0_reset),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_mbus_0_reset),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_fbus_0_reset),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_pbus_0_reset),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_1_reset),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_clock),
    .auto_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_subsystem_sbus_0_reset),
    .auto_tile_reset_provider_out_member_allClocks_implicit_clock_clock
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_implicit_clock_clock),
    .auto_tile_reset_provider_out_member_allClocks_implicit_clock_reset
      (auto_resetCtrl_tile_reset_provider_out_member_allClocks_implicit_clock_reset),
    .auto_in_a_ready
      (auto_resetCtrl_in_a_ready),
    .auto_in_d_valid
      (auto_resetCtrl_in_d_valid),
    .auto_in_d_bits_opcode
      (auto_resetCtrl_in_d_bits_opcode),
    .auto_in_d_bits_size
      (auto_resetCtrl_in_d_bits_size),
    .auto_in_d_bits_source
      (auto_resetCtrl_in_d_bits_source),
    .auto_in_d_bits_data
      (auto_resetCtrl_in_d_bits_data)
  );
endmodule

