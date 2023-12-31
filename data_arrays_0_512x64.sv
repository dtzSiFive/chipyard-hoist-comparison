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

// VCS coverage exclude_file
module data_arrays_0_512x64(	// DescribedSRAM.scala:19:26
  input  [8:0]  RW0_addr,
  input         RW0_en,
                RW0_clk,
                RW0_wmode,
  input  [63:0] RW0_wdata,
  input  [7:0]  RW0_wmask,
  output [63:0] RW0_rdata
);

  reg [63:0] Memory[0:511];	// DescribedSRAM.scala:19:26
  reg [8:0]  _RW0_raddr_d0;	// DescribedSRAM.scala:19:26
  reg        _RW0_ren_d0;	// DescribedSRAM.scala:19:26
  reg        _RW0_rmode_d0;	// DescribedSRAM.scala:19:26
  always @(posedge RW0_clk) begin	// DescribedSRAM.scala:19:26
    _RW0_raddr_d0 <= RW0_addr;	// DescribedSRAM.scala:19:26
    _RW0_ren_d0 <= RW0_en;	// DescribedSRAM.scala:19:26
    _RW0_rmode_d0 <= RW0_wmode;	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[0] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h0 +: 8] <= RW0_wdata[7:0];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[1] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h8 +: 8] <= RW0_wdata[15:8];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[2] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h10 +: 8] <= RW0_wdata[23:16];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[3] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h18 +: 8] <= RW0_wdata[31:24];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[4] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h20 +: 8] <= RW0_wdata[39:32];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[5] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h28 +: 8] <= RW0_wdata[47:40];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[6] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h30 +: 8] <= RW0_wdata[55:48];	// DescribedSRAM.scala:19:26
    if (RW0_en & RW0_wmask[7] & RW0_wmode)	// DescribedSRAM.scala:19:26
      Memory[RW0_addr][32'h38 +: 8] <= RW0_wdata[63:56];	// DescribedSRAM.scala:19:26
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// DescribedSRAM.scala:19:26
    `ifdef RANDOMIZE_REG_INIT	// DescribedSRAM.scala:19:26
      reg [31:0] _RANDOM;	// DescribedSRAM.scala:19:26
    `endif // RANDOMIZE_REG_INIT
    reg [63:0] _RANDOM_MEM;	// DescribedSRAM.scala:19:26
    initial begin	// DescribedSRAM.scala:19:26
      `INIT_RANDOM_PROLOG_	// DescribedSRAM.scala:19:26
      `ifdef RANDOMIZE_MEM_INIT	// DescribedSRAM.scala:19:26
        for (logic [9:0] i = 10'h0; i < 10'h200; i += 10'h1) begin
          for (logic [6:0] j = 7'h0; j < 7'h40; j += 7'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// DescribedSRAM.scala:19:26
          end	// DescribedSRAM.scala:19:26
          Memory[i[8:0]] = _RANDOM_MEM;	// DescribedSRAM.scala:19:26
        end	// DescribedSRAM.scala:19:26
      `endif // RANDOMIZE_MEM_INIT
      `ifdef RANDOMIZE_REG_INIT	// DescribedSRAM.scala:19:26
        _RANDOM = {`RANDOM};	// DescribedSRAM.scala:19:26
        _RW0_raddr_d0 = _RANDOM[8:0];	// DescribedSRAM.scala:19:26
        _RW0_ren_d0 = _RANDOM[9];	// DescribedSRAM.scala:19:26
        _RW0_rmode_d0 = _RANDOM[10];	// DescribedSRAM.scala:19:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign RW0_rdata = _RW0_ren_d0 & ~_RW0_rmode_d0 ? Memory[_RW0_raddr_d0] : 64'bx;	// DescribedSRAM.scala:19:26
endmodule

