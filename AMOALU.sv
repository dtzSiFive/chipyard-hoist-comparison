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

module AMOALU(
  input  [7:0]  io_mask,
  input  [4:0]  io_cmd,
  input  [63:0] io_lhs,
                io_rhs,
  output [63:0] io_out
);

  wire        _logic_xor_T_1 = io_cmd == 5'hA;	// AMOALU.scala:67:26
  wire        logic_and = _logic_xor_T_1 | io_cmd == 5'hB;	// AMOALU.scala:67:{26,38,48}
  wire        logic_xor = io_cmd == 5'h9 | _logic_xor_T_1;	// AMOALU.scala:67:26, :68:{26,39}
  wire [63:0] adder_out_mask = {32'hFFFFFFFF, io_mask[3], 31'h7FFFFFFF};	// AMOALU.scala:72:{16,71,98}
  wire [63:0] wmask =
    {{8{io_mask[7]}},
     {8{io_mask[6]}},
     {8{io_mask[5]}},
     {8{io_mask[4]}},
     {8{io_mask[3]}},
     {8{io_mask[2]}},
     {8{io_mask[1]}},
     {8{io_mask[0]}}};	// AMOALU.scala:72:71, :91:49, Bitwise.scala:26:51, :72:12, Cat.scala:30:58
  assign io_out =
    wmask
    & (io_cmd == 5'h8
         ? (io_lhs & adder_out_mask) + (io_rhs & adder_out_mask)
         : logic_and | logic_xor
             ? (logic_and ? io_lhs & io_rhs : 64'h0)
               | (logic_xor ? io_lhs ^ io_rhs : 64'h0)
             : ((io_mask[4]
                   ? (io_lhs[63] == io_rhs[63]
                        ? io_lhs[63:32] < io_rhs[63:32] | io_lhs[63:32] == io_rhs[63:32]
                          & io_lhs[31:0] < io_rhs[31:0]
                        : io_cmd[1] ? io_rhs[63] : io_lhs[63])
                   : io_lhs[31] == io_rhs[31]
                       ? io_lhs[31:0] < io_rhs[31:0]
                       : io_cmd[1] ? io_rhs[31] : io_lhs[31])
                  ? io_cmd == 5'hC | io_cmd == 5'hE
                  : io_cmd == 5'hD | io_cmd == 5'hF)
                 ? io_lhs
                 : io_rhs) | ~wmask & io_lhs;	// AMOALU.scala:64:{20,33,43}, :65:{20,33,43}, :66:20, :67:38, :68:39, :72:98, :73:{13,21,31}, :79:{26,35,38}, :80:{13,24,27,38,53,69}, :86:17, :88:{10,12,18,23,58}, :91:49, :94:{19,23}, :96:{8,27,42}, :97:{8,27}, :99:8, :100:{8,19}, :104:{19,25,27,34}, Cat.scala:30:58, Mux.scala:47:69
endmodule

