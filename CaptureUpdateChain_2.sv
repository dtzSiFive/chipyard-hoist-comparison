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

module CaptureUpdateChain_2(
  input        clock,
               reset,
               io_chainIn_shift,
               io_chainIn_data,
               io_chainIn_capture,
               io_chainIn_update,
  output       io_chainOut_data,
  output [4:0] io_update_bits
);

  reg regs_0;	// JtagShifter.scala:155:39
  reg regs_1;	// JtagShifter.scala:155:39
  reg regs_2;	// JtagShifter.scala:155:39
  reg regs_3;	// JtagShifter.scala:155:39
  reg regs_4;	// JtagShifter.scala:155:39
  `ifndef SYNTHESIS	// JtagShifter.scala:184:9
    always @(posedge clock) begin	// JtagShifter.scala:184:9
      if (~(~(io_chainIn_capture & io_chainIn_update)
            & ~(io_chainIn_capture & io_chainIn_shift)
            & ~(io_chainIn_update & io_chainIn_shift) | reset)) begin	// JtagShifter.scala:184:{9,10,31}, :185:{10,31}, :186:{7,10,30}
        if (`ASSERT_VERBOSE_COND_)	// JtagShifter.scala:184:9
          $error("Assertion failed\n    at JtagShifter.scala:184 assert(!(io.chainIn.capture && io.chainIn.update)\n");	// JtagShifter.scala:184:9
        if (`STOP_COND_)	// JtagShifter.scala:184:9
          $fatal;	// JtagShifter.scala:184:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (io_chainIn_capture) begin
      regs_0 <= 1'h1;	// JtagShifter.scala:155:39
      regs_1 <= 1'h0;	// JtagShifter.scala:155:39
      regs_2 <= 1'h0;	// JtagShifter.scala:155:39
      regs_3 <= 1'h0;	// JtagShifter.scala:155:39
      regs_4 <= 1'h0;	// JtagShifter.scala:155:39
    end
    else if (io_chainIn_update | ~io_chainIn_shift) begin	// JtagShifter.scala:155:39, :172:35, :175:34
    end
    else begin	// JtagShifter.scala:155:39, :172:35, :175:34
      regs_0 <= regs_1;	// JtagShifter.scala:155:39
      regs_1 <= regs_2;	// JtagShifter.scala:155:39
      regs_2 <= regs_3;	// JtagShifter.scala:155:39
      regs_3 <= regs_4;	// JtagShifter.scala:155:39
      regs_4 <= io_chainIn_data;	// JtagShifter.scala:155:39
    end
  end // always @(posedge)
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
        regs_0 = _RANDOM[/*Zero width*/ 1'b0][0];	// JtagShifter.scala:155:39
        regs_1 = _RANDOM[/*Zero width*/ 1'b0][1];	// JtagShifter.scala:155:39
        regs_2 = _RANDOM[/*Zero width*/ 1'b0][2];	// JtagShifter.scala:155:39
        regs_3 = _RANDOM[/*Zero width*/ 1'b0][3];	// JtagShifter.scala:155:39
        regs_4 = _RANDOM[/*Zero width*/ 1'b0][4];	// JtagShifter.scala:155:39
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_chainOut_data = regs_0;	// JtagShifter.scala:155:39
  assign io_update_bits = {regs_4, regs_3, regs_2, regs_1, regs_0};	// Cat.scala:30:58, JtagShifter.scala:155:39
endmodule

