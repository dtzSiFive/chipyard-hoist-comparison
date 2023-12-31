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

module BreakpointUnit_2(
  input         io_status_debug,
  input  [1:0]  io_status_prv,
  input         io_bp_0_control_action,
                io_bp_0_control_chain,
  input  [1:0]  io_bp_0_control_tmatch,
  input         io_bp_0_control_x,
                io_bp_0_control_w,
                io_bp_0_control_r,
  input  [32:0] io_bp_0_address,
                io_pc,
                io_ea,
  output        io_xcpt_if,
                io_xcpt_ld,
                io_xcpt_st,
                io_debug_if,
                io_debug_ld,
                io_debug_st
);

  wire [3:0]  _en_T_2 = 4'h8 >> io_status_prv;	// Breakpoint.scala:31:68, Cat.scala:30:58
  wire        en = ~io_status_debug & _en_T_2[0];	// Breakpoint.scala:31:{35,50,68}
  wire        _w_T_2 = io_ea >= io_bp_0_address;	// Breakpoint.scala:66:8
  wire [32:0] _w_T_5 = ~io_ea;	// Breakpoint.scala:63:6
  wire        r_lo_hi = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        r_hi_lo = r_lo_hi & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire [32:0] _x_T_11 = ~io_bp_0_address;	// Breakpoint.scala:63:24
  wire        r_lo_hi_1 = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        r_hi_lo_1 = r_lo_hi_1 & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire        w_lo_hi = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        w_hi_lo = w_lo_hi & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire        w_lo_hi_1 = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        w_hi_lo_1 = w_lo_hi_1 & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire [32:0] _x_T_5 = ~io_pc;	// Breakpoint.scala:63:6
  wire        x_lo_hi = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        x_hi_lo = x_lo_hi & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire        x_lo_hi_1 = io_bp_0_control_tmatch[0] & io_bp_0_address[0];	// Breakpoint.scala:60:{73,83}, :66:36
  wire        x_hi_lo_1 = x_lo_hi_1 & io_bp_0_address[1];	// Breakpoint.scala:60:{73,83}
  wire        _GEN =
    ~io_bp_0_control_chain & en & io_bp_0_control_r
    & (io_bp_0_control_tmatch[1]
         ? _w_T_2 ^ io_bp_0_control_tmatch[0]
         : {_w_T_5[32:4],
            _w_T_5[3:0]
              | {r_hi_lo & io_bp_0_address[2],
                 r_hi_lo,
                 r_lo_hi,
                 io_bp_0_control_tmatch[0]}} == {_x_T_11[32:4],
                                                 _x_T_11[3:0]
                                                   | {r_hi_lo_1 & io_bp_0_address[2],
                                                      r_hi_lo_1,
                                                      r_lo_hi_1,
                                                      io_bp_0_control_tmatch[0]}});	// Breakpoint.scala:31:50, :60:{73,83}, :63:{6,9,19,24,33}, :66:{8,20,36}, :69:{8,23}, :110:15, :119:15, Cat.scala:30:58
  wire        _GEN_0 =
    ~io_bp_0_control_chain & en & io_bp_0_control_w
    & (io_bp_0_control_tmatch[1]
         ? _w_T_2 ^ io_bp_0_control_tmatch[0]
         : {_w_T_5[32:4],
            _w_T_5[3:0]
              | {w_hi_lo & io_bp_0_address[2],
                 w_hi_lo,
                 w_lo_hi,
                 io_bp_0_control_tmatch[0]}} == {_x_T_11[32:4],
                                                 _x_T_11[3:0]
                                                   | {w_hi_lo_1 & io_bp_0_address[2],
                                                      w_hi_lo_1,
                                                      w_lo_hi_1,
                                                      io_bp_0_control_tmatch[0]}});	// Breakpoint.scala:31:50, :60:{73,83}, :63:{6,9,19,24,33}, :66:{8,20,36}, :69:{8,23}, :110:15, :120:15, Cat.scala:30:58
  wire        _GEN_1 =
    ~io_bp_0_control_chain & en & io_bp_0_control_x
    & (io_bp_0_control_tmatch[1]
         ? io_pc >= io_bp_0_address ^ io_bp_0_control_tmatch[0]
         : {_x_T_5[32:4],
            _x_T_5[3:0]
              | {x_hi_lo & io_bp_0_address[2],
                 x_hi_lo,
                 x_lo_hi,
                 io_bp_0_control_tmatch[0]}} == {_x_T_11[32:4],
                                                 _x_T_11[3:0]
                                                   | {x_hi_lo_1 & io_bp_0_address[2],
                                                      x_hi_lo_1,
                                                      x_lo_hi_1,
                                                      io_bp_0_control_tmatch[0]}});	// Breakpoint.scala:31:50, :60:{73,83}, :63:{6,9,19,24,33}, :66:{8,20,36}, :69:{8,23}, :110:15, :121:15, Cat.scala:30:58
  assign io_xcpt_if = _GEN_1 & ~io_bp_0_control_action;	// Breakpoint.scala:97:14, :121:{15,27,40,51}
  assign io_xcpt_ld = _GEN & ~io_bp_0_control_action;	// Breakpoint.scala:98:14, :119:{15,27,40,51}
  assign io_xcpt_st = _GEN_0 & ~io_bp_0_control_action;	// Breakpoint.scala:99:14, :120:{15,27,40,51}
  assign io_debug_if = _GEN_1 & io_bp_0_control_action;	// Breakpoint.scala:100:15, :121:{15,27,73}
  assign io_debug_ld = _GEN & io_bp_0_control_action;	// Breakpoint.scala:101:15, :119:{15,27,73}
  assign io_debug_st = _GEN_0 & io_bp_0_control_action;	// Breakpoint.scala:102:15, :120:{15,27,73}
endmodule

