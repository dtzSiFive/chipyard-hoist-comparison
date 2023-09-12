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

module QueueCompatibility_20(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
                io_enq_bits_param,
                io_enq_bits_source,
  input  [31:0] io_enq_bits_address,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
                io_deq_bits_param,
                io_deq_bits_size,
                io_deq_bits_source,
  output [31:0] io_deq_bits_address,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_corrupt,
  output [3:0]  io_count
);

  wire [108:0] _ram_ext_R0_data;	// Decoupled.scala:218:16
  reg  [3:0]   enq_ptr_value;	// Counter.scala:60:40
  reg  [3:0]   deq_ptr_value;	// Counter.scala:60:40
  reg          maybe_full;	// Decoupled.scala:221:27
  wire         ptr_match = enq_ptr_value == deq_ptr_value;	// Counter.scala:60:40, Decoupled.scala:223:33
  wire         empty = ptr_match & ~maybe_full;	// Decoupled.scala:221:27, :223:33, :224:{25,28}
  wire         full = ptr_match & maybe_full;	// Decoupled.scala:221:27, :223:33, :225:24
  wire         do_enq = ~full & io_enq_valid;	// Decoupled.scala:40:37, :225:24, :241:19
  wire [3:0]   _ptr_diff_T = enq_ptr_value - deq_ptr_value;	// Counter.scala:60:40, Decoupled.scala:257:32
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 4'h0;	// Counter.scala:60:40
      deq_ptr_value <= 4'h0;	// Counter.scala:60:40
      maybe_full <= 1'h0;	// Decoupled.scala:221:27
    end
    else begin
      automatic logic do_deq = io_deq_ready & ~empty;	// Decoupled.scala:40:37, :224:25, :240:19
      if (do_enq) begin	// Decoupled.scala:40:37
        if (enq_ptr_value == 4'hB)	// Counter.scala:60:40, :72:24
          enq_ptr_value <= 4'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          enq_ptr_value <= enq_ptr_value + 4'h1;	// Counter.scala:60:40, :76:24
      end
      if (do_deq) begin	// Decoupled.scala:40:37
        if (deq_ptr_value == 4'hB)	// Counter.scala:60:40, :72:24
          deq_ptr_value <= 4'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          deq_ptr_value <= deq_ptr_value + 4'h1;	// Counter.scala:60:40, :76:24
      end
      if (do_enq != do_deq)	// Decoupled.scala:40:37, :236:16
        maybe_full <= do_enq;	// Decoupled.scala:40:37, :221:27
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
        enq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][3:0];	// Counter.scala:60:40
        deq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][7:4];	// Counter.scala:60:40
        maybe_full = _RANDOM[/*Zero width*/ 1'b0][8];	// Counter.scala:60:40, Decoupled.scala:221:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_12x109 ram_ext (	// Decoupled.scala:218:16
    .R0_addr (deq_ptr_value),	// Counter.scala:60:40
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),	// Counter.scala:60:40
    .W0_en   (do_enq),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data
      ({1'h0,
        io_enq_bits_data,
        io_enq_bits_address,
        io_enq_bits_source,
        3'h6,
        io_enq_bits_param,
        io_enq_bits_opcode}),	// Decoupled.scala:218:16
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = ~full;	// Decoupled.scala:225:24, :241:19
  assign io_deq_valid = ~empty;	// Decoupled.scala:224:25, :240:19
  assign io_deq_bits_opcode = _ram_ext_R0_data[2:0];	// Decoupled.scala:218:16
  assign io_deq_bits_param = _ram_ext_R0_data[5:3];	// Decoupled.scala:218:16
  assign io_deq_bits_size = _ram_ext_R0_data[8:6];	// Decoupled.scala:218:16
  assign io_deq_bits_source = _ram_ext_R0_data[11:9];	// Decoupled.scala:218:16
  assign io_deq_bits_address = _ram_ext_R0_data[43:12];	// Decoupled.scala:218:16
  assign io_deq_bits_data = _ram_ext_R0_data[107:44];	// Decoupled.scala:218:16
  assign io_deq_bits_corrupt = _ram_ext_R0_data[108];	// Decoupled.scala:218:16
  assign io_count =
    ptr_match
      ? (maybe_full ? 4'hC : 4'h0)
      : deq_ptr_value > enq_ptr_value ? _ptr_diff_T - 4'h4 : _ptr_diff_T;	// Counter.scala:60:40, Decoupled.scala:221:27, :223:33, :257:32, :261:20, :262:24, :264:{24,39}, :265:38
endmodule

