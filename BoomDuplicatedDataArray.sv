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

module BoomDuplicatedDataArray(
  input         clock,
                io_read_0_valid,
  input  [7:0]  io_read_0_bits_way_en,
  input  [11:0] io_read_0_bits_addr,
  input         io_read_1_valid,
  input  [7:0]  io_read_1_bits_way_en,
  input  [11:0] io_read_1_bits_addr,
  input         io_write_valid,
  input  [7:0]  io_write_bits_way_en,
  input  [11:0] io_write_bits_addr,
  input  [63:0] io_write_bits_data,
  output [63:0] io_resp_0_0,
                io_resp_0_1,
                io_resp_0_2,
                io_resp_0_3,
                io_resp_0_4,
                io_resp_0_5,
                io_resp_0_6,
                io_resp_0_7,
                io_resp_1_0,
                io_resp_1_1,
                io_resp_1_2,
                io_resp_1_3,
                io_resp_1_4,
                io_resp_1_5,
                io_resp_1_6,
                io_resp_1_7
);

  wire [63:0] _array_7_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_6_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_5_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_4_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_3_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_2_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_1_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_0_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_7_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_6_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_5_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_4_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_3_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_2_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_1_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire [63:0] _array_0_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire        array_0_1_MPORT_8_en = io_write_bits_way_en[0] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_0_REG;	// dcache.scala:297:31
  wire        array_1_1_MPORT_9_en = io_write_bits_way_en[1] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_1_REG;	// dcache.scala:297:31
  wire        array_2_1_MPORT_10_en = io_write_bits_way_en[2] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_2_REG;	// dcache.scala:297:31
  wire        array_3_1_MPORT_11_en = io_write_bits_way_en[3] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_3_REG;	// dcache.scala:297:31
  wire        array_4_1_MPORT_12_en = io_write_bits_way_en[4] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_4_REG;	// dcache.scala:297:31
  wire        array_5_1_MPORT_13_en = io_write_bits_way_en[5] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_5_REG;	// dcache.scala:297:31
  wire        array_6_1_MPORT_14_en = io_write_bits_way_en[6] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_6_REG;	// dcache.scala:297:31
  wire        array_7_1_MPORT_15_en = io_write_bits_way_en[7] & io_write_valid;	// dcache.scala:293:{33,37}
  reg  [63:0] io_resp_0_7_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_0_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_1_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_2_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_3_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_4_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_5_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_6_REG;	// dcache.scala:297:31
  reg  [63:0] io_resp_1_7_REG;	// dcache.scala:297:31
  always @(posedge clock) begin
    io_resp_0_0_REG <= _array_0_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_1_REG <= _array_1_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_2_REG <= _array_2_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_3_REG <= _array_3_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_4_REG <= _array_4_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_5_REG <= _array_5_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_6_REG <= _array_6_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_0_7_REG <= _array_7_0_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_0_REG <= _array_0_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_1_REG <= _array_1_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_2_REG <= _array_2_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_3_REG <= _array_3_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_4_REG <= _array_4_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_5_REG <= _array_5_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_6_REG <= _array_6_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
    io_resp_1_7_REG <= _array_7_1_0_ext_R0_data;	// DescribedSRAM.scala:19:26, dcache.scala:297:31
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:31];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h20; i += 6'h1) begin
          _RANDOM[i[4:0]] = `RANDOM;
        end
        io_resp_0_0_REG = {_RANDOM[5'h0], _RANDOM[5'h1]};	// dcache.scala:297:31
        io_resp_0_1_REG = {_RANDOM[5'h2], _RANDOM[5'h3]};	// dcache.scala:297:31
        io_resp_0_2_REG = {_RANDOM[5'h4], _RANDOM[5'h5]};	// dcache.scala:297:31
        io_resp_0_3_REG = {_RANDOM[5'h6], _RANDOM[5'h7]};	// dcache.scala:297:31
        io_resp_0_4_REG = {_RANDOM[5'h8], _RANDOM[5'h9]};	// dcache.scala:297:31
        io_resp_0_5_REG = {_RANDOM[5'hA], _RANDOM[5'hB]};	// dcache.scala:297:31
        io_resp_0_6_REG = {_RANDOM[5'hC], _RANDOM[5'hD]};	// dcache.scala:297:31
        io_resp_0_7_REG = {_RANDOM[5'hE], _RANDOM[5'hF]};	// dcache.scala:297:31
        io_resp_1_0_REG = {_RANDOM[5'h10], _RANDOM[5'h11]};	// dcache.scala:297:31
        io_resp_1_1_REG = {_RANDOM[5'h12], _RANDOM[5'h13]};	// dcache.scala:297:31
        io_resp_1_2_REG = {_RANDOM[5'h14], _RANDOM[5'h15]};	// dcache.scala:297:31
        io_resp_1_3_REG = {_RANDOM[5'h16], _RANDOM[5'h17]};	// dcache.scala:297:31
        io_resp_1_4_REG = {_RANDOM[5'h18], _RANDOM[5'h19]};	// dcache.scala:297:31
        io_resp_1_5_REG = {_RANDOM[5'h1A], _RANDOM[5'h1B]};	// dcache.scala:297:31
        io_resp_1_6_REG = {_RANDOM[5'h1C], _RANDOM[5'h1D]};	// dcache.scala:297:31
        io_resp_1_7_REG = {_RANDOM[5'h1E], _RANDOM[5'h1F]};	// dcache.scala:297:31
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  array_512x64 array_0_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[0] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_0_1_MPORT_8_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_0_0_0_ext_R0_data)
  );
  array_512x64 array_1_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[1] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_1_1_MPORT_9_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_1_0_0_ext_R0_data)
  );
  array_512x64 array_2_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[2] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_2_1_MPORT_10_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_2_0_0_ext_R0_data)
  );
  array_512x64 array_3_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[3] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_3_1_MPORT_11_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_3_0_0_ext_R0_data)
  );
  array_512x64 array_4_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[4] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_4_1_MPORT_12_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_4_0_0_ext_R0_data)
  );
  array_512x64 array_5_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[5] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_5_1_MPORT_13_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_5_0_0_ext_R0_data)
  );
  array_512x64 array_6_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[6] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_6_1_MPORT_14_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_6_0_0_ext_R0_data)
  );
  array_512x64 array_7_0_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_0_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_0_bits_way_en[7] & io_read_0_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_7_1_MPORT_15_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_7_0_0_ext_R0_data)
  );
  array_512x64 array_0_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[0] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_0_1_MPORT_8_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_0_1_0_ext_R0_data)
  );
  array_512x64 array_1_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[1] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_1_1_MPORT_9_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_1_1_0_ext_R0_data)
  );
  array_512x64 array_2_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[2] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_2_1_MPORT_10_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_2_1_0_ext_R0_data)
  );
  array_512x64 array_3_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[3] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_3_1_MPORT_11_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_3_1_0_ext_R0_data)
  );
  array_512x64 array_4_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[4] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_4_1_MPORT_12_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_4_1_0_ext_R0_data)
  );
  array_512x64 array_5_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[5] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_5_1_MPORT_13_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_5_1_0_ext_R0_data)
  );
  array_512x64 array_6_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[6] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_6_1_MPORT_14_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_6_1_0_ext_R0_data)
  );
  array_512x64 array_7_1_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (io_read_1_bits_addr[11:3]),	// dcache.scala:285:38
    .R0_en   (io_read_1_bits_way_en[7] & io_read_1_valid),	// dcache.scala:297:{72,76}
    .R0_clk  (clock),
    .W0_addr (io_write_bits_addr[11:3]),	// dcache.scala:282:34
    .W0_en   (array_7_1_MPORT_15_en),	// dcache.scala:293:37
    .W0_clk  (clock),
    .W0_data (io_write_bits_data),
    .R0_data (_array_7_1_0_ext_R0_data)
  );
  assign io_resp_0_0 = io_resp_0_0_REG;	// dcache.scala:297:31
  assign io_resp_0_1 = io_resp_0_1_REG;	// dcache.scala:297:31
  assign io_resp_0_2 = io_resp_0_2_REG;	// dcache.scala:297:31
  assign io_resp_0_3 = io_resp_0_3_REG;	// dcache.scala:297:31
  assign io_resp_0_4 = io_resp_0_4_REG;	// dcache.scala:297:31
  assign io_resp_0_5 = io_resp_0_5_REG;	// dcache.scala:297:31
  assign io_resp_0_6 = io_resp_0_6_REG;	// dcache.scala:297:31
  assign io_resp_0_7 = io_resp_0_7_REG;	// dcache.scala:297:31
  assign io_resp_1_0 = io_resp_1_0_REG;	// dcache.scala:297:31
  assign io_resp_1_1 = io_resp_1_1_REG;	// dcache.scala:297:31
  assign io_resp_1_2 = io_resp_1_2_REG;	// dcache.scala:297:31
  assign io_resp_1_3 = io_resp_1_3_REG;	// dcache.scala:297:31
  assign io_resp_1_4 = io_resp_1_4_REG;	// dcache.scala:297:31
  assign io_resp_1_5 = io_resp_1_5_REG;	// dcache.scala:297:31
  assign io_resp_1_6 = io_resp_1_6_REG;	// dcache.scala:297:31
  assign io_resp_1_7 = io_resp_1_7_REG;	// dcache.scala:297:31
endmodule

