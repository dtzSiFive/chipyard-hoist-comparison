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

module BTBBranchPredictorBank_4(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input          io_resp_in_0_f2_0_taken,
                 io_resp_in_0_f2_0_is_br,
                 io_resp_in_0_f2_0_is_jal,
                 io_resp_in_0_f2_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_0_predicted_pc_bits,
  input          io_resp_in_0_f2_1_taken,
                 io_resp_in_0_f2_1_is_br,
                 io_resp_in_0_f2_1_is_jal,
                 io_resp_in_0_f2_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_1_predicted_pc_bits,
  input          io_resp_in_0_f2_2_taken,
                 io_resp_in_0_f2_2_is_br,
                 io_resp_in_0_f2_2_is_jal,
                 io_resp_in_0_f2_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_2_predicted_pc_bits,
  input          io_resp_in_0_f2_3_taken,
                 io_resp_in_0_f2_3_is_br,
                 io_resp_in_0_f2_3_is_jal,
                 io_resp_in_0_f2_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f2_3_predicted_pc_bits,
  input          io_resp_in_0_f3_0_taken,
                 io_resp_in_0_f3_0_is_br,
                 io_resp_in_0_f3_0_is_jal,
                 io_resp_in_0_f3_0_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_0_predicted_pc_bits,
  input          io_resp_in_0_f3_1_taken,
                 io_resp_in_0_f3_1_is_br,
                 io_resp_in_0_f3_1_is_jal,
                 io_resp_in_0_f3_1_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_1_predicted_pc_bits,
  input          io_resp_in_0_f3_2_taken,
                 io_resp_in_0_f3_2_is_br,
                 io_resp_in_0_f3_2_is_jal,
                 io_resp_in_0_f3_2_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_2_predicted_pc_bits,
  input          io_resp_in_0_f3_3_taken,
                 io_resp_in_0_f3_3_is_br,
                 io_resp_in_0_f3_3_is_jal,
                 io_resp_in_0_f3_3_predicted_pc_valid,
  input  [39:0]  io_resp_in_0_f3_3_predicted_pc_bits,
  input          io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f2_0_taken,
                 io_resp_f2_0_is_br,
                 io_resp_f2_0_is_jal,
                 io_resp_f2_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_0_predicted_pc_bits,
  output         io_resp_f2_1_taken,
                 io_resp_f2_1_is_br,
                 io_resp_f2_1_is_jal,
                 io_resp_f2_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_1_predicted_pc_bits,
  output         io_resp_f2_2_taken,
                 io_resp_f2_2_is_br,
                 io_resp_f2_2_is_jal,
                 io_resp_f2_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_2_predicted_pc_bits,
  output         io_resp_f2_3_taken,
                 io_resp_f2_3_is_br,
                 io_resp_f2_3_is_jal,
                 io_resp_f2_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_3_predicted_pc_bits,
  output         io_resp_f3_0_taken,
                 io_resp_f3_0_is_br,
                 io_resp_f3_0_is_jal,
                 io_resp_f3_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_0_predicted_pc_bits,
  output         io_resp_f3_1_taken,
                 io_resp_f3_1_is_br,
                 io_resp_f3_1_is_jal,
                 io_resp_f3_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_1_predicted_pc_bits,
  output         io_resp_f3_2_taken,
                 io_resp_f3_2_is_br,
                 io_resp_f3_2_is_jal,
                 io_resp_f3_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_2_predicted_pc_bits,
  output         io_resp_f3_3_taken,
                 io_resp_f3_3_is_br,
                 io_resp_f3_3_is_jal,
                 io_resp_f3_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_3_predicted_pc_bits,
  output [119:0] io_f3_meta
);

  wire [30:0]  meta_1_MPORT_3_data_3;	// btb.scala:183:12
  wire [30:0]  meta_1_MPORT_3_data_2;	// btb.scala:183:12
  wire [30:0]  meta_1_MPORT_3_data_1;	// btb.scala:183:12
  wire [30:0]  meta_1_MPORT_3_data_0;	// btb.scala:183:12
  wire [13:0]  btb_1_MPORT_2_data_3;	// btb.scala:172:12
  wire [13:0]  btb_1_MPORT_2_data_2;	// btb.scala:172:12
  wire [13:0]  btb_1_MPORT_2_data_1;	// btb.scala:172:12
  wire [13:0]  btb_1_MPORT_2_data_0;	// btb.scala:172:12
  wire [30:0]  meta_0_MPORT_1_data_3;	// btb.scala:183:12
  wire [30:0]  meta_0_MPORT_1_data_2;	// btb.scala:183:12
  wire [30:0]  meta_0_MPORT_1_data_1;	// btb.scala:183:12
  wire [30:0]  meta_0_MPORT_1_data_0;	// btb.scala:183:12
  wire [13:0]  btb_0_MPORT_data_3;	// btb.scala:172:12
  wire [13:0]  btb_0_MPORT_data_2;	// btb.scala:172:12
  wire [13:0]  btb_0_MPORT_data_1;	// btb.scala:172:12
  wire [13:0]  btb_0_MPORT_data_0;	// btb.scala:172:12
  wire [39:0]  _ebtb_ext_R0_data;	// btb.scala:67:29
  wire [55:0]  _btb_1_ext_R0_data;	// btb.scala:66:47
  wire [55:0]  _btb_0_ext_R0_data;	// btb.scala:66:47
  wire [123:0] _meta_1_ext_R0_data;	// btb.scala:65:47
  wire [123:0] _meta_0_ext_R0_data;	// btb.scala:65:47
  reg  [36:0]  s1_idx;	// predictor.scala:163:29
  reg          s1_valid;	// predictor.scala:168:25
  reg  [39:0]  s1_pc;	// predictor.scala:178:22
  reg          s1_update_valid;	// predictor.scala:184:30
  reg          s1_update_bits_is_mispredict_update;	// predictor.scala:184:30
  reg          s1_update_bits_is_repair_update;	// predictor.scala:184:30
  reg  [3:0]   s1_update_bits_btb_mispredicts;	// predictor.scala:184:30
  reg  [39:0]  s1_update_bits_pc;	// predictor.scala:184:30
  reg  [3:0]   s1_update_bits_br_mask;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_idx_valid;	// predictor.scala:184:30
  reg  [1:0]   s1_update_bits_cfi_idx_bits;	// predictor.scala:184:30
  reg          s1_update_bits_cfi_taken;	// predictor.scala:184:30
  reg  [39:0]  s1_update_bits_target;	// predictor.scala:184:30
  reg  [119:0] s1_update_bits_meta;	// predictor.scala:184:30
  reg  [36:0]  s1_update_idx;	// predictor.scala:185:30
  reg          f3_meta_REG_write_way;	// btb.scala:53:32
  reg          f3_meta_write_way;	// btb.scala:53:24
  reg          doing_reset;	// btb.scala:60:28
  reg  [6:0]   reset_idx;	// btb.scala:61:28
  reg          REG;	// btb.scala:104:18
  reg          io_resp_f2_0_predicted_pc_REG_valid;	// btb.scala:105:44
  reg  [39:0]  io_resp_f2_0_predicted_pc_REG_bits;	// btb.scala:105:44
  reg          io_resp_f2_0_is_br_REG;	// btb.scala:106:44
  reg          io_resp_f2_0_is_jal_REG;	// btb.scala:107:44
  reg          REG_1;	// btb.scala:108:20
  reg          REG_2;	// btb.scala:112:26
  reg          REG_3;	// btb.scala:112:18
  reg          io_resp_f3_0_predicted_pc_REG_valid;	// btb.scala:113:44
  reg  [39:0]  io_resp_f3_0_predicted_pc_REG_bits;	// btb.scala:113:44
  reg          io_resp_f3_0_is_br_REG;	// btb.scala:114:44
  reg          io_resp_f3_0_is_jal_REG;	// btb.scala:115:44
  reg          REG_4;	// btb.scala:116:28
  reg          REG_5;	// btb.scala:116:20
  reg          REG_6;	// btb.scala:104:18
  reg          io_resp_f2_1_predicted_pc_REG_valid;	// btb.scala:105:44
  reg  [39:0]  io_resp_f2_1_predicted_pc_REG_bits;	// btb.scala:105:44
  reg          io_resp_f2_1_is_br_REG;	// btb.scala:106:44
  reg          io_resp_f2_1_is_jal_REG;	// btb.scala:107:44
  reg          REG_7;	// btb.scala:108:20
  reg          REG_8;	// btb.scala:112:26
  reg          REG_9;	// btb.scala:112:18
  reg          io_resp_f3_1_predicted_pc_REG_valid;	// btb.scala:113:44
  reg  [39:0]  io_resp_f3_1_predicted_pc_REG_bits;	// btb.scala:113:44
  reg          io_resp_f3_1_is_br_REG;	// btb.scala:114:44
  reg          io_resp_f3_1_is_jal_REG;	// btb.scala:115:44
  reg          REG_10;	// btb.scala:116:28
  reg          REG_11;	// btb.scala:116:20
  reg          REG_12;	// btb.scala:104:18
  reg          io_resp_f2_2_predicted_pc_REG_valid;	// btb.scala:105:44
  reg  [39:0]  io_resp_f2_2_predicted_pc_REG_bits;	// btb.scala:105:44
  reg          io_resp_f2_2_is_br_REG;	// btb.scala:106:44
  reg          io_resp_f2_2_is_jal_REG;	// btb.scala:107:44
  reg          REG_13;	// btb.scala:108:20
  reg          REG_14;	// btb.scala:112:26
  reg          REG_15;	// btb.scala:112:18
  reg          io_resp_f3_2_predicted_pc_REG_valid;	// btb.scala:113:44
  reg  [39:0]  io_resp_f3_2_predicted_pc_REG_bits;	// btb.scala:113:44
  reg          io_resp_f3_2_is_br_REG;	// btb.scala:114:44
  reg          io_resp_f3_2_is_jal_REG;	// btb.scala:115:44
  reg          REG_16;	// btb.scala:116:28
  reg          REG_17;	// btb.scala:116:20
  reg          REG_18;	// btb.scala:104:18
  reg          io_resp_f2_3_predicted_pc_REG_valid;	// btb.scala:105:44
  reg  [39:0]  io_resp_f2_3_predicted_pc_REG_bits;	// btb.scala:105:44
  reg          io_resp_f2_3_is_br_REG;	// btb.scala:106:44
  reg          io_resp_f2_3_is_jal_REG;	// btb.scala:107:44
  reg          REG_19;	// btb.scala:108:20
  reg          REG_20;	// btb.scala:112:26
  reg          REG_21;	// btb.scala:112:18
  reg          io_resp_f3_3_predicted_pc_REG_valid;	// btb.scala:113:44
  reg  [39:0]  io_resp_f3_3_predicted_pc_REG_bits;	// btb.scala:113:44
  reg          io_resp_f3_3_is_br_REG;	// btb.scala:114:44
  reg          io_resp_f3_3_is_jal_REG;	// btb.scala:115:44
  reg          REG_22;	// btb.scala:116:28
  reg          REG_23;	// btb.scala:116:20
  wire [39:0]  _new_offset_value_T_5 =
    s1_update_bits_target
    - (s1_update_bits_pc + {37'h0, s1_update_bits_cfi_idx_bits, 1'h0});	// btb.scala:142:56, :143:24, predictor.scala:160:14, :184:30
  wire         s1_update_wbtb_data_extended =
    $signed(_new_offset_value_T_5) > 40'shFFF
    | $signed(_new_offset_value_T_5) < -40'sh1000;	// btb.scala:142:56, :144:{46,65}, :145:46
  wire         _s1_update_wmeta_mask_T_1 =
    s1_update_bits_is_mispredict_update | s1_update_bits_is_repair_update;	// predictor.scala:96:49, :184:30
  wire [3:0]   s1_update_wbtb_mask =
    4'h1 << s1_update_bits_cfi_idx_bits
    & {4{s1_update_bits_cfi_idx_valid & s1_update_valid & s1_update_bits_cfi_taken
           & ~(_s1_update_wmeta_mask_T_1 | (|s1_update_bits_btb_mispredicts))}};	// Bitwise.scala:72:12, OneHot.scala:58:35, btb.scala:151:58, :152:97, predictor.scala:94:50, :96:{26,49,69}, :184:30
  wire         btb_0_MPORT_en = doing_reset | ~(s1_update_bits_meta[0]);	// btb.scala:60:28, :167:{23,51}, predictor.scala:184:30
  wire [6:0]   btb_1_MPORT_2_addr = doing_reset ? reset_idx : s1_update_idx[6:0];	// btb.scala:60:28, :61:28, :169:12, predictor.scala:185:30
  wire [13:0]  _GEN = {_new_offset_value_T_5[12:0], s1_update_wbtb_data_extended};	// btb.scala:142:56, :144:65, :150:32, :174:61
  assign btb_0_MPORT_data_0 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_0_MPORT_data_1 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_0_MPORT_data_2 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_0_MPORT_data_3 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  wire [3:0]   _GEN_0 = doing_reset ? 4'hF : s1_update_wbtb_mask;	// Bitwise.scala:72:12, btb.scala:60:28, :151:58, :175:12
  wire [30:0]  _GEN_1 =
    {s1_update_bits_br_mask[0],
     s1_update_bits_btb_mispredicts[0] ? 30'h0 : s1_update_idx[36:7]};	// btb.scala:162:{43,74,98}, :163:62, :185:46, predictor.scala:184:30, :185:30
  wire [30:0]  _GEN_2 =
    {s1_update_bits_br_mask[1],
     s1_update_bits_btb_mispredicts[1] ? 30'h0 : s1_update_idx[36:7]};	// btb.scala:162:{43,74,98}, :163:62, :185:46, predictor.scala:184:30, :185:30
  wire [30:0]  _GEN_3 =
    {s1_update_bits_br_mask[2],
     s1_update_bits_btb_mispredicts[2] ? 30'h0 : s1_update_idx[36:7]};	// btb.scala:162:{43,74,98}, :163:62, :185:46, predictor.scala:184:30, :185:30
  wire [30:0]  _GEN_4 =
    {s1_update_bits_br_mask[3],
     s1_update_bits_btb_mispredicts[3] ? 30'h0 : s1_update_idx[36:7]};	// btb.scala:162:{43,74,98}, :163:62, :185:46, predictor.scala:184:30, :185:30
  assign meta_0_MPORT_1_data_0 = doing_reset ? 31'h0 : _GEN_1;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_0_MPORT_1_data_1 = doing_reset ? 31'h0 : _GEN_2;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_0_MPORT_1_data_2 = doing_reset ? 31'h0 : _GEN_3;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_0_MPORT_1_data_3 = doing_reset ? 31'h0 : _GEN_4;	// btb.scala:60:28, :183:12, :184:18, :185:46
  wire [3:0]   _GEN_5 =
    doing_reset
      ? 4'hF
      : (s1_update_wbtb_mask | s1_update_bits_br_mask)
        & ({4{s1_update_valid
                & ~(_s1_update_wmeta_mask_T_1 | (|s1_update_bits_btb_mispredicts))}}
           | {4{s1_update_valid}} & s1_update_bits_btb_mispredicts);	// Bitwise.scala:72:12, btb.scala:60:28, :151:58, :154:{52,78}, :155:{38,74}, :156:40, :186:12, predictor.scala:94:50, :96:{26,49,69}, :184:30
  wire         btb_1_MPORT_2_en = doing_reset | s1_update_bits_meta[0];	// btb.scala:60:28, :167:23, predictor.scala:184:30
  assign btb_1_MPORT_2_data_0 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_1_MPORT_2_data_1 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_1_MPORT_2_data_2 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign btb_1_MPORT_2_data_3 = doing_reset ? 14'h0 : _GEN;	// btb.scala:60:28, :172:12, :173:18, :174:61
  assign meta_1_MPORT_3_data_0 = doing_reset ? 31'h0 : _GEN_1;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_1_MPORT_3_data_1 = doing_reset ? 31'h0 : _GEN_2;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_1_MPORT_3_data_2 = doing_reset ? 31'h0 : _GEN_3;	// btb.scala:60:28, :183:12, :184:18, :185:46
  assign meta_1_MPORT_3_data_3 = doing_reset ? 31'h0 : _GEN_4;	// btb.scala:60:28, :183:12, :184:18, :185:46
  always @(posedge clock) begin
    automatic logic s1_hit_ohs_0_0;	// btb.scala:84:30
    automatic logic s1_hit_ohs_1_0;	// btb.scala:84:30
    automatic logic s1_hit_ohs_2_0;	// btb.scala:84:30
    automatic logic s1_hit_ohs_3_0;	// btb.scala:84:30
    automatic logic s1_hits_0;	// btb.scala:87:55
    automatic logic s1_hits_1;	// btb.scala:87:55
    automatic logic s1_hits_2;	// btb.scala:87:55
    automatic logic s1_hits_3;	// btb.scala:87:55
    automatic logic s1_resp_0_valid;	// btb.scala:93:50
    automatic logic _GEN_6;	// btb.scala:98:54
    automatic logic s1_is_jal_0;	// btb.scala:99:54
    automatic logic s1_resp_1_valid;	// btb.scala:93:50
    automatic logic _GEN_7;	// btb.scala:98:54
    automatic logic s1_is_jal_1;	// btb.scala:99:54
    automatic logic s1_resp_2_valid;	// btb.scala:93:50
    automatic logic _GEN_8;	// btb.scala:98:54
    automatic logic s1_is_jal_2;	// btb.scala:99:54
    automatic logic s1_resp_3_valid;	// btb.scala:93:50
    automatic logic _GEN_9;	// btb.scala:98:54
    automatic logic s1_is_jal_3;	// btb.scala:99:54
    s1_hit_ohs_0_0 = _meta_0_ext_R0_data[29:0] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, predictor.scala:163:29
    s1_hit_ohs_1_0 = _meta_0_ext_R0_data[60:31] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, predictor.scala:163:29
    s1_hit_ohs_2_0 = _meta_0_ext_R0_data[91:62] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, predictor.scala:163:29
    s1_hit_ohs_3_0 = _meta_0_ext_R0_data[122:93] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, predictor.scala:163:29
    s1_hits_0 = s1_hit_ohs_0_0 | _meta_1_ext_R0_data[29:0] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, :87:55, predictor.scala:163:29
    s1_hits_1 = s1_hit_ohs_1_0 | _meta_1_ext_R0_data[60:31] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, :87:55, predictor.scala:163:29
    s1_hits_2 = s1_hit_ohs_2_0 | _meta_1_ext_R0_data[91:62] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, :87:55, predictor.scala:163:29
    s1_hits_3 = s1_hit_ohs_3_0 | _meta_1_ext_R0_data[122:93] == s1_idx[36:7];	// btb.scala:65:47, :74:93, :76:29, :84:30, :87:55, predictor.scala:163:29
    s1_resp_0_valid = ~doing_reset & s1_valid & s1_hits_0;	// btb.scala:60:28, :87:55, :93:{25,50}, predictor.scala:168:25
    _GEN_6 = s1_hit_ohs_0_0 ? _meta_0_ext_R0_data[30] : _meta_1_ext_R0_data[30];	// btb.scala:65:47, :74:93, :84:30, :98:54
    s1_is_jal_0 = ~doing_reset & s1_resp_0_valid & ~_GEN_6;	// btb.scala:60:28, :93:{25,50}, :98:54, :99:{54,57}
    s1_resp_1_valid = ~doing_reset & s1_valid & s1_hits_1;	// btb.scala:60:28, :87:55, :93:{25,50}, predictor.scala:168:25
    _GEN_7 = s1_hit_ohs_1_0 ? _meta_0_ext_R0_data[61] : _meta_1_ext_R0_data[61];	// btb.scala:65:47, :74:93, :84:30, :98:54
    s1_is_jal_1 = ~doing_reset & s1_resp_1_valid & ~_GEN_7;	// btb.scala:60:28, :93:{25,50}, :98:54, :99:{54,57}
    s1_resp_2_valid = ~doing_reset & s1_valid & s1_hits_2;	// btb.scala:60:28, :87:55, :93:{25,50}, predictor.scala:168:25
    _GEN_8 = s1_hit_ohs_2_0 ? _meta_0_ext_R0_data[92] : _meta_1_ext_R0_data[92];	// btb.scala:65:47, :74:93, :84:30, :98:54
    s1_is_jal_2 = ~doing_reset & s1_resp_2_valid & ~_GEN_8;	// btb.scala:60:28, :93:{25,50}, :98:54, :99:{54,57}
    s1_resp_3_valid = ~doing_reset & s1_valid & s1_hits_3;	// btb.scala:60:28, :87:55, :93:{25,50}, predictor.scala:168:25
    _GEN_9 = s1_hit_ohs_3_0 ? _meta_0_ext_R0_data[123] : _meta_1_ext_R0_data[123];	// btb.scala:65:47, :74:93, :84:30, :98:54
    s1_is_jal_3 = ~doing_reset & s1_resp_3_valid & ~_GEN_9;	// btb.scala:60:28, :93:{25,50}, :98:54, :99:{54,57}
    s1_idx <= io_f0_pc[39:3];	// frontend.scala:163:35, predictor.scala:163:29
    s1_valid <= io_f0_valid;	// predictor.scala:168:25
    s1_pc <= io_f0_pc;	// predictor.scala:178:22
    s1_update_valid <= io_update_valid;	// predictor.scala:184:30
    s1_update_bits_is_mispredict_update <= io_update_bits_is_mispredict_update;	// predictor.scala:184:30
    s1_update_bits_is_repair_update <= io_update_bits_is_repair_update;	// predictor.scala:184:30
    s1_update_bits_btb_mispredicts <= io_update_bits_btb_mispredicts;	// predictor.scala:184:30
    s1_update_bits_pc <= io_update_bits_pc;	// predictor.scala:184:30
    s1_update_bits_br_mask <= io_update_bits_br_mask;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;	// predictor.scala:184:30
    s1_update_bits_cfi_taken <= io_update_bits_cfi_taken;	// predictor.scala:184:30
    s1_update_bits_target <= io_update_bits_target;	// predictor.scala:184:30
    s1_update_bits_meta <= io_update_bits_meta;	// predictor.scala:184:30
    s1_update_idx <= io_update_bits_pc[39:3];	// frontend.scala:163:35, predictor.scala:185:30
    if (s1_hits_0 | s1_hits_1 | s1_hits_2 | s1_hits_3)	// btb.scala:87:55, :133:44
      f3_meta_REG_write_way <=
        ~(s1_hit_ohs_0_0 | s1_hit_ohs_1_0 | s1_hit_ohs_2_0 | s1_hit_ohs_3_0);	// Mux.scala:47:69, btb.scala:53:32, :60:28, :84:30, :134:54, predictor.scala:160:14
    else	// btb.scala:133:44
      f3_meta_REG_write_way <=
        s1_idx[7] ^ s1_idx[8] ^ s1_idx[9] ^ s1_idx[10] ^ s1_idx[11] ^ s1_idx[12]
        ^ s1_idx[13] ^ s1_idx[14] ^ s1_idx[15] ^ s1_idx[16] ^ s1_idx[17] ^ s1_idx[18]
        ^ s1_idx[19] ^ s1_idx[20] ^ s1_idx[21] ^ s1_idx[22] ^ s1_idx[23] ^ s1_idx[24]
        ^ s1_idx[25] ^ s1_idx[26] ^ s1_idx[27] ^ s1_idx[28] ^ s1_idx[29] ^ s1_idx[30]
        ^ s1_idx[31] ^ s1_idx[32] ^ s1_idx[33] ^ s1_idx[34] ^ s1_idx[35] ^ s1_idx[36]
        ^ _meta_0_ext_R0_data[0] ^ _meta_0_ext_R0_data[1] ^ _meta_0_ext_R0_data[2]
        ^ _meta_0_ext_R0_data[3] ^ _meta_0_ext_R0_data[4] ^ _meta_0_ext_R0_data[5]
        ^ _meta_0_ext_R0_data[6] ^ _meta_0_ext_R0_data[7] ^ _meta_0_ext_R0_data[8]
        ^ _meta_0_ext_R0_data[9] ^ _meta_0_ext_R0_data[10] ^ _meta_0_ext_R0_data[11]
        ^ _meta_0_ext_R0_data[12] ^ _meta_0_ext_R0_data[13] ^ _meta_0_ext_R0_data[14]
        ^ _meta_0_ext_R0_data[15] ^ _meta_0_ext_R0_data[16] ^ _meta_0_ext_R0_data[17]
        ^ _meta_0_ext_R0_data[18] ^ _meta_0_ext_R0_data[19] ^ _meta_0_ext_R0_data[20]
        ^ _meta_0_ext_R0_data[21] ^ _meta_0_ext_R0_data[22] ^ _meta_0_ext_R0_data[23]
        ^ _meta_0_ext_R0_data[24] ^ _meta_0_ext_R0_data[25] ^ _meta_0_ext_R0_data[26]
        ^ _meta_0_ext_R0_data[27] ^ _meta_0_ext_R0_data[28] ^ _meta_0_ext_R0_data[29]
        ^ _meta_0_ext_R0_data[31] ^ _meta_0_ext_R0_data[32] ^ _meta_0_ext_R0_data[33]
        ^ _meta_0_ext_R0_data[34] ^ _meta_0_ext_R0_data[35] ^ _meta_0_ext_R0_data[36]
        ^ _meta_0_ext_R0_data[37] ^ _meta_0_ext_R0_data[38] ^ _meta_0_ext_R0_data[39]
        ^ _meta_0_ext_R0_data[40] ^ _meta_0_ext_R0_data[41] ^ _meta_0_ext_R0_data[42]
        ^ _meta_0_ext_R0_data[43] ^ _meta_0_ext_R0_data[44] ^ _meta_0_ext_R0_data[45]
        ^ _meta_0_ext_R0_data[46] ^ _meta_0_ext_R0_data[47] ^ _meta_0_ext_R0_data[48]
        ^ _meta_0_ext_R0_data[49] ^ _meta_0_ext_R0_data[50] ^ _meta_0_ext_R0_data[51]
        ^ _meta_0_ext_R0_data[52] ^ _meta_0_ext_R0_data[53] ^ _meta_0_ext_R0_data[54]
        ^ _meta_0_ext_R0_data[55] ^ _meta_0_ext_R0_data[56] ^ _meta_0_ext_R0_data[57]
        ^ _meta_0_ext_R0_data[58] ^ _meta_0_ext_R0_data[59] ^ _meta_0_ext_R0_data[60]
        ^ _meta_0_ext_R0_data[62] ^ _meta_0_ext_R0_data[63] ^ _meta_0_ext_R0_data[64]
        ^ _meta_0_ext_R0_data[65] ^ _meta_0_ext_R0_data[66] ^ _meta_0_ext_R0_data[67]
        ^ _meta_0_ext_R0_data[68] ^ _meta_0_ext_R0_data[69] ^ _meta_0_ext_R0_data[70]
        ^ _meta_0_ext_R0_data[71] ^ _meta_0_ext_R0_data[72] ^ _meta_0_ext_R0_data[73]
        ^ _meta_0_ext_R0_data[74] ^ _meta_0_ext_R0_data[75] ^ _meta_0_ext_R0_data[76]
        ^ _meta_0_ext_R0_data[77] ^ _meta_0_ext_R0_data[78] ^ _meta_0_ext_R0_data[79]
        ^ _meta_0_ext_R0_data[80] ^ _meta_0_ext_R0_data[81] ^ _meta_0_ext_R0_data[82]
        ^ _meta_0_ext_R0_data[83] ^ _meta_0_ext_R0_data[84] ^ _meta_0_ext_R0_data[85]
        ^ _meta_0_ext_R0_data[86] ^ _meta_0_ext_R0_data[87] ^ _meta_0_ext_R0_data[88]
        ^ _meta_0_ext_R0_data[89] ^ _meta_0_ext_R0_data[90] ^ _meta_0_ext_R0_data[91]
        ^ _meta_0_ext_R0_data[93] ^ _meta_0_ext_R0_data[94] ^ _meta_0_ext_R0_data[95]
        ^ _meta_0_ext_R0_data[96] ^ _meta_0_ext_R0_data[97] ^ _meta_0_ext_R0_data[98]
        ^ _meta_0_ext_R0_data[99] ^ _meta_0_ext_R0_data[100] ^ _meta_0_ext_R0_data[101]
        ^ _meta_0_ext_R0_data[102] ^ _meta_0_ext_R0_data[103] ^ _meta_0_ext_R0_data[104]
        ^ _meta_0_ext_R0_data[105] ^ _meta_0_ext_R0_data[106] ^ _meta_0_ext_R0_data[107]
        ^ _meta_0_ext_R0_data[108] ^ _meta_0_ext_R0_data[109] ^ _meta_0_ext_R0_data[110]
        ^ _meta_0_ext_R0_data[111] ^ _meta_0_ext_R0_data[112] ^ _meta_0_ext_R0_data[113]
        ^ _meta_0_ext_R0_data[114] ^ _meta_0_ext_R0_data[115] ^ _meta_0_ext_R0_data[116]
        ^ _meta_0_ext_R0_data[117] ^ _meta_0_ext_R0_data[118] ^ _meta_0_ext_R0_data[119]
        ^ _meta_0_ext_R0_data[120] ^ _meta_0_ext_R0_data[121] ^ _meta_0_ext_R0_data[122]
        ^ _meta_1_ext_R0_data[0] ^ _meta_1_ext_R0_data[1] ^ _meta_1_ext_R0_data[2]
        ^ _meta_1_ext_R0_data[3] ^ _meta_1_ext_R0_data[4] ^ _meta_1_ext_R0_data[5]
        ^ _meta_1_ext_R0_data[6] ^ _meta_1_ext_R0_data[7] ^ _meta_1_ext_R0_data[8]
        ^ _meta_1_ext_R0_data[9] ^ _meta_1_ext_R0_data[10] ^ _meta_1_ext_R0_data[11]
        ^ _meta_1_ext_R0_data[12] ^ _meta_1_ext_R0_data[13] ^ _meta_1_ext_R0_data[14]
        ^ _meta_1_ext_R0_data[15] ^ _meta_1_ext_R0_data[16] ^ _meta_1_ext_R0_data[17]
        ^ _meta_1_ext_R0_data[18] ^ _meta_1_ext_R0_data[19] ^ _meta_1_ext_R0_data[20]
        ^ _meta_1_ext_R0_data[21] ^ _meta_1_ext_R0_data[22] ^ _meta_1_ext_R0_data[23]
        ^ _meta_1_ext_R0_data[24] ^ _meta_1_ext_R0_data[25] ^ _meta_1_ext_R0_data[26]
        ^ _meta_1_ext_R0_data[27] ^ _meta_1_ext_R0_data[28] ^ _meta_1_ext_R0_data[29]
        ^ _meta_1_ext_R0_data[31] ^ _meta_1_ext_R0_data[32] ^ _meta_1_ext_R0_data[33]
        ^ _meta_1_ext_R0_data[34] ^ _meta_1_ext_R0_data[35] ^ _meta_1_ext_R0_data[36]
        ^ _meta_1_ext_R0_data[37] ^ _meta_1_ext_R0_data[38] ^ _meta_1_ext_R0_data[39]
        ^ _meta_1_ext_R0_data[40] ^ _meta_1_ext_R0_data[41] ^ _meta_1_ext_R0_data[42]
        ^ _meta_1_ext_R0_data[43] ^ _meta_1_ext_R0_data[44] ^ _meta_1_ext_R0_data[45]
        ^ _meta_1_ext_R0_data[46] ^ _meta_1_ext_R0_data[47] ^ _meta_1_ext_R0_data[48]
        ^ _meta_1_ext_R0_data[49] ^ _meta_1_ext_R0_data[50] ^ _meta_1_ext_R0_data[51]
        ^ _meta_1_ext_R0_data[52] ^ _meta_1_ext_R0_data[53] ^ _meta_1_ext_R0_data[54]
        ^ _meta_1_ext_R0_data[55] ^ _meta_1_ext_R0_data[56] ^ _meta_1_ext_R0_data[57]
        ^ _meta_1_ext_R0_data[58] ^ _meta_1_ext_R0_data[59] ^ _meta_1_ext_R0_data[60]
        ^ _meta_1_ext_R0_data[62] ^ _meta_1_ext_R0_data[63] ^ _meta_1_ext_R0_data[64]
        ^ _meta_1_ext_R0_data[65] ^ _meta_1_ext_R0_data[66] ^ _meta_1_ext_R0_data[67]
        ^ _meta_1_ext_R0_data[68] ^ _meta_1_ext_R0_data[69] ^ _meta_1_ext_R0_data[70]
        ^ _meta_1_ext_R0_data[71] ^ _meta_1_ext_R0_data[72] ^ _meta_1_ext_R0_data[73]
        ^ _meta_1_ext_R0_data[74] ^ _meta_1_ext_R0_data[75] ^ _meta_1_ext_R0_data[76]
        ^ _meta_1_ext_R0_data[77] ^ _meta_1_ext_R0_data[78] ^ _meta_1_ext_R0_data[79]
        ^ _meta_1_ext_R0_data[80] ^ _meta_1_ext_R0_data[81] ^ _meta_1_ext_R0_data[82]
        ^ _meta_1_ext_R0_data[83] ^ _meta_1_ext_R0_data[84] ^ _meta_1_ext_R0_data[85]
        ^ _meta_1_ext_R0_data[86] ^ _meta_1_ext_R0_data[87] ^ _meta_1_ext_R0_data[88]
        ^ _meta_1_ext_R0_data[89] ^ _meta_1_ext_R0_data[90] ^ _meta_1_ext_R0_data[91]
        ^ _meta_1_ext_R0_data[93] ^ _meta_1_ext_R0_data[94] ^ _meta_1_ext_R0_data[95]
        ^ _meta_1_ext_R0_data[96] ^ _meta_1_ext_R0_data[97] ^ _meta_1_ext_R0_data[98]
        ^ _meta_1_ext_R0_data[99] ^ _meta_1_ext_R0_data[100] ^ _meta_1_ext_R0_data[101]
        ^ _meta_1_ext_R0_data[102] ^ _meta_1_ext_R0_data[103] ^ _meta_1_ext_R0_data[104]
        ^ _meta_1_ext_R0_data[105] ^ _meta_1_ext_R0_data[106] ^ _meta_1_ext_R0_data[107]
        ^ _meta_1_ext_R0_data[108] ^ _meta_1_ext_R0_data[109] ^ _meta_1_ext_R0_data[110]
        ^ _meta_1_ext_R0_data[111] ^ _meta_1_ext_R0_data[112] ^ _meta_1_ext_R0_data[113]
        ^ _meta_1_ext_R0_data[114] ^ _meta_1_ext_R0_data[115] ^ _meta_1_ext_R0_data[116]
        ^ _meta_1_ext_R0_data[117] ^ _meta_1_ext_R0_data[118] ^ _meta_1_ext_R0_data[119]
        ^ _meta_1_ext_R0_data[120] ^ _meta_1_ext_R0_data[121] ^ _meta_1_ext_R0_data[122];	// btb.scala:53:32, :65:47, :127:14, :129:20, predictor.scala:163:29
    f3_meta_write_way <= f3_meta_REG_write_way;	// btb.scala:53:{24,32}
    REG <= s1_hits_0;	// btb.scala:87:55, :104:18
    io_resp_f2_0_predicted_pc_REG_valid <= s1_resp_0_valid;	// btb.scala:93:50, :105:44
    if (s1_hit_ohs_0_0 ? _btb_0_ext_R0_data[0] : _btb_1_ext_R0_data[0])	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_0_predicted_pc_REG_bits <= _ebtb_ext_R0_data;	// btb.scala:67:29, :105:44
    else begin	// btb.scala:97:34
      automatic logic [12:0] _GEN_10;	// btb.scala:97:34
      _GEN_10 = s1_hit_ohs_0_0 ? _btb_0_ext_R0_data[13:1] : _btb_1_ext_R0_data[13:1];	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_0_predicted_pc_REG_bits <= s1_pc + {{27{_GEN_10[12]}}, _GEN_10};	// btb.scala:97:34, :105:44, predictor.scala:178:22
    end
    io_resp_f2_0_is_br_REG <= ~doing_reset & s1_resp_0_valid & _GEN_6;	// btb.scala:60:28, :93:{25,50}, :98:54, :106:44
    io_resp_f2_0_is_jal_REG <= s1_is_jal_0;	// btb.scala:99:54, :107:44
    REG_1 <= s1_is_jal_0;	// btb.scala:99:54, :108:20
    REG_2 <= s1_hits_0;	// btb.scala:87:55, :112:26
    REG_3 <= REG_2;	// btb.scala:112:{18,26}
    if (REG) begin	// btb.scala:104:18
      io_resp_f3_0_predicted_pc_REG_valid <= io_resp_f2_0_predicted_pc_REG_valid;	// btb.scala:105:44, :113:44
      io_resp_f3_0_predicted_pc_REG_bits <= io_resp_f2_0_predicted_pc_REG_bits;	// btb.scala:105:44, :113:44
      io_resp_f3_0_is_br_REG <= io_resp_f2_0_is_br_REG;	// btb.scala:106:44, :114:44
      io_resp_f3_0_is_jal_REG <= io_resp_f2_0_is_jal_REG;	// btb.scala:107:44, :115:44
    end
    else begin	// btb.scala:104:18
      io_resp_f3_0_predicted_pc_REG_valid <= io_resp_in_0_f2_0_predicted_pc_valid;	// btb.scala:113:44
      io_resp_f3_0_predicted_pc_REG_bits <= io_resp_in_0_f2_0_predicted_pc_bits;	// btb.scala:113:44
      io_resp_f3_0_is_br_REG <= io_resp_in_0_f2_0_is_br;	// btb.scala:114:44
      io_resp_f3_0_is_jal_REG <= io_resp_in_0_f2_0_is_jal;	// btb.scala:115:44
    end
    REG_4 <= s1_is_jal_0;	// btb.scala:99:54, :116:28
    REG_5 <= REG_4;	// btb.scala:116:{20,28}
    REG_6 <= s1_hits_1;	// btb.scala:87:55, :104:18
    io_resp_f2_1_predicted_pc_REG_valid <= s1_resp_1_valid;	// btb.scala:93:50, :105:44
    if (s1_hit_ohs_1_0 ? _btb_0_ext_R0_data[14] : _btb_1_ext_R0_data[14])	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_1_predicted_pc_REG_bits <= _ebtb_ext_R0_data;	// btb.scala:67:29, :105:44
    else begin	// btb.scala:97:34
      automatic logic [12:0] _GEN_11;	// btb.scala:97:34
      _GEN_11 = s1_hit_ohs_1_0 ? _btb_0_ext_R0_data[27:15] : _btb_1_ext_R0_data[27:15];	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_1_predicted_pc_REG_bits <= s1_pc + {{27{_GEN_11[12]}}, _GEN_11} + 40'h2;	// btb.scala:97:{21,34}, :105:44, predictor.scala:178:22
    end
    io_resp_f2_1_is_br_REG <= ~doing_reset & s1_resp_1_valid & _GEN_7;	// btb.scala:60:28, :93:{25,50}, :98:54, :106:44
    io_resp_f2_1_is_jal_REG <= s1_is_jal_1;	// btb.scala:99:54, :107:44
    REG_7 <= s1_is_jal_1;	// btb.scala:99:54, :108:20
    REG_8 <= s1_hits_1;	// btb.scala:87:55, :112:26
    REG_9 <= REG_8;	// btb.scala:112:{18,26}
    if (REG_6) begin	// btb.scala:104:18
      io_resp_f3_1_predicted_pc_REG_valid <= io_resp_f2_1_predicted_pc_REG_valid;	// btb.scala:105:44, :113:44
      io_resp_f3_1_predicted_pc_REG_bits <= io_resp_f2_1_predicted_pc_REG_bits;	// btb.scala:105:44, :113:44
      io_resp_f3_1_is_br_REG <= io_resp_f2_1_is_br_REG;	// btb.scala:106:44, :114:44
      io_resp_f3_1_is_jal_REG <= io_resp_f2_1_is_jal_REG;	// btb.scala:107:44, :115:44
    end
    else begin	// btb.scala:104:18
      io_resp_f3_1_predicted_pc_REG_valid <= io_resp_in_0_f2_1_predicted_pc_valid;	// btb.scala:113:44
      io_resp_f3_1_predicted_pc_REG_bits <= io_resp_in_0_f2_1_predicted_pc_bits;	// btb.scala:113:44
      io_resp_f3_1_is_br_REG <= io_resp_in_0_f2_1_is_br;	// btb.scala:114:44
      io_resp_f3_1_is_jal_REG <= io_resp_in_0_f2_1_is_jal;	// btb.scala:115:44
    end
    REG_10 <= s1_is_jal_1;	// btb.scala:99:54, :116:28
    REG_11 <= REG_10;	// btb.scala:116:{20,28}
    REG_12 <= s1_hits_2;	// btb.scala:87:55, :104:18
    io_resp_f2_2_predicted_pc_REG_valid <= s1_resp_2_valid;	// btb.scala:93:50, :105:44
    if (s1_hit_ohs_2_0 ? _btb_0_ext_R0_data[28] : _btb_1_ext_R0_data[28])	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_2_predicted_pc_REG_bits <= _ebtb_ext_R0_data;	// btb.scala:67:29, :105:44
    else begin	// btb.scala:97:34
      automatic logic [12:0] _GEN_12;	// btb.scala:97:34
      _GEN_12 = s1_hit_ohs_2_0 ? _btb_0_ext_R0_data[41:29] : _btb_1_ext_R0_data[41:29];	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_2_predicted_pc_REG_bits <= s1_pc + {{27{_GEN_12[12]}}, _GEN_12} + 40'h4;	// btb.scala:97:{21,34}, :105:44, predictor.scala:178:22
    end
    io_resp_f2_2_is_br_REG <= ~doing_reset & s1_resp_2_valid & _GEN_8;	// btb.scala:60:28, :93:{25,50}, :98:54, :106:44
    io_resp_f2_2_is_jal_REG <= s1_is_jal_2;	// btb.scala:99:54, :107:44
    REG_13 <= s1_is_jal_2;	// btb.scala:99:54, :108:20
    REG_14 <= s1_hits_2;	// btb.scala:87:55, :112:26
    REG_15 <= REG_14;	// btb.scala:112:{18,26}
    if (REG_12) begin	// btb.scala:104:18
      io_resp_f3_2_predicted_pc_REG_valid <= io_resp_f2_2_predicted_pc_REG_valid;	// btb.scala:105:44, :113:44
      io_resp_f3_2_predicted_pc_REG_bits <= io_resp_f2_2_predicted_pc_REG_bits;	// btb.scala:105:44, :113:44
      io_resp_f3_2_is_br_REG <= io_resp_f2_2_is_br_REG;	// btb.scala:106:44, :114:44
      io_resp_f3_2_is_jal_REG <= io_resp_f2_2_is_jal_REG;	// btb.scala:107:44, :115:44
    end
    else begin	// btb.scala:104:18
      io_resp_f3_2_predicted_pc_REG_valid <= io_resp_in_0_f2_2_predicted_pc_valid;	// btb.scala:113:44
      io_resp_f3_2_predicted_pc_REG_bits <= io_resp_in_0_f2_2_predicted_pc_bits;	// btb.scala:113:44
      io_resp_f3_2_is_br_REG <= io_resp_in_0_f2_2_is_br;	// btb.scala:114:44
      io_resp_f3_2_is_jal_REG <= io_resp_in_0_f2_2_is_jal;	// btb.scala:115:44
    end
    REG_16 <= s1_is_jal_2;	// btb.scala:99:54, :116:28
    REG_17 <= REG_16;	// btb.scala:116:{20,28}
    REG_18 <= s1_hits_3;	// btb.scala:87:55, :104:18
    io_resp_f2_3_predicted_pc_REG_valid <= s1_resp_3_valid;	// btb.scala:93:50, :105:44
    if (s1_hit_ohs_3_0 ? _btb_0_ext_R0_data[42] : _btb_1_ext_R0_data[42])	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_3_predicted_pc_REG_bits <= _ebtb_ext_R0_data;	// btb.scala:67:29, :105:44
    else begin	// btb.scala:97:34
      automatic logic [12:0] _GEN_13;	// btb.scala:97:34
      _GEN_13 = s1_hit_ohs_3_0 ? _btb_0_ext_R0_data[55:43] : _btb_1_ext_R0_data[55:43];	// btb.scala:66:47, :73:93, :84:30, :97:34
      io_resp_f2_3_predicted_pc_REG_bits <= s1_pc + {{27{_GEN_13[12]}}, _GEN_13} + 40'h6;	// btb.scala:97:{21,34}, :105:44, predictor.scala:178:22
    end
    io_resp_f2_3_is_br_REG <= ~doing_reset & s1_resp_3_valid & _GEN_9;	// btb.scala:60:28, :93:{25,50}, :98:54, :106:44
    io_resp_f2_3_is_jal_REG <= s1_is_jal_3;	// btb.scala:99:54, :107:44
    REG_19 <= s1_is_jal_3;	// btb.scala:99:54, :108:20
    REG_20 <= s1_hits_3;	// btb.scala:87:55, :112:26
    REG_21 <= REG_20;	// btb.scala:112:{18,26}
    if (REG_18) begin	// btb.scala:104:18
      io_resp_f3_3_predicted_pc_REG_valid <= io_resp_f2_3_predicted_pc_REG_valid;	// btb.scala:105:44, :113:44
      io_resp_f3_3_predicted_pc_REG_bits <= io_resp_f2_3_predicted_pc_REG_bits;	// btb.scala:105:44, :113:44
      io_resp_f3_3_is_br_REG <= io_resp_f2_3_is_br_REG;	// btb.scala:106:44, :114:44
      io_resp_f3_3_is_jal_REG <= io_resp_f2_3_is_jal_REG;	// btb.scala:107:44, :115:44
    end
    else begin	// btb.scala:104:18
      io_resp_f3_3_predicted_pc_REG_valid <= io_resp_in_0_f2_3_predicted_pc_valid;	// btb.scala:113:44
      io_resp_f3_3_predicted_pc_REG_bits <= io_resp_in_0_f2_3_predicted_pc_bits;	// btb.scala:113:44
      io_resp_f3_3_is_br_REG <= io_resp_in_0_f2_3_is_br;	// btb.scala:114:44
      io_resp_f3_3_is_jal_REG <= io_resp_in_0_f2_3_is_jal;	// btb.scala:115:44
    end
    REG_22 <= s1_is_jal_3;	// btb.scala:99:54, :116:28
    REG_23 <= REG_22;	// btb.scala:116:{20,28}
    if (reset) begin
      doing_reset <= 1'h1;	// btb.scala:60:28
      reset_idx <= 7'h0;	// btb.scala:61:28
    end
    else begin
      doing_reset <= reset_idx != 7'h7F & doing_reset;	// btb.scala:60:28, :61:28, :63:{19,36,50}
      reset_idx <= reset_idx + {6'h0, doing_reset};	// btb.scala:60:28, :61:28, :62:26
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:27];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h1C; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_idx = {_RANDOM[5'h0], _RANDOM[5'h1][4:0]};	// predictor.scala:163:29
        s1_valid = _RANDOM[5'h3][15];	// predictor.scala:168:25
        s1_pc = {_RANDOM[5'h3][31:30], _RANDOM[5'h4], _RANDOM[5'h5][5:0]};	// predictor.scala:168:25, :178:22
        s1_update_valid = _RANDOM[5'h5][6];	// predictor.scala:178:22, :184:30
        s1_update_bits_is_mispredict_update = _RANDOM[5'h5][7];	// predictor.scala:178:22, :184:30
        s1_update_bits_is_repair_update = _RANDOM[5'h5][8];	// predictor.scala:178:22, :184:30
        s1_update_bits_btb_mispredicts = _RANDOM[5'h5][12:9];	// predictor.scala:178:22, :184:30
        s1_update_bits_pc = {_RANDOM[5'h5][31:13], _RANDOM[5'h6][20:0]};	// predictor.scala:178:22, :184:30
        s1_update_bits_br_mask = _RANDOM[5'h6][24:21];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_valid = _RANDOM[5'h6][25];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_bits = _RANDOM[5'h6][27:26];	// predictor.scala:184:30
        s1_update_bits_cfi_taken = _RANDOM[5'h6][28];	// predictor.scala:184:30
        s1_update_bits_target = {_RANDOM[5'h9][31:2], _RANDOM[5'hA][9:0]};	// predictor.scala:184:30
        s1_update_bits_meta =
          {_RANDOM[5'hA][31:10],
           _RANDOM[5'hB],
           _RANDOM[5'hC],
           _RANDOM[5'hD],
           _RANDOM[5'hE][1:0]};	// predictor.scala:184:30
        s1_update_idx = {_RANDOM[5'hE][31:2], _RANDOM[5'hF][6:0]};	// predictor.scala:184:30, :185:30
        f3_meta_REG_write_way = _RANDOM[5'hF][8];	// btb.scala:53:32, predictor.scala:185:30
        f3_meta_write_way = _RANDOM[5'hF][9];	// btb.scala:53:24, predictor.scala:185:30
        doing_reset = _RANDOM[5'hF][10];	// btb.scala:60:28, predictor.scala:185:30
        reset_idx = _RANDOM[5'hF][17:11];	// btb.scala:61:28, predictor.scala:185:30
        REG = _RANDOM[5'hF][18];	// btb.scala:104:18, predictor.scala:185:30
        io_resp_f2_0_predicted_pc_REG_valid = _RANDOM[5'hF][19];	// btb.scala:105:44, predictor.scala:185:30
        io_resp_f2_0_predicted_pc_REG_bits = {_RANDOM[5'hF][31:20], _RANDOM[5'h10][27:0]};	// btb.scala:105:44, predictor.scala:185:30
        io_resp_f2_0_is_br_REG = _RANDOM[5'h10][28];	// btb.scala:105:44, :106:44
        io_resp_f2_0_is_jal_REG = _RANDOM[5'h10][29];	// btb.scala:105:44, :107:44
        REG_1 = _RANDOM[5'h10][30];	// btb.scala:105:44, :108:20
        REG_2 = _RANDOM[5'h10][31];	// btb.scala:105:44, :112:26
        REG_3 = _RANDOM[5'h11][0];	// btb.scala:112:18
        io_resp_f3_0_predicted_pc_REG_valid = _RANDOM[5'h11][1];	// btb.scala:112:18, :113:44
        io_resp_f3_0_predicted_pc_REG_bits = {_RANDOM[5'h11][31:2], _RANDOM[5'h12][9:0]};	// btb.scala:112:18, :113:44
        io_resp_f3_0_is_br_REG = _RANDOM[5'h12][10];	// btb.scala:113:44, :114:44
        io_resp_f3_0_is_jal_REG = _RANDOM[5'h12][11];	// btb.scala:113:44, :115:44
        REG_4 = _RANDOM[5'h12][12];	// btb.scala:113:44, :116:28
        REG_5 = _RANDOM[5'h12][13];	// btb.scala:113:44, :116:20
        REG_6 = _RANDOM[5'h12][14];	// btb.scala:104:18, :113:44
        io_resp_f2_1_predicted_pc_REG_valid = _RANDOM[5'h12][15];	// btb.scala:105:44, :113:44
        io_resp_f2_1_predicted_pc_REG_bits =
          {_RANDOM[5'h12][31:16], _RANDOM[5'h13][23:0]};	// btb.scala:105:44, :113:44
        io_resp_f2_1_is_br_REG = _RANDOM[5'h13][24];	// btb.scala:105:44, :106:44
        io_resp_f2_1_is_jal_REG = _RANDOM[5'h13][25];	// btb.scala:105:44, :107:44
        REG_7 = _RANDOM[5'h13][26];	// btb.scala:105:44, :108:20
        REG_8 = _RANDOM[5'h13][27];	// btb.scala:105:44, :112:26
        REG_9 = _RANDOM[5'h13][28];	// btb.scala:105:44, :112:18
        io_resp_f3_1_predicted_pc_REG_valid = _RANDOM[5'h13][29];	// btb.scala:105:44, :113:44
        io_resp_f3_1_predicted_pc_REG_bits =
          {_RANDOM[5'h13][31:30], _RANDOM[5'h14], _RANDOM[5'h15][5:0]};	// btb.scala:105:44, :113:44
        io_resp_f3_1_is_br_REG = _RANDOM[5'h15][6];	// btb.scala:113:44, :114:44
        io_resp_f3_1_is_jal_REG = _RANDOM[5'h15][7];	// btb.scala:113:44, :115:44
        REG_10 = _RANDOM[5'h15][8];	// btb.scala:113:44, :116:28
        REG_11 = _RANDOM[5'h15][9];	// btb.scala:113:44, :116:20
        REG_12 = _RANDOM[5'h15][10];	// btb.scala:104:18, :113:44
        io_resp_f2_2_predicted_pc_REG_valid = _RANDOM[5'h15][11];	// btb.scala:105:44, :113:44
        io_resp_f2_2_predicted_pc_REG_bits =
          {_RANDOM[5'h15][31:12], _RANDOM[5'h16][19:0]};	// btb.scala:105:44, :113:44
        io_resp_f2_2_is_br_REG = _RANDOM[5'h16][20];	// btb.scala:105:44, :106:44
        io_resp_f2_2_is_jal_REG = _RANDOM[5'h16][21];	// btb.scala:105:44, :107:44
        REG_13 = _RANDOM[5'h16][22];	// btb.scala:105:44, :108:20
        REG_14 = _RANDOM[5'h16][23];	// btb.scala:105:44, :112:26
        REG_15 = _RANDOM[5'h16][24];	// btb.scala:105:44, :112:18
        io_resp_f3_2_predicted_pc_REG_valid = _RANDOM[5'h16][25];	// btb.scala:105:44, :113:44
        io_resp_f3_2_predicted_pc_REG_bits =
          {_RANDOM[5'h16][31:26], _RANDOM[5'h17], _RANDOM[5'h18][1:0]};	// btb.scala:105:44, :113:44
        io_resp_f3_2_is_br_REG = _RANDOM[5'h18][2];	// btb.scala:113:44, :114:44
        io_resp_f3_2_is_jal_REG = _RANDOM[5'h18][3];	// btb.scala:113:44, :115:44
        REG_16 = _RANDOM[5'h18][4];	// btb.scala:113:44, :116:28
        REG_17 = _RANDOM[5'h18][5];	// btb.scala:113:44, :116:20
        REG_18 = _RANDOM[5'h18][6];	// btb.scala:104:18, :113:44
        io_resp_f2_3_predicted_pc_REG_valid = _RANDOM[5'h18][7];	// btb.scala:105:44, :113:44
        io_resp_f2_3_predicted_pc_REG_bits = {_RANDOM[5'h18][31:8], _RANDOM[5'h19][15:0]};	// btb.scala:105:44, :113:44
        io_resp_f2_3_is_br_REG = _RANDOM[5'h19][16];	// btb.scala:105:44, :106:44
        io_resp_f2_3_is_jal_REG = _RANDOM[5'h19][17];	// btb.scala:105:44, :107:44
        REG_19 = _RANDOM[5'h19][18];	// btb.scala:105:44, :108:20
        REG_20 = _RANDOM[5'h19][19];	// btb.scala:105:44, :112:26
        REG_21 = _RANDOM[5'h19][20];	// btb.scala:105:44, :112:18
        io_resp_f3_3_predicted_pc_REG_valid = _RANDOM[5'h19][21];	// btb.scala:105:44, :113:44
        io_resp_f3_3_predicted_pc_REG_bits =
          {_RANDOM[5'h19][31:22], _RANDOM[5'h1A][29:0]};	// btb.scala:105:44, :113:44
        io_resp_f3_3_is_br_REG = _RANDOM[5'h1A][30];	// btb.scala:113:44, :114:44
        io_resp_f3_3_is_jal_REG = _RANDOM[5'h1A][31];	// btb.scala:113:44, :115:44
        REG_22 = _RANDOM[5'h1B][0];	// btb.scala:116:28
        REG_23 = _RANDOM[5'h1B][1];	// btb.scala:116:{20,28}
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  meta_128x124 meta_0_ext (	// btb.scala:65:47
    .R0_addr (io_f0_pc[9:3]),	// btb.scala:74:60
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (btb_1_MPORT_2_addr),	// btb.scala:169:12
    .W0_en   (btb_0_MPORT_en),	// btb.scala:167:23
    .W0_clk  (clock),
    .W0_data
      ({meta_0_MPORT_1_data_3,
        meta_0_MPORT_1_data_2,
        meta_0_MPORT_1_data_1,
        meta_0_MPORT_1_data_0}),	// btb.scala:65:47, :183:12
    .W0_mask (_GEN_5),	// btb.scala:186:12
    .R0_data (_meta_0_ext_R0_data)
  );
  meta_128x124 meta_1_ext (	// btb.scala:65:47
    .R0_addr (io_f0_pc[9:3]),	// btb.scala:74:60
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (btb_1_MPORT_2_addr),	// btb.scala:169:12
    .W0_en   (btb_1_MPORT_2_en),	// btb.scala:167:23
    .W0_clk  (clock),
    .W0_data
      ({meta_1_MPORT_3_data_3,
        meta_1_MPORT_3_data_2,
        meta_1_MPORT_3_data_1,
        meta_1_MPORT_3_data_0}),	// btb.scala:65:47, :183:12
    .W0_mask (_GEN_5),	// btb.scala:186:12
    .R0_data (_meta_1_ext_R0_data)
  );
  btb_128x56 btb_0_ext (	// btb.scala:66:47
    .R0_addr (io_f0_pc[9:3]),	// btb.scala:73:59
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (btb_1_MPORT_2_addr),	// btb.scala:169:12
    .W0_en   (btb_0_MPORT_en),	// btb.scala:167:23
    .W0_clk  (clock),
    .W0_data
      ({btb_0_MPORT_data_3, btb_0_MPORT_data_2, btb_0_MPORT_data_1, btb_0_MPORT_data_0}),	// btb.scala:66:47, :172:12
    .W0_mask (_GEN_0),	// btb.scala:175:12
    .R0_data (_btb_0_ext_R0_data)
  );
  btb_128x56 btb_1_ext (	// btb.scala:66:47
    .R0_addr (io_f0_pc[9:3]),	// btb.scala:73:59
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (btb_1_MPORT_2_addr),	// btb.scala:169:12
    .W0_en   (btb_1_MPORT_2_en),	// btb.scala:167:23
    .W0_clk  (clock),
    .W0_data
      ({btb_1_MPORT_2_data_3,
        btb_1_MPORT_2_data_2,
        btb_1_MPORT_2_data_1,
        btb_1_MPORT_2_data_0}),	// btb.scala:66:47, :172:12
    .W0_mask (_GEN_0),	// btb.scala:175:12
    .R0_data (_btb_1_ext_R0_data)
  );
  ebtb_128x40 ebtb_ext (	// btb.scala:67:29
    .R0_addr (io_f0_pc[9:3]),	// btb.scala:75:31
    .R0_en   (io_f0_valid),
    .R0_clk  (clock),
    .W0_addr (s1_update_idx[6:0]),	// predictor.scala:185:30
    .W0_en   ((|s1_update_wbtb_mask) & s1_update_wbtb_data_extended),	// btb.scala:144:65, :151:58, :194:{29,37}
    .W0_clk  (clock),
    .W0_data (s1_update_bits_target),	// predictor.scala:184:30
    .R0_data (_ebtb_ext_R0_data)
  );
  assign io_resp_f2_0_taken = REG & REG_1 | io_resp_in_0_f2_0_taken;	// btb.scala:102:19, :104:{18,32}, :108:{20,36}, :109:34
  assign io_resp_f2_0_is_br = REG ? io_resp_f2_0_is_br_REG : io_resp_in_0_f2_0_is_br;	// btb.scala:102:19, :104:{18,32}, :106:{34,44}
  assign io_resp_f2_0_is_jal = REG ? io_resp_f2_0_is_jal_REG : io_resp_in_0_f2_0_is_jal;	// btb.scala:102:19, :104:{18,32}, :107:{34,44}
  assign io_resp_f2_0_predicted_pc_valid =
    REG ? io_resp_f2_0_predicted_pc_REG_valid : io_resp_in_0_f2_0_predicted_pc_valid;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_0_predicted_pc_bits =
    REG ? io_resp_f2_0_predicted_pc_REG_bits : io_resp_in_0_f2_0_predicted_pc_bits;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_1_taken = REG_6 & REG_7 | io_resp_in_0_f2_1_taken;	// btb.scala:102:19, :104:{18,32}, :108:{20,36}, :109:34
  assign io_resp_f2_1_is_br = REG_6 ? io_resp_f2_1_is_br_REG : io_resp_in_0_f2_1_is_br;	// btb.scala:102:19, :104:{18,32}, :106:{34,44}
  assign io_resp_f2_1_is_jal = REG_6 ? io_resp_f2_1_is_jal_REG : io_resp_in_0_f2_1_is_jal;	// btb.scala:102:19, :104:{18,32}, :107:{34,44}
  assign io_resp_f2_1_predicted_pc_valid =
    REG_6 ? io_resp_f2_1_predicted_pc_REG_valid : io_resp_in_0_f2_1_predicted_pc_valid;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_1_predicted_pc_bits =
    REG_6 ? io_resp_f2_1_predicted_pc_REG_bits : io_resp_in_0_f2_1_predicted_pc_bits;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_2_taken = REG_12 & REG_13 | io_resp_in_0_f2_2_taken;	// btb.scala:102:19, :104:{18,32}, :108:{20,36}, :109:34
  assign io_resp_f2_2_is_br = REG_12 ? io_resp_f2_2_is_br_REG : io_resp_in_0_f2_2_is_br;	// btb.scala:102:19, :104:{18,32}, :106:{34,44}
  assign io_resp_f2_2_is_jal =
    REG_12 ? io_resp_f2_2_is_jal_REG : io_resp_in_0_f2_2_is_jal;	// btb.scala:102:19, :104:{18,32}, :107:{34,44}
  assign io_resp_f2_2_predicted_pc_valid =
    REG_12 ? io_resp_f2_2_predicted_pc_REG_valid : io_resp_in_0_f2_2_predicted_pc_valid;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_2_predicted_pc_bits =
    REG_12 ? io_resp_f2_2_predicted_pc_REG_bits : io_resp_in_0_f2_2_predicted_pc_bits;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_3_taken = REG_18 & REG_19 | io_resp_in_0_f2_3_taken;	// btb.scala:102:19, :104:{18,32}, :108:{20,36}, :109:34
  assign io_resp_f2_3_is_br = REG_18 ? io_resp_f2_3_is_br_REG : io_resp_in_0_f2_3_is_br;	// btb.scala:102:19, :104:{18,32}, :106:{34,44}
  assign io_resp_f2_3_is_jal =
    REG_18 ? io_resp_f2_3_is_jal_REG : io_resp_in_0_f2_3_is_jal;	// btb.scala:102:19, :104:{18,32}, :107:{34,44}
  assign io_resp_f2_3_predicted_pc_valid =
    REG_18 ? io_resp_f2_3_predicted_pc_REG_valid : io_resp_in_0_f2_3_predicted_pc_valid;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f2_3_predicted_pc_bits =
    REG_18 ? io_resp_f2_3_predicted_pc_REG_bits : io_resp_in_0_f2_3_predicted_pc_bits;	// btb.scala:102:19, :104:{18,32}, :105:{34,44}
  assign io_resp_f3_0_taken = REG_3 & REG_5 | io_resp_in_0_f3_0_taken;	// btb.scala:103:19, :112:{18,41}, :116:{20,45}, :117:34
  assign io_resp_f3_0_is_br = REG_3 ? io_resp_f3_0_is_br_REG : io_resp_in_0_f3_0_is_br;	// btb.scala:103:19, :112:{18,41}, :114:{34,44}
  assign io_resp_f3_0_is_jal = REG_3 ? io_resp_f3_0_is_jal_REG : io_resp_in_0_f3_0_is_jal;	// btb.scala:103:19, :112:{18,41}, :115:{34,44}
  assign io_resp_f3_0_predicted_pc_valid =
    REG_3 ? io_resp_f3_0_predicted_pc_REG_valid : io_resp_in_0_f3_0_predicted_pc_valid;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_0_predicted_pc_bits =
    REG_3 ? io_resp_f3_0_predicted_pc_REG_bits : io_resp_in_0_f3_0_predicted_pc_bits;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_1_taken = REG_9 & REG_11 | io_resp_in_0_f3_1_taken;	// btb.scala:103:19, :112:{18,41}, :116:{20,45}, :117:34
  assign io_resp_f3_1_is_br = REG_9 ? io_resp_f3_1_is_br_REG : io_resp_in_0_f3_1_is_br;	// btb.scala:103:19, :112:{18,41}, :114:{34,44}
  assign io_resp_f3_1_is_jal = REG_9 ? io_resp_f3_1_is_jal_REG : io_resp_in_0_f3_1_is_jal;	// btb.scala:103:19, :112:{18,41}, :115:{34,44}
  assign io_resp_f3_1_predicted_pc_valid =
    REG_9 ? io_resp_f3_1_predicted_pc_REG_valid : io_resp_in_0_f3_1_predicted_pc_valid;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_1_predicted_pc_bits =
    REG_9 ? io_resp_f3_1_predicted_pc_REG_bits : io_resp_in_0_f3_1_predicted_pc_bits;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_2_taken = REG_15 & REG_17 | io_resp_in_0_f3_2_taken;	// btb.scala:103:19, :112:{18,41}, :116:{20,45}, :117:34
  assign io_resp_f3_2_is_br = REG_15 ? io_resp_f3_2_is_br_REG : io_resp_in_0_f3_2_is_br;	// btb.scala:103:19, :112:{18,41}, :114:{34,44}
  assign io_resp_f3_2_is_jal =
    REG_15 ? io_resp_f3_2_is_jal_REG : io_resp_in_0_f3_2_is_jal;	// btb.scala:103:19, :112:{18,41}, :115:{34,44}
  assign io_resp_f3_2_predicted_pc_valid =
    REG_15 ? io_resp_f3_2_predicted_pc_REG_valid : io_resp_in_0_f3_2_predicted_pc_valid;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_2_predicted_pc_bits =
    REG_15 ? io_resp_f3_2_predicted_pc_REG_bits : io_resp_in_0_f3_2_predicted_pc_bits;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_3_taken = REG_21 & REG_23 | io_resp_in_0_f3_3_taken;	// btb.scala:103:19, :112:{18,41}, :116:{20,45}, :117:34
  assign io_resp_f3_3_is_br = REG_21 ? io_resp_f3_3_is_br_REG : io_resp_in_0_f3_3_is_br;	// btb.scala:103:19, :112:{18,41}, :114:{34,44}
  assign io_resp_f3_3_is_jal =
    REG_21 ? io_resp_f3_3_is_jal_REG : io_resp_in_0_f3_3_is_jal;	// btb.scala:103:19, :112:{18,41}, :115:{34,44}
  assign io_resp_f3_3_predicted_pc_valid =
    REG_21 ? io_resp_f3_3_predicted_pc_REG_valid : io_resp_in_0_f3_3_predicted_pc_valid;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_resp_f3_3_predicted_pc_bits =
    REG_21 ? io_resp_f3_3_predicted_pc_REG_bits : io_resp_in_0_f3_3_predicted_pc_bits;	// btb.scala:103:19, :112:{18,41}, :113:{34,44}
  assign io_f3_meta = {119'h0, f3_meta_write_way};	// btb.scala:53:24, :56:14
endmodule

