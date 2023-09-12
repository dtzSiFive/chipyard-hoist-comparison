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

module PMPChecker_9(
  input  [1:0]  io_prv,
  input         io_pmp_0_cfg_l,
  input  [1:0]  io_pmp_0_cfg_a,
  input         io_pmp_0_cfg_x,
                io_pmp_0_cfg_w,
                io_pmp_0_cfg_r,
  input  [29:0] io_pmp_0_addr,
  input  [31:0] io_pmp_0_mask,
  input         io_pmp_1_cfg_l,
  input  [1:0]  io_pmp_1_cfg_a,
  input         io_pmp_1_cfg_x,
                io_pmp_1_cfg_w,
                io_pmp_1_cfg_r,
  input  [29:0] io_pmp_1_addr,
  input  [31:0] io_pmp_1_mask,
  input         io_pmp_2_cfg_l,
  input  [1:0]  io_pmp_2_cfg_a,
  input         io_pmp_2_cfg_x,
                io_pmp_2_cfg_w,
                io_pmp_2_cfg_r,
  input  [29:0] io_pmp_2_addr,
  input  [31:0] io_pmp_2_mask,
  input         io_pmp_3_cfg_l,
  input  [1:0]  io_pmp_3_cfg_a,
  input         io_pmp_3_cfg_x,
                io_pmp_3_cfg_w,
                io_pmp_3_cfg_r,
  input  [29:0] io_pmp_3_addr,
  input  [31:0] io_pmp_3_mask,
  input         io_pmp_4_cfg_l,
  input  [1:0]  io_pmp_4_cfg_a,
  input         io_pmp_4_cfg_x,
                io_pmp_4_cfg_w,
                io_pmp_4_cfg_r,
  input  [29:0] io_pmp_4_addr,
  input  [31:0] io_pmp_4_mask,
  input         io_pmp_5_cfg_l,
  input  [1:0]  io_pmp_5_cfg_a,
  input         io_pmp_5_cfg_x,
                io_pmp_5_cfg_w,
                io_pmp_5_cfg_r,
  input  [29:0] io_pmp_5_addr,
  input  [31:0] io_pmp_5_mask,
  input         io_pmp_6_cfg_l,
  input  [1:0]  io_pmp_6_cfg_a,
  input         io_pmp_6_cfg_x,
                io_pmp_6_cfg_w,
                io_pmp_6_cfg_r,
  input  [29:0] io_pmp_6_addr,
  input  [31:0] io_pmp_6_mask,
  input         io_pmp_7_cfg_l,
  input  [1:0]  io_pmp_7_cfg_a,
  input         io_pmp_7_cfg_x,
                io_pmp_7_cfg_w,
                io_pmp_7_cfg_r,
  input  [29:0] io_pmp_7_addr,
  input  [31:0] io_pmp_7_mask,
                io_addr,
  output        io_r,
                io_w,
                io_x
);

  wire res_hit =
    io_pmp_7_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_7_addr[29:2]) & ~(io_pmp_7_mask[31:4])) == 28'h0
      : io_pmp_7_cfg_a[0] & io_addr[31:4] >= io_pmp_6_addr[29:2]
        & (io_addr[31:4] < io_pmp_7_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_7_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_7_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :134:{8,61}
  wire res_ignore = io_prv[1] & ~io_pmp_7_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned =
    io_pmp_7_cfg_a[1]
      ? (&(io_pmp_7_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0
          & (|(io_pmp_6_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_7_addr[29:2]) == 28'h0 & (|(io_pmp_7_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :84:64, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_1 =
    io_pmp_6_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_6_addr[29:2]) & ~(io_pmp_6_mask[31:4])) == 28'h0
      : io_pmp_6_cfg_a[0] & io_addr[31:4] >= io_pmp_5_addr[29:2]
        & (io_addr[31:4] < io_pmp_6_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_6_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_1 = io_prv[1] & ~io_pmp_6_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_1 =
    io_pmp_6_cfg_a[1]
      ? (&(io_pmp_6_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0
          & (|(io_pmp_5_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_6_addr[29:2]) == 28'h0 & (|(io_pmp_6_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_2 =
    io_pmp_5_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_5_addr[29:2]) & ~(io_pmp_5_mask[31:4])) == 28'h0
      : io_pmp_5_cfg_a[0] & io_addr[31:4] >= io_pmp_4_addr[29:2]
        & (io_addr[31:4] < io_pmp_5_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_5_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_2 = io_prv[1] & ~io_pmp_5_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_2 =
    io_pmp_5_cfg_a[1]
      ? (&(io_pmp_5_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0
          & (|(io_pmp_4_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_5_addr[29:2]) == 28'h0 & (|(io_pmp_5_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_3 =
    io_pmp_4_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_4_addr[29:2]) & ~(io_pmp_4_mask[31:4])) == 28'h0
      : io_pmp_4_cfg_a[0] & io_addr[31:4] >= io_pmp_3_addr[29:2]
        & (io_addr[31:4] < io_pmp_4_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_4_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_3 = io_prv[1] & ~io_pmp_4_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_3 =
    io_pmp_4_cfg_a[1]
      ? (&(io_pmp_4_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0
          & (|(io_pmp_3_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_4_addr[29:2]) == 28'h0 & (|(io_pmp_4_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_4 =
    io_pmp_3_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_3_addr[29:2]) & ~(io_pmp_3_mask[31:4])) == 28'h0
      : io_pmp_3_cfg_a[0] & io_addr[31:4] >= io_pmp_2_addr[29:2]
        & (io_addr[31:4] < io_pmp_3_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_3_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_4 = io_prv[1] & ~io_pmp_3_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_4 =
    io_pmp_3_cfg_a[1]
      ? (&(io_pmp_3_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0
          & (|(io_pmp_2_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_3_addr[29:2]) == 28'h0 & (|(io_pmp_3_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_5 =
    io_pmp_2_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_2_addr[29:2]) & ~(io_pmp_2_mask[31:4])) == 28'h0
      : io_pmp_2_cfg_a[0] & io_addr[31:4] >= io_pmp_1_addr[29:2]
        & (io_addr[31:4] < io_pmp_2_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_2_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_5 = io_prv[1] & ~io_pmp_2_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_5 =
    io_pmp_2_cfg_a[1]
      ? (&(io_pmp_2_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0
          & (|(io_pmp_1_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_2_addr[29:2]) == 28'h0 & (|(io_pmp_2_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_6 =
    io_pmp_1_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_1_addr[29:2]) & ~(io_pmp_1_mask[31:4])) == 28'h0
      : io_pmp_1_cfg_a[0] & io_addr[31:4] >= io_pmp_0_addr[29:2]
        & (io_addr[31:4] < io_pmp_1_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_1_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_6 = io_prv[1] & ~io_pmp_1_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_6 =
    io_pmp_1_cfg_a[1]
      ? (&(io_pmp_1_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0
          & (|(io_pmp_0_addr[1:0] & ~(io_addr[3:2])))
          | (io_addr[31:4] ^ io_pmp_1_addr[29:2]) == 28'h0 & (|(io_pmp_1_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :72:28, :125:{49,67,82,88,106,123,125,145}, :126:{49,62,77,83,146}, :127:{24,46}, :128:{39,57}, :129:8
  wire res_hit_7 =
    io_pmp_0_cfg_a[1]
      ? ((io_addr[31:4] ^ io_pmp_0_addr[29:2]) & ~(io_pmp_0_mask[31:4])) == 28'h0
      : io_pmp_0_cfg_a[0]
        & (io_addr[31:4] < io_pmp_0_addr[29:2]
           | (io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0
           & io_addr[3:0] < {io_pmp_0_addr[1:0], 2'h0});	// PMP.scala:47:20, :48:26, :62:36, :65:{47,52,54,58}, :71:{29,53,72}, :72:28, :82:{39,52}, :83:{41,54,69}, :84:{53,64}, :85:{16,30}, :125:106, :134:{8,61}
  wire res_ignore_7 = io_prv[1] & ~io_pmp_0_cfg_l;	// PMP.scala:157:56, :165:{26,29}
  wire res_aligned_7 =
    io_pmp_0_cfg_a[1]
      ? (&(io_pmp_0_mask[3:0]))
      : ~((io_addr[31:4] ^ io_pmp_0_addr[29:2]) == 28'h0 & (|(io_pmp_0_addr[1:0])));	// PMP.scala:47:20, :65:58, :71:29, :125:106, :126:{49,62,77,83,146}, :127:24, :128:{39,57}, :129:8
  assign io_r =
    res_hit_7
      ? res_aligned_7 & (io_pmp_0_cfg_r | res_ignore_7)
      : res_hit_6
          ? res_aligned_6 & (io_pmp_1_cfg_r | res_ignore_6)
          : res_hit_5
              ? res_aligned_5 & (io_pmp_2_cfg_r | res_ignore_5)
              : res_hit_4
                  ? res_aligned_4 & (io_pmp_3_cfg_r | res_ignore_4)
                  : res_hit_3
                      ? res_aligned_3 & (io_pmp_4_cfg_r | res_ignore_3)
                      : res_hit_2
                          ? res_aligned_2 & (io_pmp_5_cfg_r | res_ignore_2)
                          : res_hit_1
                              ? res_aligned_1 & (io_pmp_6_cfg_r | res_ignore_1)
                              : res_hit
                                  ? res_aligned & (io_pmp_7_cfg_r | res_ignore)
                                  : io_prv[1];	// PMP.scala:129:8, :134:8, :157:56, :165:26, :183:{26,40}, :186:8
  assign io_w =
    res_hit_7
      ? res_aligned_7 & (io_pmp_0_cfg_w | res_ignore_7)
      : res_hit_6
          ? res_aligned_6 & (io_pmp_1_cfg_w | res_ignore_6)
          : res_hit_5
              ? res_aligned_5 & (io_pmp_2_cfg_w | res_ignore_5)
              : res_hit_4
                  ? res_aligned_4 & (io_pmp_3_cfg_w | res_ignore_4)
                  : res_hit_3
                      ? res_aligned_3 & (io_pmp_4_cfg_w | res_ignore_3)
                      : res_hit_2
                          ? res_aligned_2 & (io_pmp_5_cfg_w | res_ignore_2)
                          : res_hit_1
                              ? res_aligned_1 & (io_pmp_6_cfg_w | res_ignore_1)
                              : res_hit
                                  ? res_aligned & (io_pmp_7_cfg_w | res_ignore)
                                  : io_prv[1];	// PMP.scala:129:8, :134:8, :157:56, :165:26, :184:{26,40}, :186:8
  assign io_x =
    res_hit_7
      ? res_aligned_7 & (io_pmp_0_cfg_x | res_ignore_7)
      : res_hit_6
          ? res_aligned_6 & (io_pmp_1_cfg_x | res_ignore_6)
          : res_hit_5
              ? res_aligned_5 & (io_pmp_2_cfg_x | res_ignore_5)
              : res_hit_4
                  ? res_aligned_4 & (io_pmp_3_cfg_x | res_ignore_4)
                  : res_hit_3
                      ? res_aligned_3 & (io_pmp_4_cfg_x | res_ignore_3)
                      : res_hit_2
                          ? res_aligned_2 & (io_pmp_5_cfg_x | res_ignore_2)
                          : res_hit_1
                              ? res_aligned_1 & (io_pmp_6_cfg_x | res_ignore_1)
                              : res_hit
                                  ? res_aligned & (io_pmp_7_cfg_x | res_ignore)
                                  : io_prv[1];	// PMP.scala:129:8, :134:8, :157:56, :165:26, :185:{26,40}, :186:8
endmodule

