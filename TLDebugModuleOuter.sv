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

module TLDebugModuleOuter(
  input         clock,
                reset,
                auto_dmi_in_a_valid,
  input  [2:0]  auto_dmi_in_a_bits_opcode,
  input  [6:0]  auto_dmi_in_a_bits_address,
  input  [31:0] auto_dmi_in_a_bits_data,
  input         auto_dmi_in_d_ready,
                io_ctrl_dmactiveAck,
                io_innerCtrl_ready,
                io_hgDebugInt_0,
                io_hgDebugInt_1,
                io_hgDebugInt_2,
                io_hgDebugInt_3,
                io_hgDebugInt_4,
                io_hgDebugInt_5,
  output [2:0]  auto_dmi_in_d_bits_opcode,
  output [31:0] auto_dmi_in_d_bits_data,
  output        auto_int_out_5_0,
                auto_int_out_4_0,
                auto_int_out_3_0,
                auto_int_out_2_0,
                auto_int_out_1_0,
                auto_int_out_0_0,
                io_ctrl_dmactive,
                io_innerCtrl_valid,
                io_innerCtrl_bits_resumereq,
  output [9:0]  io_innerCtrl_bits_hartsel,
  output        io_innerCtrl_bits_ackhavereset,
                io_innerCtrl_bits_hasel,
                io_innerCtrl_bits_hamask_0,
                io_innerCtrl_bits_hamask_1,
                io_innerCtrl_bits_hamask_2,
                io_innerCtrl_bits_hamask_3,
                io_innerCtrl_bits_hamask_4,
                io_innerCtrl_bits_hamask_5,
                io_innerCtrl_bits_hrmask_0,
                io_innerCtrl_bits_hrmask_1,
                io_innerCtrl_bits_hrmask_2,
                io_innerCtrl_bits_hrmask_3,
                io_innerCtrl_bits_hrmask_4,
                io_innerCtrl_bits_hrmask_5
);

  wire             _io_innerCtrl_bits_hasel_output;	// Debug.scala:600:42
  wire [9:0]       _io_innerCtrl_bits_hartsel_output;	// Debug.scala:595:42
  wire             out_woready_5;	// RegisterRouter.scala:79:24
  wire             out_woready_18;	// RegisterRouter.scala:79:24
  wire             DMCONTROLWrData_setresethaltreq;	// RegisterRouter.scala:79:24
  wire             DMCONTROLWrData_clrresethaltreq;	// RegisterRouter.scala:79:24
  reg              DMCONTROLReg_haltreq;	// Debug.scala:336:31
  reg              DMCONTROLReg_hasel;	// Debug.scala:336:31
  reg  [9:0]       DMCONTROLReg_hartsello;	// Debug.scala:336:31
  reg              DMCONTROLReg_ndmreset;	// Debug.scala:336:31
  reg              DMCONTROLReg_dmactive;	// Debug.scala:336:31
  reg  [14:0]      HAWINDOWSELReg_hawindowsel;	// Debug.scala:405:33
  reg  [31:0]      HAMASKReg_maskdata;	// Debug.scala:431:32
  wire             _GEN = HAWINDOWSELReg_hawindowsel == 15'h0;	// Debug.scala:392:50, :405:33, :433:20
  wire             _GEN_0 = out_woready_5 & _GEN;	// Debug.scala:433:20, :441:30, RegisterRouter.scala:79:24
  wire             hamask_0 = _GEN_0 ? auto_dmi_in_a_bits_data[0] : HAMASKReg_maskdata[0];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  wire             hamask_1 = _GEN_0 ? auto_dmi_in_a_bits_data[1] : HAMASKReg_maskdata[1];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  wire             hamask_2 = _GEN_0 ? auto_dmi_in_a_bits_data[2] : HAMASKReg_maskdata[2];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  wire             hamask_3 = _GEN_0 ? auto_dmi_in_a_bits_data[3] : HAMASKReg_maskdata[3];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  wire             hamask_4 = _GEN_0 ? auto_dmi_in_a_bits_data[4] : HAMASKReg_maskdata[4];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  wire             hamask_5 = _GEN_0 ? auto_dmi_in_a_bits_data[5] : HAMASKReg_maskdata[5];	// Debug.scala:431:32, :441:30, :449:54, :450:48, :451:74, :452:44, :454:44
  reg              hrmaskReg_0;	// Debug.scala:471:28
  reg              hrmaskReg_1;	// Debug.scala:471:28
  reg              hrmaskReg_2;	// Debug.scala:471:28
  reg              hrmaskReg_3;	// Debug.scala:471:28
  reg              hrmaskReg_4;	// Debug.scala:471:28
  reg              hrmaskReg_5;	// Debug.scala:471:28
  wire             _GEN_1 = out_woready_18 & DMCONTROLWrData_clrresethaltreq;	// Debug.scala:477:39, RegisterRouter.scala:79:24
  wire             _GEN_2 =
    _io_innerCtrl_bits_hartsel_output == 10'h0 | _io_innerCtrl_bits_hasel_output
    & hamask_0;	// Debug.scala:334:47, :400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             _GEN_3 = out_woready_18 & DMCONTROLWrData_setresethaltreq;	// Debug.scala:479:39, RegisterRouter.scala:79:24
  wire             hrmaskNxt_0 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_2) & (_GEN_3 & _GEN_2 | hrmaskReg_0);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             _GEN_4 =
    _io_innerCtrl_bits_hartsel_output == 10'h1 | _io_innerCtrl_bits_hasel_output
    & hamask_1;	// Debug.scala:400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             hrmaskNxt_1 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_4) & (_GEN_3 & _GEN_4 | hrmaskReg_1);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             _GEN_5 =
    _io_innerCtrl_bits_hartsel_output == 10'h2 | _io_innerCtrl_bits_hasel_output
    & hamask_2;	// Debug.scala:400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             hrmaskNxt_2 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_5) & (_GEN_3 & _GEN_5 | hrmaskReg_2);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             _GEN_6 =
    _io_innerCtrl_bits_hartsel_output == 10'h3 | _io_innerCtrl_bits_hasel_output
    & hamask_3;	// Debug.scala:400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             hrmaskNxt_3 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_6) & (_GEN_3 & _GEN_6 | hrmaskReg_3);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             _GEN_7 =
    _io_innerCtrl_bits_hartsel_output == 10'h4 | _io_innerCtrl_bits_hasel_output
    & hamask_4;	// Debug.scala:400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             hrmaskNxt_4 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_7) & (_GEN_3 & _GEN_7 | hrmaskReg_4);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             _GEN_8 =
    _io_innerCtrl_bits_hartsel_output == 10'h5 | _io_innerCtrl_bits_hasel_output
    & hamask_5;	// Debug.scala:400:{35,47}, :401:56, :451:74, :452:44, :454:44, :595:42, :600:42
  wire             hrmaskNxt_5 =
    ~(~DMCONTROLReg_dmactive | _GEN_1 & _GEN_8) & (_GEN_3 & _GEN_8 | hrmaskReg_5);	// Debug.scala:336:31, :354:11, :400:47, :471:28, :473:15, :475:44, :476:30, :477:{39,74,102}, :478:30, :479:{39,74,102}, :480:30
  wire             out_front_bits_read = auto_dmi_in_a_bits_opcode == 3'h4;	// RegisterRouter.scala:68:36
  assign DMCONTROLWrData_clrresethaltreq = auto_dmi_in_a_bits_data[2];	// RegisterRouter.scala:79:24
  assign DMCONTROLWrData_setresethaltreq = auto_dmi_in_a_bits_data[3];	// RegisterRouter.scala:79:24
  wire             _out_wofireMux_T_2 =
    auto_dmi_in_a_valid & auto_dmi_in_d_ready & ~out_front_bits_read;	// RegisterRouter.scala:68:36, :79:24
  assign out_woready_18 =
    _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[4:3] == 2'h0
    & ~(auto_dmi_in_a_bits_address[2]);	// Cat.scala:30:58, Edges.scala:191:34, RegisterRouter.scala:69:19, :79:24
  assign out_woready_5 =
    _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[4:3] == 2'h2
    & auto_dmi_in_a_bits_address[2];	// Cat.scala:30:58, Edges.scala:191:34, RegisterRouter.scala:69:19, :79:24
  wire [3:0]       _GEN_9 =
    {{1'h1},
     {auto_dmi_in_a_bits_address[2]},
     {~(auto_dmi_in_a_bits_address[2])},
     {~(auto_dmi_in_a_bits_address[2])}};	// Edges.scala:191:34, MuxLiteral.scala:48:10, RegisterRouter.scala:69:19, :79:24
  wire [3:0][31:0] _GEN_10 =
    {{32'h0},
     {{26'h0, _GEN ? HAMASKReg_maskdata[5:0] : 6'h0}},
     {32'h112380},
     {{DMCONTROLReg_haltreq,
       4'h0,
       DMCONTROLReg_hasel,
       7'h0,
       DMCONTROLReg_hartsello[2:0],
       14'h0,
       DMCONTROLReg_ndmreset,
       DMCONTROLReg_dmactive & io_ctrl_dmactiveAck}}};	// Cat.scala:30:58, Debug.scala:336:31, :358:104, :374:47, :395:47, :425:31, :431:32, :433:{20,52}, :434:{35,55}, :487:43, MuxLiteral.scala:48:{10,48}, RegisterRouter.scala:79:24
  wire [2:0]       bundleIn_0_d_bits_opcode = {2'h0, out_front_bits_read};	// RegisterRouter.scala:68:36, :94:19
  reg              debugIntRegs_0;	// Debug.scala:552:31
  reg              debugIntRegs_1;	// Debug.scala:552:31
  reg              debugIntRegs_2;	// Debug.scala:552:31
  reg              debugIntRegs_3;	// Debug.scala:552:31
  reg              debugIntRegs_4;	// Debug.scala:552:31
  reg              debugIntRegs_5;	// Debug.scala:552:31
  reg              innerCtrlValidReg;	// Debug.scala:583:36
  reg              innerCtrlResumeReqReg;	// Debug.scala:584:40
  reg              innerCtrlAckHaveResetReg;	// Debug.scala:585:43
  wire             _io_innerCtrl_valid_output =
    out_woready_18 | out_woready_5 | innerCtrlValidReg;	// Debug.scala:583:36, :594:54, RegisterRouter.scala:79:24
  assign _io_innerCtrl_bits_hartsel_output =
    out_woready_18 ? {7'h0, auto_dmi_in_a_bits_data[18:16]} : DMCONTROLReg_hartsello;	// Debug.scala:278:12, :336:31, :358:104, :595:42, RegisterRouter.scala:79:24
  wire             _io_innerCtrl_bits_resumereq_output =
    out_woready_18 & auto_dmi_in_a_bits_data[30] | innerCtrlResumeReqReg;	// Debug.scala:584:40, :596:{54,83}, RegisterRouter.scala:79:24
  wire             _io_innerCtrl_bits_ackhavereset_output =
    out_woready_18 & auto_dmi_in_a_bits_data[28] | innerCtrlAckHaveResetReg;	// Debug.scala:585:43, :597:{57,89}, RegisterRouter.scala:79:24
  assign _io_innerCtrl_bits_hasel_output =
    out_woready_18 ? auto_dmi_in_a_bits_data[26] : DMCONTROLReg_hasel;	// Debug.scala:336:31, :600:42, RegisterRouter.scala:79:24
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      DMCONTROLReg_haltreq <= 1'h0;	// Debug.scala:334:47, :336:31
      DMCONTROLReg_hasel <= 1'h0;	// Debug.scala:334:47, :336:31
      DMCONTROLReg_hartsello <= 10'h0;	// Debug.scala:334:47, :336:31
      DMCONTROLReg_ndmreset <= 1'h0;	// Debug.scala:334:47, :336:31
      DMCONTROLReg_dmactive <= 1'h0;	// Debug.scala:334:47, :336:31
      HAWINDOWSELReg_hawindowsel <= 15'h0;	// Debug.scala:392:50, :405:33
      HAMASKReg_maskdata <= 32'h0;	// Debug.scala:395:47, :431:32
      hrmaskReg_0 <= 1'h0;	// Debug.scala:334:47, :471:28
      hrmaskReg_1 <= 1'h0;	// Debug.scala:334:47, :471:28
      hrmaskReg_2 <= 1'h0;	// Debug.scala:334:47, :471:28
      hrmaskReg_3 <= 1'h0;	// Debug.scala:334:47, :471:28
      hrmaskReg_4 <= 1'h0;	// Debug.scala:334:47, :471:28
      hrmaskReg_5 <= 1'h0;	// Debug.scala:334:47, :471:28
      debugIntRegs_0 <= 1'h0;	// Debug.scala:334:47, :552:31
      debugIntRegs_1 <= 1'h0;	// Debug.scala:334:47, :552:31
      debugIntRegs_2 <= 1'h0;	// Debug.scala:334:47, :552:31
      debugIntRegs_3 <= 1'h0;	// Debug.scala:334:47, :552:31
      debugIntRegs_4 <= 1'h0;	// Debug.scala:334:47, :552:31
      debugIntRegs_5 <= 1'h0;	// Debug.scala:334:47, :552:31
      innerCtrlValidReg <= 1'h0;	// Debug.scala:334:47, :583:36
      innerCtrlResumeReqReg <= 1'h0;	// Debug.scala:334:47, :584:40
      innerCtrlAckHaveResetReg <= 1'h0;	// Debug.scala:334:47, :585:43
    end
    else begin
      DMCONTROLReg_haltreq <=
        DMCONTROLReg_dmactive
        & (out_woready_18 ? auto_dmi_in_a_bits_data[31] : DMCONTROLReg_haltreq);	// Debug.scala:336:31, :353:18, :354:22, :355:20, :361:{47,75}, RegisterRouter.scala:79:24
      DMCONTROLReg_hasel <=
        DMCONTROLReg_dmactive
        & (out_woready_18 ? auto_dmi_in_a_bits_data[26] : DMCONTROLReg_hasel);	// Debug.scala:336:31, :353:18, :354:22, :355:20, :359:{47,75}, RegisterRouter.scala:79:24
      if (DMCONTROLReg_dmactive) begin	// Debug.scala:336:31
        if (out_woready_18)	// RegisterRouter.scala:79:24
          DMCONTROLReg_hartsello <= {7'h0, auto_dmi_in_a_bits_data[18:16]};	// Debug.scala:336:31, :358:104, RegisterRouter.scala:79:24
      end
      else	// Debug.scala:336:31
        DMCONTROLReg_hartsello <= 10'h0;	// Debug.scala:334:47, :336:31
      DMCONTROLReg_ndmreset <=
        DMCONTROLReg_dmactive
        & (out_woready_18 ? auto_dmi_in_a_bits_data[1] : DMCONTROLReg_ndmreset);	// Debug.scala:336:31, :353:18, :354:22, :355:20, :357:{47,75}, RegisterRouter.scala:79:24
      if (out_woready_18)	// RegisterRouter.scala:79:24
        DMCONTROLReg_dmactive <= auto_dmi_in_a_bits_data[0];	// Debug.scala:336:31, RegisterRouter.scala:79:24
      if (DMCONTROLReg_dmactive) begin	// Debug.scala:336:31
        if (_GEN_0)	// Debug.scala:441:30
          HAMASKReg_maskdata <= {26'h0, auto_dmi_in_a_bits_data[5:0]};	// Debug.scala:278:12, :431:32, :434:55, RegisterRouter.scala:79:24
      end
      else begin	// Debug.scala:336:31
        HAWINDOWSELReg_hawindowsel <= 15'h0;	// Debug.scala:392:50, :405:33
        HAMASKReg_maskdata <= 32'h0;	// Debug.scala:395:47, :431:32
      end
      hrmaskReg_0 <= hrmaskNxt_0;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      hrmaskReg_1 <= hrmaskNxt_1;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      hrmaskReg_2 <= hrmaskNxt_2;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      hrmaskReg_3 <= hrmaskNxt_3;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      hrmaskReg_4 <= hrmaskNxt_4;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      hrmaskReg_5 <= hrmaskNxt_5;	// Debug.scala:471:28, :475:44, :476:30, :477:102, :478:30, :479:102
      debugIntRegs_0 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h0 | auto_dmi_in_a_bits_data[26]
              & hamask_0)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_0);	// Debug.scala:336:31, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      debugIntRegs_1 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h1 | auto_dmi_in_a_bits_data[26]
              & hamask_1)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_1);	// Debug.scala:336:31, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      debugIntRegs_2 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h2 | auto_dmi_in_a_bits_data[26]
              & hamask_2)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_2);	// Debug.scala:336:31, :400:35, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      debugIntRegs_3 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h3 | auto_dmi_in_a_bits_data[26]
              & hamask_3)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_3);	// Debug.scala:336:31, :400:35, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      debugIntRegs_4 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h4 | auto_dmi_in_a_bits_data[26]
              & hamask_4)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_4);	// Debug.scala:336:31, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      debugIntRegs_5 <=
        DMCONTROLReg_dmactive
        & (out_woready_18
           & (auto_dmi_in_a_bits_data[18:16] == 3'h5 | auto_dmi_in_a_bits_data[26]
              & hamask_5)
             ? auto_dmi_in_a_bits_data[31]
             : debugIntRegs_5);	// Debug.scala:336:31, :400:35, :451:74, :452:44, :454:44, :552:31, :554:17, :568:44, :569:32, :571:{27,58}, :572:{11,59,96}, :573:34, RegisterRouter.scala:79:24
      innerCtrlValidReg <= _io_innerCtrl_valid_output & ~io_innerCtrl_ready;	// Debug.scala:583:36, :590:{52,54}, :594:54
      innerCtrlResumeReqReg <= _io_innerCtrl_bits_resumereq_output & ~io_innerCtrl_ready;	// Debug.scala:584:40, :590:54, :591:61, :596:83
      innerCtrlAckHaveResetReg <=
        _io_innerCtrl_bits_ackhavereset_output & ~io_innerCtrl_ready;	// Debug.scala:585:43, :590:54, :592:64, :597:89
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:3];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        DMCONTROLReg_haltreq = _RANDOM[2'h0][0];	// Debug.scala:336:31
        DMCONTROLReg_hasel = _RANDOM[2'h0][5];	// Debug.scala:336:31
        DMCONTROLReg_hartsello = _RANDOM[2'h0][15:6];	// Debug.scala:336:31
        DMCONTROLReg_ndmreset = _RANDOM[2'h0][30];	// Debug.scala:336:31
        DMCONTROLReg_dmactive = _RANDOM[2'h0][31];	// Debug.scala:336:31
        HAWINDOWSELReg_hawindowsel = _RANDOM[2'h1][31:17];	// Debug.scala:405:33
        HAMASKReg_maskdata = _RANDOM[2'h2];	// Debug.scala:431:32
        hrmaskReg_0 = _RANDOM[2'h3][0];	// Debug.scala:471:28
        hrmaskReg_1 = _RANDOM[2'h3][1];	// Debug.scala:471:28
        hrmaskReg_2 = _RANDOM[2'h3][2];	// Debug.scala:471:28
        hrmaskReg_3 = _RANDOM[2'h3][3];	// Debug.scala:471:28
        hrmaskReg_4 = _RANDOM[2'h3][4];	// Debug.scala:471:28
        hrmaskReg_5 = _RANDOM[2'h3][5];	// Debug.scala:471:28
        debugIntRegs_0 = _RANDOM[2'h3][6];	// Debug.scala:471:28, :552:31
        debugIntRegs_1 = _RANDOM[2'h3][7];	// Debug.scala:471:28, :552:31
        debugIntRegs_2 = _RANDOM[2'h3][8];	// Debug.scala:471:28, :552:31
        debugIntRegs_3 = _RANDOM[2'h3][9];	// Debug.scala:471:28, :552:31
        debugIntRegs_4 = _RANDOM[2'h3][10];	// Debug.scala:471:28, :552:31
        debugIntRegs_5 = _RANDOM[2'h3][11];	// Debug.scala:471:28, :552:31
        innerCtrlValidReg = _RANDOM[2'h3][12];	// Debug.scala:471:28, :583:36
        innerCtrlResumeReqReg = _RANDOM[2'h3][13];	// Debug.scala:471:28, :584:40
        innerCtrlAckHaveResetReg = _RANDOM[2'h3][14];	// Debug.scala:471:28, :585:43
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        DMCONTROLReg_haltreq = 1'h0;	// Debug.scala:334:47, :336:31
        DMCONTROLReg_hasel = 1'h0;	// Debug.scala:334:47, :336:31
        DMCONTROLReg_hartsello = 10'h0;	// Debug.scala:334:47, :336:31
        DMCONTROLReg_ndmreset = 1'h0;	// Debug.scala:334:47, :336:31
        DMCONTROLReg_dmactive = 1'h0;	// Debug.scala:334:47, :336:31
        HAWINDOWSELReg_hawindowsel = 15'h0;	// Debug.scala:392:50, :405:33
        HAMASKReg_maskdata = 32'h0;	// Debug.scala:395:47, :431:32
        hrmaskReg_0 = 1'h0;	// Debug.scala:334:47, :471:28
        hrmaskReg_1 = 1'h0;	// Debug.scala:334:47, :471:28
        hrmaskReg_2 = 1'h0;	// Debug.scala:334:47, :471:28
        hrmaskReg_3 = 1'h0;	// Debug.scala:334:47, :471:28
        hrmaskReg_4 = 1'h0;	// Debug.scala:334:47, :471:28
        hrmaskReg_5 = 1'h0;	// Debug.scala:334:47, :471:28
        debugIntRegs_0 = 1'h0;	// Debug.scala:334:47, :552:31
        debugIntRegs_1 = 1'h0;	// Debug.scala:334:47, :552:31
        debugIntRegs_2 = 1'h0;	// Debug.scala:334:47, :552:31
        debugIntRegs_3 = 1'h0;	// Debug.scala:334:47, :552:31
        debugIntRegs_4 = 1'h0;	// Debug.scala:334:47, :552:31
        debugIntRegs_5 = 1'h0;	// Debug.scala:334:47, :552:31
        innerCtrlValidReg = 1'h0;	// Debug.scala:334:47, :583:36
        innerCtrlResumeReqReg = 1'h0;	// Debug.scala:334:47, :584:40
        innerCtrlAckHaveResetReg = 1'h0;	// Debug.scala:334:47, :585:43
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_71 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_dmi_in_d_ready),
    .io_in_a_valid        (auto_dmi_in_a_valid),
    .io_in_a_bits_opcode  (auto_dmi_in_a_bits_opcode),
    .io_in_a_bits_address (auto_dmi_in_a_bits_address),
    .io_in_d_ready        (auto_dmi_in_d_ready),
    .io_in_d_valid        (auto_dmi_in_a_valid),
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode)	// RegisterRouter.scala:94:19
  );
  assign auto_dmi_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_dmi_in_d_bits_data =
    _GEN_9[auto_dmi_in_a_bits_address[4:3]]
      ? _GEN_10[auto_dmi_in_a_bits_address[4:3]]
      : 32'h0;	// Cat.scala:30:58, Debug.scala:395:47, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  assign auto_int_out_5_0 = debugIntRegs_5 | io_hgDebugInt_5;	// Debug.scala:552:31, :558:60
  assign auto_int_out_4_0 = debugIntRegs_4 | io_hgDebugInt_4;	// Debug.scala:552:31, :558:60
  assign auto_int_out_3_0 = debugIntRegs_3 | io_hgDebugInt_3;	// Debug.scala:552:31, :558:60
  assign auto_int_out_2_0 = debugIntRegs_2 | io_hgDebugInt_2;	// Debug.scala:552:31, :558:60
  assign auto_int_out_1_0 = debugIntRegs_1 | io_hgDebugInt_1;	// Debug.scala:552:31, :558:60
  assign auto_int_out_0_0 = debugIntRegs_0 | io_hgDebugInt_0;	// Debug.scala:552:31, :558:60
  assign io_ctrl_dmactive = DMCONTROLReg_dmactive;	// Debug.scala:336:31
  assign io_innerCtrl_valid = _io_innerCtrl_valid_output;	// Debug.scala:594:54
  assign io_innerCtrl_bits_resumereq = _io_innerCtrl_bits_resumereq_output;	// Debug.scala:596:83
  assign io_innerCtrl_bits_hartsel = _io_innerCtrl_bits_hartsel_output;	// Debug.scala:595:42
  assign io_innerCtrl_bits_ackhavereset = _io_innerCtrl_bits_ackhavereset_output;	// Debug.scala:597:89
  assign io_innerCtrl_bits_hasel = _io_innerCtrl_bits_hasel_output;	// Debug.scala:600:42
  assign io_innerCtrl_bits_hamask_0 = hamask_0;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hamask_1 = hamask_1;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hamask_2 = hamask_2;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hamask_3 = hamask_3;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hamask_4 = hamask_4;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hamask_5 = hamask_5;	// Debug.scala:451:74, :452:44, :454:44
  assign io_innerCtrl_bits_hrmask_0 = hrmaskNxt_0;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
  assign io_innerCtrl_bits_hrmask_1 = hrmaskNxt_1;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
  assign io_innerCtrl_bits_hrmask_2 = hrmaskNxt_2;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
  assign io_innerCtrl_bits_hrmask_3 = hrmaskNxt_3;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
  assign io_innerCtrl_bits_hrmask_4 = hrmaskNxt_4;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
  assign io_innerCtrl_bits_hrmask_5 = hrmaskNxt_5;	// Debug.scala:475:44, :476:30, :477:102, :478:30, :479:102
endmodule

