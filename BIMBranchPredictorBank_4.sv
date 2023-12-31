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

module BIMBranchPredictorBank_4(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input          io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_is_br,
                 io_update_bits_cfi_is_jal,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f2_0_taken,
                 io_resp_f2_1_taken,
                 io_resp_f2_2_taken,
                 io_resp_f2_3_taken,
                 io_resp_f3_0_taken,
                 io_resp_f3_1_taken,
                 io_resp_f3_2_taken,
                 io_resp_f3_3_taken,
  output [119:0] io_f3_meta
);

  wire [1:0]   data_MPORT_data_3;	// bim.scala:112:10
  wire [1:0]   data_MPORT_data_2;	// bim.scala:112:10
  wire [1:0]   data_MPORT_data_1;	// bim.scala:112:10
  wire [1:0]   data_MPORT_data_0;	// bim.scala:112:10
  wire [7:0]   _data_ext_R0_data;	// bim.scala:50:26
  reg          s1_valid;	// predictor.scala:168:25
  reg          s2_valid;	// predictor.scala:169:25
  reg          s1_update_valid;	// predictor.scala:184:30
  reg          s1_update_bits_is_mispredict_update;	// predictor.scala:184:30
  reg          s1_update_bits_is_repair_update;	// predictor.scala:184:30
  reg  [3:0]   s1_update_bits_btb_mispredicts;	// predictor.scala:184:30
  reg  [3:0]   s1_update_bits_br_mask;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_idx_valid;	// predictor.scala:184:30
  reg  [1:0]   s1_update_bits_cfi_idx_bits;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_taken;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_is_br;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_is_jal;	// predictor.scala:184:30
  reg  [119:0] s1_update_bits_meta;	// predictor.scala:184:30
  reg  [36:0]  s1_update_idx;	// predictor.scala:185:30
  reg          doing_reset;	// bim.scala:44:28
  reg  [10:0]  reset_idx;	// bim.scala:45:26
  reg  [1:0]   s2_req_rdata_0;	// bim.scala:54:32
  reg  [1:0]   s2_req_rdata_1;	// bim.scala:54:32
  reg  [1:0]   s2_req_rdata_2;	// bim.scala:54:32
  reg  [1:0]   s2_req_rdata_3;	// bim.scala:54:32
  wire         s2_resp_0 = s2_valid & s2_req_rdata_0[1] & ~doing_reset;	// bim.scala:44:28, :54:32, :60:{53,57,60}, predictor.scala:169:25
  wire         s2_resp_1 = s2_valid & s2_req_rdata_1[1] & ~doing_reset;	// bim.scala:44:28, :54:32, :60:{53,57,60}, predictor.scala:169:25
  wire         s2_resp_2 = s2_valid & s2_req_rdata_2[1] & ~doing_reset;	// bim.scala:44:28, :54:32, :60:{53,57,60}, predictor.scala:169:25
  wire         s2_resp_3 = s2_valid & s2_req_rdata_3[1] & ~doing_reset;	// bim.scala:44:28, :54:32, :60:{53,57,60}, predictor.scala:169:25
  reg  [10:0]  wrbypass_idxs_0;	// bim.scala:70:26
  reg  [10:0]  wrbypass_idxs_1;	// bim.scala:70:26
  reg  [1:0]   wrbypass_0_0;	// bim.scala:71:26
  reg  [1:0]   wrbypass_0_1;	// bim.scala:71:26
  reg  [1:0]   wrbypass_0_2;	// bim.scala:71:26
  reg  [1:0]   wrbypass_0_3;	// bim.scala:71:26
  reg  [1:0]   wrbypass_1_0;	// bim.scala:71:26
  reg  [1:0]   wrbypass_1_1;	// bim.scala:71:26
  reg  [1:0]   wrbypass_1_2;	// bim.scala:71:26
  reg  [1:0]   wrbypass_1_3;	// bim.scala:71:26
  reg          wrbypass_enq_idx;	// bim.scala:72:33
  wire         wrbypass_hits_0 = ~doing_reset & wrbypass_idxs_0 == s1_update_idx[10:0];	// bim.scala:44:28, :60:60, :70:26, :75:18, :76:{22,41}, predictor.scala:185:30
  wire         wrbypass_hit =
    wrbypass_hits_0 | ~doing_reset & wrbypass_idxs_1 == s1_update_idx[10:0];	// bim.scala:44:28, :60:60, :70:26, :75:18, :76:{22,41}, :78:44, predictor.scala:185:30
  wire         _was_taken_T = s1_update_bits_cfi_idx_bits == 2'h0;	// bim.scala:38:10, :90:68, predictor.scala:184:30
  wire         s1_update_wmask_0 =
    s1_update_bits_br_mask[0] | s1_update_bits_cfi_idx_valid & _was_taken_T;	// bim.scala:89:{33,37}, :90:{37,68}, predictor.scala:184:30
  wire         was_taken =
    s1_update_bits_cfi_idx_valid & _was_taken_T
    & (s1_update_bits_cfi_is_br & s1_update_bits_br_mask[0] & s1_update_bits_cfi_taken
       | s1_update_bits_cfi_is_jal);	// bim.scala:89:33, :90:68, :93:47, :95:{66,95}, predictor.scala:184:30
  wire [1:0]   old_bim_value =
    wrbypass_hit
      ? (wrbypass_hits_0 ? wrbypass_0_0 : wrbypass_1_0)
      : s1_update_bits_meta[1:0];	// bim.scala:67:55, :71:26, :75:18, :78:44, :99:30, predictor.scala:184:30
  wire         _s1_update_wdata_0_T = (&old_bim_value) & was_taken;	// bim.scala:35:32, :37:28, :93:47, :99:30
  wire         _s1_update_wdata_0_T_2 = old_bim_value == 2'h0 & ~was_taken;	// bim.scala:36:32, :38:{10,30,33}, :93:47, :99:30
  wire [1:0]   _s1_update_wdata_0_T_3 = old_bim_value + 2'h1;	// bim.scala:39:20, :90:68, :99:30
  wire [1:0]   _s1_update_wdata_0_T_5 = old_bim_value - 2'h1;	// bim.scala:39:29, :99:30
  wire         _was_taken_T_6 = s1_update_bits_cfi_idx_bits == 2'h1;	// bim.scala:90:68, predictor.scala:184:30
  wire         s1_update_wmask_1 =
    s1_update_bits_br_mask[1] | s1_update_bits_cfi_idx_valid & _was_taken_T_6;	// bim.scala:89:{33,37}, :90:{37,68}, predictor.scala:184:30
  wire         was_taken_1 =
    s1_update_bits_cfi_idx_valid & _was_taken_T_6
    & (s1_update_bits_cfi_is_br & s1_update_bits_br_mask[1] & s1_update_bits_cfi_taken
       | s1_update_bits_cfi_is_jal);	// bim.scala:89:33, :90:68, :93:47, :95:{66,95}, predictor.scala:184:30
  wire [1:0]   old_bim_value_1 =
    wrbypass_hit
      ? (wrbypass_hits_0 ? wrbypass_0_1 : wrbypass_1_1)
      : s1_update_bits_meta[3:2];	// bim.scala:67:55, :71:26, :75:18, :78:44, :99:30, predictor.scala:184:30
  wire         _s1_update_wdata_1_T = (&old_bim_value_1) & was_taken_1;	// bim.scala:35:32, :37:28, :93:47, :99:30
  wire         _s1_update_wdata_1_T_2 = old_bim_value_1 == 2'h0 & ~was_taken_1;	// bim.scala:36:32, :38:{10,30,33}, :93:47, :99:30
  wire [1:0]   _s1_update_wdata_1_T_3 = old_bim_value_1 + 2'h1;	// bim.scala:39:20, :90:68, :99:30
  wire [1:0]   _s1_update_wdata_1_T_5 = old_bim_value_1 - 2'h1;	// bim.scala:39:29, :99:30
  wire         _was_taken_T_12 = s1_update_bits_cfi_idx_bits == 2'h2;	// bim.scala:87:39, :90:68, predictor.scala:184:30
  wire         s1_update_wmask_2 =
    s1_update_bits_br_mask[2] | s1_update_bits_cfi_idx_valid & _was_taken_T_12;	// bim.scala:89:{33,37}, :90:{37,68}, predictor.scala:184:30
  wire         was_taken_2 =
    s1_update_bits_cfi_idx_valid & _was_taken_T_12
    & (s1_update_bits_cfi_is_br & s1_update_bits_br_mask[2] & s1_update_bits_cfi_taken
       | s1_update_bits_cfi_is_jal);	// bim.scala:89:33, :90:68, :93:47, :95:{66,95}, predictor.scala:184:30
  wire [1:0]   old_bim_value_2 =
    wrbypass_hit
      ? (wrbypass_hits_0 ? wrbypass_0_2 : wrbypass_1_2)
      : s1_update_bits_meta[5:4];	// bim.scala:67:55, :71:26, :75:18, :78:44, :99:30, predictor.scala:184:30
  wire         _s1_update_wdata_2_T = (&old_bim_value_2) & was_taken_2;	// bim.scala:35:32, :37:28, :93:47, :99:30
  wire         _s1_update_wdata_2_T_2 = old_bim_value_2 == 2'h0 & ~was_taken_2;	// bim.scala:36:32, :38:{10,30,33}, :93:47, :99:30
  wire [1:0]   _s1_update_wdata_2_T_3 = old_bim_value_2 + 2'h1;	// bim.scala:39:20, :90:68, :99:30
  wire [1:0]   _s1_update_wdata_2_T_5 = old_bim_value_2 - 2'h1;	// bim.scala:39:29, :99:30
  wire         s1_update_wmask_3 =
    s1_update_bits_br_mask[3] | s1_update_bits_cfi_idx_valid
    & (&s1_update_bits_cfi_idx_bits);	// bim.scala:89:{33,37}, :90:{37,68}, predictor.scala:184:30
  wire         was_taken_3 =
    s1_update_bits_cfi_idx_valid & (&s1_update_bits_cfi_idx_bits)
    & (s1_update_bits_cfi_is_br & s1_update_bits_br_mask[3] & s1_update_bits_cfi_taken
       | s1_update_bits_cfi_is_jal);	// bim.scala:89:33, :90:68, :93:47, :95:{66,95}, predictor.scala:184:30
  wire [1:0]   old_bim_value_3 =
    wrbypass_hit
      ? (wrbypass_hits_0 ? wrbypass_0_3 : wrbypass_1_3)
      : s1_update_bits_meta[7:6];	// bim.scala:67:55, :71:26, :75:18, :78:44, :99:30, predictor.scala:184:30
  wire         _s1_update_wdata_3_T = (&old_bim_value_3) & was_taken_3;	// bim.scala:35:32, :37:28, :93:47, :99:30
  wire         _s1_update_wdata_3_T_2 = old_bim_value_3 == 2'h0 & ~was_taken_3;	// bim.scala:36:32, :38:{10,30,33}, :93:47, :99:30
  wire [1:0]   _s1_update_wdata_3_T_3 = old_bim_value_3 + 2'h1;	// bim.scala:39:20, :90:68, :99:30
  wire [1:0]   _s1_update_wdata_3_T_5 = old_bim_value_3 - 2'h1;	// bim.scala:39:29, :99:30
  wire         _GEN =
    s1_update_bits_is_mispredict_update | s1_update_bits_is_repair_update
    | (|s1_update_bits_btb_mispredicts);	// predictor.scala:94:50, :96:69, :184:30
  assign data_MPORT_data_0 =
    doing_reset
      ? 2'h2
      : _s1_update_wdata_0_T
          ? 2'h3
          : _s1_update_wdata_0_T_2
              ? 2'h0
              : was_taken ? _s1_update_wdata_0_T_3 : _s1_update_wdata_0_T_5;	// bim.scala:35:32, :37:{8,28}, :38:{10,30}, :39:{10,20,29}, :44:28, :87:39, :93:47, :112:10
  assign data_MPORT_data_1 =
    doing_reset
      ? 2'h2
      : _s1_update_wdata_1_T
          ? 2'h3
          : _s1_update_wdata_1_T_2
              ? 2'h0
              : was_taken_1 ? _s1_update_wdata_1_T_3 : _s1_update_wdata_1_T_5;	// bim.scala:35:32, :37:{8,28}, :38:{10,30}, :39:{10,20,29}, :44:28, :87:39, :93:47, :112:10
  assign data_MPORT_data_2 =
    doing_reset
      ? 2'h2
      : _s1_update_wdata_2_T
          ? 2'h3
          : _s1_update_wdata_2_T_2
              ? 2'h0
              : was_taken_2 ? _s1_update_wdata_2_T_3 : _s1_update_wdata_2_T_5;	// bim.scala:35:32, :37:{8,28}, :38:{10,30}, :39:{10,20,29}, :44:28, :87:39, :93:47, :112:10
  assign data_MPORT_data_3 =
    doing_reset
      ? 2'h2
      : _s1_update_wdata_3_T
          ? 2'h3
          : _s1_update_wdata_3_T_2
              ? 2'h0
              : was_taken_3 ? _s1_update_wdata_3_T_3 : _s1_update_wdata_3_T_5;	// bim.scala:35:32, :37:{8,28}, :38:{10,30}, :39:{10,20,29}, :44:28, :87:39, :93:47, :112:10
  reg          io_resp_f3_0_taken_REG;	// bim.scala:128:35
  reg          io_resp_f3_1_taken_REG;	// bim.scala:128:35
  reg          io_resp_f3_2_taken_REG;	// bim.scala:128:35
  reg          io_resp_f3_3_taken_REG;	// bim.scala:128:35
  reg  [7:0]   io_f3_meta_REG;	// bim.scala:130:24
  always @(posedge clock) begin
    automatic logic _GEN_0;	// bim.scala:116:57
    _GEN_0 =
      (s1_update_wmask_0 | s1_update_wmask_1 | s1_update_wmask_2 | s1_update_wmask_3)
      & s1_update_valid & ~_GEN;	// bim.scala:89:37, :116:{33,57}, predictor.scala:96:{26,69}, :184:30
    s1_valid <= io_f0_valid;	// predictor.scala:168:25
    s2_valid <= s1_valid;	// predictor.scala:168:25, :169:25
    s1_update_valid <= io_update_valid;	// predictor.scala:184:30
    s1_update_bits_is_mispredict_update <= io_update_bits_is_mispredict_update;	// predictor.scala:184:30
    s1_update_bits_is_repair_update <= io_update_bits_is_repair_update;	// predictor.scala:184:30
    s1_update_bits_btb_mispredicts <= io_update_bits_btb_mispredicts;	// predictor.scala:184:30
    s1_update_bits_br_mask <= io_update_bits_br_mask;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;	// predictor.scala:184:30
    s1_update_bits_cfi_taken <= io_update_bits_cfi_taken;	// predictor.scala:184:30
    s1_update_bits_cfi_is_br <= io_update_bits_cfi_is_br;	// predictor.scala:184:30
    s1_update_bits_cfi_is_jal <= io_update_bits_cfi_is_jal;	// predictor.scala:184:30
    s1_update_bits_meta <= io_update_bits_meta;	// predictor.scala:184:30
    s1_update_idx <= io_update_bits_pc[39:3];	// frontend.scala:163:35, predictor.scala:185:30
    s2_req_rdata_0 <= _data_ext_R0_data[1:0];	// bim.scala:50:26, :54:32
    s2_req_rdata_1 <= _data_ext_R0_data[3:2];	// bim.scala:50:26, :54:32
    s2_req_rdata_2 <= _data_ext_R0_data[5:4];	// bim.scala:50:26, :54:32
    s2_req_rdata_3 <= _data_ext_R0_data[7:6];	// bim.scala:50:26, :54:32
    if (~_GEN_0 | wrbypass_hit | wrbypass_enq_idx) begin	// bim.scala:70:26, :72:33, :78:44, :116:{57,93}, :117:25
    end
    else	// bim.scala:70:26, :116:93, :117:25
      wrbypass_idxs_0 <= s1_update_idx[10:0];	// bim.scala:70:26, predictor.scala:185:30
    if (~_GEN_0 | wrbypass_hit | ~wrbypass_enq_idx) begin	// bim.scala:70:26, :72:33, :78:44, :116:{57,93}, :117:25, :121:39
    end
    else	// bim.scala:70:26, :116:93, :117:25
      wrbypass_idxs_1 <= s1_update_idx[10:0];	// bim.scala:70:26, predictor.scala:185:30
    if (_GEN_0) begin	// bim.scala:116:57
      if (wrbypass_hit) begin	// bim.scala:78:44
        if (wrbypass_hits_0) begin	// bim.scala:75:18
          if (_s1_update_wdata_0_T)	// bim.scala:37:28
            wrbypass_0_0 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_0_T_2)	// bim.scala:38:30
            wrbypass_0_0 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken)	// bim.scala:93:47
            wrbypass_0_0 <= _s1_update_wdata_0_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_0_0 <= _s1_update_wdata_0_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_1_T)	// bim.scala:37:28
            wrbypass_0_1 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_1_T_2)	// bim.scala:38:30
            wrbypass_0_1 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_1)	// bim.scala:93:47
            wrbypass_0_1 <= _s1_update_wdata_1_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_0_1 <= _s1_update_wdata_1_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_2_T)	// bim.scala:37:28
            wrbypass_0_2 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_2_T_2)	// bim.scala:38:30
            wrbypass_0_2 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_2)	// bim.scala:93:47
            wrbypass_0_2 <= _s1_update_wdata_2_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_0_2 <= _s1_update_wdata_2_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_3_T)	// bim.scala:37:28
            wrbypass_0_3 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_3_T_2)	// bim.scala:38:30
            wrbypass_0_3 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_3)	// bim.scala:93:47
            wrbypass_0_3 <= _s1_update_wdata_3_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_0_3 <= _s1_update_wdata_3_T_5;	// bim.scala:39:29, :71:26
        end
        else begin	// bim.scala:75:18
          if (_s1_update_wdata_0_T)	// bim.scala:37:28
            wrbypass_1_0 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_0_T_2)	// bim.scala:38:30
            wrbypass_1_0 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken)	// bim.scala:93:47
            wrbypass_1_0 <= _s1_update_wdata_0_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_1_0 <= _s1_update_wdata_0_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_1_T)	// bim.scala:37:28
            wrbypass_1_1 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_1_T_2)	// bim.scala:38:30
            wrbypass_1_1 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_1)	// bim.scala:93:47
            wrbypass_1_1 <= _s1_update_wdata_1_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_1_1 <= _s1_update_wdata_1_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_2_T)	// bim.scala:37:28
            wrbypass_1_2 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_2_T_2)	// bim.scala:38:30
            wrbypass_1_2 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_2)	// bim.scala:93:47
            wrbypass_1_2 <= _s1_update_wdata_2_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_1_2 <= _s1_update_wdata_2_T_5;	// bim.scala:39:29, :71:26
          if (_s1_update_wdata_3_T)	// bim.scala:37:28
            wrbypass_1_3 <= 2'h3;	// bim.scala:35:32, :71:26
          else if (_s1_update_wdata_3_T_2)	// bim.scala:38:30
            wrbypass_1_3 <= 2'h0;	// bim.scala:38:10, :71:26
          else if (was_taken_3)	// bim.scala:93:47
            wrbypass_1_3 <= _s1_update_wdata_3_T_3;	// bim.scala:39:20, :71:26
          else	// bim.scala:93:47
            wrbypass_1_3 <= _s1_update_wdata_3_T_5;	// bim.scala:39:29, :71:26
        end
      end
      else if (wrbypass_enq_idx) begin	// bim.scala:72:33
        if (_s1_update_wdata_0_T)	// bim.scala:37:28
          wrbypass_1_0 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_0_T_2)	// bim.scala:38:30
          wrbypass_1_0 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken)	// bim.scala:93:47
          wrbypass_1_0 <= _s1_update_wdata_0_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_1_0 <= _s1_update_wdata_0_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_1_T)	// bim.scala:37:28
          wrbypass_1_1 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_1_T_2)	// bim.scala:38:30
          wrbypass_1_1 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_1)	// bim.scala:93:47
          wrbypass_1_1 <= _s1_update_wdata_1_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_1_1 <= _s1_update_wdata_1_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_2_T)	// bim.scala:37:28
          wrbypass_1_2 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_2_T_2)	// bim.scala:38:30
          wrbypass_1_2 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_2)	// bim.scala:93:47
          wrbypass_1_2 <= _s1_update_wdata_2_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_1_2 <= _s1_update_wdata_2_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_3_T)	// bim.scala:37:28
          wrbypass_1_3 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_3_T_2)	// bim.scala:38:30
          wrbypass_1_3 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_3)	// bim.scala:93:47
          wrbypass_1_3 <= _s1_update_wdata_3_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_1_3 <= _s1_update_wdata_3_T_5;	// bim.scala:39:29, :71:26
      end
      else begin	// bim.scala:72:33
        if (_s1_update_wdata_0_T)	// bim.scala:37:28
          wrbypass_0_0 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_0_T_2)	// bim.scala:38:30
          wrbypass_0_0 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken)	// bim.scala:93:47
          wrbypass_0_0 <= _s1_update_wdata_0_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_0_0 <= _s1_update_wdata_0_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_1_T)	// bim.scala:37:28
          wrbypass_0_1 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_1_T_2)	// bim.scala:38:30
          wrbypass_0_1 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_1)	// bim.scala:93:47
          wrbypass_0_1 <= _s1_update_wdata_1_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_0_1 <= _s1_update_wdata_1_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_2_T)	// bim.scala:37:28
          wrbypass_0_2 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_2_T_2)	// bim.scala:38:30
          wrbypass_0_2 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_2)	// bim.scala:93:47
          wrbypass_0_2 <= _s1_update_wdata_2_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_0_2 <= _s1_update_wdata_2_T_5;	// bim.scala:39:29, :71:26
        if (_s1_update_wdata_3_T)	// bim.scala:37:28
          wrbypass_0_3 <= 2'h3;	// bim.scala:35:32, :71:26
        else if (_s1_update_wdata_3_T_2)	// bim.scala:38:30
          wrbypass_0_3 <= 2'h0;	// bim.scala:38:10, :71:26
        else if (was_taken_3)	// bim.scala:93:47
          wrbypass_0_3 <= _s1_update_wdata_3_T_3;	// bim.scala:39:20, :71:26
        else	// bim.scala:93:47
          wrbypass_0_3 <= _s1_update_wdata_3_T_5;	// bim.scala:39:29, :71:26
      end
    end
    io_resp_f3_0_taken_REG <= s2_resp_0;	// bim.scala:60:57, :128:35
    io_resp_f3_1_taken_REG <= s2_resp_1;	// bim.scala:60:57, :128:35
    io_resp_f3_2_taken_REG <= s2_resp_2;	// bim.scala:60:57, :128:35
    io_resp_f3_3_taken_REG <= s2_resp_3;	// bim.scala:60:57, :128:35
    io_f3_meta_REG <= {s2_req_rdata_3, s2_req_rdata_2, s2_req_rdata_1, s2_req_rdata_0};	// bim.scala:54:32, :130:{24,33}
    if (reset) begin
      doing_reset <= 1'h1;	// bim.scala:44:28
      reset_idx <= 11'h0;	// bim.scala:45:26
      wrbypass_enq_idx <= 1'h0;	// bim.scala:72:33, predictor.scala:160:14
    end
    else begin
      doing_reset <= reset_idx != 11'h7FF & doing_reset;	// bim.scala:44:28, :45:26, :47:{19,36,50}
      reset_idx <= reset_idx + {10'h0, doing_reset};	// bim.scala:44:28, :45:26, :46:26
      if (~_GEN_0 | wrbypass_hit) begin	// bim.scala:70:26, :72:33, :78:44, :116:{57,93}, :117:25
      end
      else	// bim.scala:72:33, :116:93, :117:25
        wrbypass_enq_idx <= wrbypass_enq_idx - 1'h1;	// bim.scala:72:33, util.scala:203:14
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:17];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h12; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_valid = _RANDOM[5'h3][15];	// predictor.scala:168:25
        s2_valid = _RANDOM[5'h3][16];	// predictor.scala:168:25, :169:25
        s1_update_valid = _RANDOM[5'h5][6];	// predictor.scala:184:30
        s1_update_bits_is_mispredict_update = _RANDOM[5'h5][7];	// predictor.scala:184:30
        s1_update_bits_is_repair_update = _RANDOM[5'h5][8];	// predictor.scala:184:30
        s1_update_bits_btb_mispredicts = _RANDOM[5'h5][12:9];	// predictor.scala:184:30
        s1_update_bits_br_mask = _RANDOM[5'h6][24:21];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_valid = _RANDOM[5'h6][25];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_bits = _RANDOM[5'h6][27:26];	// predictor.scala:184:30
        s1_update_bits_cfi_taken = _RANDOM[5'h6][28];	// predictor.scala:184:30
        s1_update_bits_cfi_is_br = _RANDOM[5'h6][30];	// predictor.scala:184:30
        s1_update_bits_cfi_is_jal = _RANDOM[5'h6][31];	// predictor.scala:184:30
        s1_update_bits_meta =
          {_RANDOM[5'hA][31:10],
           _RANDOM[5'hB],
           _RANDOM[5'hC],
           _RANDOM[5'hD],
           _RANDOM[5'hE][1:0]};	// predictor.scala:184:30
        s1_update_idx = {_RANDOM[5'hE][31:2], _RANDOM[5'hF][6:0]};	// predictor.scala:184:30, :185:30
        doing_reset = _RANDOM[5'hF][8];	// bim.scala:44:28, predictor.scala:185:30
        reset_idx = _RANDOM[5'hF][19:9];	// bim.scala:45:26, predictor.scala:185:30
        s2_req_rdata_0 = _RANDOM[5'hF][21:20];	// bim.scala:54:32, predictor.scala:185:30
        s2_req_rdata_1 = _RANDOM[5'hF][23:22];	// bim.scala:54:32, predictor.scala:185:30
        s2_req_rdata_2 = _RANDOM[5'hF][25:24];	// bim.scala:54:32, predictor.scala:185:30
        s2_req_rdata_3 = _RANDOM[5'hF][27:26];	// bim.scala:54:32, predictor.scala:185:30
        wrbypass_idxs_0 = {_RANDOM[5'hF][31:28], _RANDOM[5'h10][6:0]};	// bim.scala:70:26, predictor.scala:185:30
        wrbypass_idxs_1 = _RANDOM[5'h10][17:7];	// bim.scala:70:26
        wrbypass_0_0 = _RANDOM[5'h10][19:18];	// bim.scala:70:26, :71:26
        wrbypass_0_1 = _RANDOM[5'h10][21:20];	// bim.scala:70:26, :71:26
        wrbypass_0_2 = _RANDOM[5'h10][23:22];	// bim.scala:70:26, :71:26
        wrbypass_0_3 = _RANDOM[5'h10][25:24];	// bim.scala:70:26, :71:26
        wrbypass_1_0 = _RANDOM[5'h10][27:26];	// bim.scala:70:26, :71:26
        wrbypass_1_1 = _RANDOM[5'h10][29:28];	// bim.scala:70:26, :71:26
        wrbypass_1_2 = _RANDOM[5'h10][31:30];	// bim.scala:70:26, :71:26
        wrbypass_1_3 = _RANDOM[5'h11][1:0];	// bim.scala:71:26
        wrbypass_enq_idx = _RANDOM[5'h11][2];	// bim.scala:71:26, :72:33
        io_resp_f3_0_taken_REG = _RANDOM[5'h11][3];	// bim.scala:71:26, :128:35
        io_resp_f3_1_taken_REG = _RANDOM[5'h11][4];	// bim.scala:71:26, :128:35
        io_resp_f3_2_taken_REG = _RANDOM[5'h11][5];	// bim.scala:71:26, :128:35
        io_resp_f3_3_taken_REG = _RANDOM[5'h11][6];	// bim.scala:71:26, :128:35
        io_f3_meta_REG = _RANDOM[5'h11][14:7];	// bim.scala:71:26, :130:24
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  data_2048x8 data_ext (	// bim.scala:50:26
    .R0_addr (io_f0_pc[13:3]),	// bim.scala:54:42
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (doing_reset ? reset_idx : s1_update_idx[10:0]),	// bim.scala:44:28, :45:26, :111:10, predictor.scala:185:30
    .W0_en   (doing_reset | s1_update_valid & ~_GEN),	// bim.scala:44:28, :109:{21,41}, predictor.scala:96:{26,69}, :184:30
    .W0_clk  (clock),
    .W0_data
      ({data_MPORT_data_3, data_MPORT_data_2, data_MPORT_data_1, data_MPORT_data_0}),	// bim.scala:50:26, :112:10
    .W0_mask
      (doing_reset
         ? 4'hF
         : {s1_update_wmask_3, s1_update_wmask_2, s1_update_wmask_1, s1_update_wmask_0}),	// bim.scala:44:28, :89:37, :113:{10,25,63}
    .R0_data (_data_ext_R0_data)
  );
  assign io_resp_f2_0_taken = s2_resp_0;	// bim.scala:60:57
  assign io_resp_f2_1_taken = s2_resp_1;	// bim.scala:60:57
  assign io_resp_f2_2_taken = s2_resp_2;	// bim.scala:60:57
  assign io_resp_f2_3_taken = s2_resp_3;	// bim.scala:60:57
  assign io_resp_f3_0_taken = io_resp_f3_0_taken_REG;	// bim.scala:128:35
  assign io_resp_f3_1_taken = io_resp_f3_1_taken_REG;	// bim.scala:128:35
  assign io_resp_f3_2_taken = io_resp_f3_2_taken_REG;	// bim.scala:128:35
  assign io_resp_f3_3_taken = io_resp_f3_3_taken_REG;	// bim.scala:128:35
  assign io_f3_meta = {112'h0, io_f3_meta_REG};	// bim.scala:130:{14,24}
endmodule

