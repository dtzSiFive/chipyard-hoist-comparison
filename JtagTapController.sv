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

module JtagTapController(
  input        clock,
               reset,
               io_jtag_TMS,
               io_jtag_TDI,
               io_control_jtag_reset,
               io_dataChainIn_data,
  output       io_jtag_TDO_data,
  output [4:0] io_output_instruction,
  output       io_output_tapIsInTestLogicReset,
               io_dataChainOut_shift,
               io_dataChainOut_data,
               io_dataChainOut_capture,
               io_dataChainOut_update
);

  wire       _irChain_io_chainOut_data;	// JtagTap.scala:106:23
  wire [4:0] _irChain_io_update_bits;	// JtagTap.scala:106:23
  wire [3:0] _stateMachine_io_currState;	// JtagTap.scala:86:30
  wire       _clock_falling_T_1 = ~clock;	// JtagTap.scala:71:33
  reg        tdoReg;	// JtagTap.scala:93:30
  wire       _irChain_io_chainIn_update_T = _stateMachine_io_currState == 4'hD;	// JtagTap.scala:86:30, :111:42
  reg  [4:0] activeInstruction;	// JtagTap.scala:115:36
  wire       _io_dataChainOut_shift_T = _stateMachine_io_currState == 4'h2;	// JtagTap.scala:86:30, :130:38
  always @(posedge _clock_falling_T_1 or posedge io_control_jtag_reset) begin	// JtagTap.scala:71:{33,48}
    if (io_control_jtag_reset) begin	// JtagTap.scala:71:48
      tdoReg <= 1'h0;	// JtagTap.scala:93:30
      activeInstruction <= 5'h1;	// JtagTap.scala:115:36
    end
    else begin	// JtagTap.scala:71:48
      if (_io_dataChainOut_shift_T)	// JtagTap.scala:130:38
        tdoReg <= io_dataChainIn_data;	// JtagTap.scala:93:30
      else	// JtagTap.scala:130:38
        tdoReg <= _irChain_io_chainOut_data;	// JtagTap.scala:93:30, :106:23
      if (&_stateMachine_io_currState)	// JtagTap.scala:86:30, :124:38
        activeInstruction <= 5'h1;	// JtagTap.scala:115:36
      else if (_irChain_io_chainIn_update_T)	// JtagTap.scala:111:42
        activeInstruction <= _irChain_io_update_bits;	// JtagTap.scala:106:23, :115:36
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        tdoReg = _RANDOM[/*Zero width*/ 1'b0][0];	// JtagTap.scala:93:30
        activeInstruction = _RANDOM[/*Zero width*/ 1'b0][6:2];	// JtagTap.scala:93:30, :115:36
      `endif // RANDOMIZE_REG_INIT
      if (io_control_jtag_reset) begin
        tdoReg = 1'h0;	// JtagTap.scala:93:30
        activeInstruction = 5'h1;	// JtagTap.scala:115:36
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  JtagStateMachine stateMachine (	// JtagTap.scala:86:30
    .clock        (clock),
    .reset        (io_control_jtag_reset),
    .io_tms       (io_jtag_TMS),
    .io_currState (_stateMachine_io_currState)
  );
  CaptureUpdateChain_2 irChain (	// JtagTap.scala:106:23
    .clock              (clock),
    .reset              (reset),
    .io_chainIn_shift   (_stateMachine_io_currState == 4'hA),	// JtagTap.scala:86:30, :108:41
    .io_chainIn_data    (io_jtag_TDI),
    .io_chainIn_capture (_stateMachine_io_currState == 4'hE),	// JtagTap.scala:86:30, :110:43
    .io_chainIn_update  (_irChain_io_chainIn_update_T),	// JtagTap.scala:111:42
    .io_chainOut_data   (_irChain_io_chainOut_data),
    .io_update_bits     (_irChain_io_update_bits)
  );
  assign io_jtag_TDO_data = tdoReg;	// JtagTap.scala:93:30
  assign io_output_instruction = activeInstruction;	// JtagTap.scala:115:36
  assign io_output_tapIsInTestLogicReset = &_stateMachine_io_currState;	// JtagTap.scala:86:30, :124:38
  assign io_dataChainOut_shift = _io_dataChainOut_shift_T;	// JtagTap.scala:130:38
  assign io_dataChainOut_data = io_jtag_TDI;
  assign io_dataChainOut_capture = _stateMachine_io_currState == 4'h6;	// JtagTap.scala:86:30, :132:40
  assign io_dataChainOut_update = _stateMachine_io_currState == 4'h5;	// JtagTap.scala:86:30, :133:39
endmodule

