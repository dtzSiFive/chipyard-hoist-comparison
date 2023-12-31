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
module tag_array_64x80(	// icache.scala:180:30
  input  [5:0]  RW0_addr,
  input         RW0_en,
                RW0_clk,
                RW0_wmode,
  input  [79:0] RW0_wdata,
  input  [3:0]  RW0_wmask,
  output [79:0] RW0_rdata
);

  reg [79:0] Memory[0:63];	// icache.scala:180:30
  reg [5:0]  _RW0_raddr_d0;	// icache.scala:180:30
  reg        _RW0_ren_d0;	// icache.scala:180:30
  reg        _RW0_rmode_d0;	// icache.scala:180:30
  always @(posedge RW0_clk) begin	// icache.scala:180:30
    _RW0_raddr_d0 <= RW0_addr;	// icache.scala:180:30
    _RW0_ren_d0 <= RW0_en;	// icache.scala:180:30
    _RW0_rmode_d0 <= RW0_wmode;	// icache.scala:180:30
    if (RW0_en & RW0_wmask[0] & RW0_wmode)	// icache.scala:180:30
      Memory[RW0_addr][32'h0 +: 20] <= RW0_wdata[19:0];	// icache.scala:180:30
    if (RW0_en & RW0_wmask[1] & RW0_wmode)	// icache.scala:180:30
      Memory[RW0_addr][32'h14 +: 20] <= RW0_wdata[39:20];	// icache.scala:180:30
    if (RW0_en & RW0_wmask[2] & RW0_wmode)	// icache.scala:180:30
      Memory[RW0_addr][32'h28 +: 20] <= RW0_wdata[59:40];	// icache.scala:180:30
    if (RW0_en & RW0_wmask[3] & RW0_wmode)	// icache.scala:180:30
      Memory[RW0_addr][32'h3C +: 20] <= RW0_wdata[79:60];	// icache.scala:180:30
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// icache.scala:180:30
    `ifdef RANDOMIZE_REG_INIT	// icache.scala:180:30
      reg [31:0] _RANDOM;	// icache.scala:180:30
    `endif // RANDOMIZE_REG_INIT
    reg [95:0] _RANDOM_MEM;	// icache.scala:180:30
    initial begin	// icache.scala:180:30
      `INIT_RANDOM_PROLOG_	// icache.scala:180:30
      `ifdef RANDOMIZE_MEM_INIT	// icache.scala:180:30
        for (logic [6:0] i = 7'h0; i < 7'h40; i += 7'h1) begin
          for (logic [6:0] j = 7'h0; j < 7'h60; j += 7'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// icache.scala:180:30
          end	// icache.scala:180:30
          Memory[i[5:0]] = _RANDOM_MEM[79:0];	// icache.scala:180:30
        end	// icache.scala:180:30
      `endif // RANDOMIZE_MEM_INIT
      `ifdef RANDOMIZE_REG_INIT	// icache.scala:180:30
        _RANDOM = {`RANDOM};	// icache.scala:180:30
        _RW0_raddr_d0 = _RANDOM[5:0];	// icache.scala:180:30
        _RW0_ren_d0 = _RANDOM[6];	// icache.scala:180:30
        _RW0_rmode_d0 = _RANDOM[7];	// icache.scala:180:30
      `endif // RANDOMIZE_REG_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign RW0_rdata = _RW0_ren_d0 & ~_RW0_rmode_d0 ? Memory[_RW0_raddr_d0] : 80'bx;	// icache.scala:180:30
endmodule

