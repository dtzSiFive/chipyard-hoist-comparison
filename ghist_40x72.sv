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
module ghist_40x72(	// fetch-target-queue.scala:144:43
  input  [5:0]  R0_addr,
  input         R0_en,
                R0_clk,
  input  [5:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [71:0] W0_data,
  output [71:0] R0_data
);

  reg [71:0] Memory[0:39];	// fetch-target-queue.scala:144:43
  reg        _R0_en_d0;	// fetch-target-queue.scala:144:43
  reg [5:0]  _R0_addr_d0;	// fetch-target-queue.scala:144:43
  always @(posedge R0_clk) begin	// fetch-target-queue.scala:144:43
    _R0_en_d0 <= R0_en;	// fetch-target-queue.scala:144:43
    _R0_addr_d0 <= R0_addr;	// fetch-target-queue.scala:144:43
  end // always @(posedge)
  always @(posedge W0_clk) begin	// fetch-target-queue.scala:144:43
    if (W0_en)	// fetch-target-queue.scala:144:43
      Memory[W0_addr] <= W0_data;	// fetch-target-queue.scala:144:43
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// fetch-target-queue.scala:144:43
    `ifdef RANDOMIZE_REG_INIT	// fetch-target-queue.scala:144:43
      reg [31:0] _RANDOM;	// fetch-target-queue.scala:144:43
    `endif // RANDOMIZE_REG_INIT
    reg [95:0] _RANDOM_MEM;	// fetch-target-queue.scala:144:43
    initial begin	// fetch-target-queue.scala:144:43
      `INIT_RANDOM_PROLOG_	// fetch-target-queue.scala:144:43
      `ifdef RANDOMIZE_MEM_INIT	// fetch-target-queue.scala:144:43
        for (logic [5:0] i = 6'h0; i < 6'h28; i += 6'h1) begin
          for (logic [6:0] j = 7'h0; j < 7'h60; j += 7'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// fetch-target-queue.scala:144:43
          end	// fetch-target-queue.scala:144:43
          Memory[i] = _RANDOM_MEM[71:0];	// fetch-target-queue.scala:144:43
        end	// fetch-target-queue.scala:144:43
      `endif // RANDOMIZE_MEM_INIT
      `ifdef RANDOMIZE_REG_INIT	// fetch-target-queue.scala:144:43
        _RANDOM = {`RANDOM};	// fetch-target-queue.scala:144:43
        _R0_en_d0 = _RANDOM[0];	// fetch-target-queue.scala:144:43
        _R0_addr_d0 = _RANDOM[6:1];	// fetch-target-queue.scala:144:43
      `endif // RANDOMIZE_REG_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = _R0_en_d0 ? Memory[_R0_addr_d0] : 72'bx;	// fetch-target-queue.scala:144:43
endmodule

