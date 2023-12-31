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

module LoopBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input  [3:0]   io_f0_mask,
  input          io_resp_in_0_f2_0_is_br,
                 io_resp_in_0_f2_0_predicted_pc_valid,
                 io_resp_in_0_f2_1_is_br,
                 io_resp_in_0_f2_1_predicted_pc_valid,
                 io_resp_in_0_f2_2_is_br,
                 io_resp_in_0_f2_2_predicted_pc_valid,
                 io_resp_in_0_f2_3_is_br,
                 io_resp_in_0_f2_3_predicted_pc_valid,
                 io_resp_in_0_f3_0_taken,
                 io_resp_in_0_f3_1_taken,
                 io_resp_in_0_f3_2_taken,
                 io_resp_in_0_f3_3_taken,
                 io_f3_fire,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_mispredicted,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f3_0_taken,
                 io_resp_f3_1_taken,
                 io_resp_f3_2_taken,
                 io_resp_f3_3_taken,
  output [119:0] io_f3_meta
);

  wire [9:0]   _columns_3_io_f3_meta_s_cnt;	// loop.scala:182:45
  wire [9:0]   _columns_2_io_f3_meta_s_cnt;	// loop.scala:182:45
  wire [9:0]   _columns_1_io_f3_meta_s_cnt;	// loop.scala:182:45
  wire [9:0]   _columns_0_io_f3_meta_s_cnt;	// loop.scala:182:45
  reg  [35:0]  s1_idx;	// predictor.scala:163:29
  reg  [35:0]  s2_idx;	// predictor.scala:164:29
  reg          s1_valid;	// predictor.scala:168:25
  reg          s2_valid;	// predictor.scala:169:25
  reg          s3_valid;	// predictor.scala:170:25
  reg  [3:0]   s1_mask;	// predictor.scala:173:24
  reg  [3:0]   s2_mask;	// predictor.scala:174:24
  reg  [3:0]   s3_mask;	// predictor.scala:175:24
  reg          s1_update_valid;	// predictor.scala:184:30
  reg          s1_update_bits_is_mispredict_update;	// predictor.scala:184:30
  reg          s1_update_bits_is_repair_update;	// predictor.scala:184:30
  reg  [3:0]   s1_update_bits_br_mask;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30
  reg  [119:0] s1_update_bits_meta;	// predictor.scala:184:30
  reg  [35:0]  s1_update_idx;	// predictor.scala:185:30
  reg          columns_0_io_f3_req_fire_REG;	// loop.scala:193:14
  reg          columns_1_io_f3_req_fire_REG;	// loop.scala:193:14
  reg          columns_2_io_f3_req_fire_REG;	// loop.scala:193:14
  reg          columns_3_io_f3_req_fire_REG;	// loop.scala:193:14
  always @(posedge clock) begin
    s1_idx <= io_f0_pc[39:4];	// frontend.scala:163:35, predictor.scala:163:29
    s2_idx <= s1_idx;	// predictor.scala:163:29, :164:29
    s1_valid <= io_f0_valid;	// predictor.scala:168:25
    s2_valid <= s1_valid;	// predictor.scala:168:25, :169:25
    s3_valid <= s2_valid;	// predictor.scala:169:25, :170:25
    s1_mask <= io_f0_mask;	// predictor.scala:173:24
    s2_mask <= s1_mask;	// predictor.scala:173:24, :174:24
    s3_mask <= s2_mask;	// predictor.scala:174:24, :175:24
    s1_update_valid <= io_update_valid;	// predictor.scala:184:30
    s1_update_bits_is_mispredict_update <= io_update_bits_is_mispredict_update;	// predictor.scala:184:30
    s1_update_bits_is_repair_update <= io_update_bits_is_repair_update;	// predictor.scala:184:30
    s1_update_bits_br_mask <= io_update_bits_br_mask;	// predictor.scala:184:30
    s1_update_bits_cfi_mispredicted <= io_update_bits_cfi_mispredicted;	// predictor.scala:184:30
    s1_update_bits_meta <= io_update_bits_meta;	// predictor.scala:184:30
    s1_update_idx <= io_update_bits_pc[39:4];	// frontend.scala:163:35, predictor.scala:185:30
    columns_0_io_f3_req_fire_REG <=
      io_resp_in_0_f2_0_predicted_pc_valid & io_resp_in_0_f2_0_is_br;	// loop.scala:193:{14,54}
    columns_1_io_f3_req_fire_REG <=
      io_resp_in_0_f2_1_predicted_pc_valid & io_resp_in_0_f2_1_is_br;	// loop.scala:193:{14,54}
    columns_2_io_f3_req_fire_REG <=
      io_resp_in_0_f2_2_predicted_pc_valid & io_resp_in_0_f2_2_is_br;	// loop.scala:193:{14,54}
    columns_3_io_f3_req_fire_REG <=
      io_resp_in_0_f2_3_predicted_pc_valid & io_resp_in_0_f2_3_is_br;	// loop.scala:193:{14,54}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:15];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h10; i += 5'h1) begin
          _RANDOM[i[3:0]] = `RANDOM;
        end
        s1_idx = {_RANDOM[4'h0], _RANDOM[4'h1][3:0]};	// predictor.scala:163:29
        s2_idx = {_RANDOM[4'h1][31:4], _RANDOM[4'h2][7:0]};	// predictor.scala:163:29, :164:29
        s1_valid = _RANDOM[4'h3][12];	// predictor.scala:168:25
        s2_valid = _RANDOM[4'h3][13];	// predictor.scala:168:25, :169:25
        s3_valid = _RANDOM[4'h3][14];	// predictor.scala:168:25, :170:25
        s1_mask = _RANDOM[4'h3][18:15];	// predictor.scala:168:25, :173:24
        s2_mask = _RANDOM[4'h3][22:19];	// predictor.scala:168:25, :174:24
        s3_mask = _RANDOM[4'h3][26:23];	// predictor.scala:168:25, :175:24
        s1_update_valid = _RANDOM[4'h5][3];	// predictor.scala:184:30
        s1_update_bits_is_mispredict_update = _RANDOM[4'h5][4];	// predictor.scala:184:30
        s1_update_bits_is_repair_update = _RANDOM[4'h5][5];	// predictor.scala:184:30
        s1_update_bits_br_mask = _RANDOM[4'h6][21:18];	// predictor.scala:184:30
        s1_update_bits_cfi_mispredicted = _RANDOM[4'h6][26];	// predictor.scala:184:30
        s1_update_bits_meta =
          {_RANDOM[4'hA][31:7], _RANDOM[4'hB], _RANDOM[4'hC], _RANDOM[4'hD][30:0]};	// predictor.scala:184:30
        s1_update_idx = {_RANDOM[4'hD][31], _RANDOM[4'hE], _RANDOM[4'hF][2:0]};	// predictor.scala:184:30, :185:30
        columns_0_io_f3_req_fire_REG = _RANDOM[4'hF][4];	// loop.scala:193:14, predictor.scala:185:30
        columns_1_io_f3_req_fire_REG = _RANDOM[4'hF][5];	// loop.scala:193:14, predictor.scala:185:30
        columns_2_io_f3_req_fire_REG = _RANDOM[4'hF][6];	// loop.scala:193:14, predictor.scala:185:30
        columns_3_io_f3_req_fire_REG = _RANDOM[4'hF][7];	// loop.scala:193:14, predictor.scala:185:30
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  LoopBranchPredictorColumn columns_0 (	// loop.scala:182:45
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),	// predictor.scala:164:29
    .io_f3_req_fire
      (s3_valid & s3_mask[0] & io_f3_fire & columns_0_io_f3_req_fire_REG),	// loop.scala:192:{54,72}, :193:14, predictor.scala:170:25, :175:24
    .io_f3_pred_in        (io_resp_in_0_f3_0_taken),
    .io_update_mispredict
      (s1_update_valid & s1_update_bits_br_mask[0] & s1_update_bits_is_mispredict_update
       & s1_update_bits_cfi_mispredicted),	// loop.scala:199:68, :200:82, predictor.scala:184:30
    .io_update_repair
      (s1_update_valid & s1_update_bits_br_mask[0] & s1_update_bits_is_repair_update),	// loop.scala:199:68, :203:72, predictor.scala:184:30
    .io_update_idx        (s1_update_idx),	// predictor.scala:185:30
    .io_update_meta_s_cnt (s1_update_bits_meta[9:0]),	// loop.scala:187:49, predictor.scala:184:30
    .io_f3_pred           (io_resp_f3_0_taken),
    .io_f3_meta_s_cnt     (_columns_0_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_1 (	// loop.scala:182:45
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),	// predictor.scala:164:29
    .io_f3_req_fire
      (s3_valid & s3_mask[1] & io_f3_fire & columns_1_io_f3_req_fire_REG),	// loop.scala:192:{54,72}, :193:14, predictor.scala:170:25, :175:24
    .io_f3_pred_in        (io_resp_in_0_f3_1_taken),
    .io_update_mispredict
      (s1_update_valid & s1_update_bits_br_mask[1] & s1_update_bits_is_mispredict_update
       & s1_update_bits_cfi_mispredicted),	// loop.scala:199:68, :200:82, predictor.scala:184:30
    .io_update_repair
      (s1_update_valid & s1_update_bits_br_mask[1] & s1_update_bits_is_repair_update),	// loop.scala:199:68, :203:72, predictor.scala:184:30
    .io_update_idx        (s1_update_idx),	// predictor.scala:185:30
    .io_update_meta_s_cnt (s1_update_bits_meta[19:10]),	// loop.scala:187:49, predictor.scala:184:30
    .io_f3_pred           (io_resp_f3_1_taken),
    .io_f3_meta_s_cnt     (_columns_1_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_2 (	// loop.scala:182:45
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),	// predictor.scala:164:29
    .io_f3_req_fire
      (s3_valid & s3_mask[2] & io_f3_fire & columns_2_io_f3_req_fire_REG),	// loop.scala:192:{54,72}, :193:14, predictor.scala:170:25, :175:24
    .io_f3_pred_in        (io_resp_in_0_f3_2_taken),
    .io_update_mispredict
      (s1_update_valid & s1_update_bits_br_mask[2] & s1_update_bits_is_mispredict_update
       & s1_update_bits_cfi_mispredicted),	// loop.scala:199:68, :200:82, predictor.scala:184:30
    .io_update_repair
      (s1_update_valid & s1_update_bits_br_mask[2] & s1_update_bits_is_repair_update),	// loop.scala:199:68, :203:72, predictor.scala:184:30
    .io_update_idx        (s1_update_idx),	// predictor.scala:185:30
    .io_update_meta_s_cnt (s1_update_bits_meta[29:20]),	// loop.scala:187:49, predictor.scala:184:30
    .io_f3_pred           (io_resp_f3_2_taken),
    .io_f3_meta_s_cnt     (_columns_2_io_f3_meta_s_cnt)
  );
  LoopBranchPredictorColumn columns_3 (	// loop.scala:182:45
    .clock                (clock),
    .reset                (reset),
    .io_f2_req_idx        (s2_idx),	// predictor.scala:164:29
    .io_f3_req_fire
      (s3_valid & s3_mask[3] & io_f3_fire & columns_3_io_f3_req_fire_REG),	// loop.scala:192:{54,72}, :193:14, predictor.scala:170:25, :175:24
    .io_f3_pred_in        (io_resp_in_0_f3_3_taken),
    .io_update_mispredict
      (s1_update_valid & s1_update_bits_br_mask[3] & s1_update_bits_is_mispredict_update
       & s1_update_bits_cfi_mispredicted),	// loop.scala:199:68, :200:82, predictor.scala:184:30
    .io_update_repair
      (s1_update_valid & s1_update_bits_br_mask[3] & s1_update_bits_is_repair_update),	// loop.scala:199:68, :203:72, predictor.scala:184:30
    .io_update_idx        (s1_update_idx),	// predictor.scala:185:30
    .io_update_meta_s_cnt (s1_update_bits_meta[39:30]),	// loop.scala:187:49, predictor.scala:184:30
    .io_f3_pred           (io_resp_f3_3_taken),
    .io_f3_meta_s_cnt     (_columns_3_io_f3_meta_s_cnt)
  );
  assign io_f3_meta =
    {80'h0,
     _columns_3_io_f3_meta_s_cnt,
     _columns_2_io_f3_meta_s_cnt,
     _columns_1_io_f3_meta_s_cnt,
     _columns_0_io_f3_meta_s_cnt};	// loop.scala:182:45, :212:14
endmodule

