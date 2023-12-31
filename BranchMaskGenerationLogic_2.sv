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

module BranchMaskGenerationLogic_2(
  input         clock,
                reset,
                io_is_branch_0,
                io_is_branch_1,
                io_will_fire_0,
                io_will_fire_1,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b2_uop_br_mask,
  input         io_brupdate_b2_mispredict,
                io_flush_pipeline,
  output [3:0]  io_br_tag_0,
                io_br_tag_1,
  output [11:0] io_br_mask_0,
                io_br_mask_1,
  output        io_is_full_0,
                io_is_full_1
);

  reg  [11:0] branch_mask;	// decode.scala:741:28
  wire [11:0] tag_masks_0 =
    branch_mask[0]
      ? (branch_mask[1]
           ? (branch_mask[2]
                ? (branch_mask[3]
                     ? (branch_mask[4]
                          ? (branch_mask[5]
                               ? (branch_mask[6]
                                    ? (branch_mask[7]
                                         ? (branch_mask[8]
                                              ? (branch_mask[9]
                                                   ? (branch_mask[10]
                                                        ? {~(branch_mask[11]), 11'h0}
                                                        : 12'h400)
                                                   : 12'h200)
                                              : 12'h100)
                                         : 12'h80)
                                    : 12'h40)
                               : 12'h20)
                          : 12'h10)
                     : 12'h8)
                : 12'h4)
           : 12'h2)
      : 12'h1;	// decode.scala:741:28, :756:18, :759:{13,27,32}, :761:22
  wire [11:0] _GEN = {12{io_is_branch_0}} & tag_masks_0 | branch_mask;	// decode.scala:741:28, :759:32, :761:22, :766:24
  wire [11:0] _GEN_0 = {12{io_will_fire_0}} & tag_masks_0 | branch_mask;	// decode.scala:741:28, :759:32, :761:22, :776:20
  always @(posedge clock) begin
    if (reset)
      branch_mask <= 12'h0;	// decode.scala:741:28
    else if (io_flush_pipeline)
      branch_mask <= 12'h0;	// decode.scala:741:28
    else
      branch_mask <=
        ({12{io_will_fire_1}}
         & (_GEN[0]
              ? (_GEN[1]
                   ? (_GEN[2]
                        ? (_GEN[3]
                             ? (_GEN[4]
                                  ? (_GEN[5]
                                       ? (_GEN[6]
                                            ? (_GEN[7]
                                                 ? (_GEN[8]
                                                      ? (_GEN[9]
                                                           ? (_GEN[10]
                                                                ? {~(_GEN[11]), 11'h0}
                                                                : 12'h400)
                                                           : 12'h200)
                                                      : 12'h100)
                                                 : 12'h80)
                                            : 12'h40)
                                       : 12'h20)
                                  : 12'h10)
                             : 12'h8)
                        : 12'h4)
                   : 12'h2)
              : 12'h1) | _GEN_0) & ~io_brupdate_b1_resolve_mask
        & (io_brupdate_b2_mispredict ? io_brupdate_b2_uop_br_mask : 12'hFFF);	// decode.scala:741:28, :751:41, :756:18, :759:{13,27,32}, :761:22, :766:24, :776:20, :785:19, :788:57, util.scala:89:23
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        branch_mask = _RANDOM[/*Zero width*/ 1'b0][11:0];	// decode.scala:741:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_br_tag_0 =
    branch_mask[0]
      ? (branch_mask[1]
           ? (branch_mask[2]
                ? (branch_mask[3]
                     ? (branch_mask[4]
                          ? (branch_mask[5]
                               ? (branch_mask[6]
                                    ? (branch_mask[7]
                                         ? (branch_mask[8]
                                              ? (branch_mask[9]
                                                   ? (branch_mask[10]
                                                        ? (branch_mask[11] ? 4'h0 : 4'hB)
                                                        : 4'hA)
                                                   : 4'h9)
                                              : 4'h8)
                                         : 4'h7)
                                    : 4'h6)
                               : 4'h5)
                          : 4'h4)
                     : 4'h3)
                : 4'h2)
           : 4'h1)
      : 4'h0;	// decode.scala:741:28, :755:16, :759:{27,32}, :760:20
  assign io_br_tag_1 =
    _GEN[0]
      ? (_GEN[1]
           ? (_GEN[2]
                ? (_GEN[3]
                     ? (_GEN[4]
                          ? (_GEN[5]
                               ? (_GEN[6]
                                    ? (_GEN[7]
                                         ? (_GEN[8]
                                              ? (_GEN[9]
                                                   ? (_GEN[10]
                                                        ? (_GEN[11] ? 4'h0 : 4'hB)
                                                        : 4'hA)
                                                   : 4'h9)
                                              : 4'h8)
                                         : 4'h7)
                                    : 4'h6)
                               : 4'h5)
                          : 4'h4)
                     : 4'h3)
                : 4'h2)
           : 4'h1)
      : 4'h0;	// decode.scala:755:16, :759:{27,32}, :760:20, :766:24
  assign io_br_mask_0 = branch_mask & ~io_brupdate_b1_resolve_mask;	// decode.scala:741:28, util.scala:89:{21,23}
  assign io_br_mask_1 = _GEN_0 & ~io_brupdate_b1_resolve_mask;	// decode.scala:776:20, util.scala:89:{21,23}
  assign io_is_full_0 = (&branch_mask) & io_is_branch_0;	// decode.scala:741:28, :751:{37,63}
  assign io_is_full_1 = (&_GEN) & io_is_branch_1;	// decode.scala:751:{37,63}, :766:24
endmodule

