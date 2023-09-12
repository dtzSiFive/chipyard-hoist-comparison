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

module DCacheDataArray(
  input         clock,
                io_req_valid,
  input  [11:0] io_req_bits_addr,
  input         io_req_bits_write,
  input  [63:0] io_req_bits_wdata,
  input  [7:0]  io_req_bits_eccMask,
  input  [3:0]  io_req_bits_way_en,
  output [63:0] io_resp_0,
                io_resp_1,
                io_resp_2,
                io_resp_3
);

  wire         data_arrays_0_rdata_data_en;	// DCache.scala:71:39
  wire         data_arrays_0_rdata_MPORT_en;	// DCache.scala:66:17
  wire [255:0] _data_arrays_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  assign data_arrays_0_rdata_MPORT_en = io_req_valid & io_req_bits_write;	// DCache.scala:66:17
  assign data_arrays_0_rdata_data_en = io_req_valid & ~io_req_bits_write;	// DCache.scala:71:{39,42}
  data_arrays_0_512x256 data_arrays_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (io_req_bits_addr[11:3]),	// DCache.scala:53:31
    .RW0_en    (data_arrays_0_rdata_data_en | data_arrays_0_rdata_MPORT_en),	// DCache.scala:66:17, :71:39, DescribedSRAM.scala:19:26
    .RW0_clk   (clock),
    .RW0_wmode (io_req_bits_write),
    .RW0_wdata ({4{io_req_bits_wdata}}),	// DescribedSRAM.scala:19:26
    .RW0_wmask
      ({io_req_bits_eccMask[7] & io_req_bits_way_en[3],
        io_req_bits_eccMask[6] & io_req_bits_way_en[3],
        io_req_bits_eccMask[5] & io_req_bits_way_en[3],
        io_req_bits_eccMask[4] & io_req_bits_way_en[3],
        io_req_bits_eccMask[3] & io_req_bits_way_en[3],
        io_req_bits_eccMask[2] & io_req_bits_way_en[3],
        io_req_bits_eccMask[1] & io_req_bits_way_en[3],
        io_req_bits_eccMask[0] & io_req_bits_way_en[3],
        io_req_bits_eccMask[7] & io_req_bits_way_en[2],
        io_req_bits_eccMask[6] & io_req_bits_way_en[2],
        io_req_bits_eccMask[5] & io_req_bits_way_en[2],
        io_req_bits_eccMask[4] & io_req_bits_way_en[2],
        io_req_bits_eccMask[3] & io_req_bits_way_en[2],
        io_req_bits_eccMask[2] & io_req_bits_way_en[2],
        io_req_bits_eccMask[1] & io_req_bits_way_en[2],
        io_req_bits_eccMask[0] & io_req_bits_way_en[2],
        io_req_bits_eccMask[7] & io_req_bits_way_en[1],
        io_req_bits_eccMask[6] & io_req_bits_way_en[1],
        io_req_bits_eccMask[5] & io_req_bits_way_en[1],
        io_req_bits_eccMask[4] & io_req_bits_way_en[1],
        io_req_bits_eccMask[3] & io_req_bits_way_en[1],
        io_req_bits_eccMask[2] & io_req_bits_way_en[1],
        io_req_bits_eccMask[1] & io_req_bits_way_en[1],
        io_req_bits_eccMask[0] & io_req_bits_way_en[1],
        io_req_bits_eccMask[7] & io_req_bits_way_en[0],
        io_req_bits_eccMask[6] & io_req_bits_way_en[0],
        io_req_bits_eccMask[5] & io_req_bits_way_en[0],
        io_req_bits_eccMask[4] & io_req_bits_way_en[0],
        io_req_bits_eccMask[3] & io_req_bits_way_en[0],
        io_req_bits_eccMask[2] & io_req_bits_way_en[0],
        io_req_bits_eccMask[1] & io_req_bits_way_en[0],
        io_req_bits_eccMask[0] & io_req_bits_way_en[0]}),	// DCache.scala:50:82, :51:{87,108}, DescribedSRAM.scala:19:26
    .RW0_rdata (_data_arrays_0_ext_RW0_rdata)
  );
  assign io_resp_0 = _data_arrays_0_ext_RW0_rdata[63:0];	// Cat.scala:30:58, DescribedSRAM.scala:19:26
  assign io_resp_1 = _data_arrays_0_ext_RW0_rdata[127:64];	// Cat.scala:30:58, DescribedSRAM.scala:19:26
  assign io_resp_2 = _data_arrays_0_ext_RW0_rdata[191:128];	// Cat.scala:30:58, DescribedSRAM.scala:19:26
  assign io_resp_3 = _data_arrays_0_ext_RW0_rdata[255:192];	// Cat.scala:30:58, DescribedSRAM.scala:19:26
endmodule

