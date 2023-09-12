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

module IBuf(
  input         clock,
                reset,
                io_imem_valid,
                io_imem_bits_btb_taken,
                io_imem_bits_btb_bridx,
  input  [4:0]  io_imem_bits_btb_entry,
  input  [7:0]  io_imem_bits_btb_bht_history,
  input  [39:0] io_imem_bits_pc,
  input  [31:0] io_imem_bits_data,
  input         io_imem_bits_xcpt_pf_inst,
                io_imem_bits_xcpt_ae_inst,
                io_imem_bits_replay,
                io_kill,
                io_inst_0_ready,
  output        io_imem_ready,
  output [39:0] io_pc,
  output [4:0]  io_btb_resp_entry,
  output [7:0]  io_btb_resp_bht_history,
  output        io_inst_0_valid,
                io_inst_0_bits_xcpt0_pf_inst,
                io_inst_0_bits_xcpt0_ae_inst,
                io_inst_0_bits_xcpt1_pf_inst,
                io_inst_0_bits_xcpt1_ae_inst,
                io_inst_0_bits_replay,
                io_inst_0_bits_rvc,
  output [31:0] io_inst_0_bits_inst_bits,
  output [4:0]  io_inst_0_bits_inst_rd,
                io_inst_0_bits_inst_rs1,
                io_inst_0_bits_inst_rs2,
                io_inst_0_bits_inst_rs3,
  output [31:0] io_inst_0_bits_raw
);

  wire [1:0]   nReady;	// IBuf.scala:102:{56,65}
  wire         _exp_io_rvc;	// IBuf.scala:86:21
  reg          nBufValid;	// IBuf.scala:34:47
  reg  [39:0]  buf_pc;	// IBuf.scala:35:16
  reg  [31:0]  buf_data;	// IBuf.scala:35:16
  reg          buf_xcpt_pf_inst;	// IBuf.scala:35:16
  reg          buf_xcpt_ae_inst;	// IBuf.scala:35:16
  reg          buf_replay;	// IBuf.scala:35:16
  reg  [4:0]   ibufBTBResp_entry;	// IBuf.scala:36:24
  reg  [7:0]   ibufBTBResp_bht_history;	// IBuf.scala:36:24
  wire [1:0]   _GEN = {1'h0, io_imem_bits_pc[1]};	// IBuf.scala:34:47, :41:88, package.scala:154:13
  wire [1:0]   _nIC_T_2 =
    (io_imem_bits_btb_taken ? {1'h0, io_imem_bits_btb_bridx} + 2'h1 : 2'h2) - _GEN;	// IBuf.scala:34:47, :41:{16,64,88}, :92:63
  wire [1:0]   _GEN_0 = {1'h0, nBufValid};	// IBuf.scala:34:47, :42:25
  wire [1:0]   _nICReady_T = nReady - _GEN_0;	// IBuf.scala:42:25, :102:{56,65}
  wire         _nBufValid_T = nReady >= _GEN_0;	// IBuf.scala:42:25, :44:47, :102:{56,65}
  wire [1:0]   _nBufValid_T_6 = _nIC_T_2 - _nICReady_T;	// IBuf.scala:41:88, :42:25, :44:92
  wire [190:0] _icData_T_1 =
    {63'h0,
     {2{{2{io_imem_bits_data[31:16]}}}},
     io_imem_bits_data,
     {2{io_imem_bits_data[15:0]}}} << {185'h0, _GEN_0 - 2'h2 - _GEN, 4'h0};	// Cat.scala:30:58, IBuf.scala:41:88, :42:25, :68:{32,44}, :69:87, :120:58, :121:10, :128:19
  wire [62:0]  _icMask_T_2 = 63'hFFFFFFFF << {58'h0, nBufValid, 4'h0};	// IBuf.scala:34:47, :71:51, :128:{10,19}
  wire [31:0]  inst =
    _icData_T_1[95:64] & _icMask_T_2[31:0] | buf_data & ~(_icMask_T_2[31:0]);	// IBuf.scala:35:16, :71:{51,92}, :72:{21,30,41,43}, :121:10, package.scala:154:13
  wire [3:0]   _valid_T = 4'h1 << (io_imem_valid ? _nIC_T_2 : 2'h0) + _GEN_0;	// IBuf.scala:41:88, :42:25, :43:{19,49}, OneHot.scala:58:35
  wire [1:0]   _valid_T_1 = _valid_T[1:0] - 2'h1;	// IBuf.scala:74:33, OneHot.scala:58:35
  wire [1:0]   _bufMask_T_1 = (2'h1 << _GEN_0) - 2'h1;	// IBuf.scala:42:25, :75:37, :92:63, OneHot.scala:58:35
  wire [1:0]   buf_replay_0 = buf_replay ? _bufMask_T_1 : 2'h0;	// IBuf.scala:35:16, :75:37, :77:23
  wire [1:0]   ic_replay =
    buf_replay_0 | (io_imem_bits_replay ? _valid_T_1 & ~_bufMask_T_1 : 2'h0);	// IBuf.scala:74:33, :75:37, :77:23, :78:{30,35,63,65}
  `ifndef SYNTHESIS	// IBuf.scala:79:9
    always @(posedge clock) begin	// IBuf.scala:79:9
      if (~(~io_imem_valid | ~io_imem_bits_btb_taken
            | io_imem_bits_btb_bridx >= io_imem_bits_pc[1] | reset)) begin	// IBuf.scala:79:{9,10,28,78}, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// IBuf.scala:79:9
          $error("Assertion failed\n    at IBuf.scala:79 assert(!io.imem.valid || !io.imem.bits.btb.taken || io.imem.bits.btb.bridx >= pcWordBits)\n");	// IBuf.scala:79:9
        if (`STOP_COND_)	// IBuf.scala:79:9
          $fatal;	// IBuf.scala:79:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire         full_insn = _exp_io_rvc | _valid_T_1[1] | buf_replay_0[0];	// IBuf.scala:41:64, :74:{33,37}, :77:23, :86:21, :93:{42,48,61}
  wire [1:0]   _io_inst_0_bits_xcpt1_WIRE_1 =
    _exp_io_rvc
      ? 2'h0
      : {_bufMask_T_1[1] ? buf_xcpt_pf_inst : io_imem_bits_xcpt_pf_inst,
         _bufMask_T_1[1] ? buf_xcpt_ae_inst : io_imem_bits_xcpt_ae_inst};	// IBuf.scala:35:16, :75:37, :76:{53,61}, :86:21, :96:{35,63}
  wire         _GEN_1 = _bufMask_T_1[0] & _exp_io_rvc | _bufMask_T_1[1];	// IBuf.scala:41:64, :75:37, :86:21, :100:{21,25,40,50}
  assign nReady = full_insn ? (_exp_io_rvc ? 2'h1 : 2'h2) : 2'h0;	// IBuf.scala:41:16, :86:21, :92:63, :93:48, :102:{56,65,71}
  always @(posedge clock) begin
    automatic logic _GEN_2;	// IBuf.scala:54:68
    _GEN_2 = io_imem_valid & _nBufValid_T & _nICReady_T < _nIC_T_2 & ~(_nBufValid_T_6[1]);	// IBuf.scala:41:88, :42:25, :44:{47,85,92}, :54:{62,68,73}
    if (reset)
      nBufValid <= 1'h0;	// IBuf.scala:34:47
    else
      nBufValid <=
        ~io_kill
        & (io_inst_0_ready
             ? (_GEN_2
                  ? _nBufValid_T_6[0]
                  : ~(_nBufValid_T | ~nBufValid) & nBufValid - nReady[0])
             : nBufValid);	// IBuf.scala:34:47, :44:{47,92}, :47:29, :48:{17,23,65}, :54:{68,92}, :56:{19,26}, :63:20, :64:17, :102:{56,65}, package.scala:209:{38,43}
    if (io_inst_0_ready & _GEN_2) begin	// IBuf.scala:35:16, :47:29, :54:{68,92}, :57:13
      automatic logic [63:0] _buf_data_T_1 =
        {{2{io_imem_bits_data[31:16]}}, io_imem_bits_data}
        >> {58'h0, _GEN + _nICReady_T, 4'h0};	// Cat.scala:30:58, IBuf.scala:41:88, :42:25, :55:32, :127:58, :128:{10,19}
      buf_pc <=
        io_imem_bits_pc & 40'hFFFFFFFFFC | io_imem_bits_pc + {37'h0, _nICReady_T, 1'h0}
        & 40'h3;	// IBuf.scala:34:47, :35:16, :42:25, :59:{35,37,49,68,109}
      buf_data <= {16'h0, _buf_data_T_1[15:0]};	// IBuf.scala:35:16, :58:{18,61}, :128:10
      buf_xcpt_pf_inst <= io_imem_bits_xcpt_pf_inst;	// IBuf.scala:35:16
      buf_xcpt_ae_inst <= io_imem_bits_xcpt_ae_inst;	// IBuf.scala:35:16
      buf_replay <= io_imem_bits_replay;	// IBuf.scala:35:16
      ibufBTBResp_entry <= io_imem_bits_btb_entry;	// IBuf.scala:36:24
      ibufBTBResp_bht_history <= io_imem_bits_btb_bht_history;	// IBuf.scala:36:24
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:6];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h7; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        nBufValid = _RANDOM[3'h0][0];	// IBuf.scala:34:47
        buf_pc = {_RANDOM[3'h1][31:28], _RANDOM[3'h2], _RANDOM[3'h3][3:0]};	// IBuf.scala:35:16
        buf_data = {_RANDOM[3'h3][31:4], _RANDOM[3'h4][3:0]};	// IBuf.scala:35:16
        buf_xcpt_pf_inst = _RANDOM[3'h4][6];	// IBuf.scala:35:16
        buf_xcpt_ae_inst = _RANDOM[3'h4][7];	// IBuf.scala:35:16
        buf_replay = _RANDOM[3'h4][8];	// IBuf.scala:35:16
        ibufBTBResp_entry = _RANDOM[3'h5][26:22];	// IBuf.scala:36:24
        ibufBTBResp_bht_history = {_RANDOM[3'h5][31:27], _RANDOM[3'h6][2:0]};	// IBuf.scala:36:24
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RVCExpander exp (	// IBuf.scala:86:21
    .io_in       (inst),	// IBuf.scala:72:30
    .io_out_bits (io_inst_0_bits_inst_bits),
    .io_out_rd   (io_inst_0_bits_inst_rd),
    .io_out_rs1  (io_inst_0_bits_inst_rs1),
    .io_out_rs2  (io_inst_0_bits_inst_rs2),
    .io_out_rs3  (io_inst_0_bits_inst_rs3),
    .io_rvc      (_exp_io_rvc)
  );
  assign io_imem_ready =
    io_inst_0_ready & _nBufValid_T & (_nICReady_T >= _nIC_T_2 | ~(_nBufValid_T_6[1]));	// IBuf.scala:41:88, :42:25, :44:{47,60,73,80,85,92}
  assign io_pc = nBufValid ? buf_pc : io_imem_bits_pc;	// IBuf.scala:34:47, :35:16, :82:15
  assign io_btb_resp_entry = _GEN_1 ? ibufBTBResp_entry : io_imem_bits_btb_entry;	// IBuf.scala:36:24, :81:15, :100:{40,57,71}
  assign io_btb_resp_bht_history =
    _GEN_1 ? ibufBTBResp_bht_history : io_imem_bits_btb_bht_history;	// IBuf.scala:36:24, :81:15, :100:{40,57,71}
  assign io_inst_0_valid = _valid_T_1[0] & full_insn;	// IBuf.scala:74:{33,37}, :93:48, :94:{32,36}
  assign io_inst_0_bits_xcpt0_pf_inst =
    _bufMask_T_1[0] ? buf_xcpt_pf_inst : io_imem_bits_xcpt_pf_inst;	// IBuf.scala:35:16, :75:37, :76:{53,61}
  assign io_inst_0_bits_xcpt0_ae_inst =
    _bufMask_T_1[0] ? buf_xcpt_ae_inst : io_imem_bits_xcpt_ae_inst;	// IBuf.scala:35:16, :75:37, :76:{53,61}
  assign io_inst_0_bits_xcpt1_pf_inst = _io_inst_0_bits_xcpt1_WIRE_1[1];	// IBuf.scala:96:{35,79}
  assign io_inst_0_bits_xcpt1_ae_inst = _io_inst_0_bits_xcpt1_WIRE_1[0];	// IBuf.scala:96:{35,79}
  assign io_inst_0_bits_replay = ic_replay[0] | ~_exp_io_rvc & ic_replay[1];	// IBuf.scala:41:64, :78:30, :86:21, :92:{29,33,37,49,61}
  assign io_inst_0_bits_rvc = _exp_io_rvc;	// IBuf.scala:86:21
  assign io_inst_0_bits_raw = inst;	// IBuf.scala:72:30
endmodule

