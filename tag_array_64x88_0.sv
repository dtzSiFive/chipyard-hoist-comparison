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
module tag_array_64x88_0(	// HellaCache.scala:322:25
  input  [5:0]  R0_addr,
  input         R0_en,
                R0_clk,
  input  [5:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [87:0] W0_data,
  input  [3:0]  W0_mask,
  output [87:0] R0_data
);

  reg [87:0] Memory[0:63];	// HellaCache.scala:322:25
  reg        _R0_en_d0;	// HellaCache.scala:322:25
  reg [5:0]  _R0_addr_d0;	// HellaCache.scala:322:25
  always @(posedge R0_clk) begin	// HellaCache.scala:322:25
    _R0_en_d0 <= R0_en;	// HellaCache.scala:322:25
    _R0_addr_d0 <= R0_addr;	// HellaCache.scala:322:25
  end // always @(posedge)
  always @(posedge W0_clk) begin	// HellaCache.scala:322:25
    if (W0_en & W0_mask[0])	// HellaCache.scala:322:25
      Memory[W0_addr][32'h0 +: 22] <= W0_data[21:0];	// HellaCache.scala:322:25
    if (W0_en & W0_mask[1])	// HellaCache.scala:322:25
      Memory[W0_addr][32'h16 +: 22] <= W0_data[43:22];	// HellaCache.scala:322:25
    if (W0_en & W0_mask[2])	// HellaCache.scala:322:25
      Memory[W0_addr][32'h2C +: 22] <= W0_data[65:44];	// HellaCache.scala:322:25
    if (W0_en & W0_mask[3])	// HellaCache.scala:322:25
      Memory[W0_addr][32'h42 +: 22] <= W0_data[87:66];	// HellaCache.scala:322:25
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// HellaCache.scala:322:25
    `ifdef RANDOMIZE_REG_INIT	// HellaCache.scala:322:25
      reg [31:0] _RANDOM;	// HellaCache.scala:322:25
    `endif // RANDOMIZE_REG_INIT
    reg [95:0] _RANDOM_MEM;	// HellaCache.scala:322:25
    initial begin	// HellaCache.scala:322:25
      `INIT_RANDOM_PROLOG_	// HellaCache.scala:322:25
      `ifdef RANDOMIZE_MEM_INIT	// HellaCache.scala:322:25
        for (logic [6:0] i = 7'h0; i < 7'h40; i += 7'h1) begin
          for (logic [6:0] j = 7'h0; j < 7'h60; j += 7'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// HellaCache.scala:322:25
          end	// HellaCache.scala:322:25
          Memory[i[5:0]] = _RANDOM_MEM[87:0];	// HellaCache.scala:322:25
        end	// HellaCache.scala:322:25
      `endif // RANDOMIZE_MEM_INIT
      `ifdef RANDOMIZE_REG_INIT	// HellaCache.scala:322:25
        _RANDOM = {`RANDOM};	// HellaCache.scala:322:25
        _R0_en_d0 = _RANDOM[0];	// HellaCache.scala:322:25
        _R0_addr_d0 = _RANDOM[6:1];	// HellaCache.scala:322:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = _R0_en_d0 ? Memory[_R0_addr_d0] : 88'bx;	// HellaCache.scala:322:25
endmodule

