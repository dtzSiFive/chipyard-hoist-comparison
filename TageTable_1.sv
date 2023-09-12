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

module TageTable_1(
  input         clock,
                reset,
                io_f1_req_valid,
  input  [39:0] io_f1_req_pc,
  input  [63:0] io_f1_req_ghist,
  input         io_update_mask_0,
                io_update_mask_1,
                io_update_mask_2,
                io_update_mask_3,
                io_update_taken_0,
                io_update_taken_1,
                io_update_taken_2,
                io_update_taken_3,
                io_update_alloc_0,
                io_update_alloc_1,
                io_update_alloc_2,
                io_update_alloc_3,
  input  [2:0]  io_update_old_ctr_0,
                io_update_old_ctr_1,
                io_update_old_ctr_2,
                io_update_old_ctr_3,
  input  [39:0] io_update_pc,
  input  [63:0] io_update_hist,
  input         io_update_u_mask_0,
                io_update_u_mask_1,
                io_update_u_mask_2,
                io_update_u_mask_3,
  input  [1:0]  io_update_u_0,
                io_update_u_1,
                io_update_u_2,
                io_update_u_3,
  output        io_f3_resp_0_valid,
  output [2:0]  io_f3_resp_0_bits_ctr,
  output [1:0]  io_f3_resp_0_bits_u,
  output        io_f3_resp_1_valid,
  output [2:0]  io_f3_resp_1_bits_ctr,
  output [1:0]  io_f3_resp_1_bits_u,
  output        io_f3_resp_2_valid,
  output [2:0]  io_f3_resp_2_bits_ctr,
  output [1:0]  io_f3_resp_2_bits_u,
  output        io_f3_resp_3_valid,
  output [2:0]  io_f3_resp_3_bits_ctr,
  output [1:0]  io_f3_resp_3_bits_u
);

  wire        update_lo_wdata_3;	// tage.scala:167:44
  wire        update_hi_wdata_3;	// tage.scala:166:44
  wire [2:0]  update_wdata_3_ctr;	// tage.scala:155:33
  wire        update_lo_wdata_2;	// tage.scala:167:44
  wire        update_hi_wdata_2;	// tage.scala:166:44
  wire [2:0]  update_wdata_2_ctr;	// tage.scala:155:33
  wire        update_lo_wdata_1;	// tage.scala:167:44
  wire        update_hi_wdata_1;	// tage.scala:166:44
  wire [2:0]  update_wdata_1_ctr;	// tage.scala:155:33
  wire        update_lo_wdata_0;	// tage.scala:167:44
  wire        update_hi_wdata_0;	// tage.scala:166:44
  wire [2:0]  update_wdata_0_ctr;	// tage.scala:155:33
  wire        lo_us_MPORT_2_data_3;	// tage.scala:137:8
  wire        lo_us_MPORT_2_data_2;	// tage.scala:137:8
  wire        lo_us_MPORT_2_data_1;	// tage.scala:137:8
  wire        lo_us_MPORT_2_data_0;	// tage.scala:137:8
  wire        hi_us_MPORT_1_data_3;	// tage.scala:130:8
  wire        hi_us_MPORT_1_data_2;	// tage.scala:130:8
  wire        hi_us_MPORT_1_data_1;	// tage.scala:130:8
  wire        hi_us_MPORT_1_data_0;	// tage.scala:130:8
  wire [10:0] table_MPORT_data_3;	// tage.scala:123:8
  wire [10:0] table_MPORT_data_2;	// tage.scala:123:8
  wire [10:0] table_MPORT_data_1;	// tage.scala:123:8
  wire [10:0] table_MPORT_data_0;	// tage.scala:123:8
  wire [43:0] _table_ext_R0_data;	// tage.scala:91:27
  wire [3:0]  _lo_us_ext_R0_data;	// tage.scala:90:27
  wire [3:0]  _hi_us_ext_R0_data;	// tage.scala:89:27
  reg         doing_reset;	// tage.scala:72:28
  reg  [6:0]  reset_idx;	// tage.scala:73:26
  wire [6:0]  _s2_req_rlous_T_1 =
    {io_f1_req_pc[10:8], io_f1_req_pc[7:4] ^ io_f1_req_ghist[3:0]};	// frontend.scala:163:35, tage.scala:53:11, :60:{29,43}
  reg  [6:0]  s2_tag;	// tage.scala:95:29
  reg         io_f3_resp_0_valid_REG;	// tage.scala:104:38
  reg  [1:0]  io_f3_resp_0_bits_u_REG;	// tage.scala:105:38
  reg  [2:0]  io_f3_resp_0_bits_ctr_REG;	// tage.scala:106:38
  reg         io_f3_resp_1_valid_REG;	// tage.scala:104:38
  reg  [1:0]  io_f3_resp_1_bits_u_REG;	// tage.scala:105:38
  reg  [2:0]  io_f3_resp_1_bits_ctr_REG;	// tage.scala:106:38
  reg         io_f3_resp_2_valid_REG;	// tage.scala:104:38
  reg  [1:0]  io_f3_resp_2_bits_u_REG;	// tage.scala:105:38
  reg  [2:0]  io_f3_resp_2_bits_ctr_REG;	// tage.scala:106:38
  reg         io_f3_resp_3_valid_REG;	// tage.scala:104:38
  reg  [1:0]  io_f3_resp_3_bits_u_REG;	// tage.scala:105:38
  reg  [2:0]  io_f3_resp_3_bits_ctr_REG;	// tage.scala:106:38
  reg  [18:0] clear_u_ctr;	// tage.scala:109:28
  wire        doing_clear_u = clear_u_ctr[10:0] == 11'h0;	// tage.scala:109:28, :112:{34,61}, :123:29
  wire        doing_clear_u_hi = doing_clear_u & clear_u_ctr[18];	// tage.scala:109:28, :112:61, :113:{40,54}
  wire        doing_clear_u_lo = doing_clear_u & ~(clear_u_ctr[18]);	// tage.scala:109:28, :112:61, :113:54, :114:{40,95}
  wire [3:0]  _GEN = io_update_pc[7:4] ^ io_update_hist[3:0];	// frontend.scala:163:35, tage.scala:53:11, :60:29
  wire [6:0]  update_idx = {io_update_pc[10:8], _GEN};	// tage.scala:60:{29,43}
  wire [3:0]  _GEN_0 = io_update_pc[14:11] ^ io_update_hist[3:0];	// frontend.scala:163:35, tage.scala:53:11, :62:{30,50}
  wire [6:0]  update_wdata_3_tag = {io_update_pc[17:15], _GEN_0};	// tage.scala:62:{50,64}
  assign table_MPORT_data_0 =
    doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, update_wdata_0_ctr};	// tage.scala:62:{50,64}, :72:28, :123:{8,29,102}, :155:33
  assign table_MPORT_data_1 =
    doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, update_wdata_1_ctr};	// tage.scala:62:{50,64}, :72:28, :123:{8,29,102}, :155:33
  assign table_MPORT_data_2 =
    doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, update_wdata_2_ctr};	// tage.scala:62:{50,64}, :72:28, :123:{8,29,102}, :155:33
  assign table_MPORT_data_3 =
    doing_reset ? 11'h0 : {1'h1, io_update_pc[17:15], _GEN_0, update_wdata_3_ctr};	// tage.scala:62:{50,64}, :72:28, :123:{8,29,102}, :155:33
  wire [6:0]  _GEN_1 = {io_update_pc[10:8], _GEN};	// tage.scala:60:{29,43}, :129:36
  wire        _GEN_2 = doing_reset | doing_clear_u_hi;	// tage.scala:72:28, :113:40, :130:21
  assign hi_us_MPORT_1_data_0 = ~_GEN_2 & update_hi_wdata_0;	// tage.scala:130:{8,21}, :166:44
  assign hi_us_MPORT_1_data_1 = ~_GEN_2 & update_hi_wdata_1;	// tage.scala:130:{8,21}, :166:44
  assign hi_us_MPORT_1_data_2 = ~_GEN_2 & update_hi_wdata_2;	// tage.scala:130:{8,21}, :166:44
  assign hi_us_MPORT_1_data_3 = ~_GEN_2 & update_hi_wdata_3;	// tage.scala:130:{8,21}, :166:44
  wire [3:0]  _GEN_3 =
    {io_update_u_mask_3, io_update_u_mask_2, io_update_u_mask_1, io_update_u_mask_0};	// tage.scala:131:80
  wire        _GEN_4 = doing_reset | doing_clear_u_lo;	// tage.scala:72:28, :114:40, :137:21
  assign lo_us_MPORT_2_data_0 = ~_GEN_4 & update_lo_wdata_0;	// tage.scala:137:{8,21}, :167:44
  assign lo_us_MPORT_2_data_1 = ~_GEN_4 & update_lo_wdata_1;	// tage.scala:137:{8,21}, :167:44
  assign lo_us_MPORT_2_data_2 = ~_GEN_4 & update_lo_wdata_2;	// tage.scala:137:{8,21}, :167:44
  assign lo_us_MPORT_2_data_3 = ~_GEN_4 & update_lo_wdata_3;	// tage.scala:137:{8,21}, :167:44
  reg  [6:0]  wrbypass_tags_0;	// tage.scala:141:29
  reg  [6:0]  wrbypass_tags_1;	// tage.scala:141:29
  reg  [6:0]  wrbypass_idxs_0;	// tage.scala:142:29
  reg  [6:0]  wrbypass_idxs_1;	// tage.scala:142:29
  reg  [2:0]  wrbypass_0_0;	// tage.scala:143:29
  reg  [2:0]  wrbypass_0_1;	// tage.scala:143:29
  reg  [2:0]  wrbypass_0_2;	// tage.scala:143:29
  reg  [2:0]  wrbypass_0_3;	// tage.scala:143:29
  reg  [2:0]  wrbypass_1_0;	// tage.scala:143:29
  reg  [2:0]  wrbypass_1_1;	// tage.scala:143:29
  reg  [2:0]  wrbypass_1_2;	// tage.scala:143:29
  reg  [2:0]  wrbypass_1_3;	// tage.scala:143:29
  reg         wrbypass_enq_idx;	// tage.scala:144:33
  wire        wrbypass_hits_0 =
    ~doing_reset & wrbypass_tags_0 == update_wdata_3_tag & wrbypass_idxs_0 == update_idx;	// tage.scala:60:43, :62:64, :72:28, :100:83, :141:29, :142:29, :148:{22,37}, :149:22
  wire        wrbypass_hit =
    wrbypass_hits_0 | ~doing_reset & wrbypass_tags_1 == update_wdata_3_tag
    & wrbypass_idxs_1 == update_idx;	// tage.scala:60:43, :62:64, :72:28, :100:83, :141:29, :142:29, :148:{22,37}, :149:22, :151:48
  wire [2:0]  _GEN_5 = wrbypass_hits_0 ? wrbypass_0_0 : wrbypass_1_0;	// tage.scala:67:25, :143:29, :148:37
  wire [2:0]  _GEN_6 = wrbypass_hits_0 ? wrbypass_0_1 : wrbypass_1_1;	// tage.scala:67:25, :143:29, :148:37
  wire [2:0]  _GEN_7 = wrbypass_hits_0 ? wrbypass_0_2 : wrbypass_1_2;	// tage.scala:67:25, :143:29, :148:37
  wire [2:0]  _GEN_8 = wrbypass_hits_0 ? wrbypass_0_3 : wrbypass_1_3;	// tage.scala:67:25, :143:29, :148:37
  wire        _update_wdata_0_ctr_T_2 = _GEN_5 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_0_ctr_T_3 = _GEN_5 - 3'h1;	// tage.scala:67:{25,43}
  wire [2:0]  _update_wdata_0_ctr_T_7 = _GEN_5 + 3'h1;	// tage.scala:67:25, :68:43
  wire        _update_wdata_0_ctr_T_12 = io_update_old_ctr_0 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_0_ctr_T_13 = io_update_old_ctr_0 - 3'h1;	// tage.scala:67:43
  wire [2:0]  _update_wdata_0_ctr_T_17 = io_update_old_ctr_0 + 3'h1;	// tage.scala:68:43
  assign update_wdata_0_ctr =
    io_update_alloc_0
      ? (io_update_taken_0 ? 3'h4 : 3'h3)
      : wrbypass_hit
          ? (io_update_taken_0
               ? ((&_GEN_5) ? 3'h7 : _update_wdata_0_ctr_T_7)
               : _update_wdata_0_ctr_T_2 ? 3'h0 : _update_wdata_0_ctr_T_3)
          : io_update_taken_0
              ? ((&io_update_old_ctr_0) ? 3'h7 : _update_wdata_0_ctr_T_17)
              : _update_wdata_0_ctr_T_12 ? 3'h0 : _update_wdata_0_ctr_T_13;	// tage.scala:67:{8,20,25,43}, :68:{20,25,43}, :151:48, :155:33, :156:10, :159:10
  assign update_hi_wdata_0 = io_update_u_0[1];	// tage.scala:166:44
  assign update_lo_wdata_0 = io_update_u_0[0];	// tage.scala:167:44
  wire        _update_wdata_1_ctr_T_2 = _GEN_6 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_1_ctr_T_3 = _GEN_6 - 3'h1;	// tage.scala:67:{25,43}
  wire [2:0]  _update_wdata_1_ctr_T_7 = _GEN_6 + 3'h1;	// tage.scala:67:25, :68:43
  wire        _update_wdata_1_ctr_T_12 = io_update_old_ctr_1 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_1_ctr_T_13 = io_update_old_ctr_1 - 3'h1;	// tage.scala:67:43
  wire [2:0]  _update_wdata_1_ctr_T_17 = io_update_old_ctr_1 + 3'h1;	// tage.scala:68:43
  assign update_wdata_1_ctr =
    io_update_alloc_1
      ? (io_update_taken_1 ? 3'h4 : 3'h3)
      : wrbypass_hit
          ? (io_update_taken_1
               ? ((&_GEN_6) ? 3'h7 : _update_wdata_1_ctr_T_7)
               : _update_wdata_1_ctr_T_2 ? 3'h0 : _update_wdata_1_ctr_T_3)
          : io_update_taken_1
              ? ((&io_update_old_ctr_1) ? 3'h7 : _update_wdata_1_ctr_T_17)
              : _update_wdata_1_ctr_T_12 ? 3'h0 : _update_wdata_1_ctr_T_13;	// tage.scala:67:{8,20,25,43}, :68:{20,25,43}, :151:48, :155:33, :156:10, :159:10
  assign update_hi_wdata_1 = io_update_u_1[1];	// tage.scala:166:44
  assign update_lo_wdata_1 = io_update_u_1[0];	// tage.scala:167:44
  wire        _update_wdata_2_ctr_T_2 = _GEN_7 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_2_ctr_T_3 = _GEN_7 - 3'h1;	// tage.scala:67:{25,43}
  wire [2:0]  _update_wdata_2_ctr_T_7 = _GEN_7 + 3'h1;	// tage.scala:67:25, :68:43
  wire        _update_wdata_2_ctr_T_12 = io_update_old_ctr_2 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_2_ctr_T_13 = io_update_old_ctr_2 - 3'h1;	// tage.scala:67:43
  wire [2:0]  _update_wdata_2_ctr_T_17 = io_update_old_ctr_2 + 3'h1;	// tage.scala:68:43
  assign update_wdata_2_ctr =
    io_update_alloc_2
      ? (io_update_taken_2 ? 3'h4 : 3'h3)
      : wrbypass_hit
          ? (io_update_taken_2
               ? ((&_GEN_7) ? 3'h7 : _update_wdata_2_ctr_T_7)
               : _update_wdata_2_ctr_T_2 ? 3'h0 : _update_wdata_2_ctr_T_3)
          : io_update_taken_2
              ? ((&io_update_old_ctr_2) ? 3'h7 : _update_wdata_2_ctr_T_17)
              : _update_wdata_2_ctr_T_12 ? 3'h0 : _update_wdata_2_ctr_T_13;	// tage.scala:67:{8,20,25,43}, :68:{20,25,43}, :151:48, :155:33, :156:10, :159:10
  assign update_hi_wdata_2 = io_update_u_2[1];	// tage.scala:166:44
  assign update_lo_wdata_2 = io_update_u_2[0];	// tage.scala:167:44
  wire        _update_wdata_3_ctr_T_2 = _GEN_8 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_3_ctr_T_3 = _GEN_8 - 3'h1;	// tage.scala:67:{25,43}
  wire [2:0]  _update_wdata_3_ctr_T_7 = _GEN_8 + 3'h1;	// tage.scala:67:25, :68:43
  wire        _update_wdata_3_ctr_T_12 = io_update_old_ctr_3 == 3'h0;	// tage.scala:67:25
  wire [2:0]  _update_wdata_3_ctr_T_13 = io_update_old_ctr_3 - 3'h1;	// tage.scala:67:43
  wire [2:0]  _update_wdata_3_ctr_T_17 = io_update_old_ctr_3 + 3'h1;	// tage.scala:68:43
  assign update_wdata_3_ctr =
    io_update_alloc_3
      ? (io_update_taken_3 ? 3'h4 : 3'h3)
      : wrbypass_hit
          ? (io_update_taken_3
               ? ((&_GEN_8) ? 3'h7 : _update_wdata_3_ctr_T_7)
               : _update_wdata_3_ctr_T_2 ? 3'h0 : _update_wdata_3_ctr_T_3)
          : io_update_taken_3
              ? ((&io_update_old_ctr_3) ? 3'h7 : _update_wdata_3_ctr_T_17)
              : _update_wdata_3_ctr_T_12 ? 3'h0 : _update_wdata_3_ctr_T_13;	// tage.scala:67:{8,20,25,43}, :68:{20,25,43}, :151:48, :155:33, :156:10, :159:10
  assign update_hi_wdata_3 = io_update_u_3[1];	// tage.scala:166:44
  assign update_lo_wdata_3 = io_update_u_3[0];	// tage.scala:167:44
  always @(posedge clock) begin
    automatic logic _GEN_9;	// tage.scala:170:32
    automatic logic _GEN_10;	// tage.scala:141:29, :170:38, :171:39
    automatic logic _GEN_11;	// tage.scala:141:29, :170:38, :171:39
    _GEN_9 = io_update_mask_0 | io_update_mask_1 | io_update_mask_2 | io_update_mask_3;	// tage.scala:170:32
    _GEN_10 = ~_GEN_9 | wrbypass_hit | wrbypass_enq_idx;	// tage.scala:141:29, :144:33, :151:48, :170:{32,38}, :171:39
    _GEN_11 = ~_GEN_9 | wrbypass_hit | ~wrbypass_enq_idx;	// tage.scala:141:29, :144:33, :151:48, :170:{32,38}, :171:39, :175:39
    if (reset) begin
      doing_reset <= 1'h1;	// tage.scala:72:28
      reset_idx <= 7'h0;	// tage.scala:73:26
      clear_u_ctr <= 19'h0;	// tage.scala:109:28
      wrbypass_enq_idx <= 1'h0;	// tage.scala:75:50, :144:33
    end
    else begin
      doing_reset <= reset_idx != 7'h7F & doing_reset;	// tage.scala:72:28, :73:26, :75:{19,36,50}
      reset_idx <= reset_idx + {6'h0, doing_reset};	// tage.scala:72:28, :73:26, :74:26
      if (doing_reset)	// tage.scala:72:28
        clear_u_ctr <= 19'h1;	// tage.scala:109:28, :110:36
      else	// tage.scala:72:28
        clear_u_ctr <= clear_u_ctr + 19'h1;	// tage.scala:109:28, :110:{36,85}
      if (~_GEN_9 | wrbypass_hit) begin	// tage.scala:141:29, :144:33, :151:48, :170:{32,38}, :171:39
      end
      else	// tage.scala:144:33, :170:38, :171:39
        wrbypass_enq_idx <= wrbypass_enq_idx - 1'h1;	// tage.scala:144:33, util.scala:203:14
    end
    s2_tag <= {io_f1_req_pc[17:15], io_f1_req_pc[14:11] ^ io_f1_req_ghist[3:0]};	// frontend.scala:163:35, tage.scala:53:11, :62:{30,50,64}, :95:29
    io_f3_resp_0_valid_REG <=
      _table_ext_R0_data[10] & _table_ext_R0_data[9:3] == s2_tag & ~doing_reset;	// tage.scala:72:28, :91:27, :95:29, :97:87, :100:{69,80,83}, :104:38
    io_f3_resp_0_bits_u_REG <= {_hi_us_ext_R0_data[0], _lo_us_ext_R0_data[0]};	// Cat.scala:30:58, tage.scala:89:27, :90:27, :105:38
    io_f3_resp_0_bits_ctr_REG <= _table_ext_R0_data[2:0];	// tage.scala:91:27, :97:87, :106:38
    io_f3_resp_1_valid_REG <=
      _table_ext_R0_data[21] & _table_ext_R0_data[20:14] == s2_tag & ~doing_reset;	// tage.scala:72:28, :91:27, :95:29, :97:87, :100:{69,80,83}, :104:38
    io_f3_resp_1_bits_u_REG <= {_hi_us_ext_R0_data[1], _lo_us_ext_R0_data[1]};	// Cat.scala:30:58, tage.scala:89:27, :90:27, :105:38
    io_f3_resp_1_bits_ctr_REG <= _table_ext_R0_data[13:11];	// tage.scala:91:27, :97:87, :106:38
    io_f3_resp_2_valid_REG <=
      _table_ext_R0_data[32] & _table_ext_R0_data[31:25] == s2_tag & ~doing_reset;	// tage.scala:72:28, :91:27, :95:29, :97:87, :100:{69,80,83}, :104:38
    io_f3_resp_2_bits_u_REG <= {_hi_us_ext_R0_data[2], _lo_us_ext_R0_data[2]};	// Cat.scala:30:58, tage.scala:89:27, :90:27, :105:38
    io_f3_resp_2_bits_ctr_REG <= _table_ext_R0_data[24:22];	// tage.scala:91:27, :97:87, :106:38
    io_f3_resp_3_valid_REG <=
      _table_ext_R0_data[43] & _table_ext_R0_data[42:36] == s2_tag & ~doing_reset;	// tage.scala:72:28, :91:27, :95:29, :97:87, :100:{69,80,83}, :104:38
    io_f3_resp_3_bits_u_REG <= {_hi_us_ext_R0_data[3], _lo_us_ext_R0_data[3]};	// Cat.scala:30:58, tage.scala:89:27, :90:27, :105:38
    io_f3_resp_3_bits_ctr_REG <= _table_ext_R0_data[35:33];	// tage.scala:91:27, :97:87, :106:38
    if (_GEN_10) begin	// tage.scala:141:29, :170:38, :171:39
    end
    else	// tage.scala:141:29, :170:38, :171:39
      wrbypass_tags_0 <= update_wdata_3_tag;	// tage.scala:62:64, :141:29
    if (_GEN_11) begin	// tage.scala:141:29, :170:38, :171:39
    end
    else	// tage.scala:141:29, :170:38, :171:39
      wrbypass_tags_1 <= update_wdata_3_tag;	// tage.scala:62:64, :141:29
    if (_GEN_10) begin	// tage.scala:141:29, :142:29, :170:38, :171:39
    end
    else	// tage.scala:142:29, :170:38, :171:39
      wrbypass_idxs_0 <= update_idx;	// tage.scala:60:43, :142:29
    if (_GEN_11) begin	// tage.scala:141:29, :142:29, :170:38, :171:39
    end
    else	// tage.scala:142:29, :170:38, :171:39
      wrbypass_idxs_1 <= update_idx;	// tage.scala:60:43, :142:29
    if (_GEN_9) begin	// tage.scala:170:32
      if (wrbypass_hit) begin	// tage.scala:151:48
        if (wrbypass_hits_0) begin	// tage.scala:148:37
          if (io_update_alloc_0) begin
            if (io_update_taken_0)
              wrbypass_0_0 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_0_0 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_0) begin
              if (&_GEN_5)	// tage.scala:67:25, :68:25
                wrbypass_0_0 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_0_0 <= _update_wdata_0_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_0_ctr_T_2)	// tage.scala:67:25
              wrbypass_0_0 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_0_0 <= _update_wdata_0_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_0) begin
            if (&io_update_old_ctr_0)	// tage.scala:68:25
              wrbypass_0_0 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_0 <= _update_wdata_0_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_0_ctr_T_12)	// tage.scala:67:25
            wrbypass_0_0 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_0 <= _update_wdata_0_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_1) begin
            if (io_update_taken_1)
              wrbypass_0_1 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_0_1 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_1) begin
              if (&_GEN_6)	// tage.scala:67:25, :68:25
                wrbypass_0_1 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_0_1 <= _update_wdata_1_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_1_ctr_T_2)	// tage.scala:67:25
              wrbypass_0_1 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_0_1 <= _update_wdata_1_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_1) begin
            if (&io_update_old_ctr_1)	// tage.scala:68:25
              wrbypass_0_1 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_1 <= _update_wdata_1_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_1_ctr_T_12)	// tage.scala:67:25
            wrbypass_0_1 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_1 <= _update_wdata_1_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_2) begin
            if (io_update_taken_2)
              wrbypass_0_2 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_0_2 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_2) begin
              if (&_GEN_7)	// tage.scala:67:25, :68:25
                wrbypass_0_2 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_0_2 <= _update_wdata_2_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_2_ctr_T_2)	// tage.scala:67:25
              wrbypass_0_2 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_0_2 <= _update_wdata_2_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_2) begin
            if (&io_update_old_ctr_2)	// tage.scala:68:25
              wrbypass_0_2 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_2 <= _update_wdata_2_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_2_ctr_T_12)	// tage.scala:67:25
            wrbypass_0_2 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_2 <= _update_wdata_2_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_3) begin
            if (io_update_taken_3)
              wrbypass_0_3 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_0_3 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_3) begin
              if (&_GEN_8)	// tage.scala:67:25, :68:25
                wrbypass_0_3 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_0_3 <= _update_wdata_3_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_3_ctr_T_2)	// tage.scala:67:25
              wrbypass_0_3 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_0_3 <= _update_wdata_3_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_3) begin
            if (&io_update_old_ctr_3)	// tage.scala:68:25
              wrbypass_0_3 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_3 <= _update_wdata_3_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_3_ctr_T_12)	// tage.scala:67:25
            wrbypass_0_3 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_3 <= _update_wdata_3_ctr_T_13;	// tage.scala:67:43, :143:29
        end
        else begin	// tage.scala:148:37
          if (io_update_alloc_0) begin
            if (io_update_taken_0)
              wrbypass_1_0 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_1_0 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_0) begin
              if (&_GEN_5)	// tage.scala:67:25, :68:25
                wrbypass_1_0 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_1_0 <= _update_wdata_0_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_0_ctr_T_2)	// tage.scala:67:25
              wrbypass_1_0 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_1_0 <= _update_wdata_0_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_0) begin
            if (&io_update_old_ctr_0)	// tage.scala:68:25
              wrbypass_1_0 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_0 <= _update_wdata_0_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_0_ctr_T_12)	// tage.scala:67:25
            wrbypass_1_0 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_0 <= _update_wdata_0_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_1) begin
            if (io_update_taken_1)
              wrbypass_1_1 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_1_1 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_1) begin
              if (&_GEN_6)	// tage.scala:67:25, :68:25
                wrbypass_1_1 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_1_1 <= _update_wdata_1_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_1_ctr_T_2)	// tage.scala:67:25
              wrbypass_1_1 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_1_1 <= _update_wdata_1_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_1) begin
            if (&io_update_old_ctr_1)	// tage.scala:68:25
              wrbypass_1_1 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_1 <= _update_wdata_1_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_1_ctr_T_12)	// tage.scala:67:25
            wrbypass_1_1 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_1 <= _update_wdata_1_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_2) begin
            if (io_update_taken_2)
              wrbypass_1_2 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_1_2 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_2) begin
              if (&_GEN_7)	// tage.scala:67:25, :68:25
                wrbypass_1_2 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_1_2 <= _update_wdata_2_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_2_ctr_T_2)	// tage.scala:67:25
              wrbypass_1_2 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_1_2 <= _update_wdata_2_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_2) begin
            if (&io_update_old_ctr_2)	// tage.scala:68:25
              wrbypass_1_2 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_2 <= _update_wdata_2_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_2_ctr_T_12)	// tage.scala:67:25
            wrbypass_1_2 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_2 <= _update_wdata_2_ctr_T_13;	// tage.scala:67:43, :143:29
          if (io_update_alloc_3) begin
            if (io_update_taken_3)
              wrbypass_1_3 <= 3'h4;	// tage.scala:143:29
            else
              wrbypass_1_3 <= 3'h3;	// tage.scala:143:29, :156:10
          end
          else if (wrbypass_hit) begin	// tage.scala:151:48
            if (io_update_taken_3) begin
              if (&_GEN_8)	// tage.scala:67:25, :68:25
                wrbypass_1_3 <= 3'h7;	// tage.scala:68:25, :143:29
              else	// tage.scala:68:25
                wrbypass_1_3 <= _update_wdata_3_ctr_T_7;	// tage.scala:68:43, :143:29
            end
            else if (_update_wdata_3_ctr_T_2)	// tage.scala:67:25
              wrbypass_1_3 <= 3'h0;	// tage.scala:143:29
            else	// tage.scala:67:25
              wrbypass_1_3 <= _update_wdata_3_ctr_T_3;	// tage.scala:67:43, :143:29
          end
          else if (io_update_taken_3) begin
            if (&io_update_old_ctr_3)	// tage.scala:68:25
              wrbypass_1_3 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_3 <= _update_wdata_3_ctr_T_17;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_3_ctr_T_12)	// tage.scala:67:25
            wrbypass_1_3 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_3 <= _update_wdata_3_ctr_T_13;	// tage.scala:67:43, :143:29
        end
      end
      else if (wrbypass_enq_idx) begin	// tage.scala:144:33
        if (io_update_alloc_0) begin
          if (io_update_taken_0)
            wrbypass_1_0 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_1_0 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_0) begin
            if (&_GEN_5)	// tage.scala:67:25, :68:25
              wrbypass_1_0 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_0 <= _update_wdata_0_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_0_ctr_T_2)	// tage.scala:67:25
            wrbypass_1_0 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_0 <= _update_wdata_0_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_0) begin
          if (&io_update_old_ctr_0)	// tage.scala:68:25
            wrbypass_1_0 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_1_0 <= _update_wdata_0_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_0_ctr_T_12)	// tage.scala:67:25
          wrbypass_1_0 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_1_0 <= _update_wdata_0_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_1) begin
          if (io_update_taken_1)
            wrbypass_1_1 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_1_1 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_1) begin
            if (&_GEN_6)	// tage.scala:67:25, :68:25
              wrbypass_1_1 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_1 <= _update_wdata_1_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_1_ctr_T_2)	// tage.scala:67:25
            wrbypass_1_1 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_1 <= _update_wdata_1_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_1) begin
          if (&io_update_old_ctr_1)	// tage.scala:68:25
            wrbypass_1_1 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_1_1 <= _update_wdata_1_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_1_ctr_T_12)	// tage.scala:67:25
          wrbypass_1_1 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_1_1 <= _update_wdata_1_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_2) begin
          if (io_update_taken_2)
            wrbypass_1_2 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_1_2 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_2) begin
            if (&_GEN_7)	// tage.scala:67:25, :68:25
              wrbypass_1_2 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_2 <= _update_wdata_2_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_2_ctr_T_2)	// tage.scala:67:25
            wrbypass_1_2 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_2 <= _update_wdata_2_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_2) begin
          if (&io_update_old_ctr_2)	// tage.scala:68:25
            wrbypass_1_2 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_1_2 <= _update_wdata_2_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_2_ctr_T_12)	// tage.scala:67:25
          wrbypass_1_2 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_1_2 <= _update_wdata_2_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_3) begin
          if (io_update_taken_3)
            wrbypass_1_3 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_1_3 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_3) begin
            if (&_GEN_8)	// tage.scala:67:25, :68:25
              wrbypass_1_3 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_1_3 <= _update_wdata_3_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_3_ctr_T_2)	// tage.scala:67:25
            wrbypass_1_3 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_1_3 <= _update_wdata_3_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_3) begin
          if (&io_update_old_ctr_3)	// tage.scala:68:25
            wrbypass_1_3 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_1_3 <= _update_wdata_3_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_3_ctr_T_12)	// tage.scala:67:25
          wrbypass_1_3 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_1_3 <= _update_wdata_3_ctr_T_13;	// tage.scala:67:43, :143:29
      end
      else begin	// tage.scala:144:33
        if (io_update_alloc_0) begin
          if (io_update_taken_0)
            wrbypass_0_0 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_0_0 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_0) begin
            if (&_GEN_5)	// tage.scala:67:25, :68:25
              wrbypass_0_0 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_0 <= _update_wdata_0_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_0_ctr_T_2)	// tage.scala:67:25
            wrbypass_0_0 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_0 <= _update_wdata_0_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_0) begin
          if (&io_update_old_ctr_0)	// tage.scala:68:25
            wrbypass_0_0 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_0_0 <= _update_wdata_0_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_0_ctr_T_12)	// tage.scala:67:25
          wrbypass_0_0 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_0_0 <= _update_wdata_0_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_1) begin
          if (io_update_taken_1)
            wrbypass_0_1 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_0_1 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_1) begin
            if (&_GEN_6)	// tage.scala:67:25, :68:25
              wrbypass_0_1 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_1 <= _update_wdata_1_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_1_ctr_T_2)	// tage.scala:67:25
            wrbypass_0_1 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_1 <= _update_wdata_1_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_1) begin
          if (&io_update_old_ctr_1)	// tage.scala:68:25
            wrbypass_0_1 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_0_1 <= _update_wdata_1_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_1_ctr_T_12)	// tage.scala:67:25
          wrbypass_0_1 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_0_1 <= _update_wdata_1_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_2) begin
          if (io_update_taken_2)
            wrbypass_0_2 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_0_2 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_2) begin
            if (&_GEN_7)	// tage.scala:67:25, :68:25
              wrbypass_0_2 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_2 <= _update_wdata_2_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_2_ctr_T_2)	// tage.scala:67:25
            wrbypass_0_2 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_2 <= _update_wdata_2_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_2) begin
          if (&io_update_old_ctr_2)	// tage.scala:68:25
            wrbypass_0_2 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_0_2 <= _update_wdata_2_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_2_ctr_T_12)	// tage.scala:67:25
          wrbypass_0_2 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_0_2 <= _update_wdata_2_ctr_T_13;	// tage.scala:67:43, :143:29
        if (io_update_alloc_3) begin
          if (io_update_taken_3)
            wrbypass_0_3 <= 3'h4;	// tage.scala:143:29
          else
            wrbypass_0_3 <= 3'h3;	// tage.scala:143:29, :156:10
        end
        else if (wrbypass_hit) begin	// tage.scala:151:48
          if (io_update_taken_3) begin
            if (&_GEN_8)	// tage.scala:67:25, :68:25
              wrbypass_0_3 <= 3'h7;	// tage.scala:68:25, :143:29
            else	// tage.scala:68:25
              wrbypass_0_3 <= _update_wdata_3_ctr_T_7;	// tage.scala:68:43, :143:29
          end
          else if (_update_wdata_3_ctr_T_2)	// tage.scala:67:25
            wrbypass_0_3 <= 3'h0;	// tage.scala:143:29
          else	// tage.scala:67:25
            wrbypass_0_3 <= _update_wdata_3_ctr_T_3;	// tage.scala:67:43, :143:29
        end
        else if (io_update_taken_3) begin
          if (&io_update_old_ctr_3)	// tage.scala:68:25
            wrbypass_0_3 <= 3'h7;	// tage.scala:68:25, :143:29
          else	// tage.scala:68:25
            wrbypass_0_3 <= _update_wdata_3_ctr_T_17;	// tage.scala:68:43, :143:29
        end
        else if (_update_wdata_3_ctr_T_12)	// tage.scala:67:25
          wrbypass_0_3 <= 3'h0;	// tage.scala:143:29
        else	// tage.scala:67:25
          wrbypass_0_3 <= _update_wdata_3_ctr_T_13;	// tage.scala:67:43, :143:29
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:3];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        doing_reset = _RANDOM[2'h0][0];	// tage.scala:72:28
        reset_idx = _RANDOM[2'h0][7:1];	// tage.scala:72:28, :73:26
        s2_tag = _RANDOM[2'h0][14:8];	// tage.scala:72:28, :95:29
        io_f3_resp_0_valid_REG = _RANDOM[2'h0][15];	// tage.scala:72:28, :104:38
        io_f3_resp_0_bits_u_REG = _RANDOM[2'h0][17:16];	// tage.scala:72:28, :105:38
        io_f3_resp_0_bits_ctr_REG = _RANDOM[2'h0][20:18];	// tage.scala:72:28, :106:38
        io_f3_resp_1_valid_REG = _RANDOM[2'h0][21];	// tage.scala:72:28, :104:38
        io_f3_resp_1_bits_u_REG = _RANDOM[2'h0][23:22];	// tage.scala:72:28, :105:38
        io_f3_resp_1_bits_ctr_REG = _RANDOM[2'h0][26:24];	// tage.scala:72:28, :106:38
        io_f3_resp_2_valid_REG = _RANDOM[2'h0][27];	// tage.scala:72:28, :104:38
        io_f3_resp_2_bits_u_REG = _RANDOM[2'h0][29:28];	// tage.scala:72:28, :105:38
        io_f3_resp_2_bits_ctr_REG = {_RANDOM[2'h0][31:30], _RANDOM[2'h1][0]};	// tage.scala:72:28, :106:38
        io_f3_resp_3_valid_REG = _RANDOM[2'h1][1];	// tage.scala:104:38, :106:38
        io_f3_resp_3_bits_u_REG = _RANDOM[2'h1][3:2];	// tage.scala:105:38, :106:38
        io_f3_resp_3_bits_ctr_REG = _RANDOM[2'h1][6:4];	// tage.scala:106:38
        clear_u_ctr = _RANDOM[2'h1][25:7];	// tage.scala:106:38, :109:28
        wrbypass_tags_0 = {_RANDOM[2'h1][31:26], _RANDOM[2'h2][0]};	// tage.scala:106:38, :141:29
        wrbypass_tags_1 = _RANDOM[2'h2][7:1];	// tage.scala:141:29
        wrbypass_idxs_0 = _RANDOM[2'h2][14:8];	// tage.scala:141:29, :142:29
        wrbypass_idxs_1 = _RANDOM[2'h2][21:15];	// tage.scala:141:29, :142:29
        wrbypass_0_0 = _RANDOM[2'h2][24:22];	// tage.scala:141:29, :143:29
        wrbypass_0_1 = _RANDOM[2'h2][27:25];	// tage.scala:141:29, :143:29
        wrbypass_0_2 = _RANDOM[2'h2][30:28];	// tage.scala:141:29, :143:29
        wrbypass_0_3 = {_RANDOM[2'h2][31], _RANDOM[2'h3][1:0]};	// tage.scala:141:29, :143:29
        wrbypass_1_0 = _RANDOM[2'h3][4:2];	// tage.scala:143:29
        wrbypass_1_1 = _RANDOM[2'h3][7:5];	// tage.scala:143:29
        wrbypass_1_2 = _RANDOM[2'h3][10:8];	// tage.scala:143:29
        wrbypass_1_3 = _RANDOM[2'h3][13:11];	// tage.scala:143:29
        wrbypass_enq_idx = _RANDOM[2'h3][14];	// tage.scala:143:29, :144:33
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  mem_128x4 hi_us_ext (	// tage.scala:89:27
    .R0_addr (_s2_req_rlous_T_1),	// tage.scala:60:43
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (doing_reset ? reset_idx : doing_clear_u_hi ? clear_u_ctr[17:11] : _GEN_1),	// tage.scala:72:28, :73:26, :109:28, :113:40, :115:33, :129:{8,36}
    .W0_en   (1'h1),
    .W0_clk  (clock),
    .W0_data
      ({hi_us_MPORT_1_data_3,
        hi_us_MPORT_1_data_2,
        hi_us_MPORT_1_data_1,
        hi_us_MPORT_1_data_0}),	// tage.scala:89:27, :130:8
    .W0_mask (_GEN_2 ? 4'hF : _GEN_3),	// tage.scala:124:22, :130:21, :131:{8,80}
    .R0_data (_hi_us_ext_R0_data)
  );
  mem_128x4 lo_us_ext (	// tage.scala:90:27
    .R0_addr (_s2_req_rlous_T_1),	// tage.scala:60:43
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (doing_reset ? reset_idx : doing_clear_u_lo ? clear_u_ctr[17:11] : _GEN_1),	// tage.scala:72:28, :73:26, :109:28, :114:40, :115:33, :129:36, :136:{8,36}
    .W0_en   (1'h1),
    .W0_clk  (clock),
    .W0_data
      ({lo_us_MPORT_2_data_3,
        lo_us_MPORT_2_data_2,
        lo_us_MPORT_2_data_1,
        lo_us_MPORT_2_data_0}),	// tage.scala:90:27, :137:8
    .W0_mask (_GEN_4 ? 4'hF : _GEN_3),	// tage.scala:124:22, :131:80, :137:21, :138:8
    .R0_data (_lo_us_ext_R0_data)
  );
  table_128x44 table_ext (	// tage.scala:91:27
    .R0_addr (_s2_req_rlous_T_1),	// tage.scala:60:43
    .R0_en   (io_f1_req_valid),
    .R0_clk  (clock),
    .W0_addr (doing_reset ? reset_idx : update_idx),	// tage.scala:60:43, :72:28, :73:26, :122:8
    .W0_en   (1'h1),
    .W0_clk  (clock),
    .W0_data
      ({table_MPORT_data_3, table_MPORT_data_2, table_MPORT_data_1, table_MPORT_data_0}),	// tage.scala:91:27, :123:8
    .W0_mask
      (doing_reset
         ? 4'hF
         : {io_update_mask_3, io_update_mask_2, io_update_mask_1, io_update_mask_0}),	// tage.scala:72:28, :124:{8,22,90}
    .R0_data (_table_ext_R0_data)
  );
  assign io_f3_resp_0_valid = io_f3_resp_0_valid_REG;	// tage.scala:104:38
  assign io_f3_resp_0_bits_ctr = io_f3_resp_0_bits_ctr_REG;	// tage.scala:106:38
  assign io_f3_resp_0_bits_u = io_f3_resp_0_bits_u_REG;	// tage.scala:105:38
  assign io_f3_resp_1_valid = io_f3_resp_1_valid_REG;	// tage.scala:104:38
  assign io_f3_resp_1_bits_ctr = io_f3_resp_1_bits_ctr_REG;	// tage.scala:106:38
  assign io_f3_resp_1_bits_u = io_f3_resp_1_bits_u_REG;	// tage.scala:105:38
  assign io_f3_resp_2_valid = io_f3_resp_2_valid_REG;	// tage.scala:104:38
  assign io_f3_resp_2_bits_ctr = io_f3_resp_2_bits_ctr_REG;	// tage.scala:106:38
  assign io_f3_resp_2_bits_u = io_f3_resp_2_bits_u_REG;	// tage.scala:105:38
  assign io_f3_resp_3_valid = io_f3_resp_3_valid_REG;	// tage.scala:104:38
  assign io_f3_resp_3_bits_ctr = io_f3_resp_3_bits_ctr_REG;	// tage.scala:106:38
  assign io_f3_resp_3_bits_u = io_f3_resp_3_bits_u_REG;	// tage.scala:105:38
endmodule

