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

module NLPrefetcher(
  input         clock,
                reset,
                io_mshr_avail,
                io_req_val,
  input  [39:0] io_req_addr,
  input  [1:0]  io_req_coh_state,
  input         io_prefetch_ready,
  output        io_prefetch_valid,
  output [4:0]  io_prefetch_bits_uop_mem_cmd,
  output [39:0] io_prefetch_bits_addr
);

  reg         req_valid;	// prefetcher.scala:51:26
  reg  [39:0] req_addr;	// prefetcher.scala:52:22
  reg  [4:0]  req_cmd;	// prefetcher.scala:53:22
  wire        _io_prefetch_valid_output = req_valid & io_mshr_avail;	// prefetcher.scala:51:26, :65:45
  always @(posedge clock) begin
    automatic logic [39:0] _mshr_req_addr_T;	// prefetcher.scala:55:35
    automatic logic        _GEN;	// prefetcher.scala:57:20
    _mshr_req_addr_T = io_req_addr + 40'h40;	// prefetcher.scala:55:35
    _GEN =
      io_req_val
      & ({_mshr_req_addr_T[39:18], _mshr_req_addr_T[17:16] ^ 2'h2} == 24'h0
         | {_mshr_req_addr_T[39:29], _mshr_req_addr_T[28:12] ^ 17'h10000} == 28'h0
         | {_mshr_req_addr_T[39:32], _mshr_req_addr_T[31:28] ^ 4'h8} == 12'h0);	// Parameters.scala:137:{31,49,52,67}, :671:42, prefetcher.scala:55:35, :57:20
    if (reset)
      req_valid <= 1'h0;	// prefetcher.scala:51:26
    else
      req_valid <= _GEN | ~(io_prefetch_ready & _io_prefetch_valid_output) & req_valid;	// Decoupled.scala:40:37, prefetcher.scala:51:26, :57:{20,34}, :58:15, :61:36, :62:15, :65:45
    if (_GEN) begin	// prefetcher.scala:57:20
      req_addr <= _mshr_req_addr_T;	// prefetcher.scala:52:22, :55:35
      req_cmd <= {4'h1, io_req_coh_state[1]};	// Metadata.scala:19:53, prefetcher.scala:53:22, :60:15
    end
  end // always @(posedge)
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
        req_valid = _RANDOM[1'h0][0];	// prefetcher.scala:51:26
        req_addr = {_RANDOM[1'h0][31:1], _RANDOM[1'h1][8:0]};	// prefetcher.scala:51:26, :52:22
        req_cmd = _RANDOM[1'h1][13:9];	// prefetcher.scala:52:22, :53:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_prefetch_valid = _io_prefetch_valid_output;	// prefetcher.scala:65:45
  assign io_prefetch_bits_uop_mem_cmd = req_cmd;	// prefetcher.scala:53:22
  assign io_prefetch_bits_addr = req_addr;	// prefetcher.scala:52:22
endmodule

