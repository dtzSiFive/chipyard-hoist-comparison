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

module PipelinedMulUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [19:0] io_req_bits_uop_br_mask,
  input  [6:0]  io_req_bits_uop_rob_idx,
                io_req_bits_uop_pdst,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data
);

  reg        r_valids_0;	// functional-unit.scala:228:27
  reg        r_valids_1;	// functional-unit.scala:228:27
  reg        r_valids_2;	// functional-unit.scala:228:27
  reg [19:0] r_uops_0_br_mask;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_0_rob_idx;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_0_pdst;	// functional-unit.scala:229:23
  reg        r_uops_0_bypassable;	// functional-unit.scala:229:23
  reg        r_uops_0_is_amo;	// functional-unit.scala:229:23
  reg        r_uops_0_uses_stq;	// functional-unit.scala:229:23
  reg [1:0]  r_uops_0_dst_rtype;	// functional-unit.scala:229:23
  reg [19:0] r_uops_1_br_mask;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_1_rob_idx;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_1_pdst;	// functional-unit.scala:229:23
  reg        r_uops_1_bypassable;	// functional-unit.scala:229:23
  reg        r_uops_1_is_amo;	// functional-unit.scala:229:23
  reg        r_uops_1_uses_stq;	// functional-unit.scala:229:23
  reg [1:0]  r_uops_1_dst_rtype;	// functional-unit.scala:229:23
  reg [19:0] r_uops_2_br_mask;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_2_rob_idx;	// functional-unit.scala:229:23
  reg [6:0]  r_uops_2_pdst;	// functional-unit.scala:229:23
  reg        r_uops_2_bypassable;	// functional-unit.scala:229:23
  reg        r_uops_2_is_amo;	// functional-unit.scala:229:23
  reg        r_uops_2_uses_stq;	// functional-unit.scala:229:23
  reg [1:0]  r_uops_2_dst_rtype;	// functional-unit.scala:229:23
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;	// functional-unit.scala:228:27
      r_valids_1 <= 1'h0;	// functional-unit.scala:228:27
      r_valids_2 <= 1'h0;	// functional-unit.scala:228:27
    end
    else begin
      r_valids_0 <=
        io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :232:{84,87}, util.scala:118:{51,59}
      r_valids_1 <=
        r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
      r_valids_2 <=
        r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
    end
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;	// functional-unit.scala:229:23
    r_uops_0_pdst <= io_req_bits_uop_pdst;	// functional-unit.scala:229:23
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;	// functional-unit.scala:229:23
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;	// functional-unit.scala:229:23
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;	// functional-unit.scala:229:23
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;	// functional-unit.scala:229:23
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_1_rob_idx <= r_uops_0_rob_idx;	// functional-unit.scala:229:23
    r_uops_1_pdst <= r_uops_0_pdst;	// functional-unit.scala:229:23
    r_uops_1_bypassable <= r_uops_0_bypassable;	// functional-unit.scala:229:23
    r_uops_1_is_amo <= r_uops_0_is_amo;	// functional-unit.scala:229:23
    r_uops_1_uses_stq <= r_uops_0_uses_stq;	// functional-unit.scala:229:23
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;	// functional-unit.scala:229:23
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_2_rob_idx <= r_uops_1_rob_idx;	// functional-unit.scala:229:23
    r_uops_2_pdst <= r_uops_1_pdst;	// functional-unit.scala:229:23
    r_uops_2_bypassable <= r_uops_1_bypassable;	// functional-unit.scala:229:23
    r_uops_2_is_amo <= r_uops_1_is_amo;	// functional-unit.scala:229:23
    r_uops_2_uses_stq <= r_uops_1_uses_stq;	// functional-unit.scala:229:23
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;	// functional-unit.scala:229:23
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:38];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h27; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        r_valids_0 = _RANDOM[6'h0][0];	// functional-unit.scala:228:27
        r_valids_1 = _RANDOM[6'h0][1];	// functional-unit.scala:228:27
        r_valids_2 = _RANDOM[6'h0][2];	// functional-unit.scala:228:27
        r_uops_0_br_mask = {_RANDOM[6'h4][31], _RANDOM[6'h5][18:0]};	// functional-unit.scala:229:23
        r_uops_0_rob_idx = _RANDOM[6'h7][12:6];	// functional-unit.scala:229:23
        r_uops_0_pdst = _RANDOM[6'h7][31:25];	// functional-unit.scala:229:23
        r_uops_0_bypassable = _RANDOM[6'hB][7];	// functional-unit.scala:229:23
        r_uops_0_is_amo = _RANDOM[6'hB][18];	// functional-unit.scala:229:23
        r_uops_0_uses_stq = _RANDOM[6'hB][20];	// functional-unit.scala:229:23
        r_uops_0_dst_rtype = _RANDOM[6'hC][19:18];	// functional-unit.scala:229:23
        r_uops_1_br_mask = _RANDOM[6'h12][19:0];	// functional-unit.scala:229:23
        r_uops_1_rob_idx = _RANDOM[6'h14][13:7];	// functional-unit.scala:229:23
        r_uops_1_pdst = {_RANDOM[6'h14][31:26], _RANDOM[6'h15][0]};	// functional-unit.scala:229:23
        r_uops_1_bypassable = _RANDOM[6'h18][8];	// functional-unit.scala:229:23
        r_uops_1_is_amo = _RANDOM[6'h18][19];	// functional-unit.scala:229:23
        r_uops_1_uses_stq = _RANDOM[6'h18][21];	// functional-unit.scala:229:23
        r_uops_1_dst_rtype = _RANDOM[6'h19][20:19];	// functional-unit.scala:229:23
        r_uops_2_br_mask = _RANDOM[6'h1F][20:1];	// functional-unit.scala:229:23
        r_uops_2_rob_idx = _RANDOM[6'h21][14:8];	// functional-unit.scala:229:23
        r_uops_2_pdst = {_RANDOM[6'h21][31:27], _RANDOM[6'h22][1:0]};	// functional-unit.scala:229:23
        r_uops_2_bypassable = _RANDOM[6'h25][9];	// functional-unit.scala:229:23
        r_uops_2_is_amo = _RANDOM[6'h25][20];	// functional-unit.scala:229:23
        r_uops_2_uses_stq = _RANDOM[6'h25][22];	// functional-unit.scala:229:23
        r_uops_2_dst_rtype = _RANDOM[6'h26][21:20];	// functional-unit.scala:229:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  PipelinedMultiplier imul (	// functional-unit.scala:708:20
    .clock             (clock),
    .reset             (reset),
    .io_req_valid      (io_req_valid),
    .io_req_bits_fn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_in1   (io_req_bits_rs1_data),
    .io_req_bits_in2   (io_req_bits_rs2_data),
    .io_resp_bits_data (io_resp_bits_data)
  );
  assign io_resp_valid =
    r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 20'h0;	// functional-unit.scala:228:27, :229:23, :249:47, util.scala:118:{51,59}
  assign io_resp_bits_uop_rob_idx = r_uops_2_rob_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_pdst = r_uops_2_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_bypassable = r_uops_2_bypassable;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_amo = r_uops_2_is_amo;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_uses_stq = r_uops_2_uses_stq;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_dst_rtype = r_uops_2_dst_rtype;	// functional-unit.scala:229:23
endmodule

