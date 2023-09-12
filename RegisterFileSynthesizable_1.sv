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

module RegisterFileSynthesizable_1(
  input         clock,
                reset,
  input  [6:0]  io_read_ports_0_addr,
                io_read_ports_1_addr,
                io_read_ports_2_addr,
                io_read_ports_3_addr,
                io_read_ports_4_addr,
                io_read_ports_5_addr,
                io_read_ports_6_addr,
                io_read_ports_7_addr,
                io_read_ports_8_addr,
                io_read_ports_9_addr,
                io_read_ports_10_addr,
                io_read_ports_11_addr,
  input         io_write_ports_0_valid,
  input  [6:0]  io_write_ports_0_bits_addr,
  input  [63:0] io_write_ports_0_bits_data,
  input         io_write_ports_1_valid,
  input  [6:0]  io_write_ports_1_bits_addr,
  input  [63:0] io_write_ports_1_bits_data,
  input         io_write_ports_2_valid,
  input  [6:0]  io_write_ports_2_bits_addr,
  input  [63:0] io_write_ports_2_bits_data,
  input         io_write_ports_3_valid,
  input  [6:0]  io_write_ports_3_bits_addr,
  input  [63:0] io_write_ports_3_bits_data,
  input         io_write_ports_4_valid,
  input  [6:0]  io_write_ports_4_bits_addr,
  input  [63:0] io_write_ports_4_bits_data,
  input         io_write_ports_5_valid,
  input  [6:0]  io_write_ports_5_bits_addr,
  input  [63:0] io_write_ports_5_bits_data,
  output [63:0] io_read_ports_0_data,
                io_read_ports_1_data,
                io_read_ports_2_data,
                io_read_ports_3_data,
                io_read_ports_4_data,
                io_read_ports_5_data,
                io_read_ports_6_data,
                io_read_ports_7_data,
                io_read_ports_8_data,
                io_read_ports_9_data,
                io_read_ports_10_data,
                io_read_ports_11_data
);

  wire [63:0] _regfile_ext_R0_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R1_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R2_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R3_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R4_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R5_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R6_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R7_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R8_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R9_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R10_data;	// regfile.scala:117:20
  wire [63:0] _regfile_ext_R11_data;	// regfile.scala:117:20
  reg  [6:0]  read_addrs_0;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_1;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_2;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_3;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_4;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_5;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_6;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_7;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_8;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_9;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_10;	// regfile.scala:125:50
  reg  [6:0]  read_addrs_11;	// regfile.scala:125:50
  wire        _bypass_data_WIRE_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_0;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_2_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_1;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_4_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_2;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_6_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_3;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_8_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_4;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_10_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_5;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_12_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_6;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_14_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_7;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_16_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_8;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_18_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_9;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_20_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_10;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_0 =
    io_write_ports_0_valid & io_write_ports_0_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_1 =
    io_write_ports_1_valid & io_write_ports_1_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_2 =
    io_write_ports_2_valid & io_write_ports_2_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_3 =
    io_write_ports_3_valid & io_write_ports_3_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_4 =
    io_write_ports_4_valid & io_write_ports_4_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  wire        _bypass_data_WIRE_22_5 =
    io_write_ports_5_valid & io_write_ports_5_bits_addr == read_addrs_11;	// regfile.scala:125:50, :145:59, :146:21
  `ifndef SYNTHESIS	// regfile.scala:171:15
    always @(posedge clock) begin	// regfile.scala:171:15
      automatic logic _GEN = io_write_ports_0_bits_addr == 7'h0;	// regfile.scala:174:45
      automatic logic _GEN_0 = io_write_ports_1_bits_addr == 7'h0;	// regfile.scala:174:45
      automatic logic _GEN_1 = io_write_ports_2_bits_addr == 7'h0;	// regfile.scala:174:45
      automatic logic _GEN_2 = io_write_ports_3_bits_addr == 7'h0;	// regfile.scala:174:45
      if (~(~io_write_ports_0_valid | ~io_write_ports_1_valid
            | io_write_ports_0_bits_addr != io_write_ports_1_bits_addr | _GEN
            | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_0_valid | ~io_write_ports_2_valid
            | io_write_ports_0_bits_addr != io_write_ports_2_bits_addr | _GEN
            | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_0_valid | ~io_write_ports_3_valid
            | io_write_ports_0_bits_addr != io_write_ports_3_bits_addr | _GEN
            | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_0_valid | ~io_write_ports_4_valid
            | io_write_ports_0_bits_addr != io_write_ports_4_bits_addr | _GEN
            | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_0_valid | ~io_write_ports_5_valid
            | io_write_ports_0_bits_addr != io_write_ports_5_bits_addr | _GEN
            | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_1_valid | ~io_write_ports_2_valid
            | io_write_ports_1_bits_addr != io_write_ports_2_bits_addr | _GEN_0
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_1_valid | ~io_write_ports_3_valid
            | io_write_ports_1_bits_addr != io_write_ports_3_bits_addr | _GEN_0
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_1_valid | ~io_write_ports_4_valid
            | io_write_ports_1_bits_addr != io_write_ports_4_bits_addr | _GEN_0
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_1_valid | ~io_write_ports_5_valid
            | io_write_ports_1_bits_addr != io_write_ports_5_bits_addr | _GEN_0
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_2_valid | ~io_write_ports_3_valid
            | io_write_ports_2_bits_addr != io_write_ports_3_bits_addr | _GEN_1
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_2_valid | ~io_write_ports_4_valid
            | io_write_ports_2_bits_addr != io_write_ports_4_bits_addr | _GEN_1
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_2_valid | ~io_write_ports_5_valid
            | io_write_ports_2_bits_addr != io_write_ports_5_bits_addr | _GEN_1
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_3_valid | ~io_write_ports_4_valid
            | io_write_ports_3_bits_addr != io_write_ports_4_bits_addr | _GEN_2
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_3_valid | ~io_write_ports_5_valid
            | io_write_ports_3_bits_addr != io_write_ports_5_bits_addr | _GEN_2
            | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
      if (~(~io_write_ports_4_valid | ~io_write_ports_5_valid
            | io_write_ports_4_bits_addr != io_write_ports_5_bits_addr
            | io_write_ports_4_bits_addr == 7'h0 | reset)) begin	// regfile.scala:171:15, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    read_addrs_0 <= io_read_ports_0_addr;	// regfile.scala:125:50
    read_addrs_1 <= io_read_ports_1_addr;	// regfile.scala:125:50
    read_addrs_2 <= io_read_ports_2_addr;	// regfile.scala:125:50
    read_addrs_3 <= io_read_ports_3_addr;	// regfile.scala:125:50
    read_addrs_4 <= io_read_ports_4_addr;	// regfile.scala:125:50
    read_addrs_5 <= io_read_ports_5_addr;	// regfile.scala:125:50
    read_addrs_6 <= io_read_ports_6_addr;	// regfile.scala:125:50
    read_addrs_7 <= io_read_ports_7_addr;	// regfile.scala:125:50
    read_addrs_8 <= io_read_ports_8_addr;	// regfile.scala:125:50
    read_addrs_9 <= io_read_ports_9_addr;	// regfile.scala:125:50
    read_addrs_10 <= io_read_ports_10_addr;	// regfile.scala:125:50
    read_addrs_11 <= io_read_ports_11_addr;	// regfile.scala:125:50
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
        read_addrs_0 = _RANDOM[2'h0][6:0];	// regfile.scala:125:50
        read_addrs_1 = _RANDOM[2'h0][13:7];	// regfile.scala:125:50
        read_addrs_2 = _RANDOM[2'h0][20:14];	// regfile.scala:125:50
        read_addrs_3 = _RANDOM[2'h0][27:21];	// regfile.scala:125:50
        read_addrs_4 = {_RANDOM[2'h0][31:28], _RANDOM[2'h1][2:0]};	// regfile.scala:125:50
        read_addrs_5 = _RANDOM[2'h1][9:3];	// regfile.scala:125:50
        read_addrs_6 = _RANDOM[2'h1][16:10];	// regfile.scala:125:50
        read_addrs_7 = _RANDOM[2'h1][23:17];	// regfile.scala:125:50
        read_addrs_8 = _RANDOM[2'h1][30:24];	// regfile.scala:125:50
        read_addrs_9 = {_RANDOM[2'h1][31], _RANDOM[2'h2][5:0]};	// regfile.scala:125:50
        read_addrs_10 = _RANDOM[2'h2][12:6];	// regfile.scala:125:50
        read_addrs_11 = _RANDOM[2'h2][19:13];	// regfile.scala:125:50
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  regfile_128x64 regfile_ext (	// regfile.scala:117:20
    .R0_addr  (read_addrs_9),	// regfile.scala:125:50
    .R0_en    (1'h1),
    .R0_clk   (clock),
    .R1_addr  (read_addrs_8),	// regfile.scala:125:50
    .R1_en    (1'h1),
    .R1_clk   (clock),
    .R2_addr  (read_addrs_7),	// regfile.scala:125:50
    .R2_en    (1'h1),
    .R2_clk   (clock),
    .R3_addr  (read_addrs_6),	// regfile.scala:125:50
    .R3_en    (1'h1),
    .R3_clk   (clock),
    .R4_addr  (read_addrs_5),	// regfile.scala:125:50
    .R4_en    (1'h1),
    .R4_clk   (clock),
    .R5_addr  (read_addrs_4),	// regfile.scala:125:50
    .R5_en    (1'h1),
    .R5_clk   (clock),
    .R6_addr  (read_addrs_3),	// regfile.scala:125:50
    .R6_en    (1'h1),
    .R6_clk   (clock),
    .R7_addr  (read_addrs_2),	// regfile.scala:125:50
    .R7_en    (1'h1),
    .R7_clk   (clock),
    .R8_addr  (read_addrs_1),	// regfile.scala:125:50
    .R8_en    (1'h1),
    .R8_clk   (clock),
    .R9_addr  (read_addrs_11),	// regfile.scala:125:50
    .R9_en    (1'h1),
    .R9_clk   (clock),
    .R10_addr (read_addrs_10),	// regfile.scala:125:50
    .R10_en   (1'h1),
    .R10_clk  (clock),
    .R11_addr (read_addrs_0),	// regfile.scala:125:50
    .R11_en   (1'h1),
    .R11_clk  (clock),
    .W0_addr  (io_write_ports_5_bits_addr),
    .W0_en    (io_write_ports_5_valid),
    .W0_clk   (clock),
    .W0_data  (io_write_ports_5_bits_data),
    .W1_addr  (io_write_ports_4_bits_addr),
    .W1_en    (io_write_ports_4_valid),
    .W1_clk   (clock),
    .W1_data  (io_write_ports_4_bits_data),
    .W2_addr  (io_write_ports_3_bits_addr),
    .W2_en    (io_write_ports_3_valid),
    .W2_clk   (clock),
    .W2_data  (io_write_ports_3_bits_data),
    .W3_addr  (io_write_ports_2_bits_addr),
    .W3_en    (io_write_ports_2_valid),
    .W3_clk   (clock),
    .W3_data  (io_write_ports_2_bits_data),
    .W4_addr  (io_write_ports_1_bits_addr),
    .W4_en    (io_write_ports_1_valid),
    .W4_clk   (clock),
    .W4_data  (io_write_ports_1_bits_data),
    .W5_addr  (io_write_ports_0_bits_addr),
    .W5_en    (io_write_ports_0_valid),
    .W5_clk   (clock),
    .W5_data  (io_write_ports_0_bits_data),
    .R0_data  (_regfile_ext_R0_data),
    .R1_data  (_regfile_ext_R1_data),
    .R2_data  (_regfile_ext_R2_data),
    .R3_data  (_regfile_ext_R3_data),
    .R4_data  (_regfile_ext_R4_data),
    .R5_data  (_regfile_ext_R5_data),
    .R6_data  (_regfile_ext_R6_data),
    .R7_data  (_regfile_ext_R7_data),
    .R8_data  (_regfile_ext_R8_data),
    .R9_data  (_regfile_ext_R9_data),
    .R10_data (_regfile_ext_R10_data),
    .R11_data (_regfile_ext_R11_data)
  );
  assign io_read_ports_0_data =
    _bypass_data_WIRE_0 | _bypass_data_WIRE_1 | _bypass_data_WIRE_2 | _bypass_data_WIRE_3
    | _bypass_data_WIRE_4 | _bypass_data_WIRE_5
      ? (_bypass_data_WIRE_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R11_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_1_data =
    _bypass_data_WIRE_2_0 | _bypass_data_WIRE_2_1 | _bypass_data_WIRE_2_2
    | _bypass_data_WIRE_2_3 | _bypass_data_WIRE_2_4 | _bypass_data_WIRE_2_5
      ? (_bypass_data_WIRE_2_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_2_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_2_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_2_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_2_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_2_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R8_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_2_data =
    _bypass_data_WIRE_4_0 | _bypass_data_WIRE_4_1 | _bypass_data_WIRE_4_2
    | _bypass_data_WIRE_4_3 | _bypass_data_WIRE_4_4 | _bypass_data_WIRE_4_5
      ? (_bypass_data_WIRE_4_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_4_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_4_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_4_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_4_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_4_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R7_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_3_data =
    _bypass_data_WIRE_6_0 | _bypass_data_WIRE_6_1 | _bypass_data_WIRE_6_2
    | _bypass_data_WIRE_6_3 | _bypass_data_WIRE_6_4 | _bypass_data_WIRE_6_5
      ? (_bypass_data_WIRE_6_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_6_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_6_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_6_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_6_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_6_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R6_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_4_data =
    _bypass_data_WIRE_8_0 | _bypass_data_WIRE_8_1 | _bypass_data_WIRE_8_2
    | _bypass_data_WIRE_8_3 | _bypass_data_WIRE_8_4 | _bypass_data_WIRE_8_5
      ? (_bypass_data_WIRE_8_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_8_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_8_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_8_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_8_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_8_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R5_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_5_data =
    _bypass_data_WIRE_10_0 | _bypass_data_WIRE_10_1 | _bypass_data_WIRE_10_2
    | _bypass_data_WIRE_10_3 | _bypass_data_WIRE_10_4 | _bypass_data_WIRE_10_5
      ? (_bypass_data_WIRE_10_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_10_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_10_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_10_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_10_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_10_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R4_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_6_data =
    _bypass_data_WIRE_12_0 | _bypass_data_WIRE_12_1 | _bypass_data_WIRE_12_2
    | _bypass_data_WIRE_12_3 | _bypass_data_WIRE_12_4 | _bypass_data_WIRE_12_5
      ? (_bypass_data_WIRE_12_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_12_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_12_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_12_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_12_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_12_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R3_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_7_data =
    _bypass_data_WIRE_14_0 | _bypass_data_WIRE_14_1 | _bypass_data_WIRE_14_2
    | _bypass_data_WIRE_14_3 | _bypass_data_WIRE_14_4 | _bypass_data_WIRE_14_5
      ? (_bypass_data_WIRE_14_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_14_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_14_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_14_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_14_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_14_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R2_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_8_data =
    _bypass_data_WIRE_16_0 | _bypass_data_WIRE_16_1 | _bypass_data_WIRE_16_2
    | _bypass_data_WIRE_16_3 | _bypass_data_WIRE_16_4 | _bypass_data_WIRE_16_5
      ? (_bypass_data_WIRE_16_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_16_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_16_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_16_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_16_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_16_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R1_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_9_data =
    _bypass_data_WIRE_18_0 | _bypass_data_WIRE_18_1 | _bypass_data_WIRE_18_2
    | _bypass_data_WIRE_18_3 | _bypass_data_WIRE_18_4 | _bypass_data_WIRE_18_5
      ? (_bypass_data_WIRE_18_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_18_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_18_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_18_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_18_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_18_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R0_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_10_data =
    _bypass_data_WIRE_20_0 | _bypass_data_WIRE_20_1 | _bypass_data_WIRE_20_2
    | _bypass_data_WIRE_20_3 | _bypass_data_WIRE_20_4 | _bypass_data_WIRE_20_5
      ? (_bypass_data_WIRE_20_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_20_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_20_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_20_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_20_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_20_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R10_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
  assign io_read_ports_11_data =
    _bypass_data_WIRE_22_0 | _bypass_data_WIRE_22_1 | _bypass_data_WIRE_22_2
    | _bypass_data_WIRE_22_3 | _bypass_data_WIRE_22_4 | _bypass_data_WIRE_22_5
      ? (_bypass_data_WIRE_22_0 ? io_write_ports_0_bits_data : 64'h0)
        | (_bypass_data_WIRE_22_1 ? io_write_ports_1_bits_data : 64'h0)
        | (_bypass_data_WIRE_22_2 ? io_write_ports_2_bits_data : 64'h0)
        | (_bypass_data_WIRE_22_3 ? io_write_ports_3_bits_data : 64'h0)
        | (_bypass_data_WIRE_22_4 ? io_write_ports_4_bits_data : 64'h0)
        | (_bypass_data_WIRE_22_5 ? io_write_ports_5_bits_data : 64'h0)
      : _regfile_ext_R9_data;	// Mux.scala:27:72, regfile.scala:117:20, :145:59, :150:{35,55}
endmodule

