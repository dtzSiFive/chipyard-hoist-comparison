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

module AsyncQueueSource_2(
  input         clock,
                reset,
                io_enq_valid,
  input  [2:0]  io_enq_bits_opcode,
  input  [1:0]  io_enq_bits_size,
  input         io_enq_bits_source,
  input  [31:0] io_enq_bits_data,
  input         io_async_ridx,
                io_async_safe_ridx_valid,
                io_async_safe_sink_reset_n,
  output        io_enq_ready,
  output [2:0]  io_async_mem_0_opcode,
  output [1:0]  io_async_mem_0_param,
                io_async_mem_0_size,
  output        io_async_mem_0_source,
                io_async_mem_0_sink,
                io_async_mem_0_denied,
  output [31:0] io_async_mem_0_data,
  output        io_async_mem_0_corrupt,
                io_async_widx,
                io_async_safe_widx_valid,
                io_async_safe_source_reset_n
);

  wire        _io_enq_ready_output;	// AsyncQueue.scala:89:29
  wire        _sink_valid_io_out;	// AsyncQueue.scala:104:30
  wire        _sink_extend_io_out;	// AsyncQueue.scala:103:30
  wire        _source_valid_0_io_out;	// AsyncQueue.scala:100:32
  wire        _ridx_ridx_gray_io_q;	// ShiftReg.scala:45:23
  reg  [2:0]  mem_0_opcode;	// AsyncQueue.scala:80:16
  reg  [1:0]  mem_0_param;	// AsyncQueue.scala:80:16
  reg  [1:0]  mem_0_size;	// AsyncQueue.scala:80:16
  reg         mem_0_source;	// AsyncQueue.scala:80:16
  reg         mem_0_sink;	// AsyncQueue.scala:80:16
  reg         mem_0_denied;	// AsyncQueue.scala:80:16
  reg  [31:0] mem_0_data;	// AsyncQueue.scala:80:16
  reg         mem_0_corrupt;	// AsyncQueue.scala:80:16
  wire        _widx_T_1 = _io_enq_ready_output & io_enq_valid;	// AsyncQueue.scala:89:29, Decoupled.scala:40:37
  reg         widx_widx_bin;	// AsyncQueue.scala:52:25
  reg         ready_reg;	// AsyncQueue.scala:88:56
  assign _io_enq_ready_output = ready_reg & _sink_valid_io_out;	// AsyncQueue.scala:88:56, :89:29, :104:30
  reg         widx_gray;	// AsyncQueue.scala:91:55
  always @(posedge clock) begin
    if (_widx_T_1) begin	// Decoupled.scala:40:37
      mem_0_opcode <= io_enq_bits_opcode;	// AsyncQueue.scala:80:16
      mem_0_param <= 2'h0;	// AsyncQueue.scala:80:16
      mem_0_size <= io_enq_bits_size;	// AsyncQueue.scala:80:16
      mem_0_source <= io_enq_bits_source;	// AsyncQueue.scala:80:16
      mem_0_data <= io_enq_bits_data;	// AsyncQueue.scala:80:16
    end
    mem_0_sink <= ~_widx_T_1 & mem_0_sink;	// AsyncQueue.scala:80:16, :86:{24,37}, Decoupled.scala:40:37
    mem_0_denied <= ~_widx_T_1 & mem_0_denied;	// AsyncQueue.scala:80:16, :86:{24,37}, Decoupled.scala:40:37
    mem_0_corrupt <= ~_widx_T_1 & mem_0_corrupt;	// AsyncQueue.scala:80:16, :86:{24,37}, Decoupled.scala:40:37
  end // always @(posedge)
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      widx_widx_bin <= 1'h0;	// AsyncQueue.scala:52:25
      ready_reg <= 1'h0;	// AsyncQueue.scala:88:56
      widx_gray <= 1'h0;	// AsyncQueue.scala:91:55
    end
    else begin
      automatic logic widx;	// AsyncQueue.scala:53:23
      widx = _sink_valid_io_out & widx_widx_bin + _widx_T_1;	// AsyncQueue.scala:52:25, :53:{23,43}, :104:30, Decoupled.scala:40:37
      widx_widx_bin <= widx;	// AsyncQueue.scala:52:25, :53:23
      ready_reg <= _sink_valid_io_out & widx != ~_ridx_ridx_gray_io_q;	// AsyncQueue.scala:53:23, :83:{26,34,44}, :88:56, :104:30, ShiftReg.scala:45:23
      widx_gray <= widx;	// AsyncQueue.scala:53:23, :91:55
    end
  end // always @(posedge, posedge)
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
        mem_0_opcode = _RANDOM[1'h0][2:0];	// AsyncQueue.scala:80:16
        mem_0_param = _RANDOM[1'h0][4:3];	// AsyncQueue.scala:80:16
        mem_0_size = _RANDOM[1'h0][6:5];	// AsyncQueue.scala:80:16
        mem_0_source = _RANDOM[1'h0][7];	// AsyncQueue.scala:80:16
        mem_0_sink = _RANDOM[1'h0][8];	// AsyncQueue.scala:80:16
        mem_0_denied = _RANDOM[1'h0][9];	// AsyncQueue.scala:80:16
        mem_0_data = {_RANDOM[1'h0][31:10], _RANDOM[1'h1][9:0]};	// AsyncQueue.scala:80:16
        mem_0_corrupt = _RANDOM[1'h1][10];	// AsyncQueue.scala:80:16
        widx_widx_bin = _RANDOM[1'h1][11];	// AsyncQueue.scala:52:25, :80:16
        ready_reg = _RANDOM[1'h1][12];	// AsyncQueue.scala:80:16, :88:56
        widx_gray = _RANDOM[1'h1][13];	// AsyncQueue.scala:80:16, :91:55
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        widx_widx_bin = 1'h0;	// AsyncQueue.scala:52:25
        ready_reg = 1'h0;	// AsyncQueue.scala:88:56
        widx_gray = 1'h0;	// AsyncQueue.scala:91:55
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w1_d3_i0 ridx_ridx_gray (	// ShiftReg.scala:45:23
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_ridx),
    .io_q  (_ridx_ridx_gray_io_q)
  );
  AsyncValidSync source_valid_0 (	// AsyncQueue.scala:100:32
    .io_in  (1'h1),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),	// AsyncQueue.scala:105:{43,46}
    .io_out (_source_valid_0_io_out)
  );
  AsyncValidSync source_valid_1 (	// AsyncQueue.scala:101:32
    .io_in  (_source_valid_0_io_out),	// AsyncQueue.scala:100:32
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),	// AsyncQueue.scala:105:46, :106:43
    .io_out (io_async_safe_widx_valid)
  );
  AsyncValidSync sink_extend (	// AsyncQueue.scala:103:30
    .io_in  (io_async_safe_ridx_valid),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_sink_reset_n),	// AsyncQueue.scala:105:46, :107:43
    .io_out (_sink_extend_io_out)
  );
  AsyncValidSync sink_valid (	// AsyncQueue.scala:104:30
    .io_in  (_sink_extend_io_out),	// AsyncQueue.scala:103:30
    .clock  (clock),
    .reset  (reset),
    .io_out (_sink_valid_io_out)
  );
  assign io_enq_ready = _io_enq_ready_output;	// AsyncQueue.scala:89:29
  assign io_async_mem_0_opcode = mem_0_opcode;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_param = mem_0_param;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_size = mem_0_size;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_source = mem_0_source;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_sink = mem_0_sink;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_denied = mem_0_denied;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_data = mem_0_data;	// AsyncQueue.scala:80:16
  assign io_async_mem_0_corrupt = mem_0_corrupt;	// AsyncQueue.scala:80:16
  assign io_async_widx = widx_gray;	// AsyncQueue.scala:91:55
  assign io_async_safe_source_reset_n = ~reset;	// AsyncQueue.scala:121:27
endmodule

