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

module DebugTransportModuleJTAG(
  input         io_jtag_clock,
                io_jtag_reset,
                io_dmi_req_ready,
                io_dmi_resp_valid,
  input  [31:0] io_dmi_resp_bits_data,
  input  [1:0]  io_dmi_resp_bits_resp,
  input         io_jtag_TMS,
                io_jtag_TDI,
  output        io_dmi_req_valid,
  output [6:0]  io_dmi_req_bits_addr,
  output [31:0] io_dmi_req_bits_data,
  output [1:0]  io_dmi_req_bits_op,
  output        io_dmi_resp_ready,
                io_jtag_TDO_data
);

  wire        _GEN;	// JtagTap.scala:249:21, :250:26, :252:26
  wire        _GEN_0;	// DebugTransport.scala:208:26, :210:97
  wire        _GEN_1;	// DebugTransport.scala:98:24, :122:25, :210:97, :218:24
  wire        _tapIO_bypassChain_io_chainOut_data;	// JtagTap.scala:211:29
  wire [4:0]  _tapIO_controllerInternal_io_output_instruction;	// JtagTap.scala:203:36
  wire        _tapIO_controllerInternal_io_output_tapIsInTestLogicReset;	// JtagTap.scala:203:36
  wire        _tapIO_controllerInternal_io_dataChainOut_shift;	// JtagTap.scala:203:36
  wire        _tapIO_controllerInternal_io_dataChainOut_capture;	// JtagTap.scala:203:36
  wire        _tapIO_controllerInternal_io_dataChainOut_update;	// JtagTap.scala:203:36
  wire        _tapIO_idcodeChain_io_chainOut_data;	// JtagTap.scala:185:33
  wire        _dmiAccessChain_io_chainOut_data;	// DebugTransport.scala:136:31
  wire        _dmiAccessChain_io_update_valid;	// DebugTransport.scala:136:31
  wire [6:0]  _dmiAccessChain_io_update_bits_addr;	// DebugTransport.scala:136:31
  wire [31:0] _dmiAccessChain_io_update_bits_data;	// DebugTransport.scala:136:31
  wire [1:0]  _dmiAccessChain_io_update_bits_op;	// DebugTransport.scala:136:31
  wire        _dtmInfoChain_io_chainOut_data;	// DebugTransport.scala:130:29
  wire        _dtmInfoChain_io_update_valid;	// DebugTransport.scala:130:29
  wire        _dtmInfoChain_io_update_bits_dmireset;	// DebugTransport.scala:130:29
  reg         busyReg;	// DebugTransport.scala:98:24
  reg         stickyBusyReg;	// DebugTransport.scala:99:30
  reg         dmiStatus_hi;	// DebugTransport.scala:100:37
  reg         downgradeOpReg;	// DebugTransport.scala:102:31
  reg  [6:0]  dmiReqReg_addr;	// DebugTransport.scala:112:23
  reg  [31:0] dmiReqReg_data;	// DebugTransport.scala:112:23
  reg  [1:0]  dmiReqReg_op;	// DebugTransport.scala:112:23
  reg         dmiReqValidReg;	// DebugTransport.scala:113:31
  wire        _busy_T_1 = busyReg & ~io_dmi_resp_valid;	// DebugTransport.scala:98:24, :157:{20,22}
  wire        busy = _busy_T_1 | stickyBusyReg;	// DebugTransport.scala:99:30, :157:{20,42}
  wire        _nonzeroResp_T_1 = io_dmi_resp_valid & (|io_dmi_resp_bits_resp);	// DebugTransport.scala:180:{60,85}
  wire        _GEN_2 = busy | ~io_dmi_resp_valid;	// DebugTransport.scala:157:42, :199:40
  wire        _GEN_3 = io_dmi_req_ready & dmiReqValidReg;	// DebugTransport.scala:113:31, Decoupled.scala:40:37
  `ifndef SYNTHESIS	// DebugTransport.scala:205:9
    always @(posedge io_jtag_clock) begin	// DebugTransport.scala:205:9
      if (~(~(_dmiAccessChain_io_update_valid & _GEN_0 & _GEN_1 & _GEN_3)
            | io_jtag_reset)) begin	// DebugTransport.scala:98:24, :122:25, :136:31, :205:{9,10,29}, :208:26, :210:97, :218:24, Decoupled.scala:40:37
        if (`ASSERT_VERBOSE_COND_)	// DebugTransport.scala:205:9
          $error("Assertion failed: Conflicting updates for dmiReqValidReg, should not happen.\n    at DebugTransport.scala:205 assert(!(dmiReqValidCheck && io.dmi.req.fire()), \"Conflicting updates for dmiReqValidReg, should not happen.\");\n");	// DebugTransport.scala:205:9
        if (`STOP_COND_)	// DebugTransport.scala:205:9
          $fatal;	// DebugTransport.scala:205:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _GEN_4 = downgradeOpReg | _dmiAccessChain_io_update_bits_op == 2'h0;	// DebugTransport.scala:102:31, :136:31, :210:{32,69}
  assign _GEN_1 = ~_GEN_4;	// DebugTransport.scala:98:24, :122:25, :210:{32,97}, :218:24
  assign _GEN_0 = ~stickyBusyReg;	// DebugTransport.scala:99:30, :208:26, :210:97
  wire        _io_dmi_resp_ready_output =
    dmiReqReg_op == 2'h2 ? io_dmi_resp_valid : _GEN & ~busy;	// DebugTransport.scala:112:23, :157:42, :226:27, :227:18, :231:{41,43}, JtagTap.scala:249:21, :250:26, :252:26
  wire        tapIO_icodeSelects_0 =
    _tapIO_controllerInternal_io_output_instruction == 5'h1;	// JtagTap.scala:203:36, :227:82
  wire        tapIO_icodeSelects_0_1 =
    _tapIO_controllerInternal_io_output_instruction == 5'h10;	// JtagTap.scala:203:36, :227:82
  wire        tapIO_icodeSelects_0_2 =
    _tapIO_controllerInternal_io_output_instruction == 5'h11;	// JtagTap.scala:203:36, :227:82
  assign _GEN =
    tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_capture;	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
  always @(posedge io_jtag_clock or posedge io_jtag_reset) begin
    if (io_jtag_reset) begin
      busyReg <= 1'h0;	// DebugTransport.scala:98:24
      stickyBusyReg <= 1'h0;	// DebugTransport.scala:99:30
      dmiStatus_hi <= 1'h0;	// DebugTransport.scala:100:37
      downgradeOpReg <= 1'h0;	// DebugTransport.scala:102:31
      dmiReqValidReg <= 1'h0;	// DebugTransport.scala:113:31
    end
    else begin
      automatic logic _GEN_5 =
        _tapIO_controllerInternal_io_output_tapIsInTestLogicReset
        | _dtmInfoChain_io_update_valid & _dtmInfoChain_io_update_bits_dmireset;	// DebugTransport.scala:130:29, :165:44, :170:39, :171:49, :172:28, :173:21, :271:45, :273:19, JtagTap.scala:203:36
      busyReg <=
        ~(_tapIO_controllerInternal_io_output_tapIsInTestLogicReset
          | _io_dmi_resp_ready_output & io_dmi_resp_valid) & (dmiReqValidReg | busyReg);	// DebugTransport.scala:98:24, :113:31, :145:27, :146:13, :148:29, :149:13, :226:27, :271:45, :272:13, Decoupled.scala:40:37, JtagTap.scala:203:36
      stickyBusyReg <= ~_GEN_5 & (_GEN & _busy_T_1 | stickyBusyReg);	// DebugTransport.scala:99:30, :157:20, :165:44, :167:19, :170:39, :171:49, :173:21, :271:45, :273:19, JtagTap.scala:249:21, :250:26, :252:26
      dmiStatus_hi <= ~_GEN_5 & (_GEN & _nonzeroResp_T_1 | dmiStatus_hi);	// DebugTransport.scala:100:37, :165:44, :168:26, :170:39, :171:49, :172:28, :173:21, :180:60, :271:45, :273:19, :274:26, JtagTap.scala:249:21, :250:26, :252:26
      downgradeOpReg <=
        ~_tapIO_controllerInternal_io_output_tapIsInTestLogicReset
        & (_GEN
             ? ~busy & (dmiStatus_hi | _nonzeroResp_T_1)
             : ~_dmiAccessChain_io_update_valid & downgradeOpReg);	// DebugTransport.scala:100:37, :102:31, :136:31, :157:42, :162:41, :163:20, :165:44, :166:{20,24,30}, :180:{39,60}, :271:45, :275:20, JtagTap.scala:203:36, :249:21, :250:26, :252:26
      dmiReqValidReg <=
        ~(_tapIO_controllerInternal_io_output_tapIsInTestLogicReset | _GEN_3)
        & (_dmiAccessChain_io_update_valid & ~(stickyBusyReg | _GEN_4) | dmiReqValidReg);	// DebugTransport.scala:99:30, :113:31, :136:31, :207:41, :208:26, :210:{32,97}, :217:22, :222:28, :223:20, :271:45, :276:20, Decoupled.scala:40:37, JtagTap.scala:203:36
    end
  end // always @(posedge, posedge)
  always @(posedge io_jtag_clock) begin
    if (~_dmiAccessChain_io_update_valid | stickyBusyReg) begin	// DebugTransport.scala:99:30, :102:31, :112:23, :136:31, :162:41, :163:20, :207:41, :208:26
    end
    else if (_GEN_4) begin	// DebugTransport.scala:210:32
      dmiReqReg_addr <= 7'h0;	// DebugTransport.scala:112:23, :184:18
      dmiReqReg_data <= 32'h0;	// DebugTransport.scala:112:23, :186:18
      dmiReqReg_op <= 2'h0;	// DebugTransport.scala:112:23
    end
    else begin	// DebugTransport.scala:210:32
      dmiReqReg_addr <= _dmiAccessChain_io_update_bits_addr;	// DebugTransport.scala:112:23, :136:31
      dmiReqReg_data <= _dmiAccessChain_io_update_bits_data;	// DebugTransport.scala:112:23, :136:31
      dmiReqReg_op <= _dmiAccessChain_io_update_bits_op;	// DebugTransport.scala:112:23, :136:31
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:1];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        busyReg = _RANDOM[1'h0][0];	// DebugTransport.scala:98:24
        stickyBusyReg = _RANDOM[1'h0][1];	// DebugTransport.scala:98:24, :99:30
        dmiStatus_hi = _RANDOM[1'h0][2];	// DebugTransport.scala:98:24, :100:37
        downgradeOpReg = _RANDOM[1'h0][3];	// DebugTransport.scala:98:24, :102:31
        dmiReqReg_addr = _RANDOM[1'h0][10:4];	// DebugTransport.scala:98:24, :112:23
        dmiReqReg_data = {_RANDOM[1'h0][31:11], _RANDOM[1'h1][10:0]};	// DebugTransport.scala:98:24, :112:23
        dmiReqReg_op = _RANDOM[1'h1][12:11];	// DebugTransport.scala:112:23
        dmiReqValidReg = _RANDOM[1'h1][13];	// DebugTransport.scala:112:23, :113:31
      `endif // RANDOMIZE_REG_INIT
      if (io_jtag_reset) begin
        busyReg = 1'h0;	// DebugTransport.scala:98:24
        stickyBusyReg = 1'h0;	// DebugTransport.scala:99:30
        dmiStatus_hi = 1'h0;	// DebugTransport.scala:100:37
        downgradeOpReg = 1'h0;	// DebugTransport.scala:102:31
        dmiReqValidReg = 1'h0;	// DebugTransport.scala:113:31
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  CaptureUpdateChain dtmInfoChain (	// DebugTransport.scala:130:29
    .clock                     (io_jtag_clock),
    .reset                     (io_jtag_reset),
    .io_chainIn_shift
      (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_shift),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainIn_data           (tapIO_icodeSelects_0_1 & io_jtag_TDI),	// JtagTap.scala:227:82, :249:21, :250:26, :252:26
    .io_chainIn_capture
      (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_capture),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainIn_update
      (tapIO_icodeSelects_0_1 & _tapIO_controllerInternal_io_dataChainOut_update),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_capture_bits_dmiStatus ({dmiStatus_hi, dmiStatus_hi | stickyBusyReg}),	// Cat.scala:30:58, DebugTransport.scala:99:30, :100:37, :120:63
    .io_chainOut_data          (_dtmInfoChain_io_chainOut_data),
    .io_update_valid           (_dtmInfoChain_io_update_valid),
    .io_update_bits_dmireset   (_dtmInfoChain_io_update_bits_dmireset)
  );
  CaptureUpdateChain_1 dmiAccessChain (	// DebugTransport.scala:136:31
    .clock                (io_jtag_clock),
    .reset                (io_jtag_reset),
    .io_chainIn_shift
      (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_shift),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainIn_data      (tapIO_icodeSelects_0_2 & io_jtag_TDI),	// JtagTap.scala:227:82, :249:21, :250:26, :252:26
    .io_chainIn_capture   (_GEN),	// JtagTap.scala:249:21, :250:26, :252:26
    .io_chainIn_update
      (tapIO_icodeSelects_0_2 & _tapIO_controllerInternal_io_dataChainOut_update),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_capture_bits_addr (_GEN_2 ? 7'h0 : dmiReqReg_addr),	// DebugTransport.scala:112:23, :184:18, :199:40
    .io_capture_bits_data (_GEN_2 ? 32'h0 : io_dmi_resp_bits_data),	// DebugTransport.scala:186:18, :199:40
    .io_capture_bits_resp
      (busy ? 2'h3 : io_dmi_resp_valid ? io_dmi_resp_bits_resp : 2'h0),	// DebugTransport.scala:157:42, :185:21, :199:{40,60}
    .io_chainOut_data     (_dmiAccessChain_io_chainOut_data),
    .io_update_valid      (_dmiAccessChain_io_update_valid),
    .io_update_bits_addr  (_dmiAccessChain_io_update_bits_addr),
    .io_update_bits_data  (_dmiAccessChain_io_update_bits_data),
    .io_update_bits_op    (_dmiAccessChain_io_update_bits_op)
  );
  CaptureChain tapIO_idcodeChain (	// JtagTap.scala:185:33
    .clock              (io_jtag_clock),
    .reset              (io_jtag_reset),
    .io_chainIn_shift
      (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_shift),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainIn_data    (tapIO_icodeSelects_0 & io_jtag_TDI),	// JtagTap.scala:227:82, :249:21, :250:26, :252:26
    .io_chainIn_capture
      (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_capture),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainIn_update
      (tapIO_icodeSelects_0 & _tapIO_controllerInternal_io_dataChainOut_update),	// JtagTap.scala:203:36, :227:82, :249:21, :250:26, :252:26
    .io_chainOut_data   (_tapIO_idcodeChain_io_chainOut_data)
  );
  JtagTapController tapIO_controllerInternal (	// JtagTap.scala:203:36
    .clock                           (io_jtag_clock),
    .reset                           (io_jtag_reset),
    .io_jtag_TMS                     (io_jtag_TMS),
    .io_jtag_TDI                     (io_jtag_TDI),
    .io_control_jtag_reset           (io_jtag_reset),
    .io_dataChainIn_data
      (tapIO_icodeSelects_0
         ? _tapIO_idcodeChain_io_chainOut_data
         : tapIO_icodeSelects_0_1
             ? _dtmInfoChain_io_chainOut_data
             : tapIO_icodeSelects_0_2
                 ? _dmiAccessChain_io_chainOut_data
                 : _tapIO_bypassChain_io_chainOut_data),	// DebugTransport.scala:130:29, :136:31, JtagTap.scala:185:33, :211:29, :227:82, :237:28, :238:43, :244:41
    .io_jtag_TDO_data                (io_jtag_TDO_data),
    .io_output_instruction           (_tapIO_controllerInternal_io_output_instruction),
    .io_output_tapIsInTestLogicReset
      (_tapIO_controllerInternal_io_output_tapIsInTestLogicReset),
    .io_dataChainOut_shift           (_tapIO_controllerInternal_io_dataChainOut_shift),
    .io_dataChainOut_capture         (_tapIO_controllerInternal_io_dataChainOut_capture),
    .io_dataChainOut_update          (_tapIO_controllerInternal_io_dataChainOut_update)
  );
  JtagBypassChain tapIO_bypassChain (	// JtagTap.scala:211:29
    .clock              (io_jtag_clock),
    .reset              (io_jtag_reset),
    .io_chainIn_shift   (_tapIO_controllerInternal_io_dataChainOut_shift),	// JtagTap.scala:203:36
    .io_chainIn_data    (io_jtag_TDI),
    .io_chainIn_capture (_tapIO_controllerInternal_io_dataChainOut_capture),	// JtagTap.scala:203:36
    .io_chainIn_update  (_tapIO_controllerInternal_io_dataChainOut_update),	// JtagTap.scala:203:36
    .io_chainOut_data   (_tapIO_bypassChain_io_chainOut_data)
  );
  assign io_dmi_req_valid = dmiReqValidReg;	// DebugTransport.scala:113:31
  assign io_dmi_req_bits_addr = dmiReqReg_addr;	// DebugTransport.scala:112:23
  assign io_dmi_req_bits_data = dmiReqReg_data;	// DebugTransport.scala:112:23
  assign io_dmi_req_bits_op = dmiReqReg_op;	// DebugTransport.scala:112:23
  assign io_dmi_resp_ready = _io_dmi_resp_ready_output;	// DebugTransport.scala:226:27
endmodule

