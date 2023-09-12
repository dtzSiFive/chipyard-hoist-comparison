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

module ListBuffer(
  input         clock,
                reset,
                io_push_valid,
  input  [5:0]  io_push_bits_index,
  input  [63:0] io_push_bits_data_data,
  input  [7:0]  io_push_bits_data_mask,
  input         io_push_bits_data_corrupt,
                io_pop_valid,
  input  [5:0]  io_pop_bits,
  output        io_push_ready,
  output [39:0] io_valid,
  output [63:0] io_data_data,
  output [7:0]  io_data_mask,
  output        io_data_corrupt
);

  wire [72:0] _data_ext_R0_data;	// ListBuffer.scala:50:18
  wire [5:0]  _next_ext_R0_data;	// ListBuffer.scala:49:18
  wire [5:0]  _tail_ext_R0_data;	// ListBuffer.scala:47:18
  wire [5:0]  _tail_ext_R1_data;	// ListBuffer.scala:47:18
  wire [5:0]  _head_ext_R0_data;	// ListBuffer.scala:46:18
  reg  [39:0] valid;	// ListBuffer.scala:45:22
  reg  [39:0] used;	// ListBuffer.scala:48:22
  wire [39:0] _freeOH_T_22 = ~used;	// ListBuffer.scala:48:22, :52:25
  wire [38:0] _freeOH_T_3 = _freeOH_T_22[38:0] | {_freeOH_T_22[37:0], 1'h0};	// ListBuffer.scala:46:18, :52:25, package.scala:244:{43,53}
  wire [38:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[36:0], 2'h0};	// package.scala:244:{43,53}
  wire [38:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[34:0], 4'h0};	// package.scala:244:{43,48,53}
  wire [38:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[30:0], 8'h0};	// package.scala:244:{43,48,53}
  wire [38:0] _freeOH_T_15 = _freeOH_T_12 | {_freeOH_T_12[22:0], 16'h0};	// package.scala:244:{43,48,53}
  wire [39:0] _GEN = {~(_freeOH_T_15 | {_freeOH_T_15[6:0], 32'h0}), 1'h1} & _freeOH_T_22;	// ListBuffer.scala:52:{16,25,38}, package.scala:244:{43,48,53}
  wire [30:0] _freeIdx_T = {24'h0, _GEN[39:33]} | _GEN[31:1];	// ListBuffer.scala:52:38, OneHot.scala:31:18, :32:28
  wire [14:0] _freeIdx_T_1 = _freeIdx_T[30:16] | _freeIdx_T[14:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [6:0]  _freeIdx_T_2 = _freeIdx_T_1[14:8] | _freeIdx_T_1[6:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [2:0]  _freeIdx_T_3 = _freeIdx_T_2[6:4] | _freeIdx_T_2[2:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [5:0]  data_MPORT_addr =
    {|(_GEN[39:32]),
     |(_freeIdx_T[30:15]),
     |(_freeIdx_T_1[14:7]),
     |(_freeIdx_T_2[6:3]),
     |(_freeIdx_T_3[2:1]),
     _freeIdx_T_3[2] | _freeIdx_T_3[0]};	// Cat.scala:30:58, ListBuffer.scala:52:38, OneHot.scala:30:18, :31:18, :32:{14,28}
  wire [39:0] _push_valid_T = valid >> io_push_bits_index;	// ListBuffer.scala:45:22, :61:25
  wire        _io_push_ready_output = used != 40'hFFFFFFFFFF;	// ListBuffer.scala:48:22, :52:25, :63:30
  wire        data_MPORT_en = _io_push_ready_output & io_push_valid;	// Decoupled.scala:40:37, ListBuffer.scala:63:30
  `ifndef SYNTHESIS	// ListBuffer.scala:84:10
    always @(posedge clock) begin	// ListBuffer.scala:84:10
      automatic logic [39:0] _GEN_0;	// ListBuffer.scala:84:39
      _GEN_0 = valid >> io_pop_bits;	// ListBuffer.scala:45:22, :84:39
      if (~(~io_pop_valid | _GEN_0[0] | reset)) begin	// ListBuffer.scala:84:{10,11,39}
        if (`ASSERT_VERBOSE_COND_)	// ListBuffer.scala:84:10
          $error("Assertion failed\n    at ListBuffer.scala:84 assert (!io.pop.fire() || (io.valid)(io.pop.bits))\n");	// ListBuffer.scala:84:10
        if (`STOP_COND_)	// ListBuffer.scala:84:10
          $fatal;	// ListBuffer.scala:84:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      valid <= 40'h0;	// ListBuffer.scala:45:22
      used <= 40'h0;	// ListBuffer.scala:45:22, :48:22
    end
    else begin
      automatic logic [63:0] _valid_clr_T = 64'h1 << io_pop_bits;	// OneHot.scala:65:12
      automatic logic [63:0] _valid_set_T = 64'h1 << io_push_bits_index;	// OneHot.scala:65:12
      automatic logic [63:0] _used_clr_T = 64'h1 << _head_ext_R0_data;	// ListBuffer.scala:46:18, OneHot.scala:65:12
      valid <=
        valid
        & ~(io_pop_valid & _head_ext_R0_data == _tail_ext_R1_data
              ? _valid_clr_T[39:0]
              : 40'h0) | (data_MPORT_en ? _valid_set_T[39:0] : 40'h0);	// Decoupled.scala:40:37, ListBuffer.scala:45:22, :46:18, :47:18, :64:25, :65:15, :86:24, :88:{20,48}, :89:17, :97:{21,23,35}, OneHot.scala:65:{12,27}
      used <=
        used & ~(io_pop_valid ? _used_clr_T[39:0] : 40'h0)
        | (data_MPORT_en ? _GEN : 40'h0);	// Decoupled.scala:40:37, ListBuffer.scala:45:22, :48:22, :52:38, :64:25, :66:14, :86:24, :87:14, :96:{21,23,35}, OneHot.scala:65:{12,27}
    end
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
        valid = {_RANDOM[2'h0], _RANDOM[2'h1][7:0]};	// ListBuffer.scala:45:22
        used = {_RANDOM[2'h1][31:8], _RANDOM[2'h2][15:0]};	// ListBuffer.scala:45:22, :48:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  head_40x6 head_ext (	// ListBuffer.scala:46:18
    .R0_addr (io_pop_bits),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (io_pop_bits),
    .W0_en   (io_pop_valid),
    .W0_clk  (clock),
    .W0_data
      (data_MPORT_en & _push_valid_T[0] & _tail_ext_R0_data == _head_ext_R0_data
         ? data_MPORT_addr
         : _next_ext_R0_data),	// Cat.scala:30:58, Decoupled.scala:40:37, ListBuffer.scala:46:18, :47:18, :49:18, :61:25, :91:{32,62,75}
    .W1_addr (io_push_bits_index),
    .W1_en   (data_MPORT_en & ~(_push_valid_T[0])),	// Decoupled.scala:40:37, ListBuffer.scala:46:18, :60:28, :61:25, :64:25, :68:23
    .W1_clk  (clock),
    .W1_data (data_MPORT_addr),	// Cat.scala:30:58
    .R0_data (_head_ext_R0_data)
  );
  tail_40x6 tail_ext (	// ListBuffer.scala:47:18
    .R0_addr (io_push_bits_index),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (io_pop_bits),
    .R1_en   (io_pop_valid),
    .R1_clk  (clock),
    .W0_addr (io_push_bits_index),
    .W0_en   (data_MPORT_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data (data_MPORT_addr),	// Cat.scala:30:58
    .R0_data (_tail_ext_R0_data),
    .R1_data (_tail_ext_R1_data)
  );
  next_40x6 next_ext (	// ListBuffer.scala:49:18
    .R0_addr (_head_ext_R0_data),	// ListBuffer.scala:46:18
    .R0_en   (io_pop_valid),
    .R0_clk  (clock),
    .W0_addr (_tail_ext_R0_data),	// ListBuffer.scala:47:18
    .W0_en   (data_MPORT_en & _push_valid_T[0]),	// Decoupled.scala:40:37, ListBuffer.scala:49:18, :61:25, :64:25, :68:23
    .W0_clk  (clock),
    .W0_data (data_MPORT_addr),	// Cat.scala:30:58
    .R0_data (_next_ext_R0_data)
  );
  data_40x73 data_ext (	// ListBuffer.scala:50:18
    .R0_addr (_head_ext_R0_data),	// ListBuffer.scala:46:18
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (data_MPORT_addr),	// Cat.scala:30:58
    .W0_en   (data_MPORT_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data
      ({io_push_bits_data_corrupt, io_push_bits_data_mask, io_push_bits_data_data}),	// ListBuffer.scala:50:18
    .R0_data (_data_ext_R0_data)
  );
  assign io_push_ready = _io_push_ready_output;	// ListBuffer.scala:63:30
  assign io_valid = valid;	// ListBuffer.scala:45:22
  assign io_data_data = _data_ext_R0_data[63:0];	// ListBuffer.scala:50:18
  assign io_data_mask = _data_ext_R0_data[71:64];	// ListBuffer.scala:50:18
  assign io_data_corrupt = _data_ext_R0_data[72];	// ListBuffer.scala:50:18
endmodule

