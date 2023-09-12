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

module RVCExpander_3(
  input  [31:0] io_in,
  output [31:0] io_out_bits,
  output        io_rvc
);

  wire [2:0]      _io_out_s_funct_T = {io_in[12], io_in[6:5]};	// Cat.scala:30:58, RVC.scala:36:20, :43:30
  wire [2:0]      _io_out_s_funct_T_2 = {_io_out_s_funct_T == 3'h1, 2'h0};	// Cat.scala:30:58, package.scala:32:{76,86}
  wire [7:0][2:0] _GEN =
    {{3'h3},
     {3'h2},
     {3'h0},
     {3'h0},
     {3'h7},
     {3'h6},
     {_io_out_s_funct_T_2},
     {_io_out_s_funct_T_2}};	// Bitwise.scala:72:12, Cat.scala:30:58, package.scala:32:{76,86}
  wire [3:0]      _GEN_0 = {4{io_in[12]}};	// Cat.scala:30:58, RVC.scala:43:30
  wire [6:0]      io_out_s_lo_lo_10 = (|(io_in[11:7])) ? 7'h3 : 7'h1F;	// Cat.scala:30:58, RVC.scala:33:13, :53:20, :113:{23,27}
  wire [4:0]      _io_out_T = {io_in[1:0], io_in[15:13]};	// Cat.scala:30:58, RVC.scala:151:20, :163:20
  wire [31:0]     _io_out_T_40_bits =
    _io_out_T == 5'h14
      ? {7'h0,
         io_in[12]
           ? ((|(io_in[6:2]))
                ? {io_in[6:2], io_in[11:7], 3'h0, io_in[11:7], 7'h33}
                : (|(io_in[11:7]))
                    ? {io_in[6:2], io_in[11:7], 15'hE7}
                    : {io_in[6:3], 1'h1, io_in[11:7], 15'h73})
           : {io_in[6:2],
              (|(io_in[6:2]))
                ? {8'h0, io_in[11:7], 7'h33}
                : {io_in[11:7], (|(io_in[11:7])) ? 15'h67 : 15'h1F}}}
      : _io_out_T == 5'h13
          ? {3'h0,
             io_in[4:2],
             io_in[12],
             io_in[6:5],
             11'h13,
             io_in[11:7],
             io_out_s_lo_lo_10}
          : _io_out_T == 5'h12
              ? {4'h0,
                 io_in[3:2],
                 io_in[12],
                 io_in[6:4],
                 10'h12,
                 io_in[11:7],
                 io_out_s_lo_lo_10}
              : _io_out_T == 5'h11
                  ? {3'h0, io_in[4:2], io_in[12], io_in[6:5], 11'h13, io_in[11:7], 7'h7}
                  : _io_out_T == 5'h10
                      ? {6'h0,
                         io_in[12],
                         io_in[6:2],
                         io_in[11:7],
                         3'h1,
                         io_in[11:7],
                         7'h13}
                      : _io_out_T == 5'hF
                          ? {_GEN_0,
                             io_in[6:5],
                             io_in[2],
                             7'h1,
                             io_in[9:7],
                             3'h1,
                             io_in[11:10],
                             io_in[4:3],
                             io_in[12],
                             7'h63}
                          : _io_out_T == 5'hE
                              ? {_GEN_0,
                                 io_in[6:5],
                                 io_in[2],
                                 7'h1,
                                 io_in[9:7],
                                 3'h0,
                                 io_in[11:10],
                                 io_in[4:3],
                                 io_in[12],
                                 7'h63}
                              : _io_out_T == 5'hD
                                  ? {io_in[12],
                                     io_in[8],
                                     io_in[10:9],
                                     io_in[6],
                                     io_in[7],
                                     io_in[2],
                                     io_in[11],
                                     io_in[5:3],
                                     {9{io_in[12]}},
                                     12'h6F}
                                  : _io_out_T == 5'hC
                                      ? ((&(io_in[11:10]))
                                           ? {1'h0,
                                              io_in[6:5] == 2'h0,
                                              7'h1,
                                              io_in[4:2],
                                              2'h1,
                                              io_in[9:7],
                                              _GEN[_io_out_s_funct_T],
                                              2'h1,
                                              io_in[9:7],
                                              3'h3,
                                              io_in[12],
                                              3'h3}
                                           : {io_in[11:10] == 2'h2
                                                ? {{7{io_in[12]}},
                                                   io_in[6:2],
                                                   2'h1,
                                                   io_in[9:7],
                                                   5'h1D}
                                                : {1'h0,
                                                   io_in[11:10] == 2'h1,
                                                   4'h0,
                                                   io_in[12],
                                                   io_in[6:2],
                                                   2'h1,
                                                   io_in[9:7],
                                                   5'h15},
                                              io_in[9:7],
                                              7'h13})
                                      : _io_out_T == 5'hB
                                          ? {{3{io_in[12]}},
                                             io_in[11:7] == 5'h0 | io_in[11:7] == 5'h2
                                               ? {io_in[4:3],
                                                  io_in[5],
                                                  io_in[2],
                                                  io_in[6],
                                                  4'h0,
                                                  io_in[11:7],
                                                  3'h0,
                                                  io_in[11:7],
                                                  (|{{7{io_in[12]}}, io_in[6:2]})
                                                    ? 7'h13
                                                    : 7'h1F}
                                               : {{12{io_in[12]}},
                                                  io_in[6:2],
                                                  io_in[11:7],
                                                  3'h3,
                                                  {{7{io_in[12]}}, io_in[6:2]} == 12'h0,
                                                  3'h7}}
                                          : _io_out_T == 5'hA
                                              ? {{7{io_in[12]}},
                                                 io_in[6:2],
                                                 8'h0,
                                                 io_in[11:7],
                                                 7'h13}
                                              : _io_out_T == 5'h9
                                                  ? {{7{io_in[12]}},
                                                     io_in[6:2],
                                                     io_in[11:7],
                                                     3'h0,
                                                     io_in[11:7],
                                                     4'h3,
                                                     io_in[11:7] == 5'h0,
                                                     2'h3}
                                                  : _io_out_T == 5'h8
                                                      ? {{7{io_in[12]}},
                                                         io_in[6:2],
                                                         io_in[11:7],
                                                         3'h0,
                                                         io_in[11:7],
                                                         7'h13}
                                                      : _io_out_T == 5'h7
                                                          ? {4'h0,
                                                             io_in[6:5],
                                                             io_in[12],
                                                             2'h1,
                                                             io_in[4:2],
                                                             2'h1,
                                                             io_in[9:7],
                                                             3'h3,
                                                             io_in[11:10],
                                                             10'h23}
                                                          : _io_out_T == 5'h6
                                                              ? {5'h0,
                                                                 io_in[5],
                                                                 io_in[12],
                                                                 2'h1,
                                                                 io_in[4:2],
                                                                 2'h1,
                                                                 io_in[9:7],
                                                                 3'h2,
                                                                 io_in[11:10],
                                                                 io_in[6],
                                                                 9'h23}
                                                              : _io_out_T == 5'h5
                                                                  ? {4'h0,
                                                                     io_in[6:5],
                                                                     io_in[12],
                                                                     2'h1,
                                                                     io_in[4:2],
                                                                     2'h1,
                                                                     io_in[9:7],
                                                                     3'h3,
                                                                     io_in[11:10],
                                                                     10'h27}
                                                                  : _io_out_T == 5'h4
                                                                      ? {5'h0,
                                                                         io_in[5],
                                                                         io_in[12],
                                                                         2'h1,
                                                                         io_in[4:2],
                                                                         2'h1,
                                                                         io_in[9:7],
                                                                         3'h2,
                                                                         io_in[11:10],
                                                                         io_in[6],
                                                                         9'h3F}
                                                                      : _io_out_T == 5'h3
                                                                          ? {4'h0,
                                                                             io_in[6:5],
                                                                             io_in[12:10],
                                                                             5'h1,
                                                                             io_in[9:7],
                                                                             5'hD,
                                                                             io_in[4:2],
                                                                             7'h3}
                                                                          : _io_out_T == 5'h2
                                                                              ? {5'h0,
                                                                                 io_in[5],
                                                                                 io_in[12:10],
                                                                                 io_in[6],
                                                                                 4'h1,
                                                                                 io_in[9:7],
                                                                                 5'h9,
                                                                                 io_in[4:2],
                                                                                 7'h3}
                                                                              : _io_out_T == 5'h1
                                                                                  ? {4'h0,
                                                                                     io_in[6:5],
                                                                                     io_in[12:10],
                                                                                     5'h1,
                                                                                     io_in[9:7],
                                                                                     5'hD,
                                                                                     io_in[4:2],
                                                                                     7'h7}
                                                                                  : {2'h0,
                                                                                     io_in[10:7],
                                                                                     io_in[12:11],
                                                                                     io_in[5],
                                                                                     io_in[6],
                                                                                     12'h41,
                                                                                     io_in[4:2],
                                                                                     (|(io_in[12:5]))
                                                                                       ? 7'h13
                                                                                       : 7'h1F};	// Bitwise.scala:72:12, Cat.scala:30:58, RVC.scala:22:14, :30:29, :31:29, :33:13, :34:{26,35,45,51}, :36:{20,28}, :37:{22,37}, :42:{42,56}, :43:{30,38}, :44:{36,42,57,69,76}, :53:{20,22,29}, :63:{32,65}, :77:{20,24}, :86:{20,29}, :90:29, :92:{10,14,21,27}, :103:30, :104:22, :105:43, :107:42, :113:23, :134:{33,37}, :135:{22,27}, :137:46, :138:{33,37}, :139:{25,30}, :140:10, :163:26, package.scala:32:{76,86}
  assign io_out_bits =
    (&_io_out_T) | _io_out_T == 5'h1E | _io_out_T == 5'h1D | _io_out_T == 5'h1C
    | _io_out_T == 5'h1B | _io_out_T == 5'h1A | _io_out_T == 5'h19 | _io_out_T == 5'h18
      ? io_in
      : _io_out_T == 5'h17
          ? {3'h0, io_in[9:7], io_in[12], io_in[6:2], 8'h13, io_in[11:10], 10'h23}
          : _io_out_T == 5'h16
              ? {4'h0, io_in[8:7], io_in[12], io_in[6:2], 8'h12, io_in[11:9], 9'h23}
              : _io_out_T == 5'h15
                  ? {3'h0, io_in[9:7], io_in[12], io_in[6:2], 8'h13, io_in[11:10], 10'h27}
                  : _io_out_T_40_bits;	// Cat.scala:30:58, RVC.scala:22:14, :30:29, :39:22, :43:38, :63:{32,65}, :123:65, package.scala:32:{76,86}
  assign io_rvc = io_in[1:0] != 2'h3;	// RVC.scala:163:{20,26}
endmodule

