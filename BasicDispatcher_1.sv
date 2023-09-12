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

module BasicDispatcher_1(
  input        io_ren_uops_0_valid,
  input  [2:0] io_ren_uops_0_bits_iq_type,
  input        io_ren_uops_1_valid,
  input  [2:0] io_ren_uops_1_bits_iq_type,
  input        io_ren_uops_2_valid,
  input  [2:0] io_ren_uops_2_bits_iq_type,
  input        io_dis_uops_2_0_ready,
               io_dis_uops_2_1_ready,
               io_dis_uops_2_2_ready,
               io_dis_uops_1_0_ready,
               io_dis_uops_1_1_ready,
               io_dis_uops_1_2_ready,
               io_dis_uops_0_0_ready,
               io_dis_uops_0_1_ready,
               io_dis_uops_0_2_ready,
  output       io_ren_uops_0_ready,
               io_ren_uops_1_ready,
               io_ren_uops_2_ready,
               io_dis_uops_2_0_valid,
               io_dis_uops_2_1_valid,
               io_dis_uops_2_2_valid,
               io_dis_uops_1_0_valid,
               io_dis_uops_1_1_valid,
               io_dis_uops_1_2_valid,
               io_dis_uops_0_0_valid,
               io_dis_uops_0_1_valid,
               io_dis_uops_0_2_valid
);

  assign io_ren_uops_0_ready =
    io_dis_uops_0_0_ready & io_dis_uops_1_0_ready & io_dis_uops_2_0_ready;	// dispatch.scala:47:79, :50:39
  assign io_ren_uops_1_ready =
    io_dis_uops_0_1_ready & io_dis_uops_1_1_ready & io_dis_uops_2_1_ready;	// dispatch.scala:47:79, :50:39
  assign io_ren_uops_2_ready =
    io_dis_uops_0_2_ready & io_dis_uops_1_2_ready & io_dis_uops_2_2_ready;	// dispatch.scala:47:79, :50:39
  assign io_dis_uops_2_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[2];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_2_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[2];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_2_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[2];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_1_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[0];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_1_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[0];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_1_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[0];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_0_0_valid = io_ren_uops_0_valid & io_ren_uops_0_bits_iq_type[1];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_0_1_valid = io_ren_uops_1_valid & io_ren_uops_1_bits_iq_type[1];	// dispatch.scala:58:{42,75}
  assign io_dis_uops_0_2_valid = io_ren_uops_2_valid & io_ren_uops_2_bits_iq_type[1];	// dispatch.scala:58:{42,75}
endmodule

