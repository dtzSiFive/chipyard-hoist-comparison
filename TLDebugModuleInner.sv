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

module TLDebugModuleInner(
  input         clock,
                reset,
                auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
  input  [1:0]  auto_tl_in_a_bits_size,
  input  [11:0] auto_tl_in_a_bits_source,
                auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
                auto_dmi_in_a_valid,
  input  [2:0]  auto_dmi_in_a_bits_opcode,
                auto_dmi_in_a_bits_param,
  input  [1:0]  auto_dmi_in_a_bits_size,
  input         auto_dmi_in_a_bits_source,
  input  [8:0]  auto_dmi_in_a_bits_address,
  input  [3:0]  auto_dmi_in_a_bits_mask,
  input  [31:0] auto_dmi_in_a_bits_data,
  input         auto_dmi_in_a_bits_corrupt,
                auto_dmi_in_d_ready,
                io_dmactive,
                io_innerCtrl_valid,
                io_innerCtrl_bits_resumereq,
  input  [9:0]  io_innerCtrl_bits_hartsel,
  input         io_innerCtrl_bits_ackhavereset,
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
                io_innerCtrl_bits_hrmask_5,
                io_hartIsInReset_0,
                io_hartIsInReset_1,
                io_hartIsInReset_2,
                io_hartIsInReset_3,
                io_hartIsInReset_4,
                io_hartIsInReset_5,
  output [2:0]  auto_tl_in_d_bits_opcode,
  output [63:0] auto_tl_in_d_bits_data,
  output [2:0]  auto_dmi_in_d_bits_opcode,
  output [31:0] auto_dmi_in_d_bits_data,
  output        io_hgDebugInt_0,
                io_hgDebugInt_1,
                io_hgDebugInt_2,
                io_hgDebugInt_3,
                io_hgDebugInt_4,
                io_hgDebugInt_5
);

  wire        abstractCommandBusy;	// Debug.scala:1624:42
  wire        out_woready_1_49;	// RegisterRouter.scala:79:24
  wire        out_woready_1_88;	// RegisterRouter.scala:79:24
  wire        out_woready_107;	// RegisterRouter.scala:79:24
  wire        out_woready_18;	// RegisterRouter.scala:79:24
  wire        out_woready_42;	// RegisterRouter.scala:79:24
  wire        out_woready_73;	// RegisterRouter.scala:79:24
  wire        out_woready_89;	// RegisterRouter.scala:79:24
  wire        out_woready_7;	// RegisterRouter.scala:79:24
  wire        out_woready_30;	// RegisterRouter.scala:79:24
  wire        out_woready_93;	// RegisterRouter.scala:79:24
  wire        out_woready_77;	// RegisterRouter.scala:79:24
  wire        out_woready_22;	// RegisterRouter.scala:79:24
  wire        out_woready_14;	// RegisterRouter.scala:79:24
  wire        out_woready_98;	// RegisterRouter.scala:79:24
  wire        out_woready_81;	// RegisterRouter.scala:79:24
  wire        out_woready_38;	// RegisterRouter.scala:79:24
  wire        out_woready_26;	// RegisterRouter.scala:79:24
  wire        out_woready_34;	// RegisterRouter.scala:79:24
  wire        out_woready_10;	// RegisterRouter.scala:79:24
  wire        out_woready_3;	// RegisterRouter.scala:79:24
  wire        out_woready_103;	// RegisterRouter.scala:79:24
  wire        _out_wofireMux_T_2;	// RegisterRouter.scala:79:24
  wire        out_roready_107;	// RegisterRouter.scala:79:24
  wire        out_roready_18;	// RegisterRouter.scala:79:24
  wire        out_roready_42;	// RegisterRouter.scala:79:24
  wire        out_roready_73;	// RegisterRouter.scala:79:24
  wire        out_roready_89;	// RegisterRouter.scala:79:24
  wire        out_roready_7;	// RegisterRouter.scala:79:24
  wire        out_roready_30;	// RegisterRouter.scala:79:24
  wire        out_roready_93;	// RegisterRouter.scala:79:24
  wire        out_roready_77;	// RegisterRouter.scala:79:24
  wire        out_roready_22;	// RegisterRouter.scala:79:24
  wire        out_roready_14;	// RegisterRouter.scala:79:24
  wire        out_roready_98;	// RegisterRouter.scala:79:24
  wire        out_roready_81;	// RegisterRouter.scala:79:24
  wire        out_roready_38;	// RegisterRouter.scala:79:24
  wire        out_roready_26;	// RegisterRouter.scala:79:24
  wire        out_roready_34;	// RegisterRouter.scala:79:24
  wire        out_roready_3;	// RegisterRouter.scala:79:24
  wire        out_roready_103;	// RegisterRouter.scala:79:24
  wire        out_backSel_23;	// RegisterRouter.scala:79:24
  wire        out_backSel_22;	// RegisterRouter.scala:79:24
  wire [5:0]  resumeAcks;	// Debug.scala:1234:24, :1235:20, :1237:20
  wire        _hartIsInResetSync_5_debug_hartReset_5_io_q;	// ShiftReg.scala:45:23
  wire        _hartIsInResetSync_4_debug_hartReset_4_io_q;	// ShiftReg.scala:45:23
  wire        _hartIsInResetSync_3_debug_hartReset_3_io_q;	// ShiftReg.scala:45:23
  wire        _hartIsInResetSync_2_debug_hartReset_2_io_q;	// ShiftReg.scala:45:23
  wire        _hartIsInResetSync_1_debug_hartReset_1_io_q;	// ShiftReg.scala:45:23
  wire        _hartIsInResetSync_0_debug_hartReset_0_io_q;	// ShiftReg.scala:45:23
  reg  [5:0]  haltedBitRegs;	// Debug.scala:778:31
  reg  [5:0]  resumeReqRegs;	// Debug.scala:779:31
  reg  [5:0]  haveResetBitRegs;	// Debug.scala:780:31
  reg  [2:0]  selectedHartReg;	// Debug.scala:809:30
  reg         hamaskReg_0;	// Debug.scala:823:26
  reg         hamaskReg_1;	// Debug.scala:823:26
  reg         hamaskReg_2;	// Debug.scala:823:26
  reg         hamaskReg_3;	// Debug.scala:823:26
  reg         hamaskReg_4;	// Debug.scala:823:26
  reg         hamaskReg_5;	// Debug.scala:823:26
  wire        _GEN = selectedHartReg[2:1] != 2'h3;	// Debug.scala:809:30, :832:27, :842:61
  wire        _GEN_0 = selectedHartReg == 3'h0;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_0 = _GEN & _GEN_0 | hamaskReg_0;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        _GEN_1 = selectedHartReg == 3'h1;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_1 = _GEN & _GEN_1 | hamaskReg_1;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        _GEN_2 = selectedHartReg == 3'h2;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_2 = _GEN & _GEN_2 | hamaskReg_2;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        _GEN_3 = selectedHartReg == 3'h3;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_3 = _GEN & _GEN_3 | hamaskReg_3;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        _GEN_4 = selectedHartReg == 3'h4;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_4 = _GEN & _GEN_4 | hamaskReg_4;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        _GEN_5 = selectedHartReg == 3'h5;	// Debug.scala:809:30, :833:35
  wire        hamaskFull_5 = _GEN & _GEN_5 | hamaskReg_5;	// Debug.scala:823:26, :829:18, :832:{27,44}, :833:35
  wire        hamaskWrSel_0 =
    io_innerCtrl_bits_hartsel == 10'h0 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_0;	// Debug.scala:842:{61,78}, :843:56
  wire        hamaskWrSel_1 =
    io_innerCtrl_bits_hartsel == 10'h1 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_1;	// Debug.scala:842:{61,78}, :843:56
  wire        hamaskWrSel_2 =
    io_innerCtrl_bits_hartsel == 10'h2 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_2;	// Debug.scala:842:{61,78}, :843:56
  wire        hamaskWrSel_3 =
    io_innerCtrl_bits_hartsel == 10'h3 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_3;	// Debug.scala:842:{61,78}, :843:56
  wire        hamaskWrSel_4 =
    io_innerCtrl_bits_hartsel == 10'h4 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_4;	// Debug.scala:842:{61,78}, :843:56
  wire        hamaskWrSel_5 =
    io_innerCtrl_bits_hartsel == 10'h5 | io_innerCtrl_bits_hasel
    & io_innerCtrl_bits_hamask_5;	// Debug.scala:842:{61,78}, :843:56
  reg         hrmaskReg_0;	// Debug.scala:854:29
  reg         hrmaskReg_1;	// Debug.scala:854:29
  reg         hrmaskReg_2;	// Debug.scala:854:29
  reg         hrmaskReg_3;	// Debug.scala:854:29
  reg         hrmaskReg_4;	// Debug.scala:854:29
  reg         hrmaskReg_5;	// Debug.scala:854:29
  reg         hrDebugIntReg_0;	// Debug.scala:868:34
  reg         hrDebugIntReg_1;	// Debug.scala:868:34
  reg         hrDebugIntReg_2;	// Debug.scala:868:34
  reg         hrDebugIntReg_3;	// Debug.scala:868:34
  reg         hrDebugIntReg_4;	// Debug.scala:868:34
  reg         hrDebugIntReg_5;	// Debug.scala:868:34
  wire        resumereq = io_innerCtrl_valid & io_innerCtrl_bits_resumereq;	// Debug.scala:890:41
  wire        DMSTATUSRdData_anynonexistent = selectedHartReg > 3'h5;	// Debug.scala:809:30, :833:35, :895:57
  wire        DMSTATUSRdData_allnonexistent =
    DMSTATUSRdData_anynonexistent
    & ~(hamaskFull_0 | hamaskFull_1 | hamaskFull_2 | hamaskFull_3 | hamaskFull_4
        | hamaskFull_5);	// Debug.scala:829:18, :832:44, :833:35, :895:57, :897:{75,78,99}
  wire        _GEN_6 = ~DMSTATUSRdData_allnonexistent & ~DMSTATUSRdData_anynonexistent;	// Debug.scala:895:57, :897:75, :899:{13,45}, :905:{15,47}, :906:39
  reg         hgParticipateHart_0;	// Debug.scala:942:38
  reg         hgParticipateHart_1;	// Debug.scala:942:38
  reg         hgParticipateHart_2;	// Debug.scala:942:38
  reg         hgParticipateHart_3;	// Debug.scala:942:38
  reg         hgParticipateHart_4;	// Debug.scala:942:38
  reg         hgParticipateHart_5;	// Debug.scala:942:38
  wire [7:0]  _GEN_7 =
    {{hgParticipateHart_0},
     {hgParticipateHart_0},
     {hgParticipateHart_5},
     {hgParticipateHart_4},
     {hgParticipateHart_3},
     {hgParticipateHart_2},
     {hgParticipateHart_1},
     {hgParticipateHart_0}};	// Debug.scala:942:38, :955:29
  reg         hgFired_1;	// Debug.scala:1011:38
  reg  [4:0]  ABSTRACTCSReg_progbufsize;	// Debug.scala:1087:34
  reg  [2:0]  ABSTRACTCSReg_cmderr;	// Debug.scala:1087:34
  reg  [3:0]  ABSTRACTCSReg_datacount;	// Debug.scala:1087:34
  reg  [15:0] ABSTRACTAUTOReg_autoexecprogbuf;	// Debug.scala:1131:36
  reg  [11:0] ABSTRACTAUTOReg_autoexecdata;	// Debug.scala:1131:36
  reg  [7:0]  COMMANDRdData_cmdtype;	// Debug.scala:1172:25
  reg  [23:0] COMMANDRdData_control;	// Debug.scala:1172:25
  reg  [7:0]  abstractDataMem_0;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_1;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_2;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_3;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_4;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_5;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_6;	// Debug.scala:1195:36
  reg  [7:0]  abstractDataMem_7;	// Debug.scala:1195:36
  reg  [7:0]  programBufferMem_0;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_1;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_2;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_3;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_4;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_5;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_6;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_7;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_8;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_9;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_10;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_11;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_12;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_13;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_14;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_15;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_16;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_17;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_18;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_19;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_20;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_21;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_22;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_23;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_24;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_25;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_26;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_27;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_28;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_29;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_30;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_31;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_32;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_33;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_34;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_35;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_36;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_37;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_38;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_39;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_40;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_41;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_42;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_43;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_44;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_45;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_46;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_47;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_48;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_49;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_50;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_51;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_52;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_53;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_54;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_55;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_56;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_57;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_58;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_59;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_60;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_61;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_62;	// Debug.scala:1199:34
  reg  [7:0]  programBufferMem_63;	// Debug.scala:1199:34
  assign resumeAcks =
    resumereq
      ? ~resumeReqRegs
        & ~{hamaskWrSel_5,
            hamaskWrSel_4,
            hamaskWrSel_3,
            hamaskWrSel_2,
            hamaskWrSel_1,
            hamaskWrSel_0}
      : ~resumeReqRegs;	// Debug.scala:779:31, :842:78, :890:41, :1234:24, :1235:{20,24,39,41,55}, :1237:{20,23}
  wire        out_front_bits_read = auto_dmi_in_a_bits_opcode == 3'h4;	// Debug.scala:833:35, RegisterRouter.scala:68:36
  wire [7:0]  out_backMask_hi_lo = {8{auto_dmi_in_a_bits_mask[2]}};	// Bitwise.scala:26:51, :72:12
  wire [7:0]  out_backMask_hi_hi = {8{auto_dmi_in_a_bits_mask[3]}};	// Bitwise.scala:26:51, :72:12
  wire        dmiAbstractDataWrEnMaybe_4 = out_woready_3 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_5 = out_woready_3 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_6 = out_woready_3 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_7 = out_woready_3 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_40 = out_woready_7 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_41 = out_woready_7 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_42 = out_woready_7 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_43 = out_woready_7 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        autoexecdataWrEnMaybe = out_woready_10 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        autoexecprogbufWrEnMaybe =
    out_woready_10 & (&{out_backMask_hi_hi, out_backMask_hi_lo});	// Bitwise.scala:72:12, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_20 = out_woready_14 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_21 = out_woready_14 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_22 = out_woready_14 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_23 = out_woready_14 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_56 = out_woready_18 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_57 = out_woready_18 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_58 = out_woready_18 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_59 = out_woready_18 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_24 = out_woready_22 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_25 = out_woready_22 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_26 = out_woready_22 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_27 = out_woready_22 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_4 = out_woready_26 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_5 = out_woready_26 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_6 = out_woready_26 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_7 = out_woready_26 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_36 = out_woready_30 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_37 = out_woready_30 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_38 = out_woready_30 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_39 = out_woready_30 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_0 = out_woready_34 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_1 = out_woready_34 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_2 = out_woready_34 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_3 = out_woready_34 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_8 = out_woready_38 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_9 = out_woready_38 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_10 = out_woready_38 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_11 = out_woready_38 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_52 = out_woready_42 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_53 = out_woready_42 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_54 = out_woready_42 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_55 = out_woready_42 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        ABSTRACTCSWrEnMaybe =
    _out_wofireMux_T_2 & out_backSel_22 & ~(auto_dmi_in_a_bits_address[8])
    & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, Edges.scala:191:34, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_48 = out_woready_73 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_49 = out_woready_73 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_50 = out_woready_73 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_51 = out_woready_73 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_28 = out_woready_77 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_29 = out_woready_77 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_30 = out_woready_77 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_31 = out_woready_77 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_12 = out_woready_81 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_13 = out_woready_81 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_14 = out_woready_81 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_15 = out_woready_81 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_44 = out_woready_89 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_45 = out_woready_89 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_46 = out_woready_89 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_47 = out_woready_89 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_32 = out_woready_93 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_33 = out_woready_93 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_34 = out_woready_93 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_35 = out_woready_93 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        COMMANDWrEnMaybe =
    _out_wofireMux_T_2 & out_backSel_23 & ~(auto_dmi_in_a_bits_address[8])
    & (&{out_backMask_hi_hi,
         out_backMask_hi_lo,
         {8{auto_dmi_in_a_bits_mask[1]}},
         {8{auto_dmi_in_a_bits_mask[0]}}});	// Bitwise.scala:26:51, :72:12, Cat.scala:30:58, Edges.scala:191:34, RegisterRouter.scala:79:24
  wire [31:0] _COMMANDWrData_WIRE_1 = COMMANDWrEnMaybe ? auto_dmi_in_a_bits_data : 32'h0;	// Debug.scala:265:{24,30}, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_16 = out_woready_98 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_17 = out_woready_98 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_18 = out_woready_98 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_19 = out_woready_98 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_0 = out_woready_103 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_1 = out_woready_103 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_2 = out_woready_103 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiAbstractDataWrEnMaybe_3 = out_woready_103 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_60 = out_woready_107 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_61 = out_woready_107 & auto_dmi_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_62 = out_woready_107 & auto_dmi_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        dmiProgramBufferWrEnMaybe_63 = out_woready_107 & auto_dmi_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire        out_backSel_4 = auto_dmi_in_a_bits_address[7:2] == 6'h4;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_5 = auto_dmi_in_a_bits_address[7:2] == 6'h5;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  assign out_backSel_22 = auto_dmi_in_a_bits_address[7:2] == 6'h16;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  assign out_backSel_23 = auto_dmi_in_a_bits_address[7:2] == 6'h17;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_32 = auto_dmi_in_a_bits_address[7:2] == 6'h20;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_33 = auto_dmi_in_a_bits_address[7:2] == 6'h21;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_34 = auto_dmi_in_a_bits_address[7:2] == 6'h22;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_35 = auto_dmi_in_a_bits_address[7:2] == 6'h23;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_36 = auto_dmi_in_a_bits_address[7:2] == 6'h24;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_37 = auto_dmi_in_a_bits_address[7:2] == 6'h25;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_38 = auto_dmi_in_a_bits_address[7:2] == 6'h26;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_39 = auto_dmi_in_a_bits_address[7:2] == 6'h27;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_40 = auto_dmi_in_a_bits_address[7:2] == 6'h28;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_41 = auto_dmi_in_a_bits_address[7:2] == 6'h29;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_42 = auto_dmi_in_a_bits_address[7:2] == 6'h2A;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_43 = auto_dmi_in_a_bits_address[7:2] == 6'h2B;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_44 = auto_dmi_in_a_bits_address[7:2] == 6'h2C;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_45 = auto_dmi_in_a_bits_address[7:2] == 6'h2D;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_46 = auto_dmi_in_a_bits_address[7:2] == 6'h2E;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        out_backSel_47 = auto_dmi_in_a_bits_address[7:2] == 6'h2F;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire        _out_wofireMux_T = auto_dmi_in_a_valid & auto_dmi_in_d_ready;	// RegisterRouter.scala:79:24
  wire        _out_rofireMux_T_1 = _out_wofireMux_T & out_front_bits_read;	// RegisterRouter.scala:68:36, :79:24
  assign out_roready_103 =
    _out_rofireMux_T_1 & out_backSel_4 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_3 =
    _out_rofireMux_T_1 & out_backSel_5 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_34 =
    _out_rofireMux_T_1 & out_backSel_32 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_26 =
    _out_rofireMux_T_1 & out_backSel_33 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_38 =
    _out_rofireMux_T_1 & out_backSel_34 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_81 =
    _out_rofireMux_T_1 & out_backSel_35 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_98 =
    _out_rofireMux_T_1 & out_backSel_36 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_14 =
    _out_rofireMux_T_1 & out_backSel_37 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_22 =
    _out_rofireMux_T_1 & out_backSel_38 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_77 =
    _out_rofireMux_T_1 & out_backSel_39 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_93 =
    _out_rofireMux_T_1 & out_backSel_40 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_30 =
    _out_rofireMux_T_1 & out_backSel_41 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_7 =
    _out_rofireMux_T_1 & out_backSel_42 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_89 =
    _out_rofireMux_T_1 & out_backSel_43 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_73 =
    _out_rofireMux_T_1 & out_backSel_44 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_42 =
    _out_rofireMux_T_1 & out_backSel_45 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_18 =
    _out_rofireMux_T_1 & out_backSel_46 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_roready_107 =
    _out_rofireMux_T_1 & out_backSel_47 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign _out_wofireMux_T_2 = _out_wofireMux_T & ~out_front_bits_read;	// RegisterRouter.scala:68:36, :79:24
  assign out_woready_103 =
    _out_wofireMux_T_2 & out_backSel_4 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_3 =
    _out_wofireMux_T_2 & out_backSel_5 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_10 =
    _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[7:2] == 6'h18
    & ~(auto_dmi_in_a_bits_address[8]);	// Cat.scala:30:58, Conditional.scala:37:30, Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_34 =
    _out_wofireMux_T_2 & out_backSel_32 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_26 =
    _out_wofireMux_T_2 & out_backSel_33 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_38 =
    _out_wofireMux_T_2 & out_backSel_34 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_81 =
    _out_wofireMux_T_2 & out_backSel_35 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_98 =
    _out_wofireMux_T_2 & out_backSel_36 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_14 =
    _out_wofireMux_T_2 & out_backSel_37 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_22 =
    _out_wofireMux_T_2 & out_backSel_38 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_77 =
    _out_wofireMux_T_2 & out_backSel_39 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_93 =
    _out_wofireMux_T_2 & out_backSel_40 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_30 =
    _out_wofireMux_T_2 & out_backSel_41 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_7 =
    _out_wofireMux_T_2 & out_backSel_42 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_89 =
    _out_wofireMux_T_2 & out_backSel_43 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_73 =
    _out_wofireMux_T_2 & out_backSel_44 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_42 =
    _out_wofireMux_T_2 & out_backSel_45 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_18 =
    _out_wofireMux_T_2 & out_backSel_46 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  assign out_woready_107 =
    _out_wofireMux_T_2 & out_backSel_47 & ~(auto_dmi_in_a_bits_address[8]);	// Edges.scala:191:34, RegisterRouter.scala:79:24
  wire        _out_out_bits_data_T_25 = auto_dmi_in_a_bits_address[7:2] == 6'h0;	// Cat.scala:30:58, Conditional.scala:37:30, RegisterRouter.scala:79:24
  wire [31:0] _GEN_8 =
    auto_dmi_in_a_bits_address[7:2] == 6'h11
      ? {12'h0,
         _GEN_6 & (haveResetBitRegs[0] | ~hamaskFull_0)
           & (haveResetBitRegs[1] | ~hamaskFull_1) & (haveResetBitRegs[2] | ~hamaskFull_2)
           & (haveResetBitRegs[3] | ~hamaskFull_3) & (haveResetBitRegs[4] | ~hamaskFull_4)
           & (haveResetBitRegs[5] | ~hamaskFull_5),
         ~DMSTATUSRdData_allnonexistent
           & (haveResetBitRegs[0] & hamaskFull_0 | haveResetBitRegs[1] & hamaskFull_1
              | haveResetBitRegs[2] & hamaskFull_2 | haveResetBitRegs[3] & hamaskFull_3
              | haveResetBitRegs[4] & hamaskFull_4 | haveResetBitRegs[5] & hamaskFull_5),
         _GEN_6 & (resumeAcks[0] | ~hamaskFull_0) & (resumeAcks[1] | ~hamaskFull_1)
           & (resumeAcks[2] | ~hamaskFull_2) & (resumeAcks[3] | ~hamaskFull_3)
           & (resumeAcks[4] | ~hamaskFull_4) & (resumeAcks[5] | ~hamaskFull_5),
         ~DMSTATUSRdData_allnonexistent
           & (resumeAcks[0] & hamaskFull_0 | resumeAcks[1] & hamaskFull_1 | resumeAcks[2]
              & hamaskFull_2 | resumeAcks[3] & hamaskFull_3 | resumeAcks[4] & hamaskFull_4
              | resumeAcks[5] & hamaskFull_5),
         DMSTATUSRdData_allnonexistent,
         DMSTATUSRdData_anynonexistent,
         _GEN_6 & ~hamaskFull_0 & ~hamaskFull_1 & ~hamaskFull_2 & ~hamaskFull_3
           & ~hamaskFull_4 & ~hamaskFull_5,
         1'h0,
         _GEN_6 & (~(haltedBitRegs[0]) | ~hamaskFull_0)
           & (~(haltedBitRegs[1]) | ~hamaskFull_1) & (~(haltedBitRegs[2]) | ~hamaskFull_2)
           & (~(haltedBitRegs[3]) | ~hamaskFull_3) & (~(haltedBitRegs[4]) | ~hamaskFull_4)
           & (~(haltedBitRegs[5]) | ~hamaskFull_5),
         ~DMSTATUSRdData_allnonexistent
           & (~(haltedBitRegs[0]) & hamaskFull_0 | ~(haltedBitRegs[1]) & hamaskFull_1
              | ~(haltedBitRegs[2]) & hamaskFull_2 | ~(haltedBitRegs[3]) & hamaskFull_3
              | ~(haltedBitRegs[4]) & hamaskFull_4 | ~(haltedBitRegs[5]) & hamaskFull_5),
         _GEN_6 & (haltedBitRegs[0] | ~hamaskFull_0) & (haltedBitRegs[1] | ~hamaskFull_1)
           & (haltedBitRegs[2] | ~hamaskFull_2) & (haltedBitRegs[3] | ~hamaskFull_3)
           & (haltedBitRegs[4] | ~hamaskFull_4) & (haltedBitRegs[5] | ~hamaskFull_5),
         ~DMSTATUSRdData_allnonexistent
           & (haltedBitRegs[0] & hamaskFull_0 | haltedBitRegs[1] & hamaskFull_1
              | haltedBitRegs[2] & hamaskFull_2 | haltedBitRegs[3] & hamaskFull_3
              | haltedBitRegs[4] & hamaskFull_4 | haltedBitRegs[5] & hamaskFull_5),
         8'hA2}
      : auto_dmi_in_a_bits_address[7:2] == 6'h13
          ? {31'h0, |haltedBitRegs}
          : auto_dmi_in_a_bits_address[7:2] == 6'h16
              ? {3'h0,
                 ABSTRACTCSReg_progbufsize,
                 11'h0,
                 abstractCommandBusy,
                 1'h0,
                 ABSTRACTCSReg_cmderr,
                 4'h0,
                 ABSTRACTCSReg_datacount}
              : auto_dmi_in_a_bits_address[7:2] == 6'h17
                  ? {COMMANDRdData_cmdtype, COMMANDRdData_control}
                  : auto_dmi_in_a_bits_address[7:2] == 6'h18
                      ? {ABSTRACTAUTOReg_autoexecprogbuf,
                         14'h0,
                         ABSTRACTAUTOReg_autoexecdata[1:0]}
                      : auto_dmi_in_a_bits_address[7:2] == 6'h20
                          ? {programBufferMem_3,
                             programBufferMem_2,
                             programBufferMem_1,
                             programBufferMem_0}
                          : auto_dmi_in_a_bits_address[7:2] == 6'h21
                              ? {programBufferMem_7,
                                 programBufferMem_6,
                                 programBufferMem_5,
                                 programBufferMem_4}
                              : auto_dmi_in_a_bits_address[7:2] == 6'h22
                                  ? {programBufferMem_11,
                                     programBufferMem_10,
                                     programBufferMem_9,
                                     programBufferMem_8}
                                  : auto_dmi_in_a_bits_address[7:2] == 6'h23
                                      ? {programBufferMem_15,
                                         programBufferMem_14,
                                         programBufferMem_13,
                                         programBufferMem_12}
                                      : auto_dmi_in_a_bits_address[7:2] == 6'h24
                                          ? {programBufferMem_19,
                                             programBufferMem_18,
                                             programBufferMem_17,
                                             programBufferMem_16}
                                          : auto_dmi_in_a_bits_address[7:2] == 6'h25
                                              ? {programBufferMem_23,
                                                 programBufferMem_22,
                                                 programBufferMem_21,
                                                 programBufferMem_20}
                                              : auto_dmi_in_a_bits_address[7:2] == 6'h26
                                                  ? {programBufferMem_27,
                                                     programBufferMem_26,
                                                     programBufferMem_25,
                                                     programBufferMem_24}
                                                  : auto_dmi_in_a_bits_address[7:2] == 6'h27
                                                      ? {programBufferMem_31,
                                                         programBufferMem_30,
                                                         programBufferMem_29,
                                                         programBufferMem_28}
                                                      : auto_dmi_in_a_bits_address[7:2] == 6'h28
                                                          ? {programBufferMem_35,
                                                             programBufferMem_34,
                                                             programBufferMem_33,
                                                             programBufferMem_32}
                                                          : auto_dmi_in_a_bits_address[7:2] == 6'h29
                                                              ? {programBufferMem_39,
                                                                 programBufferMem_38,
                                                                 programBufferMem_37,
                                                                 programBufferMem_36}
                                                              : auto_dmi_in_a_bits_address[7:2] == 6'h2A
                                                                  ? {programBufferMem_43,
                                                                     programBufferMem_42,
                                                                     programBufferMem_41,
                                                                     programBufferMem_40}
                                                                  : auto_dmi_in_a_bits_address[7:2] == 6'h2B
                                                                      ? {programBufferMem_47,
                                                                         programBufferMem_46,
                                                                         programBufferMem_45,
                                                                         programBufferMem_44}
                                                                      : auto_dmi_in_a_bits_address[7:2] == 6'h2C
                                                                          ? {programBufferMem_51,
                                                                             programBufferMem_50,
                                                                             programBufferMem_49,
                                                                             programBufferMem_48}
                                                                          : auto_dmi_in_a_bits_address[7:2] == 6'h2D
                                                                              ? {programBufferMem_55,
                                                                                 programBufferMem_54,
                                                                                 programBufferMem_53,
                                                                                 programBufferMem_52}
                                                                              : auto_dmi_in_a_bits_address[7:2] == 6'h2E
                                                                                  ? {programBufferMem_59,
                                                                                     programBufferMem_58,
                                                                                     programBufferMem_57,
                                                                                     programBufferMem_56}
                                                                                  : auto_dmi_in_a_bits_address[7:2] == 6'h2F
                                                                                      ? {programBufferMem_63,
                                                                                         programBufferMem_62,
                                                                                         programBufferMem_61,
                                                                                         programBufferMem_60}
                                                                                      : auto_dmi_in_a_bits_address[7:2] == 6'h32
                                                                                          ? {29'h0,
                                                                                             _GEN_7[selectedHartReg],
                                                                                             2'h0}
                                                                                          : 32'h0;	// Cat.scala:30:58, Conditional.scala:37:30, :39:67, Debug.scala:778:31, :780:31, :809:30, :829:18, :832:44, :833:35, :885:47, :895:57, :897:75, :899:{13,45}, :901:{37,77,111}, :902:{37,111}, :903:{37,58,90}, :904:{37,52,84}, :905:47, :906:39, :907:39, :908:39, :909:39, :910:39, :950:62, :955:29, :1073:48, :1087:34, :1130:54, :1131:36, :1171:45, :1172:25, :1199:34, :1234:24, :1235:20, :1237:20, :1320:46, :1624:42, MuxLiteral.scala:53:32, Nodes.scala:24:25, RegisterRouter.scala:79:24, package.scala:65:72, :66:75, :70:38
  wire [2:0]  bundleIn_0_d_bits_opcode = {2'h0, out_front_bits_read};	// Debug.scala:885:47, RegisterRouter.scala:68:36, :94:19
  reg         goReg;	// Debug.scala:1379:27
  reg  [31:0] abstractGeneratedMem_0;	// Debug.scala:1470:35
  reg  [31:0] abstractGeneratedMem_1;	// Debug.scala:1470:35
  wire        out_front_1_bits_read = auto_tl_in_a_bits_opcode == 3'h4;	// Debug.scala:833:35, RegisterRouter.scala:68:36
  wire [9:0]  _out_womask_T_195 =
    {{2{auto_tl_in_a_bits_mask[1]}}, {8{auto_tl_in_a_bits_mask[0]}}};	// Bitwise.scala:26:51, :72:12, RegisterRouter.scala:79:24
  wire [9:0]  _out_womask_T_196 =
    {{2{auto_tl_in_a_bits_mask[5]}}, {8{auto_tl_in_a_bits_mask[4]}}};	// Bitwise.scala:26:51, :72:12, RegisterRouter.scala:79:24
  wire        hartExceptionWrEn = out_woready_1_49 & (&_out_womask_T_196);	// RegisterRouter.scala:79:24
  wire        hartHaltedWrEn = out_woready_1_88 & (&_out_womask_T_195);	// RegisterRouter.scala:79:24
  wire        hartGoingWrEn = out_woready_1_88 & (&_out_womask_T_196);	// RegisterRouter.scala:79:24
  wire [7:0]  out_oindex_1 =
    {auto_tl_in_a_bits_address[11], auto_tl_in_a_bits_address[9:3]};	// Cat.scala:30:58, RegisterRouter.scala:79:24
  wire [7:0]  _GEN_9 = {auto_tl_in_a_bits_address[11], auto_tl_in_a_bits_address[9:3]};	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        _out_wofireMux_T_262 =
    auto_tl_in_a_valid & auto_tl_in_d_ready & ~out_front_1_bits_read;	// RegisterRouter.scala:68:36, :79:24
  assign out_woready_1_88 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h20 & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_1_49 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h21 & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_138 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h68 & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_82 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h69 & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_31 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6A & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_162 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6B & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_114 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6C & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_57 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6D & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_15 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6E & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_170 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h6F & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        out_woready_1_122 =
    _out_wofireMux_T_262 & _GEN_9 == 8'h70 & ~(auto_tl_in_a_bits_address[10]);	// Conditional.scala:37:30, Edges.scala:191:34, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        _out_out_bits_data_T_76 = out_oindex_1 == 8'h0;	// Cat.scala:30:58, Conditional.scala:37:30, Debug.scala:1171:45
  wire [2:0]  bundleIn_0_1_d_bits_opcode = {2'h0, out_front_1_bits_read};	// Debug.scala:885:47, RegisterRouter.scala:68:36, :94:19
  reg  [1:0]  ctrlStateReg;	// Debug.scala:1616:27
  wire [5:0]  _hartHalted_T = haltedBitRegs >> selectedHartReg;	// Debug.scala:778:31, :809:30, :1618:37
  assign abstractCommandBusy = |ctrlStateReg;	// Debug.scala:1616:27, :1624:42
  wire        commandRegIsAccessRegister = COMMANDRdData_cmdtype == 8'h0;	// Debug.scala:1171:45, :1172:25, :1641:58
  wire        _GEN_10 =
    ~(COMMANDRdData_control[17]) | (|(COMMANDRdData_control[15:12]))
    & COMMANDRdData_control[15:0] < 16'h1020
    & (COMMANDRdData_control[22:20] == 3'h2 | COMMANDRdData_control[22:20] == 3'h3);	// Debug.scala:833:35, :1172:25, :1417:73, :1649:{63,72,106}, :1650:{58,104,117}, :1660:{19,54}
  wire        commandRegIsUnsupported = ~commandRegIsAccessRegister | ~_GEN_10;	// Debug.scala:824:29, :1641:58, :1657:39, :1658:115, :1659:33, :1660:{54,73}, :1661:33, Nodes.scala:1210:84
  wire        commandRegBadHaltResume =
    commandRegIsAccessRegister & _GEN_10 & ~(_hartHalted_T[0]);	// Debug.scala:1618:37, :1641:58, :1657:39, :1658:115, :1660:{54,73}, :1662:{33,36}
  wire        _GEN_11 = ctrlStateReg == 2'h1;	// Debug.scala:1616:27, :1675:22, :1681:30
  wire        _GEN_12 = commandRegIsUnsupported | commandRegBadHaltResume;	// Debug.scala:1657:39, :1658:115, :1660:73, :1662:33, :1688:38, :1690:22, :1691:43, :1693:22, :1695:33
  wire        goAbstract = (|ctrlStateReg) & _GEN_11 & ~_GEN_12;	// Debug.scala:824:29, :1616:27, :1626:44, :1673:47, :1681:{30,59}, :1688:38, :1690:22, :1691:43, :1693:22, :1695:33, Nodes.scala:1210:84
  wire        _GEN_13 = ctrlStateReg == 2'h2;	// Debug.scala:842:61, :1616:27, :1702:30
  `ifndef SYNTHESIS	// Debug.scala:1391:15
    always @(posedge clock) begin	// Debug.scala:1391:15
      automatic logic _GEN_14 = auto_tl_in_a_bits_data[41:32] == 10'h0 | reset;	// Debug.scala:842:61, :1391:{15,28}, RegisterRouter.scala:79:24
      automatic logic _GEN_15;	// Debug.scala:1681:59
      _GEN_15 = (|ctrlStateReg) & ~_GEN_11;	// Debug.scala:1616:27, :1626:44, :1681:{30,59}
      if (io_dmactive & ~goAbstract & hartGoingWrEn & ~_GEN_14) begin	// Debug.scala:1388:25, :1391:15, :1673:47, :1681:59, RegisterRouter.scala:79:24
        if (`ASSERT_VERBOSE_COND_)	// Debug.scala:1391:15
          $error("Assertion failed: Unexpected 'GOING' hart.\n    at Debug.scala:1391 assert(hartGoingId === 0.U, \"Unexpected 'GOING' hart.\")//Chisel3 #540 %%x, expected %%x\", hartGoingId, 0.U)\n");	// Debug.scala:1391:15
        if (`STOP_COND_)	// Debug.scala:1391:15
          $fatal;	// Debug.scala:1391:15
      end
      if (_GEN_15 & _GEN_13 & hartExceptionWrEn & ~_GEN_14) begin	// Debug.scala:1391:15, :1681:59, :1702:30, :1711:15, RegisterRouter.scala:79:24
        if (`ASSERT_VERBOSE_COND_)	// Debug.scala:1711:15
          $error("Assertion failed: Unexpected 'EXCEPTION' hart\n    at Debug.scala:1711 assert(hartExceptionId === 0.U, \"Unexpected 'EXCEPTION' hart\")//Chisel3 #540, %%x, expected %%x\", hartExceptionId, 0.U)\n");	// Debug.scala:1711:15
        if (`STOP_COND_)	// Debug.scala:1711:15
          $fatal;	// Debug.scala:1711:15
      end
      if (_GEN_15 & ~_GEN_13 & (&ctrlStateReg) & ~reset) begin	// Debug.scala:1616:27, :1681:59, :1702:{30,51}, :1715:30, :1716:13
        if (`ASSERT_VERBOSE_COND_)	// Debug.scala:1716:13
          $error("Assertion failed: Should not be in custom state unless we need it.\n    at Debug.scala:1716 assert(needCustom.B, \"Should not be in custom state unless we need it.\")\n");	// Debug.scala:1716:13
        if (`STOP_COND_)	// Debug.scala:1716:13
          $fatal;	// Debug.scala:1716:13
      end
      if (~(~io_dmactive | ~hartExceptionWrEn | _GEN_13 | reset)) begin	// Debug.scala:814:13, :1702:30, :1729:{12,30}, RegisterRouter.scala:79:24
        if (`ASSERT_VERBOSE_COND_)	// Debug.scala:1729:12
          $error("Assertion failed: Unexpected EXCEPTION write: should only get it in Debug Module EXEC state\n    at Debug.scala:1729 assert ((!io.dmactive || !hartExceptionWrEn || ctrlStateReg === CtrlState(Exec)),\n");	// Debug.scala:1729:12
        if (`STOP_COND_)	// Debug.scala:1729:12
          $fatal;	// Debug.scala:1729:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (io_dmactive) begin
      automatic logic          dmiAbstractDataAccessVec_0 =
        dmiAbstractDataWrEnMaybe_0 | out_roready_103 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1153:105, RegisterRouter.scala:79:24
      automatic logic          dmiAbstractDataAccessVec_4 =
        dmiAbstractDataWrEnMaybe_4 | out_roready_3 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1153:105, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_0 =
        dmiProgramBufferWrEnMaybe_0 | out_roready_34 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_4 =
        dmiProgramBufferWrEnMaybe_4 | out_roready_26 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_8 =
        dmiProgramBufferWrEnMaybe_8 | out_roready_38 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_12 =
        dmiProgramBufferWrEnMaybe_12 | out_roready_81 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_16 =
        dmiProgramBufferWrEnMaybe_16 | out_roready_98 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_20 =
        dmiProgramBufferWrEnMaybe_20 | out_roready_14 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_24 =
        dmiProgramBufferWrEnMaybe_24 | out_roready_22 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_28 =
        dmiProgramBufferWrEnMaybe_28 | out_roready_77 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_32 =
        dmiProgramBufferWrEnMaybe_32 | out_roready_93 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_36 =
        dmiProgramBufferWrEnMaybe_36 | out_roready_30 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_40 =
        dmiProgramBufferWrEnMaybe_40 | out_roready_7 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_44 =
        dmiProgramBufferWrEnMaybe_44 | out_roready_89 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_48 =
        dmiProgramBufferWrEnMaybe_48 | out_roready_73 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_52 =
        dmiProgramBufferWrEnMaybe_52 | out_roready_42 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_56 =
        dmiProgramBufferWrEnMaybe_56 | out_roready_18 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          dmiProgramBufferAccessVec_60 =
        dmiProgramBufferWrEnMaybe_60 | out_roready_107 & auto_dmi_in_a_bits_mask[0];	// Bitwise.scala:26:51, Debug.scala:1156:108, RegisterRouter.scala:79:24
      automatic logic          autoexec;	// Debug.scala:1167:48
      automatic logic          COMMANDWrEn;	// Debug.scala:1180:40
      automatic logic [1023:0] _GEN_16;	// OneHot.scala:58:35
      automatic logic [1023:0] hartResumingIdIndex;	// OneHot.scala:58:35
      automatic logic          hartResumingWrEn;	// RegisterRouter.scala:79:24
      automatic logic          _regAccessRegisterCommand_T_1;	// Debug.scala:1666:103
      automatic logic          _GEN_17;	// Debug.scala:1674:37
      autoexec =
        dmiAbstractDataAccessVec_0 & ABSTRACTAUTOReg_autoexecdata[0]
        | dmiAbstractDataAccessVec_4 & ABSTRACTAUTOReg_autoexecdata[1]
        | dmiProgramBufferAccessVec_0 & ABSTRACTAUTOReg_autoexecprogbuf[0]
        | dmiProgramBufferAccessVec_4 & ABSTRACTAUTOReg_autoexecprogbuf[1]
        | dmiProgramBufferAccessVec_8 & ABSTRACTAUTOReg_autoexecprogbuf[2]
        | dmiProgramBufferAccessVec_12 & ABSTRACTAUTOReg_autoexecprogbuf[3]
        | dmiProgramBufferAccessVec_16 & ABSTRACTAUTOReg_autoexecprogbuf[4]
        | dmiProgramBufferAccessVec_20 & ABSTRACTAUTOReg_autoexecprogbuf[5]
        | dmiProgramBufferAccessVec_24 & ABSTRACTAUTOReg_autoexecprogbuf[6]
        | dmiProgramBufferAccessVec_28 & ABSTRACTAUTOReg_autoexecprogbuf[7]
        | dmiProgramBufferAccessVec_32 & ABSTRACTAUTOReg_autoexecprogbuf[8]
        | dmiProgramBufferAccessVec_36 & ABSTRACTAUTOReg_autoexecprogbuf[9]
        | dmiProgramBufferAccessVec_40 & ABSTRACTAUTOReg_autoexecprogbuf[10]
        | dmiProgramBufferAccessVec_44 & ABSTRACTAUTOReg_autoexecprogbuf[11]
        | dmiProgramBufferAccessVec_48 & ABSTRACTAUTOReg_autoexecprogbuf[12]
        | dmiProgramBufferAccessVec_52 & ABSTRACTAUTOReg_autoexecprogbuf[13]
        | dmiProgramBufferAccessVec_56 & ABSTRACTAUTOReg_autoexecprogbuf[14]
        | dmiProgramBufferAccessVec_60 & ABSTRACTAUTOReg_autoexecprogbuf[15];	// Debug.scala:1131:36, :1153:105, :1156:108, :1164:{54,140}, :1165:{57,144}, :1167:48
      COMMANDWrEn = COMMANDWrEnMaybe & ~(|ctrlStateReg);	// Debug.scala:1180:40, :1616:27, :1626:44, RegisterRouter.scala:79:24
      _GEN_16 = {1014'h0, auto_tl_in_a_bits_data[9:0]};	// OneHot.scala:58:35, RegisterRouter.scala:79:24
      hartResumingIdIndex = 1024'h1 << _GEN_16;	// OneHot.scala:58:35
      hartResumingWrEn = out_woready_1_49 & (&_out_womask_T_195);	// RegisterRouter.scala:79:24
      _regAccessRegisterCommand_T_1 = ABSTRACTCSReg_cmderr == 3'h0;	// Debug.scala:833:35, :1087:34, :1666:103
      _GEN_17 =
        COMMANDWrEn & ~(|(_COMMANDWrData_WIRE_1[31:24])) & _regAccessRegisterCommand_T_1
        | autoexec & commandRegIsAccessRegister & _regAccessRegisterCommand_T_1;	// Debug.scala:265:{24,30}, :1167:48, :1175:65, :1180:40, :1640:60, :1641:58, :1666:{78,103}, :1667:78, :1674:37
      if (hartHaltedWrEn) begin	// RegisterRouter.scala:79:24
        automatic logic [1023:0] hartHaltedIdIndex;	// OneHot.scala:58:35
        hartHaltedIdIndex = 1024'h1 << _GEN_16;	// OneHot.scala:58:35
        haltedBitRegs <=
          (haltedBitRegs | hartHaltedIdIndex[5:0])
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:778:31, :1218:{43,64,66,86}, OneHot.scala:58:35, ShiftReg.scala:45:23
      end
      else if (hartResumingWrEn)	// RegisterRouter.scala:79:24
        haltedBitRegs <=
          ~(hartResumingIdIndex[5:0]) & haltedBitRegs
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:778:31, :1220:{45,69,71,91}, OneHot.scala:58:35, ShiftReg.scala:45:23
      else	// RegisterRouter.scala:79:24
        haltedBitRegs <=
          haltedBitRegs
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:778:31, :1222:{42,44,64}, ShiftReg.scala:45:23
      if (resumereq)	// Debug.scala:890:41
        resumeReqRegs <=
          (resumeReqRegs
           | {hamaskWrSel_5,
              hamaskWrSel_4,
              hamaskWrSel_3,
              hamaskWrSel_2,
              hamaskWrSel_1,
              hamaskWrSel_0})
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:779:31, :842:78, :1229:{43,57,65,67,87}, ShiftReg.scala:45:23
      else if (hartResumingWrEn)	// RegisterRouter.scala:79:24
        resumeReqRegs <=
          ~(hartResumingIdIndex[5:0]) & resumeReqRegs
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:779:31, :1226:{45,69,71,91}, OneHot.scala:58:35, ShiftReg.scala:45:23
      else	// RegisterRouter.scala:79:24
        resumeReqRegs <=
          resumeReqRegs
          & ~{_hartIsInResetSync_5_debug_hartReset_5_io_q,
              _hartIsInResetSync_4_debug_hartReset_4_io_q,
              _hartIsInResetSync_3_debug_hartReset_3_io_q,
              _hartIsInResetSync_2_debug_hartReset_2_io_q,
              _hartIsInResetSync_1_debug_hartReset_1_io_q,
              _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:779:31, :1212:{40,42,62}, ShiftReg.scala:45:23
      if (io_innerCtrl_valid & io_innerCtrl_bits_ackhavereset)	// Debug.scala:922:33
        haveResetBitRegs <=
          haveResetBitRegs
          & ~{hamaskWrSel_5,
              hamaskWrSel_4,
              hamaskWrSel_3,
              hamaskWrSel_2,
              hamaskWrSel_1,
              hamaskWrSel_0}
          | {_hartIsInResetSync_5_debug_hartReset_5_io_q,
             _hartIsInResetSync_4_debug_hartReset_4_io_q,
             _hartIsInResetSync_3_debug_hartReset_3_io_q,
             _hartIsInResetSync_2_debug_hartReset_2_io_q,
             _hartIsInResetSync_1_debug_hartReset_1_io_q,
             _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:780:31, :842:78, :923:{47,50,64,74,94}, ShiftReg.scala:45:23
      else	// Debug.scala:922:33
        haveResetBitRegs <=
          haveResetBitRegs
          | {_hartIsInResetSync_5_debug_hartReset_5_io_q,
             _hartIsInResetSync_4_debug_hartReset_4_io_q,
             _hartIsInResetSync_3_debug_hartReset_3_io_q,
             _hartIsInResetSync_2_debug_hartReset_2_io_q,
             _hartIsInResetSync_1_debug_hartReset_1_io_q,
             _hartIsInResetSync_0_debug_hartReset_0_io_q};	// Debug.scala:780:31, :925:{46,66}, ShiftReg.scala:45:23
      if (io_innerCtrl_valid)
        selectedHartReg <= io_innerCtrl_bits_hartsel[2:0];	// Debug.scala:809:30, :817:25
      if (ABSTRACTCSWrEnMaybe & (|ctrlStateReg) | autoexecdataWrEnMaybe & (|ctrlStateReg)
          | autoexecprogbufWrEnMaybe & (|ctrlStateReg) | COMMANDWrEnMaybe
          & (|ctrlStateReg)
          | (dmiAbstractDataAccessVec_0 | dmiAbstractDataWrEnMaybe_1 | out_roready_103
             & auto_dmi_in_a_bits_mask[1] | dmiAbstractDataWrEnMaybe_2 | out_roready_103
             & auto_dmi_in_a_bits_mask[2] | dmiAbstractDataWrEnMaybe_3 | out_roready_103
             & auto_dmi_in_a_bits_mask[3] | dmiAbstractDataAccessVec_4
             | dmiAbstractDataWrEnMaybe_5 | out_roready_3 & auto_dmi_in_a_bits_mask[1]
             | dmiAbstractDataWrEnMaybe_6 | out_roready_3 & auto_dmi_in_a_bits_mask[2]
             | dmiAbstractDataWrEnMaybe_7 | out_roready_3 & auto_dmi_in_a_bits_mask[3])
          & (|ctrlStateReg)
          | (dmiProgramBufferAccessVec_0 | dmiProgramBufferWrEnMaybe_1 | out_roready_34
             & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_2 | out_roready_34
             & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_3 | out_roready_34
             & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_4
             | dmiProgramBufferWrEnMaybe_5 | out_roready_26 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_6 | out_roready_26 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_7 | out_roready_26 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_8 | dmiProgramBufferWrEnMaybe_9 | out_roready_38
             & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_10 | out_roready_38
             & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_11 | out_roready_38
             & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_12
             | dmiProgramBufferWrEnMaybe_13 | out_roready_81 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_14 | out_roready_81 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_15 | out_roready_81 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_16 | dmiProgramBufferWrEnMaybe_17
             | out_roready_98 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_18
             | out_roready_98 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_19
             | out_roready_98 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_20
             | dmiProgramBufferWrEnMaybe_21 | out_roready_14 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_22 | out_roready_14 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_23 | out_roready_14 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_24 | dmiProgramBufferWrEnMaybe_25
             | out_roready_22 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_26
             | out_roready_22 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_27
             | out_roready_22 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_28
             | dmiProgramBufferWrEnMaybe_29 | out_roready_77 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_30 | out_roready_77 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_31 | out_roready_77 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_32 | dmiProgramBufferWrEnMaybe_33
             | out_roready_93 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_34
             | out_roready_93 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_35
             | out_roready_93 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_36
             | dmiProgramBufferWrEnMaybe_37 | out_roready_30 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_38 | out_roready_30 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_39 | out_roready_30 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_40 | dmiProgramBufferWrEnMaybe_41 | out_roready_7
             & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_42 | out_roready_7
             & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_43 | out_roready_7
             & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_44
             | dmiProgramBufferWrEnMaybe_45 | out_roready_89 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_46 | out_roready_89 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_47 | out_roready_89 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_48 | dmiProgramBufferWrEnMaybe_49
             | out_roready_73 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_50
             | out_roready_73 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_51
             | out_roready_73 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_52
             | dmiProgramBufferWrEnMaybe_53 | out_roready_42 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_54 | out_roready_42 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_55 | out_roready_42 & auto_dmi_in_a_bits_mask[3]
             | dmiProgramBufferAccessVec_56 | dmiProgramBufferWrEnMaybe_57
             | out_roready_18 & auto_dmi_in_a_bits_mask[1] | dmiProgramBufferWrEnMaybe_58
             | out_roready_18 & auto_dmi_in_a_bits_mask[2] | dmiProgramBufferWrEnMaybe_59
             | out_roready_18 & auto_dmi_in_a_bits_mask[3] | dmiProgramBufferAccessVec_60
             | dmiProgramBufferWrEnMaybe_61 | out_roready_107 & auto_dmi_in_a_bits_mask[1]
             | dmiProgramBufferWrEnMaybe_62 | out_roready_107 & auto_dmi_in_a_bits_mask[2]
             | dmiProgramBufferWrEnMaybe_63 | out_roready_107
             & auto_dmi_in_a_bits_mask[3]) & (|ctrlStateReg))	// Bitwise.scala:26:51, Debug.scala:1153:105, :1156:108, :1158:68, :1159:69, :1616:27, :1626:44, :1632:42, :1633:42, :1634:44, :1635:42, :1636:{42,74}, :1637:42, RegisterRouter.scala:79:24
        ABSTRACTCSReg_cmderr <= 3'h1;	// Debug.scala:833:35, :1087:34
      else if (~(~(|ctrlStateReg) | _GEN_11) & _GEN_13 & hartExceptionWrEn)	// Debug.scala:1616:27, :1626:44, :1673:47, :1681:{30,59}, :1702:{30,51}, RegisterRouter.scala:79:24
        ABSTRACTCSReg_cmderr <= 3'h3;	// Debug.scala:833:35, :1087:34
      else if ((|ctrlStateReg)
                 ? _GEN_11 & commandRegIsUnsupported
                 : ~_GEN_17
                   & (COMMANDWrEn & (|(_COMMANDWrData_WIRE_1[31:24])) | autoexec
                      & commandRegIsUnsupported))	// Debug.scala:265:{24,30}, :1167:48, :1175:65, :1180:40, :1616:27, :1626:44, :1640:60, :1643:46, :1657:39, :1658:115, :1673:47, :1674:{37,66}, :1676:43, :1677:26, :1678:{28,56}, :1681:{30,59}, :1688:38
        ABSTRACTCSReg_cmderr <= 3'h2;	// Debug.scala:833:35, :1087:34
      else if ((|ctrlStateReg) & _GEN_11 & ~commandRegIsUnsupported
               & commandRegBadHaltResume)	// Debug.scala:1616:27, :1626:44, :1657:39, :1658:115, :1660:73, :1662:33, :1673:47, :1681:{30,59}, :1688:38, :1691:43
        ABSTRACTCSReg_cmderr <= 3'h4;	// Debug.scala:833:35, :1087:34
      else	// Debug.scala:1673:47, :1681:59
        ABSTRACTCSReg_cmderr <=
          ({3{~(ABSTRACTCSWrEnMaybe & ~(|ctrlStateReg))}}
           | ~(auto_dmi_in_a_bits_data[10:8])) & ABSTRACTCSReg_cmderr;	// Debug.scala:1087:34, :1095:51, :1114:30, :1115:{32,58}, :1616:27, :1626:44, RegisterRouter.scala:79:24
      if (autoexecprogbufWrEnMaybe & ~(|ctrlStateReg))	// Debug.scala:1144:38, :1616:27, :1626:44, RegisterRouter.scala:79:24
        ABSTRACTAUTOReg_autoexecprogbuf <= auto_dmi_in_a_bits_data[31:16];	// Debug.scala:1131:36, RegisterRouter.scala:79:24
      if (autoexecdataWrEnMaybe & ~(|ctrlStateReg))	// Debug.scala:1147:35, :1616:27, :1626:44, RegisterRouter.scala:79:24
        ABSTRACTAUTOReg_autoexecdata <= {10'h0, auto_dmi_in_a_bits_data[1:0]};	// Debug.scala:842:61, :1131:36, :1148:73, RegisterRouter.scala:79:24
      if (COMMANDWrEn) begin	// Debug.scala:1180:40
        COMMANDRdData_cmdtype <= _COMMANDWrData_WIRE_1[31:24];	// Debug.scala:265:{24,30}, :1172:25, :1175:65
        COMMANDRdData_control <= _COMMANDWrData_WIRE_1[23:0];	// Debug.scala:265:{24,30}, :1172:25, :1175:65
      end
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_0 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_0 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_0 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_1 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_1 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_1 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_2 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_2 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_2 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_3 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_3 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_3 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_4 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_4 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_4 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_5 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_5 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_5 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_6 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_6 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_6 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_122 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        abstractDataMem_7 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      else if (dmiAbstractDataWrEnMaybe_7 & ~(|ctrlStateReg))	// Debug.scala:1195:36, :1348:91, :1349:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        abstractDataMem_7 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1195:36, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_0 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_0 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_0 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_1 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_1 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_1 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_2 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_2 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_2 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_3 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_3 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_3 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_4 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_4 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_4 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_5 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_5 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_5 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_6 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_6 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_6 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_138 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_7 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_7 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_7 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_8 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_8 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_8 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_9 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_9 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_9 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_10 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_10 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_10 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_11 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_11 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_11 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_12 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_12 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_12 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_13 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_13 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_13 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_14 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_14 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_14 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_82 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_15 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_15 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_15 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_16 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_16 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_16 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_17 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_17 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_17 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_18 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_18 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_18 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_19 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_19 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_19 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_20 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_20 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_20 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_21 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_21 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_21 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_22 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_22 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_22 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_31 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_23 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_23 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_23 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_24 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_24 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_24 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_25 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_25 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_25 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_26 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_26 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_26 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_27 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_27 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_27 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_28 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_28 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_28 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_29 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_29 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_29 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_30 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_30 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_30 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_162 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_31 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_31 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_31 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_32 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_32 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_32 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_33 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_33 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_33 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_34 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_34 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_34 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_35 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_35 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_35 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_36 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_36 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_36 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_37 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_37 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_37 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_38 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_38 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_38 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_114 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_39 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_39 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_39 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_40 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_40 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_40 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_41 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_41 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_41 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_42 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_42 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_42 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_43 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_43 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_43 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_44 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_44 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_44 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_45 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_45 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_45 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_46 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_46 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_46 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_57 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_47 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_47 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_47 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_48 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_48 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_48 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_49 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_49 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_49 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_50 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_50 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_50 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_51 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_51 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_51 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_52 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_52 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_52 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_53 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_53 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_53 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_54 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_54 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_54 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_15 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_55 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_55 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_55 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_56 <= auto_tl_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_56 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_56 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[1])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_57 <= auto_tl_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_57 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_57 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[2])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_58 <= auto_tl_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_58 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_58 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[3])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_59 <= auto_tl_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_59 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_59 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_60 <= auto_tl_in_a_bits_data[39:32];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_60 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_60 <= auto_dmi_in_a_bits_data[7:0];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[5])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_61 <= auto_tl_in_a_bits_data[47:40];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_61 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_61 <= auto_dmi_in_a_bits_data[15:8];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[6])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_62 <= auto_tl_in_a_bits_data[55:48];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_62 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_62 <= auto_dmi_in_a_bits_data[23:16];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (out_woready_1_170 & auto_tl_in_a_bits_mask[7])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        programBufferMem_63 <= auto_tl_in_a_bits_data[63:56];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      else if (dmiProgramBufferWrEnMaybe_63 & ~(|ctrlStateReg))	// Debug.scala:1199:34, :1370:93, :1371:11, :1616:27, :1626:44, RegisterRouter.scala:79:24
        programBufferMem_63 <= auto_dmi_in_a_bits_data[31:24];	// Debug.scala:1199:34, RegisterRouter.scala:79:24
      if (|ctrlStateReg) begin	// Debug.scala:1616:27, :1626:44
        if (_GEN_11)	// Debug.scala:1681:30
          ctrlStateReg <= {~_GEN_12, 1'h0};	// Debug.scala:1616:27, :1688:38, :1690:22, :1691:43, :1693:22, :1695:33, Nodes.scala:24:25
        else if (_GEN_13
                 & (hartExceptionWrEn | ~goReg & hartHaltedWrEn
                    & auto_tl_in_a_bits_data[9:0] == {7'h0, selectedHartReg}))	// Debug.scala:809:30, :1379:27, :1702:{30,51}, :1707:{18,48,95,116}, :1708:22, :1710:31, :1712:24, :1715:53, RegisterRouter.scala:79:24
          ctrlStateReg <= 2'h0;	// Debug.scala:885:47, :1616:27
      end
      else if (_GEN_17)	// Debug.scala:1674:37
        ctrlStateReg <= 2'h1;	// Debug.scala:1616:27, :1675:22
    end
    else begin
      haltedBitRegs <= 6'h0;	// Debug.scala:778:31, RegisterRouter.scala:79:24
      resumeReqRegs <= 6'h0;	// Debug.scala:779:31, RegisterRouter.scala:79:24
      haveResetBitRegs <= 6'h0;	// Debug.scala:780:31, RegisterRouter.scala:79:24
      selectedHartReg <= 3'h0;	// Debug.scala:809:30, :833:35
      ABSTRACTCSReg_progbufsize <= 5'h10;	// Debug.scala:1087:34
      ABSTRACTCSReg_cmderr <= 3'h0;	// Debug.scala:833:35, :1087:34
      ABSTRACTCSReg_datacount <= 4'h2;	// Debug.scala:887:34, :1087:34
      ABSTRACTAUTOReg_autoexecprogbuf <= 16'h0;	// Debug.scala:1130:54, :1131:36
      ABSTRACTAUTOReg_autoexecdata <= 12'h0;	// Debug.scala:1130:54, :1131:36
      COMMANDRdData_cmdtype <= 8'h0;	// Debug.scala:1171:45, :1172:25
      COMMANDRdData_control <= 24'h0;	// Debug.scala:1171:45, :1172:25
      abstractDataMem_0 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_1 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_2 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_3 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_4 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_5 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_6 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      abstractDataMem_7 <= 8'h0;	// Debug.scala:1171:45, :1195:36
      programBufferMem_0 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_1 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_2 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_3 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_4 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_5 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_6 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_7 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_8 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_9 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_10 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_11 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_12 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_13 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_14 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_15 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_16 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_17 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_18 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_19 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_20 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_21 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_22 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_23 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_24 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_25 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_26 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_27 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_28 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_29 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_30 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_31 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_32 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_33 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_34 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_35 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_36 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_37 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_38 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_39 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_40 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_41 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_42 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_43 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_44 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_45 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_46 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_47 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_48 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_49 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_50 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_51 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_52 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_53 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_54 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_55 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_56 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_57 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_58 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_59 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_60 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_61 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_62 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      programBufferMem_63 <= 8'h0;	// Debug.scala:1171:45, :1199:34
      ctrlStateReg <= 2'h0;	// Debug.scala:885:47, :1616:27
    end
    hamaskReg_0 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_0
           : hamaskReg_0);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    hamaskReg_1 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_1
           : hamaskReg_1);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    hamaskReg_2 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_2
           : hamaskReg_2);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    hamaskReg_3 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_3
           : hamaskReg_3);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    hamaskReg_4 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_4
           : hamaskReg_4);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    hamaskReg_5 <=
      io_dmactive
      & (io_innerCtrl_valid
           ? io_innerCtrl_bits_hasel & io_innerCtrl_bits_hamask_5
           : hamaskReg_5);	// Debug.scala:823:26, :824:47, :825:19, :826:39, :827:{19,25}
    goReg <= io_dmactive & (goAbstract | ~hartGoingWrEn & goReg);	// Debug.scala:1379:27, :1385:24, :1386:13, :1388:25, :1389:15, :1390:33, :1392:15, :1673:47, :1681:59, RegisterRouter.scala:79:24
    if (goAbstract) begin	// Debug.scala:1673:47, :1681:59
      if (COMMANDRdData_control[17]) begin	// Debug.scala:1172:25, :1417:73
        if (COMMANDRdData_control[16])	// Debug.scala:1172:25, :1417:73
          abstractGeneratedMem_0 <=
            {17'h7000, COMMANDRdData_control[22:20], COMMANDRdData_control[4:0], 7'h3};	// Debug.scala:1172:25, :1417:73, :1470:35, :1476:55, :1477:54, :1481:12
        else	// Debug.scala:1417:73
          abstractGeneratedMem_0 <=
            {7'h1C,
             COMMANDRdData_control[4:0],
             5'h0,
             COMMANDRdData_control[22:20],
             12'h23};	// Debug.scala:1172:25, :1417:73, :1470:35, :1477:54, :1493:19, :1494:12
      end
      else	// Debug.scala:1417:73
        abstractGeneratedMem_0 <= 32'h13;	// Debug.scala:1470:35, :1526:21
      if (COMMANDRdData_control[18])	// Debug.scala:1172:25, :1417:73
        abstractGeneratedMem_1 <= 32'h13;	// Debug.scala:1470:35, :1526:21
      else	// Debug.scala:1417:73
        abstractGeneratedMem_1 <= 32'h100073;	// Debug.scala:1470:35, :1528:39
    end
    if (reset) begin
      hrmaskReg_0 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
      hrmaskReg_1 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
      hrmaskReg_2 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
      hrmaskReg_3 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
      hrmaskReg_4 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
      hrmaskReg_5 <= 1'h0;	// Debug.scala:854:29, Nodes.scala:24:25
    end
    else begin
      hrmaskReg_0 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_0 : hrmaskReg_0);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
      hrmaskReg_1 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_1 : hrmaskReg_1);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
      hrmaskReg_2 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_2 : hrmaskReg_2);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
      hrmaskReg_3 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_3 : hrmaskReg_3);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
      hrmaskReg_4 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_4 : hrmaskReg_4);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
      hrmaskReg_5 <=
        io_dmactive & (io_innerCtrl_valid ? io_innerCtrl_bits_hrmask_5 : hrmaskReg_5);	// Debug.scala:854:29, :861:45, :862:17, :863:37, :864:17
    end
  end // always @(posedge)
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      hrDebugIntReg_0 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hrDebugIntReg_1 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hrDebugIntReg_2 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hrDebugIntReg_3 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hrDebugIntReg_4 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hrDebugIntReg_5 <= 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
      hgParticipateHart_0 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgParticipateHart_1 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgParticipateHart_2 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgParticipateHart_3 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgParticipateHart_4 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgParticipateHart_5 <= 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
      hgFired_1 <= 1'h0;	// Debug.scala:1011:38, Nodes.scala:24:25
    end
    else begin
      automatic logic       _GEN_18 =
        _out_wofireMux_T_2 & auto_dmi_in_a_bits_address[7:2] == 6'h32
        & ~(auto_dmi_in_a_bits_address[8]) & auto_dmi_in_a_bits_mask[0]
        & auto_dmi_in_a_bits_data[1] & ~(auto_dmi_in_a_bits_data[0]);	// Bitwise.scala:26:51, Cat.scala:30:58, Conditional.scala:37:30, Debug.scala:949:{53,55}, Edges.scala:191:34, RegisterRouter.scala:79:24
      automatic logic       _GEN_19 = auto_dmi_in_a_bits_data[6:2] < 5'h2;	// Debug.scala:950:62, RegisterRouter.scala:79:24
      automatic logic [9:0] _hgHartFiring_1_T;	// Debug.scala:1032:60
      hrDebugIntReg_0 <=
        io_dmactive & hrmaskReg_0
        & (_hartIsInResetSync_0_debug_hartReset_0_io_q | hrDebugIntReg_0
           & ~(haltedBitRegs[0]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hrDebugIntReg_1 <=
        io_dmactive & hrmaskReg_1
        & (_hartIsInResetSync_1_debug_hartReset_1_io_q | hrDebugIntReg_1
           & ~(haltedBitRegs[1]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hrDebugIntReg_2 <=
        io_dmactive & hrmaskReg_2
        & (_hartIsInResetSync_2_debug_hartReset_2_io_q | hrDebugIntReg_2
           & ~(haltedBitRegs[2]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hrDebugIntReg_3 <=
        io_dmactive & hrmaskReg_3
        & (_hartIsInResetSync_3_debug_hartReset_3_io_q | hrDebugIntReg_3
           & ~(haltedBitRegs[3]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hrDebugIntReg_4 <=
        io_dmactive & hrmaskReg_4
        & (_hartIsInResetSync_4_debug_hartReset_4_io_q | hrDebugIntReg_4
           & ~(haltedBitRegs[4]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hrDebugIntReg_5 <=
        io_dmactive & hrmaskReg_5
        & (_hartIsInResetSync_5_debug_hartReset_5_io_q | hrDebugIntReg_5
           & ~(haltedBitRegs[5]));	// Debug.scala:778:31, :854:29, :868:34, :869:47, :870:23, :872:23, :874:44, ShiftReg.scala:45:23, package.scala:65:72, :66:75, :70:38
      hgParticipateHart_0 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_0 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_0);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      hgParticipateHart_1 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_1 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_1);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      hgParticipateHart_2 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_2 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_2);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      hgParticipateHart_3 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_3 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_3);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      hgParticipateHart_4 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_4 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_4);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      hgParticipateHart_5 <=
        io_dmactive
        & (_GEN_18 & hamaskFull_5 & _GEN_19
             ? auto_dmi_in_a_bits_data[2]
             : hgParticipateHart_5);	// Debug.scala:829:18, :832:44, :833:35, :942:38, :946:49, :947:40, :949:53, :950:{37,62,81}, :951:42
      _hgHartFiring_1_T = {4'h0, haltedBitRegs} >> auto_tl_in_a_bits_data[9:0];	// Debug.scala:778:31, :950:62, :1032:60, RegisterRouter.scala:79:24
      hgFired_1 <=
        io_dmactive
        & (~hgFired_1 & hartHaltedWrEn & ~(_hgHartFiring_1_T[0])
           & _GEN_7[auto_tl_in_a_bits_data[2:0]]
           | ~(hgFired_1 & (haltedBitRegs[0] | ~hgParticipateHart_0)
               & (haltedBitRegs[1] | ~hgParticipateHart_1)
               & (haltedBitRegs[2] | ~hgParticipateHart_2)
               & (haltedBitRegs[3] | ~hgParticipateHart_3)
               & (haltedBitRegs[4] | ~hgParticipateHart_4)
               & (haltedBitRegs[5] | ~hgParticipateHart_5)) & hgFired_1);	// Debug.scala:778:31, :942:38, :955:29, :1011:38, :1032:{46,60,140}, :1033:{48,82}, :1035:49, :1036:23, :1037:{21,34,75}, :1038:23, :1039:{34,80}, :1040:23, RegisterRouter.scala:79:24, package.scala:66:75
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:24];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h19; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        haltedBitRegs = _RANDOM[5'h0][5:0];	// Debug.scala:778:31
        resumeReqRegs = _RANDOM[5'h0][11:6];	// Debug.scala:778:31, :779:31
        haveResetBitRegs = _RANDOM[5'h0][17:12];	// Debug.scala:778:31, :780:31
        selectedHartReg = _RANDOM[5'h0][20:18];	// Debug.scala:778:31, :809:30
        hamaskReg_0 = _RANDOM[5'h0][21];	// Debug.scala:778:31, :823:26
        hamaskReg_1 = _RANDOM[5'h0][22];	// Debug.scala:778:31, :823:26
        hamaskReg_2 = _RANDOM[5'h0][23];	// Debug.scala:778:31, :823:26
        hamaskReg_3 = _RANDOM[5'h0][24];	// Debug.scala:778:31, :823:26
        hamaskReg_4 = _RANDOM[5'h0][25];	// Debug.scala:778:31, :823:26
        hamaskReg_5 = _RANDOM[5'h0][26];	// Debug.scala:778:31, :823:26
        hrmaskReg_0 = _RANDOM[5'h0][27];	// Debug.scala:778:31, :854:29
        hrmaskReg_1 = _RANDOM[5'h0][28];	// Debug.scala:778:31, :854:29
        hrmaskReg_2 = _RANDOM[5'h0][29];	// Debug.scala:778:31, :854:29
        hrmaskReg_3 = _RANDOM[5'h0][30];	// Debug.scala:778:31, :854:29
        hrmaskReg_4 = _RANDOM[5'h0][31];	// Debug.scala:778:31, :854:29
        hrmaskReg_5 = _RANDOM[5'h1][0];	// Debug.scala:854:29
        hrDebugIntReg_0 = _RANDOM[5'h1][1];	// Debug.scala:854:29, :868:34
        hrDebugIntReg_1 = _RANDOM[5'h1][2];	// Debug.scala:854:29, :868:34
        hrDebugIntReg_2 = _RANDOM[5'h1][3];	// Debug.scala:854:29, :868:34
        hrDebugIntReg_3 = _RANDOM[5'h1][4];	// Debug.scala:854:29, :868:34
        hrDebugIntReg_4 = _RANDOM[5'h1][5];	// Debug.scala:854:29, :868:34
        hrDebugIntReg_5 = _RANDOM[5'h1][6];	// Debug.scala:854:29, :868:34
        hgParticipateHart_0 = _RANDOM[5'h1][7];	// Debug.scala:854:29, :942:38
        hgParticipateHart_1 = _RANDOM[5'h1][8];	// Debug.scala:854:29, :942:38
        hgParticipateHart_2 = _RANDOM[5'h1][9];	// Debug.scala:854:29, :942:38
        hgParticipateHart_3 = _RANDOM[5'h1][10];	// Debug.scala:854:29, :942:38
        hgParticipateHart_4 = _RANDOM[5'h1][11];	// Debug.scala:854:29, :942:38
        hgParticipateHart_5 = _RANDOM[5'h1][12];	// Debug.scala:854:29, :942:38
        hgFired_1 = _RANDOM[5'h1][14];	// Debug.scala:854:29, :1011:38
        ABSTRACTCSReg_progbufsize = _RANDOM[5'h1][22:18];	// Debug.scala:854:29, :1087:34
        ABSTRACTCSReg_cmderr = _RANDOM[5'h2][6:4];	// Debug.scala:1087:34
        ABSTRACTCSReg_datacount = _RANDOM[5'h2][14:11];	// Debug.scala:1087:34
        ABSTRACTAUTOReg_autoexecprogbuf = _RANDOM[5'h2][30:15];	// Debug.scala:1087:34, :1131:36
        ABSTRACTAUTOReg_autoexecdata = _RANDOM[5'h3][14:3];	// Debug.scala:1131:36
        COMMANDRdData_cmdtype = _RANDOM[5'h3][22:15];	// Debug.scala:1131:36, :1172:25
        COMMANDRdData_control = {_RANDOM[5'h3][31:23], _RANDOM[5'h4][14:0]};	// Debug.scala:1131:36, :1172:25
        abstractDataMem_0 = _RANDOM[5'h4][22:15];	// Debug.scala:1172:25, :1195:36
        abstractDataMem_1 = _RANDOM[5'h4][30:23];	// Debug.scala:1172:25, :1195:36
        abstractDataMem_2 = {_RANDOM[5'h4][31], _RANDOM[5'h5][6:0]};	// Debug.scala:1172:25, :1195:36
        abstractDataMem_3 = _RANDOM[5'h5][14:7];	// Debug.scala:1195:36
        abstractDataMem_4 = _RANDOM[5'h5][22:15];	// Debug.scala:1195:36
        abstractDataMem_5 = _RANDOM[5'h5][30:23];	// Debug.scala:1195:36
        abstractDataMem_6 = {_RANDOM[5'h5][31], _RANDOM[5'h6][6:0]};	// Debug.scala:1195:36
        abstractDataMem_7 = _RANDOM[5'h6][14:7];	// Debug.scala:1195:36
        programBufferMem_0 = _RANDOM[5'h6][22:15];	// Debug.scala:1195:36, :1199:34
        programBufferMem_1 = _RANDOM[5'h6][30:23];	// Debug.scala:1195:36, :1199:34
        programBufferMem_2 = {_RANDOM[5'h6][31], _RANDOM[5'h7][6:0]};	// Debug.scala:1195:36, :1199:34
        programBufferMem_3 = _RANDOM[5'h7][14:7];	// Debug.scala:1199:34
        programBufferMem_4 = _RANDOM[5'h7][22:15];	// Debug.scala:1199:34
        programBufferMem_5 = _RANDOM[5'h7][30:23];	// Debug.scala:1199:34
        programBufferMem_6 = {_RANDOM[5'h7][31], _RANDOM[5'h8][6:0]};	// Debug.scala:1199:34
        programBufferMem_7 = _RANDOM[5'h8][14:7];	// Debug.scala:1199:34
        programBufferMem_8 = _RANDOM[5'h8][22:15];	// Debug.scala:1199:34
        programBufferMem_9 = _RANDOM[5'h8][30:23];	// Debug.scala:1199:34
        programBufferMem_10 = {_RANDOM[5'h8][31], _RANDOM[5'h9][6:0]};	// Debug.scala:1199:34
        programBufferMem_11 = _RANDOM[5'h9][14:7];	// Debug.scala:1199:34
        programBufferMem_12 = _RANDOM[5'h9][22:15];	// Debug.scala:1199:34
        programBufferMem_13 = _RANDOM[5'h9][30:23];	// Debug.scala:1199:34
        programBufferMem_14 = {_RANDOM[5'h9][31], _RANDOM[5'hA][6:0]};	// Debug.scala:1199:34
        programBufferMem_15 = _RANDOM[5'hA][14:7];	// Debug.scala:1199:34
        programBufferMem_16 = _RANDOM[5'hA][22:15];	// Debug.scala:1199:34
        programBufferMem_17 = _RANDOM[5'hA][30:23];	// Debug.scala:1199:34
        programBufferMem_18 = {_RANDOM[5'hA][31], _RANDOM[5'hB][6:0]};	// Debug.scala:1199:34
        programBufferMem_19 = _RANDOM[5'hB][14:7];	// Debug.scala:1199:34
        programBufferMem_20 = _RANDOM[5'hB][22:15];	// Debug.scala:1199:34
        programBufferMem_21 = _RANDOM[5'hB][30:23];	// Debug.scala:1199:34
        programBufferMem_22 = {_RANDOM[5'hB][31], _RANDOM[5'hC][6:0]};	// Debug.scala:1199:34
        programBufferMem_23 = _RANDOM[5'hC][14:7];	// Debug.scala:1199:34
        programBufferMem_24 = _RANDOM[5'hC][22:15];	// Debug.scala:1199:34
        programBufferMem_25 = _RANDOM[5'hC][30:23];	// Debug.scala:1199:34
        programBufferMem_26 = {_RANDOM[5'hC][31], _RANDOM[5'hD][6:0]};	// Debug.scala:1199:34
        programBufferMem_27 = _RANDOM[5'hD][14:7];	// Debug.scala:1199:34
        programBufferMem_28 = _RANDOM[5'hD][22:15];	// Debug.scala:1199:34
        programBufferMem_29 = _RANDOM[5'hD][30:23];	// Debug.scala:1199:34
        programBufferMem_30 = {_RANDOM[5'hD][31], _RANDOM[5'hE][6:0]};	// Debug.scala:1199:34
        programBufferMem_31 = _RANDOM[5'hE][14:7];	// Debug.scala:1199:34
        programBufferMem_32 = _RANDOM[5'hE][22:15];	// Debug.scala:1199:34
        programBufferMem_33 = _RANDOM[5'hE][30:23];	// Debug.scala:1199:34
        programBufferMem_34 = {_RANDOM[5'hE][31], _RANDOM[5'hF][6:0]};	// Debug.scala:1199:34
        programBufferMem_35 = _RANDOM[5'hF][14:7];	// Debug.scala:1199:34
        programBufferMem_36 = _RANDOM[5'hF][22:15];	// Debug.scala:1199:34
        programBufferMem_37 = _RANDOM[5'hF][30:23];	// Debug.scala:1199:34
        programBufferMem_38 = {_RANDOM[5'hF][31], _RANDOM[5'h10][6:0]};	// Debug.scala:1199:34
        programBufferMem_39 = _RANDOM[5'h10][14:7];	// Debug.scala:1199:34
        programBufferMem_40 = _RANDOM[5'h10][22:15];	// Debug.scala:1199:34
        programBufferMem_41 = _RANDOM[5'h10][30:23];	// Debug.scala:1199:34
        programBufferMem_42 = {_RANDOM[5'h10][31], _RANDOM[5'h11][6:0]};	// Debug.scala:1199:34
        programBufferMem_43 = _RANDOM[5'h11][14:7];	// Debug.scala:1199:34
        programBufferMem_44 = _RANDOM[5'h11][22:15];	// Debug.scala:1199:34
        programBufferMem_45 = _RANDOM[5'h11][30:23];	// Debug.scala:1199:34
        programBufferMem_46 = {_RANDOM[5'h11][31], _RANDOM[5'h12][6:0]};	// Debug.scala:1199:34
        programBufferMem_47 = _RANDOM[5'h12][14:7];	// Debug.scala:1199:34
        programBufferMem_48 = _RANDOM[5'h12][22:15];	// Debug.scala:1199:34
        programBufferMem_49 = _RANDOM[5'h12][30:23];	// Debug.scala:1199:34
        programBufferMem_50 = {_RANDOM[5'h12][31], _RANDOM[5'h13][6:0]};	// Debug.scala:1199:34
        programBufferMem_51 = _RANDOM[5'h13][14:7];	// Debug.scala:1199:34
        programBufferMem_52 = _RANDOM[5'h13][22:15];	// Debug.scala:1199:34
        programBufferMem_53 = _RANDOM[5'h13][30:23];	// Debug.scala:1199:34
        programBufferMem_54 = {_RANDOM[5'h13][31], _RANDOM[5'h14][6:0]};	// Debug.scala:1199:34
        programBufferMem_55 = _RANDOM[5'h14][14:7];	// Debug.scala:1199:34
        programBufferMem_56 = _RANDOM[5'h14][22:15];	// Debug.scala:1199:34
        programBufferMem_57 = _RANDOM[5'h14][30:23];	// Debug.scala:1199:34
        programBufferMem_58 = {_RANDOM[5'h14][31], _RANDOM[5'h15][6:0]};	// Debug.scala:1199:34
        programBufferMem_59 = _RANDOM[5'h15][14:7];	// Debug.scala:1199:34
        programBufferMem_60 = _RANDOM[5'h15][22:15];	// Debug.scala:1199:34
        programBufferMem_61 = _RANDOM[5'h15][30:23];	// Debug.scala:1199:34
        programBufferMem_62 = {_RANDOM[5'h15][31], _RANDOM[5'h16][6:0]};	// Debug.scala:1199:34
        programBufferMem_63 = _RANDOM[5'h16][14:7];	// Debug.scala:1199:34
        goReg = _RANDOM[5'h16][15];	// Debug.scala:1199:34, :1379:27
        abstractGeneratedMem_0 = {_RANDOM[5'h16][31:16], _RANDOM[5'h17][15:0]};	// Debug.scala:1199:34, :1470:35
        abstractGeneratedMem_1 = {_RANDOM[5'h17][31:16], _RANDOM[5'h18][15:0]};	// Debug.scala:1470:35
        ctrlStateReg = _RANDOM[5'h18][17:16];	// Debug.scala:1470:35, :1616:27
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        hrDebugIntReg_0 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hrDebugIntReg_1 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hrDebugIntReg_2 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hrDebugIntReg_3 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hrDebugIntReg_4 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hrDebugIntReg_5 = 1'h0;	// Debug.scala:868:34, Nodes.scala:24:25
        hgParticipateHart_0 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgParticipateHart_1 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgParticipateHart_2 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgParticipateHart_3 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgParticipateHart_4 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgParticipateHart_5 = 1'h0;	// Debug.scala:942:38, Nodes.scala:24:25
        hgFired_1 = 1'h0;	// Debug.scala:1011:38, Nodes.scala:24:25
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_75 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_dmi_in_d_ready),
    .io_in_a_valid        (auto_dmi_in_a_valid),
    .io_in_a_bits_opcode  (auto_dmi_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_dmi_in_a_bits_param),
    .io_in_a_bits_size    (auto_dmi_in_a_bits_size),
    .io_in_a_bits_source  (auto_dmi_in_a_bits_source),
    .io_in_a_bits_address (auto_dmi_in_a_bits_address),
    .io_in_a_bits_mask    (auto_dmi_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_dmi_in_a_bits_corrupt),
    .io_in_d_ready        (auto_dmi_in_d_ready),
    .io_in_d_valid        (auto_dmi_in_a_valid),
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (auto_dmi_in_a_bits_size),
    .io_in_d_bits_source  (auto_dmi_in_a_bits_source)
  );
  TLMonitor_76 monitor_1 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_tl_in_d_ready),
    .io_in_a_valid        (auto_tl_in_a_valid),
    .io_in_a_bits_opcode  (auto_tl_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_tl_in_a_bits_param),
    .io_in_a_bits_size    (auto_tl_in_a_bits_size),
    .io_in_a_bits_source  (auto_tl_in_a_bits_source),
    .io_in_a_bits_address (auto_tl_in_a_bits_address),
    .io_in_a_bits_mask    (auto_tl_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_tl_in_a_bits_corrupt),
    .io_in_d_ready        (auto_tl_in_d_ready),
    .io_in_d_valid        (auto_tl_in_a_valid),
    .io_in_d_bits_opcode  (bundleIn_0_1_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (auto_tl_in_a_bits_size),
    .io_in_d_bits_source  (auto_tl_in_a_bits_source)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_0_debug_hartReset_0 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_0),
    .io_q  (_hartIsInResetSync_0_debug_hartReset_0_io_q)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_1_debug_hartReset_1 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_1),
    .io_q  (_hartIsInResetSync_1_debug_hartReset_1_io_q)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_2_debug_hartReset_2 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_2),
    .io_q  (_hartIsInResetSync_2_debug_hartReset_2_io_q)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_3_debug_hartReset_3 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_3),
    .io_q  (_hartIsInResetSync_3_debug_hartReset_3_io_q)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_4_debug_hartReset_4 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_4),
    .io_q  (_hartIsInResetSync_4_debug_hartReset_4_io_q)
  );
  AsyncResetSynchronizerShiftReg_w1_d3_i0 hartIsInResetSync_5_debug_hartReset_5 (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_hartIsInReset_5),
    .io_q  (_hartIsInResetSync_5_debug_hartReset_5_io_q)
  );
  assign auto_tl_in_d_bits_opcode = bundleIn_0_1_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_tl_in_d_bits_data =
    (_out_out_bits_data_T_76
       ? auto_tl_in_a_bits_address[10]
       : ~(out_oindex_1 == 8'h20 | out_oindex_1 == 8'h21 | out_oindex_1 == 8'h60
           | out_oindex_1 == 8'h67 | out_oindex_1 == 8'h68 | out_oindex_1 == 8'h69
           | out_oindex_1 == 8'h6A | out_oindex_1 == 8'h6B | out_oindex_1 == 8'h6C
           | out_oindex_1 == 8'h6D | out_oindex_1 == 8'h6E | out_oindex_1 == 8'h6F
           | out_oindex_1 == 8'h70 | out_oindex_1 == 8'h80 | out_oindex_1 == 8'h81
           | out_oindex_1 == 8'h82 | out_oindex_1 == 8'h83 | out_oindex_1 == 8'h84
           | out_oindex_1 == 8'h85 | out_oindex_1 == 8'h86 | out_oindex_1 == 8'h87
           | out_oindex_1 == 8'h88 | out_oindex_1 == 8'h89 | out_oindex_1 == 8'h8A)
         | ~(auto_tl_in_a_bits_address[10]))
      ? (_out_out_bits_data_T_76
           ? {7'h0,
              (&selectedHartReg) & goReg,
              7'h0,
              selectedHartReg == 3'h6 & goReg,
              6'h0,
              resumeReqRegs[5],
              _GEN_5 & goReg,
              6'h0,
              resumeReqRegs[4],
              _GEN_4 & goReg,
              6'h0,
              resumeReqRegs[3],
              _GEN_3 & goReg,
              6'h0,
              resumeReqRegs[2],
              _GEN_2 & goReg,
              6'h0,
              resumeReqRegs[1],
              _GEN_1 & goReg,
              6'h0,
              resumeReqRegs[0],
              _GEN_0 & goReg}
           : out_oindex_1 == 8'h20 | out_oindex_1 == 8'h21
               ? 64'h0
               : out_oindex_1 == 8'h60
                   ? 64'h380006F
                   : out_oindex_1 == 8'h67
                       ? {abstractGeneratedMem_1, abstractGeneratedMem_0}
                       : out_oindex_1 == 8'h68
                           ? {programBufferMem_7,
                              programBufferMem_6,
                              programBufferMem_5,
                              programBufferMem_4,
                              programBufferMem_3,
                              programBufferMem_2,
                              programBufferMem_1,
                              programBufferMem_0}
                           : out_oindex_1 == 8'h69
                               ? {programBufferMem_15,
                                  programBufferMem_14,
                                  programBufferMem_13,
                                  programBufferMem_12,
                                  programBufferMem_11,
                                  programBufferMem_10,
                                  programBufferMem_9,
                                  programBufferMem_8}
                               : out_oindex_1 == 8'h6A
                                   ? {programBufferMem_23,
                                      programBufferMem_22,
                                      programBufferMem_21,
                                      programBufferMem_20,
                                      programBufferMem_19,
                                      programBufferMem_18,
                                      programBufferMem_17,
                                      programBufferMem_16}
                                   : out_oindex_1 == 8'h6B
                                       ? {programBufferMem_31,
                                          programBufferMem_30,
                                          programBufferMem_29,
                                          programBufferMem_28,
                                          programBufferMem_27,
                                          programBufferMem_26,
                                          programBufferMem_25,
                                          programBufferMem_24}
                                       : out_oindex_1 == 8'h6C
                                           ? {programBufferMem_39,
                                              programBufferMem_38,
                                              programBufferMem_37,
                                              programBufferMem_36,
                                              programBufferMem_35,
                                              programBufferMem_34,
                                              programBufferMem_33,
                                              programBufferMem_32}
                                           : out_oindex_1 == 8'h6D
                                               ? {programBufferMem_47,
                                                  programBufferMem_46,
                                                  programBufferMem_45,
                                                  programBufferMem_44,
                                                  programBufferMem_43,
                                                  programBufferMem_42,
                                                  programBufferMem_41,
                                                  programBufferMem_40}
                                               : out_oindex_1 == 8'h6E
                                                   ? {programBufferMem_55,
                                                      programBufferMem_54,
                                                      programBufferMem_53,
                                                      programBufferMem_52,
                                                      programBufferMem_51,
                                                      programBufferMem_50,
                                                      programBufferMem_49,
                                                      programBufferMem_48}
                                                   : out_oindex_1 == 8'h6F
                                                       ? {programBufferMem_63,
                                                          programBufferMem_62,
                                                          programBufferMem_61,
                                                          programBufferMem_60,
                                                          programBufferMem_59,
                                                          programBufferMem_58,
                                                          programBufferMem_57,
                                                          programBufferMem_56}
                                                       : out_oindex_1 == 8'h70
                                                           ? {abstractDataMem_7,
                                                              abstractDataMem_6,
                                                              abstractDataMem_5,
                                                              abstractDataMem_4,
                                                              abstractDataMem_3,
                                                              abstractDataMem_2,
                                                              abstractDataMem_1,
                                                              abstractDataMem_0}
                                                           : out_oindex_1 == 8'h80
                                                               ? 64'h380006F00C0006F
                                                               : out_oindex_1 == 8'h81
                                                                   ? 64'hFF0000F0440006F
                                                                   : out_oindex_1 == 8'h82
                                                                       ? 64'hF14024737B241073
                                                                       : out_oindex_1 == 8'h83
                                                                           ? 64'h4004440310802023
                                                                           : out_oindex_1 == 8'h84
                                                                               ? 64'hFE0408E300347413
                                                                               : out_oindex_1 == 8'h85
                                                                                   ? 64'h4086300147413
                                                                                   : out_oindex_1 == 8'h86
                                                                                       ? 64'h100022237B202473
                                                                                       : out_oindex_1 == 8'h87
                                                                                           ? 64'hF140247330000067
                                                                                           : out_oindex_1 == 8'h88
                                                                                               ? 64'h7B20247310802423
                                                                                               : out_oindex_1 == 8'h89
                                                                                                   ? 64'h100026237B200073
                                                                                                   : out_oindex_1 == 8'h8A
                                                                                                       ? 64'h100073
                                                                                                       : 64'h0)
      : 64'h0;	// Cat.scala:30:58, Conditional.scala:37:30, :39:67, :40:58, Debug.scala:779:31, :809:30, :832:27, :833:35, :1195:36, :1199:34, :1379:27, :1405:61, :1409:80, :1470:35, Edges.scala:191:34, MuxLiteral.scala:53:32, RegisterRouter.scala:79:24
  assign auto_dmi_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_dmi_in_d_bits_data =
    (_out_out_bits_data_T_25
       ? auto_dmi_in_a_bits_address[8]
       : ~(auto_dmi_in_a_bits_address[7:2] == 6'h4
           | auto_dmi_in_a_bits_address[7:2] == 6'h5
           | auto_dmi_in_a_bits_address[7:2] == 6'h11
           | auto_dmi_in_a_bits_address[7:2] == 6'h13
           | auto_dmi_in_a_bits_address[7:2] == 6'h16
           | auto_dmi_in_a_bits_address[7:2] == 6'h17
           | auto_dmi_in_a_bits_address[7:2] == 6'h18
           | auto_dmi_in_a_bits_address[7:2] == 6'h20
           | auto_dmi_in_a_bits_address[7:2] == 6'h21
           | auto_dmi_in_a_bits_address[7:2] == 6'h22
           | auto_dmi_in_a_bits_address[7:2] == 6'h23
           | auto_dmi_in_a_bits_address[7:2] == 6'h24
           | auto_dmi_in_a_bits_address[7:2] == 6'h25
           | auto_dmi_in_a_bits_address[7:2] == 6'h26
           | auto_dmi_in_a_bits_address[7:2] == 6'h27
           | auto_dmi_in_a_bits_address[7:2] == 6'h28
           | auto_dmi_in_a_bits_address[7:2] == 6'h29
           | auto_dmi_in_a_bits_address[7:2] == 6'h2A
           | auto_dmi_in_a_bits_address[7:2] == 6'h2B
           | auto_dmi_in_a_bits_address[7:2] == 6'h2C
           | auto_dmi_in_a_bits_address[7:2] == 6'h2D
           | auto_dmi_in_a_bits_address[7:2] == 6'h2E
           | auto_dmi_in_a_bits_address[7:2] == 6'h2F
           | auto_dmi_in_a_bits_address[7:2] == 6'h32) | ~(auto_dmi_in_a_bits_address[8]))
      ? (_out_out_bits_data_T_25
           ? {26'h0, haltedBitRegs}
           : auto_dmi_in_a_bits_address[7:2] == 6'h4
               ? {abstractDataMem_3,
                  abstractDataMem_2,
                  abstractDataMem_1,
                  abstractDataMem_0}
               : auto_dmi_in_a_bits_address[7:2] == 6'h5
                   ? {abstractDataMem_7,
                      abstractDataMem_6,
                      abstractDataMem_5,
                      abstractDataMem_4}
                   : _GEN_8)
      : 32'h0;	// Cat.scala:30:58, Conditional.scala:37:30, :39:67, :40:58, Debug.scala:778:31, :1067:26, :1195:36, Edges.scala:191:34, MuxLiteral.scala:53:32, RegisterRouter.scala:79:24
  assign io_hgDebugInt_0 = hgParticipateHart_0 & hgFired_1 | hrDebugIntReg_0;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
  assign io_hgDebugInt_1 = hgParticipateHart_1 & hgFired_1 | hrDebugIntReg_1;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
  assign io_hgDebugInt_2 = hgParticipateHart_2 & hgFired_1 | hrDebugIntReg_2;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
  assign io_hgDebugInt_3 = hgParticipateHart_3 & hgFired_1 | hrDebugIntReg_3;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
  assign io_hgDebugInt_4 = hgParticipateHart_4 & hgFired_1 | hrDebugIntReg_4;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
  assign io_hgDebugInt_5 = hgParticipateHart_5 & hgFired_1 | hrDebugIntReg_5;	// Debug.scala:868:34, :942:38, :1011:38, :1046:31, package.scala:66:75
endmodule

