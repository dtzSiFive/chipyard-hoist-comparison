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

module BranchDecode(
  input  [31:0] io_inst,
  input  [39:0] io_pc,
  output        io_out_is_ret,
                io_out_is_call,
  output [39:0] io_out_target,
  output [2:0]  io_out_cfi_type,
  output        io_out_sfb_offset_valid,
  output [5:0]  io_out_sfb_offset_bits,
  output        io_out_shadowable
);

  wire [9:0]  _GEN = {io_inst[14:12], io_inst[6:0]};	// Decode.scala:14:65
  wire        bpd_csignals_0 =
    _GEN == 10'h63 | _GEN == 10'hE3 | _GEN == 10'h2E3 | _GEN == 10'h3E3 | _GEN == 10'h263
    | _GEN == 10'h363;	// Decode.scala:14:{65,121}, :15:30
  wire        bpd_csignals_1 = io_inst[6:0] == 7'h6F;	// Decode.scala:14:{65,121}
  wire        bpd_csignals_2 = _GEN == 10'h67;	// Decode.scala:14:{65,121}
  wire [15:0] _GEN_0 = {io_inst[31:26], io_inst[14:12], io_inst[6:0]};	// Decode.scala:14:65
  wire [16:0] _GEN_1 = {io_inst[31:25], io_inst[14:12], io_inst[6:0]};	// Decode.scala:14:65
  assign io_out_is_ret =
    bpd_csignals_2 & {io_inst[19:18], io_inst[16:15]} == 4'h1 & io_inst[11:7] == 5'h0;	// Decode.scala:14:121, consts.scala:326:38, decode.scala:685:65, :686:{51,72,90}
  assign io_out_is_call = (bpd_csignals_1 | bpd_csignals_2) & io_inst[11:7] == 5'h1;	// Decode.scala:14:121, consts.scala:326:38, decode.scala:685:{32,47,65}
  assign io_out_target =
    bpd_csignals_0
      ? io_pc + {{28{io_inst[31]}}, io_inst[7], io_inst[30:25], io_inst[11:8], 1'h0}
        & 40'hFFFFFFFFFE
      : io_pc + {{20{io_inst[31]}}, io_inst[19:12], io_inst[20], io_inst[30:21], 1'h0}
        & 40'hFFFFFFFFFE;	// Cat.scala:30:58, Decode.scala:15:30, consts.scala:337:{35,46,55,68}, :338:{17,42}, :343:{46,59}, :344:{17,42}, decode.scala:688:23
  assign io_out_cfi_type =
    bpd_csignals_2 ? 3'h3 : bpd_csignals_1 ? 3'h2 : {2'h0, bpd_csignals_0};	// Decode.scala:14:121, :15:30, decode.scala:691:8, :693:8, :695:8
  assign io_out_sfb_offset_valid =
    bpd_csignals_0 & ~(io_inst[31]) & (|{io_inst[7], io_inst[30:25], io_inst[11:8]})
    & {io_inst[7], io_inst[30:26]} == 6'h0;	// Cat.scala:30:58, Decode.scala:15:30, consts.scala:337:{35,46,55,68}, decode.scala:701:{42,68,76,90,117}
  assign io_out_sfb_offset_bits = {io_inst[25], io_inst[11:8], 1'h0};	// Decode.scala:15:30, consts.scala:337:68, decode.scala:702:27
  assign io_out_shadowable =
    (_GEN_0 == 16'h93 | _GEN_0 == 16'h293 | _GEN_0 == 16'h4293 | _GEN == 10'h1B
     | _GEN_1 == 17'h9B | _GEN_1 == 17'h829B | _GEN_1 == 17'h29B | _GEN_1 == 17'h3B
     | _GEN_1 == 17'h803B | _GEN_1 == 17'hBB | _GEN_1 == 17'h82BB | _GEN_1 == 17'h2BB
     | io_inst[6:0] == 7'h37 | _GEN == 10'h13 | _GEN == 10'h393 | _GEN == 10'h313
     | _GEN == 10'h213 | _GEN == 10'h113 | _GEN == 10'h193 | _GEN_1 == 17'hB3
     | _GEN_1 == 17'h33 | _GEN_1 == 17'h8033 | _GEN_1 == 17'h133 | _GEN_1 == 17'h1B3
     | _GEN_1 == 17'h3B3 | _GEN_1 == 17'h333 | _GEN_1 == 17'h233 | _GEN_1 == 17'h82B3
     | _GEN_1 == 17'h2B3)
    & ({io_inst[5], io_inst[2]} != 2'h2 | io_inst[19:15] == io_inst[11:7]
       | _GEN_1 == 17'h33 & io_inst[19:15] == 5'h0);	// Decode.scala:14:{65,121}, :15:30, consts.scala:326:38, :327:38, decode.scala:686:90, :703:41, :705:{22,42}, :706:{14,22,41}
endmodule

