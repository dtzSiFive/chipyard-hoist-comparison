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

module ALUExeUnit_10(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [9:0]  io_req_bits_uop_fu_code,
  input         io_req_bits_uop_ctrl_is_std,
  input  [11:0] io_req_bits_uop_br_mask,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [4:0]  io_req_bits_uop_mem_cmd,
  input  [1:0]  io_req_bits_uop_mem_size,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [63:0] io_lsu_io_iresp_bits_data,
  output [64:0] io_ll_iresp_bits_data,
  output        io_lsu_io_req_valid,
  output [11:0] io_lsu_io_req_bits_uop_br_mask,
  output [63:0] io_lsu_io_req_bits_data,
  output [39:0] io_lsu_io_req_bits_addr,
  output        io_lsu_io_req_bits_mxcpt_valid,
                io_lsu_io_req_bits_sfence_valid,
                io_lsu_io_req_bits_sfence_bits_rs1,
                io_lsu_io_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_io_req_bits_sfence_bits_addr
);

  MemAddrCalcUnit_3 maddrcalc (	// execution-unit.scala:379:27
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (io_req_valid & io_req_bits_uop_fu_code[2]),	// execution-unit.scala:381:45, micro-op.scala:154:40
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_ctrl_is_std    (io_req_bits_uop_ctrl_is_std),
    .io_req_bits_uop_br_mask        (io_req_bits_uop_br_mask),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_mem_cmd        (io_req_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size       (io_req_bits_uop_mem_size),
    .io_req_bits_uop_fp_val         (io_req_bits_uop_fp_val),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data),
    .io_req_bits_rs2_data           (io_req_bits_rs2_data),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                  (io_lsu_io_req_valid),
    .io_resp_bits_uop_br_mask       (io_lsu_io_req_bits_uop_br_mask),
    .io_resp_bits_addr              (io_lsu_io_req_bits_addr),
    .io_resp_bits_mxcpt_valid       (io_lsu_io_req_bits_mxcpt_valid),
    .io_resp_bits_sfence_valid      (io_lsu_io_req_bits_sfence_valid),
    .io_resp_bits_sfence_bits_rs1   (io_lsu_io_req_bits_sfence_bits_rs1),
    .io_resp_bits_sfence_bits_rs2   (io_lsu_io_req_bits_sfence_bits_rs2),
    .io_resp_bits_sfence_bits_addr  (io_lsu_io_req_bits_sfence_bits_addr)
  );
  assign io_ll_iresp_bits_data = {1'h0, io_lsu_io_iresp_bits_data};	// execution-unit.scala:392:17
  assign io_lsu_io_req_bits_data = io_req_bits_rs2_data[63:0];	// execution-unit.scala:390:19
endmodule

