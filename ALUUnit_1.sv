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

module ALUUnit_1(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_is_rvc,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_bits_uop_ctrl_csr_cmd,
  input         io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [19:0] io_req_bits_uop_br_mask,
  input  [4:0]  io_req_bits_uop_br_tag,
  input  [5:0]  io_req_bits_uop_ftq_idx,
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
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [2:0]  io_resp_bits_uop_ctrl_csr_cmd,
  output [19:0] io_resp_bits_uop_imm_packed,
  output [6:0]  io_resp_bits_uop_rob_idx,
                io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data,
  output        io_bypass_0_valid,
  output [6:0]  io_bypass_0_bits_uop_pdst,
  output [1:0]  io_bypass_0_bits_uop_dst_rtype,
  output [63:0] io_bypass_0_bits_data,
  output        io_brinfo_uop_is_rvc,
  output [19:0] io_brinfo_uop_br_mask,
  output [4:0]  io_brinfo_uop_br_tag,
  output [5:0]  io_brinfo_uop_ftq_idx,
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

  wire [63:0] _alu_io_out;	// functional-unit.scala:320:19
  reg         r_valids_0;	// functional-unit.scala:228:27
  reg  [2:0]  r_uops_0_ctrl_csr_cmd;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_0_br_mask;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_0_imm_packed;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_rob_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_pdst;	// functional-unit.scala:229:23
  reg         r_uops_0_bypassable;	// functional-unit.scala:229:23
  reg         r_uops_0_is_amo;	// functional-unit.scala:229:23
  reg         r_uops_0_uses_stq;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_dst_rtype;	// functional-unit.scala:229:23
  wire [19:0] _r_valids_0_T = io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask;	// util.scala:118:51
  wire        _imm_xprlen_i4_1_T = io_req_bits_uop_ctrl_imm_sel == 3'h3;	// util.scala:274:27
  wire [10:0] imm_xprlen_i30_20 =
    _imm_xprlen_i4_1_T
      ? io_req_bits_uop_imm_packed[18:8]
      : {11{io_req_bits_uop_imm_packed[19]}};	// util.scala:273:18, :274:{21,27,39}
  wire        _imm_xprlen_i11_T_1 = io_req_bits_uop_ctrl_imm_sel == 3'h4;	// util.scala:275:44
  wire [7:0]  imm_xprlen_i19_12 =
    _imm_xprlen_i4_1_T | _imm_xprlen_i11_T_1
      ? io_req_bits_uop_imm_packed[7:0]
      : {8{io_req_bits_uop_imm_packed[19]}};	// util.scala:273:18, :274:27, :275:{21,36,44,56}
  wire        imm_xprlen_i11 =
    ~_imm_xprlen_i4_1_T
    & (_imm_xprlen_i11_T_1 | io_req_bits_uop_ctrl_imm_sel == 3'h2
         ? io_req_bits_uop_imm_packed[8]
         : io_req_bits_uop_imm_packed[19]);	// util.scala:273:18, :274:27, :275:44, :276:21, :277:{21,36,44,56}
  wire [4:0]  imm_xprlen_i10_5 =
    _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[18:14];	// util.scala:274:27, :278:{21,44}
  wire [4:0]  imm_xprlen_i4_1 =
    _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[13:9];	// util.scala:274:27, :279:{21,44}
  wire        imm_xprlen_i0 =
    (io_req_bits_uop_ctrl_imm_sel == 3'h1 | io_req_bits_uop_ctrl_imm_sel == 3'h0)
    & io_req_bits_uop_imm_packed[8];	// util.scala:277:56, :280:{21,27,36,44}
  wire        killed = io_req_bits_kill | (|_r_valids_0_T);	// functional-unit.scala:331:26, util.scala:118:{51,59}
  wire        br_eq = io_req_bits_rs1_data == io_req_bits_rs2_data;	// functional-unit.scala:337:21
  wire        br_ltu = io_req_bits_rs1_data < io_req_bits_rs2_data;	// functional-unit.scala:338:28
  wire        br_lt =
    (io_req_bits_rs1_data[63] ^ ~(io_req_bits_rs2_data[63])) & br_ltu
    | io_req_bits_rs1_data[63] & ~(io_req_bits_rs2_data[63]);	// functional-unit.scala:338:28, :339:{17,22,36,46,55}, :340:{29,31}
  wire [1:0]  brinfo_pc_sel =
    io_req_bits_uop_ctrl_br_type == 4'h8
      ? 2'h2
      : io_req_bits_uop_ctrl_br_type == 4'h7
          ? 2'h1
          : {1'h0,
             io_req_bits_uop_ctrl_br_type == 4'h6
               ? br_ltu
               : io_req_bits_uop_ctrl_br_type == 4'h5
                   ? br_lt
                   : io_req_bits_uop_ctrl_br_type == 4'h4
                       ? ~br_ltu
                       : io_req_bits_uop_ctrl_br_type == 4'h3
                           ? ~br_lt
                           : io_req_bits_uop_ctrl_br_type == 4'h2
                               ? br_eq
                               : io_req_bits_uop_ctrl_br_type == 4'h1 & ~br_eq};	// Mux.scala:80:{57,60}, functional-unit.scala:317:56, :337:21, :338:28, :339:55, :344:{38,39}, :346:39, :347:39
  wire        is_br =
    io_req_valid & ~killed & io_req_bits_uop_is_br & ~io_req_bits_uop_is_sfb;	// functional-unit.scala:331:26, :355:20, :362:{61,64}
  wire        is_jalr = io_req_valid & ~killed & io_req_bits_uop_is_jalr;	// functional-unit.scala:331:26, :355:20, :364:48
  wire        brinfo_valid = is_br | is_jalr;	// functional-unit.scala:362:61, :364:48, :366:15
  `ifndef SYNTHESIS	// functional-unit.scala:368:14
    always @(posedge clock) begin	// functional-unit.scala:368:14
      if (brinfo_valid & ~(brinfo_pc_sel != 2'h2 | reset)) begin	// Mux.scala:80:57, functional-unit.scala:317:56, :366:15, :368:{14,22}
        if (`ASSERT_VERBOSE_COND_)	// functional-unit.scala:368:14
          $error("Assertion failed\n    at functional-unit.scala:368 assert (pc_sel =/= PC_JALR)\n");	// functional-unit.scala:368:14
        if (`STOP_COND_)	// functional-unit.scala:368:14
          $fatal;	// functional-unit.scala:368:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg  [63:0] r_data_0;	// functional-unit.scala:440:19
  wire        _alu_out_T_5 = io_req_bits_uop_uopc == 7'h6D;	// functional-unit.scala:444:30
  always @(posedge clock) begin
    if (reset)
      r_valids_0 <= 1'h0;	// functional-unit.scala:228:27
    else
      r_valids_0 <= io_req_valid & _r_valids_0_T == 20'h0 & ~io_req_bits_kill;	// functional-unit.scala:228:27, :232:{84,87}, util.scala:118:{51,59}
    r_uops_0_ctrl_csr_cmd <= io_req_bits_uop_ctrl_csr_cmd;	// functional-unit.scala:229:23
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_0_imm_packed <= io_req_bits_uop_imm_packed;	// functional-unit.scala:229:23
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;	// functional-unit.scala:229:23
    r_uops_0_pdst <= io_req_bits_uop_pdst;	// functional-unit.scala:229:23
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;	// functional-unit.scala:229:23
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;	// functional-unit.scala:229:23
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;	// functional-unit.scala:229:23
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;	// functional-unit.scala:229:23
    if (_alu_out_T_5)	// functional-unit.scala:444:30
      r_data_0 <= io_req_bits_rs2_data;	// functional-unit.scala:440:19
    else	// functional-unit.scala:444:30
      r_data_0 <= _alu_io_out;	// functional-unit.scala:320:19, :440:19
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:15];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h10; i += 5'h1) begin
          _RANDOM[i[3:0]] = `RANDOM;
        end
        r_valids_0 = _RANDOM[4'h0][0];	// functional-unit.scala:228:27
        r_uops_0_ctrl_csr_cmd = _RANDOM[4'h4][17:15];	// functional-unit.scala:229:23
        r_uops_0_br_mask = {_RANDOM[4'h4][31:29], _RANDOM[4'h5][16:0]};	// functional-unit.scala:229:23
        r_uops_0_imm_packed = _RANDOM[4'h6][23:4];	// functional-unit.scala:229:23
        r_uops_0_rob_idx = _RANDOM[4'h7][10:4];	// functional-unit.scala:229:23
        r_uops_0_pdst = _RANDOM[4'h7][29:23];	// functional-unit.scala:229:23
        r_uops_0_bypassable = _RANDOM[4'hB][5];	// functional-unit.scala:229:23
        r_uops_0_is_amo = _RANDOM[4'hB][16];	// functional-unit.scala:229:23
        r_uops_0_uses_stq = _RANDOM[4'hB][18];	// functional-unit.scala:229:23
        r_uops_0_dst_rtype = _RANDOM[4'hC][17:16];	// functional-unit.scala:229:23
        r_data_0 = {_RANDOM[4'hD][31:3], _RANDOM[4'hE], _RANDOM[4'hF][2:0]};	// functional-unit.scala:440:19
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ALU alu (	// functional-unit.scala:320:19
    .io_dw        (io_req_bits_uop_ctrl_fcn_dw),
    .io_fn        (io_req_bits_uop_ctrl_op_fcn),
    .io_in2
      (io_req_bits_uop_ctrl_op2_sel == 3'h1
         ? {{33{io_req_bits_uop_imm_packed[19]}},
            imm_xprlen_i30_20,
            imm_xprlen_i19_12,
            imm_xprlen_i11,
            imm_xprlen_i10_5,
            imm_xprlen_i4_1,
            imm_xprlen_i0}
         : io_req_bits_uop_ctrl_op2_sel == 3'h4
             ? {59'h0, io_req_bits_uop_prs1[4:0]}
             : io_req_bits_uop_ctrl_op2_sel == 3'h0
                 ? io_req_bits_rs2_data
                 : {61'h0,
                    io_req_bits_uop_ctrl_op2_sel == 3'h3
                      ? (io_req_bits_uop_is_rvc ? 3'h2 : 3'h4)
                      : 3'h0}),	// Cat.scala:30:58, functional-unit.scala:314:{21,39}, :315:{21,39,73}, :316:{21,39}, :317:{21,39,56}, util.scala:273:18, :274:{21,27}, :275:{21,44}, :276:21, :277:44, :278:21, :279:21, :280:{21,27}
    .io_in1       (io_req_bits_uop_ctrl_op1_sel == 2'h0 ? io_req_bits_rs1_data : 64'h0),	// functional-unit.scala:309:{19,44}
    .io_out       (_alu_io_out),
    .io_adder_out (/* unused */),
    .io_cmp_out   (/* unused */)
  );
  assign io_resp_valid =
    r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0;	// functional-unit.scala:228:27, :229:23, :249:47, util.scala:118:{51,59}
  assign io_resp_bits_uop_ctrl_csr_cmd = r_uops_0_ctrl_csr_cmd;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_imm_packed = r_uops_0_imm_packed;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_rob_idx = r_uops_0_rob_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_pdst = r_uops_0_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_bypassable = r_uops_0_bypassable;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_amo = r_uops_0_is_amo;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_uses_stq = r_uops_0_uses_stq;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_dst_rtype = r_uops_0_dst_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_data = r_data_0;	// functional-unit.scala:440:19
  assign io_bypass_0_valid = io_req_valid;
  assign io_bypass_0_bits_uop_pdst = io_req_bits_uop_pdst;
  assign io_bypass_0_bits_uop_dst_rtype = io_req_bits_uop_dst_rtype;
  assign io_bypass_0_bits_data = _alu_out_T_5 ? io_req_bits_rs2_data : _alu_io_out;	// functional-unit.scala:320:19, :444:{8,30}
  assign io_brinfo_uop_is_rvc = io_req_bits_uop_is_rvc;
  assign io_brinfo_uop_br_mask = io_req_bits_uop_br_mask;
  assign io_brinfo_uop_br_tag = io_req_bits_uop_br_tag;
  assign io_brinfo_uop_ftq_idx = io_req_bits_uop_ftq_idx;
  assign io_brinfo_uop_edge_inst = io_req_bits_uop_edge_inst;
  assign io_brinfo_uop_pc_lob = io_req_bits_uop_pc_lob;
  assign io_brinfo_uop_rob_idx = io_req_bits_uop_rob_idx;
  assign io_brinfo_uop_ldq_idx = io_req_bits_uop_ldq_idx;
  assign io_brinfo_uop_stq_idx = io_req_bits_uop_stq_idx;
  assign io_brinfo_valid = brinfo_valid;	// functional-unit.scala:366:15
  assign io_brinfo_mispredict =
    brinfo_valid
    & (brinfo_pc_sel == 2'h1
         ? ~io_req_bits_uop_taken
         : brinfo_pc_sel == 2'h0 & io_req_bits_uop_taken);	// Mux.scala:80:57, functional-unit.scala:344:38, :366:{15,27}, :370:{18,32}, :371:18, :373:{18,32}, :374:{18,21}
  assign io_brinfo_taken =
    io_req_valid & ~killed
    & (io_req_bits_uop_is_br | io_req_bits_uop_is_jalr | io_req_bits_uop_is_jal)
    & (|brinfo_pc_sel);	// Mux.scala:80:57, functional-unit.scala:331:26, :355:20, :356:{46,61}, :357:28
  assign io_brinfo_cfi_type = is_jalr ? 3'h3 : {2'h0, is_br};	// functional-unit.scala:362:61, :364:48, :384:31, :385:31, util.scala:274:27
  assign io_brinfo_pc_sel = brinfo_pc_sel;	// Mux.scala:80:57
  assign io_brinfo_target_offset =
    {imm_xprlen_i30_20[0],
     imm_xprlen_i19_12,
     imm_xprlen_i11,
     imm_xprlen_i10_5,
     imm_xprlen_i4_1,
     imm_xprlen_i0};	// functional-unit.scala:395:33, util.scala:274:21, :275:21, :276:21, :278:21, :279:21, :280:21
endmodule

