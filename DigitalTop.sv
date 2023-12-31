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

module DigitalTop(
  input         clock,
                reset,
                auto_domain_resetCtrl_async_reset_sink_in_reset,
                auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock,
                auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset,
                auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock,
                auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset,
                auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock,
                auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset,
                auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock,
                auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset,
                auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_clock,
                auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_reset,
                auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock,
                auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset,
                mem_axi4_0_aw_ready,
                mem_axi4_0_w_ready,
                mem_axi4_0_b_valid,
  input  [3:0]  mem_axi4_0_b_bits_id,
  input  [1:0]  mem_axi4_0_b_bits_resp,
  input         mem_axi4_0_ar_ready,
                mem_axi4_0_r_valid,
  input  [3:0]  mem_axi4_0_r_bits_id,
  input  [63:0] mem_axi4_0_r_bits_data,
  input  [1:0]  mem_axi4_0_r_bits_resp,
  input         mem_axi4_0_r_bits_last,
                custom_boot,
                serial_tl_bits_in_valid,
  input  [3:0]  serial_tl_bits_in_bits,
  input         serial_tl_bits_out_ready,
                resetctrl_hartIsInReset_0,
                resetctrl_hartIsInReset_1,
                resetctrl_hartIsInReset_2,
                resetctrl_hartIsInReset_3,
                resetctrl_hartIsInReset_4,
                resetctrl_hartIsInReset_5,
                debug_clock,
                debug_reset,
                debug_systemjtag_jtag_TCK,
                debug_systemjtag_jtag_TMS,
                debug_systemjtag_jtag_TDI,
                debug_systemjtag_reset,
                debug_dmactiveAck,
                uart_0_rxd,
  output        mem_axi4_0_aw_valid,
  output [3:0]  mem_axi4_0_aw_bits_id,
  output [31:0] mem_axi4_0_aw_bits_addr,
  output [7:0]  mem_axi4_0_aw_bits_len,
  output [2:0]  mem_axi4_0_aw_bits_size,
  output [1:0]  mem_axi4_0_aw_bits_burst,
  output        mem_axi4_0_aw_bits_lock,
  output [3:0]  mem_axi4_0_aw_bits_cache,
  output [2:0]  mem_axi4_0_aw_bits_prot,
  output [3:0]  mem_axi4_0_aw_bits_qos,
  output        mem_axi4_0_w_valid,
  output [63:0] mem_axi4_0_w_bits_data,
  output [7:0]  mem_axi4_0_w_bits_strb,
  output        mem_axi4_0_w_bits_last,
                mem_axi4_0_b_ready,
                mem_axi4_0_ar_valid,
  output [3:0]  mem_axi4_0_ar_bits_id,
  output [31:0] mem_axi4_0_ar_bits_addr,
  output [7:0]  mem_axi4_0_ar_bits_len,
  output [2:0]  mem_axi4_0_ar_bits_size,
  output [1:0]  mem_axi4_0_ar_bits_burst,
  output        mem_axi4_0_ar_bits_lock,
  output [3:0]  mem_axi4_0_ar_bits_cache,
  output [2:0]  mem_axi4_0_ar_bits_prot,
  output [3:0]  mem_axi4_0_ar_bits_qos,
  output        mem_axi4_0_r_ready,
                serial_tl_bits_in_ready,
                serial_tl_bits_out_valid,
  output [3:0]  serial_tl_bits_out_bits,
  output        debug_systemjtag_jtag_TDO_data,
                debug_dmactive,
                uart_0_txd
);

  wire        _dtm_io_dmi_req_valid;	// Periphery.scala:161:21
  wire [6:0]  _dtm_io_dmi_req_bits_addr;	// Periphery.scala:161:21
  wire [31:0] _dtm_io_dmi_req_bits_data;	// Periphery.scala:161:21
  wire [1:0]  _dtm_io_dmi_req_bits_op;	// Periphery.scala:161:21
  wire        _dtm_io_dmi_resp_ready;	// Periphery.scala:161:21
  wire [2:0]  _domain_1_auto_resetCtrl_in_d_bits_opcode;	// TileResetCtrl.scala:23:34
  wire [63:0] _domain_1_auto_resetCtrl_in_d_bits_data;	// TileResetCtrl.scala:23:34
  wire        _uartClockDomainWrapper_auto_uart_0_int_xing_out_sync_0;	// UART.scala:242:44
  wire [2:0]  _uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_opcode;	// UART.scala:242:44
  wire [63:0] _uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_data;	// UART.scala:242:44
  wire        _domain_auto_serdesser_client_out_a_valid;	// SerialAdapter.scala:373:28
  wire [2:0]  _domain_auto_serdesser_client_out_a_bits_opcode;	// SerialAdapter.scala:373:28
  wire [2:0]  _domain_auto_serdesser_client_out_a_bits_param;	// SerialAdapter.scala:373:28
  wire [3:0]  _domain_auto_serdesser_client_out_a_bits_size;	// SerialAdapter.scala:373:28
  wire        _domain_auto_serdesser_client_out_a_bits_source;	// SerialAdapter.scala:373:28
  wire [31:0] _domain_auto_serdesser_client_out_a_bits_address;	// SerialAdapter.scala:373:28
  wire [7:0]  _domain_auto_serdesser_client_out_a_bits_mask;	// SerialAdapter.scala:373:28
  wire [63:0] _domain_auto_serdesser_client_out_a_bits_data;	// SerialAdapter.scala:373:28
  wire        _domain_auto_serdesser_client_out_a_bits_corrupt;	// SerialAdapter.scala:373:28
  wire        _domain_auto_serdesser_client_out_d_ready;	// SerialAdapter.scala:373:28
  wire        _domain_auto_tlserial_manager_crossing_in_a_ready;	// SerialAdapter.scala:373:28
  wire        _domain_auto_tlserial_manager_crossing_in_d_valid;	// SerialAdapter.scala:373:28
  wire [2:0]  _domain_auto_tlserial_manager_crossing_in_d_bits_opcode;	// SerialAdapter.scala:373:28
  wire [1:0]  _domain_auto_tlserial_manager_crossing_in_d_bits_param;	// SerialAdapter.scala:373:28
  wire [2:0]  _domain_auto_tlserial_manager_crossing_in_d_bits_size;	// SerialAdapter.scala:373:28
  wire [3:0]  _domain_auto_tlserial_manager_crossing_in_d_bits_source;	// SerialAdapter.scala:373:28
  wire        _domain_auto_tlserial_manager_crossing_in_d_bits_sink;	// SerialAdapter.scala:373:28
  wire        _domain_auto_tlserial_manager_crossing_in_d_bits_denied;	// SerialAdapter.scala:373:28
  wire [63:0] _domain_auto_tlserial_manager_crossing_in_d_bits_data;	// SerialAdapter.scala:373:28
  wire        _domain_auto_tlserial_manager_crossing_in_d_bits_corrupt;	// SerialAdapter.scala:373:28
  wire [63:0] _bootROMDomainWrapper_auto_bootrom_in_d_bits_data;	// BootROM.scala:70:42
  wire        _intsource_16_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_15_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_14_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_14_auto_out_sync_1;	// Crossing.scala:26:31
  wire        _intsource_13_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_12_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_11_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_11_auto_out_sync_1;	// Crossing.scala:26:31
  wire        _intsource_10_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_9_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_8_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_8_auto_out_sync_1;	// Crossing.scala:26:31
  wire        _intsource_7_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_6_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_6_auto_out_sync_1;	// Crossing.scala:26:31
  wire        _intsource_5_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_4_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_3_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_3_auto_out_sync_1;	// Crossing.scala:26:31
  wire        _intsource_2_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_1_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_auto_out_sync_0;	// Crossing.scala:26:31
  wire        _intsource_auto_out_sync_1;	// Crossing.scala:26:31
  wire [2:0]  _debug_1_auto_dmInner_dmInner_tl_in_d_bits_opcode;	// Periphery.scala:84:27
  wire [63:0] _debug_1_auto_dmInner_dmInner_tl_in_d_bits_data;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_5_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_4_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_3_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_2_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_1_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_auto_dmOuter_intsource_out_0_sync_0;	// Periphery.scala:84:27
  wire        _debug_1_io_dmi_dmi_req_ready;	// Periphery.scala:84:27
  wire        _debug_1_io_dmi_dmi_resp_valid;	// Periphery.scala:84:27
  wire [31:0] _debug_1_io_dmi_dmi_resp_bits_data;	// Periphery.scala:84:27
  wire [1:0]  _debug_1_io_dmi_dmi_resp_bits_resp;	// Periphery.scala:84:27
  wire        _clint_auto_int_out_5_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_5_1;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_4_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_4_1;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_3_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_3_1;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_2_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_2_1;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_1_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_1_1;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_0_0;	// CLINT.scala:109:27
  wire        _clint_auto_int_out_0_1;	// CLINT.scala:109:27
  wire [2:0]  _clint_auto_in_d_bits_opcode;	// CLINT.scala:109:27
  wire [63:0] _clint_auto_in_d_bits_data;	// CLINT.scala:109:27
  wire        _plicDomainWrapper_auto_plic_int_out_10_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_9_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_8_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_7_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_6_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_5_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_4_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_3_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_2_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_1_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_int_out_0_0;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_in_a_ready;	// Plic.scala:359:39
  wire        _plicDomainWrapper_auto_plic_in_d_valid;	// Plic.scala:359:39
  wire [2:0]  _plicDomainWrapper_auto_plic_in_d_bits_opcode;	// Plic.scala:359:39
  wire [1:0]  _plicDomainWrapper_auto_plic_in_d_bits_size;	// Plic.scala:359:39
  wire [11:0] _plicDomainWrapper_auto_plic_in_d_bits_source;	// Plic.scala:359:39
  wire [63:0] _plicDomainWrapper_auto_plic_in_d_bits_data;	// Plic.scala:359:39
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_5_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_5_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_4_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_4_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [4:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [4:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_3_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_3_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_2_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_2_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_1_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_1_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_a_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_address;	// HasTiles.scala:252:38
  wire [7:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_mask;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_b_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_c_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_opcode;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_param;	// HasTiles.scala:252:38
  wire [3:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_size;	// HasTiles.scala:252:38
  wire [1:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_source;	// HasTiles.scala:252:38
  wire [31:0] _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_address;	// HasTiles.scala:252:38
  wire [63:0] _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_data;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_corrupt;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_d_ready;	// HasTiles.scala:252:38
  wire        _tile_prci_domain_auto_tl_master_clock_xing_out_e_valid;	// HasTiles.scala:252:38
  wire [2:0]  _tile_prci_domain_auto_tl_master_clock_xing_out_e_bits_sink;	// HasTiles.scala:252:38
  wire
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid;	// BankedL2Params.scala:47:31
  wire [2:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode;	// BankedL2Params.scala:47:31
  wire [2:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param;	// BankedL2Params.scala:47:31
  wire [2:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size;	// BankedL2Params.scala:47:31
  wire [3:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source;	// BankedL2Params.scala:47:31
  wire [31:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address;	// BankedL2Params.scala:47:31
  wire [7:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask;	// BankedL2Params.scala:47:31
  wire [63:0]
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data;	// BankedL2Params.scala:47:31
  wire
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt;	// BankedL2Params.scala:47:31
  wire
    _subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_a_ready;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_b_valid;	// BankedL2Params.scala:47:31
  wire [1:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param;	// BankedL2Params.scala:47:31
  wire [6:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_source;	// BankedL2Params.scala:47:31
  wire [31:0] _subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_c_ready;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_d_valid;	// BankedL2Params.scala:47:31
  wire [2:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_opcode;	// BankedL2Params.scala:47:31
  wire [1:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_param;	// BankedL2Params.scala:47:31
  wire [2:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_size;	// BankedL2Params.scala:47:31
  wire [6:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_source;	// BankedL2Params.scala:47:31
  wire [2:0]  _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_sink;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_denied;	// BankedL2Params.scala:47:31
  wire [63:0] _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_data;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_corrupt;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_l2_ctl_in_a_ready;	// BankedL2Params.scala:47:31
  wire        _subsystem_l2_wrapper_auto_l2_ctl_in_d_valid;	// BankedL2Params.scala:47:31
  wire [2:0]  _subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_opcode;	// BankedL2Params.scala:47:31
  wire [1:0]  _subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_size;	// BankedL2Params.scala:47:31
  wire [11:0] _subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_source;	// BankedL2Params.scala:47:31
  wire [63:0] _subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_data;	// BankedL2Params.scala:47:31
  wire
    _subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_valid;	// MemoryBus.scala:25:26
  wire [28:0]
    _subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_bits_address;	// MemoryBus.scala:25:26
  wire
    _subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_ready;	// MemoryBus.scala:25:26
  wire        _subsystem_mbus_auto_bus_xing_in_a_ready;	// MemoryBus.scala:25:26
  wire        _subsystem_mbus_auto_bus_xing_in_d_valid;	// MemoryBus.scala:25:26
  wire [2:0]  _subsystem_mbus_auto_bus_xing_in_d_bits_opcode;	// MemoryBus.scala:25:26
  wire [1:0]  _subsystem_mbus_auto_bus_xing_in_d_bits_param;	// MemoryBus.scala:25:26
  wire [2:0]  _subsystem_mbus_auto_bus_xing_in_d_bits_size;	// MemoryBus.scala:25:26
  wire [3:0]  _subsystem_mbus_auto_bus_xing_in_d_bits_source;	// MemoryBus.scala:25:26
  wire        _subsystem_mbus_auto_bus_xing_in_d_bits_sink;	// MemoryBus.scala:25:26
  wire        _subsystem_mbus_auto_bus_xing_in_d_bits_denied;	// MemoryBus.scala:25:26
  wire [63:0] _subsystem_mbus_auto_bus_xing_in_d_bits_data;	// MemoryBus.scala:25:26
  wire        _subsystem_mbus_auto_bus_xing_in_d_bits_corrupt;	// MemoryBus.scala:25:26
  wire        _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [16:0] _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_debug_fragmenter_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [25:0] _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_clint_fragmenter_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [27:0] _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_plic_fragmenter_out_d_ready;	// PeripheryBus.scala:31:26
  wire
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [7:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [30:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0]
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire
    _subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0] _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [25:0] _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_bus_xing_in_a_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_bus_xing_in_d_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_cbus_auto_bus_xing_in_d_bits_opcode;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_cbus_auto_bus_xing_in_d_bits_param;	// PeripheryBus.scala:31:26
  wire [3:0]  _subsystem_cbus_auto_bus_xing_in_d_bits_size;	// PeripheryBus.scala:31:26
  wire [6:0]  _subsystem_cbus_auto_bus_xing_in_d_bits_source;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_bus_xing_in_d_bits_sink;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_bus_xing_in_d_bits_denied;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_cbus_auto_bus_xing_in_d_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_cbus_auto_bus_xing_in_d_bits_corrupt;	// PeripheryBus.scala:31:26
  wire
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready;	// FrontBus.scala:22:26
  wire
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid;	// FrontBus.scala:22:26
  wire [2:0]
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode;	// FrontBus.scala:22:26
  wire [1:0]
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param;	// FrontBus.scala:22:26
  wire [3:0]
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size;	// FrontBus.scala:22:26
  wire
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source;	// FrontBus.scala:22:26
  wire [2:0]
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink;	// FrontBus.scala:22:26
  wire
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied;	// FrontBus.scala:22:26
  wire [63:0]
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data;	// FrontBus.scala:22:26
  wire
    _subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt;	// FrontBus.scala:22:26
  wire        _subsystem_fbus_auto_bus_xing_out_a_valid;	// FrontBus.scala:22:26
  wire [2:0]  _subsystem_fbus_auto_bus_xing_out_a_bits_opcode;	// FrontBus.scala:22:26
  wire [2:0]  _subsystem_fbus_auto_bus_xing_out_a_bits_param;	// FrontBus.scala:22:26
  wire [3:0]  _subsystem_fbus_auto_bus_xing_out_a_bits_size;	// FrontBus.scala:22:26
  wire        _subsystem_fbus_auto_bus_xing_out_a_bits_source;	// FrontBus.scala:22:26
  wire [31:0] _subsystem_fbus_auto_bus_xing_out_a_bits_address;	// FrontBus.scala:22:26
  wire [7:0]  _subsystem_fbus_auto_bus_xing_out_a_bits_mask;	// FrontBus.scala:22:26
  wire [63:0] _subsystem_fbus_auto_bus_xing_out_a_bits_data;	// FrontBus.scala:22:26
  wire        _subsystem_fbus_auto_bus_xing_out_a_bits_corrupt;	// FrontBus.scala:22:26
  wire        _subsystem_fbus_auto_bus_xing_out_d_ready;	// FrontBus.scala:22:26
  wire
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [20:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0]
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire
    _subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready;	// PeripheryBus.scala:31:26
  wire
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_valid;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode;	// PeripheryBus.scala:31:26
  wire [2:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param;	// PeripheryBus.scala:31:26
  wire [1:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size;	// PeripheryBus.scala:31:26
  wire [11:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source;	// PeripheryBus.scala:31:26
  wire [30:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address;	// PeripheryBus.scala:31:26
  wire [7:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask;	// PeripheryBus.scala:31:26
  wire [63:0]
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data;	// PeripheryBus.scala:31:26
  wire
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt;	// PeripheryBus.scala:31:26
  wire
    _subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_d_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_pbus_auto_bus_xing_in_a_ready;	// PeripheryBus.scala:31:26
  wire        _subsystem_pbus_auto_bus_xing_in_d_valid;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_pbus_auto_bus_xing_in_d_bits_opcode;	// PeripheryBus.scala:31:26
  wire [1:0]  _subsystem_pbus_auto_bus_xing_in_d_bits_param;	// PeripheryBus.scala:31:26
  wire [2:0]  _subsystem_pbus_auto_bus_xing_in_d_bits_size;	// PeripheryBus.scala:31:26
  wire [7:0]  _subsystem_pbus_auto_bus_xing_in_d_bits_source;	// PeripheryBus.scala:31:26
  wire        _subsystem_pbus_auto_bus_xing_in_d_bits_sink;	// PeripheryBus.scala:31:26
  wire        _subsystem_pbus_auto_bus_xing_in_d_bits_denied;	// PeripheryBus.scala:31:26
  wire [63:0] _subsystem_pbus_auto_bus_xing_in_d_bits_data;	// PeripheryBus.scala:31:26
  wire        _subsystem_pbus_auto_bus_xing_in_d_bits_corrupt;	// PeripheryBus.scala:31:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid;	// SystemBus.scala:24:26
  wire [4:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size;	// SystemBus.scala:24:26
  wire [4:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size;	// SystemBus.scala:24:26
  wire [6:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source;	// SystemBus.scala:24:26
  wire [31:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address;	// SystemBus.scala:24:26
  wire [7:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size;	// SystemBus.scala:24:26
  wire [6:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source;	// SystemBus.scala:24:26
  wire [31:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready;	// SystemBus.scala:24:26
  wire        _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode;	// SystemBus.scala:24:26
  wire [1:0]
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode;	// SystemBus.scala:24:26
  wire [2:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param;	// SystemBus.scala:24:26
  wire [3:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size;	// SystemBus.scala:24:26
  wire [6:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source;	// SystemBus.scala:24:26
  wire [30:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address;	// SystemBus.scala:24:26
  wire [7:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask;	// SystemBus.scala:24:26
  wire [63:0]
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt;	// SystemBus.scala:24:26
  wire
    _subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready;	// SystemBus.scala:24:26
  reg  [6:0]  int_rtc_tick_value;	// Counter.scala:60:40
  wire        int_rtc_tick = int_rtc_tick_value == 7'h63;	// Counter.scala:60:40, :72:24
  always @(posedge auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock) begin
    if (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset)
      int_rtc_tick_value <= 7'h0;	// Counter.scala:60:40
    else if (int_rtc_tick)	// Counter.scala:72:24
      int_rtc_tick_value <= 7'h0;	// Counter.scala:60:40
    else	// Counter.scala:72:24
      int_rtc_tick_value <= int_rtc_tick_value + 7'h1;	// Counter.scala:60:40, :76:24
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
        int_rtc_tick_value = _RANDOM[/*Zero width*/ 1'b0][6:0];	// Counter.scala:60:40
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  SystemBus subsystem_sbus (	// SystemBus.scala:24:26
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_opcode
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_param
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_size
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_source
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_address
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_mask
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_data
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_corrupt
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_ready
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_opcode
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_param
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_size
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_source
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_address
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_data
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_corrupt
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_ready
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_bits_sink
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_opcode
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_param
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_size
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_source
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_address
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_mask
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_data
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_corrupt
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_ready
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_opcode
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_param
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_size
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_source
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_address
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_data
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_corrupt
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_ready
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_bits_sink
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_opcode
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_param
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_size
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_source
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_address
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_mask
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_data
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_corrupt
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_ready
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_opcode
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_param
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_size
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_source
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_address
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_data
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_corrupt
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_ready
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_bits_sink
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_opcode
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_param
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_size
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_source
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_address
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_mask
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_data
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_corrupt
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_b_ready
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_opcode
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_param
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_size
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_source
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_address
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_data
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_corrupt
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_ready
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_e_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_e_bits_sink
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_opcode
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_param
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_size
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_source
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_address
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_mask
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_data
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_corrupt
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_b_ready
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_opcode
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_param
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_size
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_source
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_address
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_data
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_corrupt
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_ready
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_e_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_e_bits_sink
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_opcode
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_param
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_size
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_source
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_address
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_mask
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_mask),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_data
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_corrupt
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_b_ready
      (_tile_prci_domain_auto_tl_master_clock_xing_out_b_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_opcode
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_opcode),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_param
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_param),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_size
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_size),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_source
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_source),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_address
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_address),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_data
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_data),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_corrupt
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_corrupt),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_ready
      (_tile_prci_domain_auto_tl_master_clock_xing_out_d_ready),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_e_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_e_valid),	// HasTiles.scala:252:38
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_e_bits_sink
      (_tile_prci_domain_auto_tl_master_clock_xing_out_e_bits_sink),	// HasTiles.scala:252:38
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_ready
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_a_ready),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_b_valid
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_valid),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_source
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_source),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_ready
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_c_ready),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_valid
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_valid),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_opcode
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_opcode),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_param),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_size
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_size),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_source
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_source),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_sink
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_sink),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_denied
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_denied),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_data
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_data),	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_corrupt
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_corrupt),	// BankedL2Params.scala:47:31
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid
      (_subsystem_fbus_auto_bus_xing_out_a_valid),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode
      (_subsystem_fbus_auto_bus_xing_out_a_bits_opcode),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param
      (_subsystem_fbus_auto_bus_xing_out_a_bits_param),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size
      (_subsystem_fbus_auto_bus_xing_out_a_bits_size),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source
      (_subsystem_fbus_auto_bus_xing_out_a_bits_source),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address
      (_subsystem_fbus_auto_bus_xing_out_a_bits_address),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask
      (_subsystem_fbus_auto_bus_xing_out_a_bits_mask),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_data
      (_subsystem_fbus_auto_bus_xing_out_a_bits_data),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt
      (_subsystem_fbus_auto_bus_xing_out_a_bits_corrupt),	// FrontBus.scala:22:26
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready
      (_subsystem_fbus_auto_bus_xing_out_d_ready),	// FrontBus.scala:22:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_ready
      (_subsystem_cbus_auto_bus_xing_in_a_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_valid
      (_subsystem_cbus_auto_bus_xing_in_d_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_opcode
      (_subsystem_cbus_auto_bus_xing_in_d_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_param
      (_subsystem_cbus_auto_bus_xing_in_d_bits_param),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_size
      (_subsystem_cbus_auto_bus_xing_in_d_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_source
      (_subsystem_cbus_auto_bus_xing_in_d_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_sink
      (_subsystem_cbus_auto_bus_xing_in_d_bits_sink),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_denied
      (_subsystem_cbus_auto_bus_xing_in_d_bits_denied),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_data
      (_subsystem_cbus_auto_bus_xing_in_d_bits_data),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_corrupt
      (_subsystem_cbus_auto_bus_xing_in_d_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt),
    .auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt),
    .auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt),
    .auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt),
    .auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid),
    .auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data),
    .auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready)
  );
  PeripheryBus subsystem_pbus (	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_ready
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_valid
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_opcode
      (_domain_1_auto_resetCtrl_in_d_bits_opcode),	// TileResetCtrl.scala:23:34
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_size
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_source
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_data
      (_domain_1_auto_resetCtrl_in_d_bits_data),	// TileResetCtrl.scala:23:34
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_ready
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_valid
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode
      (_uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_opcode),	// UART.scala:242:44
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_size
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_source
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_data
      (_uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_data),	// UART.scala:242:44
    .auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_bus_xing_in_a_valid
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_data
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_bus_xing_in_d_ready
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt),
    .auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_valid
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_valid),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data),
    .auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt),
    .auto_coupler_to_device_named_uart_0_control_xing_out_d_ready
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_d_ready),
    .auto_bus_xing_in_a_ready
      (_subsystem_pbus_auto_bus_xing_in_a_ready),
    .auto_bus_xing_in_d_valid
      (_subsystem_pbus_auto_bus_xing_in_d_valid),
    .auto_bus_xing_in_d_bits_opcode
      (_subsystem_pbus_auto_bus_xing_in_d_bits_opcode),
    .auto_bus_xing_in_d_bits_param
      (_subsystem_pbus_auto_bus_xing_in_d_bits_param),
    .auto_bus_xing_in_d_bits_size
      (_subsystem_pbus_auto_bus_xing_in_d_bits_size),
    .auto_bus_xing_in_d_bits_source
      (_subsystem_pbus_auto_bus_xing_in_d_bits_source),
    .auto_bus_xing_in_d_bits_sink
      (_subsystem_pbus_auto_bus_xing_in_d_bits_sink),
    .auto_bus_xing_in_d_bits_denied
      (_subsystem_pbus_auto_bus_xing_in_d_bits_denied),
    .auto_bus_xing_in_d_bits_data
      (_subsystem_pbus_auto_bus_xing_in_d_bits_data),
    .auto_bus_xing_in_d_bits_corrupt
      (_subsystem_pbus_auto_bus_xing_in_d_bits_corrupt)
  );
  FrontBus subsystem_fbus (	// FrontBus.scala:22:26
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_valid
      (_domain_auto_serdesser_client_out_a_valid),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_opcode
      (_domain_auto_serdesser_client_out_a_bits_opcode),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_param
      (_domain_auto_serdesser_client_out_a_bits_param),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_size
      (_domain_auto_serdesser_client_out_a_bits_size),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_source
      (_domain_auto_serdesser_client_out_a_bits_source),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_address
      (_domain_auto_serdesser_client_out_a_bits_address),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_mask
      (_domain_auto_serdesser_client_out_a_bits_mask),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_data
      (_domain_auto_serdesser_client_out_a_bits_data),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_corrupt
      (_domain_auto_serdesser_client_out_a_bits_corrupt),	// SerialAdapter.scala:373:28
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_ready
      (_domain_auto_serdesser_client_out_d_ready),	// SerialAdapter.scala:373:28
    .auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock
      (auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock),
    .auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset
      (auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset),
    .auto_bus_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data),	// SystemBus.scala:24:26
    .auto_bus_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data),
    .auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt),
    .auto_bus_xing_out_a_valid
      (_subsystem_fbus_auto_bus_xing_out_a_valid),
    .auto_bus_xing_out_a_bits_opcode
      (_subsystem_fbus_auto_bus_xing_out_a_bits_opcode),
    .auto_bus_xing_out_a_bits_param
      (_subsystem_fbus_auto_bus_xing_out_a_bits_param),
    .auto_bus_xing_out_a_bits_size
      (_subsystem_fbus_auto_bus_xing_out_a_bits_size),
    .auto_bus_xing_out_a_bits_source
      (_subsystem_fbus_auto_bus_xing_out_a_bits_source),
    .auto_bus_xing_out_a_bits_address
      (_subsystem_fbus_auto_bus_xing_out_a_bits_address),
    .auto_bus_xing_out_a_bits_mask
      (_subsystem_fbus_auto_bus_xing_out_a_bits_mask),
    .auto_bus_xing_out_a_bits_data
      (_subsystem_fbus_auto_bus_xing_out_a_bits_data),
    .auto_bus_xing_out_a_bits_corrupt
      (_subsystem_fbus_auto_bus_xing_out_a_bits_corrupt),
    .auto_bus_xing_out_d_ready
      (_subsystem_fbus_auto_bus_xing_out_d_ready)
  );
  PeripheryBus_1 subsystem_cbus (	// PeripheryBus.scala:31:26
    .auto_coupler_to_bootrom_fragmenter_out_a_ready
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bootrom_fragmenter_out_d_valid
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bootrom_fragmenter_out_d_bits_size
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bootrom_fragmenter_out_d_bits_source
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bootrom_fragmenter_out_d_bits_data
      (_bootROMDomainWrapper_auto_bootrom_in_d_bits_data),	// BootROM.scala:70:42
    .auto_coupler_to_debug_fragmenter_out_a_ready
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_debug_fragmenter_out_d_valid
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_debug_fragmenter_out_d_bits_opcode
      (_debug_1_auto_dmInner_dmInner_tl_in_d_bits_opcode),	// Periphery.scala:84:27
    .auto_coupler_to_debug_fragmenter_out_d_bits_size
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_debug_fragmenter_out_d_bits_source
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_debug_fragmenter_out_d_bits_data
      (_debug_1_auto_dmInner_dmInner_tl_in_d_bits_data),	// Periphery.scala:84:27
    .auto_coupler_to_clint_fragmenter_out_a_ready
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_clint_fragmenter_out_d_valid
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_clint_fragmenter_out_d_bits_opcode
      (_clint_auto_in_d_bits_opcode),	// CLINT.scala:109:27
    .auto_coupler_to_clint_fragmenter_out_d_bits_size
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_clint_fragmenter_out_d_bits_source
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_clint_fragmenter_out_d_bits_data
      (_clint_auto_in_d_bits_data),	// CLINT.scala:109:27
    .auto_coupler_to_plic_fragmenter_out_a_ready
      (_plicDomainWrapper_auto_plic_in_a_ready),	// Plic.scala:359:39
    .auto_coupler_to_plic_fragmenter_out_d_valid
      (_plicDomainWrapper_auto_plic_in_d_valid),	// Plic.scala:359:39
    .auto_coupler_to_plic_fragmenter_out_d_bits_opcode
      (_plicDomainWrapper_auto_plic_in_d_bits_opcode),	// Plic.scala:359:39
    .auto_coupler_to_plic_fragmenter_out_d_bits_size
      (_plicDomainWrapper_auto_plic_in_d_bits_size),	// Plic.scala:359:39
    .auto_coupler_to_plic_fragmenter_out_d_bits_source
      (_plicDomainWrapper_auto_plic_in_d_bits_source),	// Plic.scala:359:39
    .auto_coupler_to_plic_fragmenter_out_d_bits_data
      (_plicDomainWrapper_auto_plic_in_d_bits_data),	// Plic.scala:359:39
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_ready
      (_subsystem_pbus_auto_bus_xing_in_a_ready),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_valid
      (_subsystem_pbus_auto_bus_xing_in_d_valid),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_opcode
      (_subsystem_pbus_auto_bus_xing_in_d_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_param
      (_subsystem_pbus_auto_bus_xing_in_d_bits_param),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_size
      (_subsystem_pbus_auto_bus_xing_in_d_bits_size),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_source
      (_subsystem_pbus_auto_bus_xing_in_d_bits_source),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_sink
      (_subsystem_pbus_auto_bus_xing_in_d_bits_sink),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_denied
      (_subsystem_pbus_auto_bus_xing_in_d_bits_denied),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_data
      (_subsystem_pbus_auto_bus_xing_in_d_bits_data),	// PeripheryBus.scala:31:26
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_corrupt
      (_subsystem_pbus_auto_bus_xing_in_d_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_coupler_to_l2_ctrl_buffer_out_a_ready
      (_subsystem_l2_wrapper_auto_l2_ctl_in_a_ready),	// BankedL2Params.scala:47:31
    .auto_coupler_to_l2_ctrl_buffer_out_d_valid
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_valid),	// BankedL2Params.scala:47:31
    .auto_coupler_to_l2_ctrl_buffer_out_d_bits_opcode
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_opcode),	// BankedL2Params.scala:47:31
    .auto_coupler_to_l2_ctrl_buffer_out_d_bits_size
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_size),	// BankedL2Params.scala:47:31
    .auto_coupler_to_l2_ctrl_buffer_out_d_bits_source
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_source),	// BankedL2Params.scala:47:31
    .auto_coupler_to_l2_ctrl_buffer_out_d_bits_data
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_data),	// BankedL2Params.scala:47:31
    .auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_bus_xing_in_a_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_mask
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data),	// SystemBus.scala:24:26
    .auto_bus_xing_in_a_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt),	// SystemBus.scala:24:26
    .auto_bus_xing_in_d_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready),	// SystemBus.scala:24:26
    .custom_boot                                                          (custom_boot),
    .auto_coupler_to_bootrom_fragmenter_out_a_valid
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_valid),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_param),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_size),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_source),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_address),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_mask),
    .auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt),
    .auto_coupler_to_bootrom_fragmenter_out_d_ready
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_d_ready),
    .auto_coupler_to_debug_fragmenter_out_a_valid
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_valid),
    .auto_coupler_to_debug_fragmenter_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_opcode),
    .auto_coupler_to_debug_fragmenter_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_param),
    .auto_coupler_to_debug_fragmenter_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_size),
    .auto_coupler_to_debug_fragmenter_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_source),
    .auto_coupler_to_debug_fragmenter_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_address),
    .auto_coupler_to_debug_fragmenter_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_mask),
    .auto_coupler_to_debug_fragmenter_out_a_bits_data
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_data),
    .auto_coupler_to_debug_fragmenter_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_corrupt),
    .auto_coupler_to_debug_fragmenter_out_d_ready
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_d_ready),
    .auto_coupler_to_clint_fragmenter_out_a_valid
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_valid),
    .auto_coupler_to_clint_fragmenter_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_opcode),
    .auto_coupler_to_clint_fragmenter_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_param),
    .auto_coupler_to_clint_fragmenter_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_size),
    .auto_coupler_to_clint_fragmenter_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_source),
    .auto_coupler_to_clint_fragmenter_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_address),
    .auto_coupler_to_clint_fragmenter_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_mask),
    .auto_coupler_to_clint_fragmenter_out_a_bits_data
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_data),
    .auto_coupler_to_clint_fragmenter_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_corrupt),
    .auto_coupler_to_clint_fragmenter_out_d_ready
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_d_ready),
    .auto_coupler_to_plic_fragmenter_out_a_valid
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_valid),
    .auto_coupler_to_plic_fragmenter_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_opcode),
    .auto_coupler_to_plic_fragmenter_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_param),
    .auto_coupler_to_plic_fragmenter_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_size),
    .auto_coupler_to_plic_fragmenter_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_source),
    .auto_coupler_to_plic_fragmenter_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_address),
    .auto_coupler_to_plic_fragmenter_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_mask),
    .auto_coupler_to_plic_fragmenter_out_a_bits_data
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_data),
    .auto_coupler_to_plic_fragmenter_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_corrupt),
    .auto_coupler_to_plic_fragmenter_out_d_ready
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_d_ready),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready
      (_subsystem_cbus_auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready),
    .auto_coupler_to_l2_ctrl_buffer_out_a_valid
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_valid),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_param
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_param),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_size
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_size),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_source
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_source),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_address
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_address),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_data
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_data),
    .auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt),
    .auto_coupler_to_l2_ctrl_buffer_out_d_ready
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_d_ready),
    .auto_bus_xing_in_a_ready
      (_subsystem_cbus_auto_bus_xing_in_a_ready),
    .auto_bus_xing_in_d_valid
      (_subsystem_cbus_auto_bus_xing_in_d_valid),
    .auto_bus_xing_in_d_bits_opcode
      (_subsystem_cbus_auto_bus_xing_in_d_bits_opcode),
    .auto_bus_xing_in_d_bits_param
      (_subsystem_cbus_auto_bus_xing_in_d_bits_param),
    .auto_bus_xing_in_d_bits_size
      (_subsystem_cbus_auto_bus_xing_in_d_bits_size),
    .auto_bus_xing_in_d_bits_source
      (_subsystem_cbus_auto_bus_xing_in_d_bits_source),
    .auto_bus_xing_in_d_bits_sink
      (_subsystem_cbus_auto_bus_xing_in_d_bits_sink),
    .auto_bus_xing_in_d_bits_denied
      (_subsystem_cbus_auto_bus_xing_in_d_bits_denied),
    .auto_bus_xing_in_d_bits_data
      (_subsystem_cbus_auto_bus_xing_in_d_bits_data),
    .auto_bus_xing_in_d_bits_corrupt
      (_subsystem_cbus_auto_bus_xing_in_d_bits_corrupt)
  );
  MemoryBus subsystem_mbus (	// MemoryBus.scala:25:26
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_ready
      (_domain_auto_tlserial_manager_crossing_in_a_ready),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_valid
      (_domain_auto_tlserial_manager_crossing_in_d_valid),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_opcode
      (_domain_auto_tlserial_manager_crossing_in_d_bits_opcode),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_param
      (_domain_auto_tlserial_manager_crossing_in_d_bits_param),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_size
      (_domain_auto_tlserial_manager_crossing_in_d_bits_size),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_source
      (_domain_auto_tlserial_manager_crossing_in_d_bits_source),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_sink
      (_domain_auto_tlserial_manager_crossing_in_d_bits_sink),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_denied
      (_domain_auto_tlserial_manager_crossing_in_d_bits_denied),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_data
      (_domain_auto_tlserial_manager_crossing_in_d_bits_data),	// SerialAdapter.scala:373:28
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_bits_corrupt
      (_domain_auto_tlserial_manager_crossing_in_d_bits_corrupt),	// SerialAdapter.scala:373:28
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_ready
      (mem_axi4_0_aw_ready),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_ready
      (mem_axi4_0_w_ready),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_valid
      (mem_axi4_0_b_valid),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_id
      (mem_axi4_0_b_bits_id),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_bits_resp
      (mem_axi4_0_b_bits_resp),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_ready
      (mem_axi4_0_ar_ready),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_valid
      (mem_axi4_0_r_valid),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_id
      (mem_axi4_0_r_bits_id),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_data
      (mem_axi4_0_r_bits_data),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_resp
      (mem_axi4_0_r_bits_resp),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_bits_last
      (mem_axi4_0_r_bits_last),
    .auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock
      (auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_clock),
    .auto_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset
      (auto_subsystem_mbus_subsystem_mbus_clock_groups_in_member_subsystem_mbus_0_reset),
    .auto_bus_xing_in_a_valid
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_opcode
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_param
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_size
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_source
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_address
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_mask
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_data
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_a_bits_corrupt
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt),	// BankedL2Params.scala:47:31
    .auto_bus_xing_in_d_ready
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready),	// BankedL2Params.scala:47:31
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_valid
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_valid),
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_bits_address
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_bits_address),
    .auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_ready
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_ready),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_valid
      (mem_axi4_0_aw_valid),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_id
      (mem_axi4_0_aw_bits_id),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_addr
      (mem_axi4_0_aw_bits_addr),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_len
      (mem_axi4_0_aw_bits_len),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_size
      (mem_axi4_0_aw_bits_size),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_burst
      (mem_axi4_0_aw_bits_burst),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_lock
      (mem_axi4_0_aw_bits_lock),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_cache
      (mem_axi4_0_aw_bits_cache),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_prot
      (mem_axi4_0_aw_bits_prot),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_aw_bits_qos
      (mem_axi4_0_aw_bits_qos),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_valid
      (mem_axi4_0_w_valid),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_data
      (mem_axi4_0_w_bits_data),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_strb
      (mem_axi4_0_w_bits_strb),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_w_bits_last
      (mem_axi4_0_w_bits_last),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_b_ready
      (mem_axi4_0_b_ready),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_valid
      (mem_axi4_0_ar_valid),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_id
      (mem_axi4_0_ar_bits_id),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_addr
      (mem_axi4_0_ar_bits_addr),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_len
      (mem_axi4_0_ar_bits_len),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_size
      (mem_axi4_0_ar_bits_size),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_burst
      (mem_axi4_0_ar_bits_burst),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_lock
      (mem_axi4_0_ar_bits_lock),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_cache
      (mem_axi4_0_ar_bits_cache),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_prot
      (mem_axi4_0_ar_bits_prot),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_ar_bits_qos
      (mem_axi4_0_ar_bits_qos),
    .auto_coupler_to_memory_controller_port_named_axi4_axi4yank_out_r_ready
      (mem_axi4_0_r_ready),
    .auto_bus_xing_in_a_ready
      (_subsystem_mbus_auto_bus_xing_in_a_ready),
    .auto_bus_xing_in_d_valid
      (_subsystem_mbus_auto_bus_xing_in_d_valid),
    .auto_bus_xing_in_d_bits_opcode
      (_subsystem_mbus_auto_bus_xing_in_d_bits_opcode),
    .auto_bus_xing_in_d_bits_param
      (_subsystem_mbus_auto_bus_xing_in_d_bits_param),
    .auto_bus_xing_in_d_bits_size
      (_subsystem_mbus_auto_bus_xing_in_d_bits_size),
    .auto_bus_xing_in_d_bits_source
      (_subsystem_mbus_auto_bus_xing_in_d_bits_source),
    .auto_bus_xing_in_d_bits_sink
      (_subsystem_mbus_auto_bus_xing_in_d_bits_sink),
    .auto_bus_xing_in_d_bits_denied
      (_subsystem_mbus_auto_bus_xing_in_d_bits_denied),
    .auto_bus_xing_in_d_bits_data
      (_subsystem_mbus_auto_bus_xing_in_d_bits_data),
    .auto_bus_xing_in_d_bits_corrupt
      (_subsystem_mbus_auto_bus_xing_in_d_bits_corrupt)
  );
  CoherenceManagerWrapper subsystem_l2_wrapper (	// BankedL2Params.scala:47:31
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_ready
      (_subsystem_mbus_auto_bus_xing_in_a_ready),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_valid
      (_subsystem_mbus_auto_bus_xing_in_d_valid),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_opcode
      (_subsystem_mbus_auto_bus_xing_in_d_bits_opcode),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_param
      (_subsystem_mbus_auto_bus_xing_in_d_bits_param),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_size
      (_subsystem_mbus_auto_bus_xing_in_d_bits_size),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_source
      (_subsystem_mbus_auto_bus_xing_in_d_bits_source),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_sink
      (_subsystem_mbus_auto_bus_xing_in_d_bits_sink),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_denied
      (_subsystem_mbus_auto_bus_xing_in_d_bits_denied),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_data
      (_subsystem_mbus_auto_bus_xing_in_d_bits_data),	// MemoryBus.scala:25:26
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_bits_corrupt
      (_subsystem_mbus_auto_bus_xing_in_d_bits_corrupt),	// MemoryBus.scala:25:26
    .auto_coherent_jbar_in_a_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_mask
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_a_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_b_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_opcode
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_param
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_size
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_source
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_address
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_data
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_c_bits_corrupt
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_d_ready
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_e_valid
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid),	// SystemBus.scala:24:26
    .auto_coherent_jbar_in_e_bits_sink
      (_subsystem_sbus_auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink),	// SystemBus.scala:24:26
    .auto_l2_ctl_in_a_valid
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_data
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_l2_ctl_in_d_ready
      (_subsystem_cbus_auto_coupler_to_l2_ctrl_buffer_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_clock),
    .auto_subsystem_l2_clock_groups_in_member_subsystem_l2_0_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_1_reset),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_valid),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_address),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt),
    .auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_d_ready),
    .auto_coherent_jbar_in_a_ready
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_a_ready),
    .auto_coherent_jbar_in_b_valid
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_valid),
    .auto_coherent_jbar_in_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),
    .auto_coherent_jbar_in_b_bits_source
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_source),
    .auto_coherent_jbar_in_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),
    .auto_coherent_jbar_in_c_ready
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_c_ready),
    .auto_coherent_jbar_in_d_valid
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_valid),
    .auto_coherent_jbar_in_d_bits_opcode
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_opcode),
    .auto_coherent_jbar_in_d_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_param),
    .auto_coherent_jbar_in_d_bits_size
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_size),
    .auto_coherent_jbar_in_d_bits_source
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_source),
    .auto_coherent_jbar_in_d_bits_sink
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_sink),
    .auto_coherent_jbar_in_d_bits_denied
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_denied),
    .auto_coherent_jbar_in_d_bits_data
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_data),
    .auto_coherent_jbar_in_d_bits_corrupt
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_d_bits_corrupt),
    .auto_l2_ctl_in_a_ready
      (_subsystem_l2_wrapper_auto_l2_ctl_in_a_ready),
    .auto_l2_ctl_in_d_valid
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_valid),
    .auto_l2_ctl_in_d_bits_opcode
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_opcode),
    .auto_l2_ctl_in_d_bits_size
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_size),
    .auto_l2_ctl_in_d_bits_source
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_source),
    .auto_l2_ctl_in_d_bits_data
      (_subsystem_l2_wrapper_auto_l2_ctl_in_d_bits_data)
  );
  TilePRCIDomain tile_prci_domain (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_0_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_2_sync_0           (_intsource_2_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_1_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  TilePRCIDomain_1 tile_prci_domain_1 (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_1_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_2_sync_0           (_intsource_5_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_4_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_3_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_3_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_1_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  TilePRCIDomain_2 tile_prci_domain_2 (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_2_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_7_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_6_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_6_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_2_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  TilePRCIDomain_3 tile_prci_domain_3 (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_3_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_2_sync_0           (_intsource_10_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_9_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_8_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_8_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_3_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  TilePRCIDomain_4 tile_prci_domain_4 (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_4_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_2_sync_0           (_intsource_13_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_12_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_11_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_11_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_4_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  TilePRCIDomain_5 tile_prci_domain_5 (	// HasTiles.scala:252:38
    .auto_intsink_in_sync_0
      (_debug_1_auto_dmOuter_intsource_out_5_sync_0),	// Periphery.scala:84:27
    .auto_int_in_clock_xing_in_2_sync_0           (_intsource_16_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_1_sync_0           (_intsource_15_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_0           (_intsource_14_auto_out_sync_0),	// Crossing.scala:26:31
    .auto_int_in_clock_xing_in_0_sync_1           (_intsource_14_auto_out_sync_1),	// Crossing.scala:26:31
    .auto_tl_master_clock_xing_out_a_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_param
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_param),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_b_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_b_bits_address
      (_subsystem_l2_wrapper_auto_coherent_jbar_in_b_bits_address),	// BankedL2Params.scala:47:31
    .auto_tl_master_clock_xing_out_c_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_valid
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_opcode
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_param
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_size
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_source
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_sink
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_denied
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_data
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_d_bits_corrupt
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt),	// SystemBus.scala:24:26
    .auto_tl_master_clock_xing_out_e_ready
      (_subsystem_sbus_auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready),	// SystemBus.scala:24:26
    .auto_tap_clock_in_clock
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .auto_tap_clock_in_reset
      (auto_subsystem_sbus_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_tl_master_clock_xing_out_a_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_valid),
    .auto_tl_master_clock_xing_out_a_bits_opcode
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_opcode),
    .auto_tl_master_clock_xing_out_a_bits_param
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_param),
    .auto_tl_master_clock_xing_out_a_bits_size
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_size),
    .auto_tl_master_clock_xing_out_a_bits_source
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_source),
    .auto_tl_master_clock_xing_out_a_bits_address
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_address),
    .auto_tl_master_clock_xing_out_a_bits_mask
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_mask),
    .auto_tl_master_clock_xing_out_a_bits_data
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_data),
    .auto_tl_master_clock_xing_out_a_bits_corrupt
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_a_bits_corrupt),
    .auto_tl_master_clock_xing_out_b_ready
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_b_ready),
    .auto_tl_master_clock_xing_out_c_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_valid),
    .auto_tl_master_clock_xing_out_c_bits_opcode
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_opcode),
    .auto_tl_master_clock_xing_out_c_bits_param
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_param),
    .auto_tl_master_clock_xing_out_c_bits_size
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_size),
    .auto_tl_master_clock_xing_out_c_bits_source
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_source),
    .auto_tl_master_clock_xing_out_c_bits_address
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_address),
    .auto_tl_master_clock_xing_out_c_bits_data
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_data),
    .auto_tl_master_clock_xing_out_c_bits_corrupt
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_c_bits_corrupt),
    .auto_tl_master_clock_xing_out_d_ready
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_d_ready),
    .auto_tl_master_clock_xing_out_e_valid
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_e_valid),
    .auto_tl_master_clock_xing_out_e_bits_sink
      (_tile_prci_domain_5_auto_tl_master_clock_xing_out_e_bits_sink)
  );
  ClockSinkDomain plicDomainWrapper (	// Plic.scala:359:39
    .auto_plic_int_in_0
      (_uartClockDomainWrapper_auto_uart_0_int_xing_out_sync_0),	// UART.scala:242:44
    .auto_plic_in_a_valid
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_data
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_plic_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_plic_in_d_ready
      (_subsystem_cbus_auto_coupler_to_plic_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_clock_in_clock
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .auto_clock_in_reset
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_plic_int_out_10_0      (_plicDomainWrapper_auto_plic_int_out_10_0),
    .auto_plic_int_out_9_0       (_plicDomainWrapper_auto_plic_int_out_9_0),
    .auto_plic_int_out_8_0       (_plicDomainWrapper_auto_plic_int_out_8_0),
    .auto_plic_int_out_7_0       (_plicDomainWrapper_auto_plic_int_out_7_0),
    .auto_plic_int_out_6_0       (_plicDomainWrapper_auto_plic_int_out_6_0),
    .auto_plic_int_out_5_0       (_plicDomainWrapper_auto_plic_int_out_5_0),
    .auto_plic_int_out_4_0       (_plicDomainWrapper_auto_plic_int_out_4_0),
    .auto_plic_int_out_3_0       (_plicDomainWrapper_auto_plic_int_out_3_0),
    .auto_plic_int_out_2_0       (_plicDomainWrapper_auto_plic_int_out_2_0),
    .auto_plic_int_out_1_0       (_plicDomainWrapper_auto_plic_int_out_1_0),
    .auto_plic_int_out_0_0       (_plicDomainWrapper_auto_plic_int_out_0_0),
    .auto_plic_in_a_ready        (_plicDomainWrapper_auto_plic_in_a_ready),
    .auto_plic_in_d_valid        (_plicDomainWrapper_auto_plic_in_d_valid),
    .auto_plic_in_d_bits_opcode  (_plicDomainWrapper_auto_plic_in_d_bits_opcode),
    .auto_plic_in_d_bits_size    (_plicDomainWrapper_auto_plic_in_d_bits_size),
    .auto_plic_in_d_bits_source  (_plicDomainWrapper_auto_plic_in_d_bits_source),
    .auto_plic_in_d_bits_data    (_plicDomainWrapper_auto_plic_in_d_bits_data)
  );
  CLINT clint (	// CLINT.scala:109:27
    .clock
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_a_valid
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_data
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_in_d_ready
      (_subsystem_cbus_auto_coupler_to_clint_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .io_rtcTick             (int_rtc_tick),	// Counter.scala:72:24
    .auto_int_out_5_0       (_clint_auto_int_out_5_0),
    .auto_int_out_5_1       (_clint_auto_int_out_5_1),
    .auto_int_out_4_0       (_clint_auto_int_out_4_0),
    .auto_int_out_4_1       (_clint_auto_int_out_4_1),
    .auto_int_out_3_0       (_clint_auto_int_out_3_0),
    .auto_int_out_3_1       (_clint_auto_int_out_3_1),
    .auto_int_out_2_0       (_clint_auto_int_out_2_0),
    .auto_int_out_2_1       (_clint_auto_int_out_2_1),
    .auto_int_out_1_0       (_clint_auto_int_out_1_0),
    .auto_int_out_1_1       (_clint_auto_int_out_1_1),
    .auto_int_out_0_0       (_clint_auto_int_out_0_0),
    .auto_int_out_0_1       (_clint_auto_int_out_0_1),
    .auto_in_d_bits_opcode  (_clint_auto_in_d_bits_opcode),
    .auto_in_d_bits_data    (_clint_auto_in_d_bits_data)
  );
  TLDebugModule debug_1 (	// Periphery.scala:84:27
    .auto_dmInner_dmInner_tl_in_a_valid
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_data
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_dmInner_dmInner_tl_in_d_ready
      (_subsystem_cbus_auto_coupler_to_debug_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .io_debug_clock                            (debug_clock),
    .io_debug_reset                            (debug_reset),
    .io_ctrl_dmactiveAck                       (debug_dmactiveAck),
    .io_dmi_dmi_req_valid                      (_dtm_io_dmi_req_valid),	// Periphery.scala:161:21
    .io_dmi_dmi_req_bits_addr                  (_dtm_io_dmi_req_bits_addr),	// Periphery.scala:161:21
    .io_dmi_dmi_req_bits_data                  (_dtm_io_dmi_req_bits_data),	// Periphery.scala:161:21
    .io_dmi_dmi_req_bits_op                    (_dtm_io_dmi_req_bits_op),	// Periphery.scala:161:21
    .io_dmi_dmi_resp_ready                     (_dtm_io_dmi_resp_ready),	// Periphery.scala:161:21
    .io_dmi_dmiClock                           (debug_systemjtag_jtag_TCK),
    .io_dmi_dmiReset                           (debug_systemjtag_reset),
    .io_hartIsInReset_0                        (resetctrl_hartIsInReset_0),
    .io_hartIsInReset_1                        (resetctrl_hartIsInReset_1),
    .io_hartIsInReset_2                        (resetctrl_hartIsInReset_2),
    .io_hartIsInReset_3                        (resetctrl_hartIsInReset_3),
    .io_hartIsInReset_4                        (resetctrl_hartIsInReset_4),
    .io_hartIsInReset_5                        (resetctrl_hartIsInReset_5),
    .auto_dmInner_dmInner_tl_in_d_bits_opcode
      (_debug_1_auto_dmInner_dmInner_tl_in_d_bits_opcode),
    .auto_dmInner_dmInner_tl_in_d_bits_data
      (_debug_1_auto_dmInner_dmInner_tl_in_d_bits_data),
    .auto_dmOuter_intsource_out_5_sync_0
      (_debug_1_auto_dmOuter_intsource_out_5_sync_0),
    .auto_dmOuter_intsource_out_4_sync_0
      (_debug_1_auto_dmOuter_intsource_out_4_sync_0),
    .auto_dmOuter_intsource_out_3_sync_0
      (_debug_1_auto_dmOuter_intsource_out_3_sync_0),
    .auto_dmOuter_intsource_out_2_sync_0
      (_debug_1_auto_dmOuter_intsource_out_2_sync_0),
    .auto_dmOuter_intsource_out_1_sync_0
      (_debug_1_auto_dmOuter_intsource_out_1_sync_0),
    .auto_dmOuter_intsource_out_0_sync_0
      (_debug_1_auto_dmOuter_intsource_out_0_sync_0),
    .io_ctrl_dmactive                          (debug_dmactive),
    .io_dmi_dmi_req_ready                      (_debug_1_io_dmi_dmi_req_ready),
    .io_dmi_dmi_resp_valid                     (_debug_1_io_dmi_dmi_resp_valid),
    .io_dmi_dmi_resp_bits_data                 (_debug_1_io_dmi_dmi_resp_bits_data),
    .io_dmi_dmi_resp_bits_resp                 (_debug_1_io_dmi_dmi_resp_bits_resp)
  );
  IntSyncCrossingSource_25 intsource (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_0_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_0_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_1 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_0_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_1_auto_out_sync_0)
  );
  IntSyncCrossingSource_1 intsource_2 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_1_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_2_auto_out_sync_0)
  );
  IntSyncCrossingSource_25 intsource_3 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_1_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_1_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_3_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_3_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_4 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_2_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_4_auto_out_sync_0)
  );
  IntSyncCrossingSource_1 intsource_5 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_3_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_5_auto_out_sync_0)
  );
  IntSyncCrossingSource_25 intsource_6 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_2_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_2_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_6_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_6_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_7 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_4_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_7_auto_out_sync_0)
  );
  IntSyncCrossingSource_25 intsource_8 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_3_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_3_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_8_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_8_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_9 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_5_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_9_auto_out_sync_0)
  );
  IntSyncCrossingSource_1 intsource_10 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_6_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_10_auto_out_sync_0)
  );
  IntSyncCrossingSource_25 intsource_11 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_4_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_4_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_11_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_11_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_12 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_7_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_12_auto_out_sync_0)
  );
  IntSyncCrossingSource_1 intsource_13 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_8_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_13_auto_out_sync_0)
  );
  IntSyncCrossingSource_25 intsource_14 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_clint_auto_int_out_5_0),	// CLINT.scala:109:27
    .auto_in_1       (_clint_auto_int_out_5_1),	// CLINT.scala:109:27
    .auto_out_sync_0 (_intsource_14_auto_out_sync_0),
    .auto_out_sync_1 (_intsource_14_auto_out_sync_1)
  );
  IntSyncCrossingSource_1 intsource_15 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_9_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_15_auto_out_sync_0)
  );
  IntSyncCrossingSource_1 intsource_16 (	// Crossing.scala:26:31
    .clock           (clock),
    .reset           (reset),
    .auto_in_0       (_plicDomainWrapper_auto_plic_int_out_10_0),	// Plic.scala:359:39
    .auto_out_sync_0 (_intsource_16_auto_out_sync_0)
  );
  ClockSinkDomain_1 bootROMDomainWrapper (	// BootROM.scala:70:42
    .auto_bootrom_in_a_valid
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_opcode
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_param
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_size
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_source
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_address
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_mask
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_a_bits_corrupt
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_bootrom_in_d_ready
      (_subsystem_cbus_auto_coupler_to_bootrom_fragmenter_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_clock_in_clock
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .auto_clock_in_reset
      (auto_subsystem_cbus_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_bootrom_in_d_bits_data    (_bootROMDomainWrapper_auto_bootrom_in_d_bits_data)
  );
  ClockSinkDomain_2 domain (	// SerialAdapter.scala:373:28
    .auto_serdesser_client_out_a_ready
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_valid
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_opcode
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_param
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_size
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_source
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_sink
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_denied
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_data
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data),	// FrontBus.scala:22:26
    .auto_serdesser_client_out_d_bits_corrupt
      (_subsystem_fbus_auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt),	// FrontBus.scala:22:26
    .auto_tlserial_manager_crossing_in_a_valid
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_valid),	// MemoryBus.scala:25:26
    .auto_tlserial_manager_crossing_in_a_bits_opcode
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_opcode),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_param
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_param),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_size
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_size),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_source
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_source),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_address
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_a_bits_address),	// MemoryBus.scala:25:26
    .auto_tlserial_manager_crossing_in_a_bits_mask
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_mask),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_data
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_data),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_a_bits_corrupt
      (_subsystem_l2_wrapper_auto_coupler_to_bus_named_subsystem_mbus_bus_xing_out_a_bits_corrupt),	// BankedL2Params.scala:47:31
    .auto_tlserial_manager_crossing_in_d_ready
      (_subsystem_mbus_auto_coupler_to_port_named_serial_tl_mem_tlserial_manager_crossing_out_d_ready),	// MemoryBus.scala:25:26
    .auto_clock_in_clock
      (auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock),
    .auto_clock_in_reset
      (auto_subsystem_fbus_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset),
    .serial_tl_in_valid                               (serial_tl_bits_in_valid),
    .serial_tl_in_bits                                (serial_tl_bits_in_bits),
    .serial_tl_out_ready                              (serial_tl_bits_out_ready),
    .auto_serdesser_client_out_a_valid
      (_domain_auto_serdesser_client_out_a_valid),
    .auto_serdesser_client_out_a_bits_opcode
      (_domain_auto_serdesser_client_out_a_bits_opcode),
    .auto_serdesser_client_out_a_bits_param
      (_domain_auto_serdesser_client_out_a_bits_param),
    .auto_serdesser_client_out_a_bits_size
      (_domain_auto_serdesser_client_out_a_bits_size),
    .auto_serdesser_client_out_a_bits_source
      (_domain_auto_serdesser_client_out_a_bits_source),
    .auto_serdesser_client_out_a_bits_address
      (_domain_auto_serdesser_client_out_a_bits_address),
    .auto_serdesser_client_out_a_bits_mask
      (_domain_auto_serdesser_client_out_a_bits_mask),
    .auto_serdesser_client_out_a_bits_data
      (_domain_auto_serdesser_client_out_a_bits_data),
    .auto_serdesser_client_out_a_bits_corrupt
      (_domain_auto_serdesser_client_out_a_bits_corrupt),
    .auto_serdesser_client_out_d_ready
      (_domain_auto_serdesser_client_out_d_ready),
    .auto_tlserial_manager_crossing_in_a_ready
      (_domain_auto_tlserial_manager_crossing_in_a_ready),
    .auto_tlserial_manager_crossing_in_d_valid
      (_domain_auto_tlserial_manager_crossing_in_d_valid),
    .auto_tlserial_manager_crossing_in_d_bits_opcode
      (_domain_auto_tlserial_manager_crossing_in_d_bits_opcode),
    .auto_tlserial_manager_crossing_in_d_bits_param
      (_domain_auto_tlserial_manager_crossing_in_d_bits_param),
    .auto_tlserial_manager_crossing_in_d_bits_size
      (_domain_auto_tlserial_manager_crossing_in_d_bits_size),
    .auto_tlserial_manager_crossing_in_d_bits_source
      (_domain_auto_tlserial_manager_crossing_in_d_bits_source),
    .auto_tlserial_manager_crossing_in_d_bits_sink
      (_domain_auto_tlserial_manager_crossing_in_d_bits_sink),
    .auto_tlserial_manager_crossing_in_d_bits_denied
      (_domain_auto_tlserial_manager_crossing_in_d_bits_denied),
    .auto_tlserial_manager_crossing_in_d_bits_data
      (_domain_auto_tlserial_manager_crossing_in_d_bits_data),
    .auto_tlserial_manager_crossing_in_d_bits_corrupt
      (_domain_auto_tlserial_manager_crossing_in_d_bits_corrupt),
    .serial_tl_in_ready                               (serial_tl_bits_in_ready),
    .serial_tl_out_valid                              (serial_tl_bits_out_valid),
    .serial_tl_out_bits                               (serial_tl_bits_out_bits)
  );
  ClockSinkDomain_3 uartClockDomainWrapper (	// UART.scala:242:44
    .auto_uart_0_control_xing_in_a_valid
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_opcode
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_param
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_size
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_source
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_address
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_mask
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_data
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_a_bits_corrupt
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_uart_0_control_xing_in_d_ready
      (_subsystem_pbus_auto_coupler_to_device_named_uart_0_control_xing_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_uart_0_io_out_rxd                     (uart_0_rxd),
    .auto_clock_in_clock
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .auto_clock_in_reset
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_uart_0_int_xing_out_sync_0
      (_uartClockDomainWrapper_auto_uart_0_int_xing_out_sync_0),
    .auto_uart_0_control_xing_in_d_bits_opcode
      (_uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_opcode),
    .auto_uart_0_control_xing_in_d_bits_data
      (_uartClockDomainWrapper_auto_uart_0_control_xing_in_d_bits_data),
    .auto_uart_0_io_out_txd                     (uart_0_txd)
  );
  ClockSinkDomain_4 domain_1 (	// TileResetCtrl.scala:23:34
    .auto_resetCtrl_async_reset_sink_in_reset
      (auto_domain_resetCtrl_async_reset_sink_in_reset),
    .auto_resetCtrl_in_a_valid
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_opcode
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_param
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_size
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_source
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_address
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_mask
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_data
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_a_bits_corrupt
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt),	// PeripheryBus.scala:31:26
    .auto_resetCtrl_in_d_ready
      (_subsystem_pbus_auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready),	// PeripheryBus.scala:31:26
    .auto_clock_in_clock
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .auto_clock_in_reset
      (auto_subsystem_pbus_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_resetCtrl_in_d_bits_opcode          (_domain_1_auto_resetCtrl_in_d_bits_opcode),
    .auto_resetCtrl_in_d_bits_data            (_domain_1_auto_resetCtrl_in_d_bits_data)
  );
  DebugTransportModuleJTAG dtm (	// Periphery.scala:161:21
    .io_jtag_clock         (debug_systemjtag_jtag_TCK),
    .io_jtag_reset         (debug_systemjtag_reset),
    .io_dmi_req_ready      (_debug_1_io_dmi_dmi_req_ready),	// Periphery.scala:84:27
    .io_dmi_resp_valid     (_debug_1_io_dmi_dmi_resp_valid),	// Periphery.scala:84:27
    .io_dmi_resp_bits_data (_debug_1_io_dmi_dmi_resp_bits_data),	// Periphery.scala:84:27
    .io_dmi_resp_bits_resp (_debug_1_io_dmi_dmi_resp_bits_resp),	// Periphery.scala:84:27
    .io_jtag_TMS           (debug_systemjtag_jtag_TMS),
    .io_jtag_TDI           (debug_systemjtag_jtag_TDI),
    .io_dmi_req_valid      (_dtm_io_dmi_req_valid),
    .io_dmi_req_bits_addr  (_dtm_io_dmi_req_bits_addr),
    .io_dmi_req_bits_data  (_dtm_io_dmi_req_bits_data),
    .io_dmi_req_bits_op    (_dtm_io_dmi_req_bits_op),
    .io_dmi_resp_ready     (_dtm_io_dmi_resp_ready),
    .io_jtag_TDO_data      (debug_systemjtag_jtag_TDO_data)
  );
endmodule

