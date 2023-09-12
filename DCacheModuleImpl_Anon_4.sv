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

module DCacheModuleImpl_Anon_4(
  input         io_in_0_valid,
  input  [39:0] io_in_0_bits_addr,
  input  [5:0]  io_in_0_bits_idx,
  input         io_in_1_valid,
  input  [39:0] io_in_1_bits_addr,
  input  [5:0]  io_in_1_bits_idx,
  input  [21:0] io_in_1_bits_data,
  input         io_in_2_valid,
  input  [39:0] io_in_2_bits_addr,
  input  [5:0]  io_in_2_bits_idx,
  input  [21:0] io_in_2_bits_data,
  input         io_in_3_valid,
  input  [39:0] io_in_3_bits_addr,
  input  [5:0]  io_in_3_bits_idx,
  input  [21:0] io_in_3_bits_data,
  input         io_in_4_valid,
  input  [39:0] io_in_4_bits_addr,
  input  [5:0]  io_in_4_bits_idx,
  input  [21:0] io_in_4_bits_data,
  input         io_in_5_valid,
  input  [39:0] io_in_5_bits_addr,
  input  [5:0]  io_in_5_bits_idx,
  input  [21:0] io_in_5_bits_data,
  input         io_in_6_valid,
  input  [39:0] io_in_6_bits_addr,
  input  [5:0]  io_in_6_bits_idx,
  input  [21:0] io_in_6_bits_data,
  input         io_in_7_valid,
  input  [39:0] io_in_7_bits_addr,
  input  [5:0]  io_in_7_bits_idx,
  input  [21:0] io_in_7_bits_data,
  output        io_in_4_ready,
                io_in_5_ready,
                io_in_6_ready,
                io_in_7_ready,
                io_out_valid,
                io_out_bits_write,
  output [39:0] io_out_bits_addr,
  output [5:0]  io_out_bits_idx,
  output [21:0] io_out_bits_data
);

  wire _grant_T_2 = io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid;	// Arbiter.scala:31:68
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;	// Arbiter.scala:31:68
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;	// Arbiter.scala:31:68
  wire _io_out_valid_T = _grant_T_4 | io_in_6_valid;	// Arbiter.scala:31:68
  assign io_in_4_ready = ~_grant_T_2;	// Arbiter.scala:31:{68,78}
  assign io_in_5_ready = ~_grant_T_3;	// Arbiter.scala:31:{68,78}
  assign io_in_6_ready = ~_grant_T_4;	// Arbiter.scala:31:{68,78}
  assign io_in_7_ready = ~_io_out_valid_T;	// Arbiter.scala:31:{68,78}
  assign io_out_valid = _io_out_valid_T | io_in_7_valid;	// Arbiter.scala:31:68, :135:31
  assign io_out_bits_write =
    io_in_0_valid | io_in_1_valid | io_in_2_valid | io_in_3_valid | io_in_4_valid;	// Arbiter.scala:126:27, :128:19
  assign io_out_bits_addr =
    io_in_0_valid
      ? io_in_0_bits_addr
      : io_in_1_valid
          ? io_in_1_bits_addr
          : io_in_2_valid
              ? io_in_2_bits_addr
              : io_in_3_valid
                  ? io_in_3_bits_addr
                  : io_in_4_valid
                      ? io_in_4_bits_addr
                      : io_in_5_valid
                          ? io_in_5_bits_addr
                          : io_in_6_valid ? io_in_6_bits_addr : io_in_7_bits_addr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_idx =
    io_in_0_valid
      ? io_in_0_bits_idx
      : io_in_1_valid
          ? io_in_1_bits_idx
          : io_in_2_valid
              ? io_in_2_bits_idx
              : io_in_3_valid
                  ? io_in_3_bits_idx
                  : io_in_4_valid
                      ? io_in_4_bits_idx
                      : io_in_5_valid
                          ? io_in_5_bits_idx
                          : io_in_6_valid ? io_in_6_bits_idx : io_in_7_bits_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_data =
    io_in_0_valid
      ? 22'h0
      : io_in_1_valid
          ? io_in_1_bits_data
          : io_in_2_valid
              ? io_in_2_bits_data
              : io_in_3_valid
                  ? io_in_3_bits_data
                  : io_in_4_valid
                      ? io_in_4_bits_data
                      : io_in_5_valid
                          ? io_in_5_bits_data
                          : io_in_6_valid ? io_in_6_bits_data : io_in_7_bits_data;	// Arbiter.scala:124:15, :126:27, :128:19
endmodule

