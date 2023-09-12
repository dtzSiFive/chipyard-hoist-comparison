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

module TLError(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [3:0]  auto_in_a_bits_size,
  input  [7:0]  auto_in_a_bits_source,
  input  [13:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [3:0]  auto_in_d_bits_size,
  output [7:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_corrupt
);

  wire [2:0]      da_bits_opcode;	// Error.scala:53:21
  wire            _a_io_enq_ready;	// Decoupled.scala:296:21
  wire            _a_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0]      _a_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [3:0]      _a_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [7:0]      _a_io_deq_bits_source;	// Decoupled.scala:296:21
  wire [7:0][2:0] _GEN = {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// Error.scala:53:21
  wire [26:0]     _GEN_0 = {23'h0, _a_io_deq_bits_size};	// Decoupled.scala:296:21, package.scala:234:77
  wire [26:0]     _a_last_beats1_decode_T_1 = 27'hFFF << _GEN_0;	// package.scala:234:77
  reg  [8:0]      a_last_counter;	// Edges.scala:228:27
  wire            a_last =
    a_last_counter == 9'h1
    | (_a_io_deq_bits_opcode[2] ? 9'h0 : ~(_a_last_beats1_decode_T_1[11:3])) == 9'h0;	// Decoupled.scala:296:21, Edges.scala:91:37, :220:14, :228:27, :231:{25,37,47}, package.scala:234:{46,77,82}
  wire [26:0]     _beats1_decode_T_1 = 27'hFFF << _GEN_0;	// package.scala:234:77
  reg  [8:0]      counter;	// Edges.scala:228:27
  wire            _a_io_deq_ready_T_3 =
    auto_in_d_ready
    & (counter == 9'h1 | (da_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0) == 9'h0)
    | ~a_last;	// Edges.scala:105:36, :220:14, :228:27, :231:{25,37,47}, Error.scala:50:{26,46,49}, :53:21, package.scala:234:{46,77,82}
  wire            da_valid = _a_io_deq_valid & a_last;	// Decoupled.scala:296:21, Edges.scala:231:37, Error.scala:51:25
  assign da_bits_opcode = _GEN[_a_io_deq_bits_opcode];	// Decoupled.scala:296:21, Error.scala:53:21
  always @(posedge clock) begin
    if (reset) begin
      a_last_counter <= 9'h0;	// Edges.scala:228:27
      counter <= 9'h0;	// Edges.scala:228:27
    end
    else begin
      if (_a_io_deq_ready_T_3 & _a_io_deq_valid) begin	// Decoupled.scala:40:37, :296:21, Error.scala:50:46
        if (a_last_counter == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (_a_io_deq_bits_opcode[2])	// Decoupled.scala:296:21, Edges.scala:91:37
            a_last_counter <= 9'h0;	// Edges.scala:228:27
          else	// Edges.scala:91:37
            a_last_counter <= ~(_a_last_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:230:25
          a_last_counter <= a_last_counter - 9'h1;	// Edges.scala:228:27, :229:28
      end
      if (auto_in_d_ready & da_valid) begin	// Decoupled.scala:40:37, Error.scala:51:25
        if (counter == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (da_bits_opcode[0])	// Edges.scala:105:36, Error.scala:53:21
            counter <= ~(_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:105:36
            counter <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          counter <= counter - 9'h1;	// Edges.scala:228:27, :229:28
      end
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
        a_last_counter = _RANDOM[/*Zero width*/ 1'b0][9:1];	// Edges.scala:228:27
        counter = _RANDOM[/*Zero width*/ 1'b0][18:10];	// Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_32 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_a_io_enq_ready),	// Decoupled.scala:296:21
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (da_valid),	// Error.scala:51:25
    .io_in_d_bits_opcode  (da_bits_opcode),	// Error.scala:53:21
    .io_in_d_bits_size    (_a_io_deq_bits_size),	// Decoupled.scala:296:21
    .io_in_d_bits_source  (_a_io_deq_bits_source),	// Decoupled.scala:296:21
    .io_in_d_bits_corrupt (da_bits_opcode[0])	// Edges.scala:105:36, Error.scala:53:21
  );
  Queue_12 a (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_data    (auto_in_a_bits_data),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (_a_io_deq_ready_T_3),	// Error.scala:50:46
    .io_enq_ready        (_a_io_enq_ready),
    .io_deq_valid        (_a_io_deq_valid),
    .io_deq_bits_opcode  (_a_io_deq_bits_opcode),
    .io_deq_bits_size    (_a_io_deq_bits_size),
    .io_deq_bits_source  (_a_io_deq_bits_source)
  );
  assign auto_in_a_ready = _a_io_enq_ready;	// Decoupled.scala:296:21
  assign auto_in_d_valid = da_valid;	// Error.scala:51:25
  assign auto_in_d_bits_opcode = da_bits_opcode;	// Error.scala:53:21
  assign auto_in_d_bits_size = _a_io_deq_bits_size;	// Decoupled.scala:296:21
  assign auto_in_d_bits_source = _a_io_deq_bits_source;	// Decoupled.scala:296:21
  assign auto_in_d_bits_corrupt = da_bits_opcode[0];	// Edges.scala:105:36, Error.scala:53:21
endmodule

