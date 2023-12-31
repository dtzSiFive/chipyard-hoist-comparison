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

module PTW_2(
  input         clock,
                reset,
                io_requestor_0_req_valid,
  input  [20:0] io_requestor_0_req_bits_bits_addr,
  input         io_requestor_1_req_valid,
                io_requestor_1_req_bits_valid,
  input  [20:0] io_requestor_1_req_bits_bits_addr,
  input         io_dpath_sfence_valid,
                io_dpath_sfence_bits_rs1,
                io_dpath_sfence_bits_rs2,
  input  [32:0] io_dpath_sfence_bits_addr,
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
  output        io_requestor_0_resp_valid
);

  wire [37:0]   _l2_tlb_ram_0_ext_R0_data;	// DescribedSRAM.scala:19:26
  wire          _arb_io_out_valid;	// PTW.scala:112:19
  wire          _arb_io_out_bits_valid;	// PTW.scala:112:19
  wire [20:0]   _arb_io_out_bits_bits_addr;	// PTW.scala:112:19
  wire          _arb_io_chosen;	// PTW.scala:112:19
  reg  [2:0]    state;	// PTW.scala:109:18
  reg           resp_valid_0;	// PTW.scala:116:23
  reg  [1:0]    count;	// PTW.scala:126:18
  reg  [20:0]   r_req_addr;	// PTW.scala:130:18
  reg           r_req_dest;	// PTW.scala:131:23
  reg  [53:0]   r_pte_ppn;	// PTW.scala:132:18
  reg           r_pte_d;	// PTW.scala:132:18
  reg           r_pte_a;	// PTW.scala:132:18
  reg           r_pte_u;	// PTW.scala:132:18
  reg           r_pte_x;	// PTW.scala:132:18
  reg           r_pte_w;	// PTW.scala:132:18
  reg           r_pte_r;	// PTW.scala:132:18
  wire          readEnable = ~(|state) & _arb_io_out_valid;	// Decoupled.scala:40:37, PTW.scala:109:18, :112:19, :114:30
  reg  [1023:0] valid_1_0;	// PTW.scala:224:24
  reg           s1_valid;	// PTW.scala:252:27
  reg           s2_valid;	// PTW.scala:253:27
  reg  [37:0]   r_1;	// Reg.scala:15:16
  reg           s2_valid_vec;	// Reg.scala:15:16
  wire          s2_error = s2_valid_vec & ^r_1;	// ECC.scala:77:27, PTW.scala:258:81, Reg.scala:15:16
  wire          s2_hit_vec_0 = s2_valid_vec & r_req_addr[20:10] == r_1[36:26];	// PTW.scala:130:18, :261:59, :262:{83,93}, Reg.scala:15:16, package.scala:154:13
  wire          s2_hit = s2_valid & s2_hit_vec_0;	// PTW.scala:253:27, :262:83, :263:27
  wire          _GEN = state == 3'h1;	// Conditional.scala:37:30, PTW.scala:109:18, :341:26
  wire          _GEN_0 = state == 3'h2;	// Conditional.scala:37:30, PTW.scala:109:18, :184:15
  wire          _GEN_1 = state == 3'h4;	// Conditional.scala:37:30, Mux.scala:47:69, PTW.scala:109:18
  wire          _GEN_2 = s2_hit & ~s2_error;	// PTW.scala:258:81, :263:27, :375:19, :381:16
  `ifndef SYNTHESIS	// PTW.scala:198:9
    always @(posedge clock) begin	// PTW.scala:198:9
      if (~(~(s2_hit & ~(~(|state) | _GEN | _GEN_0) & _GEN_1 & ~(count[1]))
            | reset)) begin	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :114:30, :126:18, :156:57, :196:26, :198:{9,10,32}, :263:27
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
      if (_GEN_2 & ~(state == 3'h1 | _GEN_0 | reset)) begin	// Conditional.scala:37:30, PTW.scala:109:18, :187:24, :341:26, :381:16, :382:11
        if (`ASSERT_VERBOSE_COND_)	// PTW.scala:382:11
          $error("Assertion failed\n    at PTW.scala:382 assert(state === s_req || state === s_wait1)\n");	// PTW.scala:382:11
        if (`STOP_COND_)	// PTW.scala:382:11
          $fatal;	// PTW.scala:382:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic        _leaf_T_5;	// PTW.scala:191:46
    automatic logic        _leaf_T_8;	// package.scala:32:86
    automatic logic        _GEN_3;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_1;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_2;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_3;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_4;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_5;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_6;	// package.scala:32:76
    automatic logic [19:0] pmpHomogeneous_pgMask_7;	// package.scala:32:76
    automatic logic        homogeneous;	// PTW.scala:310:36
    _leaf_T_5 = count == 2'h1;	// PTW.scala:126:18, :191:46
    _leaf_T_8 = count == 2'h2;	// PTW.scala:126:18, :156:57, package.scala:32:86
    _GEN_3 = (&count) | _leaf_T_8;	// PTW.scala:126:18, package.scala:32:{76,86}
    pmpHomogeneous_pgMask_1 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_2 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_3 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_4 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_5 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_6 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    pmpHomogeneous_pgMask_7 = _GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000;	// PTW.scala:191:46, package.scala:32:76
    homogeneous =
      ((&count) | _leaf_T_8)
      & (io_dpath_pmp_0_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_0_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_0_mask[20] : io_dpath_pmp_0_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_0_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_0_addr[29:19]))
                      : (|(io_dpath_pmp_0_addr[29:28])))
           : ~(io_dpath_pmp_0_cfg_a[0]) | io_dpath_pmp_0_addr == 30'h0
             | (|(io_dpath_pmp_0_addr[29:10]
                  & (_GEN_3 ? 20'hFFFFF : _leaf_T_5 ? 20'hFFE00 : 20'hC0000))))
      & (io_dpath_pmp_1_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_1_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_1_mask[20] : io_dpath_pmp_1_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_1_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_1_addr[29:19]))
                      : (|(io_dpath_pmp_1_addr[29:28])))
           : ~(io_dpath_pmp_1_cfg_a[0])
             | (|(io_dpath_pmp_0_addr[29:10] & pmpHomogeneous_pgMask_1))
             | io_dpath_pmp_1_addr == 30'h0 | io_dpath_pmp_0_addr == 30'h0
             & (|(io_dpath_pmp_1_addr[29:10] & pmpHomogeneous_pgMask_1)))
      & (io_dpath_pmp_2_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_2_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_2_mask[20] : io_dpath_pmp_2_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_2_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_2_addr[29:19]))
                      : (|(io_dpath_pmp_2_addr[29:28])))
           : ~(io_dpath_pmp_2_cfg_a[0])
             | (|(io_dpath_pmp_1_addr[29:10] & pmpHomogeneous_pgMask_2))
             | io_dpath_pmp_2_addr == 30'h0 | io_dpath_pmp_1_addr == 30'h0
             & (|(io_dpath_pmp_2_addr[29:10] & pmpHomogeneous_pgMask_2)))
      & (io_dpath_pmp_3_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_3_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_3_mask[20] : io_dpath_pmp_3_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_3_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_3_addr[29:19]))
                      : (|(io_dpath_pmp_3_addr[29:28])))
           : ~(io_dpath_pmp_3_cfg_a[0])
             | (|(io_dpath_pmp_2_addr[29:10] & pmpHomogeneous_pgMask_3))
             | io_dpath_pmp_3_addr == 30'h0 | io_dpath_pmp_2_addr == 30'h0
             & (|(io_dpath_pmp_3_addr[29:10] & pmpHomogeneous_pgMask_3)))
      & (io_dpath_pmp_4_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_4_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_4_mask[20] : io_dpath_pmp_4_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_4_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_4_addr[29:19]))
                      : (|(io_dpath_pmp_4_addr[29:28])))
           : ~(io_dpath_pmp_4_cfg_a[0])
             | (|(io_dpath_pmp_3_addr[29:10] & pmpHomogeneous_pgMask_4))
             | io_dpath_pmp_4_addr == 30'h0 | io_dpath_pmp_3_addr == 30'h0
             & (|(io_dpath_pmp_4_addr[29:10] & pmpHomogeneous_pgMask_4)))
      & (io_dpath_pmp_5_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_5_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_5_mask[20] : io_dpath_pmp_5_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_5_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_5_addr[29:19]))
                      : (|(io_dpath_pmp_5_addr[29:28])))
           : ~(io_dpath_pmp_5_cfg_a[0])
             | (|(io_dpath_pmp_4_addr[29:10] & pmpHomogeneous_pgMask_5))
             | io_dpath_pmp_5_addr == 30'h0 | io_dpath_pmp_4_addr == 30'h0
             & (|(io_dpath_pmp_5_addr[29:10] & pmpHomogeneous_pgMask_5)))
      & (io_dpath_pmp_6_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_6_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_6_mask[20] : io_dpath_pmp_6_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_6_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_6_addr[29:19]))
                      : (|(io_dpath_pmp_6_addr[29:28])))
           : ~(io_dpath_pmp_6_cfg_a[0])
             | (|(io_dpath_pmp_5_addr[29:10] & pmpHomogeneous_pgMask_6))
             | io_dpath_pmp_6_addr == 30'h0 | io_dpath_pmp_5_addr == 30'h0
             & (|(io_dpath_pmp_6_addr[29:10] & pmpHomogeneous_pgMask_6)))
      & (io_dpath_pmp_7_cfg_a[1]
           ? (_GEN_3
                ? io_dpath_pmp_7_mask[11]
                : _leaf_T_5 ? io_dpath_pmp_7_mask[20] : io_dpath_pmp_7_mask[29])
             | (_GEN_3
                  ? (|(io_dpath_pmp_7_addr[29:10]))
                  : _leaf_T_5
                      ? (|(io_dpath_pmp_7_addr[29:19]))
                      : (|(io_dpath_pmp_7_addr[29:28])))
           : ~(io_dpath_pmp_7_cfg_a[0])
             | (|(io_dpath_pmp_6_addr[29:10] & pmpHomogeneous_pgMask_7))
             | io_dpath_pmp_7_addr == 30'h0 | io_dpath_pmp_6_addr == 30'h0
             & (|(io_dpath_pmp_7_addr[29:10] & pmpHomogeneous_pgMask_7)));	// PMP.scala:47:20, :48:26, :62:48, :99:93, :100:{21,66,78}, :108:32, :109:32, :112:{40,58}, :113:{40,53}, :115:62, :120:{8,45,58}, :139:40, PTW.scala:126:18, :191:46, :310:36, package.scala:32:{76,86}
    if (reset) begin
      state <= 3'h0;	// PTW.scala:109:18
      valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
    end
    else begin
      if (_GEN_2)	// PTW.scala:381:16
        state <= 3'h0;	// PTW.scala:109:18
      else if (|state) begin	// PTW.scala:109:18, :114:30
        if (_GEN)	// Conditional.scala:37:30
          state <= 3'h1;	// PTW.scala:109:18, :341:26
        else if (_GEN_0) begin	// Conditional.scala:37:30
          if (s2_hit)	// PTW.scala:263:27
            state <= 3'h1;	// PTW.scala:109:18, :341:26
          else	// PTW.scala:263:27
            state <= 3'h4;	// Mux.scala:47:69, PTW.scala:109:18
        end
        else if (_GEN_1)	// Conditional.scala:37:30
          state <= 3'h5;	// PTW.scala:109:18, :349:18, :351:35, :353:20
        else if (&state)	// Conditional.scala:37:30, PTW.scala:109:18
          state <= 3'h0;	// PTW.scala:109:18
      end
      else if (readEnable)	// Decoupled.scala:40:37
        state <= {2'h0, _arb_io_out_bits_valid};	// PTW.scala:109:18, :112:19, :271:22, :332:26
      if (s2_valid & s2_error)	// PTW.scala:253:27, :258:81, :259:20
        valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
      else if (io_dpath_sfence_valid) begin
        if (io_dpath_sfence_bits_rs1)
          valid_1_0 <= valid_1_0 & ~(1024'h1 << io_dpath_sfence_bits_addr[21:12]);	// OneHot.scala:58:35, PTW.scala:224:24, :246:{52,54,89}
        else
          valid_1_0 <= 1024'h0;	// PTW.scala:224:{24,28}
      end
    end
    resp_valid_0 <=
      _GEN_2 & ~r_req_dest | ~(~(|state) | _GEN | _GEN_0 | _GEN_1) & (&state)
      & ~r_req_dest;	// Conditional.scala:37:30, :39:67, :40:58, PTW.scala:109:18, :114:30, :116:23, :131:23, :351:35, :359:30, :381:{16,30}, :384:28
    if (_GEN_2)	// PTW.scala:381:16
      count <= 2'h2;	// PTW.scala:126:18, :156:57
    else if (|state) begin	// PTW.scala:109:18, :114:30
      if (_GEN | _GEN_0 | _GEN_1 | ~((&state) & ~homogeneous)) begin	// Conditional.scala:37:30, :39:67, PTW.scala:109:18, :126:18, :310:36, :337:28, :361:{13,27}, :362:15
      end
      else	// Conditional.scala:39:67, PTW.scala:126:18, :337:28
        count <= 2'h2;	// PTW.scala:126:18, :156:57
    end
    else	// PTW.scala:114:30
      count <= 2'h0;	// PTW.scala:126:18, :271:22
    if (readEnable) begin	// Decoupled.scala:40:37
      r_req_addr <= _arb_io_out_bits_bits_addr;	// PTW.scala:112:19, :130:18
      r_req_dest <= _arb_io_chosen;	// PTW.scala:112:19, :131:23
    end
    if (s2_hit & ~s2_error) begin	// PTW.scala:258:81, :263:27, :375:{16,19}
      r_pte_ppn <= {34'h0, r_1[25:6]};	// PTW.scala:132:18, :261:59, :272:14, Reg.scala:15:16
      r_pte_d <= r_1[5];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      r_pte_a <= r_1[4];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      r_pte_u <= r_1[3];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      r_pte_x <= r_1[2];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      r_pte_w <= r_1[1];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
      r_pte_r <= r_1[0];	// PTW.scala:132:18, :261:59, Reg.scala:15:16
    end
    else if ((&state) & ~homogeneous) begin	// PTW.scala:109:18, :310:36, :376:{15,40,43}
      if (count[0])	// PTW.scala:126:18, package.scala:31:49
        r_pte_ppn <= {r_pte_ppn[53:9], r_req_addr[8:0]};	// Cat.scala:30:58, PTW.scala:130:18, :132:18, :163:{69,99}
      else	// package.scala:31:49
        r_pte_ppn <= {r_pte_ppn[53:18], r_req_addr[17:0]};	// Cat.scala:30:58, PTW.scala:130:18, :132:18, :163:{69,99}
    end
    else if (readEnable)	// Decoupled.scala:40:37
      r_pte_ppn <= 54'h0;	// PTW.scala:132:18
    s1_valid <= readEnable & _arb_io_out_bits_valid;	// Decoupled.scala:40:37, PTW.scala:112:19, :252:{27,37}
    s2_valid <= s1_valid;	// PTW.scala:252:27, :253:27
    if (s1_valid) begin	// PTW.scala:252:27
      automatic logic [1023:0] _GEN_4;	// PTW.scala:226:34
      r_1 <= _l2_tlb_ram_0_ext_R0_data;	// DescribedSRAM.scala:19:26, Reg.scala:15:16
      _GEN_4 = valid_1_0 >> r_req_addr[9:0];	// PTW.scala:130:18, :224:24, :226:34, package.scala:154:13
      s2_valid_vec <= _GEN_4[0];	// PTW.scala:226:34, Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:83];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h54; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        state = _RANDOM[7'h0][2:0];	// PTW.scala:109:18
        resp_valid_0 = _RANDOM[7'h0][3];	// PTW.scala:109:18, :116:23
        count = _RANDOM[7'h0][7:6];	// PTW.scala:109:18, :126:18
        r_req_addr = _RANDOM[7'h0][30:10];	// PTW.scala:109:18, :130:18
        r_req_dest = _RANDOM[7'h0][31];	// PTW.scala:109:18, :131:23
        r_pte_ppn = {_RANDOM[7'h1], _RANDOM[7'h2][21:0]};	// PTW.scala:132:18
        r_pte_d = _RANDOM[7'h2][24];	// PTW.scala:132:18
        r_pte_a = _RANDOM[7'h2][25];	// PTW.scala:132:18
        r_pte_u = _RANDOM[7'h2][27];	// PTW.scala:132:18
        r_pte_x = _RANDOM[7'h2][28];	// PTW.scala:132:18
        r_pte_w = _RANDOM[7'h2][29];	// PTW.scala:132:18
        r_pte_r = _RANDOM[7'h2][30];	// PTW.scala:132:18
        valid_1_0 =
          {_RANDOM[7'h32][31:18],
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
           _RANDOM[7'h52][17:0]};	// PTW.scala:224:24
        s1_valid = _RANDOM[7'h52][18];	// PTW.scala:224:24, :252:27
        s2_valid = _RANDOM[7'h52][19];	// PTW.scala:224:24, :253:27
        r_1 = {_RANDOM[7'h52][31:20], _RANDOM[7'h53][25:0]};	// PTW.scala:224:24, Reg.scala:15:16
        s2_valid_vec = _RANDOM[7'h53][26];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Arbiter_2 arb (	// PTW.scala:112:19
    .io_in_0_valid          (io_requestor_0_req_valid),
    .io_in_0_bits_bits_addr (io_requestor_0_req_bits_bits_addr),
    .io_in_1_valid          (io_requestor_1_req_valid),
    .io_in_1_bits_valid     (io_requestor_1_req_bits_valid),
    .io_in_1_bits_bits_addr (io_requestor_1_req_bits_bits_addr),
    .io_out_valid           (_arb_io_out_valid),
    .io_out_bits_valid      (_arb_io_out_bits_valid),
    .io_out_bits_bits_addr  (_arb_io_out_bits_bits_addr),
    .io_chosen              (_arb_io_chosen)
  );
  l2_tlb_ram_0_1024x38 l2_tlb_ram_0_ext (	// DescribedSRAM.scala:19:26
    .R0_addr (_arb_io_out_bits_bits_addr[9:0]),	// PTW.scala:112:19, :254:54
    .R0_en   (readEnable),	// Decoupled.scala:40:37
    .R0_clk  (clock),
    .R0_data (_l2_tlb_ram_0_ext_R0_data)
  );
  assign io_requestor_0_resp_valid = resp_valid_0;	// PTW.scala:116:23
endmodule

