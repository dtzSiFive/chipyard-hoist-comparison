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

module Queue_65(
  input         clock,
                reset,
                io_enq_valid,
  input  [39:0] io_enq_bits_pc,
  input  [63:0] io_enq_bits_data,
  input  [3:0]  io_enq_bits_mask,
  input         io_enq_bits_xcpt_pf_inst,
                io_enq_bits_xcpt_ae_inst,
  input  [63:0] io_enq_bits_ghist_old_history,
  input         io_enq_bits_ghist_current_saw_branch_not_taken,
                io_enq_bits_ghist_new_saw_branch_not_taken,
                io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]  io_enq_bits_ghist_ras_idx,
  input  [1:0]  io_enq_bits_fsrc,
                io_enq_bits_tsrc,
  input         io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
  output [39:0] io_deq_bits_pc,
  output [63:0] io_deq_bits_data,
  output [3:0]  io_deq_bits_mask,
  output        io_deq_bits_xcpt_pf_inst,
                io_deq_bits_xcpt_ae_inst,
  output [63:0] io_deq_bits_ghist_old_history,
  output        io_deq_bits_ghist_current_saw_branch_not_taken,
                io_deq_bits_ghist_new_saw_branch_not_taken,
                io_deq_bits_ghist_new_saw_branch_taken,
  output [4:0]  io_deq_bits_ghist_ras_idx,
  output [1:0]  io_deq_bits_fsrc,
                io_deq_bits_tsrc
);

  reg  [185:0] ram;	// Decoupled.scala:218:16
  reg          full;	// Decoupled.scala:221:27
  wire         _io_enq_ready_output = io_deq_ready | ~full;	// Decoupled.scala:221:27, :241:{16,19}, :254:{25,40}
  always @(posedge clock) begin
    automatic logic do_enq;	// Decoupled.scala:40:37
    do_enq = _io_enq_ready_output & io_enq_valid;	// Decoupled.scala:40:37, :241:16, :254:{25,40}
    if (do_enq)	// Decoupled.scala:40:37
      ram <=
        {io_enq_bits_tsrc,
         io_enq_bits_fsrc,
         io_enq_bits_ghist_ras_idx,
         io_enq_bits_ghist_new_saw_branch_taken,
         io_enq_bits_ghist_new_saw_branch_not_taken,
         io_enq_bits_ghist_current_saw_branch_not_taken,
         io_enq_bits_ghist_old_history,
         io_enq_bits_xcpt_ae_inst,
         io_enq_bits_xcpt_pf_inst,
         io_enq_bits_mask,
         io_enq_bits_data,
         io_enq_bits_pc};	// Decoupled.scala:218:16
    if (reset)
      full <= 1'h0;	// Decoupled.scala:218:16, :221:27
    else if (do_enq != (io_deq_ready & full))	// Decoupled.scala:40:37, :221:27, :236:16
      full <= do_enq;	// Decoupled.scala:40:37, :221:27
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:5];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        ram =
          {_RANDOM[3'h0][31:1],
           _RANDOM[3'h1],
           _RANDOM[3'h2],
           _RANDOM[3'h3],
           _RANDOM[3'h4],
           _RANDOM[3'h5][26:0]};	// Decoupled.scala:218:16
        full = _RANDOM[3'h0][0];	// Decoupled.scala:218:16, :221:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = _io_enq_ready_output;	// Decoupled.scala:241:16, :254:{25,40}
  assign io_deq_valid = full;	// Decoupled.scala:221:27
  assign io_deq_bits_pc = ram[39:0];	// Decoupled.scala:218:16
  assign io_deq_bits_data = ram[103:40];	// Decoupled.scala:218:16
  assign io_deq_bits_mask = ram[107:104];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_pf_inst = ram[108];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_ae_inst = ram[109];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_old_history = ram[173:110];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_current_saw_branch_not_taken = ram[174];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_not_taken = ram[175];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_taken = ram[176];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_ras_idx = ram[181:177];	// Decoupled.scala:218:16
  assign io_deq_bits_fsrc = ram[183:182];	// Decoupled.scala:218:16
  assign io_deq_bits_tsrc = ram[185:184];	// Decoupled.scala:218:16
endmodule

