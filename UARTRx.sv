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

module UARTRx(
  input         clock,
                reset,
                io_en,
                io_in,
  input  [15:0] io_div,
  output        io_out_valid,
  output [7:0]  io_out_bits
);

  reg [1:0]  debounce;	// UARTRx.scala:24:21
  reg [12:0] prescaler;	// UARTRx.scala:28:22
  reg [3:0]  data_count;	// UARTRx.scala:34:23
  reg [3:0]  sample_count;	// UARTRx.scala:37:25
  reg [2:0]  sample;	// UARTRx.scala:51:19
  reg [7:0]  shifter;	// UARTRx.scala:53:20
  reg        valid;	// UARTRx.scala:55:18
  reg        state;	// UARTRx.scala:61:18
  always @(posedge clock) begin
    automatic logic pulse;	// UARTRx.scala:30:26
    automatic logic data_last;	// UARTRx.scala:35:31
    automatic logic sample_mid;	// UARTRx.scala:38:34
    automatic logic _GEN;	// UARTRx.scala:61:18, :68:21, :70:29, :71:17
    automatic logic _GEN_0;	// Conditional.scala:39:67, UARTRx.scala:51:19, :82:20, :83:16
    automatic logic _GEN_1;	// Conditional.scala:39:67, UARTRx.scala:56:9, :82:20, :87:27, :102:30
    pulse = prescaler == 13'h0;	// UARTRx.scala:28:22, :30:26
    data_last = data_count == 4'h0;	// UARTRx.scala:34:23, :35:31
    sample_mid = sample_count == 4'h7;	// UARTRx.scala:37:25, :38:34
    _GEN = ~io_in & (&debounce);	// UARTRx.scala:24:21, :25:32, :61:18, :65:15, :68:21, :70:29, :71:17
    _GEN_0 = state & pulse;	// Conditional.scala:39:67, UARTRx.scala:30:26, :51:19, :61:18, :82:20, :83:16
    _GEN_1 = state & pulse & sample_mid;	// Conditional.scala:39:67, UARTRx.scala:30:26, :38:34, :56:9, :61:18, :82:20, :87:27, :102:30
    if (reset) begin
      debounce <= 2'h0;	// UARTRx.scala:24:21
      valid <= 1'h0;	// UARTRx.scala:55:18
      state <= 1'h0;	// UARTRx.scala:61:18
    end
    else begin
      if (io_en) begin
        if (state) begin	// UARTRx.scala:61:18
        end
        else if (io_in) begin
          if (io_in & (|debounce))	// UARTRx.scala:24:21, :26:32, :65:23
            debounce <= debounce - 2'h1;	// UARTRx.scala:24:21, :66:30
        end
        else
          debounce <= debounce + 2'h1;	// UARTRx.scala:24:21, :69:30
      end
      else
        debounce <= 2'h0;	// UARTRx.scala:24:21
      valid <= state & _GEN_1 & data_last;	// Conditional.scala:39:67, :40:58, UARTRx.scala:35:31, :55:18, :56:9, :61:18, :82:20, :87:27, :102:30
      if (state)	// UARTRx.scala:61:18
        state <= ~(state & pulse & sample_mid & data_last) & state;	// Conditional.scala:39:67, UARTRx.scala:30:26, :35:31, :38:34, :61:18, :82:20, :87:27, :102:30, :103:21
      else	// UARTRx.scala:61:18
        state <= _GEN | state;	// UARTRx.scala:61:18, :68:21, :70:29, :71:17
    end
    if (state | _GEN) begin	// Conditional.scala:39:67, :40:58, UARTRx.scala:61:18, :68:21, :70:29, :71:17
      automatic logic restore;	// UARTRx.scala:47:23
      restore = ~state & ~io_in & (&debounce) | pulse;	// Conditional.scala:37:30, :40:58, UARTRx.scala:24:21, :25:32, :30:26, :47:23, :61:18, :65:15, :68:21, :70:29
      prescaler <=
        (restore ? {1'h0, io_div[15:4]} : prescaler)
        - {12'h0, ~(restore & sample_count < io_div[3:0])};	// UARTRx.scala:26:32, :28:22, :36:32, :37:25, :45:25, :46:30, :47:23, :48:{25,42}, :49:{37,42,51}
    end
    if (state) begin	// UARTRx.scala:61:18
      if (_GEN_0) begin	// Conditional.scala:39:67, UARTRx.scala:51:19, :82:20, :83:16
        automatic logic [7:0] _countdown_T_1;	// UARTRx.scala:40:49
        _countdown_T_1 = {data_count, sample_count} - 8'h1;	// UARTRx.scala:34:23, :37:25, :40:49
        data_count <= _countdown_T_1[7:4];	// UARTRx.scala:34:23, :40:49, :84:33
        sample_count <= _countdown_T_1[3:0];	// UARTRx.scala:37:25, :40:49, :85:34
      end
    end
    else if (_GEN) begin	// UARTRx.scala:61:18, :68:21, :70:29, :71:17
      data_count <= 4'h9;	// UARTRx.scala:34:23, :74:94
      sample_count <= 4'hF;	// UARTRx.scala:37:25, :75:24
    end
    if (state & _GEN_0)	// Conditional.scala:39:67, :40:58, UARTRx.scala:51:19, :61:18, :82:20, :83:16
      sample <= {sample[1:0], io_in};	// UARTRx.scala:51:19, :83:16
    if (~state | ~_GEN_1 | data_last) begin	// Conditional.scala:39:67, :40:58, UARTRx.scala:35:31, :53:20, :56:9, :61:18, :82:20, :87:27, :102:30
    end
    else	// Conditional.scala:39:67, :40:58, UARTRx.scala:53:20
      shifter <=
        {sample[0] & sample[1] | sample[0] & sample[2] | sample[1] & sample[2],
         shifter[7:1]};	// Cat.scala:30:58, Misc.scala:166:48, :167:22, UARTRx.scala:51:19, :52:31, :53:20, :106:45
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
        debounce = _RANDOM[1'h0][1:0];	// UARTRx.scala:24:21
        prescaler = _RANDOM[1'h0][14:2];	// UARTRx.scala:24:21, :28:22
        data_count = _RANDOM[1'h0][18:15];	// UARTRx.scala:24:21, :34:23
        sample_count = _RANDOM[1'h0][22:19];	// UARTRx.scala:24:21, :37:25
        sample = _RANDOM[1'h0][25:23];	// UARTRx.scala:24:21, :51:19
        shifter = {_RANDOM[1'h0][31:26], _RANDOM[1'h1][1:0]};	// UARTRx.scala:24:21, :53:20
        valid = _RANDOM[1'h1][2];	// UARTRx.scala:53:20, :55:18
        state = _RANDOM[1'h1][3];	// UARTRx.scala:53:20, :61:18
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_out_valid = valid;	// UARTRx.scala:55:18
  assign io_out_bits = shifter;	// UARTRx.scala:53:20
endmodule

