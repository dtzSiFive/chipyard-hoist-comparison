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

module TLB_4(
  input  [33:0] io_req_bits_vaddr,
  input  [1:0]  io_req_bits_size,
  input  [4:0]  io_req_bits_cmd,
  input         io_ptw_status_debug,
  input  [1:0]  io_ptw_status_dprv,
  input         io_ptw_status_mxr,
                io_ptw_status_sum,
                io_ptw_pmp_0_cfg_l,
  input  [1:0]  io_ptw_pmp_0_cfg_a,
  input         io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  input  [29:0] io_ptw_pmp_0_addr,
  input  [31:0] io_ptw_pmp_0_mask,
  input         io_ptw_pmp_1_cfg_l,
  input  [1:0]  io_ptw_pmp_1_cfg_a,
  input         io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  input  [29:0] io_ptw_pmp_1_addr,
  input  [31:0] io_ptw_pmp_1_mask,
  input         io_ptw_pmp_2_cfg_l,
  input  [1:0]  io_ptw_pmp_2_cfg_a,
  input         io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  input  [29:0] io_ptw_pmp_2_addr,
  input  [31:0] io_ptw_pmp_2_mask,
  input         io_ptw_pmp_3_cfg_l,
  input  [1:0]  io_ptw_pmp_3_cfg_a,
  input         io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  input  [29:0] io_ptw_pmp_3_addr,
  input  [31:0] io_ptw_pmp_3_mask,
  input         io_ptw_pmp_4_cfg_l,
  input  [1:0]  io_ptw_pmp_4_cfg_a,
  input         io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  input  [29:0] io_ptw_pmp_4_addr,
  input  [31:0] io_ptw_pmp_4_mask,
  input         io_ptw_pmp_5_cfg_l,
  input  [1:0]  io_ptw_pmp_5_cfg_a,
  input         io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  input  [29:0] io_ptw_pmp_5_addr,
  input  [31:0] io_ptw_pmp_5_mask,
  input         io_ptw_pmp_6_cfg_l,
  input  [1:0]  io_ptw_pmp_6_cfg_a,
  input         io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  input  [29:0] io_ptw_pmp_6_addr,
  input  [31:0] io_ptw_pmp_6_mask,
  input         io_ptw_pmp_7_cfg_l,
  input  [1:0]  io_ptw_pmp_7_cfg_a,
  input         io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  input  [29:0] io_ptw_pmp_7_addr,
  input  [31:0] io_ptw_pmp_7_mask,
  output        io_req_ready,
  output [31:0] io_resp_paddr,
  output        io_resp_pf_ld,
                io_resp_pf_st,
                io_resp_ae_ld,
                io_resp_ae_st,
                io_resp_ma_ld,
                io_resp_ma_st,
                io_resp_cacheable,
                io_resp_must_alloc,
                io_ptw_req_valid,
  output [20:0] io_ptw_req_bits_bits_addr
);

  wire        _pmp_io_r;	// TLB.scala:193:19
  wire        _pmp_io_w;	// TLB.scala:193:19
  wire [13:0] _GEN = io_req_bits_vaddr[25:12] ^ 14'h2010;	// Parameters.scala:137:31
  wire [9:0]  _GEN_0 = io_req_bits_vaddr[25:16] ^ 10'h200;	// Parameters.scala:137:31
  wire [3:0]  _GEN_1 = io_req_bits_vaddr[31:28] ^ 4'h8;	// Parameters.scala:137:31, TLB.scala:194:15
  wire [16:0] _GEN_2 = io_req_bits_vaddr[28:12] ^ 17'h10000;	// Parameters.scala:137:{31,52}
  wire        legal_address =
    {io_req_bits_vaddr[33:14], ~(io_req_bits_vaddr[13:12])} == 22'h0
    | {io_req_bits_vaddr[33:26], _GEN} == 22'h0
    | {io_req_bits_vaddr[33:15], io_req_bits_vaddr[14:12] ^ 3'h4} == 22'h0
    | {io_req_bits_vaddr[33:31], io_req_bits_vaddr[30:12] ^ 19'h54000} == 22'h0
    | {io_req_bits_vaddr[33:21], io_req_bits_vaddr[20:12] ^ 9'h100} == 22'h0
    | {io_req_bits_vaddr[33:28], ~(io_req_bits_vaddr[27:26])} == 8'h0
    | {io_req_bits_vaddr[33:26], _GEN_0} == 18'h0 | ~(|(io_req_bits_vaddr[33:12]))
    | {io_req_bits_vaddr[33:17], ~(io_req_bits_vaddr[16])} == 18'h0
    | {io_req_bits_vaddr[33:32], _GEN_1} == 6'h0
    | {io_req_bits_vaddr[33:29], _GEN_2} == 22'h0
    | {io_req_bits_vaddr[33:18], io_req_bits_vaddr[17:16] ^ 2'h2} == 18'h0;	// Cat.scala:30:58, Parameters.scala:137:{31,49,52,67}, TLB.scala:198:67
  wire [3:0]  _GEN_3 = io_req_bits_vaddr[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire [1:0]  _GEN_4 = {_GEN_1[3], io_req_bits_vaddr[28]};	// Parameters.scala:137:{31,49,52}
  wire        cacheable =
    legal_address
    & ({io_req_bits_vaddr[31], _GEN_2[16], io_req_bits_vaddr[26:25]} == 4'h0
       | ~(|_GEN_4));	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:198:67, :200:19, :283:69
  wire        deny_access_to_debug =
    ~io_ptw_status_debug & ~(|(io_req_bits_vaddr[33:12]));	// Parameters.scala:137:{49,52,67}, TLB.scala:203:{39,48}
  wire [5:0]  _GEN_5 =
    {io_req_bits_vaddr[31],
     io_req_bits_vaddr[28:27],
     io_req_bits_vaddr[25],
     io_req_bits_vaddr[17:16]};	// Parameters.scala:137:{31,49,52}
  wire [5:0]  _GEN_6 =
    {io_req_bits_vaddr[31],
     io_req_bits_vaddr[28:27],
     _GEN_0[9],
     io_req_bits_vaddr[20],
     io_req_bits_vaddr[17]};	// Parameters.scala:137:{31,49,52}
  wire [2:0]  _GEN_7 =
    {io_req_bits_vaddr[31], io_req_bits_vaddr[28], ~(io_req_bits_vaddr[27])};	// Parameters.scala:137:{31,49,52}
  wire [6:0]  _GEN_8 =
    {io_req_bits_vaddr[31],
     _GEN_2[16:15],
     io_req_bits_vaddr[25],
     io_req_bits_vaddr[20],
     io_req_bits_vaddr[17:16]};	// Parameters.scala:137:{31,49,52}
  wire        prot_pp =
    legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire        prot_al =
    legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire        prot_aa =
    legal_address & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire        prot_eff =
    legal_address
    & ({io_req_bits_vaddr[31],
        io_req_bits_vaddr[28],
        io_req_bits_vaddr[26:25],
        io_req_bits_vaddr[17:16],
        io_req_bits_vaddr[13]} == 7'h0
       | {io_req_bits_vaddr[31],
          io_req_bits_vaddr[28],
          io_req_bits_vaddr[26],
          _GEN_0[9],
          io_req_bits_vaddr[20],
          io_req_bits_vaddr[17:16]} == 7'h0
       | {io_req_bits_vaddr[31],
          io_req_bits_vaddr[28],
          io_req_bits_vaddr[26],
          _GEN[13],
          io_req_bits_vaddr[20],
          _GEN[5:4],
          io_req_bits_vaddr[13]} == 8'h0
       | {io_req_bits_vaddr[31], io_req_bits_vaddr[28], ~(io_req_bits_vaddr[26])} == 3'h0
       | {io_req_bits_vaddr[31],
          _GEN_3[3],
          _GEN_3[1:0],
          io_req_bits_vaddr[20],
          io_req_bits_vaddr[17:16],
          io_req_bits_vaddr[13]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:198:67, :200:19, :317:19
  wire [3:0]  _GEN_9 = io_req_bits_vaddr[3:0] & (4'h1 << io_req_bits_size) - 4'h1;	// OneHot.scala:58:35, TLB.scala:283:{39,69}
  wire        _cmd_read_T_1 = io_req_bits_cmd == 5'h6;	// package.scala:15:47
  wire        _cmd_write_T_3 = io_req_bits_cmd == 5'h7;	// package.scala:15:47
  wire        cmd_lrsc = _cmd_read_T_1 | _cmd_write_T_3;	// package.scala:15:47, :72:59
  wire        _cmd_write_T_5 = io_req_bits_cmd == 5'h4;	// package.scala:15:47
  wire        _cmd_write_T_6 = io_req_bits_cmd == 5'h9;	// package.scala:15:47
  wire        _cmd_write_T_7 = io_req_bits_cmd == 5'hA;	// package.scala:15:47
  wire        _cmd_write_T_8 = io_req_bits_cmd == 5'hB;	// package.scala:15:47
  wire        cmd_amo_logical =
    _cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8;	// package.scala:15:47, :72:59
  wire        _cmd_write_T_12 = io_req_bits_cmd == 5'h8;	// package.scala:15:47
  wire        _cmd_write_T_13 = io_req_bits_cmd == 5'hC;	// package.scala:15:47
  wire        _cmd_write_T_14 = io_req_bits_cmd == 5'hD;	// package.scala:15:47
  wire        _cmd_write_T_15 = io_req_bits_cmd == 5'hE;	// package.scala:15:47
  wire        _cmd_write_T_16 = io_req_bits_cmd == 5'hF;	// package.scala:15:47
  wire        cmd_amo_arithmetic =
    _cmd_write_T_12 | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15
    | _cmd_write_T_16;	// package.scala:15:47, :72:59
  wire        cmd_put_partial = io_req_bits_cmd == 5'h11;	// TLB.scala:297:41
  wire        cmd_read =
    io_req_bits_cmd == 5'h0 | _cmd_read_T_1 | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:81:{31,75}, package.scala:15:47
  wire        cmd_write =
    io_req_bits_cmd == 5'h1 | cmd_put_partial | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:82:{32,76}, TLB.scala:283:69, :297:41, package.scala:15:47
  wire        ae_array = (|_GEN_9) & prot_eff | cmd_lrsc & ~cacheable;	// TLB.scala:200:19, :283:{39,75}, :305:{8,37}, :306:{8,19}, package.scala:72:59
  PMPChecker pmp (	// TLB.scala:193:19
    .io_prv         (io_ptw_status_dprv),
    .io_pmp_0_cfg_l (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr  (io_ptw_pmp_0_addr),
    .io_pmp_0_mask  (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr  (io_ptw_pmp_1_addr),
    .io_pmp_1_mask  (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr  (io_ptw_pmp_2_addr),
    .io_pmp_2_mask  (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr  (io_ptw_pmp_3_addr),
    .io_pmp_3_mask  (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr  (io_ptw_pmp_4_addr),
    .io_pmp_4_mask  (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr  (io_ptw_pmp_5_addr),
    .io_pmp_5_mask  (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr  (io_ptw_pmp_6_addr),
    .io_pmp_6_mask  (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr  (io_ptw_pmp_7_addr),
    .io_pmp_7_mask  (io_ptw_pmp_7_mask),
    .io_addr        (io_req_bits_vaddr[31:0]),	// TLB.scala:194:15
    .io_size        (io_req_bits_size),
    .io_r           (_pmp_io_r),
    .io_w           (_pmp_io_w),
    .io_x           (/* unused */)
  );
  assign io_req_ready = 1'h1;	// TLB.scala:182:27
  assign io_resp_paddr = io_req_bits_vaddr[31:0];	// Cat.scala:30:58
  assign io_resp_pf_ld = 1'h0;	// TLB.scala:165:29
  assign io_resp_pf_st = 1'h0;	// TLB.scala:165:29
  assign io_resp_ae_ld =
    cmd_read & (ae_array | ~(legal_address & ~deny_access_to_debug & _pmp_io_r));	// Consts.scala:81:75, TLB.scala:193:19, :198:67, :203:48, :204:{44,66}, :305:37, :307:{24,44,46}
  assign io_resp_ae_st =
    (cmd_write | io_req_bits_cmd == 5'h5 | io_req_bits_cmd == 5'h17)
    & (ae_array
       | ~(legal_address
           & (~(|_GEN_5) | ~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_4))
           & ~deny_access_to_debug & _pmp_io_w)) | cmd_put_partial
    & ~(prot_pp | cacheable) | cmd_amo_logical & ~(prot_al | cacheable)
    | cmd_amo_arithmetic & ~(prot_aa | cacheable);	// Consts.scala:82:76, Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:193:19, :198:67, :200:19, :203:48, :204:44, :205:70, :278:39, :279:39, :280:39, :297:41, :300:35, :305:37, :309:{8,35,37}, :310:{8,26}, :311:{8,26,53}, :312:{8,29}, package.scala:15:47, :72:59
  assign io_resp_ma_ld = (|_GEN_9) & cmd_read & ~prot_eff;	// Consts.scala:81:75, TLB.scala:200:19, :283:{39,75}, :318:{24,49}
  assign io_resp_ma_st = (|_GEN_9) & cmd_write & ~prot_eff;	// Consts.scala:82:76, TLB.scala:200:19, :283:{39,75}, :318:49, :319:24
  assign io_resp_cacheable = cacheable;	// TLB.scala:200:19
  assign io_resp_must_alloc =
    cmd_put_partial & ~prot_pp | cmd_amo_logical & ~prot_aa | cmd_amo_arithmetic
    & ~prot_al | cmd_lrsc;	// TLB.scala:200:19, :297:41, :314:{8,26}, :315:{8,26}, :316:{8,29,46}, package.scala:72:59
  assign io_ptw_req_valid = 1'h0;	// TLB.scala:165:29
  assign io_ptw_req_bits_bits_addr = 21'h0;	// TLB.scala:174:25
endmodule

