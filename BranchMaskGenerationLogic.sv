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

module BranchMaskGenerationLogic(
  input         clock,
                reset,
                io_is_branch_0,
                io_is_branch_1,
                io_is_branch_2,
                io_is_branch_3,
                io_will_fire_0,
                io_will_fire_1,
                io_will_fire_2,
                io_will_fire_3,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b2_uop_br_mask,
  input         io_brupdate_b2_mispredict,
                io_flush_pipeline,
  output [4:0]  io_br_tag_0,
                io_br_tag_1,
                io_br_tag_2,
                io_br_tag_3,
  output [19:0] io_br_mask_0,
                io_br_mask_1,
                io_br_mask_2,
                io_br_mask_3,
  output        io_is_full_0,
                io_is_full_1,
                io_is_full_2,
                io_is_full_3
);

  reg  [19:0] branch_mask;	// decode.scala:741:28
  wire [19:0] tag_masks_0 =
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
                                                        ? (branch_mask[11]
                                                             ? (branch_mask[12]
                                                                  ? (branch_mask[13]
                                                                       ? (branch_mask[14]
                                                                            ? (branch_mask[15]
                                                                                 ? (branch_mask[16]
                                                                                      ? (branch_mask[17]
                                                                                           ? (branch_mask[18]
                                                                                                ? {~(branch_mask[19]),
                                                                                                   19'h0}
                                                                                                : 20'h40000)
                                                                                           : 20'h20000)
                                                                                      : 20'h10000)
                                                                                 : 20'h8000)
                                                                            : 20'h4000)
                                                                       : 20'h2000)
                                                                  : 20'h1000)
                                                             : 20'h800)
                                                        : 20'h400)
                                                   : 20'h200)
                                              : 20'h100)
                                         : 20'h80)
                                    : 20'h40)
                               : 20'h20)
                          : 20'h10)
                     : 20'h8)
                : 20'h4)
           : 20'h2)
      : 20'h1;	// decode.scala:741:28, :756:18, :759:{13,27,32}, :761:22
  wire [19:0] _GEN = {20{io_is_branch_0}} & tag_masks_0 | branch_mask;	// decode.scala:741:28, :759:32, :761:22, :766:24
  wire [19:0] tag_masks_1 =
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
                                                        ? (_GEN[11]
                                                             ? (_GEN[12]
                                                                  ? (_GEN[13]
                                                                       ? (_GEN[14]
                                                                            ? (_GEN[15]
                                                                                 ? (_GEN[16]
                                                                                      ? (_GEN[17]
                                                                                           ? (_GEN[18]
                                                                                                ? {~(_GEN[19]),
                                                                                                   19'h0}
                                                                                                : 20'h40000)
                                                                                           : 20'h20000)
                                                                                      : 20'h10000)
                                                                                 : 20'h8000)
                                                                            : 20'h4000)
                                                                       : 20'h2000)
                                                                  : 20'h1000)
                                                             : 20'h800)
                                                        : 20'h400)
                                                   : 20'h200)
                                              : 20'h100)
                                         : 20'h80)
                                    : 20'h40)
                               : 20'h20)
                          : 20'h10)
                     : 20'h8)
                : 20'h4)
           : 20'h2)
      : 20'h1;	// decode.scala:756:18, :759:{13,27,32}, :761:22, :766:24
  wire [19:0] _GEN_0 = {20{io_is_branch_1}} & tag_masks_1 | _GEN;	// decode.scala:759:32, :761:22, :766:24
  wire [19:0] tag_masks_2 =
    _GEN_0[0]
      ? (_GEN_0[1]
           ? (_GEN_0[2]
                ? (_GEN_0[3]
                     ? (_GEN_0[4]
                          ? (_GEN_0[5]
                               ? (_GEN_0[6]
                                    ? (_GEN_0[7]
                                         ? (_GEN_0[8]
                                              ? (_GEN_0[9]
                                                   ? (_GEN_0[10]
                                                        ? (_GEN_0[11]
                                                             ? (_GEN_0[12]
                                                                  ? (_GEN_0[13]
                                                                       ? (_GEN_0[14]
                                                                            ? (_GEN_0[15]
                                                                                 ? (_GEN_0[16]
                                                                                      ? (_GEN_0[17]
                                                                                           ? (_GEN_0[18]
                                                                                                ? {~(_GEN_0[19]),
                                                                                                   19'h0}
                                                                                                : 20'h40000)
                                                                                           : 20'h20000)
                                                                                      : 20'h10000)
                                                                                 : 20'h8000)
                                                                            : 20'h4000)
                                                                       : 20'h2000)
                                                                  : 20'h1000)
                                                             : 20'h800)
                                                        : 20'h400)
                                                   : 20'h200)
                                              : 20'h100)
                                         : 20'h80)
                                    : 20'h40)
                               : 20'h20)
                          : 20'h10)
                     : 20'h8)
                : 20'h4)
           : 20'h2)
      : 20'h1;	// decode.scala:756:18, :759:{13,27,32}, :761:22, :766:24
  wire [19:0] _GEN_1 = {20{io_is_branch_2}} & tag_masks_2 | _GEN_0;	// decode.scala:759:32, :761:22, :766:24
  wire [19:0] _GEN_2 = {20{io_will_fire_0}} & tag_masks_0 | branch_mask;	// decode.scala:741:28, :759:32, :761:22, :776:20
  wire [19:0] _GEN_3 = {20{io_will_fire_1}} & tag_masks_1 | _GEN_2;	// decode.scala:759:32, :761:22, :776:20
  wire [19:0] _GEN_4 = {20{io_will_fire_2}} & tag_masks_2 | _GEN_3;	// decode.scala:759:32, :761:22, :776:20
  always @(posedge clock) begin
    if (reset)
      branch_mask <= 20'h0;	// decode.scala:741:28
    else if (io_flush_pipeline)
      branch_mask <= 20'h0;	// decode.scala:741:28
    else
      branch_mask <=
        ({20{io_will_fire_3}}
         & (_GEN_1[0]
              ? (_GEN_1[1]
                   ? (_GEN_1[2]
                        ? (_GEN_1[3]
                             ? (_GEN_1[4]
                                  ? (_GEN_1[5]
                                       ? (_GEN_1[6]
                                            ? (_GEN_1[7]
                                                 ? (_GEN_1[8]
                                                      ? (_GEN_1[9]
                                                           ? (_GEN_1[10]
                                                                ? (_GEN_1[11]
                                                                     ? (_GEN_1[12]
                                                                          ? (_GEN_1[13]
                                                                               ? (_GEN_1[14]
                                                                                    ? (_GEN_1[15]
                                                                                         ? (_GEN_1[16]
                                                                                              ? (_GEN_1[17]
                                                                                                   ? (_GEN_1[18]
                                                                                                        ? {~(_GEN_1[19]),
                                                                                                           19'h0}
                                                                                                        : 20'h40000)
                                                                                                   : 20'h20000)
                                                                                              : 20'h10000)
                                                                                         : 20'h8000)
                                                                                    : 20'h4000)
                                                                               : 20'h2000)
                                                                          : 20'h1000)
                                                                     : 20'h800)
                                                                : 20'h400)
                                                           : 20'h200)
                                                      : 20'h100)
                                                 : 20'h80)
                                            : 20'h40)
                                       : 20'h20)
                                  : 20'h10)
                             : 20'h8)
                        : 20'h4)
                   : 20'h2)
              : 20'h1) | _GEN_4) & ~io_brupdate_b1_resolve_mask
        & (io_brupdate_b2_mispredict ? io_brupdate_b2_uop_br_mask : 20'hFFFFF);	// decode.scala:741:28, :751:41, :756:18, :759:{13,27,32}, :761:22, :766:24, :776:20, :785:19, :788:57, util.scala:89:23
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
        branch_mask = _RANDOM[/*Zero width*/ 1'b0][19:0];	// decode.scala:741:28
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
                                                        ? (branch_mask[11]
                                                             ? (branch_mask[12]
                                                                  ? (branch_mask[13]
                                                                       ? (branch_mask[14]
                                                                            ? (branch_mask[15]
                                                                                 ? (branch_mask[16]
                                                                                      ? (branch_mask[17]
                                                                                           ? (branch_mask[18]
                                                                                                ? (branch_mask[19]
                                                                                                     ? 5'h0
                                                                                                     : 5'h13)
                                                                                                : 5'h12)
                                                                                           : 5'h11)
                                                                                      : 5'h10)
                                                                                 : 5'hF)
                                                                            : 5'hE)
                                                                       : 5'hD)
                                                                  : 5'hC)
                                                             : 5'hB)
                                                        : 5'hA)
                                                   : 5'h9)
                                              : 5'h8)
                                         : 5'h7)
                                    : 5'h6)
                               : 5'h5)
                          : 5'h4)
                     : 5'h3)
                : 5'h2)
           : 5'h1)
      : 5'h0;	// decode.scala:741:28, :755:16, :759:{27,32}, :760:20
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
                                                        ? (_GEN[11]
                                                             ? (_GEN[12]
                                                                  ? (_GEN[13]
                                                                       ? (_GEN[14]
                                                                            ? (_GEN[15]
                                                                                 ? (_GEN[16]
                                                                                      ? (_GEN[17]
                                                                                           ? (_GEN[18]
                                                                                                ? (_GEN[19]
                                                                                                     ? 5'h0
                                                                                                     : 5'h13)
                                                                                                : 5'h12)
                                                                                           : 5'h11)
                                                                                      : 5'h10)
                                                                                 : 5'hF)
                                                                            : 5'hE)
                                                                       : 5'hD)
                                                                  : 5'hC)
                                                             : 5'hB)
                                                        : 5'hA)
                                                   : 5'h9)
                                              : 5'h8)
                                         : 5'h7)
                                    : 5'h6)
                               : 5'h5)
                          : 5'h4)
                     : 5'h3)
                : 5'h2)
           : 5'h1)
      : 5'h0;	// decode.scala:755:16, :759:{27,32}, :760:20, :766:24
  assign io_br_tag_2 =
    _GEN_0[0]
      ? (_GEN_0[1]
           ? (_GEN_0[2]
                ? (_GEN_0[3]
                     ? (_GEN_0[4]
                          ? (_GEN_0[5]
                               ? (_GEN_0[6]
                                    ? (_GEN_0[7]
                                         ? (_GEN_0[8]
                                              ? (_GEN_0[9]
                                                   ? (_GEN_0[10]
                                                        ? (_GEN_0[11]
                                                             ? (_GEN_0[12]
                                                                  ? (_GEN_0[13]
                                                                       ? (_GEN_0[14]
                                                                            ? (_GEN_0[15]
                                                                                 ? (_GEN_0[16]
                                                                                      ? (_GEN_0[17]
                                                                                           ? (_GEN_0[18]
                                                                                                ? (_GEN_0[19]
                                                                                                     ? 5'h0
                                                                                                     : 5'h13)
                                                                                                : 5'h12)
                                                                                           : 5'h11)
                                                                                      : 5'h10)
                                                                                 : 5'hF)
                                                                            : 5'hE)
                                                                       : 5'hD)
                                                                  : 5'hC)
                                                             : 5'hB)
                                                        : 5'hA)
                                                   : 5'h9)
                                              : 5'h8)
                                         : 5'h7)
                                    : 5'h6)
                               : 5'h5)
                          : 5'h4)
                     : 5'h3)
                : 5'h2)
           : 5'h1)
      : 5'h0;	// decode.scala:755:16, :759:{27,32}, :760:20, :766:24
  assign io_br_tag_3 =
    _GEN_1[0]
      ? (_GEN_1[1]
           ? (_GEN_1[2]
                ? (_GEN_1[3]
                     ? (_GEN_1[4]
                          ? (_GEN_1[5]
                               ? (_GEN_1[6]
                                    ? (_GEN_1[7]
                                         ? (_GEN_1[8]
                                              ? (_GEN_1[9]
                                                   ? (_GEN_1[10]
                                                        ? (_GEN_1[11]
                                                             ? (_GEN_1[12]
                                                                  ? (_GEN_1[13]
                                                                       ? (_GEN_1[14]
                                                                            ? (_GEN_1[15]
                                                                                 ? (_GEN_1[16]
                                                                                      ? (_GEN_1[17]
                                                                                           ? (_GEN_1[18]
                                                                                                ? (_GEN_1[19]
                                                                                                     ? 5'h0
                                                                                                     : 5'h13)
                                                                                                : 5'h12)
                                                                                           : 5'h11)
                                                                                      : 5'h10)
                                                                                 : 5'hF)
                                                                            : 5'hE)
                                                                       : 5'hD)
                                                                  : 5'hC)
                                                             : 5'hB)
                                                        : 5'hA)
                                                   : 5'h9)
                                              : 5'h8)
                                         : 5'h7)
                                    : 5'h6)
                               : 5'h5)
                          : 5'h4)
                     : 5'h3)
                : 5'h2)
           : 5'h1)
      : 5'h0;	// decode.scala:755:16, :759:{27,32}, :760:20, :766:24
  assign io_br_mask_0 = branch_mask & ~io_brupdate_b1_resolve_mask;	// decode.scala:741:28, util.scala:89:{21,23}
  assign io_br_mask_1 = _GEN_2 & ~io_brupdate_b1_resolve_mask;	// decode.scala:776:20, util.scala:89:{21,23}
  assign io_br_mask_2 = _GEN_3 & ~io_brupdate_b1_resolve_mask;	// decode.scala:776:20, util.scala:89:{21,23}
  assign io_br_mask_3 = _GEN_4 & ~io_brupdate_b1_resolve_mask;	// decode.scala:776:20, util.scala:89:{21,23}
  assign io_is_full_0 = (&branch_mask) & io_is_branch_0;	// decode.scala:741:28, :751:{37,63}
  assign io_is_full_1 = (&_GEN) & io_is_branch_1;	// decode.scala:751:{37,63}, :766:24
  assign io_is_full_2 = (&_GEN_0) & io_is_branch_2;	// decode.scala:751:{37,63}, :766:24
  assign io_is_full_3 = (&_GEN_1) & io_is_branch_3;	// decode.scala:751:{37,63}, :766:24
endmodule

