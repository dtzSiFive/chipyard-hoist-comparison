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

module UARTTx(
  input         clock,
                reset,
                io_en,
                io_in_valid,
  input  [7:0]  io_in_bits,
  input  [15:0] io_div,
  input         io_nstop,
  output        io_in_ready,
                io_out
);

  wire [31:0] _plusarg_reader_out;	// PlusArg.scala:80:11
  reg  [15:0] prescaler;	// UARTTx.scala:23:22
  reg  [3:0]  counter;	// UARTTx.scala:27:20
  reg  [8:0]  shifter;	// UARTTx.scala:28:20
  reg         out;	// UARTTx.scala:29:16
  wire        _io_in_ready_output = io_en & ~(|counter);	// UARTTx.scala:27:20, :34:23, :35:{24,27}
  wire        _GEN = _io_in_ready_output & io_in_valid;	// Decoupled.scala:40:37, UARTTx.scala:35:24
  `ifndef SYNTHESIS	// UARTTx.scala:38:11
    always @(posedge clock) begin	// UARTTx.scala:38:11
      if ((`PRINTF_COND_) & _GEN & ~reset)	// Decoupled.scala:40:37, UARTTx.scala:38:11
        $fwrite(32'h80000002, "UART TX (%x): %c\n", io_in_bits, io_in_bits);	// UARTTx.scala:38:11
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic pulse;	// UARTTx.scala:24:26
    automatic logic _GEN_0;	// UARTTx.scala:40:22
    automatic logic _GEN_1;	// UARTTx.scala:63:15
    pulse = prescaler == 16'h0;	// UARTTx.scala:23:22, :24:26
    _GEN_0 = _GEN & (|_plusarg_reader_out);	// Decoupled.scala:40:37, PlusArg.scala:80:11, UARTTx.scala:32:90, :40:22
    _GEN_1 = pulse & (|counter);	// UARTTx.scala:24:26, :27:20, :34:23, :63:15
    if (reset) begin
      prescaler <= 16'h0;	// UARTTx.scala:23:22
      counter <= 4'h0;	// UARTTx.scala:27:20
      out <= 1'h1;	// UARTTx.scala:29:16
    end
    else begin
      if (|counter) begin	// UARTTx.scala:27:20, :34:23
        if (pulse)	// UARTTx.scala:24:26
          prescaler <= io_div;	// UARTTx.scala:23:22
        else	// UARTTx.scala:24:26
          prescaler <= prescaler - 16'h1;	// UARTTx.scala:23:22, :61:78
      end
      if (_GEN_1) begin	// UARTTx.scala:63:15
        counter <= counter - 4'h1;	// UARTTx.scala:27:20, :64:24
        out <= shifter[0];	// UARTTx.scala:28:20, :29:16, :66:19
      end
      else if (_GEN_0)	// UARTTx.scala:40:22
        counter <= (io_nstop ? 4'h0 : 4'hA) | (io_nstop ? 4'hB : 4'h0);	// Mux.scala:27:72, UARTTx.scala:27:20
    end
    if (_GEN_1)	// UARTTx.scala:63:15
      shifter <= {1'h1, shifter[8:1]};	// Cat.scala:30:58, UARTTx.scala:28:20, :65:40
    else if (_GEN_0)	// UARTTx.scala:40:22
      shifter <= {io_in_bits, 1'h0};	// UARTTx.scala:28:20, :55:15
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
        prescaler = _RANDOM[/*Zero width*/ 1'b0][15:0];	// UARTTx.scala:23:22
        counter = _RANDOM[/*Zero width*/ 1'b0][19:16];	// UARTTx.scala:23:22, :27:20
        shifter = _RANDOM[/*Zero width*/ 1'b0][28:20];	// UARTTx.scala:23:22, :28:20
        out = _RANDOM[/*Zero width*/ 1'b0][29];	// UARTTx.scala:23:22, :29:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  plusarg_reader #(
    .FORMAT("uart_tx=%d"),
    .DEFAULT(1),
    .WIDTH(32)
  ) plusarg_reader (	// PlusArg.scala:80:11
    .out (_plusarg_reader_out)
  );
  assign io_in_ready = _io_in_ready_output;	// UARTTx.scala:35:24
  assign io_out = out;	// UARTTx.scala:29:16
endmodule

