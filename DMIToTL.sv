// Generated by CIRCT firtool-1.54.0-30-g7bb1650e3
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

module DMIToTL(
  input         auto_out_a_ready,
                auto_out_d_valid,
                auto_out_d_bits_denied,
  input  [31:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
                io_dmi_req_valid,
  input  [6:0]  io_dmi_req_bits_addr,
  input  [31:0] io_dmi_req_bits_data,
  input  [1:0]  io_dmi_req_bits_op,
  input         io_dmi_resp_ready,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
  output [8:0]  auto_out_a_bits_address,
  output [31:0] auto_out_a_bits_data,
  output        auto_out_d_ready,
                io_dmi_req_ready,
                io_dmi_resp_valid,
  output [31:0] io_dmi_resp_bits_data,
  output [1:0]  io_dmi_resp_bits_resp
);

  wire _GEN = io_dmi_req_bits_op == 2'h2;	// DMI.scala:109:30, Parameters.scala:92:32
  wire _GEN_0 = io_dmi_req_bits_op == 2'h1;	// DMI.scala:110:37
  assign auto_out_a_valid = io_dmi_req_valid;
  assign auto_out_a_bits_opcode = _GEN ? 3'h0 : {_GEN_0, 2'h0};	// Bundles.scala:256:54, DMI.scala:95:46, :109:{30,64,76}, :110:{37,64,76}, :111:76
  assign auto_out_a_bits_address = _GEN | _GEN_0 ? {io_dmi_req_bits_addr, 2'h0} : 9'h48;	// DMI.scala:95:46, :109:{30,64,76}, :110:{37,64}, Edges.scala:470:15
  assign auto_out_a_bits_data = _GEN ? io_dmi_req_bits_data : 32'h0;	// Bundles.scala:256:54, DMI.scala:109:{30,64,76}, :110:64
  assign auto_out_d_ready = io_dmi_resp_ready;
  assign io_dmi_req_ready = auto_out_a_ready;
  assign io_dmi_resp_valid = auto_out_d_valid;
  assign io_dmi_resp_bits_data = auto_out_d_bits_data;
  assign io_dmi_resp_bits_resp = {1'h0, auto_out_d_bits_corrupt | auto_out_d_bits_denied};	// DMI.scala:110:37, :119:{28,53}
endmodule
