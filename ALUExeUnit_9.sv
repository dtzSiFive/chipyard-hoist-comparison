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

module ALUExeUnit_9(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_is_rvc,
  input  [9:0]  io_req_bits_uop_fu_code,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
                io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [15:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [4:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_iresp_valid,
  output [6:0]  io_iresp_bits_uop_rob_idx,
                io_iresp_bits_uop_pdst,
  output        io_iresp_bits_uop_bypassable,
                io_iresp_bits_uop_is_amo,
                io_iresp_bits_uop_uses_stq,
  output [1:0]  io_iresp_bits_uop_dst_rtype,
  output [64:0] io_iresp_bits_data,
  output        io_bypass_0_valid,
  output [6:0]  io_bypass_0_bits_uop_pdst,
  output [1:0]  io_bypass_0_bits_uop_dst_rtype,
  output [64:0] io_bypass_0_bits_data,
  output        io_bypass_1_valid,
  output [6:0]  io_bypass_1_bits_uop_pdst,
  output [1:0]  io_bypass_1_bits_uop_dst_rtype,
  output [64:0] io_bypass_1_bits_data,
  output        io_bypass_2_valid,
  output [6:0]  io_bypass_2_bits_uop_pdst,
  output [1:0]  io_bypass_2_bits_uop_dst_rtype,
  output [64:0] io_bypass_2_bits_data,
  output        io_brinfo_uop_is_rvc,
  output [15:0] io_brinfo_uop_br_mask,
  output [3:0]  io_brinfo_uop_br_tag,
  output [4:0]  io_brinfo_uop_ftq_idx,
  output        io_brinfo_uop_edge_inst,
  output [5:0]  io_brinfo_uop_pc_lob,
  output [6:0]  io_brinfo_uop_rob_idx,
  output [4:0]  io_brinfo_uop_ldq_idx,
                io_brinfo_uop_stq_idx,
  output        io_brinfo_valid,
                io_brinfo_mispredict,
                io_brinfo_taken,
  output [2:0]  io_brinfo_cfi_type,
  output [1:0]  io_brinfo_pc_sel,
  output [20:0] io_brinfo_target_offset
);

  wire        _imul_io_resp_valid;	// execution-unit.scala:317:18
  wire [6:0]  _imul_io_resp_bits_uop_rob_idx;	// execution-unit.scala:317:18
  wire [6:0]  _imul_io_resp_bits_uop_pdst;	// execution-unit.scala:317:18
  wire        _imul_io_resp_bits_uop_bypassable;	// execution-unit.scala:317:18
  wire        _imul_io_resp_bits_uop_is_amo;	// execution-unit.scala:317:18
  wire        _imul_io_resp_bits_uop_uses_stq;	// execution-unit.scala:317:18
  wire [1:0]  _imul_io_resp_bits_uop_dst_rtype;	// execution-unit.scala:317:18
  wire [63:0] _imul_io_resp_bits_data;	// execution-unit.scala:317:18
  wire        _alu_io_resp_valid;	// execution-unit.scala:262:17
  wire [6:0]  _alu_io_resp_bits_uop_rob_idx;	// execution-unit.scala:262:17
  wire [6:0]  _alu_io_resp_bits_uop_pdst;	// execution-unit.scala:262:17
  wire        _alu_io_resp_bits_uop_bypassable;	// execution-unit.scala:262:17
  wire        _alu_io_resp_bits_uop_is_amo;	// execution-unit.scala:262:17
  wire        _alu_io_resp_bits_uop_uses_stq;	// execution-unit.scala:262:17
  wire [1:0]  _alu_io_resp_bits_uop_dst_rtype;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_resp_bits_data;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_bypass_0_bits_data;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_bypass_1_bits_data;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_bypass_2_bits_data;	// execution-unit.scala:262:17
  `ifndef SYNTHESIS	// execution-unit.scala:416:10
    always @(posedge clock) begin	// execution-unit.scala:416:10
      automatic logic [1:0] _GEN =
        {1'h0, _alu_io_resp_valid} + {1'h0, _imul_io_resp_valid};	// Bitwise.scala:47:55, execution-unit.scala:262:17, :284:15, :317:18
      if (~(~(_GEN[1]) | reset)) begin	// Bitwise.scala:47:55, execution-unit.scala:416:{10,58}
        if (`ASSERT_VERBOSE_COND_)	// execution-unit.scala:416:10
          $error("Assertion failed: Multiple functional units are fighting over the write port.\n    at execution-unit.scala:416 assert ((PopCount(iresp_fu_units.map(_.io.resp.valid)) <= 1.U && !div_resp_val) ||\n");	// execution-unit.scala:416:10
        if (`STOP_COND_)	// execution-unit.scala:416:10
          $fatal;	// execution-unit.scala:416:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  ALUUnit_6 alu (	// execution-unit.scala:262:17
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid
      (io_req_valid
       & (io_req_bits_uop_fu_code == 10'h1 | io_req_bits_uop_fu_code == 10'h2
          | io_req_bits_uop_fu_code == 10'h20 & io_req_bits_uop_uopc != 7'h6C)),	// execution-unit.scala:251:21, :254:21, :255:21, :266:20, :267:32, :268:{32,43}, :269:{32,43,67}
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_is_rvc         (io_req_bits_uop_is_rvc),
    .io_req_bits_uop_ctrl_br_type   (io_req_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel   (io_req_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel   (io_req_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel   (io_req_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_is_br          (io_req_bits_uop_is_br),
    .io_req_bits_uop_is_jalr        (io_req_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal         (io_req_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb         (io_req_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask        (io_req_bits_uop_br_mask),
    .io_req_bits_uop_br_tag         (io_req_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx        (io_req_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst      (io_req_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob         (io_req_bits_uop_pc_lob),
    .io_req_bits_uop_taken          (io_req_bits_uop_taken),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx        (io_req_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx        (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_pdst           (io_req_bits_uop_pdst),
    .io_req_bits_uop_prs1           (io_req_bits_uop_prs1),
    .io_req_bits_uop_bypassable     (io_req_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (io_req_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data[63:0]),	// execution-unit.scala:274:30
    .io_req_bits_rs2_data           (io_req_bits_rs2_data[63:0]),	// execution-unit.scala:275:30
    .io_req_bits_kill               (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                  (_alu_io_resp_valid),
    .io_resp_bits_uop_rob_idx       (_alu_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_pdst          (_alu_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_bypassable    (_alu_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_is_amo        (_alu_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_stq      (_alu_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype     (_alu_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_data              (_alu_io_resp_bits_data),
    .io_bypass_0_valid              (io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst      (io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype (io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data          (_alu_io_bypass_0_bits_data),
    .io_bypass_1_valid              (io_bypass_1_valid),
    .io_bypass_1_bits_uop_pdst      (io_bypass_1_bits_uop_pdst),
    .io_bypass_1_bits_uop_dst_rtype (io_bypass_1_bits_uop_dst_rtype),
    .io_bypass_1_bits_data          (_alu_io_bypass_1_bits_data),
    .io_bypass_2_valid              (io_bypass_2_valid),
    .io_bypass_2_bits_uop_pdst      (io_bypass_2_bits_uop_pdst),
    .io_bypass_2_bits_uop_dst_rtype (io_bypass_2_bits_uop_dst_rtype),
    .io_bypass_2_bits_data          (_alu_io_bypass_2_bits_data),
    .io_brinfo_uop_is_rvc           (io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask          (io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag           (io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx          (io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst        (io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob           (io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx          (io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx          (io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx          (io_brinfo_uop_stq_idx),
    .io_brinfo_valid                (io_brinfo_valid),
    .io_brinfo_mispredict           (io_brinfo_mispredict),
    .io_brinfo_taken                (io_brinfo_taken),
    .io_brinfo_cfi_type             (io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (io_brinfo_pc_sel),
    .io_brinfo_target_offset        (io_brinfo_target_offset)
  );
  PipelinedMulUnit_1 imul (	// execution-unit.scala:317:18
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (io_req_valid & io_req_bits_uop_fu_code[3]),	// execution-unit.scala:319:47, micro-op.scala:154:40
    .io_req_bits_uop_ctrl_op_fcn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_br_mask        (io_req_bits_uop_br_mask),
    .io_req_bits_uop_rob_idx        (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_pdst           (io_req_bits_uop_pdst),
    .io_req_bits_uop_bypassable     (io_req_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (io_req_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data[63:0]),	// execution-unit.scala:274:30
    .io_req_bits_rs2_data           (io_req_bits_rs2_data[63:0]),	// execution-unit.scala:275:30
    .io_req_bits_kill               (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                  (_imul_io_resp_valid),
    .io_resp_bits_uop_rob_idx       (_imul_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_pdst          (_imul_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_bypassable    (_imul_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_is_amo        (_imul_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_stq      (_imul_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype     (_imul_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_data              (_imul_io_resp_bits_data)
  );
  assign io_iresp_valid = _alu_io_resp_valid | _imul_io_resp_valid;	// execution-unit.scala:262:17, :317:18, :400:71
  assign io_iresp_bits_uop_rob_idx =
    _alu_io_resp_valid ? _alu_io_resp_bits_uop_rob_idx : _imul_io_resp_bits_uop_rob_idx;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_uop_pdst =
    _alu_io_resp_valid ? _alu_io_resp_bits_uop_pdst : _imul_io_resp_bits_uop_pdst;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_uop_bypassable =
    _alu_io_resp_valid
      ? _alu_io_resp_bits_uop_bypassable
      : _imul_io_resp_bits_uop_bypassable;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_uop_is_amo =
    _alu_io_resp_valid ? _alu_io_resp_bits_uop_is_amo : _imul_io_resp_bits_uop_is_amo;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_uop_uses_stq =
    _alu_io_resp_valid ? _alu_io_resp_bits_uop_uses_stq : _imul_io_resp_bits_uop_uses_stq;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_uop_dst_rtype =
    _alu_io_resp_valid
      ? _alu_io_resp_bits_uop_dst_rtype
      : _imul_io_resp_bits_uop_dst_rtype;	// Mux.scala:47:69, execution-unit.scala:262:17, :317:18
  assign io_iresp_bits_data =
    {1'h0, _alu_io_resp_valid ? _alu_io_resp_bits_data : _imul_io_resp_bits_data};	// Mux.scala:47:69, execution-unit.scala:262:17, :284:15, :317:18, :403:24
  assign io_bypass_0_bits_data = {1'h0, _alu_io_bypass_0_bits_data};	// execution-unit.scala:262:17, :284:15
  assign io_bypass_1_bits_data = {1'h0, _alu_io_bypass_1_bits_data};	// execution-unit.scala:262:17, :284:15
  assign io_bypass_2_bits_data = {1'h0, _alu_io_bypass_2_bits_data};	// execution-unit.scala:262:17, :284:15
endmodule

