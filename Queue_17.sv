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

module Queue_17(
  input         clock,
                reset,
                io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input  [7:0]  io_enq_bits_strb,
  input         io_enq_bits_last,
                io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_strb,
  output        io_deq_bits_last
);

  reg  [72:0] ram;	// Decoupled.scala:218:16
  reg         full;	// Decoupled.scala:221:27
  wire        _io_deq_valid_output = io_enq_valid | full;	// Decoupled.scala:221:27, :240:16, :245:{25,40}
  wire        do_enq = ~(~full & io_deq_ready) & ~full & io_enq_valid;	// Decoupled.scala:221:27, :224:28, :241:19, :246:18, :249:{27,36}
  always @(posedge clock) begin
    if (do_enq)	// Decoupled.scala:246:18, :249:{27,36}
      ram <= {io_enq_bits_last, io_enq_bits_strb, io_enq_bits_data};	// Decoupled.scala:218:16
    if (reset)
      full <= 1'h0;	// Decoupled.scala:218:16, :221:27
    else if (do_enq != (full & io_deq_ready & _io_deq_valid_output))	// Decoupled.scala:221:27, :236:16, :240:16, :245:{25,40}, :246:18, :248:14, :249:{27,36}
      full <= do_enq;	// Decoupled.scala:221:27, :246:18, :249:{27,36}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:2];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        ram = {_RANDOM[2'h0][31:1], _RANDOM[2'h1], _RANDOM[2'h2][9:0]};	// Decoupled.scala:218:16
        full = _RANDOM[2'h0][0];	// Decoupled.scala:218:16, :221:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~full;	// Decoupled.scala:221:27, :241:19
  assign io_deq_valid = _io_deq_valid_output;	// Decoupled.scala:240:16, :245:{25,40}
  assign io_deq_bits_data = full ? ram[63:0] : io_enq_bits_data;	// Decoupled.scala:218:16, :221:27, :242:15, :246:18, :247:19
  assign io_deq_bits_strb = full ? ram[71:64] : io_enq_bits_strb;	// Decoupled.scala:218:16, :221:27, :242:15, :246:18, :247:19
  assign io_deq_bits_last = full ? ram[72] : io_enq_bits_last;	// Decoupled.scala:218:16, :221:27, :242:15, :246:18, :247:19
endmodule

