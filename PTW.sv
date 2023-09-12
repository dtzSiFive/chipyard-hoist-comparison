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

module PTW(
  input         clock,
                reset,
                io_requestor_0_req_valid,
  input  [26:0] io_requestor_0_req_bits_bits_addr,
  input         io_requestor_1_req_valid,
                io_requestor_1_req_bits_valid,
  input  [26:0] io_requestor_1_req_bits_bits_addr,
  input         io_mem_req_ready,
                io_mem_s2_nack,
                io_mem_resp_valid,
  input  [63:0] io_mem_resp_bits_data,
  input         io_mem_s2_xcpt_ae_ld,
  input  [43:0] io_dpath_ptbr_ppn,
  input         io_dpath_sfence_valid,
                io_dpath_sfence_bits_rs1,
                io_dpath_sfence_bits_rs2,
  input  [38:0] io_dpath_sfence_bits_addr,
  input  [1:0]  io_dpath_pmp_0_cfg_a,
  input  [29:0] io_dpath_pmp_0_addr,
  input  [31:0] io_dpath_pmp_0_mask,
  input  [1:0]  io_dpath_pmp_1_cfg_a,
  input  [29:0] io_dpath_pmp_1_addr,
  input  [31:0] io_dpath_pmp_1_mask,
  input  [1:0]  io_dpath_pmp_2_cfg_a,
  input  [29:0] io_dpath_pmp_2_addr,
  input  [31:0] io_dpath_pmp_2_mask,
  input  [1:0]  io_dpath_pmp_3_cfg_a,
  input  [29:0] io_dpath_pmp_3_addr,
  input  [31:0] io_dpath_pmp_3_mask,
  input  [1:0]  io_dpath_pmp_4_cfg_a,
  input  [29:0] io_dpath_pmp_4_addr,
  input  [31:0] io_dpath_pmp_4_mask,
  input  [1:0]  io_dpath_pmp_5_cfg_a,
  input  [29:0] io_dpath_pmp_5_addr,
  input  [31:0] io_dpath_pmp_5_mask,
  input  [1:0]  io_dpath_pmp_6_cfg_a,
  input  [29:0] io_dpath_pmp_6_addr,
  input  [31:0] io_dpath_pmp_6_mask,
  input  [1:0]  io_dpath_pmp_7_cfg_a,
  input  [29:0] io_dpath_pmp_7_addr,
  input  [31:0] io_dpath_pmp_7_mask,
  output        io_requestor_0_req_ready,
                io_requestor_0_resp_valid,
                io_requestor_0_resp_bits_ae,
  output [53:0] io_requestor_0_resp_bits_pte_ppn,
  output        io_requestor_0_resp_bits_pte_d,
                io_requestor_0_resp_bits_pte_a,
                io_requestor_0_resp_bits_pte_g,
                io_requestor_0_resp_bits_pte_u,
                io_requestor_0_resp_bits_pte_x,
                io_requestor_0_resp_bits_pte_w,
                io_requestor_0_resp_bits_pte_r,
                io_requestor_0_resp_bits_pte_v,
  output [1:0]  io_requestor_0_resp_bits_level,
  output        io_requestor_0_resp_bits_homogeneous,
                io_requestor_1_req_ready,
                io_requestor_1_resp_valid,
                io_requestor_1_resp_bits_ae,
  output [53:0] io_requestor_1_resp_bits_pte_ppn,
  output        io_requestor_1_resp_bits_pte_d,
                io_requestor_1_resp_bits_pte_a,
                io_requestor_1_resp_bits_pte_g,
                io_requestor_1_resp_bits_pte_u,
                io_requestor_1_resp_bits_pte_x,
                io_requestor_1_resp_bits_pte_w,
                io_requestor_1_resp_bits_pte_r,
                io_requestor_1_resp_bits_pte_v,
  output [1:0]  io_requestor_1_resp_bits_level,
  output        io_requestor_1_resp_bits_homogeneous,
                io_mem_req_valid,
  output [39:0] io_mem_req_bits_addr,
  output        io_mem_s1_kill
);

  wire [9:0]    readAddr;	// PTW.scala:254:54
  wire          readEnable;	// PTW.scala:251:31
  wire          writeEnable;	// PTW.scala:227:21
  wire [9:0]    writeAddr;	// package.scala:154:13
  reg           l2_refill;	// PTW.scala:201:26
  wire [43:0]   _l2_tlb_ram_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire          _arb_io_out_valid;	// PTW.scala:112:19
  wire          _arb_io_out_bits_valid;	// PTW.scala:112:19
  wire [26:0]   _arb_io_out_bits_bits_addr;	// PTW.scala:112:19
  wire          _arb_io_chosen;	// PTW.scala:112:19
  reg  [2:0]    state;	// PTW.scala:109:18
  wire          _arb_io_out_ready_T_2 = ~(|state) & ~l2_refill;	// PTW.scala:109:18, :114:{30,43,46}, :201:26
  reg           resp_valid_0;	// PTW.scala:116:23
  reg           resp_valid_1;	// PTW.scala:116:23
  reg           invalidated;	// PTW.scala:125:24
  reg  [1:0]    count;	// PTW.scala:126:18
  reg           resp_ae;	// PTW.scala:127:24
  reg  [26:0]   r_req_addr;	// PTW.scala:130:18
  reg           r_req_dest;	// PTW.scala:131:23
  reg  [53:0]   r_pte_ppn;	// PTW.scala:132:18
  reg           r_pte_d;	// PTW.scala:132:18
  reg           r_pte_a;	// PTW.scala:132:18
  reg           r_pte_g;	// PTW.scala:132:18
  reg           r_pte_u;	// PTW.scala:132:18
  reg           r_pte_x;	// PTW.scala:132:18
  reg           r_pte_w;	// PTW.scala:132:18
  reg           r_pte_r;	// PTW.scala:132:18
  reg           r_pte_v;	// PTW.scala:132:18
  reg           mem_resp_valid;	// PTW.scala:134:31
  reg  [63:0]   mem_resp_data;	// PTW.scala:135:30
  wire          _leaf_T_5 = count == 2'h1;	// PTW.scala:126:18, :152:21, package.scala:32:86
  wire          _leaf_T_8 = count == 2'h2;	// PTW.scala:126:18, :156:57, package.scala:32:86
  wire          _GEN = (&count) | _leaf_T_8;	// PTW.scala:126:18, package.scala:32:{76,86}
  wire [8:0]    vpn_idx =
    _GEN ? r_req_addr[8:0] : _leaf_T_5 ? r_req_addr[17:9] : r_req_addr[26:18];	// PTW.scala:130:18, :158:{60,90}, package.scala:32:{76,86}
  wire          _r_pte_T_7 = _arb_io_out_ready_T_2 & _arb_io_out_valid;	// Decoupled.scala:40:37, PTW.scala:112:19, :114:43
  reg  [6:0]    state_reg;	// Replacement.scala:168:70
  reg  [7:0]    valid;	// PTW.scala:175:24
  reg  [31:0]   tags_0;	// PTW.scala:176:19
  reg  [31:0]   tags_1;	// PTW.scala:176:19
  reg  [31:0]   tags_2;	// PTW.scala:176:19
  reg  [31:0]   tags_3;	// PTW.scala:176:19
  reg  [31:0]   tags_4;	// PTW.scala:176:19
  reg  [31:0]   tags_5;	// PTW.scala:176:19
  reg  [31:0]   tags_6;	// PTW.scala:176:19
  reg  [31:0]   tags_7;	// PTW.scala:176:19
  reg  [19:0]   data_0;	// PTW.scala:177:19
  reg  [19:0]   data_1;	// PTW.scala:177:19
  reg  [19:0]   data_2;	// PTW.scala:177:19
  reg  [19:0]   data_3;	// PTW.scala:177:19
  reg  [19:0]   data_4;	// PTW.scala:177:19
  reg  [19:0]   data_5;	// PTW.scala:177:19
  reg  [19:0]   data_6;	// PTW.scala:177:19
  reg  [19:0]   data_7;	// PTW.scala:177:19
  wire          _r_pte_T_5 = state == 3'h1;	// PTW.scala:109:18, :184:15, :187:24
  reg           pte_hit;	// PTW.scala:195:24
  reg  [1023:0] g_0;	// PTW.scala:223:16
  reg  [1023:0] valid_1_0;	// PTW.scala:224:24
  assign writeAddr = r_req_addr[9:0];	// PTW.scala:130:18, package.scala:154:13
  assign writeEnable = l2_refill & ~invalidated;	// PTW.scala:125:24, :181:49, :201:26, :227:21
  assign readEnable = ~l2_refill & _r_pte_T_7;	// Decoupled.scala:40:37, PTW.scala:201:26, :251:{20,31}
  reg           s1_valid;	// PTW.scala:252:27
  reg           s2_valid;	// PTW.scala:253:27
  assign readAddr = _arb_io_out_bits_bits_addr[9:0];	// PTW.scala:112:19, :254:54
  reg  [43:0]   r_1;	// Reg.scala:15:16
  reg           s2_valid_vec;	// Reg.scala:15:16
  reg           s2_g_vec_0;	// Reg.scala:15:16
  wire          s2_error = s2_valid_vec & ^r_1;	// ECC.scala:77:27, PTW.scala:258:81, Reg.scala:15:16
  wire          s2_hit_vec_0 = s2_valid_vec & r_req_addr[26:10] == r_1[42:26];	// PTW.scala:130:18, :261:59, :262:{83,93}, Reg.scala:15:16, package.scala:154:13
  wire          s2_hit = s2_valid & s2_hit_vec_0;	// PTW.scala:253:27, :262:83, :263:27
  wire [39:0]   _GEN_0 = {r_pte_ppn[53:16], ~(r_pte_ppn[15:14])};	// PTW.scala:132:18, Parameters.scala:137:31
  wire [37:0]   _GEN_1 = {r_pte_ppn[53:20], r_pte_ppn[19:16] ^ 4'h8};	// PTW.scala:132:18, :184:15, Parameters.scala:137:31
  wire [65:0]   _pmpHomogeneous_T_1 = {r_pte_ppn, 12'h0};	// PTW.scala:132:18, :309:92
  wire [31:0]   _GEN_2 = {r_pte_ppn[19:0], 12'h0};	// PMP.scala:100:53, PTW.scala:132:18, :184:15, :309:92
  wire [65:0]   _GEN_3 = {34'h0, io_dpath_pmp_0_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [65:0]   _GEN_4 = {34'h0, io_dpath_pmp_1_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_1 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_5 = _GEN_2 & pmpHomogeneous_pgMask_1;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [65:0]   _GEN_6 = {34'h0, io_dpath_pmp_2_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_2 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_7 = _GEN_2 & pmpHomogeneous_pgMask_2;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [65:0]   _GEN_8 = {34'h0, io_dpath_pmp_3_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_3 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_9 = _GEN_2 & pmpHomogeneous_pgMask_3;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [65:0]   _GEN_10 = {34'h0, io_dpath_pmp_4_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_4 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_11 = _GEN_2 & pmpHomogeneous_pgMask_4;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [65:0]   _GEN_12 = {34'h0, io_dpath_pmp_5_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_5 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_13 = _GEN_2 & pmpHomogeneous_pgMask_5;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [65:0]   _GEN_14 = {34'h0, io_dpath_pmp_6_addr, 2'h0};	// PMP.scala:109:32, PTW.scala:148:13, :271:22
  wire [31:0]   pmpHomogeneous_pgMask_6 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_15 = _GEN_2 & pmpHomogeneous_pgMask_6;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire [31:0]   pmpHomogeneous_pgMask_7 =
    _GEN ? 32'hFFFFF000 : _leaf_T_5 ? 32'hFFE00000 : 32'hC0000000;	// package.scala:32:{76,86}
  wire [31:0]   _GEN_16 = _GEN_2 & pmpHomogeneous_pgMask_7;	// PMP.scala:100:53, :112:30, package.scala:32:76
  wire          homogeneous =
    (_GEN
       ? {r_pte_ppn[53:3], r_pte_ppn[1:0]} == 53'h0
         | {r_pte_ppn[53:2], ~(r_pte_ppn[1:0])} == 54'h0
         | {r_pte_ppn[53:5], ~(r_pte_ppn[4])} == 50'h0
         | {r_pte_ppn[53:6], r_pte_ppn[5:4] ^ 2'h2} == 50'h0
         | {r_pte_ppn[53:9], r_pte_ppn[8:0] ^ 9'h100} == 54'h0
         | {r_pte_ppn[53:14], r_pte_ppn[13:4] ^ 10'h200} == 50'h0
         | {r_pte_ppn[53:14], r_pte_ppn[13:0] ^ 14'h2010} == 54'h0 | ~(|_GEN_0)
         | {r_pte_ppn[53:17], r_pte_ppn[16:0] ^ 17'h10000} == 54'h0
         | {r_pte_ppn[53:19], r_pte_ppn[18:0] ^ 19'h54000} == 54'h0 | ~(|_GEN_1)
       : _leaf_T_5 & (~(|_GEN_0) | ~(|_GEN_1)))
    & (io_dpath_pmp_0_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_0_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_0_mask[20] : io_dpath_pmp_0_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_0_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_0_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_0_addr[29:28]}))
         : ~(io_dpath_pmp_0_cfg_a[0]) | _pmpHomogeneous_T_1 >= _GEN_3
           | (_GEN_2
              & pmpHomogeneous_pgMask) < ({io_dpath_pmp_0_addr, 2'h0}
                                          & pmpHomogeneous_pgMask))
    & (io_dpath_pmp_1_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_1_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_1_mask[20] : io_dpath_pmp_1_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_1_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_1_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_1_addr[29:28]}))
         : ~(io_dpath_pmp_1_cfg_a[0])
           | _GEN_5 < ({io_dpath_pmp_0_addr, 2'h0} & pmpHomogeneous_pgMask_1)
           | _pmpHomogeneous_T_1 >= _GEN_4 | _pmpHomogeneous_T_1 >= _GEN_3
           & _GEN_5 < ({io_dpath_pmp_1_addr, 2'h0} & pmpHomogeneous_pgMask_1))
    & (io_dpath_pmp_2_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_2_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_2_mask[20] : io_dpath_pmp_2_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_2_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_2_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_2_addr[29:28]}))
         : ~(io_dpath_pmp_2_cfg_a[0])
           | _GEN_7 < ({io_dpath_pmp_1_addr, 2'h0} & pmpHomogeneous_pgMask_2)
           | _pmpHomogeneous_T_1 >= _GEN_6 | _pmpHomogeneous_T_1 >= _GEN_4
           & _GEN_7 < ({io_dpath_pmp_2_addr, 2'h0} & pmpHomogeneous_pgMask_2))
    & (io_dpath_pmp_3_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_3_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_3_mask[20] : io_dpath_pmp_3_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_3_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_3_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_3_addr[29:28]}))
         : ~(io_dpath_pmp_3_cfg_a[0])
           | _GEN_9 < ({io_dpath_pmp_2_addr, 2'h0} & pmpHomogeneous_pgMask_3)
           | _pmpHomogeneous_T_1 >= _GEN_8 | _pmpHomogeneous_T_1 >= _GEN_6
           & _GEN_9 < ({io_dpath_pmp_3_addr, 2'h0} & pmpHomogeneous_pgMask_3))
    & (io_dpath_pmp_4_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_4_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_4_mask[20] : io_dpath_pmp_4_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_4_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_4_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_4_addr[29:28]}))
         : ~(io_dpath_pmp_4_cfg_a[0])
           | _GEN_11 < ({io_dpath_pmp_3_addr, 2'h0} & pmpHomogeneous_pgMask_4)
           | _pmpHomogeneous_T_1 >= _GEN_10 | _pmpHomogeneous_T_1 >= _GEN_8
           & _GEN_11 < ({io_dpath_pmp_4_addr, 2'h0} & pmpHomogeneous_pgMask_4))
    & (io_dpath_pmp_5_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_5_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_5_mask[20] : io_dpath_pmp_5_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_5_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_5_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_5_addr[29:28]}))
         : ~(io_dpath_pmp_5_cfg_a[0])
           | _GEN_13 < ({io_dpath_pmp_4_addr, 2'h0} & pmpHomogeneous_pgMask_5)
           | _pmpHomogeneous_T_1 >= _GEN_12 | _pmpHomogeneous_T_1 >= _GEN_10
           & _GEN_13 < ({io_dpath_pmp_5_addr, 2'h0} & pmpHomogeneous_pgMask_5))
    & (io_dpath_pmp_6_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_6_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_6_mask[20] : io_dpath_pmp_6_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_6_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_6_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_6_addr[29:28]}))
         : ~(io_dpath_pmp_6_cfg_a[0])
           | _GEN_15 < ({io_dpath_pmp_5_addr, 2'h0} & pmpHomogeneous_pgMask_6)
           | _pmpHomogeneous_T_1 >= _GEN_14 | _pmpHomogeneous_T_1 >= _GEN_12
           & _GEN_15 < ({io_dpath_pmp_6_addr, 2'h0} & pmpHomogeneous_pgMask_6))
    & (io_dpath_pmp_7_cfg_a[1]
         ? (_GEN
              ? io_dpath_pmp_7_mask[11]
              : _leaf_T_5 ? io_dpath_pmp_7_mask[20] : io_dpath_pmp_7_mask[29])
           | (_GEN
                ? (|{r_pte_ppn[53:20], r_pte_ppn[19:0] ^ io_dpath_pmp_7_addr[29:10]})
                : _leaf_T_5
                    ? (|{r_pte_ppn[53:20], r_pte_ppn[19:9] ^ io_dpath_pmp_7_addr[29:19]})
                    : (|{r_pte_ppn[53:20],
                         r_pte_ppn[19:18] ^ io_dpath_pmp_7_addr[29:28]}))
         : ~(io_dpath_pmp_7_cfg_a[0])
           | _GEN_16 < ({io_dpath_pmp_6_addr, 2'h0} & pmpHomogeneous_pgMask_7)
           | _pmpHomogeneous_T_1 >= {34'h0, io_dpath_pmp_7_addr, 2'h0}
           | _pmpHomogeneous_T_1 >= _GEN_14
           & _GEN_16 < ({io_dpath_pmp_7_addr, 2'h0} & pmpHomogeneous_pgMask_7));	// PMP.scala:47:20, :48:26, :62:48, :99:93, :100:{21,53,66,78}, :108:32, :109:32, :112:{30,40,58}, :113:{40,53}, :115:62, :120:{8,45,58}, PTW.scala:132:18, :148:13, :156:57, :160:29, :184:15, :271:22, :309:92, :310:36, Parameters.scala:137:{31,49,52,67}, TLBPermissions.scala:98:65, package.scala:32:{76,86}
  wire          _GEN_17 = state == 3'h1;	// Conditional.scala:37:30, PTW.scala:109:18, :184:15
  wire          _GEN_18 = state == 3'h2;	// Conditional.scala:37:30, PTW.scala:109:18, :184:15
  wire          _GEN_19 = state == 3'h4;	// Conditional.scala:37:30, Mux.scala:47:69, PTW.scala:109:18
  wire          _GEN_20 = ~(|state) | _GEN_17 | _GEN_18;	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :114:30, :196:26
  wire          _GEN_21 = s2_hit & ~s2_error;	// PTW.scala:258:81, :263:27, :375:19, :381:16
  `ifndef SYNTHESIS	// PTW.scala:198:9
    always @(posedge clock) begin	// PTW.scala:198:9
      if (~(~(s2_hit
              & (~_GEN_20 & _GEN_19 & ~(count[1]) | pte_hit & _r_pte_T_5 & ~s2_hit))
            | reset)) begin	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:126:18, :152:21, :156:57, :187:24, :195:24, :196:26, :197:{57,60}, :198:{9,10,32,59}, :263:27
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:198:9
          $error("Assertion failed: PTE Cache Hit/Miss Performance Monitor Events are lower priority than L2TLB Hit event\n    at PTW.scala:198 assert(!(io.dpath.perf.l2hit && (io.dpath.perf.pte_miss || io.dpath.perf.pte_hit)),\n");	// PTW.scala:198:9
        if (`STOP_COND_)	// PTW.scala:198:9
          $fatal;	// PTW.scala:198:9
      end
      if (s2_hit & ~(s2_hit_vec_0 | s2_error | reset)) begin	// PTW.scala:258:81, :262:83, :263:27, :268:13
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:268:13
          $error("Assertion failed: L2 TLB multi-hit\n    at PTW.scala:268 assert((PopCount(s2_hit_vec) === 1.U) || s2_error, \"L2 TLB multi-hit\")\n");	// PTW.scala:268:13
        if (`STOP_COND_)	// PTW.scala:268:13
          $fatal;	// PTW.scala:268:13
      end
      if (_GEN_21 & ~(_r_pte_T_5 | _GEN_18 | reset)) begin	// Conditional.scala:37:30, PTW.scala:187:24, :381:16, :382:11
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:382:11
          $error("Assertion failed\n    at PTW.scala:382 assert(state === s_req || state === s_wait1)\n");	// PTW.scala:382:11
        if (`STOP_COND_)	// PTW.scala:382:11
          $fatal;	// PTW.scala:382:11
      end
      if (mem_resp_valid & ~(state == 3'h5 | reset)) begin	// Mux.scala:47:69, PTW.scala:109:18, :134:31, :389:{11,18}
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:389:11
          $error("Assertion failed\n    at PTW.scala:389 assert(state === s_wait3)\n");	// PTW.scala:389:11
        if (`STOP_COND_)	// PTW.scala:389:11
          $fatal;	// PTW.scala:389:11
      end
      if (io_mem_s2_nack & ~(_GEN_19 | reset)) begin	// Conditional.scala:37:30, PTW.scala:406:11
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:406:11
          $error("Assertion failed\n    at PTW.scala:406 assert(state === s_wait2)\n");	// PTW.scala:406:11
        if (`STOP_COND_)	// PTW.scala:406:11
          $fatal;	// PTW.scala:406:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic          res_v;	// PTW.scala:149:36, :152:{102,110}
    automatic logic          traverse;	// PTW.scala:156:48
    automatic logic [65:0]   pte_addr;	// PTW.scala:160:29
    automatic logic          lo_lo_lo;	// PTW.scala:179:27
    automatic logic          lo_lo_hi;	// PTW.scala:179:27
    automatic logic          lo_hi_lo;	// PTW.scala:179:27
    automatic logic          lo_hi_hi;	// PTW.scala:179:27
    automatic logic          hi_lo_lo;	// PTW.scala:179:27
    automatic logic          hi_lo_hi;	// PTW.scala:179:27
    automatic logic          hi_hi_lo;	// PTW.scala:179:27
    automatic logic          hi_hi_hi;	// PTW.scala:179:27
    automatic logic [7:0]    hits;	// PTW.scala:179:48
    automatic logic          _GEN_22;	// PTW.scala:181:26
    automatic logic          _GEN_23;	// PTW.scala:181:46
    automatic logic [6:0]    _GEN_24;	// PTW.scala:182:57
    automatic logic [2:0]    r;	// PTW.scala:182:18
    automatic logic [31:0]   _GEN_25;	// PTW.scala:184:15
    automatic logic          pte_cache_hit;	// PTW.scala:193:10
    automatic logic [1023:0] _GEN_26;	// PTW.scala:226:34
    automatic logic [1023:0] mask;	// OneHot.scala:58:35
    automatic logic          _GEN_27;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23
    automatic logic          _GEN_28;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23
    automatic logic          _GEN_29;	// Conditional.scala:40:58, PTW.scala:381:30, :384:28
    automatic logic          _GEN_30;	// Conditional.scala:40:58, PTW.scala:381:30, :384:28
    automatic logic          _GEN_31;	// PTW.scala:381:30, :388:25, :390:21
    res_v =
      ~((mem_resp_data[1] | mem_resp_data[2] | mem_resp_data[3])
        & (~(count[1]) & (|(mem_resp_data[18:10])) | count == 2'h0
           & (|(mem_resp_data[27:19])))) & mem_resp_data[0];	// PTW.scala:126:18, :135:30, :146:33, :149:{26,36}, :152:{21,26,36,95,102,110}, :271:22
    traverse =
      res_v & ~(mem_resp_data[1]) & ~(mem_resp_data[2]) & ~(mem_resp_data[3])
      & ~(|(mem_resp_data[63:30])) & ~(count[1]);	// PTW.scala:72:{36,42,48}, :126:18, :135:30, :146:33, :149:36, :152:{21,102,110}, :154:{20,32}, :156:{33,48,57}
    pte_addr = {r_pte_ppn, vpn_idx, 3'h0};	// PTW.scala:109:18, :132:18, :160:29, package.scala:32:76
    lo_lo_lo = {34'h0, tags_0} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    lo_lo_hi = {34'h0, tags_1} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    lo_hi_lo = {34'h0, tags_2} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    lo_hi_hi = {34'h0, tags_3} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    hi_lo_lo = {34'h0, tags_4} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    hi_lo_hi = {34'h0, tags_5} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    hi_hi_lo = {34'h0, tags_6} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    hi_hi_hi = {34'h0, tags_7} == pte_addr;	// PTW.scala:148:13, :160:29, :176:19, :179:27
    hits =
      {hi_hi_hi, hi_hi_lo, hi_lo_hi, hi_lo_lo, lo_hi_hi, lo_hi_lo, lo_lo_hi, lo_lo_lo}
      & valid;	// Cat.scala:30:58, PTW.scala:175:24, :179:{27,48}
    _GEN_22 = mem_resp_valid & traverse;	// PTW.scala:134:31, :156:48, :181:26
    _GEN_23 = _GEN_22 & ~(|hits) & ~invalidated;	// PTW.scala:125:24, :179:48, :180:20, :181:{26,41,46,49}
    _GEN_24 = ~(valid[6:0]);	// PTW.scala:175:24, :182:57
    r =
      (&valid)
        ? {state_reg[6],
           state_reg[6]
             ? {state_reg[5], state_reg[5] ? state_reg[4] : state_reg[3]}
             : {state_reg[2], state_reg[2] ? state_reg[1] : state_reg[0]}}
        : _GEN_24[0]
            ? 3'h0
            : _GEN_24[1]
                ? 3'h1
                : _GEN_24[2]
                    ? 3'h2
                    : _GEN_24[3]
                        ? 3'h3
                        : _GEN_24[4] ? 3'h4 : _GEN_24[5] ? 3'h5 : {2'h3, ~(_GEN_24[6])};	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:47:40, PTW.scala:109:18, :175:24, :182:{18,25,57}, :184:15, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:32:86, :154:13
    _GEN_25 = {r_pte_ppn[19:0], vpn_idx, 3'h0};	// PTW.scala:109:18, :132:18, :184:15, package.scala:32:76
    pte_cache_hit = (|hits) & ~(count[1]);	// PTW.scala:126:18, :152:21, :156:57, :179:48, :180:20, :193:10
    _GEN_26 = {1014'h0, writeAddr};	// PTW.scala:226:34, package.scala:154:13
    mask = 1024'h1 << _GEN_26;	// OneHot.scala:58:35, PTW.scala:226:34
    _GEN_27 =
      ~_GEN_20 & (_GEN_19 ? io_mem_s2_xcpt_ae_ld & ~r_req_dest : (&state) & ~r_req_dest);	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :116:23, :131:23, :196:26, :351:35, :354:32, :359:30
    _GEN_28 =
      ~_GEN_20 & (_GEN_19 ? io_mem_s2_xcpt_ae_ld & r_req_dest : (&state) & r_req_dest);	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :116:23, :131:23, :196:26, :351:35, :354:32, :359:30
    _GEN_29 = _GEN_21 & ~r_req_dest;	// Conditional.scala:40:58, PTW.scala:131:23, :354:32, :381:{16,30}, :384:28
    _GEN_30 = _GEN_21 & r_req_dest;	// Conditional.scala:40:58, PTW.scala:131:23, :381:{16,30}, :384:28
    _GEN_31 = ~mem_resp_valid | traverse;	// PTW.scala:134:31, :156:48, :381:30, :388:25, :390:21
    if (reset) begin
      state <= 3'h0;	// PTW.scala:109:18
      state_reg <= 7'h0;	// Replacement.scala:168:70
      valid <= 8'h0;	// PTW.scala:175:24
      valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
    end
    else begin
      if (io_mem_s2_nack)
        state <= 3'h1;	// PTW.scala:109:18, :184:15
      else if (mem_resp_valid)	// PTW.scala:134:31
        state <= {2'h0, traverse};	// PTW.scala:109:18, :156:48, :271:22, :390:21, :391:18, :397:65
      else if (_GEN_21)	// PTW.scala:381:16
        state <= 3'h0;	// PTW.scala:109:18
      else if (|state) begin	// PTW.scala:109:18, :114:30
        if (_GEN_17) begin	// Conditional.scala:37:30
          if (~pte_cache_hit) begin	// PTW.scala:193:10
            if (io_mem_req_ready)
              state <= 3'h2;	// PTW.scala:109:18, :184:15
            else
              state <= 3'h1;	// PTW.scala:109:18, :184:15
          end
        end
        else if (_GEN_18) begin	// Conditional.scala:37:30
          if (s2_hit)	// PTW.scala:263:27
            state <= 3'h1;	// PTW.scala:109:18, :184:15
          else	// PTW.scala:263:27
            state <= 3'h4;	// Mux.scala:47:69, PTW.scala:109:18
        end
        else if (_GEN_19) begin	// Conditional.scala:37:30
          if (io_mem_s2_xcpt_ae_ld)
            state <= 3'h0;	// PTW.scala:109:18
          else
            state <= 3'h5;	// Mux.scala:47:69, PTW.scala:109:18
        end
        else if (&state)	// Conditional.scala:37:30, PTW.scala:109:18
          state <= 3'h0;	// PTW.scala:109:18
      end
      else if (_r_pte_T_7)	// Decoupled.scala:40:37
        state <= {2'h0, _arb_io_out_bits_valid};	// PTW.scala:109:18, :112:19, :271:22, :332:26
      if ((|hits) & _r_pte_T_5) begin	// PTW.scala:179:48, :180:20, :187:{15,24}
        automatic logic [3:0] hi_4;	// OneHot.scala:30:18, PTW.scala:179:48
        automatic logic [2:0] _GEN_32;	// OneHot.scala:32:28
        automatic logic       lo_6;	// OneHot.scala:32:28
        hi_4 = {hi_hi_hi, hi_hi_lo, hi_lo_hi, hi_lo_lo} & valid[7:4];	// OneHot.scala:30:18, PTW.scala:175:24, :179:{27,48}
        _GEN_32 = hi_4[3:1] | {lo_hi_hi, lo_hi_lo, lo_lo_hi} & valid[3:1];	// OneHot.scala:30:18, :31:18, :32:28, PTW.scala:175:24, :179:{27,48}
        lo_6 = _GEN_32[2] | _GEN_32[0];	// OneHot.scala:30:18, :31:18, :32:28
        state_reg <=
          {~(|hi_4),
           (|hi_4)
             ? {~(|(_GEN_32[2:1])),
                (|(_GEN_32[2:1])) ? ~lo_6 : state_reg[4],
                (|(_GEN_32[2:1])) ? state_reg[3] : ~lo_6}
             : state_reg[5:3],
           (|hi_4)
             ? state_reg[2:0]
             : {~(|(_GEN_32[2:1])),
                (|(_GEN_32[2:1])) ? ~lo_6 : state_reg[1],
                (|(_GEN_32[2:1])) ? state_reg[0] : ~lo_6}};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, PTW.scala:179:48, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
      if (io_dpath_sfence_valid & ~io_dpath_sfence_bits_rs1)	// PTW.scala:188:{33,36}
        valid <= 8'h0;	// PTW.scala:175:24
      else	// PTW.scala:188:33
        valid <= {8{_GEN_23}} & 8'h1 << r | valid;	// OneHot.scala:58:35, PTW.scala:175:24, :181:{46,63}, :182:18, :183:13
      if (s2_valid & s2_error)	// PTW.scala:253:27, :258:81, :259:20
        valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
      else if (io_dpath_sfence_valid) begin
        if (io_dpath_sfence_bits_rs1)
          valid_1_0 <= valid_1_0 & ~(1024'h1 << io_dpath_sfence_bits_addr[21:12]);	// OneHot.scala:58:35, PTW.scala:224:24, :246:{52,54,89}
        else if (io_dpath_sfence_bits_rs2)
          valid_1_0 <= valid_1_0 & g_0;	// PTW.scala:223:16, :224:24, :247:52
        else
          valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
      end
      else
        valid_1_0 <= {1024{writeEnable}} & mask | valid_1_0;	// OneHot.scala:58:35, PTW.scala:224:24, :227:{21,38}, :237:27
    end
    if (_GEN_31) begin	// PTW.scala:381:30, :388:25, :390:21
      resp_valid_0 <= _GEN_29 | _GEN_27;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23, :381:30, :384:28
      resp_valid_1 <= _GEN_30 | _GEN_28;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23, :381:30, :384:28
    end
    else begin	// PTW.scala:381:30, :388:25, :390:21
      resp_valid_0 <= ~r_req_dest | _GEN_29 | _GEN_27;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23, :131:23, :354:32, :381:30, :384:28, :401:32
      resp_valid_1 <= r_req_dest | _GEN_30 | _GEN_28;	// Conditional.scala:39:67, :40:58, PTW.scala:116:23, :131:23, :381:30, :384:28, :401:32
    end
    invalidated <= io_dpath_sfence_valid | invalidated & (|state);	// PTW.scala:109:18, :118:24, :125:24, :285:{40,56}
    if (_GEN_22)	// PTW.scala:181:26
      count <= count + 2'h1;	// PTW.scala:126:18, :152:21, :392:22
    else if (_GEN_21)	// PTW.scala:381:16
      count <= 2'h2;	// PTW.scala:126:18, :156:57
    else if (|state) begin	// PTW.scala:109:18, :114:30
      if (_GEN_17) begin	// Conditional.scala:37:30
        if (pte_cache_hit)	// PTW.scala:193:10
          count <= count + 2'h1;	// PTW.scala:126:18, :152:21, :338:24
      end
      else if (_GEN_18 | _GEN_19 | ~((&state) & ~homogeneous)) begin	// Conditional.scala:37:30, :39:67, PTW.scala:109:18, :126:18, :310:36, :361:{13,27}, :362:15
      end
      else	// Conditional.scala:39:67, PTW.scala:126:18
        count <= 2'h2;	// PTW.scala:126:18, :156:57
    end
    else	// PTW.scala:114:30
      count <= 2'h0;	// PTW.scala:126:18, :271:22
    if (_GEN_31)	// PTW.scala:381:30, :388:25, :390:21
      resp_ae <=
        ~(_GEN_21 | ~(|state) | _GEN_17 | _GEN_18) & _GEN_19 & io_mem_s2_xcpt_ae_ld;	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :114:30, :127:24, :381:{16,30}, :385:13
    else	// PTW.scala:381:30, :388:25, :390:21
      resp_ae <= res_v & (|(mem_resp_data[63:30]));	// PTW.scala:127:24, :135:30, :149:36, :152:{102,110}, :154:{20,32}, :395:22
    if (_r_pte_T_7) begin	// Decoupled.scala:40:37
      r_req_addr <= _arb_io_out_bits_bits_addr;	// PTW.scala:112:19, :130:18
      r_req_dest <= _arb_io_chosen;	// PTW.scala:112:19, :131:23
    end
    if (mem_resp_valid) begin	// PTW.scala:134:31
      r_pte_ppn <= {34'h0, mem_resp_data[29:10]};	// PTW.scala:132:18, :135:30, :148:{13,23}
      r_pte_d <= mem_resp_data[7];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_a <= mem_resp_data[6];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_g <= mem_resp_data[5];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_u <= mem_resp_data[4];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_x <= mem_resp_data[3];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_w <= mem_resp_data[2];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_r <= mem_resp_data[1];	// PTW.scala:132:18, :135:30, :146:33
      r_pte_v <= res_v;	// PTW.scala:132:18, :149:36, :152:{102,110}
    end
    else begin	// PTW.scala:134:31
      automatic logic _r_pte_T_1 = s2_hit & ~s2_error;	// PTW.scala:258:81, :263:27, :375:{16,19}
      automatic logic _r_pte_T_4;	// PTW.scala:376:40
      automatic logic _r_pte_T_6;	// PTW.scala:377:25
      _r_pte_T_4 = (&state) & ~homogeneous;	// PTW.scala:109:18, :310:36, :376:{15,40,43}
      _r_pte_T_6 = _r_pte_T_5 & pte_cache_hit;	// PTW.scala:187:24, :193:10, :377:25
      if (_r_pte_T_1)	// PTW.scala:375:16
        r_pte_ppn <= {34'h0, r_1[25:6]};	// PTW.scala:132:18, :148:13, :261:59, :272:14, Reg.scala:15:16
      else if (_r_pte_T_4) begin	// PTW.scala:376:40
        if (count[0])	// PTW.scala:126:18, package.scala:31:49
          r_pte_ppn <= {r_pte_ppn[53:9], r_req_addr[8:0]};	// Cat.scala:30:58, PTW.scala:130:18, :132:18, :163:{69,99}
        else	// package.scala:31:49
          r_pte_ppn <= {r_pte_ppn[53:18], r_req_addr[17:0]};	// Cat.scala:30:58, PTW.scala:130:18, :132:18, :163:{69,99}
      end
      else if (_r_pte_T_6)	// PTW.scala:377:25
        r_pte_ppn <=
          {34'h0,
           (lo_lo_lo & valid[0] ? data_0 : 20'h0) | (lo_lo_hi & valid[1] ? data_1 : 20'h0)
             | (lo_hi_lo & valid[2] ? data_2 : 20'h0)
             | (lo_hi_hi & valid[3] ? data_3 : 20'h0)
             | (hi_lo_lo & valid[4] ? data_4 : 20'h0)
             | (hi_lo_hi & valid[5] ? data_5 : 20'h0)
             | (hi_hi_lo & valid[6] ? data_6 : 20'h0)
             | (hi_hi_hi & valid[7] ? data_7 : 20'h0)};	// Mux.scala:27:72, :29:36, PTW.scala:132:18, :148:13, :175:24, :177:19, :179:{27,48}, :370:13
      else if (_r_pte_T_7)	// Decoupled.scala:40:37
        r_pte_ppn <= {10'h0, io_dpath_ptbr_ppn};	// PTW.scala:132:18, :370:13
      if (_r_pte_T_1 | ~(_r_pte_T_4 | ~_r_pte_T_6)) begin	// PTW.scala:375:{8,16}, :376:{8,40}, :377:25
        r_pte_d <= r_1[5];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
        r_pte_a <= r_1[4];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
        r_pte_g <= s2_g_vec_0;	// PTW.scala:132:18, Reg.scala:15:16
        r_pte_u <= r_1[3];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
        r_pte_x <= r_1[2];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
        r_pte_w <= r_1[1];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
        r_pte_r <= r_1[0];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      end
      r_pte_v <= _r_pte_T_1 | ~_r_pte_T_4 & _r_pte_T_6 | r_pte_v;	// PTW.scala:132:18, :375:{8,16}, :376:{8,40}, :377:25
    end
    mem_resp_valid <= io_mem_resp_valid;	// PTW.scala:134:31
    mem_resp_data <= io_mem_resp_bits_data;	// PTW.scala:135:30
    if (_GEN_23 & r == 3'h0) begin	// PTW.scala:109:18, :176:19, :181:{46,63}, :182:18, :184:15
      tags_0 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_0 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h1) begin	// PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_1 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_1 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h2) begin	// PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_2 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_2 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h3) begin	// PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_3 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_3 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h4) begin	// Mux.scala:47:69, PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_4 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_4 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h5) begin	// Mux.scala:47:69, PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_5 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_5 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & r == 3'h6) begin	// Mux.scala:47:69, PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_6 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_6 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    if (_GEN_23 & (&r)) begin	// PTW.scala:176:19, :181:{46,63}, :182:18, :184:15
      tags_7 <= _GEN_25;	// PTW.scala:176:19, :184:15
      data_7 <= mem_resp_data[29:10];	// PTW.scala:135:30, :148:23, :177:19
    end
    pte_hit <= (|state) & _GEN_17 & pte_cache_hit;	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :114:30, :193:10, :195:24
    l2_refill <=
      mem_resp_valid & ~traverse & res_v & ~(|(mem_resp_data[63:30])) & _leaf_T_8;	// PTW.scala:134:31, :135:30, :149:36, :152:{102,110}, :154:{20,32}, :156:{33,48}, :201:26, :388:25, :390:21, :394:17, package.scala:32:86
    if (writeEnable) begin	// PTW.scala:227:21
      if (r_pte_g)	// PTW.scala:132:18
        g_0 <= g_0 | mask;	// OneHot.scala:58:35, PTW.scala:223:16, :239:41
      else	// PTW.scala:132:18
        g_0 <= g_0 & ~mask;	// OneHot.scala:58:35, PTW.scala:223:16, :239:{56,58}
    end
    s1_valid <= readEnable & _arb_io_out_bits_valid;	// PTW.scala:112:19, :251:31, :252:{27,37}
    s2_valid <= s1_valid;	// PTW.scala:252:27, :253:27
    if (s1_valid) begin	// PTW.scala:252:27
      automatic logic [1023:0] _GEN_33;	// PTW.scala:226:34
      automatic logic [1023:0] _GEN_34;	// PTW.scala:257:41
      r_1 <= _l2_tlb_ram_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, Reg.scala:15:16
      _GEN_33 = valid_1_0 >> _GEN_26;	// PTW.scala:224:24, :226:34
      s2_valid_vec <= _GEN_33[0];	// PTW.scala:226:34, Reg.scala:15:16
      _GEN_34 = g_0 >> _GEN_26;	// PTW.scala:223:16, :226:34, :257:41
      s2_g_vec_0 <= _GEN_34[0];	// PTW.scala:257:41, Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:84];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h55; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        state = _RANDOM[7'h0][2:0];	// PTW.scala:109:18
        resp_valid_0 = _RANDOM[7'h0][3];	// PTW.scala:109:18, :116:23
        resp_valid_1 = _RANDOM[7'h0][4];	// PTW.scala:109:18, :116:23
        invalidated = _RANDOM[7'h0][5];	// PTW.scala:109:18, :125:24
        count = _RANDOM[7'h0][7:6];	// PTW.scala:109:18, :126:18
        resp_ae = _RANDOM[7'h0][8];	// PTW.scala:109:18, :127:24
        r_req_addr = {_RANDOM[7'h0][31:10], _RANDOM[7'h1][4:0]};	// PTW.scala:109:18, :130:18
        r_req_dest = _RANDOM[7'h1][5];	// PTW.scala:130:18, :131:23
        r_pte_ppn = {_RANDOM[7'h1][31:6], _RANDOM[7'h2][27:0]};	// PTW.scala:130:18, :132:18
        r_pte_d = _RANDOM[7'h2][30];	// PTW.scala:132:18
        r_pte_a = _RANDOM[7'h2][31];	// PTW.scala:132:18
        r_pte_g = _RANDOM[7'h3][0];	// PTW.scala:132:18
        r_pte_u = _RANDOM[7'h3][1];	// PTW.scala:132:18
        r_pte_x = _RANDOM[7'h3][2];	// PTW.scala:132:18
        r_pte_w = _RANDOM[7'h3][3];	// PTW.scala:132:18
        r_pte_r = _RANDOM[7'h3][4];	// PTW.scala:132:18
        r_pte_v = _RANDOM[7'h3][5];	// PTW.scala:132:18
        mem_resp_valid = _RANDOM[7'h3][6];	// PTW.scala:132:18, :134:31
        mem_resp_data = {_RANDOM[7'h3][31:7], _RANDOM[7'h4], _RANDOM[7'h5][6:0]};	// PTW.scala:132:18, :135:30
        state_reg = _RANDOM[7'h5][13:7];	// PTW.scala:135:30, Replacement.scala:168:70
        valid = _RANDOM[7'h5][21:14];	// PTW.scala:135:30, :175:24
        tags_0 = {_RANDOM[7'h5][31:22], _RANDOM[7'h6][21:0]};	// PTW.scala:135:30, :176:19
        tags_1 = {_RANDOM[7'h6][31:22], _RANDOM[7'h7][21:0]};	// PTW.scala:176:19
        tags_2 = {_RANDOM[7'h7][31:22], _RANDOM[7'h8][21:0]};	// PTW.scala:176:19
        tags_3 = {_RANDOM[7'h8][31:22], _RANDOM[7'h9][21:0]};	// PTW.scala:176:19
        tags_4 = {_RANDOM[7'h9][31:22], _RANDOM[7'hA][21:0]};	// PTW.scala:176:19
        tags_5 = {_RANDOM[7'hA][31:22], _RANDOM[7'hB][21:0]};	// PTW.scala:176:19
        tags_6 = {_RANDOM[7'hB][31:22], _RANDOM[7'hC][21:0]};	// PTW.scala:176:19
        tags_7 = {_RANDOM[7'hC][31:22], _RANDOM[7'hD][21:0]};	// PTW.scala:176:19
        data_0 = {_RANDOM[7'hD][31:22], _RANDOM[7'hE][9:0]};	// PTW.scala:176:19, :177:19
        data_1 = _RANDOM[7'hE][29:10];	// PTW.scala:177:19
        data_2 = {_RANDOM[7'hE][31:30], _RANDOM[7'hF][17:0]};	// PTW.scala:177:19
        data_3 = {_RANDOM[7'hF][31:18], _RANDOM[7'h10][5:0]};	// PTW.scala:177:19
        data_4 = _RANDOM[7'h10][25:6];	// PTW.scala:177:19
        data_5 = {_RANDOM[7'h10][31:26], _RANDOM[7'h11][13:0]};	// PTW.scala:177:19
        data_6 = {_RANDOM[7'h11][31:14], _RANDOM[7'h12][1:0]};	// PTW.scala:177:19
        data_7 = _RANDOM[7'h12][21:2];	// PTW.scala:177:19
        pte_hit = _RANDOM[7'h12][22];	// PTW.scala:177:19, :195:24
        l2_refill = _RANDOM[7'h12][23];	// PTW.scala:177:19, :201:26
        g_0 =
          {_RANDOM[7'h12][31:24],
           _RANDOM[7'h13],
           _RANDOM[7'h14],
           _RANDOM[7'h15],
           _RANDOM[7'h16],
           _RANDOM[7'h17],
           _RANDOM[7'h18],
           _RANDOM[7'h19],
           _RANDOM[7'h1A],
           _RANDOM[7'h1B],
           _RANDOM[7'h1C],
           _RANDOM[7'h1D],
           _RANDOM[7'h1E],
           _RANDOM[7'h1F],
           _RANDOM[7'h20],
           _RANDOM[7'h21],
           _RANDOM[7'h22],
           _RANDOM[7'h23],
           _RANDOM[7'h24],
           _RANDOM[7'h25],
           _RANDOM[7'h26],
           _RANDOM[7'h27],
           _RANDOM[7'h28],
           _RANDOM[7'h29],
           _RANDOM[7'h2A],
           _RANDOM[7'h2B],
           _RANDOM[7'h2C],
           _RANDOM[7'h2D],
           _RANDOM[7'h2E],
           _RANDOM[7'h2F],
           _RANDOM[7'h30],
           _RANDOM[7'h31],
           _RANDOM[7'h32][23:0]};	// PTW.scala:177:19, :223:16
        valid_1_0 =
          {_RANDOM[7'h32][31:24],
           _RANDOM[7'h33],
           _RANDOM[7'h34],
           _RANDOM[7'h35],
           _RANDOM[7'h36],
           _RANDOM[7'h37],
           _RANDOM[7'h38],
           _RANDOM[7'h39],
           _RANDOM[7'h3A],
           _RANDOM[7'h3B],
           _RANDOM[7'h3C],
           _RANDOM[7'h3D],
           _RANDOM[7'h3E],
           _RANDOM[7'h3F],
           _RANDOM[7'h40],
           _RANDOM[7'h41],
           _RANDOM[7'h42],
           _RANDOM[7'h43],
           _RANDOM[7'h44],
           _RANDOM[7'h45],
           _RANDOM[7'h46],
           _RANDOM[7'h47],
           _RANDOM[7'h48],
           _RANDOM[7'h49],
           _RANDOM[7'h4A],
           _RANDOM[7'h4B],
           _RANDOM[7'h4C],
           _RANDOM[7'h4D],
           _RANDOM[7'h4E],
           _RANDOM[7'h4F],
           _RANDOM[7'h50],
           _RANDOM[7'h51],
           _RANDOM[7'h52][23:0]};	// PTW.scala:223:16, :224:24
        s1_valid = _RANDOM[7'h52][24];	// PTW.scala:224:24, :252:27
        s2_valid = _RANDOM[7'h52][25];	// PTW.scala:224:24, :253:27
        r_1 = {_RANDOM[7'h52][31:26], _RANDOM[7'h53], _RANDOM[7'h54][5:0]};	// PTW.scala:224:24, Reg.scala:15:16
        s2_valid_vec = _RANDOM[7'h54][6];	// Reg.scala:15:16
        s2_g_vec_0 = _RANDOM[7'h54][7];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Arbiter arb (	// PTW.scala:112:19
    .io_in_0_valid          (io_requestor_0_req_valid),
    .io_in_0_bits_bits_addr (io_requestor_0_req_bits_bits_addr),
    .io_in_1_valid          (io_requestor_1_req_valid),
    .io_in_1_bits_valid     (io_requestor_1_req_bits_valid),
    .io_in_1_bits_bits_addr (io_requestor_1_req_bits_bits_addr),
    .io_out_ready           (_arb_io_out_ready_T_2),	// PTW.scala:114:43
    .io_in_1_ready          (io_requestor_1_req_ready),
    .io_out_valid           (_arb_io_out_valid),
    .io_out_bits_valid      (_arb_io_out_bits_valid),
    .io_out_bits_bits_addr  (_arb_io_out_bits_bits_addr),
    .io_chosen              (_arb_io_chosen)
  );
  l2_tlb_ram_0_1024x44 l2_tlb_ram_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (writeEnable ? writeAddr : readAddr),	// DescribedSRAM.scala:19:26, PTW.scala:227:21, :254:54, package.scala:154:13
    .RW0_en    (readEnable | writeEnable),	// DescribedSRAM.scala:19:26, PTW.scala:227:21, :251:31
    .RW0_clk   (clock),
    .RW0_wmode (l2_refill),	// PTW.scala:201:26
    .RW0_wdata
      ({^{r_req_addr[26:10],
          r_pte_ppn[19:0],
          r_pte_d,
          r_pte_a,
          r_pte_u,
          r_pte_x,
          r_pte_w,
          r_pte_r},
        r_req_addr[26:10],
        r_pte_ppn[19:0],
        r_pte_d,
        r_pte_a,
        r_pte_u,
        r_pte_x,
        r_pte_w,
        r_pte_r}),	// Cat.scala:30:58, ECC.scala:71:59, PTW.scala:130:18, :132:18, :231:13, :233:78, package.scala:154:13
    .RW0_rdata (_l2_tlb_ram_0_ext_RW0_rdata)
  );
  assign io_requestor_0_req_ready = _arb_io_out_ready_T_2;	// PTW.scala:114:43
  assign io_requestor_0_resp_valid = resp_valid_0;	// PTW.scala:116:23
  assign io_requestor_0_resp_bits_ae = resp_ae;	// PTW.scala:127:24
  assign io_requestor_0_resp_bits_pte_ppn = r_pte_ppn;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_d = r_pte_d;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_a = r_pte_a;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_g = r_pte_g;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_u = r_pte_u;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_x = r_pte_x;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_w = r_pte_w;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_r = r_pte_r;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_pte_v = r_pte_v;	// PTW.scala:132:18
  assign io_requestor_0_resp_bits_level = count;	// PTW.scala:126:18
  assign io_requestor_0_resp_bits_homogeneous = homogeneous;	// PTW.scala:310:36
  assign io_requestor_1_resp_valid = resp_valid_1;	// PTW.scala:116:23
  assign io_requestor_1_resp_bits_ae = resp_ae;	// PTW.scala:127:24
  assign io_requestor_1_resp_bits_pte_ppn = r_pte_ppn;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_d = r_pte_d;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_a = r_pte_a;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_g = r_pte_g;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_u = r_pte_u;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_x = r_pte_x;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_w = r_pte_w;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_r = r_pte_r;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_pte_v = r_pte_v;	// PTW.scala:132:18
  assign io_requestor_1_resp_bits_level = count;	// PTW.scala:126:18
  assign io_requestor_1_resp_bits_homogeneous = homogeneous;	// PTW.scala:310:36
  assign io_mem_req_valid = _r_pte_T_5 | state == 3'h3;	// PTW.scala:109:18, :184:15, :187:24, :287:{39,48}
  assign io_mem_req_bits_addr = {r_pte_ppn[27:0], vpn_idx, 3'h0};	// PTW.scala:109:18, :132:18, :292:24, package.scala:32:76
  assign io_mem_s1_kill = s2_hit | state != 3'h2;	// PTW.scala:109:18, :184:15, :263:27, :295:{28,37}
endmodule

