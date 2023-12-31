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

module MemAddrCalcUnit_2(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_ctrl_is_std,
  input  [15:0] io_req_bits_uop_br_mask,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [4:0]  io_req_bits_uop_mem_cmd,
  input  [1:0]  io_req_bits_uop_mem_size,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [15:0] io_resp_bits_uop_br_mask,
  output [39:0] io_resp_bits_addr,
  output        io_resp_bits_mxcpt_valid,
                io_resp_bits_sfence_valid,
                io_resp_bits_sfence_bits_rs1,
                io_resp_bits_sfence_bits_rs2,
  output [38:0] io_resp_bits_sfence_bits_addr
);

  wire [63:0] _sum_T_3 =
    io_req_bits_rs1_data[63:0]
    + {{52{io_req_bits_uop_imm_packed[19]}}, io_req_bits_uop_imm_packed[19:8]};	// functional-unit.scala:486:{42,70}
  wire        misaligned =
    io_req_bits_uop_mem_size == 2'h1 & _sum_T_3[0] | io_req_bits_uop_mem_size == 2'h2
    & (|(_sum_T_3[1:0])) | (&io_req_bits_uop_mem_size) & (|(_sum_T_3[2:0]));	// functional-unit.scala:486:42, :511:{11,19,40}, :512:{11,19,40,46,56}, :513:{11,19,40,46}
  wire        ma_ld = io_req_valid & io_req_bits_uop_uopc == 7'h1 & misaligned;	// functional-unit.scala:504:76, :512:56, :523:{53,63}
  wire        ma_st =
    io_req_valid & (io_req_bits_uop_uopc == 7'h2 | io_req_bits_uop_uopc == 7'h43)
    & misaligned;	// functional-unit.scala:505:41, :512:56, :524:{54,65,89,104}
  `ifndef SYNTHESIS	// functional-unit.scala:497:12
    always @(posedge clock) begin	// functional-unit.scala:497:12
      automatic logic _GEN = io_req_valid & io_req_bits_uop_ctrl_is_std;	// functional-unit.scala:497:28
      if (~(~(_GEN & io_req_bits_rs2_data[64]) | reset)) begin	// functional-unit.scala:497:{12,13,28,59}, :498:24
        if (`ASSERT_VERBOSE_COND_)	// functional-unit.scala:497:12
          $error("Assertion failed: 65th bit set in MemAddrCalcUnit.\n    at functional-unit.scala:497 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std &&\n");	// functional-unit.scala:497:12
        if (`STOP_COND_)	// functional-unit.scala:497:12
          $fatal;	// functional-unit.scala:497:12
      end
      if (~(~(_GEN & io_req_bits_uop_fp_val) | reset)) begin	// functional-unit.scala:497:28, :500:{12,13,59}
        if (`ASSERT_VERBOSE_COND_)	// functional-unit.scala:500:12
          $error("Assertion failed: FP store-data should now be going through a different unit.\n    at functional-unit.scala:500 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std && io.req.bits.uop.fp_val),\n");	// functional-unit.scala:500:12
        if (`STOP_COND_)	// functional-unit.scala:500:12
          $fatal;	// functional-unit.scala:500:12
      end
      if (~(~(io_req_bits_uop_fp_val & io_req_valid & io_req_bits_uop_uopc != 7'h1
              & io_req_bits_uop_uopc != 7'h2) | reset)) begin	// functional-unit.scala:504:{10,11,76}, :505:{17,41}
        if (`ASSERT_VERBOSE_COND_)	// functional-unit.scala:504:10
          $error("Assertion failed: [maddrcalc] assert we never get store data in here.\n    at functional-unit.scala:504 assert (!(io.req.bits.uop.fp_val && io.req.valid && io.req.bits.uop.uopc =/=\n");	// functional-unit.scala:504:10
        if (`STOP_COND_)	// functional-unit.scala:504:10
          $fatal;	// functional-unit.scala:504:10
      end
      if (~(~(ma_ld & ma_st) | reset)) begin	// functional-unit.scala:523:63, :524:104, :540:{10,11,19}
        if (`ASSERT_VERBOSE_COND_)	// functional-unit.scala:540:10
          $error("Assertion failed: Mutually-exclusive exceptions are firing.\n    at functional-unit.scala:540 assert (!(ma_ld && ma_st), \"Mutually-exclusive exceptions are firing.\")\n");	// functional-unit.scala:540:10
        if (`STOP_COND_)	// functional-unit.scala:540:10
          $fatal;	// functional-unit.scala:540:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign io_resp_valid =
    io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 16'h0;	// functional-unit.scala:268:38, util.scala:118:{51,59}
  assign io_resp_bits_uop_br_mask =
    io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}
  assign io_resp_bits_addr =
    {_sum_T_3[38] ? (&(_sum_T_3[63:39])) : (|(_sum_T_3[63:39])), _sum_T_3[38:0]};	// Cat.scala:30:58, functional-unit.scala:486:42, :487:{20,24,43,58}, :488:58, :489:43
  assign io_resp_bits_mxcpt_valid = ma_ld | ma_st;	// functional-unit.scala:523:63, :524:104, :531:26
  assign io_resp_bits_sfence_valid = io_req_valid & io_req_bits_uop_mem_cmd == 5'h14;	// functional-unit.scala:542:{45,72}
  assign io_resp_bits_sfence_bits_rs1 = io_req_bits_uop_mem_size[0];	// functional-unit.scala:543:59
  assign io_resp_bits_sfence_bits_rs2 = io_req_bits_uop_mem_size[1];	// functional-unit.scala:544:59
  assign io_resp_bits_sfence_bits_addr = io_req_bits_rs1_data[38:0];	// functional-unit.scala:545:33
endmodule

