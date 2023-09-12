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

module TLBusBypassBar(
  input          clock,
                 reset,
                 auto_in_a_valid,
  input  [2:0]   auto_in_a_bits_opcode,
  input  [8:0]   auto_in_a_bits_address,
  input  [31:0]  auto_in_a_bits_data,
  input          auto_in_d_ready,
                 auto_out_1_a_ready,
                 auto_out_1_d_valid,
  input  [2:0]   auto_out_1_d_bits_opcode,
  input  [1:0]   auto_out_1_d_bits_param,
                 auto_out_1_d_bits_size,
  input          auto_out_1_d_bits_source,
                 auto_out_1_d_bits_sink,
                 auto_out_1_d_bits_denied,
  input  [31:0]  auto_out_1_d_bits_data,
  input          auto_out_1_d_bits_corrupt,
                 auto_out_0_a_ready,
                 auto_out_0_d_valid,
  input  [2:0]   auto_out_0_d_bits_opcode,
  input  [1:0]   auto_out_0_d_bits_size,
  input          auto_out_0_d_bits_denied,
                 auto_out_0_d_bits_corrupt,
                 io_bypass,
  output         auto_in_a_ready,
                 auto_in_d_valid,
  output [2:0]   auto_in_d_bits_opcode,
  output [1:0]   auto_in_d_bits_param,
                 auto_in_d_bits_size,
  output         auto_in_d_bits_sink,
                 auto_in_d_bits_denied,
  output [31:0]  auto_in_d_bits_data,
  output         auto_in_d_bits_corrupt,
                 auto_out_1_a_valid,
  output [2:0]   auto_out_1_a_bits_opcode,
  output [8:0]   auto_out_1_a_bits_address,
  output [31:0]  auto_out_1_a_bits_data,
  output         auto_out_1_d_ready,
                 auto_out_0_a_valid,
  output [2:0]   auto_out_0_a_bits_opcode,
  output [127:0] auto_out_0_a_bits_address,
  output         auto_out_0_d_ready
);

  reg        in_reset;	// BusBypass.scala:77:27
  reg        bypass_reg;	// BusBypass.scala:78:25
  wire       bypass = in_reset ? io_bypass : bypass_reg;	// BusBypass.scala:77:27, :78:25, :79:21
  reg  [1:0] flight;	// Edges.scala:294:25
  reg        counter;	// Edges.scala:228:27
  reg        counter_3;	// Edges.scala:228:27
  reg        stall_counter;	// Edges.scala:228:27
  wire       stall = bypass != io_bypass & ~stall_counter;	// BusBypass.scala:79:21, :84:{25,40}, Edges.scala:228:27, :230:25
  wire       in_a_ready = ~stall & (bypass ? auto_out_0_a_ready : auto_out_1_a_ready);	// BusBypass.scala:79:21, :84:40, :86:21, :88:{28,34}
  wire       in_d_valid = bypass ? auto_out_0_d_valid : auto_out_1_d_valid;	// BusBypass.scala:79:21, :94:24
  wire [2:0] in_d_bits_opcode =
    bypass ? auto_out_0_d_bits_opcode : auto_out_1_d_bits_opcode;	// BusBypass.scala:79:21, :96:21
  wire [1:0] in_d_bits_param = bypass ? 2'h0 : auto_out_1_d_bits_param;	// BusBypass.scala:79:21, :96:21
  wire [1:0] in_d_bits_size = bypass ? auto_out_0_d_bits_size : auto_out_1_d_bits_size;	// BusBypass.scala:79:21, :96:21
  wire       in_d_bits_sink = ~bypass & auto_out_1_d_bits_sink;	// BusBypass.scala:79:21, :96:21
  wire       in_d_bits_denied =
    bypass ? auto_out_0_d_bits_denied : auto_out_1_d_bits_denied;	// BusBypass.scala:79:21, :96:21
  wire       in_d_bits_corrupt =
    bypass ? auto_out_0_d_bits_corrupt : auto_out_1_d_bits_corrupt;	// BusBypass.scala:79:21, :96:21
  always @(posedge clock) begin
    automatic logic       done;	// Decoupled.scala:40:37
    automatic logic       done_3;	// Decoupled.scala:40:37
    automatic logic [1:0] _next_flight_T_10;	// Edges.scala:323:46
    done = in_a_ready & auto_in_a_valid;	// BusBypass.scala:88:28, Decoupled.scala:40:37
    done_3 = auto_in_d_ready & in_d_valid;	// BusBypass.scala:94:24, Decoupled.scala:40:37
    _next_flight_T_10 =
      flight + {1'h0, done_3 & ~counter_3 & in_d_bits_opcode[2] & ~(in_d_bits_opcode[1])}
      + {1'h0, done & ~counter} - {1'h0, done_3};	// Bitwise.scala:47:55, BusBypass.scala:96:21, Decoupled.scala:40:37, Edges.scala:70:{36,43,52}, :228:27, :230:25, :294:25, :309:28, :312:39, :323:{30,46}
    if (reset) begin
      in_reset <= 1'h1;	// BusBypass.scala:77:27
      flight <= 2'h0;	// Edges.scala:294:25
      counter <= 1'h0;	// Edges.scala:228:27
      counter_3 <= 1'h0;	// Edges.scala:228:27
      stall_counter <= 1'h0;	// Edges.scala:228:27
    end
    else begin
      in_reset <= 1'h0;	// BusBypass.scala:77:27
      flight <= _next_flight_T_10;	// Edges.scala:294:25, :323:46
      counter <= (~done | counter - 1'h1) & counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      counter_3 <= (~done_3 | counter_3 - 1'h1) & counter_3;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
      stall_counter <= (~done | stall_counter - 1'h1) & stall_counter;	// Decoupled.scala:40:37, Edges.scala:228:27, :229:28, :234:17, :235:15
    end
    if (in_reset | _next_flight_T_10 == 2'h0)	// BusBypass.scala:77:27, :83:{20,36}, Edges.scala:323:46
      bypass_reg <= io_bypass;	// BusBypass.scala:78:25
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
        in_reset = _RANDOM[/*Zero width*/ 1'b0][0];	// BusBypass.scala:77:27
        bypass_reg = _RANDOM[/*Zero width*/ 1'b0][1];	// BusBypass.scala:77:27, :78:25
        flight = _RANDOM[/*Zero width*/ 1'b0][3:2];	// BusBypass.scala:77:27, Edges.scala:294:25
        counter = _RANDOM[/*Zero width*/ 1'b0][4];	// BusBypass.scala:77:27, Edges.scala:228:27
        counter_3 = _RANDOM[/*Zero width*/ 1'b0][7];	// BusBypass.scala:77:27, Edges.scala:228:27
        stall_counter = _RANDOM[/*Zero width*/ 1'b0][9];	// BusBypass.scala:77:27, Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_72 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (in_a_ready),	// BusBypass.scala:88:28
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (in_d_valid),	// BusBypass.scala:94:24
    .io_in_d_bits_opcode  (in_d_bits_opcode),	// BusBypass.scala:96:21
    .io_in_d_bits_param   (in_d_bits_param),	// BusBypass.scala:96:21
    .io_in_d_bits_size    (in_d_bits_size),	// BusBypass.scala:96:21
    .io_in_d_bits_source  (~bypass & auto_out_1_d_bits_source),	// BusBypass.scala:79:21, :96:21
    .io_in_d_bits_sink    (in_d_bits_sink),	// BusBypass.scala:96:21
    .io_in_d_bits_denied  (in_d_bits_denied),	// BusBypass.scala:96:21
    .io_in_d_bits_corrupt (in_d_bits_corrupt)	// BusBypass.scala:96:21
  );
  assign auto_in_a_ready = in_a_ready;	// BusBypass.scala:88:28
  assign auto_in_d_valid = in_d_valid;	// BusBypass.scala:94:24
  assign auto_in_d_bits_opcode = in_d_bits_opcode;	// BusBypass.scala:96:21
  assign auto_in_d_bits_param = in_d_bits_param;	// BusBypass.scala:96:21
  assign auto_in_d_bits_size = in_d_bits_size;	// BusBypass.scala:96:21
  assign auto_in_d_bits_sink = in_d_bits_sink;	// BusBypass.scala:96:21
  assign auto_in_d_bits_denied = in_d_bits_denied;	// BusBypass.scala:96:21
  assign auto_in_d_bits_data = bypass ? 32'h0 : auto_out_1_d_bits_data;	// BusBypass.scala:79:21, :96:21
  assign auto_in_d_bits_corrupt = in_d_bits_corrupt;	// BusBypass.scala:96:21
  assign auto_out_1_a_valid = ~stall & auto_in_a_valid & ~bypass;	// BusBypass.scala:79:21, :84:40, :86:21, :87:{42,45}
  assign auto_out_1_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_1_a_bits_address = auto_in_a_bits_address;
  assign auto_out_1_a_bits_data = auto_in_a_bits_data;
  assign auto_out_1_d_ready = auto_in_d_ready & ~bypass;	// BusBypass.scala:79:21, :87:45, :93:32
  assign auto_out_0_a_valid = ~stall & auto_in_a_valid & bypass;	// BusBypass.scala:79:21, :84:40, :86:{21,42}
  assign auto_out_0_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_0_a_bits_address = {119'h0, auto_in_a_bits_address};	// BusBypass.scala:89:18
  assign auto_out_0_d_ready = auto_in_d_ready & bypass;	// BusBypass.scala:79:21, :92:32
endmodule

