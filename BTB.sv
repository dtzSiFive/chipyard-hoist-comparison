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

module BTB(
  input         clock,
                reset,
  input  [38:0] io_req_bits_addr,
  input         io_btb_update_valid,
  input  [4:0]  io_btb_update_bits_prediction_entry,
  input  [38:0] io_btb_update_bits_pc,
  input         io_btb_update_bits_isValid,
  input  [38:0] io_btb_update_bits_br_pc,
  input  [1:0]  io_btb_update_bits_cfiType,
  input         io_bht_update_valid,
  input  [7:0]  io_bht_update_bits_prediction_history,
  input  [38:0] io_bht_update_bits_pc,
  input         io_bht_update_bits_branch,
                io_bht_update_bits_taken,
                io_bht_update_bits_mispredict,
                io_bht_advance_valid,
                io_bht_advance_bits_bht_value,
                io_ras_update_valid,
  input  [1:0]  io_ras_update_bits_cfiType,
  input  [38:0] io_ras_update_bits_returnAddr,
  input         io_flush,
  output        io_resp_valid,
                io_resp_bits_taken,
                io_resp_bits_bridx,
  output [38:0] io_resp_bits_target,
  output [4:0]  io_resp_bits_entry,
  output [7:0]  io_resp_bits_bht_history,
  output        io_resp_bits_bht_value,
                io_ras_head_valid,
  output [38:0] io_ras_head_bits
);

  wire             _table_ext_R0_data;	// BTB.scala:118:26
  reg  [12:0]      idxs_0;	// BTB.scala:201:17
  reg  [12:0]      idxs_1;	// BTB.scala:201:17
  reg  [12:0]      idxs_2;	// BTB.scala:201:17
  reg  [12:0]      idxs_3;	// BTB.scala:201:17
  reg  [12:0]      idxs_4;	// BTB.scala:201:17
  reg  [12:0]      idxs_5;	// BTB.scala:201:17
  reg  [12:0]      idxs_6;	// BTB.scala:201:17
  reg  [12:0]      idxs_7;	// BTB.scala:201:17
  reg  [12:0]      idxs_8;	// BTB.scala:201:17
  reg  [12:0]      idxs_9;	// BTB.scala:201:17
  reg  [12:0]      idxs_10;	// BTB.scala:201:17
  reg  [12:0]      idxs_11;	// BTB.scala:201:17
  reg  [12:0]      idxs_12;	// BTB.scala:201:17
  reg  [12:0]      idxs_13;	// BTB.scala:201:17
  reg  [12:0]      idxs_14;	// BTB.scala:201:17
  reg  [12:0]      idxs_15;	// BTB.scala:201:17
  reg  [12:0]      idxs_16;	// BTB.scala:201:17
  reg  [12:0]      idxs_17;	// BTB.scala:201:17
  reg  [12:0]      idxs_18;	// BTB.scala:201:17
  reg  [12:0]      idxs_19;	// BTB.scala:201:17
  reg  [12:0]      idxs_20;	// BTB.scala:201:17
  reg  [12:0]      idxs_21;	// BTB.scala:201:17
  reg  [12:0]      idxs_22;	// BTB.scala:201:17
  reg  [12:0]      idxs_23;	// BTB.scala:201:17
  reg  [12:0]      idxs_24;	// BTB.scala:201:17
  reg  [12:0]      idxs_25;	// BTB.scala:201:17
  reg  [12:0]      idxs_26;	// BTB.scala:201:17
  reg  [12:0]      idxs_27;	// BTB.scala:201:17
  reg  [2:0]       idxPages_0;	// BTB.scala:202:21
  reg  [2:0]       idxPages_1;	// BTB.scala:202:21
  reg  [2:0]       idxPages_2;	// BTB.scala:202:21
  reg  [2:0]       idxPages_3;	// BTB.scala:202:21
  reg  [2:0]       idxPages_4;	// BTB.scala:202:21
  reg  [2:0]       idxPages_5;	// BTB.scala:202:21
  reg  [2:0]       idxPages_6;	// BTB.scala:202:21
  reg  [2:0]       idxPages_7;	// BTB.scala:202:21
  reg  [2:0]       idxPages_8;	// BTB.scala:202:21
  reg  [2:0]       idxPages_9;	// BTB.scala:202:21
  reg  [2:0]       idxPages_10;	// BTB.scala:202:21
  reg  [2:0]       idxPages_11;	// BTB.scala:202:21
  reg  [2:0]       idxPages_12;	// BTB.scala:202:21
  reg  [2:0]       idxPages_13;	// BTB.scala:202:21
  reg  [2:0]       idxPages_14;	// BTB.scala:202:21
  reg  [2:0]       idxPages_15;	// BTB.scala:202:21
  reg  [2:0]       idxPages_16;	// BTB.scala:202:21
  reg  [2:0]       idxPages_17;	// BTB.scala:202:21
  reg  [2:0]       idxPages_18;	// BTB.scala:202:21
  reg  [2:0]       idxPages_19;	// BTB.scala:202:21
  reg  [2:0]       idxPages_20;	// BTB.scala:202:21
  reg  [2:0]       idxPages_21;	// BTB.scala:202:21
  reg  [2:0]       idxPages_22;	// BTB.scala:202:21
  reg  [2:0]       idxPages_23;	// BTB.scala:202:21
  reg  [2:0]       idxPages_24;	// BTB.scala:202:21
  reg  [2:0]       idxPages_25;	// BTB.scala:202:21
  reg  [2:0]       idxPages_26;	// BTB.scala:202:21
  reg  [2:0]       idxPages_27;	// BTB.scala:202:21
  reg  [12:0]      tgts_0;	// BTB.scala:203:17
  reg  [12:0]      tgts_1;	// BTB.scala:203:17
  reg  [12:0]      tgts_2;	// BTB.scala:203:17
  reg  [12:0]      tgts_3;	// BTB.scala:203:17
  reg  [12:0]      tgts_4;	// BTB.scala:203:17
  reg  [12:0]      tgts_5;	// BTB.scala:203:17
  reg  [12:0]      tgts_6;	// BTB.scala:203:17
  reg  [12:0]      tgts_7;	// BTB.scala:203:17
  reg  [12:0]      tgts_8;	// BTB.scala:203:17
  reg  [12:0]      tgts_9;	// BTB.scala:203:17
  reg  [12:0]      tgts_10;	// BTB.scala:203:17
  reg  [12:0]      tgts_11;	// BTB.scala:203:17
  reg  [12:0]      tgts_12;	// BTB.scala:203:17
  reg  [12:0]      tgts_13;	// BTB.scala:203:17
  reg  [12:0]      tgts_14;	// BTB.scala:203:17
  reg  [12:0]      tgts_15;	// BTB.scala:203:17
  reg  [12:0]      tgts_16;	// BTB.scala:203:17
  reg  [12:0]      tgts_17;	// BTB.scala:203:17
  reg  [12:0]      tgts_18;	// BTB.scala:203:17
  reg  [12:0]      tgts_19;	// BTB.scala:203:17
  reg  [12:0]      tgts_20;	// BTB.scala:203:17
  reg  [12:0]      tgts_21;	// BTB.scala:203:17
  reg  [12:0]      tgts_22;	// BTB.scala:203:17
  reg  [12:0]      tgts_23;	// BTB.scala:203:17
  reg  [12:0]      tgts_24;	// BTB.scala:203:17
  reg  [12:0]      tgts_25;	// BTB.scala:203:17
  reg  [12:0]      tgts_26;	// BTB.scala:203:17
  reg  [12:0]      tgts_27;	// BTB.scala:203:17
  reg  [2:0]       tgtPages_0;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_1;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_2;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_3;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_4;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_5;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_6;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_7;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_8;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_9;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_10;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_11;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_12;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_13;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_14;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_15;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_16;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_17;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_18;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_19;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_20;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_21;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_22;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_23;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_24;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_25;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_26;	// BTB.scala:204:21
  reg  [2:0]       tgtPages_27;	// BTB.scala:204:21
  reg  [24:0]      pages_0;	// BTB.scala:205:18
  reg  [24:0]      pages_1;	// BTB.scala:205:18
  reg  [24:0]      pages_2;	// BTB.scala:205:18
  reg  [24:0]      pages_3;	// BTB.scala:205:18
  reg  [24:0]      pages_4;	// BTB.scala:205:18
  reg  [24:0]      pages_5;	// BTB.scala:205:18
  reg  [5:0]       pageValid;	// BTB.scala:206:22
  wire [24:0]      pagesMasked_4 = pageValid[4] ? pages_4 : 25'h0;	// BTB.scala:205:18, :206:22, :207:{32,75}
  wire [24:0]      pagesMasked_5 = pageValid[5] ? pages_5 : 25'h0;	// BTB.scala:205:18, :206:22, :207:{32,75}
  reg  [27:0]      isValid;	// BTB.scala:209:20
  reg  [1:0]       cfiType_0;	// BTB.scala:210:20
  reg  [1:0]       cfiType_1;	// BTB.scala:210:20
  reg  [1:0]       cfiType_2;	// BTB.scala:210:20
  reg  [1:0]       cfiType_3;	// BTB.scala:210:20
  reg  [1:0]       cfiType_4;	// BTB.scala:210:20
  reg  [1:0]       cfiType_5;	// BTB.scala:210:20
  reg  [1:0]       cfiType_6;	// BTB.scala:210:20
  reg  [1:0]       cfiType_7;	// BTB.scala:210:20
  reg  [1:0]       cfiType_8;	// BTB.scala:210:20
  reg  [1:0]       cfiType_9;	// BTB.scala:210:20
  reg  [1:0]       cfiType_10;	// BTB.scala:210:20
  reg  [1:0]       cfiType_11;	// BTB.scala:210:20
  reg  [1:0]       cfiType_12;	// BTB.scala:210:20
  reg  [1:0]       cfiType_13;	// BTB.scala:210:20
  reg  [1:0]       cfiType_14;	// BTB.scala:210:20
  reg  [1:0]       cfiType_15;	// BTB.scala:210:20
  reg  [1:0]       cfiType_16;	// BTB.scala:210:20
  reg  [1:0]       cfiType_17;	// BTB.scala:210:20
  reg  [1:0]       cfiType_18;	// BTB.scala:210:20
  reg  [1:0]       cfiType_19;	// BTB.scala:210:20
  reg  [1:0]       cfiType_20;	// BTB.scala:210:20
  reg  [1:0]       cfiType_21;	// BTB.scala:210:20
  reg  [1:0]       cfiType_22;	// BTB.scala:210:20
  reg  [1:0]       cfiType_23;	// BTB.scala:210:20
  reg  [1:0]       cfiType_24;	// BTB.scala:210:20
  reg  [1:0]       cfiType_25;	// BTB.scala:210:20
  reg  [1:0]       cfiType_26;	// BTB.scala:210:20
  reg  [1:0]       cfiType_27;	// BTB.scala:210:20
  reg              brIdx_0;	// BTB.scala:211:18
  reg              brIdx_1;	// BTB.scala:211:18
  reg              brIdx_2;	// BTB.scala:211:18
  reg              brIdx_3;	// BTB.scala:211:18
  reg              brIdx_4;	// BTB.scala:211:18
  reg              brIdx_5;	// BTB.scala:211:18
  reg              brIdx_6;	// BTB.scala:211:18
  reg              brIdx_7;	// BTB.scala:211:18
  reg              brIdx_8;	// BTB.scala:211:18
  reg              brIdx_9;	// BTB.scala:211:18
  reg              brIdx_10;	// BTB.scala:211:18
  reg              brIdx_11;	// BTB.scala:211:18
  reg              brIdx_12;	// BTB.scala:211:18
  reg              brIdx_13;	// BTB.scala:211:18
  reg              brIdx_14;	// BTB.scala:211:18
  reg              brIdx_15;	// BTB.scala:211:18
  reg              brIdx_16;	// BTB.scala:211:18
  reg              brIdx_17;	// BTB.scala:211:18
  reg              brIdx_18;	// BTB.scala:211:18
  reg              brIdx_19;	// BTB.scala:211:18
  reg              brIdx_20;	// BTB.scala:211:18
  reg              brIdx_21;	// BTB.scala:211:18
  reg              brIdx_22;	// BTB.scala:211:18
  reg              brIdx_23;	// BTB.scala:211:18
  reg              brIdx_24;	// BTB.scala:211:18
  reg              brIdx_25;	// BTB.scala:211:18
  reg              brIdx_26;	// BTB.scala:211:18
  reg              brIdx_27;	// BTB.scala:211:18
  reg              r_btb_updatePipe_valid;	// Valid.scala:117:22
  reg  [4:0]       r_btb_updatePipe_bits_prediction_entry;	// Reg.scala:15:16
  reg  [38:0]      r_btb_updatePipe_bits_pc;	// Reg.scala:15:16
  reg              r_btb_updatePipe_bits_isValid;	// Reg.scala:15:16
  reg  [38:0]      r_btb_updatePipe_bits_br_pc;	// Reg.scala:15:16
  reg  [1:0]       r_btb_updatePipe_bits_cfiType;	// Reg.scala:15:16
  wire             pageHit_lo_lo = pages_0 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire             pageHit_lo_hi_lo = pages_1 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire             pageHit_lo_hi_hi = pages_2 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire             pageHit_hi_lo = pages_3 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire             pageHit_hi_hi_lo = pages_4 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire             pageHit_hi_hi_hi = pages_5 == io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39, :216:29
  wire [5:0]       pageHit =
    pageValid
    & {pageHit_hi_hi_hi,
       pageHit_hi_hi_lo,
       pageHit_hi_lo,
       pageHit_lo_hi_hi,
       pageHit_lo_hi_lo,
       pageHit_lo_lo};	// BTB.scala:206:22, :216:{15,29}, Cat.scala:30:58
  wire             idxHit_lo_lo_lo_lo = idxs_0 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_lo_hi_lo = idxs_1 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_lo_hi_hi = idxs_2 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_hi_lo_lo = idxs_3 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_hi_lo_hi = idxs_4 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_hi_hi_lo = idxs_5 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_lo_hi_hi_hi = idxs_6 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_lo_lo = idxs_7 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_lo_hi_lo = idxs_8 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_lo_hi_hi = idxs_9 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_hi_lo_lo = idxs_10 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_hi_lo_hi = idxs_11 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_hi_hi_lo = idxs_12 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_lo_hi_hi_hi_hi = idxs_13 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_lo_lo = idxs_14 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_lo_hi_lo = idxs_15 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_lo_hi_hi = idxs_16 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_hi_lo_lo = idxs_17 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_hi_lo_hi = idxs_18 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_hi_hi_lo = idxs_19 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_lo_hi_hi_hi = idxs_20 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_lo_lo = idxs_21 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_lo_hi_lo = idxs_22 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_lo_hi_hi = idxs_23 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_hi_lo_lo = idxs_24 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_hi_lo_hi = idxs_25 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_hi_hi_lo = idxs_26 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire             idxHit_hi_hi_hi_hi_hi = idxs_27 == io_req_bits_addr[13:1];	// BTB.scala:201:17, :219:19, :220:16
  wire [27:0]      idxHit =
    {idxHit_hi_hi_hi_hi_hi,
     idxHit_hi_hi_hi_hi_lo,
     idxHit_hi_hi_hi_lo_hi,
     idxHit_hi_hi_hi_lo_lo,
     idxHit_hi_hi_lo_hi_hi,
     idxHit_hi_hi_lo_hi_lo,
     idxHit_hi_hi_lo_lo,
     idxHit_hi_lo_hi_hi_hi,
     idxHit_hi_lo_hi_hi_lo,
     idxHit_hi_lo_hi_lo_hi,
     idxHit_hi_lo_hi_lo_lo,
     idxHit_hi_lo_lo_hi_hi,
     idxHit_hi_lo_lo_hi_lo,
     idxHit_hi_lo_lo_lo,
     idxHit_lo_hi_hi_hi_hi,
     idxHit_lo_hi_hi_hi_lo,
     idxHit_lo_hi_hi_lo_hi,
     idxHit_lo_hi_hi_lo_lo,
     idxHit_lo_hi_lo_hi_hi,
     idxHit_lo_hi_lo_hi_lo,
     idxHit_lo_hi_lo_lo,
     idxHit_lo_lo_hi_hi_hi,
     idxHit_lo_lo_hi_hi_lo,
     idxHit_lo_lo_hi_lo_hi,
     idxHit_lo_lo_hi_lo_lo,
     idxHit_lo_lo_lo_hi_hi,
     idxHit_lo_lo_lo_hi_lo,
     idxHit_lo_lo_lo_lo} & isValid;	// BTB.scala:209:20, :220:{16,32}, Cat.scala:30:58
  reg  [2:0]       nextPageRepl;	// BTB.scala:239:29
  reg  [26:0]      state_reg;	// Replacement.scala:168:70
  reg              r_respPipe_valid;	// Valid.scala:117:22
  reg              r_respPipe_bits_taken;	// Reg.scala:15:16
  reg  [4:0]       r_respPipe_bits_entry;	// Reg.scala:15:16
  wire             _io_resp_bits_cfiType_T = idxHit_lo_lo_lo_lo & isValid[0];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_1 = idxHit_lo_lo_lo_hi_lo & isValid[1];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_2 = idxHit_lo_lo_lo_hi_hi & isValid[2];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_3 = idxHit_lo_lo_hi_lo_lo & isValid[3];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_4 = idxHit_lo_lo_hi_lo_hi & isValid[4];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_5 = idxHit_lo_lo_hi_hi_lo & isValid[5];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_6 = idxHit_lo_lo_hi_hi_hi & isValid[6];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_7 = idxHit_lo_hi_lo_lo & isValid[7];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_8 = idxHit_lo_hi_lo_hi_lo & isValid[8];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_9 = idxHit_lo_hi_lo_hi_hi & isValid[9];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_10 = idxHit_lo_hi_hi_lo_lo & isValid[10];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_11 = idxHit_lo_hi_hi_lo_hi & isValid[11];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_12 = idxHit_lo_hi_hi_hi_lo & isValid[12];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_13 = idxHit_lo_hi_hi_hi_hi & isValid[13];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_14 = idxHit_hi_lo_lo_lo & isValid[14];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_15 = idxHit_hi_lo_lo_hi_lo & isValid[15];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_16 = idxHit_hi_lo_lo_hi_hi & isValid[16];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_17 = idxHit_hi_lo_hi_lo_lo & isValid[17];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_18 = idxHit_hi_lo_hi_lo_hi & isValid[18];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_19 = idxHit_hi_lo_hi_hi_lo & isValid[19];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_20 = idxHit_hi_lo_hi_hi_hi & isValid[20];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_21 = idxHit_hi_hi_lo_lo & isValid[21];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_22 = idxHit_hi_hi_lo_hi_lo & isValid[22];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_23 = idxHit_hi_hi_lo_hi_hi & isValid[23];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_24 = idxHit_hi_hi_hi_lo_lo & isValid[24];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_25 = idxHit_hi_hi_hi_lo_hi & isValid[25];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_26 = idxHit_hi_hi_hi_hi_lo & isValid[26];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire             _io_resp_bits_cfiType_T_27 = idxHit_hi_hi_hi_hi_hi & isValid[27];	// BTB.scala:209:20, :220:{16,32}, Mux.scala:29:36
  wire [6:0]       _io_resp_valid_T_84 =
    {pageHit, 1'h0}
    >> ((_io_resp_bits_cfiType_T ? idxPages_0 : 3'h0)
        | (_io_resp_bits_cfiType_T_1 ? idxPages_1 : 3'h0)
        | (_io_resp_bits_cfiType_T_2 ? idxPages_2 : 3'h0)
        | (_io_resp_bits_cfiType_T_3 ? idxPages_3 : 3'h0)
        | (_io_resp_bits_cfiType_T_4 ? idxPages_4 : 3'h0)
        | (_io_resp_bits_cfiType_T_5 ? idxPages_5 : 3'h0)
        | (_io_resp_bits_cfiType_T_6 ? idxPages_6 : 3'h0)
        | (_io_resp_bits_cfiType_T_7 ? idxPages_7 : 3'h0)
        | (_io_resp_bits_cfiType_T_8 ? idxPages_8 : 3'h0)
        | (_io_resp_bits_cfiType_T_9 ? idxPages_9 : 3'h0)
        | (_io_resp_bits_cfiType_T_10 ? idxPages_10 : 3'h0)
        | (_io_resp_bits_cfiType_T_11 ? idxPages_11 : 3'h0)
        | (_io_resp_bits_cfiType_T_12 ? idxPages_12 : 3'h0)
        | (_io_resp_bits_cfiType_T_13 ? idxPages_13 : 3'h0)
        | (_io_resp_bits_cfiType_T_14 ? idxPages_14 : 3'h0)
        | (_io_resp_bits_cfiType_T_15 ? idxPages_15 : 3'h0)
        | (_io_resp_bits_cfiType_T_16 ? idxPages_16 : 3'h0)
        | (_io_resp_bits_cfiType_T_17 ? idxPages_17 : 3'h0)
        | (_io_resp_bits_cfiType_T_18 ? idxPages_18 : 3'h0)
        | (_io_resp_bits_cfiType_T_19 ? idxPages_19 : 3'h0)
        | (_io_resp_bits_cfiType_T_20 ? idxPages_20 : 3'h0)
        | (_io_resp_bits_cfiType_T_21 ? idxPages_21 : 3'h0)
        | (_io_resp_bits_cfiType_T_22 ? idxPages_22 : 3'h0)
        | (_io_resp_bits_cfiType_T_23 ? idxPages_23 : 3'h0)
        | (_io_resp_bits_cfiType_T_24 ? idxPages_24 : 3'h0)
        | (_io_resp_bits_cfiType_T_25 ? idxPages_25 : 3'h0)
        | (_io_resp_bits_cfiType_T_26 ? idxPages_26 : 3'h0)
        | (_io_resp_bits_cfiType_T_27 ? idxPages_27 : 3'h0));	// BTB.scala:201:17, :202:21, :216:15, :220:32, :239:29, :289:{29,34}, Mux.scala:27:72, :29:36
  wire [7:0][24:0] _GEN =
    {{pagesMasked_5},
     {pagesMasked_4},
     {pagesMasked_5},
     {pagesMasked_4},
     {pageValid[3] ? pages_3 : 25'h0},
     {pageValid[2] ? pages_2 : 25'h0},
     {pageValid[1] ? pages_1 : 25'h0},
     {pageValid[0] ? pages_0 : 25'h0}};	// BTB.scala:205:18, :206:22, :207:{32,75}, package.scala:32:{76,86}
  wire [11:0]      io_resp_bits_entry_hi =
    {idxHit_hi_hi_hi_hi_hi,
     idxHit_hi_hi_hi_hi_lo,
     idxHit_hi_hi_hi_lo_hi,
     idxHit_hi_hi_hi_lo_lo,
     idxHit_hi_hi_lo_hi_hi,
     idxHit_hi_hi_lo_hi_lo,
     idxHit_hi_hi_lo_lo,
     idxHit_hi_lo_hi_hi_hi,
     idxHit_hi_lo_hi_hi_lo,
     idxHit_hi_lo_hi_lo_hi,
     idxHit_hi_lo_hi_lo_lo,
     idxHit_hi_lo_lo_hi_hi} & isValid[27:16];	// BTB.scala:209:20, :220:{16,32}, OneHot.scala:30:18
  wire [14:0]      _io_resp_bits_entry_T =
    {4'h0, io_resp_bits_entry_hi[11:1]}
    | {idxHit_hi_lo_lo_hi_lo,
       idxHit_hi_lo_lo_lo,
       idxHit_lo_hi_hi_hi_hi,
       idxHit_lo_hi_hi_hi_lo,
       idxHit_lo_hi_hi_lo_hi,
       idxHit_lo_hi_hi_lo_lo,
       idxHit_lo_hi_lo_hi_hi,
       idxHit_lo_hi_lo_hi_lo,
       idxHit_lo_hi_lo_lo,
       idxHit_lo_lo_hi_hi_hi,
       idxHit_lo_lo_hi_hi_lo,
       idxHit_lo_lo_hi_lo_hi,
       idxHit_lo_lo_hi_lo_lo,
       idxHit_lo_lo_lo_hi_hi,
       idxHit_lo_lo_lo_hi_lo} & isValid[15:1];	// BTB.scala:209:20, :220:{16,32}, OneHot.scala:30:18, :31:18, :32:{14,28}
  wire [6:0]       _io_resp_bits_entry_T_1 =
    _io_resp_bits_entry_T[14:8] | _io_resp_bits_entry_T[6:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [2:0]       _io_resp_bits_entry_T_2 =
    _io_resp_bits_entry_T_1[6:4] | _io_resp_bits_entry_T_1[2:0];	// OneHot.scala:30:18, :31:18, :32:28
  wire [4:0]       _io_resp_bits_entry_output =
    {|io_resp_bits_entry_hi,
     |(_io_resp_bits_entry_T[14:7]),
     |(_io_resp_bits_entry_T_1[6:3]),
     |(_io_resp_bits_entry_T_2[2:1]),
     _io_resp_bits_entry_T_2[2] | _io_resp_bits_entry_T_2[0]};	// BTB.scala:220:32, Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}
  reg  [7:0]       history;	// BTB.scala:119:24
  reg  [9:0]       reset_waddr;	// BTB.scala:121:36
  wire [7:0]       _res_res_value_T_4 = history * 8'hDD;	// BTB.scala:84:12, :119:24
  wire             res_value = reset_waddr[9] & _table_ext_R0_data;	// BTB.scala:94:21, :118:26, :121:36, :122:39
  wire [7:0]       _waddr_T_31 = io_bht_update_bits_prediction_history * 8'hDD;	// BTB.scala:84:12
  wire             _GEN_0 =
    io_bht_update_valid & io_bht_update_bits_branch & reset_waddr[9];	// BTB.scala:100:23, :101:13, :121:36, :122:39, :312:32, :313:40
  wire             _GEN_1 =
    ~res_value
    & (|(idxHit
         & {cfiType_27 == 2'h0,
            cfiType_26 == 2'h0,
            cfiType_25 == 2'h0,
            cfiType_24 == 2'h0,
            cfiType_23 == 2'h0,
            cfiType_22 == 2'h0,
            cfiType_21 == 2'h0,
            cfiType_20 == 2'h0,
            cfiType_19 == 2'h0,
            cfiType_18 == 2'h0,
            cfiType_17 == 2'h0,
            cfiType_16 == 2'h0,
            cfiType_15 == 2'h0,
            cfiType_14 == 2'h0,
            cfiType_13 == 2'h0,
            cfiType_12 == 2'h0,
            cfiType_11 == 2'h0,
            cfiType_10 == 2'h0,
            cfiType_9 == 2'h0,
            cfiType_8 == 2'h0,
            cfiType_7 == 2'h0,
            cfiType_6 == 2'h0,
            cfiType_5 == 2'h0,
            cfiType_4 == 2'h0,
            cfiType_3 == 2'h0,
            cfiType_2 == 2'h0,
            cfiType_1 == 2'h0,
            cfiType_0 == 2'h0}));	// BTB.scala:94:21, :210:20, :220:32, :240:65, :307:{28,44,72}, :322:{11,22}, Cat.scala:30:58
  reg  [2:0]       count;	// BTB.scala:58:30
  reg  [2:0]       pos;	// BTB.scala:59:28
  reg  [38:0]      stack_0;	// BTB.scala:60:26
  reg  [38:0]      stack_1;	// BTB.scala:60:26
  reg  [38:0]      stack_2;	// BTB.scala:60:26
  reg  [38:0]      stack_3;	// BTB.scala:60:26
  reg  [38:0]      stack_4;	// BTB.scala:60:26
  reg  [38:0]      stack_5;	// BTB.scala:60:26
  wire [7:0][38:0] _GEN_2 =
    {{stack_0},
     {stack_0},
     {stack_5},
     {stack_4},
     {stack_3},
     {stack_2},
     {stack_1},
     {stack_0}};	// BTB.scala:60:26, :330:22
  wire [38:0]      _GEN_3 = _GEN_2[pos];	// BTB.scala:59:28, :330:22
  always @(posedge clock) begin
    automatic logic [5:0] updatePageHit;	// BTB.scala:216:15
    automatic logic [7:0] idxPageRepl;	// BTB.scala:240:65
    automatic logic [7:0] idxPageUpdateOH;	// BTB.scala:241:28
    automatic logic [2:0] _idxPageUpdate_T;	// OneHot.scala:32:28
    automatic logic       _idxPageUpdate_T_1;	// OneHot.scala:32:28
    automatic logic [5:0] idxPageReplEn;	// BTB.scala:243:26
    automatic logic       samePage;	// BTB.scala:245:45
    automatic logic       doTgtPageRepl;	// BTB.scala:246:33
    automatic logic [7:0] tgtPageRepl;	// BTB.scala:247:24
    automatic logic [6:0] _tgtPageUpdate_T_1;	// BTB.scala:248:40
    automatic logic [2:0] _tgtPageUpdate_T_2;	// OneHot.scala:32:28
    automatic logic [2:0] tgtPageUpdate;	// Cat.scala:30:58
    automatic logic [5:0] tgtPageReplEn;	// BTB.scala:249:26
    automatic logic [4:0] waddr;	// BTB.scala:258:18
    automatic logic [2:0] _idxPages_T;	// BTB.scala:268:38
    automatic logic [4:0] _GEN_4;	// BTB.scala:282:24
    automatic logic [4:0] _GEN_5;	// BTB.scala:284:24
    automatic logic       _GEN_6;	// BTB.scala:335:40
    automatic logic       _nextPos_T_1;	// BTB.scala:46:49
    automatic logic [2:0] _nextPos_T_2;	// BTB.scala:46:62
    automatic logic [2:0] nextPos;	// BTB.scala:46:22
    updatePageHit =
      pageValid
      & {pages_5 == r_btb_updatePipe_bits_pc[38:14],
         pages_4 == r_btb_updatePipe_bits_pc[38:14],
         pages_3 == r_btb_updatePipe_bits_pc[38:14],
         pages_2 == r_btb_updatePipe_bits_pc[38:14],
         pages_1 == r_btb_updatePipe_bits_pc[38:14],
         pages_0 == r_btb_updatePipe_bits_pc[38:14]};	// BTB.scala:205:18, :206:22, :213:39, :216:{15,29}, Cat.scala:30:58, Reg.scala:15:16
    idxPageRepl =
      {2'h0,
       pageValid[4:0]
         & {pageHit_hi_hi_lo,
            pageHit_hi_lo,
            pageHit_lo_hi_hi,
            pageHit_lo_hi_lo,
            pageHit_lo_lo},
       pageValid[5] & pageHit_hi_hi_hi} | ((|pageHit) ? 8'h0 : 8'h1 << nextPageRepl);	// BTB.scala:119:24, :206:22, :216:{15,29}, :237:28, :239:29, :240:{32,53,65,70}, OneHot.scala:58:35
    idxPageUpdateOH = (|updatePageHit) ? {2'h0, updatePageHit} : idxPageRepl;	// BTB.scala:216:15, :236:40, :240:65, :241:28
    _idxPageUpdate_T = idxPageUpdateOH[7:5] | idxPageUpdateOH[3:1];	// BTB.scala:241:28, OneHot.scala:30:18, :31:18, :32:28
    _idxPageUpdate_T_1 = _idxPageUpdate_T[2] | _idxPageUpdate_T[0];	// OneHot.scala:30:18, :31:18, :32:28
    idxPageReplEn = (|updatePageHit) ? 6'h0 : idxPageRepl[5:0];	// BTB.scala:216:15, :236:40, :240:65, :243:26
    samePage = r_btb_updatePipe_bits_pc[38:14] == io_req_bits_addr[38:14];	// BTB.scala:213:39, :245:45, Reg.scala:15:16
    doTgtPageRepl = ~samePage & ~(|pageHit);	// BTB.scala:216:15, :237:28, :245:45, :246:{23,33,36}
    tgtPageRepl =
      samePage ? idxPageUpdateOH : {2'h0, idxPageUpdateOH[4:0], idxPageUpdateOH[5]};	// BTB.scala:240:65, :241:28, :245:45, :247:{24,71,100}
    _tgtPageUpdate_T_1 = {2'h0, pageHit[5:1]} | ((|pageHit) ? 7'h0 : tgtPageRepl[7:1]);	// BTB.scala:119:24, :216:15, :237:28, :240:65, :247:24, :248:{40,45}
    _tgtPageUpdate_T_2 = _tgtPageUpdate_T_1[6:4] | _tgtPageUpdate_T_1[2:0];	// BTB.scala:248:40, OneHot.scala:30:18, :31:18, :32:28
    tgtPageUpdate =
      {|(_tgtPageUpdate_T_1[6:3]),
       |(_tgtPageUpdate_T_2[2:1]),
       _tgtPageUpdate_T_2[2] | _tgtPageUpdate_T_2[0]};	// BTB.scala:248:40, Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}
    tgtPageReplEn = doTgtPageRepl ? tgtPageRepl[5:0] : 6'h0;	// BTB.scala:246:33, :247:24, :249:26
    waddr =
      r_btb_updatePipe_bits_prediction_entry[4:2] != 3'h7
        ? r_btb_updatePipe_bits_prediction_entry
        : {state_reg[26],
           state_reg[26]
             ? {state_reg[25],
                state_reg[25]
                  ? {1'h0, state_reg[24], state_reg[24] ? state_reg[23] : state_reg[22]}
                  : {state_reg[21],
                     state_reg[21]
                       ? {state_reg[20], state_reg[20] ? state_reg[19] : state_reg[18]}
                       : {state_reg[17], state_reg[17] ? state_reg[16] : state_reg[15]}}}
             : {state_reg[14],
                state_reg[14]
                  ? {state_reg[13],
                     state_reg[13]
                       ? {state_reg[12], state_reg[12] ? state_reg[11] : state_reg[10]}
                       : {state_reg[9], state_reg[9] ? state_reg[8] : state_reg[7]}}
                  : {state_reg[6],
                     state_reg[6]
                       ? {state_reg[5], state_reg[5] ? state_reg[4] : state_reg[3]}
                       : {state_reg[2], state_reg[2] ? state_reg[1] : state_reg[0]}}}};	// BTB.scala:201:17, :234:48, :258:18, Cat.scala:30:58, Reg.scala:15:16, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:32:86, :154:13
    _idxPages_T =
      {|(idxPageUpdateOH[7:4]), |(_idxPageUpdate_T[2:1]), _idxPageUpdate_T_1} + 3'h1;	// BTB.scala:47:20, :241:28, :268:38, OneHot.scala:30:18, :32:{14,28}
    _GEN_4 = _idxPageUpdate_T_1 ? tgtPageReplEn[4:0] : idxPageReplEn[4:0];	// BTB.scala:243:26, :249:26, :282:24, OneHot.scala:32:28
    _GEN_5 = _idxPageUpdate_T_1 ? idxPageReplEn[5:1] : tgtPageReplEn[5:1];	// BTB.scala:243:26, :249:26, :284:24, OneHot.scala:32:28
    _GEN_6 = io_ras_update_bits_cfiType == 2'h2;	// BTB.scala:253:40, :335:40
    _nextPos_T_1 = pos < 3'h5;	// BTB.scala:46:49, :59:28, package.scala:32:86
    _nextPos_T_2 = pos + 3'h1;	// BTB.scala:46:62, :47:20, :59:28
    nextPos = _nextPos_T_1 ? _nextPos_T_2 : 3'h0;	// BTB.scala:46:{22,49,62}, :239:29
    if (r_btb_updatePipe_valid & waddr == 5'h0) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, OneHot.scala:58:35, Valid.scala:117:22
      idxs_0 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_0 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_0 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_0 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_0 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_0 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h1) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_1 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_1 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_1 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_1 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_1 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_1 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h2) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_2 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_2 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_2 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_2 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_2 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_2 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h3) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_3 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_3 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_3 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_3 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_3 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_3 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h4) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_4 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_4 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_4 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_4 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_4 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_4 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h5) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_5 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_5 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_5 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_5 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_5 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_5 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h6) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_6 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_6 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_6 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_6 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_6 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_6 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h7) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_7 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_7 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_7 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_7 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_7 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_7 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h8) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_8 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_8 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_8 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_8 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_8 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_8 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h9) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_9 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_9 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_9 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_9 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_9 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_9 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hA) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_10 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_10 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_10 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_10 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_10 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_10 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hB) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_11 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_11 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_11 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_11 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_11 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_11 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hC) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_12 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_12 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_12 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_12 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_12 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_12 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hD) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_13 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_13 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_13 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_13 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_13 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_13 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hE) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_14 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_14 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_14 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_14 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_14 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_14 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'hF) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_15 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_15 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_15 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_15 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_15 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_15 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h10) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_16 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_16 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_16 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_16 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_16 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_16 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h11) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_17 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_17 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_17 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_17 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_17 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_17 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h12) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_18 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_18 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_18 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_18 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_18 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_18 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h13) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_19 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_19 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_19 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_19 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_19 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_19 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h14) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_20 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_20 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_20 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_20 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_20 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_20 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h15) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_21 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_21 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_21 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_21 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_21 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_21 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h16) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_22 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_22 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_22 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_22 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_22 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_22 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h17) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_23 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_23 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_23 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_23 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_23 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_23 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h18) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_24 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_24 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_24 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_24 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_24 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_24 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h19) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_25 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_25 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_25 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_25 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_25 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_25 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h1A) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_26 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_26 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_26 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_26 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_26 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_26 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & waddr == 5'h1B) begin	// BTB.scala:201:17, :258:18, :264:29, :266:17, Valid.scala:117:22
      idxs_27 <= r_btb_updatePipe_bits_pc[13:1];	// BTB.scala:201:17, :266:40, Reg.scala:15:16
      idxPages_27 <= _idxPages_T;	// BTB.scala:202:21, :268:38
      tgts_27 <= io_req_bits_addr[13:1];	// BTB.scala:203:17, :219:19
      tgtPages_27 <= tgtPageUpdate;	// BTB.scala:204:21, Cat.scala:30:58
      cfiType_27 <= r_btb_updatePipe_bits_cfiType;	// BTB.scala:210:20, Reg.scala:15:16
      brIdx_27 <= r_btb_updatePipe_bits_br_pc[1];	// BTB.scala:211:18, :273:{20,47}, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & _GEN_4[0]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :282:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_0 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
      else	// OneHot.scala:32:28
        pages_0 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & _GEN_5[0]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :284:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_1 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
      else	// OneHot.scala:32:28
        pages_1 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
    end
    if (r_btb_updatePipe_valid & _GEN_4[2]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :282:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_2 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
      else	// OneHot.scala:32:28
        pages_2 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & _GEN_5[2]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :284:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_3 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
      else	// OneHot.scala:32:28
        pages_3 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
    end
    if (r_btb_updatePipe_valid & _GEN_4[4]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :282:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_4 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
      else	// OneHot.scala:32:28
        pages_4 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
    end
    if (r_btb_updatePipe_valid & _GEN_5[4]) begin	// BTB.scala:205:18, :264:29, :280:{17,22,33}, :284:24, Valid.scala:117:22
      if (_idxPageUpdate_T_1)	// OneHot.scala:32:28
        pages_5 <= r_btb_updatePipe_bits_pc[38:14];	// BTB.scala:205:18, :213:39, Reg.scala:15:16
      else	// OneHot.scala:32:28
        pages_5 <= io_req_bits_addr[38:14];	// BTB.scala:205:18, :213:39
    end
    if (io_btb_update_valid) begin
      r_btb_updatePipe_bits_prediction_entry <= io_btb_update_bits_prediction_entry;	// Reg.scala:15:16
      r_btb_updatePipe_bits_pc <= io_btb_update_bits_pc;	// Reg.scala:15:16
      r_btb_updatePipe_bits_isValid <= io_btb_update_bits_isValid;	// Reg.scala:15:16
      r_btb_updatePipe_bits_br_pc <= io_btb_update_bits_br_pc;	// Reg.scala:15:16
      r_btb_updatePipe_bits_cfiType <= io_btb_update_bits_cfiType;	// Reg.scala:15:16
    end
    if (_io_resp_valid_T_84[0]) begin	// BTB.scala:289:34
      r_respPipe_bits_taken <= ~_GEN_1;	// BTB.scala:201:17, :290:22, :322:{22,35,56}, OneHot.scala:58:35, Reg.scala:15:16
      r_respPipe_bits_entry <= _io_resp_bits_entry_output;	// Cat.scala:30:58, Reg.scala:15:16
    end
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h0)	// BTB.scala:46:22, :47:20, :60:26, :239:29, :334:32, :335:{40,58}
      stack_0 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h1)	// BTB.scala:46:22, :47:20, :60:26, :334:32, :335:{40,58}
      stack_1 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h2)	// BTB.scala:46:22, :47:20, :60:26, :334:32, :335:{40,58}
      stack_2 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h3)	// BTB.scala:46:22, :47:20, :60:26, :334:32, :335:{40,58}
      stack_3 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h4)	// BTB.scala:46:22, :47:20, :60:26, :334:32, :335:{40,58}, package.scala:32:86
      stack_4 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (io_ras_update_valid & _GEN_6 & nextPos == 3'h5)	// BTB.scala:46:22, :47:20, :60:26, :334:32, :335:{40,58}, package.scala:32:86
      stack_5 <= io_ras_update_bits_returnAddr;	// BTB.scala:60:26
    if (reset) begin
      pageValid <= 6'h0;	// BTB.scala:206:22
      isValid <= 28'h0;	// BTB.scala:209:20
      r_btb_updatePipe_valid <= 1'h0;	// BTB.scala:201:17, Valid.scala:117:22
      nextPageRepl <= 3'h0;	// BTB.scala:239:29
      state_reg <= 27'h0;	// Replacement.scala:168:70
      r_respPipe_valid <= 1'h0;	// BTB.scala:201:17, Valid.scala:117:22
      history <= 8'h0;	// BTB.scala:119:24
      reset_waddr <= 10'h0;	// BTB.scala:121:36
      count <= 3'h0;	// BTB.scala:58:30, :239:29
      pos <= 3'h0;	// BTB.scala:59:28, :239:29
    end
    else begin
      pageValid <=
        {6{r_btb_updatePipe_valid}} & (tgtPageReplEn | idxPageReplEn) | pageValid;	// BTB.scala:206:22, :243:26, :249:26, :264:29, :286:{15,44}, Valid.scala:117:22
      if (io_flush)
        isValid <= 28'h0;	// BTB.scala:209:20
      else begin
        automatic logic leftOne;	// BTB.scala:220:32, Misc.scala:180:37
        automatic logic leftOne_1;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_1;	// Misc.scala:182:16
        automatic logic leftOne_2;	// Misc.scala:182:16
        automatic logic leftOne_3;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_2;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_4;	// Misc.scala:182:16
        automatic logic leftOne_5;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_3;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_4;	// Misc.scala:182:16
        automatic logic rightOne_5;	// Misc.scala:182:16
        automatic logic leftOne_6;	// Misc.scala:182:16
        automatic logic leftOne_7;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_8;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_6;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_7;	// Misc.scala:182:16
        automatic logic leftOne_9;	// Misc.scala:182:16
        automatic logic leftOne_10;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_8;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_11;	// Misc.scala:182:16
        automatic logic leftOne_12;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_9;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_10;	// Misc.scala:182:16
        automatic logic rightOne_11;	// Misc.scala:182:16
        automatic logic rightOne_12;	// Misc.scala:182:16
        automatic logic leftOne_14;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_15;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_13;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_14;	// Misc.scala:182:16
        automatic logic leftOne_16;	// Misc.scala:182:16
        automatic logic leftOne_17;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_15;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_18;	// Misc.scala:182:16
        automatic logic leftOne_19;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_16;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_17;	// Misc.scala:182:16
        automatic logic rightOne_18;	// Misc.scala:182:16
        automatic logic leftOne_20;	// Misc.scala:182:16
        automatic logic leftOne_21;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_22;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_19;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_20;	// Misc.scala:182:16
        automatic logic leftOne_23;	// Misc.scala:182:16
        automatic logic leftOne_24;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_21;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic leftOne_25;	// Misc.scala:182:16
        automatic logic leftOne_26;	// BTB.scala:220:32, Misc.scala:180:37, :181:39
        automatic logic rightOne_22;	// BTB.scala:220:32, Misc.scala:181:39
        automatic logic rightOne_23;	// Misc.scala:182:16
        automatic logic rightOne_24;	// Misc.scala:182:16
        automatic logic rightOne_25;	// Misc.scala:182:16
        leftOne = idxHit_lo_lo_lo_lo & isValid[0];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, Mux.scala:29:36
        leftOne_1 = idxHit_lo_lo_lo_hi_lo & isValid[1];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne = idxHit_lo_lo_lo_hi_hi & isValid[2];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_1 = leftOne_1 | rightOne;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_2 = leftOne | rightOne_1;	// BTB.scala:220:32, Misc.scala:180:37, :182:16
        leftOne_3 = idxHit_lo_lo_hi_lo_lo & isValid[3];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_2 = idxHit_lo_lo_hi_lo_hi & isValid[4];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_4 = leftOne_3 | rightOne_2;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_5 = idxHit_lo_lo_hi_hi_lo & isValid[5];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_3 = idxHit_lo_lo_hi_hi_hi & isValid[6];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_4 = leftOne_5 | rightOne_3;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        rightOne_5 = leftOne_4 | rightOne_4;	// Misc.scala:182:16
        leftOne_6 = leftOne_2 | rightOne_5;	// Misc.scala:182:16
        leftOne_7 = idxHit_lo_hi_lo_lo & isValid[7];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_8 = idxHit_lo_hi_lo_hi_lo & isValid[8];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_6 = idxHit_lo_hi_lo_hi_hi & isValid[9];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_7 = leftOne_8 | rightOne_6;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_9 = leftOne_7 | rightOne_7;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_10 = idxHit_lo_hi_hi_lo_lo & isValid[10];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_8 = idxHit_lo_hi_hi_lo_hi & isValid[11];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_11 = leftOne_10 | rightOne_8;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_12 = idxHit_lo_hi_hi_hi_lo & isValid[12];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_9 = idxHit_lo_hi_hi_hi_hi & isValid[13];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_10 = leftOne_12 | rightOne_9;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        rightOne_11 = leftOne_11 | rightOne_10;	// Misc.scala:182:16
        rightOne_12 = leftOne_9 | rightOne_11;	// Misc.scala:182:16
        leftOne_14 = idxHit_hi_lo_lo_lo & isValid[14];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_15 = idxHit_hi_lo_lo_hi_lo & isValid[15];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_13 = idxHit_hi_lo_lo_hi_hi & isValid[16];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_14 = leftOne_15 | rightOne_13;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_16 = leftOne_14 | rightOne_14;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_17 = idxHit_hi_lo_hi_lo_lo & isValid[17];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_15 = idxHit_hi_lo_hi_lo_hi & isValid[18];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_18 = leftOne_17 | rightOne_15;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_19 = idxHit_hi_lo_hi_hi_lo & isValid[19];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_16 = idxHit_hi_lo_hi_hi_hi & isValid[20];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_17 = leftOne_19 | rightOne_16;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        rightOne_18 = leftOne_18 | rightOne_17;	// Misc.scala:182:16
        leftOne_20 = leftOne_16 | rightOne_18;	// Misc.scala:182:16
        leftOne_21 = idxHit_hi_hi_lo_lo & isValid[21];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_22 = idxHit_hi_hi_lo_hi_lo & isValid[22];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_19 = idxHit_hi_hi_lo_hi_hi & isValid[23];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_20 = leftOne_22 | rightOne_19;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_23 = leftOne_21 | rightOne_20;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_24 = idxHit_hi_hi_hi_lo_lo & isValid[24];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_21 = idxHit_hi_hi_hi_lo_hi & isValid[25];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        leftOne_25 = leftOne_24 | rightOne_21;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        leftOne_26 = idxHit_hi_hi_hi_hi_lo & isValid[26];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:180:37, :181:39, Mux.scala:29:36
        rightOne_22 = idxHit_hi_hi_hi_hi_hi & isValid[27];	// BTB.scala:209:20, :220:{16,32}, Misc.scala:181:39, Mux.scala:29:36
        rightOne_23 = leftOne_26 | rightOne_22;	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:16
        rightOne_24 = leftOne_25 | rightOne_23;	// Misc.scala:182:16
        rightOne_25 = leftOne_23 | rightOne_24;	// Misc.scala:182:16
        if (leftOne_1 & rightOne | leftOne & rightOne_1 | leftOne_3 & rightOne_2
            | leftOne_5 & rightOne_3 | leftOne_4 & rightOne_4 | leftOne_2 & rightOne_5
            | leftOne_8 & rightOne_6 | leftOne_7 & rightOne_7 | leftOne_10 & rightOne_8
            | leftOne_12 & rightOne_9 | leftOne_11 & rightOne_10 | leftOne_9 & rightOne_11
            | leftOne_6 & rightOne_12 | leftOne_15 & rightOne_13 | leftOne_14
            & rightOne_14 | leftOne_17 & rightOne_15 | leftOne_19 & rightOne_16
            | leftOne_18 & rightOne_17 | leftOne_16 & rightOne_18 | leftOne_22
            & rightOne_19 | leftOne_21 & rightOne_20 | leftOne_24 & rightOne_21
            | leftOne_26 & rightOne_22 | leftOne_25 & rightOne_23 | leftOne_23
            & rightOne_24 | leftOne_20 & rightOne_25 | (leftOne_6 | rightOne_12)
            & (leftOne_20 | rightOne_25))	// BTB.scala:220:32, Misc.scala:180:37, :181:39, :182:{16,49,61}
          isValid <= isValid & ~idxHit;	// BTB.scala:209:20, :220:32, :299:{24,26}
        else if (r_btb_updatePipe_valid) begin	// Valid.scala:117:22
          automatic logic [31:0] mask;	// OneHot.scala:58:35
          mask = 32'h1 << waddr;	// BTB.scala:258:18, OneHot.scala:58:35
          isValid <=
            r_btb_updatePipe_bits_isValid
              ? isValid | mask[27:0]
              : ~(mask[27:0]) & isValid;	// BTB.scala:209:20, :271:{19,55,71,73}, OneHot.scala:58:35, Reg.scala:15:16
        end
      end
      r_btb_updatePipe_valid <= io_btb_update_valid;	// Valid.scala:117:22
      if (r_btb_updatePipe_valid & (~(|updatePageHit) | doTgtPageRepl)) begin	// BTB.scala:216:15, :236:40, :238:23, :246:33, :251:{28,46}, Valid.scala:117:22
        automatic logic [2:0] _next_T_1;	// BTB.scala:253:29
        _next_T_1 =
          nextPageRepl + {1'h0, ~(|updatePageHit) & doTgtPageRepl ? 2'h2 : 2'h1};	// BTB.scala:201:17, :216:15, :236:40, :238:23, :239:29, :246:33, :252:30, :253:{29,40}
        if (_next_T_1 > 3'h5)	// BTB.scala:253:29, :254:30, package.scala:32:86
          nextPageRepl <= {2'h0, _next_T_1[0]};	// BTB.scala:239:29, :240:65, :253:29, :254:{24,45}
        else	// BTB.scala:254:30
          nextPageRepl <= _next_T_1;	// BTB.scala:239:29, :253:29
      end
      if (r_respPipe_valid & r_respPipe_bits_taken | r_btb_updatePipe_valid) begin	// BTB.scala:260:{22,43}, Reg.scala:15:16, Valid.scala:117:22
        automatic logic [4:0] state_reg_touch_way_sized;	// BTB.scala:261:20
        state_reg_touch_way_sized =
          r_btb_updatePipe_valid ? waddr : r_respPipe_bits_entry;	// BTB.scala:258:18, :261:20, Reg.scala:15:16, Valid.scala:117:22
        state_reg <=
          {~(state_reg_touch_way_sized[4]),
           state_reg_touch_way_sized[4]
             ? {~(state_reg_touch_way_sized[3]),
                state_reg_touch_way_sized[3]
                  ? {~(state_reg_touch_way_sized[1]),
                     state_reg_touch_way_sized[1]
                       ? ~(state_reg_touch_way_sized[0])
                       : state_reg[23],
                     state_reg_touch_way_sized[1]
                       ? state_reg[22]
                       : ~(state_reg_touch_way_sized[0])}
                  : state_reg[24:22],
                state_reg_touch_way_sized[3]
                  ? state_reg[21:15]
                  : {~(state_reg_touch_way_sized[2]),
                     state_reg_touch_way_sized[2]
                       ? {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[19],
                          state_reg_touch_way_sized[1]
                            ? state_reg[18]
                            : ~(state_reg_touch_way_sized[0])}
                       : state_reg[20:18],
                     state_reg_touch_way_sized[2]
                       ? state_reg[17:15]
                       : {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[16],
                          state_reg_touch_way_sized[1]
                            ? state_reg[15]
                            : ~(state_reg_touch_way_sized[0])}}}
             : state_reg[25:15],
           state_reg_touch_way_sized[4]
             ? state_reg[14:0]
             : {~(state_reg_touch_way_sized[3]),
                state_reg_touch_way_sized[3]
                  ? {~(state_reg_touch_way_sized[2]),
                     state_reg_touch_way_sized[2]
                       ? {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[11],
                          state_reg_touch_way_sized[1]
                            ? state_reg[10]
                            : ~(state_reg_touch_way_sized[0])}
                       : state_reg[12:10],
                     state_reg_touch_way_sized[2]
                       ? state_reg[9:7]
                       : {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[8],
                          state_reg_touch_way_sized[1]
                            ? state_reg[7]
                            : ~(state_reg_touch_way_sized[0])}}
                  : state_reg[13:7],
                state_reg_touch_way_sized[3]
                  ? state_reg[6:0]
                  : {~(state_reg_touch_way_sized[2]),
                     state_reg_touch_way_sized[2]
                       ? {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[4],
                          state_reg_touch_way_sized[1]
                            ? state_reg[3]
                            : ~(state_reg_touch_way_sized[0])}
                       : state_reg[5:3],
                     state_reg_touch_way_sized[2]
                       ? state_reg[2:0]
                       : {~(state_reg_touch_way_sized[1]),
                          state_reg_touch_way_sized[1]
                            ? ~(state_reg_touch_way_sized[0])
                            : state_reg[1],
                          state_reg_touch_way_sized[1]
                            ? state_reg[0]
                            : ~(state_reg_touch_way_sized[0])}}}};	// BTB.scala:261:20, Cat.scala:30:58, Replacement.scala:168:70, :196:{33,43}, :198:38, :203:16, :206:16, :207:62, :218:7, :245:38, package.scala:154:13
      end
      r_respPipe_valid <= _io_resp_valid_T_84[0];	// BTB.scala:289:34, Valid.scala:117:22
      if (io_bht_update_valid & io_bht_update_bits_mispredict)	// BTB.scala:309:33, :312:32, :313:40
        history <=
          io_bht_update_bits_branch
            ? {io_bht_update_bits_taken, io_bht_update_bits_prediction_history[7:1]}
            : io_bht_update_bits_prediction_history;	// BTB.scala:109:13, :112:{13,37}, :119:24, :309:33, :315:46, :318:50, Cat.scala:30:58
      else if (io_bht_advance_valid)
        history <= {io_bht_advance_bits_bht_value, history[7:1]};	// BTB.scala:115:35, :119:24, Cat.scala:30:58
      if (reset_waddr[9]) begin	// BTB.scala:121:36, :122:39
      end
      else	// BTB.scala:122:39
        reset_waddr <= reset_waddr + 10'h1;	// BTB.scala:121:36, :126:49
      if (io_ras_update_valid) begin
        if (_GEN_6) begin	// BTB.scala:335:40
          if (count[2:1] != 2'h3)	// BTB.scala:45:17, :58:30, package.scala:32:86
            count <= count + 3'h1;	// BTB.scala:45:42, :47:20, :58:30
          if (_nextPos_T_1)	// BTB.scala:46:49
            pos <= _nextPos_T_2;	// BTB.scala:46:62, :59:28
          else	// BTB.scala:46:49
            pos <= 3'h0;	// BTB.scala:59:28, :239:29
        end
        else if ((&io_ras_update_bits_cfiType) & (|count)) begin	// BTB.scala:51:37, :52:11, :56:29, :58:30, :337:{46,63}
          count <= count - 3'h1;	// BTB.scala:52:20, :58:30
          if (|pos)	// BTB.scala:53:42, :59:28
            pos <= pos - 3'h1;	// BTB.scala:53:50, :59:28
          else	// BTB.scala:53:42
            pos <= 3'h5;	// BTB.scala:59:28, package.scala:32:86
        end
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:52];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h35; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        idxs_0 = _RANDOM[6'h0][12:0];	// BTB.scala:201:17
        idxs_1 = _RANDOM[6'h0][25:13];	// BTB.scala:201:17
        idxs_2 = {_RANDOM[6'h0][31:26], _RANDOM[6'h1][6:0]};	// BTB.scala:201:17
        idxs_3 = _RANDOM[6'h1][19:7];	// BTB.scala:201:17
        idxs_4 = {_RANDOM[6'h1][31:20], _RANDOM[6'h2][0]};	// BTB.scala:201:17
        idxs_5 = _RANDOM[6'h2][13:1];	// BTB.scala:201:17
        idxs_6 = _RANDOM[6'h2][26:14];	// BTB.scala:201:17
        idxs_7 = {_RANDOM[6'h2][31:27], _RANDOM[6'h3][7:0]};	// BTB.scala:201:17
        idxs_8 = _RANDOM[6'h3][20:8];	// BTB.scala:201:17
        idxs_9 = {_RANDOM[6'h3][31:21], _RANDOM[6'h4][1:0]};	// BTB.scala:201:17
        idxs_10 = _RANDOM[6'h4][14:2];	// BTB.scala:201:17
        idxs_11 = _RANDOM[6'h4][27:15];	// BTB.scala:201:17
        idxs_12 = {_RANDOM[6'h4][31:28], _RANDOM[6'h5][8:0]};	// BTB.scala:201:17
        idxs_13 = _RANDOM[6'h5][21:9];	// BTB.scala:201:17
        idxs_14 = {_RANDOM[6'h5][31:22], _RANDOM[6'h6][2:0]};	// BTB.scala:201:17
        idxs_15 = _RANDOM[6'h6][15:3];	// BTB.scala:201:17
        idxs_16 = _RANDOM[6'h6][28:16];	// BTB.scala:201:17
        idxs_17 = {_RANDOM[6'h6][31:29], _RANDOM[6'h7][9:0]};	// BTB.scala:201:17
        idxs_18 = _RANDOM[6'h7][22:10];	// BTB.scala:201:17
        idxs_19 = {_RANDOM[6'h7][31:23], _RANDOM[6'h8][3:0]};	// BTB.scala:201:17
        idxs_20 = _RANDOM[6'h8][16:4];	// BTB.scala:201:17
        idxs_21 = _RANDOM[6'h8][29:17];	// BTB.scala:201:17
        idxs_22 = {_RANDOM[6'h8][31:30], _RANDOM[6'h9][10:0]};	// BTB.scala:201:17
        idxs_23 = _RANDOM[6'h9][23:11];	// BTB.scala:201:17
        idxs_24 = {_RANDOM[6'h9][31:24], _RANDOM[6'hA][4:0]};	// BTB.scala:201:17
        idxs_25 = _RANDOM[6'hA][17:5];	// BTB.scala:201:17
        idxs_26 = _RANDOM[6'hA][30:18];	// BTB.scala:201:17
        idxs_27 = {_RANDOM[6'hA][31], _RANDOM[6'hB][11:0]};	// BTB.scala:201:17
        idxPages_0 = _RANDOM[6'hB][14:12];	// BTB.scala:201:17, :202:21
        idxPages_1 = _RANDOM[6'hB][17:15];	// BTB.scala:201:17, :202:21
        idxPages_2 = _RANDOM[6'hB][20:18];	// BTB.scala:201:17, :202:21
        idxPages_3 = _RANDOM[6'hB][23:21];	// BTB.scala:201:17, :202:21
        idxPages_4 = _RANDOM[6'hB][26:24];	// BTB.scala:201:17, :202:21
        idxPages_5 = _RANDOM[6'hB][29:27];	// BTB.scala:201:17, :202:21
        idxPages_6 = {_RANDOM[6'hB][31:30], _RANDOM[6'hC][0]};	// BTB.scala:201:17, :202:21
        idxPages_7 = _RANDOM[6'hC][3:1];	// BTB.scala:202:21
        idxPages_8 = _RANDOM[6'hC][6:4];	// BTB.scala:202:21
        idxPages_9 = _RANDOM[6'hC][9:7];	// BTB.scala:202:21
        idxPages_10 = _RANDOM[6'hC][12:10];	// BTB.scala:202:21
        idxPages_11 = _RANDOM[6'hC][15:13];	// BTB.scala:202:21
        idxPages_12 = _RANDOM[6'hC][18:16];	// BTB.scala:202:21
        idxPages_13 = _RANDOM[6'hC][21:19];	// BTB.scala:202:21
        idxPages_14 = _RANDOM[6'hC][24:22];	// BTB.scala:202:21
        idxPages_15 = _RANDOM[6'hC][27:25];	// BTB.scala:202:21
        idxPages_16 = _RANDOM[6'hC][30:28];	// BTB.scala:202:21
        idxPages_17 = {_RANDOM[6'hC][31], _RANDOM[6'hD][1:0]};	// BTB.scala:202:21
        idxPages_18 = _RANDOM[6'hD][4:2];	// BTB.scala:202:21
        idxPages_19 = _RANDOM[6'hD][7:5];	// BTB.scala:202:21
        idxPages_20 = _RANDOM[6'hD][10:8];	// BTB.scala:202:21
        idxPages_21 = _RANDOM[6'hD][13:11];	// BTB.scala:202:21
        idxPages_22 = _RANDOM[6'hD][16:14];	// BTB.scala:202:21
        idxPages_23 = _RANDOM[6'hD][19:17];	// BTB.scala:202:21
        idxPages_24 = _RANDOM[6'hD][22:20];	// BTB.scala:202:21
        idxPages_25 = _RANDOM[6'hD][25:23];	// BTB.scala:202:21
        idxPages_26 = _RANDOM[6'hD][28:26];	// BTB.scala:202:21
        idxPages_27 = _RANDOM[6'hD][31:29];	// BTB.scala:202:21
        tgts_0 = _RANDOM[6'hE][12:0];	// BTB.scala:203:17
        tgts_1 = _RANDOM[6'hE][25:13];	// BTB.scala:203:17
        tgts_2 = {_RANDOM[6'hE][31:26], _RANDOM[6'hF][6:0]};	// BTB.scala:203:17
        tgts_3 = _RANDOM[6'hF][19:7];	// BTB.scala:203:17
        tgts_4 = {_RANDOM[6'hF][31:20], _RANDOM[6'h10][0]};	// BTB.scala:203:17
        tgts_5 = _RANDOM[6'h10][13:1];	// BTB.scala:203:17
        tgts_6 = _RANDOM[6'h10][26:14];	// BTB.scala:203:17
        tgts_7 = {_RANDOM[6'h10][31:27], _RANDOM[6'h11][7:0]};	// BTB.scala:203:17
        tgts_8 = _RANDOM[6'h11][20:8];	// BTB.scala:203:17
        tgts_9 = {_RANDOM[6'h11][31:21], _RANDOM[6'h12][1:0]};	// BTB.scala:203:17
        tgts_10 = _RANDOM[6'h12][14:2];	// BTB.scala:203:17
        tgts_11 = _RANDOM[6'h12][27:15];	// BTB.scala:203:17
        tgts_12 = {_RANDOM[6'h12][31:28], _RANDOM[6'h13][8:0]};	// BTB.scala:203:17
        tgts_13 = _RANDOM[6'h13][21:9];	// BTB.scala:203:17
        tgts_14 = {_RANDOM[6'h13][31:22], _RANDOM[6'h14][2:0]};	// BTB.scala:203:17
        tgts_15 = _RANDOM[6'h14][15:3];	// BTB.scala:203:17
        tgts_16 = _RANDOM[6'h14][28:16];	// BTB.scala:203:17
        tgts_17 = {_RANDOM[6'h14][31:29], _RANDOM[6'h15][9:0]};	// BTB.scala:203:17
        tgts_18 = _RANDOM[6'h15][22:10];	// BTB.scala:203:17
        tgts_19 = {_RANDOM[6'h15][31:23], _RANDOM[6'h16][3:0]};	// BTB.scala:203:17
        tgts_20 = _RANDOM[6'h16][16:4];	// BTB.scala:203:17
        tgts_21 = _RANDOM[6'h16][29:17];	// BTB.scala:203:17
        tgts_22 = {_RANDOM[6'h16][31:30], _RANDOM[6'h17][10:0]};	// BTB.scala:203:17
        tgts_23 = _RANDOM[6'h17][23:11];	// BTB.scala:203:17
        tgts_24 = {_RANDOM[6'h17][31:24], _RANDOM[6'h18][4:0]};	// BTB.scala:203:17
        tgts_25 = _RANDOM[6'h18][17:5];	// BTB.scala:203:17
        tgts_26 = _RANDOM[6'h18][30:18];	// BTB.scala:203:17
        tgts_27 = {_RANDOM[6'h18][31], _RANDOM[6'h19][11:0]};	// BTB.scala:203:17
        tgtPages_0 = _RANDOM[6'h19][14:12];	// BTB.scala:203:17, :204:21
        tgtPages_1 = _RANDOM[6'h19][17:15];	// BTB.scala:203:17, :204:21
        tgtPages_2 = _RANDOM[6'h19][20:18];	// BTB.scala:203:17, :204:21
        tgtPages_3 = _RANDOM[6'h19][23:21];	// BTB.scala:203:17, :204:21
        tgtPages_4 = _RANDOM[6'h19][26:24];	// BTB.scala:203:17, :204:21
        tgtPages_5 = _RANDOM[6'h19][29:27];	// BTB.scala:203:17, :204:21
        tgtPages_6 = {_RANDOM[6'h19][31:30], _RANDOM[6'h1A][0]};	// BTB.scala:203:17, :204:21
        tgtPages_7 = _RANDOM[6'h1A][3:1];	// BTB.scala:204:21
        tgtPages_8 = _RANDOM[6'h1A][6:4];	// BTB.scala:204:21
        tgtPages_9 = _RANDOM[6'h1A][9:7];	// BTB.scala:204:21
        tgtPages_10 = _RANDOM[6'h1A][12:10];	// BTB.scala:204:21
        tgtPages_11 = _RANDOM[6'h1A][15:13];	// BTB.scala:204:21
        tgtPages_12 = _RANDOM[6'h1A][18:16];	// BTB.scala:204:21
        tgtPages_13 = _RANDOM[6'h1A][21:19];	// BTB.scala:204:21
        tgtPages_14 = _RANDOM[6'h1A][24:22];	// BTB.scala:204:21
        tgtPages_15 = _RANDOM[6'h1A][27:25];	// BTB.scala:204:21
        tgtPages_16 = _RANDOM[6'h1A][30:28];	// BTB.scala:204:21
        tgtPages_17 = {_RANDOM[6'h1A][31], _RANDOM[6'h1B][1:0]};	// BTB.scala:204:21
        tgtPages_18 = _RANDOM[6'h1B][4:2];	// BTB.scala:204:21
        tgtPages_19 = _RANDOM[6'h1B][7:5];	// BTB.scala:204:21
        tgtPages_20 = _RANDOM[6'h1B][10:8];	// BTB.scala:204:21
        tgtPages_21 = _RANDOM[6'h1B][13:11];	// BTB.scala:204:21
        tgtPages_22 = _RANDOM[6'h1B][16:14];	// BTB.scala:204:21
        tgtPages_23 = _RANDOM[6'h1B][19:17];	// BTB.scala:204:21
        tgtPages_24 = _RANDOM[6'h1B][22:20];	// BTB.scala:204:21
        tgtPages_25 = _RANDOM[6'h1B][25:23];	// BTB.scala:204:21
        tgtPages_26 = _RANDOM[6'h1B][28:26];	// BTB.scala:204:21
        tgtPages_27 = _RANDOM[6'h1B][31:29];	// BTB.scala:204:21
        pages_0 = _RANDOM[6'h1C][24:0];	// BTB.scala:205:18
        pages_1 = {_RANDOM[6'h1C][31:25], _RANDOM[6'h1D][17:0]};	// BTB.scala:205:18
        pages_2 = {_RANDOM[6'h1D][31:18], _RANDOM[6'h1E][10:0]};	// BTB.scala:205:18
        pages_3 = {_RANDOM[6'h1E][31:11], _RANDOM[6'h1F][3:0]};	// BTB.scala:205:18
        pages_4 = _RANDOM[6'h1F][28:4];	// BTB.scala:205:18
        pages_5 = {_RANDOM[6'h1F][31:29], _RANDOM[6'h20][21:0]};	// BTB.scala:205:18
        pageValid = _RANDOM[6'h20][27:22];	// BTB.scala:205:18, :206:22
        isValid = {_RANDOM[6'h20][31:28], _RANDOM[6'h21][23:0]};	// BTB.scala:205:18, :209:20
        cfiType_0 = _RANDOM[6'h21][25:24];	// BTB.scala:209:20, :210:20
        cfiType_1 = _RANDOM[6'h21][27:26];	// BTB.scala:209:20, :210:20
        cfiType_2 = _RANDOM[6'h21][29:28];	// BTB.scala:209:20, :210:20
        cfiType_3 = _RANDOM[6'h21][31:30];	// BTB.scala:209:20, :210:20
        cfiType_4 = _RANDOM[6'h22][1:0];	// BTB.scala:210:20
        cfiType_5 = _RANDOM[6'h22][3:2];	// BTB.scala:210:20
        cfiType_6 = _RANDOM[6'h22][5:4];	// BTB.scala:210:20
        cfiType_7 = _RANDOM[6'h22][7:6];	// BTB.scala:210:20
        cfiType_8 = _RANDOM[6'h22][9:8];	// BTB.scala:210:20
        cfiType_9 = _RANDOM[6'h22][11:10];	// BTB.scala:210:20
        cfiType_10 = _RANDOM[6'h22][13:12];	// BTB.scala:210:20
        cfiType_11 = _RANDOM[6'h22][15:14];	// BTB.scala:210:20
        cfiType_12 = _RANDOM[6'h22][17:16];	// BTB.scala:210:20
        cfiType_13 = _RANDOM[6'h22][19:18];	// BTB.scala:210:20
        cfiType_14 = _RANDOM[6'h22][21:20];	// BTB.scala:210:20
        cfiType_15 = _RANDOM[6'h22][23:22];	// BTB.scala:210:20
        cfiType_16 = _RANDOM[6'h22][25:24];	// BTB.scala:210:20
        cfiType_17 = _RANDOM[6'h22][27:26];	// BTB.scala:210:20
        cfiType_18 = _RANDOM[6'h22][29:28];	// BTB.scala:210:20
        cfiType_19 = _RANDOM[6'h22][31:30];	// BTB.scala:210:20
        cfiType_20 = _RANDOM[6'h23][1:0];	// BTB.scala:210:20
        cfiType_21 = _RANDOM[6'h23][3:2];	// BTB.scala:210:20
        cfiType_22 = _RANDOM[6'h23][5:4];	// BTB.scala:210:20
        cfiType_23 = _RANDOM[6'h23][7:6];	// BTB.scala:210:20
        cfiType_24 = _RANDOM[6'h23][9:8];	// BTB.scala:210:20
        cfiType_25 = _RANDOM[6'h23][11:10];	// BTB.scala:210:20
        cfiType_26 = _RANDOM[6'h23][13:12];	// BTB.scala:210:20
        cfiType_27 = _RANDOM[6'h23][15:14];	// BTB.scala:210:20
        brIdx_0 = _RANDOM[6'h23][16];	// BTB.scala:210:20, :211:18
        brIdx_1 = _RANDOM[6'h23][17];	// BTB.scala:210:20, :211:18
        brIdx_2 = _RANDOM[6'h23][18];	// BTB.scala:210:20, :211:18
        brIdx_3 = _RANDOM[6'h23][19];	// BTB.scala:210:20, :211:18
        brIdx_4 = _RANDOM[6'h23][20];	// BTB.scala:210:20, :211:18
        brIdx_5 = _RANDOM[6'h23][21];	// BTB.scala:210:20, :211:18
        brIdx_6 = _RANDOM[6'h23][22];	// BTB.scala:210:20, :211:18
        brIdx_7 = _RANDOM[6'h23][23];	// BTB.scala:210:20, :211:18
        brIdx_8 = _RANDOM[6'h23][24];	// BTB.scala:210:20, :211:18
        brIdx_9 = _RANDOM[6'h23][25];	// BTB.scala:210:20, :211:18
        brIdx_10 = _RANDOM[6'h23][26];	// BTB.scala:210:20, :211:18
        brIdx_11 = _RANDOM[6'h23][27];	// BTB.scala:210:20, :211:18
        brIdx_12 = _RANDOM[6'h23][28];	// BTB.scala:210:20, :211:18
        brIdx_13 = _RANDOM[6'h23][29];	// BTB.scala:210:20, :211:18
        brIdx_14 = _RANDOM[6'h23][30];	// BTB.scala:210:20, :211:18
        brIdx_15 = _RANDOM[6'h23][31];	// BTB.scala:210:20, :211:18
        brIdx_16 = _RANDOM[6'h24][0];	// BTB.scala:211:18
        brIdx_17 = _RANDOM[6'h24][1];	// BTB.scala:211:18
        brIdx_18 = _RANDOM[6'h24][2];	// BTB.scala:211:18
        brIdx_19 = _RANDOM[6'h24][3];	// BTB.scala:211:18
        brIdx_20 = _RANDOM[6'h24][4];	// BTB.scala:211:18
        brIdx_21 = _RANDOM[6'h24][5];	// BTB.scala:211:18
        brIdx_22 = _RANDOM[6'h24][6];	// BTB.scala:211:18
        brIdx_23 = _RANDOM[6'h24][7];	// BTB.scala:211:18
        brIdx_24 = _RANDOM[6'h24][8];	// BTB.scala:211:18
        brIdx_25 = _RANDOM[6'h24][9];	// BTB.scala:211:18
        brIdx_26 = _RANDOM[6'h24][10];	// BTB.scala:211:18
        brIdx_27 = _RANDOM[6'h24][11];	// BTB.scala:211:18
        r_btb_updatePipe_valid = _RANDOM[6'h24][12];	// BTB.scala:211:18, Valid.scala:117:22
        r_btb_updatePipe_bits_prediction_entry = _RANDOM[6'h25][30:26];	// Reg.scala:15:16
        r_btb_updatePipe_bits_pc = {_RANDOM[6'h26][31:8], _RANDOM[6'h27][14:0]};	// Reg.scala:15:16
        r_btb_updatePipe_bits_isValid = _RANDOM[6'h28][23];	// Reg.scala:15:16
        r_btb_updatePipe_bits_br_pc = {_RANDOM[6'h28][31:24], _RANDOM[6'h29][30:0]};	// Reg.scala:15:16
        r_btb_updatePipe_bits_cfiType = {_RANDOM[6'h29][31], _RANDOM[6'h2A][0]};	// Reg.scala:15:16
        nextPageRepl = _RANDOM[6'h2A][3:1];	// BTB.scala:239:29, Reg.scala:15:16
        state_reg = _RANDOM[6'h2A][30:4];	// Reg.scala:15:16, Replacement.scala:168:70
        r_respPipe_valid = _RANDOM[6'h2A][31];	// Reg.scala:15:16, Valid.scala:117:22
        r_respPipe_bits_taken = _RANDOM[6'h2B][2];	// Reg.scala:15:16
        r_respPipe_bits_entry = _RANDOM[6'h2C][17:13];	// Reg.scala:15:16
        history = {_RANDOM[6'h2C][31:27], _RANDOM[6'h2D][2:0]};	// BTB.scala:119:24, Reg.scala:15:16
        reset_waddr = _RANDOM[6'h2D][12:3];	// BTB.scala:119:24, :121:36
        count = _RANDOM[6'h2D][15:13];	// BTB.scala:58:30, :119:24
        pos = _RANDOM[6'h2D][18:16];	// BTB.scala:59:28, :119:24
        stack_0 = {_RANDOM[6'h2D][31:19], _RANDOM[6'h2E][25:0]};	// BTB.scala:60:26, :119:24
        stack_1 = {_RANDOM[6'h2E][31:26], _RANDOM[6'h2F], _RANDOM[6'h30][0]};	// BTB.scala:60:26
        stack_2 = {_RANDOM[6'h30][31:1], _RANDOM[6'h31][7:0]};	// BTB.scala:60:26
        stack_3 = {_RANDOM[6'h31][31:8], _RANDOM[6'h32][14:0]};	// BTB.scala:60:26
        stack_4 = {_RANDOM[6'h32][31:15], _RANDOM[6'h33][21:0]};	// BTB.scala:60:26
        stack_5 = {_RANDOM[6'h33][31:22], _RANDOM[6'h34][28:0]};	// BTB.scala:60:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  table_512x1 table_ext (	// BTB.scala:118:26
    .R0_addr
      ({io_req_bits_addr[10:4], io_req_bits_addr[3:2] ^ io_req_bits_addr[12:11]}
       ^ {_res_res_value_T_4[7:5], 6'h0}),	// BTB.scala:84:{12,19}, :87:21, :88:{9,42,48,77}, :90:{20,44}
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr
      (_GEN_0
         ? {io_bht_update_bits_pc[10:4],
            io_bht_update_bits_pc[3:2] ^ io_bht_update_bits_pc[12:11]}
           ^ {_waddr_T_31[7:5], 6'h0}
         : reset_waddr[8:0]),	// BTB.scala:84:{12,19}, :87:21, :88:{9,42,48,77}, :90:{20,44}, :100:23, :101:13, :121:36, :312:32, :313:40
    .W0_en   (io_bht_update_valid & io_bht_update_bits_branch | ~(reset_waddr[9])),	// BTB.scala:99:9, :121:36, :122:{27,39}, :312:32, :313:40
    .W0_clk  (clock),
    .W0_data (_GEN_0 & io_bht_update_bits_taken),	// BTB.scala:100:23, :101:13, :102:13, :312:32, :313:40
    .R0_data (_table_ext_R0_data)
  );
  assign io_resp_valid = _io_resp_valid_T_84[0];	// BTB.scala:289:34
  assign io_resp_bits_taken = ~_GEN_1;	// BTB.scala:201:17, :290:22, :322:{22,35,56}, OneHot.scala:58:35
  assign io_resp_bits_bridx =
    _io_resp_bits_cfiType_T & brIdx_0 | _io_resp_bits_cfiType_T_1 & brIdx_1
    | _io_resp_bits_cfiType_T_2 & brIdx_2 | _io_resp_bits_cfiType_T_3 & brIdx_3
    | _io_resp_bits_cfiType_T_4 & brIdx_4 | _io_resp_bits_cfiType_T_5 & brIdx_5
    | _io_resp_bits_cfiType_T_6 & brIdx_6 | _io_resp_bits_cfiType_T_7 & brIdx_7
    | _io_resp_bits_cfiType_T_8 & brIdx_8 | _io_resp_bits_cfiType_T_9 & brIdx_9
    | _io_resp_bits_cfiType_T_10 & brIdx_10 | _io_resp_bits_cfiType_T_11 & brIdx_11
    | _io_resp_bits_cfiType_T_12 & brIdx_12 | _io_resp_bits_cfiType_T_13 & brIdx_13
    | _io_resp_bits_cfiType_T_14 & brIdx_14 | _io_resp_bits_cfiType_T_15 & brIdx_15
    | _io_resp_bits_cfiType_T_16 & brIdx_16 | _io_resp_bits_cfiType_T_17 & brIdx_17
    | _io_resp_bits_cfiType_T_18 & brIdx_18 | _io_resp_bits_cfiType_T_19 & brIdx_19
    | _io_resp_bits_cfiType_T_20 & brIdx_20 | _io_resp_bits_cfiType_T_21 & brIdx_21
    | _io_resp_bits_cfiType_T_22 & brIdx_22 | _io_resp_bits_cfiType_T_23 & brIdx_23
    | _io_resp_bits_cfiType_T_24 & brIdx_24 | _io_resp_bits_cfiType_T_25 & brIdx_25
    | _io_resp_bits_cfiType_T_26 & brIdx_26 | _io_resp_bits_cfiType_T_27 & brIdx_27;	// BTB.scala:211:18, :220:32, Mux.scala:27:72, :29:36
  assign io_resp_bits_target =
    (|count)
    & (|(idxHit
         & {&cfiType_27,
            &cfiType_26,
            &cfiType_25,
            &cfiType_24,
            &cfiType_23,
            &cfiType_22,
            &cfiType_21,
            &cfiType_20,
            &cfiType_19,
            &cfiType_18,
            &cfiType_17,
            &cfiType_16,
            &cfiType_15,
            &cfiType_14,
            &cfiType_13,
            &cfiType_12,
            &cfiType_11,
            &cfiType_10,
            &cfiType_9,
            &cfiType_8,
            &cfiType_7,
            &cfiType_6,
            &cfiType_5,
            &cfiType_4,
            &cfiType_3,
            &cfiType_2,
            &cfiType_1,
            &cfiType_0}))
      ? _GEN_3
      : {_GEN[(_io_resp_bits_cfiType_T ? tgtPages_0 : 3'h0)
           | (_io_resp_bits_cfiType_T_1 ? tgtPages_1 : 3'h0)
           | (_io_resp_bits_cfiType_T_2 ? tgtPages_2 : 3'h0)
           | (_io_resp_bits_cfiType_T_3 ? tgtPages_3 : 3'h0)
           | (_io_resp_bits_cfiType_T_4 ? tgtPages_4 : 3'h0)
           | (_io_resp_bits_cfiType_T_5 ? tgtPages_5 : 3'h0)
           | (_io_resp_bits_cfiType_T_6 ? tgtPages_6 : 3'h0)
           | (_io_resp_bits_cfiType_T_7 ? tgtPages_7 : 3'h0)
           | (_io_resp_bits_cfiType_T_8 ? tgtPages_8 : 3'h0)
           | (_io_resp_bits_cfiType_T_9 ? tgtPages_9 : 3'h0)
           | (_io_resp_bits_cfiType_T_10 ? tgtPages_10 : 3'h0)
           | (_io_resp_bits_cfiType_T_11 ? tgtPages_11 : 3'h0)
           | (_io_resp_bits_cfiType_T_12 ? tgtPages_12 : 3'h0)
           | (_io_resp_bits_cfiType_T_13 ? tgtPages_13 : 3'h0)
           | (_io_resp_bits_cfiType_T_14 ? tgtPages_14 : 3'h0)
           | (_io_resp_bits_cfiType_T_15 ? tgtPages_15 : 3'h0)
           | (_io_resp_bits_cfiType_T_16 ? tgtPages_16 : 3'h0)
           | (_io_resp_bits_cfiType_T_17 ? tgtPages_17 : 3'h0)
           | (_io_resp_bits_cfiType_T_18 ? tgtPages_18 : 3'h0)
           | (_io_resp_bits_cfiType_T_19 ? tgtPages_19 : 3'h0)
           | (_io_resp_bits_cfiType_T_20 ? tgtPages_20 : 3'h0)
           | (_io_resp_bits_cfiType_T_21 ? tgtPages_21 : 3'h0)
           | (_io_resp_bits_cfiType_T_22 ? tgtPages_22 : 3'h0)
           | (_io_resp_bits_cfiType_T_23 ? tgtPages_23 : 3'h0)
           | (_io_resp_bits_cfiType_T_24 ? tgtPages_24 : 3'h0)
           | (_io_resp_bits_cfiType_T_25 ? tgtPages_25 : 3'h0)
           | (_io_resp_bits_cfiType_T_26 ? tgtPages_26 : 3'h0)
           | (_io_resp_bits_cfiType_T_27 ? tgtPages_27 : 3'h0)],
         (_io_resp_bits_cfiType_T ? tgts_0 : 13'h0)
           | (_io_resp_bits_cfiType_T_1 ? tgts_1 : 13'h0)
           | (_io_resp_bits_cfiType_T_2 ? tgts_2 : 13'h0)
           | (_io_resp_bits_cfiType_T_3 ? tgts_3 : 13'h0)
           | (_io_resp_bits_cfiType_T_4 ? tgts_4 : 13'h0)
           | (_io_resp_bits_cfiType_T_5 ? tgts_5 : 13'h0)
           | (_io_resp_bits_cfiType_T_6 ? tgts_6 : 13'h0)
           | (_io_resp_bits_cfiType_T_7 ? tgts_7 : 13'h0)
           | (_io_resp_bits_cfiType_T_8 ? tgts_8 : 13'h0)
           | (_io_resp_bits_cfiType_T_9 ? tgts_9 : 13'h0)
           | (_io_resp_bits_cfiType_T_10 ? tgts_10 : 13'h0)
           | (_io_resp_bits_cfiType_T_11 ? tgts_11 : 13'h0)
           | (_io_resp_bits_cfiType_T_12 ? tgts_12 : 13'h0)
           | (_io_resp_bits_cfiType_T_13 ? tgts_13 : 13'h0)
           | (_io_resp_bits_cfiType_T_14 ? tgts_14 : 13'h0)
           | (_io_resp_bits_cfiType_T_15 ? tgts_15 : 13'h0)
           | (_io_resp_bits_cfiType_T_16 ? tgts_16 : 13'h0)
           | (_io_resp_bits_cfiType_T_17 ? tgts_17 : 13'h0)
           | (_io_resp_bits_cfiType_T_18 ? tgts_18 : 13'h0)
           | (_io_resp_bits_cfiType_T_19 ? tgts_19 : 13'h0)
           | (_io_resp_bits_cfiType_T_20 ? tgts_20 : 13'h0)
           | (_io_resp_bits_cfiType_T_21 ? tgts_21 : 13'h0)
           | (_io_resp_bits_cfiType_T_22 ? tgts_22 : 13'h0)
           | (_io_resp_bits_cfiType_T_23 ? tgts_23 : 13'h0)
           | (_io_resp_bits_cfiType_T_24 ? tgts_24 : 13'h0)
           | (_io_resp_bits_cfiType_T_25 ? tgts_25 : 13'h0)
           | (_io_resp_bits_cfiType_T_26 ? tgts_26 : 13'h0)
           | (_io_resp_bits_cfiType_T_27 ? tgts_27 : 13'h0),
         1'h0};	// BTB.scala:56:29, :58:30, :201:17, :203:17, :204:21, :210:20, :220:32, :239:29, :291:23, :328:{26,42,67}, :330:22, :331:{24,35}, :332:27, Cat.scala:30:58, Mux.scala:27:72, :29:36, package.scala:32:{76,86}
  assign io_resp_bits_entry = _io_resp_bits_entry_output;	// Cat.scala:30:58
  assign io_resp_bits_bht_history = history;	// BTB.scala:119:24
  assign io_resp_bits_bht_value = res_value;	// BTB.scala:94:21
  assign io_ras_head_valid = |count;	// BTB.scala:56:29, :58:30
  assign io_ras_head_bits = _GEN_3;	// BTB.scala:330:22
endmodule

