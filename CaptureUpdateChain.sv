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

module CaptureUpdateChain(
  input        clock,
               reset,
               io_chainIn_shift,
               io_chainIn_data,
               io_chainIn_capture,
               io_chainIn_update,
  input  [1:0] io_capture_bits_dmiStatus,
  output       io_chainOut_data,
               io_update_valid,
               io_update_bits_dmireset
);

  reg regs_0;	// JtagShifter.scala:155:39
  reg regs_1;	// JtagShifter.scala:155:39
  reg regs_2;	// JtagShifter.scala:155:39
  reg regs_3;	// JtagShifter.scala:155:39
  reg regs_4;	// JtagShifter.scala:155:39
  reg regs_5;	// JtagShifter.scala:155:39
  reg regs_6;	// JtagShifter.scala:155:39
  reg regs_7;	// JtagShifter.scala:155:39
  reg regs_8;	// JtagShifter.scala:155:39
  reg regs_9;	// JtagShifter.scala:155:39
  reg regs_10;	// JtagShifter.scala:155:39
  reg regs_11;	// JtagShifter.scala:155:39
  reg regs_12;	// JtagShifter.scala:155:39
  reg regs_13;	// JtagShifter.scala:155:39
  reg regs_14;	// JtagShifter.scala:155:39
  reg regs_15;	// JtagShifter.scala:155:39
  reg regs_16;	// JtagShifter.scala:155:39
  reg regs_17;	// JtagShifter.scala:155:39
  reg regs_18;	// JtagShifter.scala:155:39
  reg regs_19;	// JtagShifter.scala:155:39
  reg regs_20;	// JtagShifter.scala:155:39
  reg regs_21;	// JtagShifter.scala:155:39
  reg regs_22;	// JtagShifter.scala:155:39
  reg regs_23;	// JtagShifter.scala:155:39
  reg regs_24;	// JtagShifter.scala:155:39
  reg regs_25;	// JtagShifter.scala:155:39
  reg regs_26;	// JtagShifter.scala:155:39
  reg regs_27;	// JtagShifter.scala:155:39
  reg regs_28;	// JtagShifter.scala:155:39
  reg regs_29;	// JtagShifter.scala:155:39
  reg regs_30;	// JtagShifter.scala:155:39
  reg regs_31;	// JtagShifter.scala:155:39
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
    automatic logic _GEN;	// JtagShifter.scala:155:39, :172:35, :175:34
    _GEN = io_chainIn_update | ~io_chainIn_shift;	// JtagShifter.scala:155:39, :172:35, :175:34
    regs_0 <= io_chainIn_capture | (_GEN ? regs_0 : regs_1);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_1 <= ~io_chainIn_capture & (_GEN ? regs_1 : regs_2);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_2 <= ~io_chainIn_capture & (_GEN ? regs_2 : regs_3);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_3 <= ~io_chainIn_capture & (_GEN ? regs_3 : regs_4);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_4 <= io_chainIn_capture | (_GEN ? regs_4 : regs_5);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_5 <= io_chainIn_capture | (_GEN ? regs_5 : regs_6);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_6 <= io_chainIn_capture | (_GEN ? regs_6 : regs_7);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_7 <= ~io_chainIn_capture & (_GEN ? regs_7 : regs_8);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_8 <= ~io_chainIn_capture & (_GEN ? regs_8 : regs_9);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_9 <= ~io_chainIn_capture & (_GEN ? regs_9 : regs_10);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    if (io_chainIn_capture) begin
      regs_10 <= io_capture_bits_dmiStatus[0];	// JtagShifter.scala:155:39, :168:73
      regs_11 <= io_capture_bits_dmiStatus[1];	// JtagShifter.scala:155:39, :168:73
    end
    else if (_GEN) begin	// JtagShifter.scala:155:39, :172:35, :175:34
    end
    else begin	// JtagShifter.scala:155:39, :172:35, :175:34
      regs_10 <= regs_11;	// JtagShifter.scala:155:39
      regs_11 <= regs_12;	// JtagShifter.scala:155:39
    end
    regs_12 <= io_chainIn_capture | (_GEN ? regs_12 : regs_13);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_13 <= ~io_chainIn_capture & (_GEN ? regs_13 : regs_14);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_14 <= io_chainIn_capture | (_GEN ? regs_14 : regs_15);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_15 <= ~io_chainIn_capture & (_GEN ? regs_15 : regs_16);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_16 <= ~io_chainIn_capture & (_GEN ? regs_16 : regs_17);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_17 <= ~io_chainIn_capture & (_GEN ? regs_17 : regs_18);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_18 <= ~io_chainIn_capture & (_GEN ? regs_18 : regs_19);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_19 <= ~io_chainIn_capture & (_GEN ? regs_19 : regs_20);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_20 <= ~io_chainIn_capture & (_GEN ? regs_20 : regs_21);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_21 <= ~io_chainIn_capture & (_GEN ? regs_21 : regs_22);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_22 <= ~io_chainIn_capture & (_GEN ? regs_22 : regs_23);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_23 <= ~io_chainIn_capture & (_GEN ? regs_23 : regs_24);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_24 <= ~io_chainIn_capture & (_GEN ? regs_24 : regs_25);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_25 <= ~io_chainIn_capture & (_GEN ? regs_25 : regs_26);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_26 <= ~io_chainIn_capture & (_GEN ? regs_26 : regs_27);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_27 <= ~io_chainIn_capture & (_GEN ? regs_27 : regs_28);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_28 <= ~io_chainIn_capture & (_GEN ? regs_28 : regs_29);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_29 <= ~io_chainIn_capture & (_GEN ? regs_29 : regs_30);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_30 <= ~io_chainIn_capture & (_GEN ? regs_30 : regs_31);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
    regs_31 <= ~io_chainIn_capture & (_GEN ? regs_31 : io_chainIn_data);	// JtagShifter.scala:155:39, :167:29, :168:59, :172:35, :175:34
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
        regs_5 = _RANDOM[/*Zero width*/ 1'b0][5];	// JtagShifter.scala:155:39
        regs_6 = _RANDOM[/*Zero width*/ 1'b0][6];	// JtagShifter.scala:155:39
        regs_7 = _RANDOM[/*Zero width*/ 1'b0][7];	// JtagShifter.scala:155:39
        regs_8 = _RANDOM[/*Zero width*/ 1'b0][8];	// JtagShifter.scala:155:39
        regs_9 = _RANDOM[/*Zero width*/ 1'b0][9];	// JtagShifter.scala:155:39
        regs_10 = _RANDOM[/*Zero width*/ 1'b0][10];	// JtagShifter.scala:155:39
        regs_11 = _RANDOM[/*Zero width*/ 1'b0][11];	// JtagShifter.scala:155:39
        regs_12 = _RANDOM[/*Zero width*/ 1'b0][12];	// JtagShifter.scala:155:39
        regs_13 = _RANDOM[/*Zero width*/ 1'b0][13];	// JtagShifter.scala:155:39
        regs_14 = _RANDOM[/*Zero width*/ 1'b0][14];	// JtagShifter.scala:155:39
        regs_15 = _RANDOM[/*Zero width*/ 1'b0][15];	// JtagShifter.scala:155:39
        regs_16 = _RANDOM[/*Zero width*/ 1'b0][16];	// JtagShifter.scala:155:39
        regs_17 = _RANDOM[/*Zero width*/ 1'b0][17];	// JtagShifter.scala:155:39
        regs_18 = _RANDOM[/*Zero width*/ 1'b0][18];	// JtagShifter.scala:155:39
        regs_19 = _RANDOM[/*Zero width*/ 1'b0][19];	// JtagShifter.scala:155:39
        regs_20 = _RANDOM[/*Zero width*/ 1'b0][20];	// JtagShifter.scala:155:39
        regs_21 = _RANDOM[/*Zero width*/ 1'b0][21];	// JtagShifter.scala:155:39
        regs_22 = _RANDOM[/*Zero width*/ 1'b0][22];	// JtagShifter.scala:155:39
        regs_23 = _RANDOM[/*Zero width*/ 1'b0][23];	// JtagShifter.scala:155:39
        regs_24 = _RANDOM[/*Zero width*/ 1'b0][24];	// JtagShifter.scala:155:39
        regs_25 = _RANDOM[/*Zero width*/ 1'b0][25];	// JtagShifter.scala:155:39
        regs_26 = _RANDOM[/*Zero width*/ 1'b0][26];	// JtagShifter.scala:155:39
        regs_27 = _RANDOM[/*Zero width*/ 1'b0][27];	// JtagShifter.scala:155:39
        regs_28 = _RANDOM[/*Zero width*/ 1'b0][28];	// JtagShifter.scala:155:39
        regs_29 = _RANDOM[/*Zero width*/ 1'b0][29];	// JtagShifter.scala:155:39
        regs_30 = _RANDOM[/*Zero width*/ 1'b0][30];	// JtagShifter.scala:155:39
        regs_31 = _RANDOM[/*Zero width*/ 1'b0][31];	// JtagShifter.scala:155:39
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_chainOut_data = regs_0;	// JtagShifter.scala:155:39
  assign io_update_valid = ~io_chainIn_capture & io_chainIn_update;	// JtagShifter.scala:167:29, :168:59, :171:21, :172:35
  assign io_update_bits_dmireset = regs_16;	// JtagShifter.scala:155:39
endmodule

