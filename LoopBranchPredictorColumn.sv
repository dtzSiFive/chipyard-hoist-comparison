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

module LoopBranchPredictorColumn(
  input         clock,
                reset,
  input  [35:0] io_f2_req_idx,
  input         io_f3_req_fire,
                io_f3_pred_in,
                io_update_mispredict,
                io_update_repair,
  input  [35:0] io_update_idx,
  input  [9:0]  io_update_meta_s_cnt,
  output        io_f3_pred,
  output [9:0]  io_f3_meta_s_cnt
);

  reg         doing_reset;	// loop.scala:59:30
  reg  [3:0]  reset_idx;	// loop.scala:60:28
  reg  [9:0]  entries_0_tag;	// loop.scala:65:22
  reg  [2:0]  entries_0_conf;	// loop.scala:65:22
  reg  [2:0]  entries_0_age;	// loop.scala:65:22
  reg  [9:0]  entries_0_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_0_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_1_tag;	// loop.scala:65:22
  reg  [2:0]  entries_1_conf;	// loop.scala:65:22
  reg  [2:0]  entries_1_age;	// loop.scala:65:22
  reg  [9:0]  entries_1_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_1_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_2_tag;	// loop.scala:65:22
  reg  [2:0]  entries_2_conf;	// loop.scala:65:22
  reg  [2:0]  entries_2_age;	// loop.scala:65:22
  reg  [9:0]  entries_2_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_2_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_3_tag;	// loop.scala:65:22
  reg  [2:0]  entries_3_conf;	// loop.scala:65:22
  reg  [2:0]  entries_3_age;	// loop.scala:65:22
  reg  [9:0]  entries_3_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_3_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_4_tag;	// loop.scala:65:22
  reg  [2:0]  entries_4_conf;	// loop.scala:65:22
  reg  [2:0]  entries_4_age;	// loop.scala:65:22
  reg  [9:0]  entries_4_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_4_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_5_tag;	// loop.scala:65:22
  reg  [2:0]  entries_5_conf;	// loop.scala:65:22
  reg  [2:0]  entries_5_age;	// loop.scala:65:22
  reg  [9:0]  entries_5_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_5_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_6_tag;	// loop.scala:65:22
  reg  [2:0]  entries_6_conf;	// loop.scala:65:22
  reg  [2:0]  entries_6_age;	// loop.scala:65:22
  reg  [9:0]  entries_6_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_6_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_7_tag;	// loop.scala:65:22
  reg  [2:0]  entries_7_conf;	// loop.scala:65:22
  reg  [2:0]  entries_7_age;	// loop.scala:65:22
  reg  [9:0]  entries_7_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_7_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_8_tag;	// loop.scala:65:22
  reg  [2:0]  entries_8_conf;	// loop.scala:65:22
  reg  [2:0]  entries_8_age;	// loop.scala:65:22
  reg  [9:0]  entries_8_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_8_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_9_tag;	// loop.scala:65:22
  reg  [2:0]  entries_9_conf;	// loop.scala:65:22
  reg  [2:0]  entries_9_age;	// loop.scala:65:22
  reg  [9:0]  entries_9_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_9_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_10_tag;	// loop.scala:65:22
  reg  [2:0]  entries_10_conf;	// loop.scala:65:22
  reg  [2:0]  entries_10_age;	// loop.scala:65:22
  reg  [9:0]  entries_10_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_10_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_11_tag;	// loop.scala:65:22
  reg  [2:0]  entries_11_conf;	// loop.scala:65:22
  reg  [2:0]  entries_11_age;	// loop.scala:65:22
  reg  [9:0]  entries_11_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_11_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_12_tag;	// loop.scala:65:22
  reg  [2:0]  entries_12_conf;	// loop.scala:65:22
  reg  [2:0]  entries_12_age;	// loop.scala:65:22
  reg  [9:0]  entries_12_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_12_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_13_tag;	// loop.scala:65:22
  reg  [2:0]  entries_13_conf;	// loop.scala:65:22
  reg  [2:0]  entries_13_age;	// loop.scala:65:22
  reg  [9:0]  entries_13_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_13_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_14_tag;	// loop.scala:65:22
  reg  [2:0]  entries_14_conf;	// loop.scala:65:22
  reg  [2:0]  entries_14_age;	// loop.scala:65:22
  reg  [9:0]  entries_14_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_14_s_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_15_tag;	// loop.scala:65:22
  reg  [2:0]  entries_15_conf;	// loop.scala:65:22
  reg  [2:0]  entries_15_age;	// loop.scala:65:22
  reg  [9:0]  entries_15_p_cnt;	// loop.scala:65:22
  reg  [9:0]  entries_15_s_cnt;	// loop.scala:65:22
  reg  [9:0]  f3_entry_tag;	// loop.scala:72:27
  reg  [2:0]  f3_entry_conf;	// loop.scala:72:27
  reg  [2:0]  f3_entry_age;	// loop.scala:72:27
  reg  [9:0]  f3_entry_p_cnt;	// loop.scala:72:27
  reg  [9:0]  f3_entry_s_cnt;	// loop.scala:72:27
  reg  [35:0] f3_scnt_REG;	// loop.scala:73:69
  wire        _f3_scnt_T_1 = io_update_repair & io_update_idx == f3_scnt_REG;	// loop.scala:73:{41,58,69}
  wire [9:0]  f3_scnt = _f3_scnt_T_1 ? io_update_meta_s_cnt : f3_entry_s_cnt;	// loop.scala:72:27, :73:{23,41}
  reg  [9:0]  f3_tag;	// loop.scala:76:27
  reg         f4_fire;	// loop.scala:88:27
  reg  [9:0]  f4_entry_tag;	// loop.scala:89:27
  reg  [2:0]  f4_entry_conf;	// loop.scala:89:27
  reg  [2:0]  f4_entry_age;	// loop.scala:89:27
  reg  [9:0]  f4_entry_p_cnt;	// loop.scala:89:27
  reg  [9:0]  f4_tag;	// loop.scala:90:27
  reg  [9:0]  f4_scnt;	// loop.scala:91:27
  reg  [35:0] f4_idx_REG;	// loop.scala:92:35
  reg  [35:0] f4_idx;	// loop.scala:92:27
  always @(posedge clock) begin
    automatic logic [15:0][9:0] _GEN;
    automatic logic [15:0][2:0] _GEN_0;
    automatic logic [15:0][2:0] _GEN_1;
    automatic logic [15:0][9:0] _GEN_2;
    automatic logic [15:0][9:0] _GEN_3;
    automatic logic             _GEN_4;	// loop.scala:67:45
    automatic logic             _GEN_5;	// loop.scala:97:42
    automatic logic [9:0]       _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    automatic logic             _GEN_7;	// loop.scala:65:22, :95:20, :96:38, :97:68
    automatic logic [2:0]       _GEN_8;	// loop.scala:65:22, :98:33, :102:33
    automatic logic [9:0]       _GEN_9;	// loop.scala:110:31
    automatic logic [2:0]       _GEN_10;	// loop.scala:110:31
    automatic logic [2:0]       _GEN_11;	// loop.scala:110:31
    automatic logic [9:0]       _GEN_12;	// loop.scala:110:31
    automatic logic [9:0]       _GEN_13;	// loop.scala:110:31
    automatic logic             tag_match;	// loop.scala:110:31
    automatic logic             ctr_match;	// loop.scala:111:33
    automatic logic             _GEN_14;	// loop.scala:114:32
    automatic logic             _GEN_15;	// loop.scala:117:32
    automatic logic             _GEN_16;	// loop.scala:122:39
    automatic logic             _GEN_17;	// loop.scala:125:39
    automatic logic             _GEN_18;	// loop.scala:125:52
    automatic logic [2:0]       _wentry_conf_T;	// loop.scala:126:36
    automatic logic             _GEN_19;	// loop.scala:130:52
    automatic logic             _GEN_20;	// loop.scala:136:39
    automatic logic             _GEN_21;	// loop.scala:136:53
    automatic logic             _GEN_22;	// loop.scala:143:53
    automatic logic [2:0]       _wentry_age_T;	// loop.scala:144:33
    automatic logic             _GEN_23;	// loop.scala:147:39
    automatic logic             _GEN_24;	// loop.scala:147:52
    automatic logic             _GEN_25;	// loop.scala:153:52
    automatic logic             _GEN_26;	// loop.scala:159:39
    automatic logic             _GEN_27;	// loop.scala:114:49, :117:46
    automatic logic             _GEN_28;	// loop.scala:136:75, :138:22, :143:75
    automatic logic             _GEN_29;	// loop.scala:153:67, :155:22, :159:54, :162:22
    automatic logic             _GEN_30;	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
    automatic logic             _GEN_31;	// loop.scala:130:67, :136:75, :143:75
    automatic logic             _GEN_32;	// loop.scala:125:66, :130:67, :136:75, :143:75
    automatic logic             _GEN_33;	// loop.scala:114:49, :117:46
    automatic logic             _GEN_34;	// loop.scala:117:46, :118:22, :122:54
    automatic logic             _GEN_35;	// loop.scala:114:49, :117:46
    automatic logic             _GEN_36;	// loop.scala:168:35
    automatic logic             _GEN_37;	// loop.scala:169:23
    automatic logic             _GEN_38;	// loop.scala:168:52, :169:66, :170:22
    automatic logic             _GEN_39;	// loop.scala:95:20, :114:49, :167:30, :168:52, :169:66, :171:32
    _GEN =
      {{entries_15_tag},
       {entries_14_tag},
       {entries_13_tag},
       {entries_12_tag},
       {entries_11_tag},
       {entries_10_tag},
       {entries_9_tag},
       {entries_8_tag},
       {entries_7_tag},
       {entries_6_tag},
       {entries_5_tag},
       {entries_4_tag},
       {entries_3_tag},
       {entries_2_tag},
       {entries_1_tag},
       {entries_0_tag}};	// loop.scala:65:22
    _GEN_0 =
      {{entries_15_conf},
       {entries_14_conf},
       {entries_13_conf},
       {entries_12_conf},
       {entries_11_conf},
       {entries_10_conf},
       {entries_9_conf},
       {entries_8_conf},
       {entries_7_conf},
       {entries_6_conf},
       {entries_5_conf},
       {entries_4_conf},
       {entries_3_conf},
       {entries_2_conf},
       {entries_1_conf},
       {entries_0_conf}};	// loop.scala:65:22
    _GEN_1 =
      {{entries_15_age},
       {entries_14_age},
       {entries_13_age},
       {entries_12_age},
       {entries_11_age},
       {entries_10_age},
       {entries_9_age},
       {entries_8_age},
       {entries_7_age},
       {entries_6_age},
       {entries_5_age},
       {entries_4_age},
       {entries_3_age},
       {entries_2_age},
       {entries_1_age},
       {entries_0_age}};	// loop.scala:65:22
    _GEN_2 =
      {{entries_15_p_cnt},
       {entries_14_p_cnt},
       {entries_13_p_cnt},
       {entries_12_p_cnt},
       {entries_11_p_cnt},
       {entries_10_p_cnt},
       {entries_9_p_cnt},
       {entries_8_p_cnt},
       {entries_7_p_cnt},
       {entries_6_p_cnt},
       {entries_5_p_cnt},
       {entries_4_p_cnt},
       {entries_3_p_cnt},
       {entries_2_p_cnt},
       {entries_1_p_cnt},
       {entries_0_p_cnt}};	// loop.scala:65:22
    _GEN_3 =
      {{entries_15_s_cnt},
       {entries_14_s_cnt},
       {entries_13_s_cnt},
       {entries_12_s_cnt},
       {entries_11_s_cnt},
       {entries_10_s_cnt},
       {entries_9_s_cnt},
       {entries_8_s_cnt},
       {entries_7_s_cnt},
       {entries_6_s_cnt},
       {entries_5_s_cnt},
       {entries_4_s_cnt},
       {entries_3_s_cnt},
       {entries_2_s_cnt},
       {entries_1_s_cnt},
       {entries_0_s_cnt}};	// loop.scala:65:22
    _GEN_4 = io_update_idx == io_f2_req_idx;	// loop.scala:67:45
    _GEN_5 = f4_scnt == f4_entry_p_cnt & (&f4_entry_conf);	// loop.scala:89:27, :91:27, :97:{23,42,59}
    _GEN_6 = _GEN_5 ? 10'h0 : f4_scnt + 10'h1;	// loop.scala:65:22, :91:27, :97:42, :99:33, :101:{33,44}, :176:43
    _GEN_7 = f4_fire & f4_entry_tag == f4_tag;	// loop.scala:65:22, :88:27, :89:27, :90:27, :95:20, :96:{26,38}, :97:68
    _GEN_8 = _GEN_5 | (&f4_entry_age) ? 3'h7 : f4_entry_age + 3'h1;	// loop.scala:65:22, :82:57, :89:27, :97:42, :98:33, :102:{33,53,80}, :138:22
    _GEN_9 = _GEN[io_update_idx[3:0]];	// loop.scala:110:31
    _GEN_10 = _GEN_0[io_update_idx[3:0]];	// loop.scala:110:31
    _GEN_11 = _GEN_1[io_update_idx[3:0]];	// loop.scala:110:31
    _GEN_12 = _GEN_2[io_update_idx[3:0]];	// loop.scala:110:31
    _GEN_13 = _GEN_3[io_update_idx[3:0]];	// loop.scala:110:31
    tag_match = _GEN_9 == io_update_idx[13:4];	// loop.scala:109:28, :110:31
    ctr_match = _GEN_12 == io_update_meta_s_cnt;	// loop.scala:110:31, :111:33
    _GEN_14 = io_update_mispredict & ~doing_reset;	// loop.scala:59:30, :114:{32,35}
    _GEN_15 = (&_GEN_10) & tag_match;	// loop.scala:110:31, :117:{24,32}
    _GEN_16 = (&_GEN_10) & ~tag_match;	// loop.scala:110:31, :117:24, :122:{39,42}
    _GEN_17 = (|_GEN_10) & tag_match;	// loop.scala:110:31, :125:{31,39}
    _GEN_18 = _GEN_17 & ctr_match;	// loop.scala:111:33, :125:{39,52}
    _wentry_conf_T = _GEN_10 + 3'h1;	// loop.scala:110:31, :126:36, :138:22
    _GEN_19 = _GEN_17 & ~ctr_match;	// loop.scala:111:33, :125:39, :130:{52,55}
    _GEN_20 = (|_GEN_10) & ~tag_match;	// loop.scala:110:31, :122:42, :125:31, :136:39
    _GEN_21 = _GEN_20 & ~(|_GEN_11);	// loop.scala:110:31, :136:{39,53,66}
    _GEN_22 = _GEN_20 & (|_GEN_11);	// loop.scala:110:31, :136:{39,66}, :143:53
    _wentry_age_T = _GEN_11 - 3'h1;	// loop.scala:110:31, :144:33
    _GEN_23 = ~(|_GEN_10) & tag_match;	// loop.scala:110:31, :125:31, :147:{31,39}
    _GEN_24 = _GEN_23 & ctr_match;	// loop.scala:111:33, :147:{39,52}
    _GEN_25 = _GEN_23 & ~ctr_match;	// loop.scala:111:33, :130:55, :147:39, :153:52
    _GEN_26 = ~(|_GEN_10) & ~tag_match;	// loop.scala:110:31, :122:42, :125:31, :147:31, :159:39
    _GEN_27 =
      ~_GEN_14 | _GEN_15 | _GEN_16 | _GEN_18 | _GEN_19
      | ~(_GEN_21 | ~(_GEN_22 | _GEN_24 | _GEN_25 | ~_GEN_26));	// loop.scala:114:{32,49}, :117:{32,46}, :122:{39,54}, :125:{52,66}, :130:{52,67}, :136:{53,75}, :137:22, :143:{53,75}, :147:{52,66}, :153:{52,67}, :159:{39,54}
    _GEN_28 = _GEN_21 | ~(_GEN_22 | ~(_GEN_24 | ~(_GEN_25 | ~_GEN_26)));	// loop.scala:136:{53,75}, :138:22, :143:{53,75}, :147:{52,66}, :148:22, :153:{52,67}, :159:{39,54}
    _GEN_29 = _GEN_25 | _GEN_26;	// loop.scala:153:{52,67}, :155:22, :159:{39,54}, :162:22
    _GEN_30 = _GEN_24 | _GEN_29;	// loop.scala:147:{52,66}, :149:22, :153:67, :155:22, :159:54, :162:22
    _GEN_31 = _GEN_19 | _GEN_21;	// loop.scala:130:{52,67}, :136:{53,75}, :143:75
    _GEN_32 = _GEN_18 | _GEN_31;	// loop.scala:125:{52,66}, :130:67, :136:75, :143:75
    _GEN_33 = ~_GEN_14 | _GEN_15 | _GEN_16 | _GEN_32;	// loop.scala:114:{32,49}, :117:{32,46}, :122:39, :125:66, :130:67, :136:75, :143:75
    _GEN_34 = _GEN_15 | ~(_GEN_16 | ~(_GEN_32 | ~(_GEN_22 | ~_GEN_30)));	// loop.scala:117:{32,46}, :118:22, :122:{39,54}, :125:66, :127:22, :130:67, :132:22, :136:75, :139:22, :143:{53,75}, :147:66, :149:22, :153:67, :155:22, :159:54, :162:22
    _GEN_35 =
      ~_GEN_14 | _GEN_15 | _GEN_16 | _GEN_18
      | ~(_GEN_31 | ~(_GEN_22 | _GEN_24 | ~_GEN_29));	// loop.scala:114:{32,49}, :117:{32,46}, :122:{39,54}, :125:{52,66}, :130:67, :133:22, :136:75, :140:22, :143:{53,75}, :147:{52,66}, :153:67, :155:22, :159:54, :162:22
    _GEN_36 = io_update_repair & ~doing_reset;	// loop.scala:59:30, :114:35, :168:35
    _GEN_37 = tag_match & ~(f4_fire & io_update_idx == f4_idx);	// loop.scala:88:27, :92:27, :110:31, :169:{23,26,36,53}
    _GEN_38 = _GEN_36 & _GEN_37;	// loop.scala:168:{35,52}, :169:{23,66}, :170:22
    _GEN_39 = _GEN_14 | _GEN_36 & _GEN_37;	// loop.scala:95:20, :114:{32,49}, :167:30, :168:{35,52}, :169:{23,66}, :171:32
    if (reset) begin
      doing_reset <= 1'h1;	// loop.scala:59:30
      reset_idx <= 4'h0;	// loop.scala:60:28
    end
    else begin
      doing_reset <= ~(&reset_idx) & doing_reset;	// loop.scala:59:30, :60:28, :62:{21,38,52}
      reset_idx <= reset_idx + {3'h0, doing_reset};	// loop.scala:59:30, :60:28, :61:28, :176:43
    end
    if (doing_reset & reset_idx == 4'h0) begin	// loop.scala:59:30, :60:28, :114:49, :175:24, :176:26
      entries_0_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_0_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_0_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_0_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_0_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h0) begin	// loop.scala:60:28, :95:20, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_0_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_0_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_0_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_0_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_0_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_0_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_0_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_0_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_0_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_0_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_0_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_0_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_0_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_0_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_0_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_0_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_0_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_0_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_0_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h0) begin	// loop.scala:60:28, :65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_0_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_0_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h1) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_1_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_1_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_1_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_1_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_1_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h1) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_1_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_1_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_1_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_1_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_1_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_1_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_1_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_1_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_1_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_1_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_1_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_1_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_1_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_1_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_1_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_1_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_1_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_1_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_1_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h1) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_1_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_1_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h2) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_2_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_2_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_2_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_2_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_2_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h2) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_2_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_2_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_2_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_2_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_2_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_2_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_2_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_2_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_2_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_2_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_2_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_2_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_2_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_2_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_2_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_2_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_2_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_2_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_2_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h2) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_2_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_2_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h3) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_3_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_3_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_3_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_3_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_3_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h3) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_3_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_3_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_3_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_3_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_3_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_3_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_3_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_3_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_3_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_3_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_3_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_3_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_3_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_3_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_3_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_3_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_3_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_3_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_3_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h3) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_3_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_3_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h4) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_4_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_4_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_4_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_4_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_4_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h4) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_4_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_4_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_4_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_4_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_4_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_4_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_4_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_4_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_4_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_4_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_4_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_4_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_4_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_4_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_4_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_4_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_4_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_4_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_4_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h4) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_4_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_4_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h5) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_5_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_5_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_5_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_5_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_5_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h5) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_5_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_5_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_5_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_5_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_5_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_5_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_5_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_5_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_5_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_5_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_5_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_5_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_5_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_5_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_5_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_5_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_5_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_5_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_5_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h5) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_5_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_5_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h6) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_6_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_6_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_6_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_6_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_6_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h6) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_6_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_6_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_6_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_6_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_6_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_6_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_6_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_6_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_6_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_6_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_6_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_6_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_6_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_6_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_6_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_6_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_6_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_6_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_6_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h6) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_6_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_6_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h7) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_7_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_7_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_7_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_7_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_7_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h7) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_7_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_7_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_7_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_7_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_7_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_7_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_7_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_7_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_7_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_7_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_7_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_7_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_7_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_7_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_7_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_7_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_7_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_7_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_7_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h7) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_7_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_7_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h8) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_8_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_8_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_8_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_8_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_8_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h8) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_8_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_8_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_8_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_8_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_8_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_8_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_8_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_8_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_8_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_8_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_8_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_8_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_8_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_8_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_8_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_8_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_8_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_8_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_8_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h8) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_8_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_8_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'h9) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_9_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_9_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_9_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_9_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_9_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'h9) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_9_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_9_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_9_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_9_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_9_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_9_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_9_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_9_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_9_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_9_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_9_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_9_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_9_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_9_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_9_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_9_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_9_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_9_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_9_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'h9) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_9_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_9_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'hA) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_10_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_10_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_10_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_10_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_10_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'hA) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_10_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_10_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_10_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_10_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_10_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_10_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_10_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_10_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_10_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_10_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_10_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_10_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_10_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_10_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_10_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_10_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_10_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_10_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_10_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'hA) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_10_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_10_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'hB) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_11_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_11_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_11_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_11_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_11_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'hB) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_11_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_11_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_11_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_11_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_11_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_11_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_11_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_11_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_11_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_11_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_11_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_11_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_11_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_11_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_11_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_11_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_11_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_11_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_11_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'hB) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_11_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_11_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'hC) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_12_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_12_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_12_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_12_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_12_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'hC) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_12_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_12_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_12_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_12_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_12_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_12_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_12_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_12_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_12_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_12_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_12_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_12_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_12_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_12_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_12_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_12_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_12_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_12_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_12_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'hC) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_12_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_12_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'hD) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_13_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_13_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_13_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_13_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_13_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'hD) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_13_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_13_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_13_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_13_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_13_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_13_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_13_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_13_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_13_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_13_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_13_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_13_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_13_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_13_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_13_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_13_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_13_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_13_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_13_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'hD) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_13_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_13_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & reset_idx == 4'hE) begin	// loop.scala:59:30, :60:28, :98:33, :114:49, :175:24, :176:26
      entries_14_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_14_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_14_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_14_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_14_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & io_update_idx[3:0] == 4'hE) begin	// loop.scala:95:20, :98:33, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_14_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_14_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_14_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_14_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_14_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_14_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_14_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_14_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_14_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_14_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_14_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_14_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_14_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_14_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_14_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_14_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_14_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_14_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_14_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & f4_idx[3:0] == 4'hE) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_14_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_14_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    if (doing_reset & (&reset_idx)) begin	// loop.scala:59:30, :60:28, :62:21, :114:49, :175:24, :176:26
      entries_15_tag <= 10'h0;	// loop.scala:65:22, :176:43
      entries_15_conf <= 3'h0;	// loop.scala:65:22, :176:43
      entries_15_age <= 3'h0;	// loop.scala:65:22, :176:43
      entries_15_p_cnt <= 10'h0;	// loop.scala:65:22, :176:43
      entries_15_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
    end
    else if (_GEN_39 & (&(io_update_idx[3:0]))) begin	// loop.scala:95:20, :114:49, :167:30, :168:52, :169:66, :171:32
      if (_GEN_27)	// loop.scala:114:49, :117:46
        entries_15_tag <= _GEN_9;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_15_tag <= io_update_idx[13:4];	// loop.scala:65:22, :109:28
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_15)	// loop.scala:117:32
          entries_15_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_16)	// loop.scala:122:39
          entries_15_conf <= _GEN_10;	// loop.scala:65:22, :110:31
        else if (_GEN_18)	// loop.scala:125:52
          entries_15_conf <= _wentry_conf_T;	// loop.scala:65:22, :126:36
        else if (_GEN_19)	// loop.scala:130:52
          entries_15_conf <= 3'h0;	// loop.scala:65:22, :176:43
        else if (_GEN_28)	// loop.scala:136:75, :138:22, :143:75
          entries_15_conf <= 3'h1;	// loop.scala:65:22, :138:22
        else	// loop.scala:136:75, :138:22, :143:75
          entries_15_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      end
      else	// loop.scala:114:32
        entries_15_conf <= _GEN_10;	// loop.scala:65:22, :110:31
      if (_GEN_33)	// loop.scala:114:49, :117:46
        entries_15_age <= _GEN_11;	// loop.scala:65:22, :110:31
      else if (_GEN_22)	// loop.scala:143:53
        entries_15_age <= _wentry_age_T;	// loop.scala:65:22, :144:33
      else if (_GEN_30)	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_15_age <= 3'h7;	// loop.scala:65:22, :82:57
      else	// loop.scala:147:66, :149:22, :153:67, :155:22, :159:54, :162:22
        entries_15_age <= _GEN_11;	// loop.scala:65:22, :110:31
      if (_GEN_35)	// loop.scala:114:49, :117:46
        entries_15_p_cnt <= _GEN_12;	// loop.scala:65:22, :110:31
      else	// loop.scala:114:49, :117:46
        entries_15_p_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      if (_GEN_14) begin	// loop.scala:114:32
        if (_GEN_34)	// loop.scala:117:46, :118:22, :122:54
          entries_15_s_cnt <= 10'h0;	// loop.scala:65:22, :176:43
        else	// loop.scala:117:46, :118:22, :122:54
          entries_15_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
      end
      else if (_GEN_38)	// loop.scala:168:52, :169:66, :170:22
        entries_15_s_cnt <= io_update_meta_s_cnt;	// loop.scala:65:22
      else	// loop.scala:168:52, :169:66, :170:22
        entries_15_s_cnt <= _GEN_13;	// loop.scala:65:22, :110:31
    end
    else if (_GEN_7 & (&(f4_idx[3:0]))) begin	// loop.scala:65:22, :92:27, :95:20, :96:38, :97:68, :98:33
      entries_15_age <= _GEN_8;	// loop.scala:65:22, :98:33, :102:33
      entries_15_s_cnt <= _GEN_6;	// loop.scala:65:22, :99:33, :101:33
    end
    f3_entry_tag <= _GEN[io_f2_req_idx[3:0]];	// loop.scala:72:27
    f3_entry_conf <= _GEN_0[io_f2_req_idx[3:0]];	// loop.scala:72:27
    f3_entry_age <= _GEN_1[io_f2_req_idx[3:0]];	// loop.scala:72:27
    f3_entry_p_cnt <= _GEN_2[io_f2_req_idx[3:0]];	// loop.scala:72:27
    if (io_update_repair & _GEN_4)	// loop.scala:67:{28,45}
      f3_entry_s_cnt <= io_update_meta_s_cnt;	// loop.scala:72:27
    else if (io_update_mispredict & _GEN_4)	// loop.scala:67:45, :69:39
      f3_entry_s_cnt <= 10'h0;	// loop.scala:72:27, :176:43
    else	// loop.scala:69:39
      f3_entry_s_cnt <= _GEN_3[io_f2_req_idx[3:0]];	// loop.scala:72:27
    f3_scnt_REG <= io_f2_req_idx;	// loop.scala:73:69
    f3_tag <= io_f2_req_idx[13:4];	// loop.scala:76:{27,41}
    f4_fire <= io_f3_req_fire;	// loop.scala:88:27
    f4_entry_tag <= f3_entry_tag;	// loop.scala:72:27, :89:27
    f4_entry_conf <= f3_entry_conf;	// loop.scala:72:27, :89:27
    f4_entry_age <= f3_entry_age;	// loop.scala:72:27, :89:27
    f4_entry_p_cnt <= f3_entry_p_cnt;	// loop.scala:72:27, :89:27
    f4_tag <= f3_tag;	// loop.scala:76:27, :90:27
    if (_f3_scnt_T_1)	// loop.scala:73:41
      f4_scnt <= io_update_meta_s_cnt;	// loop.scala:91:27
    else	// loop.scala:73:41
      f4_scnt <= f3_entry_s_cnt;	// loop.scala:72:27, :91:27
    f4_idx_REG <= io_f2_req_idx;	// loop.scala:92:35
    f4_idx <= f4_idx_REG;	// loop.scala:92:{27,35}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:24];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h19; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        doing_reset = _RANDOM[5'h0][0];	// loop.scala:59:30
        reset_idx = _RANDOM[5'h0][4:1];	// loop.scala:59:30, :60:28
        entries_0_tag = _RANDOM[5'h0][14:5];	// loop.scala:59:30, :65:22
        entries_0_conf = _RANDOM[5'h0][17:15];	// loop.scala:59:30, :65:22
        entries_0_age = _RANDOM[5'h0][20:18];	// loop.scala:59:30, :65:22
        entries_0_p_cnt = _RANDOM[5'h0][30:21];	// loop.scala:59:30, :65:22
        entries_0_s_cnt = {_RANDOM[5'h0][31], _RANDOM[5'h1][8:0]};	// loop.scala:59:30, :65:22
        entries_1_tag = _RANDOM[5'h1][18:9];	// loop.scala:65:22
        entries_1_conf = _RANDOM[5'h1][21:19];	// loop.scala:65:22
        entries_1_age = _RANDOM[5'h1][24:22];	// loop.scala:65:22
        entries_1_p_cnt = {_RANDOM[5'h1][31:25], _RANDOM[5'h2][2:0]};	// loop.scala:65:22
        entries_1_s_cnt = _RANDOM[5'h2][12:3];	// loop.scala:65:22
        entries_2_tag = _RANDOM[5'h2][22:13];	// loop.scala:65:22
        entries_2_conf = _RANDOM[5'h2][25:23];	// loop.scala:65:22
        entries_2_age = _RANDOM[5'h2][28:26];	// loop.scala:65:22
        entries_2_p_cnt = {_RANDOM[5'h2][31:29], _RANDOM[5'h3][6:0]};	// loop.scala:65:22
        entries_2_s_cnt = _RANDOM[5'h3][16:7];	// loop.scala:65:22
        entries_3_tag = _RANDOM[5'h3][26:17];	// loop.scala:65:22
        entries_3_conf = _RANDOM[5'h3][29:27];	// loop.scala:65:22
        entries_3_age = {_RANDOM[5'h3][31:30], _RANDOM[5'h4][0]};	// loop.scala:65:22
        entries_3_p_cnt = _RANDOM[5'h4][10:1];	// loop.scala:65:22
        entries_3_s_cnt = _RANDOM[5'h4][20:11];	// loop.scala:65:22
        entries_4_tag = _RANDOM[5'h4][30:21];	// loop.scala:65:22
        entries_4_conf = {_RANDOM[5'h4][31], _RANDOM[5'h5][1:0]};	// loop.scala:65:22
        entries_4_age = _RANDOM[5'h5][4:2];	// loop.scala:65:22
        entries_4_p_cnt = _RANDOM[5'h5][14:5];	// loop.scala:65:22
        entries_4_s_cnt = _RANDOM[5'h5][24:15];	// loop.scala:65:22
        entries_5_tag = {_RANDOM[5'h5][31:25], _RANDOM[5'h6][2:0]};	// loop.scala:65:22
        entries_5_conf = _RANDOM[5'h6][5:3];	// loop.scala:65:22
        entries_5_age = _RANDOM[5'h6][8:6];	// loop.scala:65:22
        entries_5_p_cnt = _RANDOM[5'h6][18:9];	// loop.scala:65:22
        entries_5_s_cnt = _RANDOM[5'h6][28:19];	// loop.scala:65:22
        entries_6_tag = {_RANDOM[5'h6][31:29], _RANDOM[5'h7][6:0]};	// loop.scala:65:22
        entries_6_conf = _RANDOM[5'h7][9:7];	// loop.scala:65:22
        entries_6_age = _RANDOM[5'h7][12:10];	// loop.scala:65:22
        entries_6_p_cnt = _RANDOM[5'h7][22:13];	// loop.scala:65:22
        entries_6_s_cnt = {_RANDOM[5'h7][31:23], _RANDOM[5'h8][0]};	// loop.scala:65:22
        entries_7_tag = _RANDOM[5'h8][10:1];	// loop.scala:65:22
        entries_7_conf = _RANDOM[5'h8][13:11];	// loop.scala:65:22
        entries_7_age = _RANDOM[5'h8][16:14];	// loop.scala:65:22
        entries_7_p_cnt = _RANDOM[5'h8][26:17];	// loop.scala:65:22
        entries_7_s_cnt = {_RANDOM[5'h8][31:27], _RANDOM[5'h9][4:0]};	// loop.scala:65:22
        entries_8_tag = _RANDOM[5'h9][14:5];	// loop.scala:65:22
        entries_8_conf = _RANDOM[5'h9][17:15];	// loop.scala:65:22
        entries_8_age = _RANDOM[5'h9][20:18];	// loop.scala:65:22
        entries_8_p_cnt = _RANDOM[5'h9][30:21];	// loop.scala:65:22
        entries_8_s_cnt = {_RANDOM[5'h9][31], _RANDOM[5'hA][8:0]};	// loop.scala:65:22
        entries_9_tag = _RANDOM[5'hA][18:9];	// loop.scala:65:22
        entries_9_conf = _RANDOM[5'hA][21:19];	// loop.scala:65:22
        entries_9_age = _RANDOM[5'hA][24:22];	// loop.scala:65:22
        entries_9_p_cnt = {_RANDOM[5'hA][31:25], _RANDOM[5'hB][2:0]};	// loop.scala:65:22
        entries_9_s_cnt = _RANDOM[5'hB][12:3];	// loop.scala:65:22
        entries_10_tag = _RANDOM[5'hB][22:13];	// loop.scala:65:22
        entries_10_conf = _RANDOM[5'hB][25:23];	// loop.scala:65:22
        entries_10_age = _RANDOM[5'hB][28:26];	// loop.scala:65:22
        entries_10_p_cnt = {_RANDOM[5'hB][31:29], _RANDOM[5'hC][6:0]};	// loop.scala:65:22
        entries_10_s_cnt = _RANDOM[5'hC][16:7];	// loop.scala:65:22
        entries_11_tag = _RANDOM[5'hC][26:17];	// loop.scala:65:22
        entries_11_conf = _RANDOM[5'hC][29:27];	// loop.scala:65:22
        entries_11_age = {_RANDOM[5'hC][31:30], _RANDOM[5'hD][0]};	// loop.scala:65:22
        entries_11_p_cnt = _RANDOM[5'hD][10:1];	// loop.scala:65:22
        entries_11_s_cnt = _RANDOM[5'hD][20:11];	// loop.scala:65:22
        entries_12_tag = _RANDOM[5'hD][30:21];	// loop.scala:65:22
        entries_12_conf = {_RANDOM[5'hD][31], _RANDOM[5'hE][1:0]};	// loop.scala:65:22
        entries_12_age = _RANDOM[5'hE][4:2];	// loop.scala:65:22
        entries_12_p_cnt = _RANDOM[5'hE][14:5];	// loop.scala:65:22
        entries_12_s_cnt = _RANDOM[5'hE][24:15];	// loop.scala:65:22
        entries_13_tag = {_RANDOM[5'hE][31:25], _RANDOM[5'hF][2:0]};	// loop.scala:65:22
        entries_13_conf = _RANDOM[5'hF][5:3];	// loop.scala:65:22
        entries_13_age = _RANDOM[5'hF][8:6];	// loop.scala:65:22
        entries_13_p_cnt = _RANDOM[5'hF][18:9];	// loop.scala:65:22
        entries_13_s_cnt = _RANDOM[5'hF][28:19];	// loop.scala:65:22
        entries_14_tag = {_RANDOM[5'hF][31:29], _RANDOM[5'h10][6:0]};	// loop.scala:65:22
        entries_14_conf = _RANDOM[5'h10][9:7];	// loop.scala:65:22
        entries_14_age = _RANDOM[5'h10][12:10];	// loop.scala:65:22
        entries_14_p_cnt = _RANDOM[5'h10][22:13];	// loop.scala:65:22
        entries_14_s_cnt = {_RANDOM[5'h10][31:23], _RANDOM[5'h11][0]};	// loop.scala:65:22
        entries_15_tag = _RANDOM[5'h11][10:1];	// loop.scala:65:22
        entries_15_conf = _RANDOM[5'h11][13:11];	// loop.scala:65:22
        entries_15_age = _RANDOM[5'h11][16:14];	// loop.scala:65:22
        entries_15_p_cnt = _RANDOM[5'h11][26:17];	// loop.scala:65:22
        entries_15_s_cnt = {_RANDOM[5'h11][31:27], _RANDOM[5'h12][4:0]};	// loop.scala:65:22
        f3_entry_tag = _RANDOM[5'h12][14:5];	// loop.scala:65:22, :72:27
        f3_entry_conf = _RANDOM[5'h12][17:15];	// loop.scala:65:22, :72:27
        f3_entry_age = _RANDOM[5'h12][20:18];	// loop.scala:65:22, :72:27
        f3_entry_p_cnt = _RANDOM[5'h12][30:21];	// loop.scala:65:22, :72:27
        f3_entry_s_cnt = {_RANDOM[5'h12][31], _RANDOM[5'h13][8:0]};	// loop.scala:65:22, :72:27
        f3_scnt_REG = {_RANDOM[5'h13][31:9], _RANDOM[5'h14][12:0]};	// loop.scala:72:27, :73:69
        f3_tag = _RANDOM[5'h14][22:13];	// loop.scala:73:69, :76:27
        f4_fire = _RANDOM[5'h14][23];	// loop.scala:73:69, :88:27
        f4_entry_tag = {_RANDOM[5'h14][31:24], _RANDOM[5'h15][1:0]};	// loop.scala:73:69, :89:27
        f4_entry_conf = _RANDOM[5'h15][4:2];	// loop.scala:89:27
        f4_entry_age = _RANDOM[5'h15][7:5];	// loop.scala:89:27
        f4_entry_p_cnt = _RANDOM[5'h15][17:8];	// loop.scala:89:27
        f4_tag = {_RANDOM[5'h15][31:28], _RANDOM[5'h16][5:0]};	// loop.scala:89:27, :90:27
        f4_scnt = _RANDOM[5'h16][15:6];	// loop.scala:90:27, :91:27
        f4_idx_REG = {_RANDOM[5'h16][31:16], _RANDOM[5'h17][19:0]};	// loop.scala:90:27, :92:35
        f4_idx = {_RANDOM[5'h17][31:20], _RANDOM[5'h18][23:0]};	// loop.scala:92:{27,35}
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_f3_pred =
    f3_entry_tag == f3_tag & f3_scnt == f3_entry_p_cnt & (&f3_entry_conf) ^ io_f3_pred_in;	// loop.scala:72:27, :73:23, :76:27, :78:16, :81:{24,36}, :82:{21,57,66}, :83:20
  assign io_f3_meta_s_cnt = f3_scnt;	// loop.scala:73:23
endmodule

