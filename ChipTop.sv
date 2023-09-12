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

module ChipTop(
  input         jtag_TCK,
                jtag_TMS,
                jtag_TDI,
                serial_tl_bits_in_valid,
  input  [3:0]  serial_tl_bits_in_bits,
  input         serial_tl_bits_out_ready,
                custom_boot,
                axi4_mem_0_bits_aw_ready,
                axi4_mem_0_bits_w_ready,
                axi4_mem_0_bits_b_valid,
  input  [3:0]  axi4_mem_0_bits_b_bits_id,
  input  [1:0]  axi4_mem_0_bits_b_bits_resp,
  input         axi4_mem_0_bits_ar_ready,
                axi4_mem_0_bits_r_valid,
  input  [3:0]  axi4_mem_0_bits_r_bits_id,
  input  [63:0] axi4_mem_0_bits_r_bits_data,
  input  [1:0]  axi4_mem_0_bits_r_bits_resp,
  input         axi4_mem_0_bits_r_bits_last,
                uart_0_rxd,
                reset_wire_reset,
                clock,
  output        jtag_TDO,
                serial_tl_clock,
                serial_tl_bits_in_ready,
                serial_tl_bits_out_valid,
  output [3:0]  serial_tl_bits_out_bits,
  output        axi4_mem_0_clock,
                axi4_mem_0_reset,
                axi4_mem_0_bits_aw_valid,
  output [3:0]  axi4_mem_0_bits_aw_bits_id,
  output [31:0] axi4_mem_0_bits_aw_bits_addr,
  output [7:0]  axi4_mem_0_bits_aw_bits_len,
  output [2:0]  axi4_mem_0_bits_aw_bits_size,
  output [1:0]  axi4_mem_0_bits_aw_bits_burst,
  output        axi4_mem_0_bits_aw_bits_lock,
  output [3:0]  axi4_mem_0_bits_aw_bits_cache,
  output [2:0]  axi4_mem_0_bits_aw_bits_prot,
  output [3:0]  axi4_mem_0_bits_aw_bits_qos,
  output        axi4_mem_0_bits_w_valid,
  output [63:0] axi4_mem_0_bits_w_bits_data,
  output [7:0]  axi4_mem_0_bits_w_bits_strb,
  output        axi4_mem_0_bits_w_bits_last,
                axi4_mem_0_bits_b_ready,
                axi4_mem_0_bits_ar_valid,
  output [3:0]  axi4_mem_0_bits_ar_bits_id,
  output [31:0] axi4_mem_0_bits_ar_bits_addr,
  output [7:0]  axi4_mem_0_bits_ar_bits_len,
  output [2:0]  axi4_mem_0_bits_ar_bits_size,
  output [1:0]  axi4_mem_0_bits_ar_bits_burst,
  output        axi4_mem_0_bits_ar_bits_lock,
  output [3:0]  axi4_mem_0_bits_ar_bits_cache,
  output [2:0]  axi4_mem_0_bits_ar_bits_prot,
  output [3:0]  axi4_mem_0_bits_ar_bits_qos,
  output        axi4_mem_0_bits_r_ready,
                uart_0_txd
);

  wire       _iocell_clock_i;	// IOCell.scala:111:23
  wire       _reset_wire_iocell_reset_i;	// IOCell.scala:111:23
  wire       _iocell_uart_0_rxd_i;	// IOCell.scala:111:23
  wire       _iocell_custom_boot_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_in_valid_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_in_bits_3_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_in_bits_2_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_in_bits_1_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_in_bits_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_out_ready_i;	// IOCell.scala:111:23
  wire       _iocell_serial_tl_bits_out_bits_3_pad;	// IOCell.scala:112:24
  wire       _iocell_serial_tl_bits_out_bits_2_pad;	// IOCell.scala:112:24
  wire       _iocell_serial_tl_bits_out_bits_1_pad;	// IOCell.scala:112:24
  wire       _iocell_serial_tl_bits_out_bits_pad;	// IOCell.scala:112:24
  wire       _iocell_jtag_TCK_i;	// IOCell.scala:111:23
  wire       _iocell_jtag_TMS_i;	// IOCell.scala:111:23
  wire       _iocell_jtag_TDI_i;	// IOCell.scala:111:23
  wire       _gated_clock_debug_clock_gate_out;	// ClockGate.scala:24:20
  wire       _dmactiveAck_dmactiveAck_io_q;	// ShiftReg.scala:45:23
  wire       _debug_reset_syncd_debug_reset_sync_io_q;	// ShiftReg.scala:45:23
  wire       _system_debug_systemjtag_reset_catcher_io_sync_reset;	// ResetCatchAndSync.scala:39:28
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_mbus_0_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_fbus_0_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_pbus_0_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_1_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_0_reset;	// ResetSynchronizer.scala:42:69
  wire       _dividerOnlyClockGenerator_3_auto_out_member_allClocks_implicit_clock_reset;	// ResetSynchronizer.scala:42:69
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_pbus_0_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_1_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_0_clock;	// Clocks.scala:90:45
  wire
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_implicit_clock_clock;	// Clocks.scala:90:45
  wire       _system_serial_tl_bits_in_ready;	// ChipTop.scala:32:35
  wire       _system_serial_tl_bits_out_valid;	// ChipTop.scala:32:35
  wire [3:0] _system_serial_tl_bits_out_bits;	// ChipTop.scala:32:35
  wire       _system_debug_systemjtag_jtag_TDO_data;	// ChipTop.scala:32:35
  wire       _system_debug_dmactive;	// ChipTop.scala:32:35
  wire       _system_uart_0_txd;	// ChipTop.scala:32:35
  wire       debug_reset = ~_debug_reset_syncd_debug_reset_sync_io_q;	// Periphery.scala:291:40, ShiftReg.scala:45:23
  reg        clock_en;	// Periphery.scala:299:29
  always @(posedge _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock
           or
           posedge debug_reset) begin	// Clocks.scala:90:45, Periphery.scala:291:40
    if (debug_reset)	// Clocks.scala:90:45, Periphery.scala:291:40
      clock_en <= 1'h1;	// Periphery.scala:299:29
    else	// Clocks.scala:90:45
      clock_en <= _dmactiveAck_dmactiveAck_io_q;	// Periphery.scala:299:29, ShiftReg.scala:45:23
  end // always @(posedge, posedge)
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
        clock_en = _RANDOM[/*Zero width*/ 1'b0][0];	// Periphery.scala:299:29
      `endif // RANDOMIZE_REG_INIT
      if (debug_reset)	// Periphery.scala:291:40
        clock_en = 1'h1;	// Periphery.scala:299:29
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  DigitalTop system (	// ChipTop.scala:32:35
    .clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_implicit_clock_clock),	// Clocks.scala:90:45
    .reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_implicit_clock_reset),	// ResetSynchronizer.scala:42:69
    .auto_domain_resetCtrl_async_reset_sink_in_reset
      (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock),	// Clocks.scala:90:45
    .auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_mbus_0_reset),	// ResetSynchronizer.scala:42:69
    .auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),	// Clocks.scala:90:45
    .auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock),	// Clocks.scala:90:45
    .auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_fbus_0_reset),	// ResetSynchronizer.scala:42:69
    .auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_pbus_0_clock),	// Clocks.scala:90:45
    .auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_pbus_0_reset),	// ResetSynchronizer.scala:42:69
    .auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_1_clock),	// Clocks.scala:90:45
    .auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_1_reset),	// ResetSynchronizer.scala:42:69
    .auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_0_clock),	// Clocks.scala:90:45
    .auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_0_reset),	// ResetSynchronizer.scala:42:69
    .mem_axi4_0_aw_ready
      (axi4_mem_0_bits_aw_ready),
    .mem_axi4_0_w_ready
      (axi4_mem_0_bits_w_ready),
    .mem_axi4_0_b_valid
      (axi4_mem_0_bits_b_valid),
    .mem_axi4_0_b_bits_id
      (axi4_mem_0_bits_b_bits_id),
    .mem_axi4_0_b_bits_resp
      (axi4_mem_0_bits_b_bits_resp),
    .mem_axi4_0_ar_ready
      (axi4_mem_0_bits_ar_ready),
    .mem_axi4_0_r_valid
      (axi4_mem_0_bits_r_valid),
    .mem_axi4_0_r_bits_id
      (axi4_mem_0_bits_r_bits_id),
    .mem_axi4_0_r_bits_data
      (axi4_mem_0_bits_r_bits_data),
    .mem_axi4_0_r_bits_resp
      (axi4_mem_0_bits_r_bits_resp),
    .mem_axi4_0_r_bits_last
      (axi4_mem_0_bits_r_bits_last),
    .custom_boot
      (_iocell_custom_boot_i),	// IOCell.scala:111:23
    .serial_tl_bits_in_valid
      (_iocell_serial_tl_bits_in_valid_i),	// IOCell.scala:111:23
    .serial_tl_bits_in_bits
      ({_iocell_serial_tl_bits_in_bits_3_i,
        _iocell_serial_tl_bits_in_bits_2_i,
        _iocell_serial_tl_bits_in_bits_1_i,
        _iocell_serial_tl_bits_in_bits_i}),	// Cat.scala:30:58, IOCell.scala:111:23
    .serial_tl_bits_out_ready
      (_iocell_serial_tl_bits_out_ready_i),	// IOCell.scala:111:23
    .resetctrl_hartIsInReset_0
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .resetctrl_hartIsInReset_1
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .resetctrl_hartIsInReset_2
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .resetctrl_hartIsInReset_3
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .resetctrl_hartIsInReset_4
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .resetctrl_hartIsInReset_5
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .debug_clock
      (_gated_clock_debug_clock_gate_out),	// ClockGate.scala:24:20
    .debug_reset
      (debug_reset),	// Periphery.scala:291:40
    .debug_systemjtag_jtag_TCK
      (_iocell_jtag_TCK_i),	// IOCell.scala:111:23
    .debug_systemjtag_jtag_TMS
      (_iocell_jtag_TMS_i),	// IOCell.scala:111:23
    .debug_systemjtag_jtag_TDI
      (_iocell_jtag_TDI_i),	// IOCell.scala:111:23
    .debug_systemjtag_reset
      (_system_debug_systemjtag_reset_catcher_io_sync_reset),	// ResetCatchAndSync.scala:39:28
    .debug_dmactiveAck
      (_dmactiveAck_dmactiveAck_io_q),	// ShiftReg.scala:45:23
    .uart_0_rxd
      (_iocell_uart_0_rxd_i),	// IOCell.scala:111:23
    .mem_axi4_0_aw_valid
      (axi4_mem_0_bits_aw_valid),
    .mem_axi4_0_aw_bits_id
      (axi4_mem_0_bits_aw_bits_id),
    .mem_axi4_0_aw_bits_addr
      (axi4_mem_0_bits_aw_bits_addr),
    .mem_axi4_0_aw_bits_len
      (axi4_mem_0_bits_aw_bits_len),
    .mem_axi4_0_aw_bits_size
      (axi4_mem_0_bits_aw_bits_size),
    .mem_axi4_0_aw_bits_burst
      (axi4_mem_0_bits_aw_bits_burst),
    .mem_axi4_0_aw_bits_lock
      (axi4_mem_0_bits_aw_bits_lock),
    .mem_axi4_0_aw_bits_cache
      (axi4_mem_0_bits_aw_bits_cache),
    .mem_axi4_0_aw_bits_prot
      (axi4_mem_0_bits_aw_bits_prot),
    .mem_axi4_0_aw_bits_qos
      (axi4_mem_0_bits_aw_bits_qos),
    .mem_axi4_0_w_valid
      (axi4_mem_0_bits_w_valid),
    .mem_axi4_0_w_bits_data
      (axi4_mem_0_bits_w_bits_data),
    .mem_axi4_0_w_bits_strb
      (axi4_mem_0_bits_w_bits_strb),
    .mem_axi4_0_w_bits_last
      (axi4_mem_0_bits_w_bits_last),
    .mem_axi4_0_b_ready
      (axi4_mem_0_bits_b_ready),
    .mem_axi4_0_ar_valid
      (axi4_mem_0_bits_ar_valid),
    .mem_axi4_0_ar_bits_id
      (axi4_mem_0_bits_ar_bits_id),
    .mem_axi4_0_ar_bits_addr
      (axi4_mem_0_bits_ar_bits_addr),
    .mem_axi4_0_ar_bits_len
      (axi4_mem_0_bits_ar_bits_len),
    .mem_axi4_0_ar_bits_size
      (axi4_mem_0_bits_ar_bits_size),
    .mem_axi4_0_ar_bits_burst
      (axi4_mem_0_bits_ar_bits_burst),
    .mem_axi4_0_ar_bits_lock
      (axi4_mem_0_bits_ar_bits_lock),
    .mem_axi4_0_ar_bits_cache
      (axi4_mem_0_bits_ar_bits_cache),
    .mem_axi4_0_ar_bits_prot
      (axi4_mem_0_bits_ar_bits_prot),
    .mem_axi4_0_ar_bits_qos
      (axi4_mem_0_bits_ar_bits_qos),
    .mem_axi4_0_r_ready
      (axi4_mem_0_bits_r_ready),
    .serial_tl_bits_in_ready
      (_system_serial_tl_bits_in_ready),
    .serial_tl_bits_out_valid
      (_system_serial_tl_bits_out_valid),
    .serial_tl_bits_out_bits
      (_system_serial_tl_bits_out_bits),
    .debug_systemjtag_jtag_TDO_data
      (_system_debug_systemjtag_jtag_TDO_data),
    .debug_dmactive
      (_system_debug_dmactive),
    .uart_0_txd
      (_system_uart_0_txd)
  );
  DividerOnlyClockGenerator dividerOnlyClkGenerator (	// Clocks.scala:90:45
    .auto_divider_only_clk_generator_in_clock
      (_iocell_clock_i),	// IOCell.scala:111:23
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_pbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_pbus_0_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_1_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_1_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_0_clock),
    .auto_divider_only_clk_generator_out_member_allClocks_implicit_clock_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_implicit_clock_clock)
  );
  ClockGroupResetSynchronizer dividerOnlyClockGenerator_3 (	// ResetSynchronizer.scala:42:69
    .auto_in_member_allClocks_subsystem_cbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_cbus_0_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_subsystem_mbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_mbus_0_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_subsystem_fbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_fbus_0_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_subsystem_pbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_pbus_0_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_pbus_0_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_subsystem_sbus_1_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_1_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_sbus_1_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_subsystem_sbus_0_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_sbus_0_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_subsystem_sbus_0_reset  (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_in_member_allClocks_implicit_clock_clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_implicit_clock_clock),	// Clocks.scala:90:45
    .auto_in_member_allClocks_implicit_clock_reset    (_reset_wire_iocell_reset_i),	// IOCell.scala:111:23
    .auto_out_member_allClocks_subsystem_cbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),
    .auto_out_member_allClocks_subsystem_mbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_mbus_0_reset),
    .auto_out_member_allClocks_subsystem_fbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_fbus_0_reset),
    .auto_out_member_allClocks_subsystem_pbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_pbus_0_reset),
    .auto_out_member_allClocks_subsystem_sbus_1_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_1_reset),
    .auto_out_member_allClocks_subsystem_sbus_0_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_sbus_0_reset),
    .auto_out_member_allClocks_implicit_clock_reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_implicit_clock_reset)
  );
  ResetCatchAndSync_d3 system_debug_systemjtag_reset_catcher (	// ResetCatchAndSync.scala:39:28
    .clock         (_iocell_jtag_TCK_i),	// IOCell.scala:111:23
    .reset
      (_dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_cbus_0_reset),	// ResetSynchronizer.scala:42:69
    .io_sync_reset (_system_debug_systemjtag_reset_catcher_io_sync_reset)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 debug_reset_syncd_debug_reset_sync (	// ShiftReg.scala:45:23
    .clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),	// Clocks.scala:90:45
    .reset (_system_debug_systemjtag_reset_catcher_io_sync_reset),	// ResetCatchAndSync.scala:39:28
    .io_d  (1'h1),
    .io_q  (_debug_reset_syncd_debug_reset_sync_io_q)
  );
  ResetSynchronizerShiftReg_w1_d3_i0 dmactiveAck_dmactiveAck (	// ShiftReg.scala:45:23
    .clock
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),	// Clocks.scala:90:45
    .reset (debug_reset),	// Periphery.scala:291:40
    .io_d  (_system_debug_dmactive),	// ChipTop.scala:32:35
    .io_q  (_dmactiveAck_dmactiveAck_io_q)
  );
  EICG_wrapper gated_clock_debug_clock_gate (	// ClockGate.scala:24:20
    .in
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_cbus_0_clock),	// Clocks.scala:90:45
    .test_en (1'h0),
    .en      (clock_en),	// Periphery.scala:299:29
    .out     (_gated_clock_debug_clock_gate_out)
  );
  GenericDigitalOutIOCell iocell_jtag_TDO (	// IOCell.scala:112:24
    .o   (_system_debug_systemjtag_jtag_TDO_data),	// ChipTop.scala:32:35
    .oe  (1'h1),
    .pad (jtag_TDO)
  );
  GenericDigitalInIOCell iocell_jtag_TDI (	// IOCell.scala:111:23
    .pad (jtag_TDI),
    .ie  (1'h1),
    .i   (_iocell_jtag_TDI_i)
  );
  GenericDigitalInIOCell iocell_jtag_TMS (	// IOCell.scala:111:23
    .pad (jtag_TMS),
    .ie  (1'h1),
    .i   (_iocell_jtag_TMS_i)
  );
  GenericDigitalInIOCell iocell_jtag_TCK (	// IOCell.scala:111:23
    .pad (jtag_TCK),
    .ie  (1'h1),
    .i   (_iocell_jtag_TCK_i)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_out_bits[0]),	// ChipTop.scala:32:35, IOCell.scala:228:40
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_1 (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_out_bits[1]),	// ChipTop.scala:32:35, IOCell.scala:228:40
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_1_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_2 (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_out_bits[2]),	// ChipTop.scala:32:35, IOCell.scala:228:40
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_2_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_bits_3 (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_out_bits[3]),	// ChipTop.scala:32:35, IOCell.scala:228:40
    .oe  (1'h1),
    .pad (_iocell_serial_tl_bits_out_bits_3_pad)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_out_valid (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_out_valid),	// ChipTop.scala:32:35
    .oe  (1'h1),
    .pad (serial_tl_bits_out_valid)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_out_ready (	// IOCell.scala:111:23
    .pad (serial_tl_bits_out_ready),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_out_ready_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits (	// IOCell.scala:111:23
    .pad (serial_tl_bits_in_bits[0]),	// IOCell.scala:213:39
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_1 (	// IOCell.scala:111:23
    .pad (serial_tl_bits_in_bits[1]),	// IOCell.scala:213:39
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_1_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_2 (	// IOCell.scala:111:23
    .pad (serial_tl_bits_in_bits[2]),	// IOCell.scala:213:39
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_2_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_bits_3 (	// IOCell.scala:111:23
    .pad (serial_tl_bits_in_bits[3]),	// IOCell.scala:213:39
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_bits_3_i)
  );
  GenericDigitalInIOCell iocell_serial_tl_bits_in_valid (	// IOCell.scala:111:23
    .pad (serial_tl_bits_in_valid),
    .ie  (1'h1),
    .i   (_iocell_serial_tl_bits_in_valid_i)
  );
  GenericDigitalOutIOCell iocell_serial_tl_bits_in_ready (	// IOCell.scala:112:24
    .o   (_system_serial_tl_bits_in_ready),	// ChipTop.scala:32:35
    .oe  (1'h1),
    .pad (serial_tl_bits_in_ready)
  );
  GenericDigitalOutIOCell iocell_serial_tl_clock (	// IOCell.scala:112:24
    .o
      (_dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_fbus_0_clock),	// Clocks.scala:90:45
    .oe  (1'h1),
    .pad (serial_tl_clock)
  );
  GenericDigitalInIOCell iocell_custom_boot (	// IOCell.scala:111:23
    .pad (custom_boot),
    .ie  (1'h1),
    .i   (_iocell_custom_boot_i)
  );
  GenericDigitalInIOCell iocell_uart_0_rxd (	// IOCell.scala:111:23
    .pad (uart_0_rxd),
    .ie  (1'h1),
    .i   (_iocell_uart_0_rxd_i)
  );
  GenericDigitalOutIOCell iocell_uart_0_txd (	// IOCell.scala:112:24
    .o   (_system_uart_0_txd),	// ChipTop.scala:32:35
    .oe  (1'h1),
    .pad (uart_0_txd)
  );
  GenericDigitalInIOCell reset_wire_iocell_reset (	// IOCell.scala:111:23
    .pad (reset_wire_reset),
    .ie  (1'h1),
    .i   (_reset_wire_iocell_reset_i)
  );
  GenericDigitalInIOCell iocell_clock (	// IOCell.scala:111:23
    .pad (clock),
    .ie  (1'h1),
    .i   (_iocell_clock_i)
  );
  assign serial_tl_bits_out_bits =
    {_iocell_serial_tl_bits_out_bits_3_pad,
     _iocell_serial_tl_bits_out_bits_2_pad,
     _iocell_serial_tl_bits_out_bits_1_pad,
     _iocell_serial_tl_bits_out_bits_pad};	// Cat.scala:30:58, IOCell.scala:112:24
  assign axi4_mem_0_clock =
    _dividerOnlyClkGenerator_auto_divider_only_clk_generator_out_member_allClocks_subsystem_mbus_0_clock;	// Clocks.scala:90:45
  assign axi4_mem_0_reset =
    _dividerOnlyClockGenerator_3_auto_out_member_allClocks_subsystem_mbus_0_reset;	// ResetSynchronizer.scala:42:69
endmodule

