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

module GenericSerializer(
  input         clock,
                reset,
                io_in_valid,
  input  [2:0]  io_in_bits_chanId,
                io_in_bits_opcode,
                io_in_bits_param,
  input  [3:0]  io_in_bits_size,
                io_in_bits_source,
  input  [31:0] io_in_bits_address,
  input  [63:0] io_in_bits_data,
  input         io_in_bits_corrupt,
  input  [7:0]  io_in_bits_union,
  input         io_in_bits_last,
                io_out_ready,
  output        io_in_ready,
                io_out_valid,
  output [3:0]  io_out_bits
);

  reg [122:0] data;	// Serdes.scala:175:17
  reg         sending;	// Serdes.scala:177:24
  reg [4:0]   sendCount;	// Counter.scala:60:40
  always @(posedge clock) begin
    automatic logic _GEN;	// Decoupled.scala:40:37
    automatic logic _GEN_0;	// Decoupled.scala:40:37
    _GEN = io_out_ready & sending;	// Decoupled.scala:40:37, Serdes.scala:177:24
    _GEN_0 = ~sending & io_in_valid;	// Decoupled.scala:40:37, Serdes.scala:177:24, :180:18
    if (_GEN)	// Decoupled.scala:40:37
      data <= {4'h0, data[122:4]};	// Serdes.scala:175:17, :189:39
    else if (_GEN_0)	// Decoupled.scala:40:37
      data <=
        {io_in_bits_chanId,
         io_in_bits_opcode,
         io_in_bits_param,
         io_in_bits_size,
         io_in_bits_source,
         io_in_bits_address,
         io_in_bits_data,
         io_in_bits_corrupt,
         io_in_bits_union,
         io_in_bits_last};	// Serdes.scala:175:17, :185:24
    if (reset) begin
      sending <= 1'h0;	// Serdes.scala:175:17, :177:24
      sendCount <= 5'h0;	// Counter.scala:60:40
    end
    else begin
      automatic logic wrap_wrap;	// Counter.scala:72:24
      wrap_wrap = sendCount == 5'h1E;	// Counter.scala:60:40, :72:24
      sending <= ~(_GEN & wrap_wrap) & (_GEN_0 | sending);	// Counter.scala:72:24, :118:{17,24}, Decoupled.scala:40:37, Serdes.scala:177:24, :184:23, :186:13, :191:{19,29}
      if (_GEN) begin	// Decoupled.scala:40:37
        if (wrap_wrap)	// Counter.scala:72:24
          sendCount <= 5'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          sendCount <= sendCount + 5'h1;	// Counter.scala:60:40, :76:24
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:4];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        data = {_RANDOM[3'h0], _RANDOM[3'h1], _RANDOM[3'h2], _RANDOM[3'h3][26:0]};	// Serdes.scala:175:17
        sending = _RANDOM[3'h3][27];	// Serdes.scala:175:17, :177:24
        sendCount = {_RANDOM[3'h3][31:28], _RANDOM[3'h4][0]};	// Counter.scala:60:40, Serdes.scala:175:17
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_ready = ~sending;	// Serdes.scala:177:24, :180:18
  assign io_out_valid = sending;	// Serdes.scala:177:24
  assign io_out_bits = data[3:0];	// Serdes.scala:175:17, :182:22
endmodule

