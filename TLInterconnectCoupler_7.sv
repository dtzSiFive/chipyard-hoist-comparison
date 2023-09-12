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

module TLInterconnectCoupler_7(
  input         auto_tl_master_clock_xing_in_a_valid,
  input  [2:0]  auto_tl_master_clock_xing_in_a_bits_opcode,
                auto_tl_master_clock_xing_in_a_bits_param,
  input  [3:0]  auto_tl_master_clock_xing_in_a_bits_size,
                auto_tl_master_clock_xing_in_a_bits_source,
  input  [31:0] auto_tl_master_clock_xing_in_a_bits_address,
  input  [7:0]  auto_tl_master_clock_xing_in_a_bits_mask,
  input  [63:0] auto_tl_master_clock_xing_in_a_bits_data,
  input         auto_tl_master_clock_xing_in_a_bits_corrupt,
                auto_tl_master_clock_xing_in_b_ready,
                auto_tl_master_clock_xing_in_c_valid,
  input  [2:0]  auto_tl_master_clock_xing_in_c_bits_opcode,
                auto_tl_master_clock_xing_in_c_bits_param,
  input  [3:0]  auto_tl_master_clock_xing_in_c_bits_size,
                auto_tl_master_clock_xing_in_c_bits_source,
  input  [31:0] auto_tl_master_clock_xing_in_c_bits_address,
  input  [63:0] auto_tl_master_clock_xing_in_c_bits_data,
  input         auto_tl_master_clock_xing_in_c_bits_corrupt,
                auto_tl_master_clock_xing_in_d_ready,
                auto_tl_master_clock_xing_in_e_valid,
  input  [2:0]  auto_tl_master_clock_xing_in_e_bits_sink,
  input         auto_tl_out_a_ready,
                auto_tl_out_b_valid,
  input  [1:0]  auto_tl_out_b_bits_param,
  input  [3:0]  auto_tl_out_b_bits_source,
  input  [31:0] auto_tl_out_b_bits_address,
  input         auto_tl_out_c_ready,
                auto_tl_out_d_valid,
  input  [2:0]  auto_tl_out_d_bits_opcode,
  input  [1:0]  auto_tl_out_d_bits_param,
  input  [3:0]  auto_tl_out_d_bits_size,
                auto_tl_out_d_bits_source,
  input  [2:0]  auto_tl_out_d_bits_sink,
  input         auto_tl_out_d_bits_denied,
  input  [63:0] auto_tl_out_d_bits_data,
  input         auto_tl_out_d_bits_corrupt,
                auto_tl_out_e_ready,
  output        auto_tl_master_clock_xing_in_a_ready,
                auto_tl_master_clock_xing_in_b_valid,
  output [1:0]  auto_tl_master_clock_xing_in_b_bits_param,
  output [3:0]  auto_tl_master_clock_xing_in_b_bits_source,
  output [31:0] auto_tl_master_clock_xing_in_b_bits_address,
  output        auto_tl_master_clock_xing_in_c_ready,
                auto_tl_master_clock_xing_in_d_valid,
  output [2:0]  auto_tl_master_clock_xing_in_d_bits_opcode,
  output [1:0]  auto_tl_master_clock_xing_in_d_bits_param,
  output [3:0]  auto_tl_master_clock_xing_in_d_bits_size,
                auto_tl_master_clock_xing_in_d_bits_source,
  output [2:0]  auto_tl_master_clock_xing_in_d_bits_sink,
  output        auto_tl_master_clock_xing_in_d_bits_denied,
  output [63:0] auto_tl_master_clock_xing_in_d_bits_data,
  output        auto_tl_master_clock_xing_in_d_bits_corrupt,
                auto_tl_master_clock_xing_in_e_ready,
                auto_tl_out_a_valid,
  output [2:0]  auto_tl_out_a_bits_opcode,
                auto_tl_out_a_bits_param,
  output [3:0]  auto_tl_out_a_bits_size,
                auto_tl_out_a_bits_source,
  output [31:0] auto_tl_out_a_bits_address,
  output [7:0]  auto_tl_out_a_bits_mask,
  output [63:0] auto_tl_out_a_bits_data,
  output        auto_tl_out_a_bits_corrupt,
                auto_tl_out_b_ready,
                auto_tl_out_c_valid,
  output [2:0]  auto_tl_out_c_bits_opcode,
                auto_tl_out_c_bits_param,
  output [3:0]  auto_tl_out_c_bits_size,
                auto_tl_out_c_bits_source,
  output [31:0] auto_tl_out_c_bits_address,
  output [63:0] auto_tl_out_c_bits_data,
  output        auto_tl_out_c_bits_corrupt,
                auto_tl_out_d_ready,
                auto_tl_out_e_valid,
  output [2:0]  auto_tl_out_e_bits_sink
);

  assign auto_tl_master_clock_xing_in_a_ready = auto_tl_out_a_ready;
  assign auto_tl_master_clock_xing_in_b_valid = auto_tl_out_b_valid;
  assign auto_tl_master_clock_xing_in_b_bits_param = auto_tl_out_b_bits_param;
  assign auto_tl_master_clock_xing_in_b_bits_source = auto_tl_out_b_bits_source;
  assign auto_tl_master_clock_xing_in_b_bits_address = auto_tl_out_b_bits_address;
  assign auto_tl_master_clock_xing_in_c_ready = auto_tl_out_c_ready;
  assign auto_tl_master_clock_xing_in_d_valid = auto_tl_out_d_valid;
  assign auto_tl_master_clock_xing_in_d_bits_opcode = auto_tl_out_d_bits_opcode;
  assign auto_tl_master_clock_xing_in_d_bits_param = auto_tl_out_d_bits_param;
  assign auto_tl_master_clock_xing_in_d_bits_size = auto_tl_out_d_bits_size;
  assign auto_tl_master_clock_xing_in_d_bits_source = auto_tl_out_d_bits_source;
  assign auto_tl_master_clock_xing_in_d_bits_sink = auto_tl_out_d_bits_sink;
  assign auto_tl_master_clock_xing_in_d_bits_denied = auto_tl_out_d_bits_denied;
  assign auto_tl_master_clock_xing_in_d_bits_data = auto_tl_out_d_bits_data;
  assign auto_tl_master_clock_xing_in_d_bits_corrupt = auto_tl_out_d_bits_corrupt;
  assign auto_tl_master_clock_xing_in_e_ready = auto_tl_out_e_ready;
  assign auto_tl_out_a_valid = auto_tl_master_clock_xing_in_a_valid;
  assign auto_tl_out_a_bits_opcode = auto_tl_master_clock_xing_in_a_bits_opcode;
  assign auto_tl_out_a_bits_param = auto_tl_master_clock_xing_in_a_bits_param;
  assign auto_tl_out_a_bits_size = auto_tl_master_clock_xing_in_a_bits_size;
  assign auto_tl_out_a_bits_source = auto_tl_master_clock_xing_in_a_bits_source;
  assign auto_tl_out_a_bits_address = auto_tl_master_clock_xing_in_a_bits_address;
  assign auto_tl_out_a_bits_mask = auto_tl_master_clock_xing_in_a_bits_mask;
  assign auto_tl_out_a_bits_data = auto_tl_master_clock_xing_in_a_bits_data;
  assign auto_tl_out_a_bits_corrupt = auto_tl_master_clock_xing_in_a_bits_corrupt;
  assign auto_tl_out_b_ready = auto_tl_master_clock_xing_in_b_ready;
  assign auto_tl_out_c_valid = auto_tl_master_clock_xing_in_c_valid;
  assign auto_tl_out_c_bits_opcode = auto_tl_master_clock_xing_in_c_bits_opcode;
  assign auto_tl_out_c_bits_param = auto_tl_master_clock_xing_in_c_bits_param;
  assign auto_tl_out_c_bits_size = auto_tl_master_clock_xing_in_c_bits_size;
  assign auto_tl_out_c_bits_source = auto_tl_master_clock_xing_in_c_bits_source;
  assign auto_tl_out_c_bits_address = auto_tl_master_clock_xing_in_c_bits_address;
  assign auto_tl_out_c_bits_data = auto_tl_master_clock_xing_in_c_bits_data;
  assign auto_tl_out_c_bits_corrupt = auto_tl_master_clock_xing_in_c_bits_corrupt;
  assign auto_tl_out_d_ready = auto_tl_master_clock_xing_in_d_ready;
  assign auto_tl_out_e_valid = auto_tl_master_clock_xing_in_e_valid;
  assign auto_tl_out_e_bits_sink = auto_tl_master_clock_xing_in_e_bits_sink;
endmodule

