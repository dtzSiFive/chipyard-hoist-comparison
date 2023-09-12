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

module AsyncQueueSink(
  input         clock,
                reset,
                io_deq_ready,
  input  [2:0]  io_async_mem_0_opcode,
  input  [1:0]  io_async_mem_0_param,
                io_async_mem_0_size,
  input         io_async_mem_0_source,
                io_async_mem_0_sink,
                io_async_mem_0_denied,
  input  [31:0] io_async_mem_0_data,
  input         io_async_mem_0_corrupt,
                io_async_widx,
                io_async_safe_widx_valid,
                io_async_safe_source_reset_n,
  output        io_deq_valid,
  output [2:0]  io_deq_bits_opcode,
  output [1:0]  io_deq_bits_param,
                io_deq_bits_size,
  output        io_deq_bits_source,
                io_deq_bits_sink,
                io_deq_bits_denied,
  output [31:0] io_deq_bits_data,
  output        io_deq_bits_corrupt,
                io_async_ridx,
                io_async_safe_ridx_valid,
                io_async_safe_sink_reset_n
);

  wire        _io_deq_valid_output;	// AsyncQueue.scala:162:29
  wire        _source_valid_io_out;	// AsyncQueue.scala:172:31
  wire        _source_extend_io_out;	// AsyncQueue.scala:171:31
  wire        _sink_valid_0_io_out;	// AsyncQueue.scala:168:33
  wire [42:0] _io_deq_bits_deq_bits_reg_io_q;	// SynchronizerReg.scala:207:25
  wire        _widx_widx_gray_io_q;	// ShiftReg.scala:45:23
  reg         ridx_ridx_bin;	// AsyncQueue.scala:52:25
  wire        ridx =
    _source_valid_io_out & ridx_ridx_bin + (io_deq_ready & _io_deq_valid_output);	// AsyncQueue.scala:52:25, :53:{23,43}, :162:29, :172:31, Decoupled.scala:40:37
  wire        valid = _source_valid_io_out & ridx != _widx_widx_gray_io_q;	// AsyncQueue.scala:53:23, :146:{28,36}, :172:31, ShiftReg.scala:45:23
  reg         valid_reg;	// AsyncQueue.scala:161:56
  assign _io_deq_valid_output = valid_reg & _source_valid_io_out;	// AsyncQueue.scala:161:56, :162:29, :172:31
  reg         ridx_gray;	// AsyncQueue.scala:164:55
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ridx_ridx_bin <= 1'h0;	// AsyncQueue.scala:52:25
      valid_reg <= 1'h0;	// AsyncQueue.scala:161:56
      ridx_gray <= 1'h0;	// AsyncQueue.scala:164:55
    end
    else begin
      ridx_ridx_bin <= ridx;	// AsyncQueue.scala:52:25, :53:23
      valid_reg <= valid;	// AsyncQueue.scala:146:28, :161:56
      ridx_gray <= ridx;	// AsyncQueue.scala:53:23, :164:55
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
        ridx_ridx_bin = _RANDOM[/*Zero width*/ 1'b0][0];	// AsyncQueue.scala:52:25
        valid_reg = _RANDOM[/*Zero width*/ 1'b0][1];	// AsyncQueue.scala:52:25, :161:56
        ridx_gray = _RANDOM[/*Zero width*/ 1'b0][2];	// AsyncQueue.scala:52:25, :164:55
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        ridx_ridx_bin = 1'h0;	// AsyncQueue.scala:52:25
        valid_reg = 1'h0;	// AsyncQueue.scala:161:56
        ridx_gray = 1'h0;	// AsyncQueue.scala:164:55
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w1_d3_i0 widx_widx_gray (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_widx),
    .io_q  (_widx_widx_gray_io_q)
  );
  ClockCrossingReg_w43 io_deq_bits_deq_bits_reg (	// SynchronizerReg.scala:207:25
    .clock (clock),
    .io_d
      ({io_async_mem_0_opcode,
        io_async_mem_0_param,
        io_async_mem_0_size,
        io_async_mem_0_source,
        io_async_mem_0_sink,
        io_async_mem_0_denied,
        io_async_mem_0_data,
        io_async_mem_0_corrupt}),	// SynchronizerReg.scala:209:24
    .io_en (valid),	// AsyncQueue.scala:146:28
    .io_q  (_io_deq_bits_deq_bits_reg_io_q)
  );
  AsyncValidSync sink_valid_0 (	// AsyncQueue.scala:168:33
    .io_in  (1'h1),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),	// AsyncQueue.scala:173:{42,45}
    .io_out (_sink_valid_0_io_out)
  );
  AsyncValidSync sink_valid_1 (	// AsyncQueue.scala:169:33
    .io_in  (_sink_valid_0_io_out),	// AsyncQueue.scala:168:33
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),	// AsyncQueue.scala:173:45, :174:42
    .io_out (io_async_safe_ridx_valid)
  );
  AsyncValidSync source_extend (	// AsyncQueue.scala:171:31
    .io_in  (io_async_safe_widx_valid),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n),	// AsyncQueue.scala:173:45, :175:42
    .io_out (_source_extend_io_out)
  );
  AsyncValidSync source_valid (	// AsyncQueue.scala:172:31
    .io_in  (_source_extend_io_out),	// AsyncQueue.scala:171:31
    .clock  (clock),
    .reset  (reset),
    .io_out (_source_valid_io_out)
  );
  assign io_deq_valid = _io_deq_valid_output;	// AsyncQueue.scala:162:29
  assign io_deq_bits_opcode = _io_deq_bits_deq_bits_reg_io_q[42:40];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_param = _io_deq_bits_deq_bits_reg_io_q[39:38];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_size = _io_deq_bits_deq_bits_reg_io_q[37:36];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_source = _io_deq_bits_deq_bits_reg_io_q[35];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_sink = _io_deq_bits_deq_bits_reg_io_q[34];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_denied = _io_deq_bits_deq_bits_reg_io_q[33];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_data = _io_deq_bits_deq_bits_reg_io_q[32:1];	// SynchronizerReg.scala:207:25, :211:26
  assign io_deq_bits_corrupt = _io_deq_bits_deq_bits_reg_io_q[0];	// SynchronizerReg.scala:207:25, :211:26
  assign io_async_ridx = ridx_gray;	// AsyncQueue.scala:164:55
  assign io_async_safe_sink_reset_n = ~reset;	// AsyncQueue.scala:189:25
endmodule
