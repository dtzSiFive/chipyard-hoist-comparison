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

module Scheduler(
  input         clock,
                reset,
                io_in_a_valid,
  input  [2:0]  io_in_a_bits_opcode,
                io_in_a_bits_param,
                io_in_a_bits_size,
  input  [6:0]  io_in_a_bits_source,
  input  [31:0] io_in_a_bits_address,
  input  [7:0]  io_in_a_bits_mask,
  input  [63:0] io_in_a_bits_data,
  input         io_in_a_bits_corrupt,
                io_in_b_ready,
                io_in_c_valid,
  input  [2:0]  io_in_c_bits_opcode,
                io_in_c_bits_param,
                io_in_c_bits_size,
  input  [6:0]  io_in_c_bits_source,
  input  [31:0] io_in_c_bits_address,
  input  [63:0] io_in_c_bits_data,
  input         io_in_c_bits_corrupt,
                io_in_d_ready,
                io_in_e_valid,
  input  [2:0]  io_in_e_bits_sink,
  input         io_out_a_ready,
                io_out_c_ready,
                io_out_d_valid,
  input  [2:0]  io_out_d_bits_opcode,
  input  [1:0]  io_out_d_bits_param,
  input  [2:0]  io_out_d_bits_size,
                io_out_d_bits_source,
                io_out_d_bits_sink,
  input         io_out_d_bits_denied,
  input  [63:0] io_out_d_bits_data,
  input         io_out_d_bits_corrupt,
                io_req_valid,
  input  [31:0] io_req_bits_address,
  input         io_resp_ready,
  output        io_in_a_ready,
                io_in_b_valid,
  output [1:0]  io_in_b_bits_param,
  output [6:0]  io_in_b_bits_source,
  output [31:0] io_in_b_bits_address,
  output        io_in_c_ready,
                io_in_d_valid,
  output [2:0]  io_in_d_bits_opcode,
  output [1:0]  io_in_d_bits_param,
  output [2:0]  io_in_d_bits_size,
  output [6:0]  io_in_d_bits_source,
  output [2:0]  io_in_d_bits_sink,
  output        io_in_d_bits_denied,
  output [63:0] io_in_d_bits_data,
  output        io_in_d_bits_corrupt,
                io_out_a_valid,
  output [2:0]  io_out_a_bits_opcode,
                io_out_a_bits_param,
                io_out_a_bits_size,
                io_out_a_bits_source,
  output [31:0] io_out_a_bits_address,
  output [7:0]  io_out_a_bits_mask,
  output [63:0] io_out_a_bits_data,
  output        io_out_a_bits_corrupt,
                io_out_c_valid,
  output [2:0]  io_out_c_bits_opcode,
                io_out_c_bits_param,
                io_out_c_bits_size,
                io_out_c_bits_source,
  output [31:0] io_out_c_bits_address,
  output [63:0] io_out_c_bits_data,
  output        io_out_c_bits_corrupt,
                io_out_d_ready,
                io_out_e_valid,
  output [2:0]  io_out_e_bits_sink,
  output        io_req_ready,
                io_resp_valid
);

  wire [12:0]     _GEN;	// Scheduler.scala:222:24, :269:83, :271:26, :284:103, :286:29
  wire [12:0]     _GEN_0;	// Scheduler.scala:222:24, :269:83, :271:26, :276:131, :278:30
  wire [12:0]     _GEN_1;	// Scheduler.scala:222:24, :269:83, :271:26
  wire [12:0]     _GEN_2;	// Scheduler.scala:222:24, :269:83, :271:26
  wire [12:0]     _GEN_3;	// Scheduler.scala:222:24, :269:83, :271:26
  wire [12:0]     _GEN_4;	// Scheduler.scala:222:24, :269:83, :271:26
  wire [12:0]     _GEN_5;	// Scheduler.scala:222:24, :269:83, :271:26
  wire            request_ready;	// Scheduler.scala:250:40
  wire            _c_mshr_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _c_mshr_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _c_mshr_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _c_mshr_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _c_mshr_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _c_mshr_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _c_mshr_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _c_mshr_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _c_mshr_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _c_mshr_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _c_mshr_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _c_mshr_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _c_mshr_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _c_mshr_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _c_mshr_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _c_mshr_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _c_mshr_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _bc_mshr_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _bc_mshr_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _bc_mshr_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _bc_mshr_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _bc_mshr_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _bc_mshr_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _bc_mshr_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _bc_mshr_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _bc_mshr_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _bc_mshr_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _bc_mshr_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _bc_mshr_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _bc_mshr_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _bc_mshr_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_4_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_4_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_4_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_4_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_4_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _abc_mshrs_4_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_4_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_4_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_4_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_4_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _abc_mshrs_4_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_4_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_4_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _abc_mshrs_4_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_3_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_3_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_3_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_3_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_3_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _abc_mshrs_3_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_3_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_3_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_3_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_3_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _abc_mshrs_3_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_3_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_3_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _abc_mshrs_3_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_2_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_2_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_2_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_2_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_2_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _abc_mshrs_2_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_2_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_2_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_2_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_2_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _abc_mshrs_2_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_2_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_2_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _abc_mshrs_2_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_1_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_1_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_1_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_1_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_1_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _abc_mshrs_1_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_1_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_1_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_1_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_1_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _abc_mshrs_1_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_1_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_1_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _abc_mshrs_1_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_status_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_status_bits_set;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_0_io_status_bits_tag;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_status_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_status_bits_blockC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_status_bits_nestC;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_a_valid;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_0_io_schedule_bits_a_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_schedule_bits_a_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_a_bits_param;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_a_bits_block;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_b_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_b_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_0_io_schedule_bits_b_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_schedule_bits_b_bits_set;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_0_io_schedule_bits_b_bits_clients;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_c_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_c_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_c_bits_param;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_0_io_schedule_bits_c_bits_tag;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_schedule_bits_c_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_c_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_c_bits_dirty;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_d_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_d_bits_prio_0;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_d_bits_prio_2;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_d_bits_opcode;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_d_bits_param;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_d_bits_size;	// Scheduler.scala:69:46
  wire [6:0]      _abc_mshrs_0_io_schedule_bits_d_bits_source;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_0_io_schedule_bits_d_bits_offset;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_0_io_schedule_bits_d_bits_put;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_schedule_bits_d_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_d_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_d_bits_bad;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_e_valid;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_e_bits_sink;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_x_valid;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_dir_valid;	// Scheduler.scala:69:46
  wire [9:0]      _abc_mshrs_0_io_schedule_bits_dir_bits_set;	// Scheduler.scala:69:46
  wire [2:0]      _abc_mshrs_0_io_schedule_bits_dir_bits_way;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_dir_bits_data_dirty;	// Scheduler.scala:69:46
  wire [1:0]      _abc_mshrs_0_io_schedule_bits_dir_bits_data_state;	// Scheduler.scala:69:46
  wire [5:0]      _abc_mshrs_0_io_schedule_bits_dir_bits_data_clients;	// Scheduler.scala:69:46
  wire [12:0]     _abc_mshrs_0_io_schedule_bits_dir_bits_data_tag;	// Scheduler.scala:69:46
  wire            _abc_mshrs_0_io_schedule_bits_reload;	// Scheduler.scala:69:46
  wire            _requests_io_push_ready;	// Scheduler.scala:68:24
  wire [20:0]     _requests_io_valid;	// Scheduler.scala:68:24
  wire            _requests_io_data_prio_0;	// Scheduler.scala:68:24
  wire            _requests_io_data_prio_1;	// Scheduler.scala:68:24
  wire            _requests_io_data_prio_2;	// Scheduler.scala:68:24
  wire            _requests_io_data_control;	// Scheduler.scala:68:24
  wire [2:0]      _requests_io_data_opcode;	// Scheduler.scala:68:24
  wire [2:0]      _requests_io_data_param;	// Scheduler.scala:68:24
  wire [2:0]      _requests_io_data_size;	// Scheduler.scala:68:24
  wire [6:0]      _requests_io_data_source;	// Scheduler.scala:68:24
  wire [12:0]     _requests_io_data_tag;	// Scheduler.scala:68:24
  wire [5:0]      _requests_io_data_offset;	// Scheduler.scala:68:24
  wire [5:0]      _requests_io_data_put;	// Scheduler.scala:68:24
  wire            _bankedStore_io_sinkC_adr_ready;	// Scheduler.scala:67:27
  wire            _bankedStore_io_sinkD_adr_ready;	// Scheduler.scala:67:27
  wire            _bankedStore_io_sourceC_adr_ready;	// Scheduler.scala:67:27
  wire [63:0]     _bankedStore_io_sourceC_dat_data;	// Scheduler.scala:67:27
  wire            _bankedStore_io_sourceD_radr_ready;	// Scheduler.scala:67:27
  wire [63:0]     _bankedStore_io_sourceD_rdat_data;	// Scheduler.scala:67:27
  wire            _bankedStore_io_sourceD_wadr_ready;	// Scheduler.scala:67:27
  wire            _directory_io_write_ready;	// Scheduler.scala:66:25
  wire            _directory_io_result_bits_dirty;	// Scheduler.scala:66:25
  wire [1:0]      _directory_io_result_bits_state;	// Scheduler.scala:66:25
  wire [5:0]      _directory_io_result_bits_clients;	// Scheduler.scala:66:25
  wire [12:0]     _directory_io_result_bits_tag;	// Scheduler.scala:66:25
  wire            _directory_io_result_bits_hit;	// Scheduler.scala:66:25
  wire [2:0]      _directory_io_result_bits_way;	// Scheduler.scala:66:25
  wire            _directory_io_ready;	// Scheduler.scala:66:25
  wire            _sinkX_io_req_valid;	// Scheduler.scala:56:21
  wire [12:0]     _sinkX_io_req_bits_tag;	// Scheduler.scala:56:21
  wire [9:0]      _sinkX_io_req_bits_set;	// Scheduler.scala:56:21
  wire            _sinkD_io_resp_valid;	// Scheduler.scala:54:21
  wire            _sinkD_io_resp_bits_last;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_resp_bits_opcode;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_resp_bits_param;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_resp_bits_source;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_resp_bits_sink;	// Scheduler.scala:54:21
  wire            _sinkD_io_resp_bits_denied;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_source;	// Scheduler.scala:54:21
  wire            _sinkD_io_bs_adr_valid;	// Scheduler.scala:54:21
  wire            _sinkD_io_bs_adr_bits_noop;	// Scheduler.scala:54:21
  wire [2:0]      _sinkD_io_bs_adr_bits_beat;	// Scheduler.scala:54:21
  wire [63:0]     _sinkD_io_bs_dat_data;	// Scheduler.scala:54:21
  wire            _sinkC_io_req_valid;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_req_bits_opcode;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_req_bits_param;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_req_bits_size;	// Scheduler.scala:53:21
  wire [6:0]      _sinkC_io_req_bits_source;	// Scheduler.scala:53:21
  wire [12:0]     _sinkC_io_req_bits_tag;	// Scheduler.scala:53:21
  wire [5:0]      _sinkC_io_req_bits_offset;	// Scheduler.scala:53:21
  wire [5:0]      _sinkC_io_req_bits_put;	// Scheduler.scala:53:21
  wire [9:0]      _sinkC_io_req_bits_set;	// Scheduler.scala:53:21
  wire            _sinkC_io_resp_valid;	// Scheduler.scala:53:21
  wire            _sinkC_io_resp_bits_last;	// Scheduler.scala:53:21
  wire [9:0]      _sinkC_io_resp_bits_set;	// Scheduler.scala:53:21
  wire [12:0]     _sinkC_io_resp_bits_tag;	// Scheduler.scala:53:21
  wire [6:0]      _sinkC_io_resp_bits_source;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_resp_bits_param;	// Scheduler.scala:53:21
  wire            _sinkC_io_resp_bits_data;	// Scheduler.scala:53:21
  wire [9:0]      _sinkC_io_set;	// Scheduler.scala:53:21
  wire            _sinkC_io_bs_adr_valid;	// Scheduler.scala:53:21
  wire            _sinkC_io_bs_adr_bits_noop;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_bs_adr_bits_way;	// Scheduler.scala:53:21
  wire [9:0]      _sinkC_io_bs_adr_bits_set;	// Scheduler.scala:53:21
  wire [2:0]      _sinkC_io_bs_adr_bits_beat;	// Scheduler.scala:53:21
  wire            _sinkC_io_bs_adr_bits_mask;	// Scheduler.scala:53:21
  wire [63:0]     _sinkC_io_bs_dat_data;	// Scheduler.scala:53:21
  wire            _sinkC_io_rel_pop_ready;	// Scheduler.scala:53:21
  wire [63:0]     _sinkC_io_rel_beat_data;	// Scheduler.scala:53:21
  wire            _sinkC_io_rel_beat_corrupt;	// Scheduler.scala:53:21
  wire            _sinkA_io_req_valid;	// Scheduler.scala:52:21
  wire [12:0]     _sinkA_io_req_bits_tag;	// Scheduler.scala:52:21
  wire [5:0]      _sinkA_io_req_bits_offset;	// Scheduler.scala:52:21
  wire [5:0]      _sinkA_io_req_bits_put;	// Scheduler.scala:52:21
  wire [9:0]      _sinkA_io_req_bits_set;	// Scheduler.scala:52:21
  wire            _sinkA_io_pb_pop_ready;	// Scheduler.scala:52:21
  wire [63:0]     _sinkA_io_pb_beat_data;	// Scheduler.scala:52:21
  wire [7:0]      _sinkA_io_pb_beat_mask;	// Scheduler.scala:52:21
  wire            _sinkA_io_pb_beat_corrupt;	// Scheduler.scala:52:21
  wire            _sourceX_io_req_ready;	// Scheduler.scala:43:23
  wire            _sourceE_io_req_ready;	// Scheduler.scala:42:23
  wire            _sourceD_io_req_ready;	// Scheduler.scala:41:23
  wire            _sourceD_io_pb_pop_valid;	// Scheduler.scala:41:23
  wire [5:0]      _sourceD_io_pb_pop_bits_index;	// Scheduler.scala:41:23
  wire            _sourceD_io_pb_pop_bits_last;	// Scheduler.scala:41:23
  wire            _sourceD_io_rel_pop_valid;	// Scheduler.scala:41:23
  wire [5:0]      _sourceD_io_rel_pop_bits_index;	// Scheduler.scala:41:23
  wire            _sourceD_io_rel_pop_bits_last;	// Scheduler.scala:41:23
  wire            _sourceD_io_bs_radr_valid;	// Scheduler.scala:41:23
  wire [2:0]      _sourceD_io_bs_radr_bits_way;	// Scheduler.scala:41:23
  wire [9:0]      _sourceD_io_bs_radr_bits_set;	// Scheduler.scala:41:23
  wire [2:0]      _sourceD_io_bs_radr_bits_beat;	// Scheduler.scala:41:23
  wire            _sourceD_io_bs_radr_bits_mask;	// Scheduler.scala:41:23
  wire            _sourceD_io_bs_wadr_valid;	// Scheduler.scala:41:23
  wire [2:0]      _sourceD_io_bs_wadr_bits_way;	// Scheduler.scala:41:23
  wire [9:0]      _sourceD_io_bs_wadr_bits_set;	// Scheduler.scala:41:23
  wire [2:0]      _sourceD_io_bs_wadr_bits_beat;	// Scheduler.scala:41:23
  wire            _sourceD_io_bs_wadr_bits_mask;	// Scheduler.scala:41:23
  wire [63:0]     _sourceD_io_bs_wdat_data;	// Scheduler.scala:41:23
  wire            _sourceD_io_evict_safe;	// Scheduler.scala:41:23
  wire            _sourceD_io_grant_safe;	// Scheduler.scala:41:23
  wire            _sourceC_io_req_ready;	// Scheduler.scala:40:23
  wire            _sourceC_io_bs_adr_valid;	// Scheduler.scala:40:23
  wire [2:0]      _sourceC_io_bs_adr_bits_way;	// Scheduler.scala:40:23
  wire [9:0]      _sourceC_io_bs_adr_bits_set;	// Scheduler.scala:40:23
  wire [2:0]      _sourceC_io_bs_adr_bits_beat;	// Scheduler.scala:40:23
  wire [9:0]      _sourceC_io_evict_req_set;	// Scheduler.scala:40:23
  wire [2:0]      _sourceC_io_evict_req_way;	// Scheduler.scala:40:23
  wire            _sourceB_io_req_ready;	// Scheduler.scala:39:23
  wire            _sourceA_io_req_ready;	// Scheduler.scala:38:23
  wire            mshr_request_lo_lo =
    _abc_mshrs_0_io_schedule_valid
    & ~(_bc_mshr_io_status_valid
        & _abc_mshrs_0_io_status_bits_set == _bc_mshr_io_status_bits_set
        | _c_mshr_io_status_valid
        & _abc_mshrs_0_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_abc_mshrs_0_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_abc_mshrs_0_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :88:{30,54,86}, :89:{30,54}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_lo_hi_lo =
    _abc_mshrs_1_io_schedule_valid
    & ~(_bc_mshr_io_status_valid
        & _abc_mshrs_1_io_status_bits_set == _bc_mshr_io_status_bits_set
        | _c_mshr_io_status_valid
        & _abc_mshrs_1_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_abc_mshrs_1_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_abc_mshrs_1_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :88:{30,54,86}, :89:{30,54}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_lo_hi_hi =
    _abc_mshrs_2_io_schedule_valid
    & ~(_bc_mshr_io_status_valid
        & _abc_mshrs_2_io_status_bits_set == _bc_mshr_io_status_bits_set
        | _c_mshr_io_status_valid
        & _abc_mshrs_2_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_abc_mshrs_2_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_abc_mshrs_2_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :88:{30,54,86}, :89:{30,54}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_hi_lo_lo =
    _abc_mshrs_3_io_schedule_valid
    & ~(_bc_mshr_io_status_valid
        & _abc_mshrs_3_io_status_bits_set == _bc_mshr_io_status_bits_set
        | _c_mshr_io_status_valid
        & _abc_mshrs_3_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_abc_mshrs_3_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_abc_mshrs_3_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :88:{30,54,86}, :89:{30,54}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_hi_lo_hi =
    _abc_mshrs_4_io_schedule_valid
    & ~(_bc_mshr_io_status_valid
        & _abc_mshrs_4_io_status_bits_set == _bc_mshr_io_status_bits_set
        | _c_mshr_io_status_valid
        & _abc_mshrs_4_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_abc_mshrs_4_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_abc_mshrs_4_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :88:{30,54,86}, :89:{30,54}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_hi_hi_lo =
    _bc_mshr_io_schedule_valid
    & ~(_c_mshr_io_status_valid
        & _bc_mshr_io_status_bits_set == _c_mshr_io_status_bits_set)
    & (_sourceA_io_req_ready | ~_bc_mshr_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_bc_mshr_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_bc_mshr_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_bc_mshr_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_bc_mshr_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_bc_mshr_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_bc_mshr_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :92:{28,58}, :105:28, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire            mshr_request_hi_hi_hi =
    _c_mshr_io_schedule_valid
    & (_sourceA_io_req_ready | ~_c_mshr_io_schedule_bits_a_valid)
    & (_sourceB_io_req_ready | ~_c_mshr_io_schedule_bits_b_valid)
    & (_sourceC_io_req_ready | ~_c_mshr_io_schedule_bits_c_valid)
    & (_sourceD_io_req_ready | ~_c_mshr_io_schedule_bits_d_valid)
    & (_sourceE_io_req_ready | ~_c_mshr_io_schedule_bits_e_valid)
    & (_sourceX_io_req_ready | ~_c_mshr_io_schedule_bits_x_valid)
    & (_directory_io_write_ready | ~_c_mshr_io_schedule_bits_dir_valid);	// Scheduler.scala:38:23, :39:23, :40:23, :41:23, :42:23, :43:23, :66:25, :69:46, :106:{29,32}, :107:{29,32}, :108:{29,32}, :109:{29,32}, :110:{29,32}, :111:{29,32,61}, :112:{33,36}
  wire [6:0]      mshr_request =
    {mshr_request_hi_hi_hi,
     mshr_request_hi_hi_lo,
     mshr_request_hi_lo_hi,
     mshr_request_hi_lo_lo,
     mshr_request_lo_hi_hi,
     mshr_request_lo_hi_lo,
     mshr_request_lo_lo};	// Cat.scala:30:58, Scheduler.scala:111:61
  reg  [6:0]      robin_filter;	// Scheduler.scala:116:29
  wire [6:0]      robin_request_lo = mshr_request & robin_filter;	// Cat.scala:30:58, Scheduler.scala:116:29, :117:54
  wire            _GEN_6 = mshr_request_hi_lo_lo | mshr_request_lo_hi_hi;	// Scheduler.scala:111:61, package.scala:244:43
  wire            _GEN_7 = mshr_request_lo_hi_hi | mshr_request_lo_hi_lo;	// Scheduler.scala:111:61, package.scala:244:43
  wire            _GEN_8 = mshr_request_lo_hi_lo | mshr_request_lo_lo;	// Scheduler.scala:111:61, package.scala:244:43
  wire            _GEN_9 = mshr_request_lo_lo | robin_request_lo[6];	// Scheduler.scala:111:61, :117:54, package.scala:244:43
  wire [5:0]      _GEN_10 = robin_request_lo[6:1] | robin_request_lo[5:0];	// Scheduler.scala:117:54, package.scala:244:43
  wire            _GEN_11 = _GEN_8 | _GEN_10[5];	// package.scala:244:43
  wire            _GEN_12 = _GEN_9 | _GEN_10[4];	// package.scala:244:43
  wire [3:0]      _GEN_13 = _GEN_10[5:2] | _GEN_10[3:0];	// package.scala:244:43
  wire            _GEN_14 = _GEN_10[1] | robin_request_lo[0];	// Scheduler.scala:117:54, package.scala:244:43
  wire            _GEN_15 = _GEN_13[1] | robin_request_lo[0];	// Scheduler.scala:117:54, package.scala:244:43
  wire [13:0]     _GEN_16 =
    {~(mshr_request_hi_hi_lo | mshr_request_hi_lo_hi | _GEN_6 | _GEN_11 | _GEN_15),
     ~(mshr_request_hi_lo_hi | mshr_request_hi_lo_lo | _GEN_7 | _GEN_12 | _GEN_13[0]),
     ~(_GEN_6 | _GEN_8 | _GEN_13[3] | _GEN_14),
     ~(_GEN_7 | _GEN_9 | _GEN_13[2] | _GEN_10[0]),
     ~(_GEN_11 | _GEN_13[1] | robin_request_lo[0]),
     ~(_GEN_12 | _GEN_13[0]),
     ~(_GEN_13[3] | _GEN_14),
     ~(_GEN_13[2] | _GEN_10[0]),
     ~_GEN_15,
     ~(_GEN_13[0]),
     ~_GEN_14,
     ~(_GEN_10[0]),
     ~(robin_request_lo[0]),
     1'h1}
    & {mshr_request_hi_hi_hi,
       mshr_request_hi_hi_lo,
       mshr_request_hi_lo_hi,
       mshr_request_hi_lo_lo,
       mshr_request_lo_hi_hi,
       mshr_request_lo_hi_lo,
       mshr_request_lo_lo,
       robin_request_lo};	// Cat.scala:30:58, Scheduler.scala:111:61, :117:54, :118:{24,54}, package.scala:244:43
  wire [6:0]      mshr_selectOH = _GEN_16[13:7] | _GEN_16[6:0];	// Scheduler.scala:118:54, :119:{37,70,86}
  wire [2:0]      _mshr_select_T = {1'h0, mshr_selectOH[6:5]} | mshr_selectOH[3:1];	// OneHot.scala:31:18, :32:28, Scheduler.scala:119:70
  wire [2:0]      schedule_d_bits_sink =
    {|(mshr_selectOH[6:4]),
     |(_mshr_select_T[2:1]),
     _mshr_select_T[2] | _mshr_select_T[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, Scheduler.scala:119:70
  wire            _schedule_WIRE =
    mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_reload | mshr_selectOH[1]
    & _abc_mshrs_1_io_schedule_bits_reload | mshr_selectOH[2]
    & _abc_mshrs_2_io_schedule_bits_reload | mshr_selectOH[3]
    & _abc_mshrs_3_io_schedule_bits_reload | mshr_selectOH[4]
    & _abc_mshrs_4_io_schedule_bits_reload | mshr_selectOH[5]
    & _bc_mshr_io_schedule_bits_reload | mshr_selectOH[6]
    & _c_mshr_io_schedule_bits_reload;	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
  wire [2:0]      _schedule_WIRE_46 =
    (mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_c_bits_opcode : 3'h0)
    | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_c_bits_opcode : 3'h0);	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
  wire [12:0]     scheduleTag =
    (mshr_selectOH[0] ? _abc_mshrs_0_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[1] ? _abc_mshrs_1_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[2] ? _abc_mshrs_2_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[3] ? _abc_mshrs_3_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[4] ? _abc_mshrs_4_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[5] ? _bc_mshr_io_status_bits_tag : 13'h0)
    | (mshr_selectOH[6] ? _c_mshr_io_status_bits_tag : 13'h0);	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
  wire [9:0]      nestedwb_set =
    mshr_selectOH[6] ? _c_mshr_io_status_bits_set : _bc_mshr_io_status_bits_set;	// Mux.scala:29:36, Scheduler.scala:69:46, :119:70, :144:24
  wire [12:0]     nestedwb_tag =
    mshr_selectOH[6] ? _c_mshr_io_status_bits_tag : _bc_mshr_io_status_bits_tag;	// Mux.scala:29:36, Scheduler.scala:69:46, :119:70, :145:24
  wire            nestedwb_b_clr_dirty =
    mshr_selectOH[5] & _bc_mshr_io_schedule_bits_dir_valid;	// Mux.scala:29:36, Scheduler.scala:69:46, :119:70, :146:37
  wire            nestedwb_b_toN =
    nestedwb_b_clr_dirty & _bc_mshr_io_schedule_bits_dir_bits_data_state == 2'h0;	// Scheduler.scala:69:46, :146:{37,75,123}
  wire            nestedwb_b_toB =
    nestedwb_b_clr_dirty & _bc_mshr_io_schedule_bits_dir_bits_data_state == 2'h1;	// Scheduler.scala:69:46, :146:37, :147:{75,123}
  wire            nestedwb_c_set_dirty =
    mshr_selectOH[6] & _c_mshr_io_schedule_bits_dir_valid
    & _c_mshr_io_schedule_bits_dir_bits_data_dirty;	// Mux.scala:29:36, Scheduler.scala:69:46, :119:70, :149:75
  wire            request_valid =
    _directory_io_ready
    & (_sinkA_io_req_valid | _sinkX_io_req_valid | _sinkC_io_req_valid);	// Scheduler.scala:52:21, :53:21, :56:21, :66:25, :153:{39,84}
  wire            _mshrs_6_io_allocate_bits_WIRE_control =
    ~_sinkC_io_req_valid & _sinkX_io_req_valid;	// Scheduler.scala:53:21, :56:21, :154:22
  wire [2:0]      _mshrs_6_io_allocate_bits_WIRE_opcode =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_opcode
      : _sinkX_io_req_valid ? 3'h0 : io_in_a_bits_opcode;	// Scheduler.scala:53:21, :56:21, :69:46, :154:22, :155:22
  wire [2:0]      _mshrs_6_io_allocate_bits_WIRE_param =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_param
      : _sinkX_io_req_valid ? 3'h0 : io_in_a_bits_param;	// Scheduler.scala:53:21, :56:21, :69:46, :154:22, :155:22
  wire [2:0]      _mshrs_6_io_allocate_bits_WIRE_size =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_size
      : _sinkX_io_req_valid ? 3'h6 : io_in_a_bits_size;	// Scheduler.scala:39:23, :53:21, :56:21, :154:22, :155:22
  wire [6:0]      _mshrs_6_io_allocate_bits_WIRE_source =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_source
      : _sinkX_io_req_valid ? 7'h0 : io_in_a_bits_source;	// Scheduler.scala:53:21, :56:21, :154:22, :155:22
  wire [12:0]     _mshrs_6_io_allocate_bits_WIRE_tag =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_tag
      : _sinkX_io_req_valid ? _sinkX_io_req_bits_tag : _sinkA_io_req_bits_tag;	// Scheduler.scala:52:21, :53:21, :56:21, :154:22, :155:22
  wire [5:0]      _mshrs_6_io_allocate_bits_WIRE_offset =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_offset
      : _sinkX_io_req_valid ? 6'h0 : _sinkA_io_req_bits_offset;	// Scheduler.scala:52:21, :53:21, :56:21, :154:22, :155:22
  wire [5:0]      _mshrs_6_io_allocate_bits_WIRE_put =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_put
      : _sinkX_io_req_valid ? 6'h0 : _sinkA_io_req_bits_put;	// Scheduler.scala:52:21, :53:21, :56:21, :154:22, :155:22
  wire [9:0]      request_bits_set =
    _sinkC_io_req_valid
      ? _sinkC_io_req_bits_set
      : _sinkX_io_req_valid ? _sinkX_io_req_bits_set : _sinkA_io_req_bits_set;	// Scheduler.scala:52:21, :53:21, :56:21, :154:22, :155:22
  wire            _sinkA_io_req_ready_T = _directory_io_ready & request_ready;	// Scheduler.scala:66:25, :156:44, :250:40
  wire            setMatches_lo_lo =
    _abc_mshrs_0_io_status_valid & _abc_mshrs_0_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_lo_hi_lo =
    _abc_mshrs_1_io_status_valid & _abc_mshrs_1_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_lo_hi_hi =
    _abc_mshrs_2_io_status_valid & _abc_mshrs_2_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_hi_lo_lo =
    _abc_mshrs_3_io_status_valid & _abc_mshrs_3_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_hi_lo_hi =
    _abc_mshrs_4_io_status_valid & _abc_mshrs_4_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_hi_hi_lo =
    _bc_mshr_io_status_valid & _bc_mshr_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire            setMatches_hi_hi_hi =
    _c_mshr_io_status_valid & _c_mshr_io_status_bits_set == request_bits_set;	// Scheduler.scala:69:46, :154:22, :161:{59,83}
  wire [6:0]      setMatches =
    {setMatches_hi_hi_hi,
     setMatches_hi_hi_lo,
     setMatches_hi_lo_hi,
     setMatches_hi_lo_lo,
     setMatches_lo_hi_hi,
     setMatches_lo_hi_lo,
     setMatches_lo_lo};	// Cat.scala:30:58, Scheduler.scala:161:59
  wire            alloc = setMatches == 7'h0;	// Cat.scala:30:58, Scheduler.scala:56:21, :162:30
  wire            nestC =
    (setMatches_lo_lo & _abc_mshrs_0_io_status_bits_nestC | setMatches_lo_hi_lo
     & _abc_mshrs_1_io_status_bits_nestC | setMatches_lo_hi_hi
     & _abc_mshrs_2_io_status_bits_nestC | setMatches_hi_lo_lo
     & _abc_mshrs_3_io_status_bits_nestC | setMatches_hi_lo_hi
     & _abc_mshrs_4_io_status_bits_nestC | setMatches_hi_hi_lo
     & _bc_mshr_io_status_bits_nestC | setMatches_hi_hi_hi & _c_mshr_io_status_bits_nestC)
    & _sinkC_io_req_valid;	// Mux.scala:27:72, Scheduler.scala:53:21, :69:46, :161:59, :169:70
  wire [6:0]      prioFilter = {{2{_sinkC_io_req_valid}}, 5'h1F};	// Cat.scala:30:58, Scheduler.scala:53:21, :171:69
  wire [6:0]      lowerMatches = setMatches & prioFilter;	// Cat.scala:30:58, Scheduler.scala:172:33
  wire            queue =
    (|lowerMatches) & ~nestC
    & ~((setMatches_lo_lo & _abc_mshrs_0_io_status_bits_blockC | setMatches_lo_hi_lo
         & _abc_mshrs_1_io_status_bits_blockC | setMatches_lo_hi_hi
         & _abc_mshrs_2_io_status_bits_blockC | setMatches_hi_lo_lo
         & _abc_mshrs_3_io_status_bits_blockC | setMatches_hi_lo_hi
         & _abc_mshrs_4_io_status_bits_blockC | setMatches_hi_hi_lo
         & _bc_mshr_io_status_bits_blockC | setMatches_hi_hi_hi
         & _c_mshr_io_status_bits_blockC) & _sinkC_io_req_valid);	// Mux.scala:27:72, Scheduler.scala:53:21, :69:46, :161:59, :165:70, :169:70, :172:33, :174:{31,47,65,68}
  wire            _requests_io_push_valid_T = request_valid & queue;	// Scheduler.scala:153:39, :174:65, :184:31
  wire [6:0]      lowerMatches1 =
    setMatches_hi_hi_hi & _sinkC_io_req_valid
      ? 7'h40
      : setMatches_hi_hi_lo & _sinkC_io_req_valid ? 7'h20 : lowerMatches;	// Scheduler.scala:53:21, :161:59, :172:33, :189:{8,21}, :190:{8,21}
  wire [6:0]      _a_pop_T = mshr_selectOH & _requests_io_valid[6:0];	// Scheduler.scala:68:24, :119:70, :195:76, :196:32
  wire [6:0]      _b_pop_T = mshr_selectOH & _requests_io_valid[13:7];	// Scheduler.scala:68:24, :119:70, :195:76, :197:32
  wire [6:0]      _c_pop_T = mshr_selectOH & _requests_io_valid[20:14];	// Scheduler.scala:68:24, :119:70, :195:76, :198:32
  wire            bypassMatches =
    (|(mshr_selectOH & lowerMatches1))
    & ((|_c_pop_T) | _sinkC_io_req_valid
         ? ~(|_c_pop_T)
         : (|_b_pop_T) ? ~(|_b_pop_T) : ~(|_a_pop_T));	// Scheduler.scala:53:21, :119:70, :189:8, :195:76, :196:{32,82}, :197:{32,82}, :198:{32,82}, :199:{38,58,61}, :200:{26,33,58,69,101,109}
  wire            may_pop = (|_a_pop_T) | (|_b_pop_T) | (|_c_pop_T);	// Scheduler.scala:195:76, :196:{32,82}, :197:{32,82}, :198:{32,82}, :201:32
  wire            bypass = _requests_io_push_valid_T & bypassMatches;	// Scheduler.scala:184:31, :199:61, :202:39
  wire            _mshr_uses_directory_assuming_no_bypass_T = _schedule_WIRE & may_pop;	// Mux.scala:27:72, Scheduler.scala:201:32, :204:34
  wire            will_pop = _mshr_uses_directory_assuming_no_bypass_T & ~bypass;	// Scheduler.scala:202:39, :204:{34,45,48}
  wire            bypass_1 =
    _requests_io_push_valid_T & lowerMatches1[0]
    & (_requests_io_valid[14] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[14])
         : _requests_io_valid[7] ? ~(_requests_io_valid[7]) : ~(_requests_io_valid[0]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_2 =
    _requests_io_push_valid_T & lowerMatches1[1]
    & (_requests_io_valid[15] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[15])
         : _requests_io_valid[8] ? ~(_requests_io_valid[8]) : ~(_requests_io_valid[1]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_3 =
    _requests_io_push_valid_T & lowerMatches1[2]
    & (_requests_io_valid[16] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[16])
         : _requests_io_valid[9] ? ~(_requests_io_valid[9]) : ~(_requests_io_valid[2]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_4 =
    _requests_io_push_valid_T & lowerMatches1[3]
    & (_requests_io_valid[17] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[17])
         : _requests_io_valid[10] ? ~(_requests_io_valid[10]) : ~(_requests_io_valid[3]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_5 =
    _requests_io_push_valid_T & lowerMatches1[4]
    & (_requests_io_valid[18] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[18])
         : _requests_io_valid[11] ? ~(_requests_io_valid[11]) : ~(_requests_io_valid[4]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_6 =
    _requests_io_push_valid_T & lowerMatches1[5]
    & (_requests_io_valid[19] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[19])
         : _requests_io_valid[12] ? ~(_requests_io_valid[12]) : ~(_requests_io_valid[5]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire            bypass_7 =
    _requests_io_push_valid_T & lowerMatches1[6]
    & (_requests_io_valid[20] | _sinkC_io_req_valid
         ? ~(_requests_io_valid[20])
         : _requests_io_valid[13] ? ~(_requests_io_valid[13]) : ~(_requests_io_valid[6]));	// Scheduler.scala:53:21, :68:24, :184:31, :189:8, :214:34, :215:34, :216:34, :217:38, :218:{28,35,60,71,103,111}, :220:41
  wire [19:0]     _prio_requests_T = ~(_requests_io_valid[20:1]);	// Scheduler.scala:68:24, :229:25
  wire [12:0]     _GEN_17 = _prio_requests_T[12:0] | _requests_io_valid[20:8];	// Scheduler.scala:68:24, :229:{25,44,65}
  wire [19:0]     prio_requests =
    ~{_prio_requests_T[19:13], _GEN_17[12:6], _GEN_17[5:0] | _requests_io_valid[20:15]};	// Scheduler.scala:68:24, :229:{23,25,44,82,103}
  wire [20:0]     _pop_index_T = {3{mshr_selectOH}};	// Cat.scala:30:58, Scheduler.scala:119:70
  wire [4:0]      pop_index_hi_1 = mshr_selectOH[6:2] & prio_requests[19:15];	// OneHot.scala:30:18, Scheduler.scala:119:70, :229:23, :230:77
  wire [14:0]     _pop_index_T_2 =
    {11'h0, pop_index_hi_1[4:1]} | _pop_index_T[15:1] & prio_requests[14:0];	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:28, Scheduler.scala:229:23, :230:77
  wire [6:0]      _pop_index_T_3 = _pop_index_T_2[14:8] | _pop_index_T_2[6:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [2:0]      _pop_index_T_4 = _pop_index_T_3[6:4] | _pop_index_T_3[2:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire            lb_tag_mismatch = scheduleTag != _requests_io_data_tag;	// Mux.scala:27:72, Scheduler.scala:68:24, :235:37
  wire            mshr_uses_directory_assuming_no_bypass =
    _mshr_uses_directory_assuming_no_bypass_T & lb_tag_mismatch;	// Scheduler.scala:204:34, :235:37, :236:75
  wire            mshr_uses_directory_for_lb = will_pop & lb_tag_mismatch;	// Scheduler.scala:204:45, :235:37, :237:45
  wire            mshr_uses_directory =
    _schedule_WIRE & (may_pop | bypass)
    & scheduleTag != (bypass
                        ? _mshrs_6_io_allocate_bits_WIRE_tag
                        : _requests_io_data_tag);	// Mux.scala:27:72, Scheduler.scala:68:24, :154:22, :201:32, :202:39, :203:49, :238:{41,56,63}
  wire [6:0]      _mshr_insertOH_T_13 =
    ~{_c_mshr_io_status_valid,
      _bc_mshr_io_status_valid,
      _abc_mshrs_4_io_status_valid,
      _abc_mshrs_3_io_status_valid,
      _abc_mshrs_2_io_status_valid,
      _abc_mshrs_1_io_status_valid,
      _abc_mshrs_0_io_status_valid};	// Cat.scala:30:58, Scheduler.scala:69:46, :242:20
  wire            bypassQueue = _schedule_WIRE & bypassMatches;	// Mux.scala:27:72, Scheduler.scala:199:61, :245:37
  wire            request_alloc_cases =
    alloc & ~mshr_uses_directory_assuming_no_bypass
    & (|(_mshr_insertOH_T_13 & prioFilter)) | nestC
    & ~mshr_uses_directory_assuming_no_bypass & ~_c_mshr_io_status_valid;	// Cat.scala:30:58, Scheduler.scala:69:46, :162:30, :169:70, :236:75, :242:{20,34,51}, :247:{16,56}, :248:{87,112}, :249:56
  assign request_ready =
    request_alloc_cases | queue & (bypassQueue | _requests_io_push_ready);	// Scheduler.scala:68:24, :174:65, :245:37, :248:112, :250:{40,50,66}
  wire            alloc_uses_directory = request_valid & request_alloc_cases;	// Scheduler.scala:153:39, :248:112, :251:44
  wire [2:0]      _requests_io_push_bits_index_T_1 =
    {1'h0, lowerMatches1[6:5]} | lowerMatches1[3:1];	// OneHot.scala:31:18, :32:28, Scheduler.scala:189:8
  wire [2:0]      _requests_io_push_bits_index_T_12 =
    {lowerMatches1[1:0], 1'h0} | lowerMatches1[5:3];	// OneHot.scala:30:18, :31:18, :32:28, Scheduler.scala:189:8
  wire [5:0]      _mshr_insertOH_T_3 =
    _mshr_insertOH_T_13[5:0] | {_mshr_insertOH_T_13[4:0], 1'h0};	// Scheduler.scala:242:20, package.scala:244:{43,53}
  wire [5:0]      _mshr_insertOH_T_6 =
    _mshr_insertOH_T_3 | {_mshr_insertOH_T_3[3:0], 2'h0};	// Scheduler.scala:146:123, package.scala:244:{43,53}
  wire [6:0]      _GEN_18 =
    {~(_mshr_insertOH_T_6 | {_mshr_insertOH_T_6[1:0], 4'h0}), 1'h1} & _mshr_insertOH_T_13
    & prioFilter;	// Cat.scala:30:58, Scheduler.scala:242:20, :267:{23,53,69}, package.scala:244:{43,48,53}
  wire            _GEN_19 = request_valid & alloc;	// Scheduler.scala:153:39, :162:30, :269:25
  wire            _GEN_20 =
    _GEN_19 & _GEN_18[0] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_21 = _GEN_20 | bypass_1;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26
  assign _GEN_5 = _GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
  wire            _GEN_22 =
    _GEN_19 & _GEN_18[1] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_23 = _GEN_22 | bypass_2;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26
  assign _GEN_4 = _GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
  wire            _GEN_24 =
    _GEN_19 & _GEN_18[2] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_25 = _GEN_24 | bypass_3;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26
  assign _GEN_3 = _GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
  wire            _GEN_26 =
    _GEN_19 & _GEN_18[3] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_27 = _GEN_26 | bypass_4;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26
  assign _GEN_2 = _GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
  wire            _GEN_28 =
    _GEN_19 & _GEN_18[4] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_29 = _GEN_28 | bypass_5;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26
  assign _GEN_1 = _GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
  wire            _GEN_30 =
    _GEN_19 & _GEN_18[5] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:236:75, :247:16, :267:69, :268:18, :269:{25,39}
  wire            _GEN_31 = _GEN_30 | bypass_6;	// Scheduler.scala:220:41, :222:24, :269:{39,83}, :271:26, :276:131, :278:30
  assign _GEN_0 = _GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
  wire            _GEN_32 =
    request_valid & nestC & ~_c_mshr_io_status_valid
    & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:69:46, :153:39, :169:70, :236:75, :247:16, :248:87, :284:59
  wire            _GEN_33 =
    _GEN_32 | _GEN_19 & _GEN_18[6] & ~mshr_uses_directory_assuming_no_bypass;	// Scheduler.scala:225:25, :236:75, :247:16, :267:69, :268:18, :269:{25,39,83}, :270:27, :284:{59,103}, :285:30
  wire            _GEN_34 = _GEN_33 | bypass_7;	// Scheduler.scala:220:41, :222:24, :225:25, :269:83, :270:27, :271:26, :284:103, :285:30, :286:29
  assign _GEN = _GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_tag : _requests_io_data_tag;	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
  `ifndef SYNTHESIS	// Scheduler.scala:288:12
    always @(posedge clock) begin	// Scheduler.scala:288:12
      if (_GEN_32 & ~(_sinkC_io_req_valid | reset)) begin	// Scheduler.scala:53:21, :284:59, :288:12
        if (`ASSERT_VERBOSE_COND_)	// Scheduler.scala:288:12
          $error("Assertion failed\n    at Scheduler.scala:288 assert (!request.bits.prio(0))\n");	// Scheduler.scala:288:12
        if (`STOP_COND_)	// Scheduler.scala:288:12
          $fatal;	// Scheduler.scala:288:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg  [7:0]      directoryFanout;	// Scheduler.scala:296:46
  wire [7:0][2:0] _GEN_35 =
    {{_abc_mshrs_0_io_status_bits_way},
     {_c_mshr_io_status_bits_way},
     {_bc_mshr_io_status_bits_way},
     {_abc_mshrs_4_io_status_bits_way},
     {_abc_mshrs_3_io_status_bits_way},
     {_abc_mshrs_2_io_status_bits_way},
     {_abc_mshrs_1_io_status_bits_way},
     {_abc_mshrs_0_io_status_bits_way}};	// Scheduler.scala:69:46, :308:16
  wire [2:0]      _GEN_36 = _GEN_35[_sinkD_io_source];	// Scheduler.scala:54:21, :308:16
  wire [7:0][9:0] _GEN_37 =
    {{_abc_mshrs_0_io_status_bits_set},
     {_c_mshr_io_status_bits_set},
     {_bc_mshr_io_status_bits_set},
     {_abc_mshrs_4_io_status_bits_set},
     {_abc_mshrs_3_io_status_bits_set},
     {_abc_mshrs_2_io_status_bits_set},
     {_abc_mshrs_1_io_status_bits_set},
     {_abc_mshrs_0_io_status_bits_set}};	// Scheduler.scala:69:46, :309:16
  wire [9:0]      _GEN_38 = _GEN_37[_sinkD_io_source];	// Scheduler.scala:54:21, :309:16
  always @(posedge clock) begin
    if (reset)
      robin_filter <= 7'h0;	// Scheduler.scala:56:21, :116:29
    else if (|mshr_request) begin	// Cat.scala:30:58, Scheduler.scala:126:25
      automatic logic [5:0] _GEN_39 = mshr_selectOH[5:0] | mshr_selectOH[6:1];	// Scheduler.scala:119:70, package.scala:253:{43,48}
      automatic logic [4:0] _GEN_40 = _GEN_39[4:0] | {mshr_selectOH[6], _GEN_39[5:2]};	// Scheduler.scala:119:70, package.scala:253:{43,48}
      robin_filter <=
        ~{mshr_selectOH[6],
          _GEN_39[5],
          _GEN_40[4:3],
          _GEN_40[2:0] | {mshr_selectOH[6], _GEN_39[5], _GEN_40[4]}};	// Scheduler.scala:116:29, :119:70, :126:47, package.scala:253:{43,48}
    end
    if (mshr_uses_directory)	// Scheduler.scala:238:41
      directoryFanout <= {1'h0, mshr_selectOH};	// Scheduler.scala:119:70, :296:{46,50}
    else if (alloc_uses_directory) begin	// Scheduler.scala:251:44
      if (alloc)	// Scheduler.scala:162:30
        directoryFanout <= {1'h0, _GEN_18};	// Scheduler.scala:267:69, :296:46
      else	// Scheduler.scala:162:30
        directoryFanout <= 8'h40;	// Scheduler.scala:295:22, :296:46
    end
    else	// Scheduler.scala:251:44
      directoryFanout <= 8'h0;	// Scheduler.scala:296:{46,90}
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
        robin_filter = _RANDOM[/*Zero width*/ 1'b0][6:0];	// Scheduler.scala:116:29
        directoryFanout = _RANDOM[/*Zero width*/ 1'b0][14:7];	// Scheduler.scala:116:29, :296:46
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  SourceA sourceA (	// Scheduler.scala:38:23
    .clock              (clock),
    .reset              (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_a_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_a_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_a_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_a_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_a_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_a_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_a_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_tag
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_a_bits_tag : 13'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_a_bits_tag : 13'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_set
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_a_bits_set : 10'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_a_bits_set : 10'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_param
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_a_bits_param : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_a_bits_param : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_source (schedule_d_bits_sink),	// Cat.scala:30:58
    .io_req_bits_block
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_a_bits_block | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_a_bits_block | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_a_bits_block | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_a_bits_block | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_a_bits_block | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_a_bits_block | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_a_bits_block),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_a_ready         (io_out_a_ready),
    .io_req_ready       (_sourceA_io_req_ready),
    .io_a_valid         (io_out_a_valid),
    .io_a_bits_opcode   (io_out_a_bits_opcode),
    .io_a_bits_param    (io_out_a_bits_param),
    .io_a_bits_size     (io_out_a_bits_size),
    .io_a_bits_source   (io_out_a_bits_source),
    .io_a_bits_address  (io_out_a_bits_address),
    .io_a_bits_mask     (io_out_a_bits_mask),
    .io_a_bits_data     (io_out_a_bits_data),
    .io_a_bits_corrupt  (io_out_a_bits_corrupt)
  );
  SourceB sourceB (	// Scheduler.scala:39:23
    .clock               (clock),
    .reset               (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_b_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_b_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_b_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_b_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_b_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_b_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_b_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_param
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_b_bits_param : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_b_bits_param : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_tag
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_b_bits_tag : 13'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_b_bits_tag : 13'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_set
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_b_bits_set : 10'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_b_bits_set : 10'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_clients
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_b_bits_clients : 6'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_b_bits_clients : 6'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_b_ready          (io_in_b_ready),
    .io_req_ready        (_sourceB_io_req_ready),
    .io_b_valid          (io_in_b_valid),
    .io_b_bits_param     (io_in_b_bits_param),
    .io_b_bits_source    (io_in_b_bits_source),
    .io_b_bits_address   (io_in_b_bits_address)
  );
  SourceC sourceC (	// Scheduler.scala:40:23
    .clock               (clock),
    .reset               (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_c_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_c_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_c_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_c_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_c_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_c_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_c_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_opcode  (_schedule_WIRE_46),	// Mux.scala:27:72
    .io_req_bits_param
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_c_bits_param : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_c_bits_param : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_source  (_schedule_WIRE_46[1] ? schedule_d_bits_sink : 3'h0),	// Cat.scala:30:58, Mux.scala:27:72, Scheduler.scala:56:21, :69:46, :130:{32,55}
    .io_req_bits_tag
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_c_bits_tag : 13'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_c_bits_tag : 13'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_set
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_c_bits_set : 10'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_c_bits_set : 10'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_way
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_c_bits_way : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_c_bits_way : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_dirty
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_c_bits_dirty | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_c_bits_dirty | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_c_bits_dirty | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_c_bits_dirty | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_c_bits_dirty | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_c_bits_dirty | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_c_bits_dirty),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_c_ready          (io_out_c_ready),
    .io_bs_adr_ready     (_bankedStore_io_sourceC_adr_ready),	// Scheduler.scala:67:27
    .io_bs_dat_data      (_bankedStore_io_sourceC_dat_data),	// Scheduler.scala:67:27
    .io_evict_safe       (_sourceD_io_evict_safe),	// Scheduler.scala:41:23
    .io_req_ready        (_sourceC_io_req_ready),
    .io_c_valid          (io_out_c_valid),
    .io_c_bits_opcode    (io_out_c_bits_opcode),
    .io_c_bits_param     (io_out_c_bits_param),
    .io_c_bits_size      (io_out_c_bits_size),
    .io_c_bits_source    (io_out_c_bits_source),
    .io_c_bits_address   (io_out_c_bits_address),
    .io_c_bits_data      (io_out_c_bits_data),
    .io_c_bits_corrupt   (io_out_c_bits_corrupt),
    .io_bs_adr_valid     (_sourceC_io_bs_adr_valid),
    .io_bs_adr_bits_way  (_sourceC_io_bs_adr_bits_way),
    .io_bs_adr_bits_set  (_sourceC_io_bs_adr_bits_set),
    .io_bs_adr_bits_beat (_sourceC_io_bs_adr_bits_beat),
    .io_evict_req_set    (_sourceC_io_evict_req_set),
    .io_evict_req_way    (_sourceC_io_evict_req_way)
  );
  SourceD sourceD (	// Scheduler.scala:41:23
    .clock                 (clock),
    .reset                 (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_d_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_d_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_d_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_d_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_d_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_d_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_d_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_prio_0
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_d_bits_prio_0 | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_d_bits_prio_0),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_prio_2
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_d_bits_prio_2 | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_d_bits_prio_2),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_opcode
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_opcode : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_opcode : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_param
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_param : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_param : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_size
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_size : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_size : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_source
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_source : 7'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_source : 7'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_offset
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_offset : 6'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_offset : 6'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_put
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_put : 6'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_put : 6'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_set
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_set : 10'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_set : 10'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_sink      (schedule_d_bits_sink),	// Cat.scala:30:58
    .io_req_bits_way
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_d_bits_way : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_d_bits_way : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_bits_bad
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_d_bits_bad | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_d_bits_bad | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_d_bits_bad | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_d_bits_bad | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_d_bits_bad | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_d_bits_bad | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_d_bits_bad),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_d_ready            (io_in_d_ready),
    .io_pb_pop_ready       (_sinkA_io_pb_pop_ready),	// Scheduler.scala:52:21
    .io_pb_beat_data       (_sinkA_io_pb_beat_data),	// Scheduler.scala:52:21
    .io_pb_beat_mask       (_sinkA_io_pb_beat_mask),	// Scheduler.scala:52:21
    .io_pb_beat_corrupt    (_sinkA_io_pb_beat_corrupt),	// Scheduler.scala:52:21
    .io_rel_pop_ready      (_sinkC_io_rel_pop_ready),	// Scheduler.scala:53:21
    .io_rel_beat_data      (_sinkC_io_rel_beat_data),	// Scheduler.scala:53:21
    .io_rel_beat_corrupt   (_sinkC_io_rel_beat_corrupt),	// Scheduler.scala:53:21
    .io_bs_radr_ready      (_bankedStore_io_sourceD_radr_ready),	// Scheduler.scala:67:27
    .io_bs_rdat_data       (_bankedStore_io_sourceD_rdat_data),	// Scheduler.scala:67:27
    .io_bs_wadr_ready      (_bankedStore_io_sourceD_wadr_ready),	// Scheduler.scala:67:27
    .io_evict_req_set      (_sourceC_io_evict_req_set),	// Scheduler.scala:40:23
    .io_evict_req_way      (_sourceC_io_evict_req_way),	// Scheduler.scala:40:23
    .io_grant_req_set      (_GEN_38),	// Scheduler.scala:309:16
    .io_grant_req_way      (_GEN_36),	// Scheduler.scala:308:16
    .io_req_ready          (_sourceD_io_req_ready),
    .io_d_valid            (io_in_d_valid),
    .io_d_bits_opcode      (io_in_d_bits_opcode),
    .io_d_bits_param       (io_in_d_bits_param),
    .io_d_bits_size        (io_in_d_bits_size),
    .io_d_bits_source      (io_in_d_bits_source),
    .io_d_bits_sink        (io_in_d_bits_sink),
    .io_d_bits_denied      (io_in_d_bits_denied),
    .io_d_bits_data        (io_in_d_bits_data),
    .io_d_bits_corrupt     (io_in_d_bits_corrupt),
    .io_pb_pop_valid       (_sourceD_io_pb_pop_valid),
    .io_pb_pop_bits_index  (_sourceD_io_pb_pop_bits_index),
    .io_pb_pop_bits_last   (_sourceD_io_pb_pop_bits_last),
    .io_rel_pop_valid      (_sourceD_io_rel_pop_valid),
    .io_rel_pop_bits_index (_sourceD_io_rel_pop_bits_index),
    .io_rel_pop_bits_last  (_sourceD_io_rel_pop_bits_last),
    .io_bs_radr_valid      (_sourceD_io_bs_radr_valid),
    .io_bs_radr_bits_way   (_sourceD_io_bs_radr_bits_way),
    .io_bs_radr_bits_set   (_sourceD_io_bs_radr_bits_set),
    .io_bs_radr_bits_beat  (_sourceD_io_bs_radr_bits_beat),
    .io_bs_radr_bits_mask  (_sourceD_io_bs_radr_bits_mask),
    .io_bs_wadr_valid      (_sourceD_io_bs_wadr_valid),
    .io_bs_wadr_bits_way   (_sourceD_io_bs_wadr_bits_way),
    .io_bs_wadr_bits_set   (_sourceD_io_bs_wadr_bits_set),
    .io_bs_wadr_bits_beat  (_sourceD_io_bs_wadr_bits_beat),
    .io_bs_wadr_bits_mask  (_sourceD_io_bs_wadr_bits_mask),
    .io_bs_wdat_data       (_sourceD_io_bs_wdat_data),
    .io_evict_safe         (_sourceD_io_evict_safe),
    .io_grant_safe         (_sourceD_io_grant_safe)
  );
  SourceE sourceE (	// Scheduler.scala:42:23
    .clock            (clock),
    .reset            (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_e_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_e_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_e_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_e_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_e_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_e_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_e_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_req_bits_sink
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_e_bits_sink : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_e_bits_sink : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_req_ready     (_sourceE_io_req_ready),
    .io_e_valid       (io_out_e_valid),
    .io_e_bits_sink   (io_out_e_bits_sink)
  );
  SourceX sourceX (	// Scheduler.scala:43:23
    .clock        (clock),
    .reset        (reset),
    .io_req_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_x_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_x_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_x_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_x_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_x_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_x_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_x_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_x_ready   (io_resp_ready),
    .io_req_ready (_sourceX_io_req_ready),
    .io_x_valid   (io_resp_valid)
  );
  SinkA sinkA (	// Scheduler.scala:52:21
    .clock                (clock),
    .reset                (reset),
    .io_req_ready
      (_sinkA_io_req_ready_T & ~_sinkC_io_req_valid & ~_sinkX_io_req_valid),	// Scheduler.scala:53:21, :56:21, :156:44, :157:64, :158:{84,87}
    .io_a_valid           (io_in_a_valid),
    .io_a_bits_opcode     (io_in_a_bits_opcode),
    .io_a_bits_size       (io_in_a_bits_size),
    .io_a_bits_address    (io_in_a_bits_address),
    .io_a_bits_mask       (io_in_a_bits_mask),
    .io_a_bits_data       (io_in_a_bits_data),
    .io_a_bits_corrupt    (io_in_a_bits_corrupt),
    .io_pb_pop_valid      (_sourceD_io_pb_pop_valid),	// Scheduler.scala:41:23
    .io_pb_pop_bits_index (_sourceD_io_pb_pop_bits_index),	// Scheduler.scala:41:23
    .io_pb_pop_bits_last  (_sourceD_io_pb_pop_bits_last),	// Scheduler.scala:41:23
    .io_req_valid         (_sinkA_io_req_valid),
    .io_req_bits_tag      (_sinkA_io_req_bits_tag),
    .io_req_bits_offset   (_sinkA_io_req_bits_offset),
    .io_req_bits_put      (_sinkA_io_req_bits_put),
    .io_req_bits_set      (_sinkA_io_req_bits_set),
    .io_a_ready           (io_in_a_ready),
    .io_pb_pop_ready      (_sinkA_io_pb_pop_ready),
    .io_pb_beat_data      (_sinkA_io_pb_beat_data),
    .io_pb_beat_mask      (_sinkA_io_pb_beat_mask),
    .io_pb_beat_corrupt   (_sinkA_io_pb_beat_corrupt)
  );
  SinkC sinkC (	// Scheduler.scala:53:21
    .clock                 (clock),
    .reset                 (reset),
    .io_req_ready          (_sinkA_io_req_ready_T),	// Scheduler.scala:156:44
    .io_c_valid            (io_in_c_valid),
    .io_c_bits_opcode      (io_in_c_bits_opcode),
    .io_c_bits_param       (io_in_c_bits_param),
    .io_c_bits_size        (io_in_c_bits_size),
    .io_c_bits_source      (io_in_c_bits_source),
    .io_c_bits_address     (io_in_c_bits_address),
    .io_c_bits_data        (io_in_c_bits_data),
    .io_c_bits_corrupt     (io_in_c_bits_corrupt),
    .io_way
      (_bc_mshr_io_status_valid & _bc_mshr_io_status_bits_set == _sinkC_io_set
         ? _bc_mshr_io_status_bits_way
         : (_abc_mshrs_0_io_status_valid
            & _abc_mshrs_0_io_status_bits_set == _sinkC_io_set
              ? _abc_mshrs_0_io_status_bits_way
              : 3'h0)
           | (_abc_mshrs_1_io_status_valid
              & _abc_mshrs_1_io_status_bits_set == _sinkC_io_set
                ? _abc_mshrs_1_io_status_bits_way
                : 3'h0)
           | (_abc_mshrs_2_io_status_valid
              & _abc_mshrs_2_io_status_bits_set == _sinkC_io_set
                ? _abc_mshrs_2_io_status_bits_way
                : 3'h0)
           | (_abc_mshrs_3_io_status_valid
              & _abc_mshrs_3_io_status_bits_set == _sinkC_io_set
                ? _abc_mshrs_3_io_status_bits_way
                : 3'h0)
           | (_abc_mshrs_4_io_status_valid
              & _abc_mshrs_4_io_status_bits_set == _sinkC_io_set
                ? _abc_mshrs_4_io_status_bits_way
                : 3'h0)),	// Mux.scala:27:72, Scheduler.scala:53:21, :56:21, :69:46, :304:{8,33,63}, :306:{50,74}
    .io_bs_adr_ready       (_bankedStore_io_sinkC_adr_ready),	// Scheduler.scala:67:27
    .io_rel_pop_valid      (_sourceD_io_rel_pop_valid),	// Scheduler.scala:41:23
    .io_rel_pop_bits_index (_sourceD_io_rel_pop_bits_index),	// Scheduler.scala:41:23
    .io_rel_pop_bits_last  (_sourceD_io_rel_pop_bits_last),	// Scheduler.scala:41:23
    .io_req_valid          (_sinkC_io_req_valid),
    .io_req_bits_opcode    (_sinkC_io_req_bits_opcode),
    .io_req_bits_param     (_sinkC_io_req_bits_param),
    .io_req_bits_size      (_sinkC_io_req_bits_size),
    .io_req_bits_source    (_sinkC_io_req_bits_source),
    .io_req_bits_tag       (_sinkC_io_req_bits_tag),
    .io_req_bits_offset    (_sinkC_io_req_bits_offset),
    .io_req_bits_put       (_sinkC_io_req_bits_put),
    .io_req_bits_set       (_sinkC_io_req_bits_set),
    .io_resp_valid         (_sinkC_io_resp_valid),
    .io_resp_bits_last     (_sinkC_io_resp_bits_last),
    .io_resp_bits_set      (_sinkC_io_resp_bits_set),
    .io_resp_bits_tag      (_sinkC_io_resp_bits_tag),
    .io_resp_bits_source   (_sinkC_io_resp_bits_source),
    .io_resp_bits_param    (_sinkC_io_resp_bits_param),
    .io_resp_bits_data     (_sinkC_io_resp_bits_data),
    .io_c_ready            (io_in_c_ready),
    .io_set                (_sinkC_io_set),
    .io_bs_adr_valid       (_sinkC_io_bs_adr_valid),
    .io_bs_adr_bits_noop   (_sinkC_io_bs_adr_bits_noop),
    .io_bs_adr_bits_way    (_sinkC_io_bs_adr_bits_way),
    .io_bs_adr_bits_set    (_sinkC_io_bs_adr_bits_set),
    .io_bs_adr_bits_beat   (_sinkC_io_bs_adr_bits_beat),
    .io_bs_adr_bits_mask   (_sinkC_io_bs_adr_bits_mask),
    .io_bs_dat_data        (_sinkC_io_bs_dat_data),
    .io_rel_pop_ready      (_sinkC_io_rel_pop_ready),
    .io_rel_beat_data      (_sinkC_io_rel_beat_data),
    .io_rel_beat_corrupt   (_sinkC_io_rel_beat_corrupt)
  );
  SinkD sinkD (	// Scheduler.scala:54:21
    .clock               (clock),
    .reset               (reset),
    .io_d_valid          (io_out_d_valid),
    .io_d_bits_opcode    (io_out_d_bits_opcode),
    .io_d_bits_param     (io_out_d_bits_param),
    .io_d_bits_size      (io_out_d_bits_size),
    .io_d_bits_source    (io_out_d_bits_source),
    .io_d_bits_sink      (io_out_d_bits_sink),
    .io_d_bits_denied    (io_out_d_bits_denied),
    .io_d_bits_data      (io_out_d_bits_data),
    .io_d_bits_corrupt   (io_out_d_bits_corrupt),
    .io_bs_adr_ready     (_bankedStore_io_sinkD_adr_ready),	// Scheduler.scala:67:27
    .io_grant_safe       (_sourceD_io_grant_safe),	// Scheduler.scala:41:23
    .io_resp_valid       (_sinkD_io_resp_valid),
    .io_resp_bits_last   (_sinkD_io_resp_bits_last),
    .io_resp_bits_opcode (_sinkD_io_resp_bits_opcode),
    .io_resp_bits_param  (_sinkD_io_resp_bits_param),
    .io_resp_bits_source (_sinkD_io_resp_bits_source),
    .io_resp_bits_sink   (_sinkD_io_resp_bits_sink),
    .io_resp_bits_denied (_sinkD_io_resp_bits_denied),
    .io_d_ready          (io_out_d_ready),
    .io_source           (_sinkD_io_source),
    .io_bs_adr_valid     (_sinkD_io_bs_adr_valid),
    .io_bs_adr_bits_noop (_sinkD_io_bs_adr_bits_noop),
    .io_bs_adr_bits_beat (_sinkD_io_bs_adr_bits_beat),
    .io_bs_dat_data      (_sinkD_io_bs_dat_data)
  );
  SinkX sinkX (	// Scheduler.scala:56:21
    .clock             (clock),
    .reset             (reset),
    .io_req_ready      (_sinkA_io_req_ready_T & ~_sinkC_io_req_valid),	// Scheduler.scala:53:21, :156:44, :157:{61,64}
    .io_x_valid        (io_req_valid),
    .io_x_bits_address (io_req_bits_address),
    .io_req_valid      (_sinkX_io_req_valid),
    .io_req_bits_tag   (_sinkX_io_req_bits_tag),
    .io_req_bits_set   (_sinkX_io_req_bits_set),
    .io_x_ready        (io_req_ready)
  );
  Directory directory (	// Scheduler.scala:66:25
    .clock                      (clock),
    .reset                      (reset),
    .io_write_valid
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_dir_valid | mshr_selectOH[1]
       & _abc_mshrs_1_io_schedule_bits_dir_valid | mshr_selectOH[2]
       & _abc_mshrs_2_io_schedule_bits_dir_valid | mshr_selectOH[3]
       & _abc_mshrs_3_io_schedule_bits_dir_valid | mshr_selectOH[4]
       & _abc_mshrs_4_io_schedule_bits_dir_valid | mshr_selectOH[5]
       & _bc_mshr_io_schedule_bits_dir_valid | mshr_selectOH[6]
       & _c_mshr_io_schedule_bits_dir_valid),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_write_bits_set
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_dir_bits_set : 10'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_dir_bits_set : 10'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_write_bits_way
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_dir_bits_way : 3'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_dir_bits_way : 3'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_write_bits_data_dirty
      (mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[1] & _abc_mshrs_1_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[2] & _abc_mshrs_2_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[3] & _abc_mshrs_3_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[4] & _abc_mshrs_4_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[5] & _bc_mshr_io_schedule_bits_dir_bits_data_dirty
       | mshr_selectOH[6] & _c_mshr_io_schedule_bits_dir_bits_data_dirty),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_write_bits_data_state
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_dir_bits_data_state : 2'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_dir_bits_data_state : 2'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70, :146:123
    .io_write_bits_data_clients
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_dir_bits_data_clients : 6'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_dir_bits_data_clients : 6'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:56:21, :69:46, :119:70
    .io_write_bits_data_tag
      ((mshr_selectOH[0] ? _abc_mshrs_0_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[1] ? _abc_mshrs_1_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[2] ? _abc_mshrs_2_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[3] ? _abc_mshrs_3_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[4] ? _abc_mshrs_4_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[5] ? _bc_mshr_io_schedule_bits_dir_bits_data_tag : 13'h0)
       | (mshr_selectOH[6] ? _c_mshr_io_schedule_bits_dir_bits_data_tag : 13'h0)),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70
    .io_read_valid              (mshr_uses_directory | alloc_uses_directory),	// Scheduler.scala:238:41, :251:44, :254:50
    .io_read_bits_set
      (mshr_uses_directory_for_lb
         ? (mshr_selectOH[0] ? _abc_mshrs_0_io_status_bits_set : 10'h0)
           | (mshr_selectOH[1] ? _abc_mshrs_1_io_status_bits_set : 10'h0)
           | (mshr_selectOH[2] ? _abc_mshrs_2_io_status_bits_set : 10'h0)
           | (mshr_selectOH[3] ? _abc_mshrs_3_io_status_bits_set : 10'h0)
           | (mshr_selectOH[4] ? _abc_mshrs_4_io_status_bits_set : 10'h0)
           | (mshr_selectOH[5] ? _bc_mshr_io_status_bits_set : 10'h0)
           | (mshr_selectOH[6] ? _c_mshr_io_status_bits_set : 10'h0)
         : request_bits_set),	// Mux.scala:27:72, :29:36, Scheduler.scala:69:46, :119:70, :154:22, :237:45, :255:36
    .io_read_bits_tag
      (mshr_uses_directory_for_lb
         ? _requests_io_data_tag
         : _mshrs_6_io_allocate_bits_WIRE_tag),	// Scheduler.scala:68:24, :154:22, :237:45, :256:36
    .io_write_ready             (_directory_io_write_ready),
    .io_result_bits_dirty       (_directory_io_result_bits_dirty),
    .io_result_bits_state       (_directory_io_result_bits_state),
    .io_result_bits_clients     (_directory_io_result_bits_clients),
    .io_result_bits_tag         (_directory_io_result_bits_tag),
    .io_result_bits_hit         (_directory_io_result_bits_hit),
    .io_result_bits_way         (_directory_io_result_bits_way),
    .io_ready                   (_directory_io_ready)
  );
  BankedStore bankedStore (	// Scheduler.scala:67:27
    .clock                     (clock),
    .io_sinkC_adr_valid        (_sinkC_io_bs_adr_valid),	// Scheduler.scala:53:21
    .io_sinkC_adr_bits_noop    (_sinkC_io_bs_adr_bits_noop),	// Scheduler.scala:53:21
    .io_sinkC_adr_bits_way     (_sinkC_io_bs_adr_bits_way),	// Scheduler.scala:53:21
    .io_sinkC_adr_bits_set     (_sinkC_io_bs_adr_bits_set),	// Scheduler.scala:53:21
    .io_sinkC_adr_bits_beat    (_sinkC_io_bs_adr_bits_beat),	// Scheduler.scala:53:21
    .io_sinkC_adr_bits_mask    (_sinkC_io_bs_adr_bits_mask),	// Scheduler.scala:53:21
    .io_sinkC_dat_data         (_sinkC_io_bs_dat_data),	// Scheduler.scala:53:21
    .io_sinkD_adr_valid        (_sinkD_io_bs_adr_valid),	// Scheduler.scala:54:21
    .io_sinkD_adr_bits_noop    (_sinkD_io_bs_adr_bits_noop),	// Scheduler.scala:54:21
    .io_sinkD_adr_bits_way     (_GEN_36),	// Scheduler.scala:308:16
    .io_sinkD_adr_bits_set     (_GEN_38),	// Scheduler.scala:309:16
    .io_sinkD_adr_bits_beat    (_sinkD_io_bs_adr_bits_beat),	// Scheduler.scala:54:21
    .io_sinkD_dat_data         (_sinkD_io_bs_dat_data),	// Scheduler.scala:54:21
    .io_sourceC_adr_valid      (_sourceC_io_bs_adr_valid),	// Scheduler.scala:40:23
    .io_sourceC_adr_bits_way   (_sourceC_io_bs_adr_bits_way),	// Scheduler.scala:40:23
    .io_sourceC_adr_bits_set   (_sourceC_io_bs_adr_bits_set),	// Scheduler.scala:40:23
    .io_sourceC_adr_bits_beat  (_sourceC_io_bs_adr_bits_beat),	// Scheduler.scala:40:23
    .io_sourceD_radr_valid     (_sourceD_io_bs_radr_valid),	// Scheduler.scala:41:23
    .io_sourceD_radr_bits_way  (_sourceD_io_bs_radr_bits_way),	// Scheduler.scala:41:23
    .io_sourceD_radr_bits_set  (_sourceD_io_bs_radr_bits_set),	// Scheduler.scala:41:23
    .io_sourceD_radr_bits_beat (_sourceD_io_bs_radr_bits_beat),	// Scheduler.scala:41:23
    .io_sourceD_radr_bits_mask (_sourceD_io_bs_radr_bits_mask),	// Scheduler.scala:41:23
    .io_sourceD_wadr_valid     (_sourceD_io_bs_wadr_valid),	// Scheduler.scala:41:23
    .io_sourceD_wadr_bits_way  (_sourceD_io_bs_wadr_bits_way),	// Scheduler.scala:41:23
    .io_sourceD_wadr_bits_set  (_sourceD_io_bs_wadr_bits_set),	// Scheduler.scala:41:23
    .io_sourceD_wadr_bits_beat (_sourceD_io_bs_wadr_bits_beat),	// Scheduler.scala:41:23
    .io_sourceD_wadr_bits_mask (_sourceD_io_bs_wadr_bits_mask),	// Scheduler.scala:41:23
    .io_sourceD_wdat_data      (_sourceD_io_bs_wdat_data),	// Scheduler.scala:41:23
    .io_sinkC_adr_ready        (_bankedStore_io_sinkC_adr_ready),
    .io_sinkD_adr_ready        (_bankedStore_io_sinkD_adr_ready),
    .io_sourceC_adr_ready      (_bankedStore_io_sourceC_adr_ready),
    .io_sourceC_dat_data       (_bankedStore_io_sourceC_dat_data),
    .io_sourceD_radr_ready     (_bankedStore_io_sourceD_radr_ready),
    .io_sourceD_rdat_data      (_bankedStore_io_sourceD_rdat_data),
    .io_sourceD_wadr_ready     (_bankedStore_io_sourceD_wadr_ready)
  );
  ListBuffer_2 requests (	// Scheduler.scala:68:24
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid             (_requests_io_push_valid_T & ~bypassQueue),	// Scheduler.scala:184:31, :245:37, :259:{52,55}
    .io_push_bits_index
      ({2'h0,
        _sinkC_io_req_valid
          ? 3'h0
          : {|(lowerMatches1[6:4]),
             |(_requests_io_push_bits_index_T_1[2:1]),
             _requests_io_push_bits_index_T_1[2] | _requests_io_push_bits_index_T_1[0]}}
       | (_sinkC_io_req_valid
            ? {|(lowerMatches1[6:2]),
               |(lowerMatches1[1:0]),
               |{lowerMatches1[1:0], lowerMatches1[6]},
               |(_requests_io_push_bits_index_T_12[2:1]),
               _requests_io_push_bits_index_T_12[2]
                 | _requests_io_push_bits_index_T_12[0]}
            : 5'h0)),	// Cat.scala:30:58, Mux.scala:27:72, OneHot.scala:30:18, :31:18, :32:{14,28}, Scheduler.scala:53:21, :56:21, :69:46, :146:123, :189:8
    .io_push_bits_data_prio_0  (~_sinkC_io_req_valid),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :248:84, :276:87, :289:12
    .io_push_bits_data_prio_2  (_sinkC_io_req_valid),	// Scheduler.scala:53:21
    .io_push_bits_data_control (_mshrs_6_io_allocate_bits_WIRE_control),	// Scheduler.scala:154:22
    .io_push_bits_data_opcode  (_mshrs_6_io_allocate_bits_WIRE_opcode),	// Scheduler.scala:154:22
    .io_push_bits_data_param   (_mshrs_6_io_allocate_bits_WIRE_param),	// Scheduler.scala:154:22
    .io_push_bits_data_size    (_mshrs_6_io_allocate_bits_WIRE_size),	// Scheduler.scala:154:22
    .io_push_bits_data_source  (_mshrs_6_io_allocate_bits_WIRE_source),	// Scheduler.scala:154:22
    .io_push_bits_data_tag     (_mshrs_6_io_allocate_bits_WIRE_tag),	// Scheduler.scala:154:22
    .io_push_bits_data_offset  (_mshrs_6_io_allocate_bits_WIRE_offset),	// Scheduler.scala:154:22
    .io_push_bits_data_put     (_mshrs_6_io_allocate_bits_WIRE_put),	// Scheduler.scala:154:22
    .io_pop_valid              (will_pop),	// Scheduler.scala:204:45
    .io_pop_bits
      ({|pop_index_hi_1,
        |(_pop_index_T_2[14:7]),
        |(_pop_index_T_3[6:3]),
        |(_pop_index_T_4[2:1]),
        _pop_index_T_4[2] | _pop_index_T_4[0]}),	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, Scheduler.scala:230:77
    .io_push_ready             (_requests_io_push_ready),
    .io_valid                  (_requests_io_valid),
    .io_data_prio_0            (_requests_io_data_prio_0),
    .io_data_prio_1            (_requests_io_data_prio_1),
    .io_data_prio_2            (_requests_io_data_prio_2),
    .io_data_control           (_requests_io_data_control),
    .io_data_opcode            (_requests_io_data_opcode),
    .io_data_param             (_requests_io_data_param),
    .io_data_size              (_requests_io_data_size),
    .io_data_source            (_requests_io_data_source),
    .io_data_tag               (_requests_io_data_tag),
    .io_data_offset            (_requests_io_data_offset),
    .io_data_put               (_requests_io_data_put)
  );
  MSHR abc_mshrs_0 (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_20 | mshr_selectOH[0] & _abc_mshrs_0_io_schedule_bits_reload
       & (_requests_io_valid[0] | _requests_io_valid[7] | _requests_io_valid[14]
          | bypass_1)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27
    .io_allocate_bits_prio_0
      (_GEN_21 ? ~_sinkC_io_req_valid : _requests_io_data_prio_0),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :222:24, :248:84, :269:83, :271:26, :276:87, :289:12
    .io_allocate_bits_prio_1
      (~(_GEN_20 | bypass_1) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26
    .io_allocate_bits_prio_2
      (_GEN_21 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26
    .io_allocate_bits_control
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_opcode
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_param
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_size
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_source
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_tag                   (_GEN_5),	// Scheduler.scala:222:24, :269:83, :271:26
    .io_allocate_bits_offset
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_put
      (_GEN_21 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_set
      (_GEN_20 ? request_bits_set : _abc_mshrs_0_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26
    .io_allocate_bits_repeat
      (~_GEN_20 & _GEN_5 == _abc_mshrs_0_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33
    .io_directory_valid                     (directoryFanout[0]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[0]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _abc_mshrs_0_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h0),	// Scheduler.scala:54:21, :56:21, :69:46, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h0),	// Scheduler.scala:56:21, :69:46, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_abc_mshrs_0_io_status_valid),
    .io_status_bits_set                     (_abc_mshrs_0_io_status_bits_set),
    .io_status_bits_tag                     (_abc_mshrs_0_io_status_bits_tag),
    .io_status_bits_way                     (_abc_mshrs_0_io_status_bits_way),
    .io_status_bits_blockC                  (_abc_mshrs_0_io_status_bits_blockC),
    .io_status_bits_nestC                   (_abc_mshrs_0_io_status_bits_nestC),
    .io_schedule_valid                      (_abc_mshrs_0_io_schedule_valid),
    .io_schedule_bits_a_valid               (_abc_mshrs_0_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_abc_mshrs_0_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_abc_mshrs_0_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_abc_mshrs_0_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_abc_mshrs_0_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_abc_mshrs_0_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_abc_mshrs_0_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_abc_mshrs_0_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_abc_mshrs_0_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients
      (_abc_mshrs_0_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_abc_mshrs_0_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_abc_mshrs_0_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_abc_mshrs_0_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_abc_mshrs_0_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_abc_mshrs_0_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_abc_mshrs_0_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_abc_mshrs_0_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_abc_mshrs_0_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_abc_mshrs_0_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_abc_mshrs_0_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_abc_mshrs_0_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_abc_mshrs_0_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_abc_mshrs_0_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_abc_mshrs_0_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_abc_mshrs_0_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_abc_mshrs_0_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_abc_mshrs_0_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_abc_mshrs_0_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_abc_mshrs_0_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_abc_mshrs_0_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_abc_mshrs_0_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_abc_mshrs_0_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_abc_mshrs_0_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_abc_mshrs_0_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_abc_mshrs_0_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_abc_mshrs_0_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_abc_mshrs_0_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_abc_mshrs_0_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag
      (_abc_mshrs_0_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_abc_mshrs_0_io_schedule_bits_reload)
  );
  MSHR abc_mshrs_1 (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_22 | mshr_selectOH[1] & _abc_mshrs_1_io_schedule_bits_reload
       & (_requests_io_valid[1] | _requests_io_valid[8] | _requests_io_valid[15]
          | bypass_2)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27
    .io_allocate_bits_prio_0
      (_GEN_23 ? ~_sinkC_io_req_valid : _requests_io_data_prio_0),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :222:24, :248:84, :269:83, :271:26, :276:87, :289:12
    .io_allocate_bits_prio_1
      (~(_GEN_22 | bypass_2) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26
    .io_allocate_bits_prio_2
      (_GEN_23 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26
    .io_allocate_bits_control
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_opcode
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_param
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_size
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_source
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_tag                   (_GEN_4),	// Scheduler.scala:222:24, :269:83, :271:26
    .io_allocate_bits_offset
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_put
      (_GEN_23 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_set
      (_GEN_22 ? request_bits_set : _abc_mshrs_1_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26
    .io_allocate_bits_repeat
      (~_GEN_22 & _GEN_4 == _abc_mshrs_1_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33
    .io_directory_valid                     (directoryFanout[1]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[1]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _abc_mshrs_1_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h1),	// Scheduler.scala:54:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h1),	// Scheduler.scala:78:74, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_abc_mshrs_1_io_status_valid),
    .io_status_bits_set                     (_abc_mshrs_1_io_status_bits_set),
    .io_status_bits_tag                     (_abc_mshrs_1_io_status_bits_tag),
    .io_status_bits_way                     (_abc_mshrs_1_io_status_bits_way),
    .io_status_bits_blockC                  (_abc_mshrs_1_io_status_bits_blockC),
    .io_status_bits_nestC                   (_abc_mshrs_1_io_status_bits_nestC),
    .io_schedule_valid                      (_abc_mshrs_1_io_schedule_valid),
    .io_schedule_bits_a_valid               (_abc_mshrs_1_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_abc_mshrs_1_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_abc_mshrs_1_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_abc_mshrs_1_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_abc_mshrs_1_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_abc_mshrs_1_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_abc_mshrs_1_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_abc_mshrs_1_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_abc_mshrs_1_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients
      (_abc_mshrs_1_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_abc_mshrs_1_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_abc_mshrs_1_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_abc_mshrs_1_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_abc_mshrs_1_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_abc_mshrs_1_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_abc_mshrs_1_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_abc_mshrs_1_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_abc_mshrs_1_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_abc_mshrs_1_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_abc_mshrs_1_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_abc_mshrs_1_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_abc_mshrs_1_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_abc_mshrs_1_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_abc_mshrs_1_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_abc_mshrs_1_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_abc_mshrs_1_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_abc_mshrs_1_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_abc_mshrs_1_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_abc_mshrs_1_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_abc_mshrs_1_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_abc_mshrs_1_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_abc_mshrs_1_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_abc_mshrs_1_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_abc_mshrs_1_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_abc_mshrs_1_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_abc_mshrs_1_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_abc_mshrs_1_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_abc_mshrs_1_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag
      (_abc_mshrs_1_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_abc_mshrs_1_io_schedule_bits_reload)
  );
  MSHR abc_mshrs_2 (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_24 | mshr_selectOH[2] & _abc_mshrs_2_io_schedule_bits_reload
       & (_requests_io_valid[2] | _requests_io_valid[9] | _requests_io_valid[16]
          | bypass_3)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27
    .io_allocate_bits_prio_0
      (_GEN_25 ? ~_sinkC_io_req_valid : _requests_io_data_prio_0),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :222:24, :248:84, :269:83, :271:26, :276:87, :289:12
    .io_allocate_bits_prio_1
      (~(_GEN_24 | bypass_3) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26
    .io_allocate_bits_prio_2
      (_GEN_25 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26
    .io_allocate_bits_control
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_opcode
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_param
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_size
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_source
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_tag                   (_GEN_3),	// Scheduler.scala:222:24, :269:83, :271:26
    .io_allocate_bits_offset
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_put
      (_GEN_25 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_set
      (_GEN_24 ? request_bits_set : _abc_mshrs_2_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26
    .io_allocate_bits_repeat
      (~_GEN_24 & _GEN_3 == _abc_mshrs_2_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33
    .io_directory_valid                     (directoryFanout[2]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[2]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _abc_mshrs_2_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h2),	// Scheduler.scala:54:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h2),	// Scheduler.scala:78:74, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_abc_mshrs_2_io_status_valid),
    .io_status_bits_set                     (_abc_mshrs_2_io_status_bits_set),
    .io_status_bits_tag                     (_abc_mshrs_2_io_status_bits_tag),
    .io_status_bits_way                     (_abc_mshrs_2_io_status_bits_way),
    .io_status_bits_blockC                  (_abc_mshrs_2_io_status_bits_blockC),
    .io_status_bits_nestC                   (_abc_mshrs_2_io_status_bits_nestC),
    .io_schedule_valid                      (_abc_mshrs_2_io_schedule_valid),
    .io_schedule_bits_a_valid               (_abc_mshrs_2_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_abc_mshrs_2_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_abc_mshrs_2_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_abc_mshrs_2_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_abc_mshrs_2_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_abc_mshrs_2_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_abc_mshrs_2_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_abc_mshrs_2_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_abc_mshrs_2_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients
      (_abc_mshrs_2_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_abc_mshrs_2_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_abc_mshrs_2_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_abc_mshrs_2_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_abc_mshrs_2_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_abc_mshrs_2_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_abc_mshrs_2_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_abc_mshrs_2_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_abc_mshrs_2_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_abc_mshrs_2_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_abc_mshrs_2_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_abc_mshrs_2_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_abc_mshrs_2_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_abc_mshrs_2_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_abc_mshrs_2_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_abc_mshrs_2_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_abc_mshrs_2_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_abc_mshrs_2_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_abc_mshrs_2_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_abc_mshrs_2_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_abc_mshrs_2_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_abc_mshrs_2_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_abc_mshrs_2_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_abc_mshrs_2_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_abc_mshrs_2_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_abc_mshrs_2_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_abc_mshrs_2_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_abc_mshrs_2_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_abc_mshrs_2_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag
      (_abc_mshrs_2_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_abc_mshrs_2_io_schedule_bits_reload)
  );
  MSHR abc_mshrs_3 (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_26 | mshr_selectOH[3] & _abc_mshrs_3_io_schedule_bits_reload
       & (_requests_io_valid[3] | _requests_io_valid[10] | _requests_io_valid[17]
          | bypass_4)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27
    .io_allocate_bits_prio_0
      (_GEN_27 ? ~_sinkC_io_req_valid : _requests_io_data_prio_0),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :222:24, :248:84, :269:83, :271:26, :276:87, :289:12
    .io_allocate_bits_prio_1
      (~(_GEN_26 | bypass_4) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26
    .io_allocate_bits_prio_2
      (_GEN_27 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26
    .io_allocate_bits_control
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_opcode
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_param
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_size
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_source
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_tag                   (_GEN_2),	// Scheduler.scala:222:24, :269:83, :271:26
    .io_allocate_bits_offset
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_put
      (_GEN_27 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_set
      (_GEN_26 ? request_bits_set : _abc_mshrs_3_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26
    .io_allocate_bits_repeat
      (~_GEN_26 & _GEN_2 == _abc_mshrs_3_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33
    .io_directory_valid                     (directoryFanout[3]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[3]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _abc_mshrs_3_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h3),	// Scheduler.scala:54:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h3),	// Scheduler.scala:78:74, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_abc_mshrs_3_io_status_valid),
    .io_status_bits_set                     (_abc_mshrs_3_io_status_bits_set),
    .io_status_bits_tag                     (_abc_mshrs_3_io_status_bits_tag),
    .io_status_bits_way                     (_abc_mshrs_3_io_status_bits_way),
    .io_status_bits_blockC                  (_abc_mshrs_3_io_status_bits_blockC),
    .io_status_bits_nestC                   (_abc_mshrs_3_io_status_bits_nestC),
    .io_schedule_valid                      (_abc_mshrs_3_io_schedule_valid),
    .io_schedule_bits_a_valid               (_abc_mshrs_3_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_abc_mshrs_3_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_abc_mshrs_3_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_abc_mshrs_3_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_abc_mshrs_3_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_abc_mshrs_3_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_abc_mshrs_3_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_abc_mshrs_3_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_abc_mshrs_3_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients
      (_abc_mshrs_3_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_abc_mshrs_3_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_abc_mshrs_3_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_abc_mshrs_3_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_abc_mshrs_3_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_abc_mshrs_3_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_abc_mshrs_3_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_abc_mshrs_3_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_abc_mshrs_3_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_abc_mshrs_3_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_abc_mshrs_3_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_abc_mshrs_3_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_abc_mshrs_3_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_abc_mshrs_3_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_abc_mshrs_3_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_abc_mshrs_3_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_abc_mshrs_3_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_abc_mshrs_3_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_abc_mshrs_3_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_abc_mshrs_3_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_abc_mshrs_3_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_abc_mshrs_3_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_abc_mshrs_3_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_abc_mshrs_3_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_abc_mshrs_3_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_abc_mshrs_3_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_abc_mshrs_3_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_abc_mshrs_3_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_abc_mshrs_3_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag
      (_abc_mshrs_3_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_abc_mshrs_3_io_schedule_bits_reload)
  );
  MSHR abc_mshrs_4 (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_28 | mshr_selectOH[4] & _abc_mshrs_4_io_schedule_bits_reload
       & (_requests_io_valid[4] | _requests_io_valid[11] | _requests_io_valid[18]
          | bypass_5)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27
    .io_allocate_bits_prio_0
      (_GEN_29 ? ~_sinkC_io_req_valid : _requests_io_data_prio_0),	// Mux.scala:27:72, Scheduler.scala:39:23, :40:23, :41:23, :42:23, :43:23, :52:21, :53:21, :54:21, :55:21, :56:21, :67:27, :68:24, :69:46, :152:21, :154:22, :155:22, :174:{37,57}, :222:24, :248:84, :269:83, :271:26, :276:87, :289:12
    .io_allocate_bits_prio_1
      (~(_GEN_28 | bypass_5) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26
    .io_allocate_bits_prio_2
      (_GEN_29 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26
    .io_allocate_bits_control
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_opcode
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_param
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_size
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_source
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_tag                   (_GEN_1),	// Scheduler.scala:222:24, :269:83, :271:26
    .io_allocate_bits_offset
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_put
      (_GEN_29 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26
    .io_allocate_bits_set
      (_GEN_28 ? request_bits_set : _abc_mshrs_4_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26
    .io_allocate_bits_repeat
      (~_GEN_28 & _GEN_1 == _abc_mshrs_4_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33
    .io_directory_valid                     (directoryFanout[4]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[4]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _abc_mshrs_4_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h4),	// Scheduler.scala:54:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h4),	// Scheduler.scala:78:74, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_abc_mshrs_4_io_status_valid),
    .io_status_bits_set                     (_abc_mshrs_4_io_status_bits_set),
    .io_status_bits_tag                     (_abc_mshrs_4_io_status_bits_tag),
    .io_status_bits_way                     (_abc_mshrs_4_io_status_bits_way),
    .io_status_bits_blockC                  (_abc_mshrs_4_io_status_bits_blockC),
    .io_status_bits_nestC                   (_abc_mshrs_4_io_status_bits_nestC),
    .io_schedule_valid                      (_abc_mshrs_4_io_schedule_valid),
    .io_schedule_bits_a_valid               (_abc_mshrs_4_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_abc_mshrs_4_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_abc_mshrs_4_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_abc_mshrs_4_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_abc_mshrs_4_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_abc_mshrs_4_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_abc_mshrs_4_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_abc_mshrs_4_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_abc_mshrs_4_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients
      (_abc_mshrs_4_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_abc_mshrs_4_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_abc_mshrs_4_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_abc_mshrs_4_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_abc_mshrs_4_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_abc_mshrs_4_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_abc_mshrs_4_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_abc_mshrs_4_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_abc_mshrs_4_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_abc_mshrs_4_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_abc_mshrs_4_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_abc_mshrs_4_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_abc_mshrs_4_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_abc_mshrs_4_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_abc_mshrs_4_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_abc_mshrs_4_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_abc_mshrs_4_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_abc_mshrs_4_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_abc_mshrs_4_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_abc_mshrs_4_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_abc_mshrs_4_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_abc_mshrs_4_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_abc_mshrs_4_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_abc_mshrs_4_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_abc_mshrs_4_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_abc_mshrs_4_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_abc_mshrs_4_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_abc_mshrs_4_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_abc_mshrs_4_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag
      (_abc_mshrs_4_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_abc_mshrs_4_io_schedule_bits_reload)
  );
  MSHR bc_mshr (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_30 | mshr_selectOH[5] & _bc_mshr_io_schedule_bits_reload
       & (_requests_io_valid[5] | _requests_io_valid[12] | _requests_io_valid[19]
          | bypass_6)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:{39,83}, :270:27, :276:131, :277:31
    .io_allocate_bits_prio_0                (1'h0),
    .io_allocate_bits_prio_1
      (~(_GEN_30 | bypass_6) & _requests_io_data_prio_1),	// Scheduler.scala:68:24, :220:41, :222:{24,30}, :269:{39,83}, :271:26, :276:131, :278:30
    .io_allocate_bits_prio_2
      (_GEN_31 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_control
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_opcode
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_param
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_size
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_source
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_tag                   (_GEN_0),	// Scheduler.scala:222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_offset
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_put
      (_GEN_31 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :276:131, :278:30
    .io_allocate_bits_set
      (_GEN_30 ? request_bits_set : _bc_mshr_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :269:{39,83}, :271:26, :276:131, :278:30
    .io_allocate_bits_repeat
      (~_GEN_30 & _GEN_0 == _bc_mshr_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :269:{39,83}, :271:26, :272:33, :276:131, :278:30, :279:37
    .io_directory_valid                     (directoryFanout[5]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[5]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _bc_mshr_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h5),	// Scheduler.scala:54:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h5),	// Scheduler.scala:78:74, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_bc_mshr_io_status_valid),
    .io_status_bits_set                     (_bc_mshr_io_status_bits_set),
    .io_status_bits_tag                     (_bc_mshr_io_status_bits_tag),
    .io_status_bits_way                     (_bc_mshr_io_status_bits_way),
    .io_status_bits_blockC                  (_bc_mshr_io_status_bits_blockC),
    .io_status_bits_nestC                   (_bc_mshr_io_status_bits_nestC),
    .io_schedule_valid                      (_bc_mshr_io_schedule_valid),
    .io_schedule_bits_a_valid               (_bc_mshr_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_bc_mshr_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_bc_mshr_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_bc_mshr_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_bc_mshr_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_bc_mshr_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_bc_mshr_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_bc_mshr_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_bc_mshr_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients        (_bc_mshr_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_bc_mshr_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_bc_mshr_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_bc_mshr_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_bc_mshr_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_bc_mshr_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_bc_mshr_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_bc_mshr_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_bc_mshr_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_bc_mshr_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_bc_mshr_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_bc_mshr_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_bc_mshr_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_bc_mshr_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_bc_mshr_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_bc_mshr_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_bc_mshr_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_bc_mshr_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_bc_mshr_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_bc_mshr_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_bc_mshr_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_bc_mshr_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_bc_mshr_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_bc_mshr_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_bc_mshr_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_bc_mshr_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_bc_mshr_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_bc_mshr_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_bc_mshr_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag     (_bc_mshr_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_bc_mshr_io_schedule_bits_reload)
  );
  MSHR c_mshr (	// Scheduler.scala:69:46
    .clock                                  (clock),
    .reset                                  (reset),
    .io_allocate_valid
      (_GEN_33 | mshr_selectOH[6] & _c_mshr_io_schedule_bits_reload
       & (_requests_io_valid[6] | _requests_io_valid[13] | _requests_io_valid[20]
          | bypass_7)),	// Mux.scala:29:36, Scheduler.scala:68:24, :69:46, :119:70, :214:34, :215:34, :216:34, :220:41, :221:61, :225:{25,32}, :269:83, :270:27, :284:103, :285:30
    .io_allocate_bits_prio_0                (1'h0),
    .io_allocate_bits_prio_1                (1'h0),
    .io_allocate_bits_prio_2
      (_GEN_34 ? _sinkC_io_req_valid : _requests_io_data_prio_2),	// Scheduler.scala:53:21, :68:24, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_control
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_control : _requests_io_data_control),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_opcode
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_opcode : _requests_io_data_opcode),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_param
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_param : _requests_io_data_param),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_size
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_size : _requests_io_data_size),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_source
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_source : _requests_io_data_source),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_tag                   (_GEN),	// Scheduler.scala:222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_offset
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_offset : _requests_io_data_offset),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_put
      (_GEN_34 ? _mshrs_6_io_allocate_bits_WIRE_put : _requests_io_data_put),	// Scheduler.scala:68:24, :154:22, :222:24, :269:83, :271:26, :284:103, :286:29
    .io_allocate_bits_set
      (_GEN_33 ? request_bits_set : _c_mshr_io_status_bits_set),	// Scheduler.scala:69:46, :154:22, :223:28, :225:25, :269:83, :270:27, :271:26, :284:103, :285:30, :286:29
    .io_allocate_bits_repeat
      (~_GEN_33 & _GEN == _c_mshr_io_status_bits_tag),	// Scheduler.scala:69:46, :222:24, :224:{31,57}, :225:25, :269:83, :270:27, :271:26, :272:33, :284:103, :285:30, :286:29, :287:36
    .io_directory_valid                     (directoryFanout[6]),	// Scheduler.scala:296:46, :298:44
    .io_directory_bits_dirty                (_directory_io_result_bits_dirty),	// Scheduler.scala:66:25
    .io_directory_bits_state                (_directory_io_result_bits_state),	// Scheduler.scala:66:25
    .io_directory_bits_clients              (_directory_io_result_bits_clients),	// Scheduler.scala:66:25
    .io_directory_bits_tag                  (_directory_io_result_bits_tag),	// Scheduler.scala:66:25
    .io_directory_bits_hit                  (_directory_io_result_bits_hit),	// Scheduler.scala:66:25
    .io_directory_bits_way                  (_directory_io_result_bits_way),	// Scheduler.scala:66:25
    .io_schedule_ready                      (mshr_selectOH[6]),	// Mux.scala:29:36, Scheduler.scala:119:70
    .io_sinkc_valid
      (_sinkC_io_resp_valid & _sinkC_io_resp_bits_set == _c_mshr_io_status_bits_set),	// Scheduler.scala:53:21, :69:46, :77:{45,71}
    .io_sinkc_bits_last                     (_sinkC_io_resp_bits_last),	// Scheduler.scala:53:21
    .io_sinkc_bits_tag                      (_sinkC_io_resp_bits_tag),	// Scheduler.scala:53:21
    .io_sinkc_bits_source                   (_sinkC_io_resp_bits_source),	// Scheduler.scala:53:21
    .io_sinkc_bits_param                    (_sinkC_io_resp_bits_param),	// Scheduler.scala:53:21
    .io_sinkc_bits_data                     (_sinkC_io_resp_bits_data),	// Scheduler.scala:53:21
    .io_sinkd_valid
      (_sinkD_io_resp_valid & _sinkD_io_resp_bits_source == 3'h6),	// Scheduler.scala:39:23, :54:21, :56:21, :78:{45,74}
    .io_sinkd_bits_last                     (_sinkD_io_resp_bits_last),	// Scheduler.scala:54:21
    .io_sinkd_bits_opcode                   (_sinkD_io_resp_bits_opcode),	// Scheduler.scala:54:21
    .io_sinkd_bits_param                    (_sinkD_io_resp_bits_param),	// Scheduler.scala:54:21
    .io_sinkd_bits_sink                     (_sinkD_io_resp_bits_sink),	// Scheduler.scala:54:21
    .io_sinkd_bits_denied                   (_sinkD_io_resp_bits_denied),	// Scheduler.scala:54:21
    .io_sinke_valid                         (io_in_e_valid & io_in_e_bits_sink == 3'h6),	// Scheduler.scala:39:23, :56:21, :79:{45,74}
    .io_nestedwb_set                        (nestedwb_set),	// Scheduler.scala:144:24
    .io_nestedwb_tag                        (nestedwb_tag),	// Scheduler.scala:145:24
    .io_nestedwb_b_toN                      (nestedwb_b_toN),	// Scheduler.scala:146:75
    .io_nestedwb_b_toB                      (nestedwb_b_toB),	// Scheduler.scala:147:75
    .io_nestedwb_b_clr_dirty                (nestedwb_b_clr_dirty),	// Scheduler.scala:146:37
    .io_nestedwb_c_set_dirty                (nestedwb_c_set_dirty),	// Scheduler.scala:149:75
    .io_status_valid                        (_c_mshr_io_status_valid),
    .io_status_bits_set                     (_c_mshr_io_status_bits_set),
    .io_status_bits_tag                     (_c_mshr_io_status_bits_tag),
    .io_status_bits_way                     (_c_mshr_io_status_bits_way),
    .io_status_bits_blockC                  (_c_mshr_io_status_bits_blockC),
    .io_status_bits_nestC                   (_c_mshr_io_status_bits_nestC),
    .io_schedule_valid                      (_c_mshr_io_schedule_valid),
    .io_schedule_bits_a_valid               (_c_mshr_io_schedule_bits_a_valid),
    .io_schedule_bits_a_bits_tag            (_c_mshr_io_schedule_bits_a_bits_tag),
    .io_schedule_bits_a_bits_set            (_c_mshr_io_schedule_bits_a_bits_set),
    .io_schedule_bits_a_bits_param          (_c_mshr_io_schedule_bits_a_bits_param),
    .io_schedule_bits_a_bits_block          (_c_mshr_io_schedule_bits_a_bits_block),
    .io_schedule_bits_b_valid               (_c_mshr_io_schedule_bits_b_valid),
    .io_schedule_bits_b_bits_param          (_c_mshr_io_schedule_bits_b_bits_param),
    .io_schedule_bits_b_bits_tag            (_c_mshr_io_schedule_bits_b_bits_tag),
    .io_schedule_bits_b_bits_set            (_c_mshr_io_schedule_bits_b_bits_set),
    .io_schedule_bits_b_bits_clients        (_c_mshr_io_schedule_bits_b_bits_clients),
    .io_schedule_bits_c_valid               (_c_mshr_io_schedule_bits_c_valid),
    .io_schedule_bits_c_bits_opcode         (_c_mshr_io_schedule_bits_c_bits_opcode),
    .io_schedule_bits_c_bits_param          (_c_mshr_io_schedule_bits_c_bits_param),
    .io_schedule_bits_c_bits_tag            (_c_mshr_io_schedule_bits_c_bits_tag),
    .io_schedule_bits_c_bits_set            (_c_mshr_io_schedule_bits_c_bits_set),
    .io_schedule_bits_c_bits_way            (_c_mshr_io_schedule_bits_c_bits_way),
    .io_schedule_bits_c_bits_dirty          (_c_mshr_io_schedule_bits_c_bits_dirty),
    .io_schedule_bits_d_valid               (_c_mshr_io_schedule_bits_d_valid),
    .io_schedule_bits_d_bits_prio_0         (_c_mshr_io_schedule_bits_d_bits_prio_0),
    .io_schedule_bits_d_bits_prio_2         (_c_mshr_io_schedule_bits_d_bits_prio_2),
    .io_schedule_bits_d_bits_opcode         (_c_mshr_io_schedule_bits_d_bits_opcode),
    .io_schedule_bits_d_bits_param          (_c_mshr_io_schedule_bits_d_bits_param),
    .io_schedule_bits_d_bits_size           (_c_mshr_io_schedule_bits_d_bits_size),
    .io_schedule_bits_d_bits_source         (_c_mshr_io_schedule_bits_d_bits_source),
    .io_schedule_bits_d_bits_offset         (_c_mshr_io_schedule_bits_d_bits_offset),
    .io_schedule_bits_d_bits_put            (_c_mshr_io_schedule_bits_d_bits_put),
    .io_schedule_bits_d_bits_set            (_c_mshr_io_schedule_bits_d_bits_set),
    .io_schedule_bits_d_bits_way            (_c_mshr_io_schedule_bits_d_bits_way),
    .io_schedule_bits_d_bits_bad            (_c_mshr_io_schedule_bits_d_bits_bad),
    .io_schedule_bits_e_valid               (_c_mshr_io_schedule_bits_e_valid),
    .io_schedule_bits_e_bits_sink           (_c_mshr_io_schedule_bits_e_bits_sink),
    .io_schedule_bits_x_valid               (_c_mshr_io_schedule_bits_x_valid),
    .io_schedule_bits_dir_valid             (_c_mshr_io_schedule_bits_dir_valid),
    .io_schedule_bits_dir_bits_set          (_c_mshr_io_schedule_bits_dir_bits_set),
    .io_schedule_bits_dir_bits_way          (_c_mshr_io_schedule_bits_dir_bits_way),
    .io_schedule_bits_dir_bits_data_dirty
      (_c_mshr_io_schedule_bits_dir_bits_data_dirty),
    .io_schedule_bits_dir_bits_data_state
      (_c_mshr_io_schedule_bits_dir_bits_data_state),
    .io_schedule_bits_dir_bits_data_clients
      (_c_mshr_io_schedule_bits_dir_bits_data_clients),
    .io_schedule_bits_dir_bits_data_tag     (_c_mshr_io_schedule_bits_dir_bits_data_tag),
    .io_schedule_bits_reload                (_c_mshr_io_schedule_bits_reload)
  );
endmodule

