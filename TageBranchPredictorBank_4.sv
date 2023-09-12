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

module TageBranchPredictorBank_4(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input  [63:0]  io_f1_ghist,
  input          io_resp_in_0_f3_0_taken,
                 io_resp_in_0_f3_1_taken,
                 io_resp_in_0_f3_2_taken,
                 io_resp_in_0_f3_3_taken,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_mispredicted,
  input  [63:0]  io_update_bits_ghist,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f3_0_taken,
                 io_resp_f3_1_taken,
                 io_resp_f3_2_taken,
                 io_resp_f3_3_taken,
  output [119:0] io_f3_meta
);

  wire            _alloc_lfsr_prng_3_io_out_0;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_3_io_out_1;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_3_io_out_2;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_3_io_out_3;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_3_io_out_4;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_3_io_out_5;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_0;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_1;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_2;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_3;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_4;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_2_io_out_5;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_0;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_1;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_2;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_3;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_4;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_1_io_out_5;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_0;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_1;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_2;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_3;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_4;	// PRNG.scala:82:22
  wire            _alloc_lfsr_prng_io_out_5;	// PRNG.scala:82:22
  wire            _tables_5_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_5_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_5_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_5_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_5_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_5_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_5_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_5_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_5_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_5_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_5_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_5_io_f3_resp_3_bits_u;	// tage.scala:224:21
  wire            _tables_4_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_4_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_4_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_4_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_4_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_4_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_4_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_4_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_4_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_4_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_4_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_4_io_f3_resp_3_bits_u;	// tage.scala:224:21
  wire            _tables_3_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_3_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_3_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_3_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_3_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_3_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_3_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_3_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_3_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_3_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_3_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_3_io_f3_resp_3_bits_u;	// tage.scala:224:21
  wire            _tables_2_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_2_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_2_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_2_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_2_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_2_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_2_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_2_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_2_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_2_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_2_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_2_io_f3_resp_3_bits_u;	// tage.scala:224:21
  wire            _tables_1_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_1_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_1_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_1_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_1_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_1_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_1_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_1_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_1_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_1_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_1_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_1_io_f3_resp_3_bits_u;	// tage.scala:224:21
  wire            _tables_0_io_f3_resp_0_valid;	// tage.scala:224:21
  wire [2:0]      _tables_0_io_f3_resp_0_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_0_io_f3_resp_0_bits_u;	// tage.scala:224:21
  wire            _tables_0_io_f3_resp_1_valid;	// tage.scala:224:21
  wire [2:0]      _tables_0_io_f3_resp_1_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_0_io_f3_resp_1_bits_u;	// tage.scala:224:21
  wire            _tables_0_io_f3_resp_2_valid;	// tage.scala:224:21
  wire [2:0]      _tables_0_io_f3_resp_2_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_0_io_f3_resp_2_bits_u;	// tage.scala:224:21
  wire            _tables_0_io_f3_resp_3_valid;	// tage.scala:224:21
  wire [2:0]      _tables_0_io_f3_resp_3_bits_ctr;	// tage.scala:224:21
  wire [1:0]      _tables_0_io_f3_resp_3_bits_u;	// tage.scala:224:21
  reg             s1_update_valid;	// predictor.scala:184:30
  reg             s1_update_bits_is_mispredict_update;	// predictor.scala:184:30
  reg             s1_update_bits_is_repair_update;	// predictor.scala:184:30
  reg  [3:0]      s1_update_bits_btb_mispredicts;	// predictor.scala:184:30
  reg  [39:0]     s1_update_bits_pc;	// predictor.scala:184:30
  reg  [3:0]      s1_update_bits_br_mask;	// predictor.scala:184:30
  reg             s1_update_bits_cfi_idx_valid;	// predictor.scala:184:30
  reg  [1:0]      s1_update_bits_cfi_idx_bits;	// predictor.scala:184:30
  reg             s1_update_bits_cfi_taken;	// predictor.scala:184:30
  reg             s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30
  reg  [63:0]     s1_update_bits_ghist;	// predictor.scala:184:30
  reg  [119:0]    s1_update_bits_meta;	// predictor.scala:184:30
  reg             t_io_f1_req_valid_REG;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG;	// tage.scala:226:35
  reg             t_io_f1_req_valid_REG_1;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG_1;	// tage.scala:226:35
  reg             t_io_f1_req_valid_REG_2;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG_2;	// tage.scala:226:35
  reg             t_io_f1_req_valid_REG_3;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG_3;	// tage.scala:226:35
  reg             t_io_f1_req_valid_REG_4;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG_4;	// tage.scala:226:35
  reg             t_io_f1_req_valid_REG_5;	// tage.scala:225:35
  reg  [39:0]     t_io_f1_req_pc_REG_5;	// tage.scala:226:35
  wire            _GEN =
    _tables_0_io_f3_resp_0_valid
      ? _tables_0_io_f3_resp_0_bits_ctr[2]
      : io_resp_in_0_f3_0_taken;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_0 =
    _tables_1_io_f3_resp_0_valid ? _tables_1_io_f3_resp_0_bits_ctr[2] : _GEN;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_1 =
    _tables_2_io_f3_resp_0_valid ? _tables_2_io_f3_resp_0_bits_ctr[2] : _GEN_0;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_2 =
    _tables_3_io_f3_resp_0_valid ? _tables_3_io_f3_resp_0_bits_ctr[2] : _GEN_1;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_3 =
    _tables_4_io_f3_resp_0_valid ? _tables_4_io_f3_resp_0_bits_ctr[2] : _GEN_2;	// tage.scala:224:21, :271:{21,50}
  wire            _io_resp_f3_0_taken_output =
    _tables_5_io_f3_resp_0_valid
      ? (_tables_5_io_f3_resp_0_bits_ctr == 3'h3 | _tables_5_io_f3_resp_0_bits_ctr == 3'h4
           ? _GEN_3
           : _tables_5_io_f3_resp_0_bits_ctr[2])
      : _tables_4_io_f3_resp_0_valid
          ? (_tables_4_io_f3_resp_0_bits_ctr == 3'h3
             | _tables_4_io_f3_resp_0_bits_ctr == 3'h4
               ? _GEN_2
               : _tables_4_io_f3_resp_0_bits_ctr[2])
          : _tables_3_io_f3_resp_0_valid
              ? (_tables_3_io_f3_resp_0_bits_ctr == 3'h3
                 | _tables_3_io_f3_resp_0_bits_ctr == 3'h4
                   ? _GEN_1
                   : _tables_3_io_f3_resp_0_bits_ctr[2])
              : _tables_2_io_f3_resp_0_valid
                  ? (_tables_2_io_f3_resp_0_bits_ctr == 3'h3
                     | _tables_2_io_f3_resp_0_bits_ctr == 3'h4
                       ? _GEN_0
                       : _tables_2_io_f3_resp_0_bits_ctr[2])
                  : _tables_1_io_f3_resp_0_valid
                      ? (_tables_1_io_f3_resp_0_bits_ctr == 3'h3
                         | _tables_1_io_f3_resp_0_bits_ctr == 3'h4
                           ? _GEN
                           : _tables_1_io_f3_resp_0_bits_ctr[2])
                      : ~_tables_0_io_f3_resp_0_valid
                        | _tables_0_io_f3_resp_0_bits_ctr == 3'h3
                        | _tables_0_io_f3_resp_0_bits_ctr == 3'h4
                          ? io_resp_in_0_f3_0_taken
                          : _tables_0_io_f3_resp_0_bits_ctr[2];	// tage.scala:224:21, :259:25, :264:18, :265:{29,35,40,48,55,76}, :271:21, :303:37
  wire            f3_meta_provider_0_valid =
    _tables_0_io_f3_resp_0_valid | _tables_1_io_f3_resp_0_valid
    | _tables_2_io_f3_resp_0_valid | _tables_3_io_f3_resp_0_valid
    | _tables_4_io_f3_resp_0_valid | _tables_5_io_f3_resp_0_valid;	// tage.scala:224:21, :269:27
  wire [2:0]      f3_meta_provider_0_bits =
    _tables_5_io_f3_resp_0_valid
      ? 3'h5
      : _tables_4_io_f3_resp_0_valid
          ? 3'h4
          : {1'h0,
             _tables_3_io_f3_resp_0_valid
               ? 2'h3
               : _tables_2_io_f3_resp_0_valid
                   ? 2'h2
                   : {1'h0, _tables_1_io_f3_resp_0_valid}};	// predictor.scala:160:14, tage.scala:224:21, :265:{40,55}, :270:21
  wire [7:0][2:0] _GEN_4 =
    {{_tables_0_io_f3_resp_0_bits_ctr},
     {_tables_0_io_f3_resp_0_bits_ctr},
     {_tables_5_io_f3_resp_0_bits_ctr},
     {_tables_4_io_f3_resp_0_bits_ctr},
     {_tables_3_io_f3_resp_0_bits_ctr},
     {_tables_2_io_f3_resp_0_bits_ctr},
     {_tables_1_io_f3_resp_0_bits_ctr},
     {_tables_0_io_f3_resp_0_bits_ctr}};	// tage.scala:224:21, :276:31
  wire [7:0][1:0] _GEN_5 =
    {{_tables_0_io_f3_resp_0_bits_u},
     {_tables_0_io_f3_resp_0_bits_u},
     {_tables_5_io_f3_resp_0_bits_u},
     {_tables_4_io_f3_resp_0_bits_u},
     {_tables_3_io_f3_resp_0_bits_u},
     {_tables_2_io_f3_resp_0_bits_u},
     {_tables_1_io_f3_resp_0_bits_u},
     {_tables_0_io_f3_resp_0_bits_u}};	// tage.scala:224:21, :276:31
  wire [7:0]      _allocatable_slots_T_20 = 8'h1 << f3_meta_provider_0_bits;	// OneHot.scala:58:35, tage.scala:270:21
  wire [5:0]      _GEN_6 =
    _allocatable_slots_T_20[5:0] | _allocatable_slots_T_20[6:1]
    | _allocatable_slots_T_20[7:2];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [4:0]      _GEN_7 = _GEN_6[4:0] | _allocatable_slots_T_20[7:3];	// OneHot.scala:58:35, tage.scala:265:40, :270:21, util.scala:373:{29,45}
  wire [3:0]      _GEN_8 = _GEN_7[3:0] | _allocatable_slots_T_20[7:4];	// OneHot.scala:58:35, tage.scala:265:{40,55}, util.scala:373:{29,45}
  wire [2:0]      _GEN_9 = _GEN_8[2:0] | _allocatable_slots_T_20[7:5];	// OneHot.scala:58:35, tage.scala:265:55, :270:21, util.scala:373:{29,45}
  wire [1:0]      _GEN_10 = _GEN_9[1:0] | _allocatable_slots_T_20[7:6];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [5:0]      _GEN_11 =
    ~({_GEN_6[5],
       _GEN_7[4],
       _GEN_8[3],
       _GEN_9[2],
       _GEN_10[1],
       _GEN_10[0] | (&f3_meta_provider_0_bits)} & {6{f3_meta_provider_0_valid}})
    & {~_tables_5_io_f3_resp_0_valid & _tables_5_io_f3_resp_0_bits_u == 2'h0,
       ~_tables_4_io_f3_resp_0_valid & _tables_4_io_f3_resp_0_bits_u == 2'h0,
       ~_tables_3_io_f3_resp_0_valid & _tables_3_io_f3_resp_0_bits_u == 2'h0,
       ~_tables_2_io_f3_resp_0_valid & _tables_2_io_f3_resp_0_bits_u == 2'h0,
       ~_tables_1_io_f3_resp_0_valid & _tables_1_io_f3_resp_0_bits_u == 2'h0,
       ~_tables_0_io_f3_resp_0_valid & _tables_0_io_f3_resp_0_bits_u == 2'h0};	// Bitwise.scala:72:12, tage.scala:224:21, :265:{40,55}, :269:27, :270:21, :282:{33,45,60,70,77}, :283:{7,39}, :321:43, util.scala:373:{29,45}
  wire [5:0]      _GEN_12 =
    _GEN_11
    & {_alloc_lfsr_prng_io_out_5,
       _alloc_lfsr_prng_io_out_4,
       _alloc_lfsr_prng_io_out_3,
       _alloc_lfsr_prng_io_out_2,
       _alloc_lfsr_prng_io_out_1,
       _alloc_lfsr_prng_io_out_0};	// PRNG.scala:82:22, :86:17, tage.scala:282:77, :288:58
  wire [2:0]      masked_entry =
    _GEN_12[0]
      ? 3'h0
      : _GEN_12[1]
          ? 3'h1
          : _GEN_12[2]
              ? 3'h2
              : _GEN_12[3] ? 3'h3 : _GEN_12[4] ? 3'h4 : {1'h1, ~(_GEN_12[5]), 1'h1};	// Mux.scala:47:69, OneHot.scala:47:40, :58:35, tage.scala:265:55, :288:58, :303:37
  wire [7:0]      _alloc_entry_T = {2'h0, _GEN_11} >> masked_entry;	// Mux.scala:47:69, tage.scala:282:77, :289:44, :321:43
  wire            _GEN_13 =
    _tables_0_io_f3_resp_1_valid
      ? _tables_0_io_f3_resp_1_bits_ctr[2]
      : io_resp_in_0_f3_1_taken;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_14 =
    _tables_1_io_f3_resp_1_valid ? _tables_1_io_f3_resp_1_bits_ctr[2] : _GEN_13;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_15 =
    _tables_2_io_f3_resp_1_valid ? _tables_2_io_f3_resp_1_bits_ctr[2] : _GEN_14;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_16 =
    _tables_3_io_f3_resp_1_valid ? _tables_3_io_f3_resp_1_bits_ctr[2] : _GEN_15;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_17 =
    _tables_4_io_f3_resp_1_valid ? _tables_4_io_f3_resp_1_bits_ctr[2] : _GEN_16;	// tage.scala:224:21, :271:{21,50}
  wire            _io_resp_f3_1_taken_output =
    _tables_5_io_f3_resp_1_valid
      ? (_tables_5_io_f3_resp_1_bits_ctr == 3'h3 | _tables_5_io_f3_resp_1_bits_ctr == 3'h4
           ? _GEN_17
           : _tables_5_io_f3_resp_1_bits_ctr[2])
      : _tables_4_io_f3_resp_1_valid
          ? (_tables_4_io_f3_resp_1_bits_ctr == 3'h3
             | _tables_4_io_f3_resp_1_bits_ctr == 3'h4
               ? _GEN_16
               : _tables_4_io_f3_resp_1_bits_ctr[2])
          : _tables_3_io_f3_resp_1_valid
              ? (_tables_3_io_f3_resp_1_bits_ctr == 3'h3
                 | _tables_3_io_f3_resp_1_bits_ctr == 3'h4
                   ? _GEN_15
                   : _tables_3_io_f3_resp_1_bits_ctr[2])
              : _tables_2_io_f3_resp_1_valid
                  ? (_tables_2_io_f3_resp_1_bits_ctr == 3'h3
                     | _tables_2_io_f3_resp_1_bits_ctr == 3'h4
                       ? _GEN_14
                       : _tables_2_io_f3_resp_1_bits_ctr[2])
                  : _tables_1_io_f3_resp_1_valid
                      ? (_tables_1_io_f3_resp_1_bits_ctr == 3'h3
                         | _tables_1_io_f3_resp_1_bits_ctr == 3'h4
                           ? _GEN_13
                           : _tables_1_io_f3_resp_1_bits_ctr[2])
                      : ~_tables_0_io_f3_resp_1_valid
                        | _tables_0_io_f3_resp_1_bits_ctr == 3'h3
                        | _tables_0_io_f3_resp_1_bits_ctr == 3'h4
                          ? io_resp_in_0_f3_1_taken
                          : _tables_0_io_f3_resp_1_bits_ctr[2];	// tage.scala:224:21, :259:25, :264:18, :265:{29,35,40,48,55,76}, :271:21, :303:37
  wire            f3_meta_provider_1_valid =
    _tables_0_io_f3_resp_1_valid | _tables_1_io_f3_resp_1_valid
    | _tables_2_io_f3_resp_1_valid | _tables_3_io_f3_resp_1_valid
    | _tables_4_io_f3_resp_1_valid | _tables_5_io_f3_resp_1_valid;	// tage.scala:224:21, :269:27
  wire [2:0]      f3_meta_provider_1_bits =
    _tables_5_io_f3_resp_1_valid
      ? 3'h5
      : _tables_4_io_f3_resp_1_valid
          ? 3'h4
          : {1'h0,
             _tables_3_io_f3_resp_1_valid
               ? 2'h3
               : _tables_2_io_f3_resp_1_valid
                   ? 2'h2
                   : {1'h0, _tables_1_io_f3_resp_1_valid}};	// predictor.scala:160:14, tage.scala:224:21, :265:{40,55}, :270:21
  wire [7:0][2:0] _GEN_18 =
    {{_tables_0_io_f3_resp_1_bits_ctr},
     {_tables_0_io_f3_resp_1_bits_ctr},
     {_tables_5_io_f3_resp_1_bits_ctr},
     {_tables_4_io_f3_resp_1_bits_ctr},
     {_tables_3_io_f3_resp_1_bits_ctr},
     {_tables_2_io_f3_resp_1_bits_ctr},
     {_tables_1_io_f3_resp_1_bits_ctr},
     {_tables_0_io_f3_resp_1_bits_ctr}};	// tage.scala:224:21, :276:31
  wire [7:0][1:0] _GEN_19 =
    {{_tables_0_io_f3_resp_1_bits_u},
     {_tables_0_io_f3_resp_1_bits_u},
     {_tables_5_io_f3_resp_1_bits_u},
     {_tables_4_io_f3_resp_1_bits_u},
     {_tables_3_io_f3_resp_1_bits_u},
     {_tables_2_io_f3_resp_1_bits_u},
     {_tables_1_io_f3_resp_1_bits_u},
     {_tables_0_io_f3_resp_1_bits_u}};	// tage.scala:224:21, :276:31
  wire [7:0]      _allocatable_slots_T_59 = 8'h1 << f3_meta_provider_1_bits;	// OneHot.scala:58:35, tage.scala:270:21
  wire [5:0]      _GEN_20 =
    _allocatable_slots_T_59[5:0] | _allocatable_slots_T_59[6:1]
    | _allocatable_slots_T_59[7:2];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [4:0]      _GEN_21 = _GEN_20[4:0] | _allocatable_slots_T_59[7:3];	// OneHot.scala:58:35, tage.scala:265:40, :270:21, util.scala:373:{29,45}
  wire [3:0]      _GEN_22 = _GEN_21[3:0] | _allocatable_slots_T_59[7:4];	// OneHot.scala:58:35, tage.scala:265:{40,55}, util.scala:373:{29,45}
  wire [2:0]      _GEN_23 = _GEN_22[2:0] | _allocatable_slots_T_59[7:5];	// OneHot.scala:58:35, tage.scala:265:55, :270:21, util.scala:373:{29,45}
  wire [1:0]      _GEN_24 = _GEN_23[1:0] | _allocatable_slots_T_59[7:6];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [5:0]      _GEN_25 =
    ~({_GEN_20[5],
       _GEN_21[4],
       _GEN_22[3],
       _GEN_23[2],
       _GEN_24[1],
       _GEN_24[0] | (&f3_meta_provider_1_bits)} & {6{f3_meta_provider_1_valid}})
    & {~_tables_5_io_f3_resp_1_valid & _tables_5_io_f3_resp_1_bits_u == 2'h0,
       ~_tables_4_io_f3_resp_1_valid & _tables_4_io_f3_resp_1_bits_u == 2'h0,
       ~_tables_3_io_f3_resp_1_valid & _tables_3_io_f3_resp_1_bits_u == 2'h0,
       ~_tables_2_io_f3_resp_1_valid & _tables_2_io_f3_resp_1_bits_u == 2'h0,
       ~_tables_1_io_f3_resp_1_valid & _tables_1_io_f3_resp_1_bits_u == 2'h0,
       ~_tables_0_io_f3_resp_1_valid & _tables_0_io_f3_resp_1_bits_u == 2'h0};	// Bitwise.scala:72:12, tage.scala:224:21, :265:{40,55}, :269:27, :270:21, :282:{33,45,60,70,77}, :283:{7,39}, :321:43, util.scala:373:{29,45}
  wire [5:0]      _GEN_26 =
    _GEN_25
    & {_alloc_lfsr_prng_1_io_out_5,
       _alloc_lfsr_prng_1_io_out_4,
       _alloc_lfsr_prng_1_io_out_3,
       _alloc_lfsr_prng_1_io_out_2,
       _alloc_lfsr_prng_1_io_out_1,
       _alloc_lfsr_prng_1_io_out_0};	// PRNG.scala:82:22, :86:17, tage.scala:282:77, :288:58
  wire [2:0]      masked_entry_1 =
    _GEN_26[0]
      ? 3'h0
      : _GEN_26[1]
          ? 3'h1
          : _GEN_26[2]
              ? 3'h2
              : _GEN_26[3] ? 3'h3 : _GEN_26[4] ? 3'h4 : {1'h1, ~(_GEN_26[5]), 1'h1};	// Mux.scala:47:69, OneHot.scala:47:40, :58:35, tage.scala:265:55, :288:58, :303:37
  wire [7:0]      _alloc_entry_T_2 = {2'h0, _GEN_25} >> masked_entry_1;	// Mux.scala:47:69, tage.scala:282:77, :289:44, :321:43
  wire            _GEN_27 =
    _tables_0_io_f3_resp_2_valid
      ? _tables_0_io_f3_resp_2_bits_ctr[2]
      : io_resp_in_0_f3_2_taken;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_28 =
    _tables_1_io_f3_resp_2_valid ? _tables_1_io_f3_resp_2_bits_ctr[2] : _GEN_27;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_29 =
    _tables_2_io_f3_resp_2_valid ? _tables_2_io_f3_resp_2_bits_ctr[2] : _GEN_28;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_30 =
    _tables_3_io_f3_resp_2_valid ? _tables_3_io_f3_resp_2_bits_ctr[2] : _GEN_29;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_31 =
    _tables_4_io_f3_resp_2_valid ? _tables_4_io_f3_resp_2_bits_ctr[2] : _GEN_30;	// tage.scala:224:21, :271:{21,50}
  wire            _io_resp_f3_2_taken_output =
    _tables_5_io_f3_resp_2_valid
      ? (_tables_5_io_f3_resp_2_bits_ctr == 3'h3 | _tables_5_io_f3_resp_2_bits_ctr == 3'h4
           ? _GEN_31
           : _tables_5_io_f3_resp_2_bits_ctr[2])
      : _tables_4_io_f3_resp_2_valid
          ? (_tables_4_io_f3_resp_2_bits_ctr == 3'h3
             | _tables_4_io_f3_resp_2_bits_ctr == 3'h4
               ? _GEN_30
               : _tables_4_io_f3_resp_2_bits_ctr[2])
          : _tables_3_io_f3_resp_2_valid
              ? (_tables_3_io_f3_resp_2_bits_ctr == 3'h3
                 | _tables_3_io_f3_resp_2_bits_ctr == 3'h4
                   ? _GEN_29
                   : _tables_3_io_f3_resp_2_bits_ctr[2])
              : _tables_2_io_f3_resp_2_valid
                  ? (_tables_2_io_f3_resp_2_bits_ctr == 3'h3
                     | _tables_2_io_f3_resp_2_bits_ctr == 3'h4
                       ? _GEN_28
                       : _tables_2_io_f3_resp_2_bits_ctr[2])
                  : _tables_1_io_f3_resp_2_valid
                      ? (_tables_1_io_f3_resp_2_bits_ctr == 3'h3
                         | _tables_1_io_f3_resp_2_bits_ctr == 3'h4
                           ? _GEN_27
                           : _tables_1_io_f3_resp_2_bits_ctr[2])
                      : ~_tables_0_io_f3_resp_2_valid
                        | _tables_0_io_f3_resp_2_bits_ctr == 3'h3
                        | _tables_0_io_f3_resp_2_bits_ctr == 3'h4
                          ? io_resp_in_0_f3_2_taken
                          : _tables_0_io_f3_resp_2_bits_ctr[2];	// tage.scala:224:21, :259:25, :264:18, :265:{29,35,40,48,55,76}, :271:21, :303:37
  wire            f3_meta_provider_2_valid =
    _tables_0_io_f3_resp_2_valid | _tables_1_io_f3_resp_2_valid
    | _tables_2_io_f3_resp_2_valid | _tables_3_io_f3_resp_2_valid
    | _tables_4_io_f3_resp_2_valid | _tables_5_io_f3_resp_2_valid;	// tage.scala:224:21, :269:27
  wire [2:0]      f3_meta_provider_2_bits =
    _tables_5_io_f3_resp_2_valid
      ? 3'h5
      : _tables_4_io_f3_resp_2_valid
          ? 3'h4
          : {1'h0,
             _tables_3_io_f3_resp_2_valid
               ? 2'h3
               : _tables_2_io_f3_resp_2_valid
                   ? 2'h2
                   : {1'h0, _tables_1_io_f3_resp_2_valid}};	// predictor.scala:160:14, tage.scala:224:21, :265:{40,55}, :270:21
  wire [7:0][2:0] _GEN_32 =
    {{_tables_0_io_f3_resp_2_bits_ctr},
     {_tables_0_io_f3_resp_2_bits_ctr},
     {_tables_5_io_f3_resp_2_bits_ctr},
     {_tables_4_io_f3_resp_2_bits_ctr},
     {_tables_3_io_f3_resp_2_bits_ctr},
     {_tables_2_io_f3_resp_2_bits_ctr},
     {_tables_1_io_f3_resp_2_bits_ctr},
     {_tables_0_io_f3_resp_2_bits_ctr}};	// tage.scala:224:21, :276:31
  wire [7:0][1:0] _GEN_33 =
    {{_tables_0_io_f3_resp_2_bits_u},
     {_tables_0_io_f3_resp_2_bits_u},
     {_tables_5_io_f3_resp_2_bits_u},
     {_tables_4_io_f3_resp_2_bits_u},
     {_tables_3_io_f3_resp_2_bits_u},
     {_tables_2_io_f3_resp_2_bits_u},
     {_tables_1_io_f3_resp_2_bits_u},
     {_tables_0_io_f3_resp_2_bits_u}};	// tage.scala:224:21, :276:31
  wire [7:0]      _allocatable_slots_T_98 = 8'h1 << f3_meta_provider_2_bits;	// OneHot.scala:58:35, tage.scala:270:21
  wire [5:0]      _GEN_34 =
    _allocatable_slots_T_98[5:0] | _allocatable_slots_T_98[6:1]
    | _allocatable_slots_T_98[7:2];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [4:0]      _GEN_35 = _GEN_34[4:0] | _allocatable_slots_T_98[7:3];	// OneHot.scala:58:35, tage.scala:265:40, :270:21, util.scala:373:{29,45}
  wire [3:0]      _GEN_36 = _GEN_35[3:0] | _allocatable_slots_T_98[7:4];	// OneHot.scala:58:35, tage.scala:265:{40,55}, util.scala:373:{29,45}
  wire [2:0]      _GEN_37 = _GEN_36[2:0] | _allocatable_slots_T_98[7:5];	// OneHot.scala:58:35, tage.scala:265:55, :270:21, util.scala:373:{29,45}
  wire [1:0]      _GEN_38 = _GEN_37[1:0] | _allocatable_slots_T_98[7:6];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [5:0]      _GEN_39 =
    ~({_GEN_34[5],
       _GEN_35[4],
       _GEN_36[3],
       _GEN_37[2],
       _GEN_38[1],
       _GEN_38[0] | (&f3_meta_provider_2_bits)} & {6{f3_meta_provider_2_valid}})
    & {~_tables_5_io_f3_resp_2_valid & _tables_5_io_f3_resp_2_bits_u == 2'h0,
       ~_tables_4_io_f3_resp_2_valid & _tables_4_io_f3_resp_2_bits_u == 2'h0,
       ~_tables_3_io_f3_resp_2_valid & _tables_3_io_f3_resp_2_bits_u == 2'h0,
       ~_tables_2_io_f3_resp_2_valid & _tables_2_io_f3_resp_2_bits_u == 2'h0,
       ~_tables_1_io_f3_resp_2_valid & _tables_1_io_f3_resp_2_bits_u == 2'h0,
       ~_tables_0_io_f3_resp_2_valid & _tables_0_io_f3_resp_2_bits_u == 2'h0};	// Bitwise.scala:72:12, tage.scala:224:21, :265:{40,55}, :269:27, :270:21, :282:{33,45,60,70,77}, :283:{7,39}, :321:43, util.scala:373:{29,45}
  wire [5:0]      _GEN_40 =
    _GEN_39
    & {_alloc_lfsr_prng_2_io_out_5,
       _alloc_lfsr_prng_2_io_out_4,
       _alloc_lfsr_prng_2_io_out_3,
       _alloc_lfsr_prng_2_io_out_2,
       _alloc_lfsr_prng_2_io_out_1,
       _alloc_lfsr_prng_2_io_out_0};	// PRNG.scala:82:22, :86:17, tage.scala:282:77, :288:58
  wire [2:0]      masked_entry_2 =
    _GEN_40[0]
      ? 3'h0
      : _GEN_40[1]
          ? 3'h1
          : _GEN_40[2]
              ? 3'h2
              : _GEN_40[3] ? 3'h3 : _GEN_40[4] ? 3'h4 : {1'h1, ~(_GEN_40[5]), 1'h1};	// Mux.scala:47:69, OneHot.scala:47:40, :58:35, tage.scala:265:55, :288:58, :303:37
  wire [7:0]      _alloc_entry_T_4 = {2'h0, _GEN_39} >> masked_entry_2;	// Mux.scala:47:69, tage.scala:282:77, :289:44, :321:43
  wire            _GEN_41 =
    _tables_0_io_f3_resp_3_valid
      ? _tables_0_io_f3_resp_3_bits_ctr[2]
      : io_resp_in_0_f3_3_taken;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_42 =
    _tables_1_io_f3_resp_3_valid ? _tables_1_io_f3_resp_3_bits_ctr[2] : _GEN_41;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_43 =
    _tables_2_io_f3_resp_3_valid ? _tables_2_io_f3_resp_3_bits_ctr[2] : _GEN_42;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_44 =
    _tables_3_io_f3_resp_3_valid ? _tables_3_io_f3_resp_3_bits_ctr[2] : _GEN_43;	// tage.scala:224:21, :271:{21,50}
  wire            _GEN_45 =
    _tables_4_io_f3_resp_3_valid ? _tables_4_io_f3_resp_3_bits_ctr[2] : _GEN_44;	// tage.scala:224:21, :271:{21,50}
  wire            _io_resp_f3_3_taken_output =
    _tables_5_io_f3_resp_3_valid
      ? (_tables_5_io_f3_resp_3_bits_ctr == 3'h3 | _tables_5_io_f3_resp_3_bits_ctr == 3'h4
           ? _GEN_45
           : _tables_5_io_f3_resp_3_bits_ctr[2])
      : _tables_4_io_f3_resp_3_valid
          ? (_tables_4_io_f3_resp_3_bits_ctr == 3'h3
             | _tables_4_io_f3_resp_3_bits_ctr == 3'h4
               ? _GEN_44
               : _tables_4_io_f3_resp_3_bits_ctr[2])
          : _tables_3_io_f3_resp_3_valid
              ? (_tables_3_io_f3_resp_3_bits_ctr == 3'h3
                 | _tables_3_io_f3_resp_3_bits_ctr == 3'h4
                   ? _GEN_43
                   : _tables_3_io_f3_resp_3_bits_ctr[2])
              : _tables_2_io_f3_resp_3_valid
                  ? (_tables_2_io_f3_resp_3_bits_ctr == 3'h3
                     | _tables_2_io_f3_resp_3_bits_ctr == 3'h4
                       ? _GEN_42
                       : _tables_2_io_f3_resp_3_bits_ctr[2])
                  : _tables_1_io_f3_resp_3_valid
                      ? (_tables_1_io_f3_resp_3_bits_ctr == 3'h3
                         | _tables_1_io_f3_resp_3_bits_ctr == 3'h4
                           ? _GEN_41
                           : _tables_1_io_f3_resp_3_bits_ctr[2])
                      : ~_tables_0_io_f3_resp_3_valid
                        | _tables_0_io_f3_resp_3_bits_ctr == 3'h3
                        | _tables_0_io_f3_resp_3_bits_ctr == 3'h4
                          ? io_resp_in_0_f3_3_taken
                          : _tables_0_io_f3_resp_3_bits_ctr[2];	// tage.scala:224:21, :259:25, :264:18, :265:{29,35,40,48,55,76}, :271:21, :303:37
  wire            f3_meta_provider_3_valid =
    _tables_0_io_f3_resp_3_valid | _tables_1_io_f3_resp_3_valid
    | _tables_2_io_f3_resp_3_valid | _tables_3_io_f3_resp_3_valid
    | _tables_4_io_f3_resp_3_valid | _tables_5_io_f3_resp_3_valid;	// tage.scala:224:21, :269:27
  wire [2:0]      f3_meta_provider_3_bits =
    _tables_5_io_f3_resp_3_valid
      ? 3'h5
      : _tables_4_io_f3_resp_3_valid
          ? 3'h4
          : {1'h0,
             _tables_3_io_f3_resp_3_valid
               ? 2'h3
               : _tables_2_io_f3_resp_3_valid
                   ? 2'h2
                   : {1'h0, _tables_1_io_f3_resp_3_valid}};	// predictor.scala:160:14, tage.scala:224:21, :265:{40,55}, :270:21
  wire [7:0][2:0] _GEN_46 =
    {{_tables_0_io_f3_resp_3_bits_ctr},
     {_tables_0_io_f3_resp_3_bits_ctr},
     {_tables_5_io_f3_resp_3_bits_ctr},
     {_tables_4_io_f3_resp_3_bits_ctr},
     {_tables_3_io_f3_resp_3_bits_ctr},
     {_tables_2_io_f3_resp_3_bits_ctr},
     {_tables_1_io_f3_resp_3_bits_ctr},
     {_tables_0_io_f3_resp_3_bits_ctr}};	// tage.scala:224:21, :276:31
  wire [7:0][1:0] _GEN_47 =
    {{_tables_0_io_f3_resp_3_bits_u},
     {_tables_0_io_f3_resp_3_bits_u},
     {_tables_5_io_f3_resp_3_bits_u},
     {_tables_4_io_f3_resp_3_bits_u},
     {_tables_3_io_f3_resp_3_bits_u},
     {_tables_2_io_f3_resp_3_bits_u},
     {_tables_1_io_f3_resp_3_bits_u},
     {_tables_0_io_f3_resp_3_bits_u}};	// tage.scala:224:21, :276:31
  wire [7:0]      _allocatable_slots_T_137 = 8'h1 << f3_meta_provider_3_bits;	// OneHot.scala:58:35, tage.scala:270:21
  wire [5:0]      _GEN_48 =
    _allocatable_slots_T_137[5:0] | _allocatable_slots_T_137[6:1]
    | _allocatable_slots_T_137[7:2];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [4:0]      _GEN_49 = _GEN_48[4:0] | _allocatable_slots_T_137[7:3];	// OneHot.scala:58:35, tage.scala:265:40, :270:21, util.scala:373:{29,45}
  wire [3:0]      _GEN_50 = _GEN_49[3:0] | _allocatable_slots_T_137[7:4];	// OneHot.scala:58:35, tage.scala:265:{40,55}, util.scala:373:{29,45}
  wire [2:0]      _GEN_51 = _GEN_50[2:0] | _allocatable_slots_T_137[7:5];	// OneHot.scala:58:35, tage.scala:265:55, :270:21, util.scala:373:{29,45}
  wire [1:0]      _GEN_52 = _GEN_51[1:0] | _allocatable_slots_T_137[7:6];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
  wire [5:0]      _GEN_53 =
    ~({_GEN_48[5],
       _GEN_49[4],
       _GEN_50[3],
       _GEN_51[2],
       _GEN_52[1],
       _GEN_52[0] | (&f3_meta_provider_3_bits)} & {6{f3_meta_provider_3_valid}})
    & {~_tables_5_io_f3_resp_3_valid & _tables_5_io_f3_resp_3_bits_u == 2'h0,
       ~_tables_4_io_f3_resp_3_valid & _tables_4_io_f3_resp_3_bits_u == 2'h0,
       ~_tables_3_io_f3_resp_3_valid & _tables_3_io_f3_resp_3_bits_u == 2'h0,
       ~_tables_2_io_f3_resp_3_valid & _tables_2_io_f3_resp_3_bits_u == 2'h0,
       ~_tables_1_io_f3_resp_3_valid & _tables_1_io_f3_resp_3_bits_u == 2'h0,
       ~_tables_0_io_f3_resp_3_valid & _tables_0_io_f3_resp_3_bits_u == 2'h0};	// Bitwise.scala:72:12, tage.scala:224:21, :265:{40,55}, :269:27, :270:21, :282:{33,45,60,70,77}, :283:{7,39}, :321:43, util.scala:373:{29,45}
  wire [5:0]      _GEN_54 =
    _GEN_53
    & {_alloc_lfsr_prng_3_io_out_5,
       _alloc_lfsr_prng_3_io_out_4,
       _alloc_lfsr_prng_3_io_out_3,
       _alloc_lfsr_prng_3_io_out_2,
       _alloc_lfsr_prng_3_io_out_1,
       _alloc_lfsr_prng_3_io_out_0};	// PRNG.scala:82:22, :86:17, tage.scala:282:77, :288:58
  wire [2:0]      masked_entry_3 =
    _GEN_54[0]
      ? 3'h0
      : _GEN_54[1]
          ? 3'h1
          : _GEN_54[2]
              ? 3'h2
              : _GEN_54[3] ? 3'h3 : _GEN_54[4] ? 3'h4 : {1'h1, ~(_GEN_54[5]), 1'h1};	// Mux.scala:47:69, OneHot.scala:47:40, :58:35, tage.scala:265:55, :288:58, :303:37
  wire [7:0]      _alloc_entry_T_6 = {2'h0, _GEN_53} >> masked_entry_3;	// Mux.scala:47:69, tage.scala:282:77, :289:44, :321:43
  reg             t_io_update_mask_0_REG;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG;	// tage.scala:354:41
  reg             t_io_update_mask_0_REG_1;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG_1;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG_1;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG_1;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG_1;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG_1;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG_1;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG_1;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG_1;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG_1;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG_1;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG_1;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG_1;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG_1;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG_1;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG_1;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG_1;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG_1;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG_1;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG_1;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG_1;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG_1;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG_1;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG_1;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG_1;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG_1;	// tage.scala:354:41
  reg             t_io_update_mask_0_REG_2;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG_2;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG_2;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG_2;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG_2;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG_2;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG_2;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG_2;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG_2;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG_2;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG_2;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG_2;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG_2;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG_2;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG_2;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG_2;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG_2;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG_2;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG_2;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG_2;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG_2;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG_2;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG_2;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG_2;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG_2;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG_2;	// tage.scala:354:41
  reg             t_io_update_mask_0_REG_3;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG_3;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG_3;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG_3;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG_3;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG_3;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG_3;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG_3;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG_3;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG_3;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG_3;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG_3;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG_3;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG_3;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG_3;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG_3;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG_3;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG_3;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG_3;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG_3;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG_3;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG_3;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG_3;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG_3;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG_3;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG_3;	// tage.scala:354:41
  reg             t_io_update_mask_0_REG_4;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG_4;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG_4;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG_4;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG_4;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG_4;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG_4;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG_4;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG_4;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG_4;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG_4;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG_4;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG_4;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG_4;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG_4;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG_4;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG_4;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG_4;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG_4;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG_4;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG_4;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG_4;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG_4;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG_4;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG_4;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG_4;	// tage.scala:354:41
  reg             t_io_update_mask_0_REG_5;	// tage.scala:345:48
  reg             t_io_update_taken_0_REG_5;	// tage.scala:346:48
  reg             t_io_update_alloc_0_REG_5;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_0_REG_5;	// tage.scala:348:48
  reg             t_io_update_u_mask_0_REG_5;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_0_REG_5;	// tage.scala:351:47
  reg             t_io_update_mask_1_REG_5;	// tage.scala:345:48
  reg             t_io_update_taken_1_REG_5;	// tage.scala:346:48
  reg             t_io_update_alloc_1_REG_5;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_1_REG_5;	// tage.scala:348:48
  reg             t_io_update_u_mask_1_REG_5;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_1_REG_5;	// tage.scala:351:47
  reg             t_io_update_mask_2_REG_5;	// tage.scala:345:48
  reg             t_io_update_taken_2_REG_5;	// tage.scala:346:48
  reg             t_io_update_alloc_2_REG_5;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_2_REG_5;	// tage.scala:348:48
  reg             t_io_update_u_mask_2_REG_5;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_2_REG_5;	// tage.scala:351:47
  reg             t_io_update_mask_3_REG_5;	// tage.scala:345:48
  reg             t_io_update_taken_3_REG_5;	// tage.scala:346:48
  reg             t_io_update_alloc_3_REG_5;	// tage.scala:347:48
  reg  [2:0]      t_io_update_old_ctr_3_REG_5;	// tage.scala:348:48
  reg             t_io_update_u_mask_3_REG_5;	// tage.scala:350:47
  reg  [1:0]      t_io_update_u_3_REG_5;	// tage.scala:351:47
  reg  [39:0]     t_io_update_pc_REG_5;	// tage.scala:353:41
  reg  [63:0]     t_io_update_hist_REG_5;	// tage.scala:354:41
  always @(posedge clock) begin
    automatic logic            _GEN_55;	// predictor.scala:96:69
    automatic logic            _GEN_56;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_57;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_58;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_59;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_60;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_61;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_62;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _new_u_T;	// tage.scala:237:73, :308:52
    automatic logic            _new_u_T_2;	// tage.scala:218:27
    automatic logic [1:0]      _new_u_T_3;	// tage.scala:218:43
    automatic logic [1:0]      _new_u_T_7;	// tage.scala:219:43
    automatic logic            _GEN_63;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_64;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_65;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_66;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_67;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_68;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_69;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _new_u_T_11;	// tage.scala:237:73, :308:52
    automatic logic            _new_u_T_13;	// tage.scala:218:27
    automatic logic [1:0]      _new_u_T_14;	// tage.scala:218:43
    automatic logic [1:0]      _new_u_T_18;	// tage.scala:219:43
    automatic logic            _GEN_70;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_71;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_72;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_73;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_74;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_75;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_76;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _new_u_T_22;	// tage.scala:237:73, :308:52
    automatic logic            _new_u_T_24;	// tage.scala:218:27
    automatic logic [1:0]      _new_u_T_25;	// tage.scala:218:43
    automatic logic [1:0]      _new_u_T_29;	// tage.scala:219:43
    automatic logic            _GEN_77;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_78;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_79;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_80;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_81;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_82;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _GEN_83;	// tage.scala:299:92, :300:47, :303:37
    automatic logic            _new_u_T_33;	// tage.scala:237:73, :308:52
    automatic logic            _new_u_T_35;	// tage.scala:218:27
    automatic logic [1:0]      _new_u_T_36;	// tage.scala:218:43
    automatic logic [1:0]      _new_u_T_40;	// tage.scala:219:43
    automatic logic            _GEN_84;	// tage.scala:317:95
    automatic logic [3:0]      _GEN_85;	// tage.scala:320:27
    automatic logic            _GEN_86;	// tage.scala:320:27
    automatic logic [3:0][2:0] _GEN_87;	// tage.scala:320:27
    automatic logic [2:0]      _GEN_88;	// tage.scala:320:27
    automatic logic            _GEN_89;	// tage.scala:321:43
    automatic logic            _GEN_90;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_91;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_92;	// tage.scala:321:43
    automatic logic            _GEN_93;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_94;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_95;	// tage.scala:321:43
    automatic logic            _GEN_96;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_97;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_98;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_99;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_100;	// tage.scala:321:43
    automatic logic            _GEN_101;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_102;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_103;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_104;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_105;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_106;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_107;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_108;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_109;	// tage.scala:321:43
    automatic logic            _GEN_110;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_111;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_112;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_113;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_114;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_115;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_116;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_117;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_118;	// tage.scala:321:43
    automatic logic            _GEN_119;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_120;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_121;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_122;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_123;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_124;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_125;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_126;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_127;	// tage.scala:321:43
    automatic logic            _GEN_128;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_129;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_130;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_131;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_132;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_133;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_134;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_135;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_136;	// tage.scala:321:43
    automatic logic            _GEN_137;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_138;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_139;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_140;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_141;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_142;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_143;	// tage.scala:299:92, :321:43
    automatic logic            _GEN_144;	// tage.scala:299:92, :317:128, :320:27, :321:43
    automatic logic            _GEN_145;	// tage.scala:297:67
    automatic logic            _GEN_146;	// tage.scala:297:67
    automatic logic            _GEN_147;	// tage.scala:297:67
    automatic logic            _GEN_148;	// tage.scala:297:67
    automatic logic            _GEN_149;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic            _GEN_150;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic            _GEN_151;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic            _GEN_152;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic            _GEN_153;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic            _GEN_154;	// tage.scala:299:92, :317:128, :320:27, :323:43
    automatic logic [3:0][2:0] _GEN_155;	// OneHot.scala:58:35
    automatic logic [2:0]      _GEN_156;	// OneHot.scala:58:35
    automatic logic [7:0]      _decr_mask_T_1;	// OneHot.scala:58:35
    automatic logic [5:0]      _GEN_157;	// tage.scala:270:21, util.scala:373:{29,45}
    automatic logic [4:0]      _GEN_158;	// tage.scala:265:40, util.scala:373:{29,45}
    automatic logic [3:0]      _GEN_159;	// tage.scala:265:55, util.scala:373:{29,45}
    automatic logic [2:0]      _GEN_160;	// tage.scala:270:21, util.scala:373:{29,45}
    automatic logic [1:0]      _GEN_161;	// util.scala:373:{29,45}
    automatic logic [3:0]      _GEN_162;	// OneHot.scala:58:35
    automatic logic [5:0]      decr_mask;	// tage.scala:330:26
    automatic logic            _GEN_163;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_164;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_165;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_166;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_167;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_168;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_169;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_170;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_171;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_172;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_173;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_174;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_175;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_176;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_177;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_178;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_179;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_180;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_181;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_182;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_183;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_184;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_185;	// tage.scala:299:92, :333:29, :334:36
    automatic logic            _GEN_186;	// tage.scala:299:92, :333:29, :334:36
    _GEN_55 =
      s1_update_bits_is_mispredict_update | s1_update_bits_is_repair_update
      | (|s1_update_bits_btb_mispredicts);	// predictor.scala:94:50, :96:69, :184:30
    _GEN_56 =
      s1_update_bits_br_mask[0] & s1_update_valid & ~_GEN_55 & s1_update_bits_meta[43];	// predictor.scala:96:{26,69}, :184:30, tage.scala:236:52, :299:{33,92}, :300:47, :303:37
    _GEN_57 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h0;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_58 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h1;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_59 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h2;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_60 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h3;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_61 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h4;	// predictor.scala:184:30, tage.scala:236:52, :265:55, :299:92, :300:47, :303:37
    _GEN_62 = _GEN_56 & s1_update_bits_meta[42:40] == 3'h5;	// predictor.scala:184:30, tage.scala:236:52, :270:21, :299:92, :300:47, :303:37
    _new_u_T = s1_update_bits_cfi_idx_bits == 2'h0 & s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30, tage.scala:237:73, :308:52, :321:43
    _new_u_T_2 = s1_update_bits_meta[29:28] == 2'h0;	// predictor.scala:184:30, tage.scala:218:27, :236:52, :321:43
    _new_u_T_3 = s1_update_bits_meta[29:28] - 2'h1;	// predictor.scala:184:30, tage.scala:218:43, :236:52
    _new_u_T_7 = s1_update_bits_meta[29:28] + 2'h1;	// predictor.scala:184:30, tage.scala:219:43, :236:52, :321:43
    _GEN_63 =
      s1_update_bits_br_mask[1] & s1_update_valid & ~_GEN_55 & s1_update_bits_meta[47];	// predictor.scala:96:{26,69}, :184:30, tage.scala:236:52, :299:{33,92}, :300:47, :303:37
    _GEN_64 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h0;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_65 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h1;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_66 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h2;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_67 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h3;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_68 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h4;	// predictor.scala:184:30, tage.scala:236:52, :265:55, :299:92, :300:47, :303:37
    _GEN_69 = _GEN_63 & s1_update_bits_meta[46:44] == 3'h5;	// predictor.scala:184:30, tage.scala:236:52, :270:21, :299:92, :300:47, :303:37
    _new_u_T_11 = s1_update_bits_cfi_idx_bits == 2'h1 & s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30, tage.scala:237:73, :308:52, :321:43
    _new_u_T_13 = s1_update_bits_meta[31:30] == 2'h0;	// predictor.scala:184:30, tage.scala:218:27, :236:52, :321:43
    _new_u_T_14 = s1_update_bits_meta[31:30] - 2'h1;	// predictor.scala:184:30, tage.scala:218:43, :236:52
    _new_u_T_18 = s1_update_bits_meta[31:30] + 2'h1;	// predictor.scala:184:30, tage.scala:219:43, :236:52, :321:43
    _GEN_70 =
      s1_update_bits_br_mask[2] & s1_update_valid & ~_GEN_55 & s1_update_bits_meta[51];	// predictor.scala:96:{26,69}, :184:30, tage.scala:236:52, :299:{33,92}, :300:47, :303:37
    _GEN_71 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h0;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_72 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h1;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_73 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h2;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_74 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h3;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_75 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h4;	// predictor.scala:184:30, tage.scala:236:52, :265:55, :299:92, :300:47, :303:37
    _GEN_76 = _GEN_70 & s1_update_bits_meta[50:48] == 3'h5;	// predictor.scala:184:30, tage.scala:236:52, :270:21, :299:92, :300:47, :303:37
    _new_u_T_22 = s1_update_bits_cfi_idx_bits == 2'h2 & s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30, tage.scala:237:73, :270:21, :308:52
    _new_u_T_24 = s1_update_bits_meta[33:32] == 2'h0;	// predictor.scala:184:30, tage.scala:218:27, :236:52, :321:43
    _new_u_T_25 = s1_update_bits_meta[33:32] - 2'h1;	// predictor.scala:184:30, tage.scala:218:43, :236:52
    _new_u_T_29 = s1_update_bits_meta[33:32] + 2'h1;	// predictor.scala:184:30, tage.scala:219:43, :236:52, :321:43
    _GEN_77 =
      s1_update_bits_br_mask[3] & s1_update_valid & ~_GEN_55 & s1_update_bits_meta[55];	// predictor.scala:96:{26,69}, :184:30, tage.scala:236:52, :299:{33,92}, :300:47, :303:37
    _GEN_78 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h0;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_79 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h1;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_80 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h2;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_81 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h3;	// predictor.scala:184:30, tage.scala:236:52, :299:92, :300:47, :303:37
    _GEN_82 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h4;	// predictor.scala:184:30, tage.scala:236:52, :265:55, :299:92, :300:47, :303:37
    _GEN_83 = _GEN_77 & s1_update_bits_meta[54:52] == 3'h5;	// predictor.scala:184:30, tage.scala:236:52, :270:21, :299:92, :300:47, :303:37
    _new_u_T_33 = (&s1_update_bits_cfi_idx_bits) & s1_update_bits_cfi_mispredicted;	// predictor.scala:184:30, tage.scala:237:73, :308:52
    _new_u_T_35 = s1_update_bits_meta[35:34] == 2'h0;	// predictor.scala:184:30, tage.scala:218:27, :236:52, :321:43
    _new_u_T_36 = s1_update_bits_meta[35:34] - 2'h1;	// predictor.scala:184:30, tage.scala:218:43, :236:52
    _new_u_T_40 = s1_update_bits_meta[35:34] + 2'h1;	// predictor.scala:184:30, tage.scala:219:43, :236:52, :321:43
    _GEN_84 =
      s1_update_valid & ~_GEN_55 & s1_update_bits_cfi_mispredicted
      & s1_update_bits_cfi_idx_valid;	// predictor.scala:96:{26,69}, :184:30, tage.scala:317:95
    _GEN_85 =
      {{s1_update_bits_meta[15]},
       {s1_update_bits_meta[11]},
       {s1_update_bits_meta[7]},
       {s1_update_bits_meta[3]}};	// predictor.scala:184:30, tage.scala:236:52, :320:27
    _GEN_86 = _GEN_85[s1_update_bits_cfi_idx_bits];	// predictor.scala:184:30, tage.scala:320:27
    _GEN_87 =
      {{s1_update_bits_meta[14:12]},
       {s1_update_bits_meta[10:8]},
       {s1_update_bits_meta[6:4]},
       {s1_update_bits_meta[2:0]}};	// predictor.scala:184:30, tage.scala:236:52, :320:27
    _GEN_88 = _GEN_87[s1_update_bits_cfi_idx_bits];	// predictor.scala:184:30, tage.scala:320:27
    _GEN_89 = _GEN_88 == 3'h0;	// tage.scala:303:37, :320:27, :321:43
    _GEN_90 = _GEN_89 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_91 = _GEN_84 & _GEN_86 & _GEN_90;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_92 = s1_update_bits_cfi_idx_bits == 2'h1;	// predictor.scala:184:30, tage.scala:321:43
    _GEN_93 = _GEN_89 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_94 = _GEN_84 & _GEN_86 & _GEN_93;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_95 = s1_update_bits_cfi_idx_bits == 2'h2;	// predictor.scala:184:30, tage.scala:270:21, :321:43
    _GEN_96 = _GEN_89 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_97 = _GEN_84 & _GEN_86 & _GEN_96;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_98 = _GEN_89 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_99 = _GEN_84 & _GEN_86 & _GEN_98;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_100 = _GEN_88 == 3'h1;	// tage.scala:303:37, :320:27, :321:43
    _GEN_101 = _GEN_100 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_102 = _GEN_84 & _GEN_86 & _GEN_101;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_103 = _GEN_100 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_104 = _GEN_84 & _GEN_86 & _GEN_103;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_105 = _GEN_100 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_106 = _GEN_84 & _GEN_86 & _GEN_105;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_107 = _GEN_100 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_108 = _GEN_84 & _GEN_86 & _GEN_107;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_109 = _GEN_88 == 3'h2;	// tage.scala:303:37, :320:27, :321:43
    _GEN_110 = _GEN_109 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_111 = _GEN_84 & _GEN_86 & _GEN_110;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_112 = _GEN_109 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_113 = _GEN_84 & _GEN_86 & _GEN_112;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_114 = _GEN_109 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_115 = _GEN_84 & _GEN_86 & _GEN_114;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_116 = _GEN_109 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_117 = _GEN_84 & _GEN_86 & _GEN_116;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_118 = _GEN_88 == 3'h3;	// tage.scala:303:37, :320:27, :321:43
    _GEN_119 = _GEN_118 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_120 = _GEN_84 & _GEN_86 & _GEN_119;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_121 = _GEN_118 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_122 = _GEN_84 & _GEN_86 & _GEN_121;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_123 = _GEN_118 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_124 = _GEN_84 & _GEN_86 & _GEN_123;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_125 = _GEN_118 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_126 = _GEN_84 & _GEN_86 & _GEN_125;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_127 = _GEN_88 == 3'h4;	// tage.scala:265:55, :320:27, :321:43
    _GEN_128 = _GEN_127 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_129 = _GEN_84 & _GEN_86 & _GEN_128;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_130 = _GEN_127 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_131 = _GEN_84 & _GEN_86 & _GEN_130;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_132 = _GEN_127 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_133 = _GEN_84 & _GEN_86 & _GEN_132;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_134 = _GEN_127 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_135 = _GEN_84 & _GEN_86 & _GEN_134;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_136 = _GEN_88 == 3'h5;	// tage.scala:270:21, :320:27, :321:43
    _GEN_137 = _GEN_136 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43
    _GEN_138 = _GEN_84 & _GEN_86 & _GEN_137;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_139 = _GEN_136 & _GEN_92;	// tage.scala:299:92, :321:43
    _GEN_140 = _GEN_84 & _GEN_86 & _GEN_139;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_141 = _GEN_136 & _GEN_95;	// tage.scala:299:92, :321:43
    _GEN_142 = _GEN_84 & _GEN_86 & _GEN_141;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_143 = _GEN_136 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43
    _GEN_144 = _GEN_84 & _GEN_86 & _GEN_143;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43
    _GEN_145 = s1_update_bits_cfi_idx_valid & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:{58,67}
    _GEN_146 = s1_update_bits_cfi_idx_valid & s1_update_bits_cfi_idx_bits == 2'h1;	// predictor.scala:184:30, tage.scala:297:{58,67}, :321:43
    _GEN_147 = s1_update_bits_cfi_idx_valid & s1_update_bits_cfi_idx_bits == 2'h2;	// predictor.scala:184:30, tage.scala:270:21, :297:{58,67}
    _GEN_148 = s1_update_bits_cfi_idx_valid & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:{58,67}
    _GEN_149 = _GEN_84 & _GEN_86 & _GEN_89;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_150 = _GEN_84 & _GEN_86 & _GEN_100;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_151 = _GEN_84 & _GEN_86 & _GEN_109;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_152 = _GEN_84 & _GEN_86 & _GEN_118;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_153 = _GEN_84 & _GEN_86 & _GEN_127;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_154 = _GEN_84 & _GEN_86 & _GEN_136;	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :323:43
    _GEN_155 =
      {{s1_update_bits_meta[54:52]},
       {s1_update_bits_meta[50:48]},
       {s1_update_bits_meta[46:44]},
       {s1_update_bits_meta[42:40]}};	// OneHot.scala:58:35, predictor.scala:184:30, tage.scala:236:52
    _GEN_156 = _GEN_155[s1_update_bits_cfi_idx_bits];	// OneHot.scala:58:35, predictor.scala:184:30
    _decr_mask_T_1 = 8'h1 << _GEN_156;	// OneHot.scala:58:35
    _GEN_157 = _decr_mask_T_1[5:0] | _decr_mask_T_1[6:1] | _decr_mask_T_1[7:2];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
    _GEN_158 = _GEN_157[4:0] | _decr_mask_T_1[7:3];	// OneHot.scala:58:35, tage.scala:265:40, :270:21, util.scala:373:{29,45}
    _GEN_159 = _GEN_158[3:0] | _decr_mask_T_1[7:4];	// OneHot.scala:58:35, tage.scala:265:{40,55}, util.scala:373:{29,45}
    _GEN_160 = _GEN_159[2:0] | _decr_mask_T_1[7:5];	// OneHot.scala:58:35, tage.scala:265:55, :270:21, util.scala:373:{29,45}
    _GEN_161 = _GEN_160[1:0] | _decr_mask_T_1[7:6];	// OneHot.scala:58:35, tage.scala:270:21, util.scala:373:{29,45}
    _GEN_162 =
      {{s1_update_bits_meta[55]},
       {s1_update_bits_meta[51]},
       {s1_update_bits_meta[47]},
       {s1_update_bits_meta[43]}};	// OneHot.scala:58:35, predictor.scala:184:30, tage.scala:236:52
    decr_mask =
      _GEN_162[s1_update_bits_cfi_idx_bits]
        ? ~{_GEN_157[5],
            _GEN_158[4],
            _GEN_159[3],
            _GEN_160[2],
            _GEN_161[1],
            _GEN_161[0] | (&_GEN_156)}
        : 6'h0;	// OneHot.scala:58:35, predictor.scala:184:30, tage.scala:265:{40,55}, :270:21, :330:{26,43}, util.scala:373:{29,45}
    _GEN_163 = decr_mask[0] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_164 = decr_mask[0] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_165 = decr_mask[0] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_166 = decr_mask[0] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_167 = decr_mask[1] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_168 = decr_mask[1] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_169 = decr_mask[1] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_170 = decr_mask[1] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_171 = decr_mask[2] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_172 = decr_mask[2] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_173 = decr_mask[2] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_174 = decr_mask[2] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_175 = decr_mask[3] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_176 = decr_mask[3] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_177 = decr_mask[3] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_178 = decr_mask[3] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_179 = decr_mask[4] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_180 = decr_mask[4] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_181 = decr_mask[4] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_182 = decr_mask[4] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_183 = decr_mask[5] & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_184 = decr_mask[5] & _GEN_92;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_185 = decr_mask[5] & _GEN_95;	// tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    _GEN_186 = decr_mask[5] & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :321:43, :330:26, :333:{24,29}, :334:36
    s1_update_valid <= io_update_valid;	// predictor.scala:184:30
    s1_update_bits_is_mispredict_update <= io_update_bits_is_mispredict_update;	// predictor.scala:184:30
    s1_update_bits_is_repair_update <= io_update_bits_is_repair_update;	// predictor.scala:184:30
    s1_update_bits_btb_mispredicts <= io_update_bits_btb_mispredicts;	// predictor.scala:184:30
    s1_update_bits_pc <= io_update_bits_pc;	// predictor.scala:184:30
    s1_update_bits_br_mask <= io_update_bits_br_mask;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;	// predictor.scala:184:30
    s1_update_bits_cfi_taken <= io_update_bits_cfi_taken;	// predictor.scala:184:30
    s1_update_bits_cfi_mispredicted <= io_update_bits_cfi_mispredicted;	// predictor.scala:184:30
    s1_update_bits_ghist <= io_update_bits_ghist;	// predictor.scala:184:30
    s1_update_bits_meta <= io_update_bits_meta;	// predictor.scala:184:30
    t_io_f1_req_valid_REG <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG <= io_f0_pc;	// tage.scala:226:35
    t_io_f1_req_valid_REG_1 <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG_1 <= io_f0_pc;	// tage.scala:226:35
    t_io_f1_req_valid_REG_2 <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG_2 <= io_f0_pc;	// tage.scala:226:35
    t_io_f1_req_valid_REG_3 <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG_3 <= io_f0_pc;	// tage.scala:226:35
    t_io_f1_req_valid_REG_4 <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG_4 <= io_f0_pc;	// tage.scala:226:35
    t_io_f1_req_valid_REG_5 <= io_f0_valid;	// tage.scala:225:35
    t_io_f1_req_pc_REG_5 <= io_f0_pc;	// tage.scala:226:35
    t_io_update_mask_0_REG <= _GEN_91 | _GEN_57;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG <= (_GEN_91 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG <= _GEN_149 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84) begin	// tage.scala:317:95
      if (_GEN_86) begin	// tage.scala:320:27
        t_io_update_u_mask_0_REG <= _GEN_90 | _GEN_57;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG <= _GEN_93 | _GEN_64;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG <= _GEN_96 | _GEN_71;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG <= _GEN_98 | _GEN_78;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_0_REG_1 <= _GEN_101 | _GEN_58;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG_1 <= _GEN_103 | _GEN_65;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG_1 <= _GEN_105 | _GEN_72;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG_1 <= _GEN_107 | _GEN_79;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_0_REG_2 <= _GEN_110 | _GEN_59;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG_2 <= _GEN_112 | _GEN_66;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG_2 <= _GEN_114 | _GEN_73;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG_2 <= _GEN_116 | _GEN_80;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_0_REG_3 <= _GEN_119 | _GEN_60;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG_3 <= _GEN_121 | _GEN_67;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG_3 <= _GEN_123 | _GEN_74;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG_3 <= _GEN_125 | _GEN_81;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_0_REG_4 <= _GEN_128 | _GEN_61;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG_4 <= _GEN_130 | _GEN_68;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG_4 <= _GEN_132 | _GEN_75;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG_4 <= _GEN_134 | _GEN_82;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_0_REG_5 <= _GEN_137 | _GEN_62;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_1_REG_5 <= _GEN_139 | _GEN_69;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_2_REG_5 <= _GEN_141 | _GEN_76;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
        t_io_update_u_mask_3_REG_5 <= _GEN_143 | _GEN_83;	// tage.scala:299:92, :300:47, :303:37, :321:43, :325:44, :350:47
      end
      else begin	// tage.scala:320:27
        t_io_update_u_mask_0_REG <= _GEN_163 | _GEN_57;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG <= _GEN_164 | _GEN_64;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG <= _GEN_165 | _GEN_71;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG <= _GEN_166 | _GEN_78;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_0_REG_1 <= _GEN_167 | _GEN_58;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG_1 <= _GEN_168 | _GEN_65;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG_1 <= _GEN_169 | _GEN_72;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG_1 <= _GEN_170 | _GEN_79;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_0_REG_2 <= _GEN_171 | _GEN_59;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG_2 <= _GEN_172 | _GEN_66;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG_2 <= _GEN_173 | _GEN_73;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG_2 <= _GEN_174 | _GEN_80;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_0_REG_3 <= _GEN_175 | _GEN_60;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG_3 <= _GEN_176 | _GEN_67;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG_3 <= _GEN_177 | _GEN_74;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG_3 <= _GEN_178 | _GEN_81;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_0_REG_4 <= _GEN_179 | _GEN_61;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG_4 <= _GEN_180 | _GEN_68;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG_4 <= _GEN_181 | _GEN_75;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG_4 <= _GEN_182 | _GEN_82;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_0_REG_5 <= _GEN_183 | _GEN_62;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_1_REG_5 <= _GEN_184 | _GEN_69;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_2_REG_5 <= _GEN_185 | _GEN_76;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
        t_io_update_u_mask_3_REG_5 <= _GEN_186 | _GEN_83;	// tage.scala:299:92, :300:47, :303:37, :333:29, :334:36, :350:47
      end
    end
    else begin	// tage.scala:317:95
      t_io_update_u_mask_0_REG <= _GEN_57;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG <= _GEN_64;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG <= _GEN_71;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG <= _GEN_78;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_0_REG_1 <= _GEN_58;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG_1 <= _GEN_65;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG_1 <= _GEN_72;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG_1 <= _GEN_79;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_0_REG_2 <= _GEN_59;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG_2 <= _GEN_66;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG_2 <= _GEN_73;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG_2 <= _GEN_80;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_0_REG_3 <= _GEN_60;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG_3 <= _GEN_67;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG_3 <= _GEN_74;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG_3 <= _GEN_81;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_0_REG_4 <= _GEN_61;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG_4 <= _GEN_68;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG_4 <= _GEN_75;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG_4 <= _GEN_82;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_0_REG_5 <= _GEN_62;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_1_REG_5 <= _GEN_69;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_2_REG_5 <= _GEN_76;	// tage.scala:299:92, :300:47, :303:37, :350:47
      t_io_update_u_mask_3_REG_5 <= _GEN_83;	// tage.scala:299:92, :300:47, :303:37, :350:47
    end
    if (_GEN_84 & (_GEN_86 ? _GEN_90 : _GEN_163))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG <= _GEN_94 | _GEN_64;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG <= (_GEN_94 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG <= _GEN_149 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_93 : _GEN_164))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG <= _GEN_97 | _GEN_71;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG <= (_GEN_97 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG <= _GEN_149 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_96 : _GEN_165))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG <= _GEN_99 | _GEN_78;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG <= (_GEN_99 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG <= _GEN_149 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_98 : _GEN_166))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
    t_io_update_mask_0_REG_1 <= _GEN_102 | _GEN_58;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG_1 <= (_GEN_102 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG_1 <= _GEN_150 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG_1 <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_101 : _GEN_167))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG_1 <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG_1 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG_1 <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG_1 <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG_1 <= _GEN_104 | _GEN_65;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG_1 <= (_GEN_104 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG_1 <= _GEN_150 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG_1 <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_103 : _GEN_168))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG_1 <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG_1 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG_1 <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG_1 <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG_1 <= _GEN_106 | _GEN_72;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG_1 <= (_GEN_106 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG_1 <= _GEN_150 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG_1 <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_105 : _GEN_169))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG_1 <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG_1 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG_1 <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG_1 <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG_1 <= _GEN_108 | _GEN_79;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG_1 <= (_GEN_108 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG_1 <= _GEN_150 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG_1 <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_107 : _GEN_170))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG_1 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG_1 <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG_1 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG_1 <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG_1 <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG_1 <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG_1 <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
    t_io_update_mask_0_REG_2 <= _GEN_111 | _GEN_59;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG_2 <= (_GEN_111 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG_2 <= _GEN_151 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG_2 <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_110 : _GEN_171))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG_2 <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG_2 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG_2 <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG_2 <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG_2 <= _GEN_113 | _GEN_66;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG_2 <= (_GEN_113 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG_2 <= _GEN_151 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG_2 <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_112 : _GEN_172))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG_2 <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG_2 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG_2 <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG_2 <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG_2 <= _GEN_115 | _GEN_73;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG_2 <= (_GEN_115 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG_2 <= _GEN_151 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG_2 <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_114 : _GEN_173))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG_2 <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG_2 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG_2 <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG_2 <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG_2 <= _GEN_117 | _GEN_80;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG_2 <= (_GEN_117 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG_2 <= _GEN_151 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG_2 <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_116 : _GEN_174))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG_2 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG_2 <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG_2 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG_2 <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG_2 <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG_2 <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG_2 <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
    t_io_update_mask_0_REG_3 <= _GEN_120 | _GEN_60;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG_3 <= (_GEN_120 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG_3 <= _GEN_152 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG_3 <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_119 : _GEN_175))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG_3 <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG_3 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG_3 <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG_3 <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG_3 <= _GEN_122 | _GEN_67;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG_3 <= (_GEN_122 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG_3 <= _GEN_152 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG_3 <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_121 : _GEN_176))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG_3 <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG_3 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG_3 <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG_3 <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG_3 <= _GEN_124 | _GEN_74;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG_3 <= (_GEN_124 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG_3 <= _GEN_152 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG_3 <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_123 : _GEN_177))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG_3 <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG_3 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG_3 <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG_3 <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG_3 <= _GEN_126 | _GEN_81;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG_3 <= (_GEN_126 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG_3 <= _GEN_152 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG_3 <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_125 : _GEN_178))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG_3 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG_3 <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG_3 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG_3 <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG_3 <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG_3 <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG_3 <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
    t_io_update_mask_0_REG_4 <= _GEN_129 | _GEN_61;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG_4 <= (_GEN_129 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG_4 <= _GEN_153 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG_4 <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_128 : _GEN_179))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG_4 <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG_4 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG_4 <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG_4 <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG_4 <= _GEN_131 | _GEN_68;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG_4 <= (_GEN_131 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG_4 <= _GEN_153 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG_4 <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_130 : _GEN_180))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG_4 <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG_4 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG_4 <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG_4 <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG_4 <= _GEN_133 | _GEN_75;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG_4 <= (_GEN_133 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG_4 <= _GEN_153 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG_4 <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_132 : _GEN_181))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG_4 <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG_4 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG_4 <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG_4 <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG_4 <= _GEN_135 | _GEN_82;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG_4 <= (_GEN_135 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG_4 <= _GEN_153 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG_4 <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_134 : _GEN_182))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG_4 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG_4 <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG_4 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG_4 <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG_4 <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG_4 <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG_4 <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
    t_io_update_mask_0_REG_5 <= _GEN_138 | _GEN_62;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_0_REG_5 <= (_GEN_138 | _GEN_145) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_0_REG_5 <= _GEN_154 & ~(|s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:297:58, :299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_0_REG_5 <= s1_update_bits_meta[18:16];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_137 : _GEN_183))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_0_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[36]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_2)	// tage.scala:218:27
          t_io_update_u_0_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_0_REG_5 <= _new_u_T_3;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[29:28]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_0_REG_5 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_0_REG_5 <= _new_u_T_7;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_0_REG_5 <= s1_update_bits_meta[29:28];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_1_REG_5 <= _GEN_140 | _GEN_69;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_1_REG_5 <= (_GEN_140 | _GEN_146) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_1_REG_5 <= _GEN_154 & _GEN_92;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_1_REG_5 <= s1_update_bits_meta[21:19];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_139 : _GEN_184))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_1_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[37]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_11) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_13)	// tage.scala:218:27
          t_io_update_u_1_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_1_REG_5 <= _new_u_T_14;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[31:30]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_1_REG_5 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_1_REG_5 <= _new_u_T_18;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_1_REG_5 <= s1_update_bits_meta[31:30];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_2_REG_5 <= _GEN_142 | _GEN_76;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_2_REG_5 <= (_GEN_142 | _GEN_147) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_2_REG_5 <= _GEN_154 & _GEN_95;	// tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_2_REG_5 <= s1_update_bits_meta[24:22];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_141 : _GEN_185))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_2_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[38]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_22) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_24)	// tage.scala:218:27
          t_io_update_u_2_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_2_REG_5 <= _new_u_T_25;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[33:32]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_2_REG_5 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_2_REG_5 <= _new_u_T_29;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_2_REG_5 <= s1_update_bits_meta[33:32];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_mask_3_REG_5 <= _GEN_144 | _GEN_83;	// tage.scala:299:92, :300:47, :303:37, :317:128, :320:27, :321:43, :345:48
    t_io_update_taken_3_REG_5 <= (_GEN_144 | _GEN_148) & s1_update_bits_cfi_taken;	// predictor.scala:184:30, tage.scala:297:67, :299:92, :317:128, :320:27, :321:43, :322:43, :346:48
    t_io_update_alloc_3_REG_5 <= _GEN_154 & (&s1_update_bits_cfi_idx_bits);	// predictor.scala:184:30, tage.scala:299:92, :317:128, :320:27, :321:43, :323:43, :347:48
    t_io_update_old_ctr_3_REG_5 <= s1_update_bits_meta[27:25];	// predictor.scala:184:30, tage.scala:236:52, :348:48
    if (_GEN_84 & (_GEN_86 ? _GEN_143 : _GEN_186))	// tage.scala:299:92, :317:{95,128}, :320:27, :321:43, :326:44, :333:29, :334:36, :335:36
      t_io_update_u_3_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
    else if (s1_update_bits_meta[39]) begin	// predictor.scala:184:30, tage.scala:236:52
      if (_new_u_T_33) begin	// tage.scala:237:73, :308:52
        if (_new_u_T_35)	// tage.scala:218:27
          t_io_update_u_3_REG_5 <= 2'h0;	// tage.scala:321:43, :351:47
        else	// tage.scala:218:27
          t_io_update_u_3_REG_5 <= _new_u_T_36;	// tage.scala:218:43, :351:47
      end
      else if (&(s1_update_bits_meta[35:34]))	// predictor.scala:184:30, tage.scala:219:27, :236:52
        t_io_update_u_3_REG_5 <= 2'h3;	// tage.scala:265:40, :351:47
      else	// tage.scala:219:27
        t_io_update_u_3_REG_5 <= _new_u_T_40;	// tage.scala:219:43, :351:47
    end
    else	// tage.scala:236:52
      t_io_update_u_3_REG_5 <= s1_update_bits_meta[35:34];	// predictor.scala:184:30, tage.scala:236:52, :351:47
    t_io_update_pc_REG_5 <= s1_update_bits_pc;	// predictor.scala:184:30, tage.scala:353:41
    t_io_update_hist_REG_5 <= s1_update_bits_ghist;	// predictor.scala:184:30, tage.scala:354:41
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:49];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h32; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_update_valid = _RANDOM[6'h5][6];	// predictor.scala:184:30
        s1_update_bits_is_mispredict_update = _RANDOM[6'h5][7];	// predictor.scala:184:30
        s1_update_bits_is_repair_update = _RANDOM[6'h5][8];	// predictor.scala:184:30
        s1_update_bits_btb_mispredicts = _RANDOM[6'h5][12:9];	// predictor.scala:184:30
        s1_update_bits_pc = {_RANDOM[6'h5][31:13], _RANDOM[6'h6][20:0]};	// predictor.scala:184:30
        s1_update_bits_br_mask = _RANDOM[6'h6][24:21];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_valid = _RANDOM[6'h6][25];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_bits = _RANDOM[6'h6][27:26];	// predictor.scala:184:30
        s1_update_bits_cfi_taken = _RANDOM[6'h6][28];	// predictor.scala:184:30
        s1_update_bits_cfi_mispredicted = _RANDOM[6'h6][29];	// predictor.scala:184:30
        s1_update_bits_ghist = {_RANDOM[6'h7][31:1], _RANDOM[6'h8], _RANDOM[6'h9][0]};	// predictor.scala:184:30
        s1_update_bits_meta =
          {_RANDOM[6'hA][31:10],
           _RANDOM[6'hB],
           _RANDOM[6'hC],
           _RANDOM[6'hD],
           _RANDOM[6'hE][1:0]};	// predictor.scala:184:30
        t_io_f1_req_valid_REG = _RANDOM[6'hF][8];	// tage.scala:225:35
        t_io_f1_req_pc_REG = {_RANDOM[6'hF][31:9], _RANDOM[6'h10][16:0]};	// tage.scala:225:35, :226:35
        t_io_f1_req_valid_REG_1 = _RANDOM[6'h10][17];	// tage.scala:225:35, :226:35
        t_io_f1_req_pc_REG_1 = {_RANDOM[6'h10][31:18], _RANDOM[6'h11][25:0]};	// tage.scala:226:35
        t_io_f1_req_valid_REG_2 = _RANDOM[6'h11][26];	// tage.scala:225:35, :226:35
        t_io_f1_req_pc_REG_2 =
          {_RANDOM[6'h11][31:27], _RANDOM[6'h12], _RANDOM[6'h13][2:0]};	// tage.scala:226:35
        t_io_f1_req_valid_REG_3 = _RANDOM[6'h13][3];	// tage.scala:225:35, :226:35
        t_io_f1_req_pc_REG_3 = {_RANDOM[6'h13][31:4], _RANDOM[6'h14][11:0]};	// tage.scala:226:35
        t_io_f1_req_valid_REG_4 = _RANDOM[6'h14][12];	// tage.scala:225:35, :226:35
        t_io_f1_req_pc_REG_4 = {_RANDOM[6'h14][31:13], _RANDOM[6'h15][20:0]};	// tage.scala:226:35
        t_io_f1_req_valid_REG_5 = _RANDOM[6'h15][21];	// tage.scala:225:35, :226:35
        t_io_f1_req_pc_REG_5 = {_RANDOM[6'h15][31:22], _RANDOM[6'h16][29:0]};	// tage.scala:226:35
        t_io_update_mask_0_REG = _RANDOM[6'h16][30];	// tage.scala:226:35, :345:48
        t_io_update_taken_0_REG = _RANDOM[6'h16][31];	// tage.scala:226:35, :346:48
        t_io_update_alloc_0_REG = _RANDOM[6'h17][0];	// tage.scala:347:48
        t_io_update_old_ctr_0_REG = _RANDOM[6'h17][3:1];	// tage.scala:347:48, :348:48
        t_io_update_u_mask_0_REG = _RANDOM[6'h17][4];	// tage.scala:347:48, :350:47
        t_io_update_u_0_REG = _RANDOM[6'h17][6:5];	// tage.scala:347:48, :351:47
        t_io_update_mask_1_REG = _RANDOM[6'h17][7];	// tage.scala:345:48, :347:48
        t_io_update_taken_1_REG = _RANDOM[6'h17][8];	// tage.scala:346:48, :347:48
        t_io_update_alloc_1_REG = _RANDOM[6'h17][9];	// tage.scala:347:48
        t_io_update_old_ctr_1_REG = _RANDOM[6'h17][12:10];	// tage.scala:347:48, :348:48
        t_io_update_u_mask_1_REG = _RANDOM[6'h17][13];	// tage.scala:347:48, :350:47
        t_io_update_u_1_REG = _RANDOM[6'h17][15:14];	// tage.scala:347:48, :351:47
        t_io_update_mask_2_REG = _RANDOM[6'h17][16];	// tage.scala:345:48, :347:48
        t_io_update_taken_2_REG = _RANDOM[6'h17][17];	// tage.scala:346:48, :347:48
        t_io_update_alloc_2_REG = _RANDOM[6'h17][18];	// tage.scala:347:48
        t_io_update_old_ctr_2_REG = _RANDOM[6'h17][21:19];	// tage.scala:347:48, :348:48
        t_io_update_u_mask_2_REG = _RANDOM[6'h17][22];	// tage.scala:347:48, :350:47
        t_io_update_u_2_REG = _RANDOM[6'h17][24:23];	// tage.scala:347:48, :351:47
        t_io_update_mask_3_REG = _RANDOM[6'h17][25];	// tage.scala:345:48, :347:48
        t_io_update_taken_3_REG = _RANDOM[6'h17][26];	// tage.scala:346:48, :347:48
        t_io_update_alloc_3_REG = _RANDOM[6'h17][27];	// tage.scala:347:48
        t_io_update_old_ctr_3_REG = _RANDOM[6'h17][30:28];	// tage.scala:347:48, :348:48
        t_io_update_u_mask_3_REG = _RANDOM[6'h17][31];	// tage.scala:347:48, :350:47
        t_io_update_u_3_REG = _RANDOM[6'h18][1:0];	// tage.scala:351:47
        t_io_update_pc_REG = {_RANDOM[6'h18][31:2], _RANDOM[6'h19][9:0]};	// tage.scala:351:47, :353:41
        t_io_update_hist_REG =
          {_RANDOM[6'h19][31:10], _RANDOM[6'h1A], _RANDOM[6'h1B][9:0]};	// tage.scala:353:41, :354:41
        t_io_update_mask_0_REG_1 = _RANDOM[6'h1B][10];	// tage.scala:345:48, :354:41
        t_io_update_taken_0_REG_1 = _RANDOM[6'h1B][11];	// tage.scala:346:48, :354:41
        t_io_update_alloc_0_REG_1 = _RANDOM[6'h1B][12];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_0_REG_1 = _RANDOM[6'h1B][15:13];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_0_REG_1 = _RANDOM[6'h1B][16];	// tage.scala:350:47, :354:41
        t_io_update_u_0_REG_1 = _RANDOM[6'h1B][18:17];	// tage.scala:351:47, :354:41
        t_io_update_mask_1_REG_1 = _RANDOM[6'h1B][19];	// tage.scala:345:48, :354:41
        t_io_update_taken_1_REG_1 = _RANDOM[6'h1B][20];	// tage.scala:346:48, :354:41
        t_io_update_alloc_1_REG_1 = _RANDOM[6'h1B][21];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_1_REG_1 = _RANDOM[6'h1B][24:22];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_1_REG_1 = _RANDOM[6'h1B][25];	// tage.scala:350:47, :354:41
        t_io_update_u_1_REG_1 = _RANDOM[6'h1B][27:26];	// tage.scala:351:47, :354:41
        t_io_update_mask_2_REG_1 = _RANDOM[6'h1B][28];	// tage.scala:345:48, :354:41
        t_io_update_taken_2_REG_1 = _RANDOM[6'h1B][29];	// tage.scala:346:48, :354:41
        t_io_update_alloc_2_REG_1 = _RANDOM[6'h1B][30];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_2_REG_1 = {_RANDOM[6'h1B][31], _RANDOM[6'h1C][1:0]};	// tage.scala:348:48, :354:41
        t_io_update_u_mask_2_REG_1 = _RANDOM[6'h1C][2];	// tage.scala:348:48, :350:47
        t_io_update_u_2_REG_1 = _RANDOM[6'h1C][4:3];	// tage.scala:348:48, :351:47
        t_io_update_mask_3_REG_1 = _RANDOM[6'h1C][5];	// tage.scala:345:48, :348:48
        t_io_update_taken_3_REG_1 = _RANDOM[6'h1C][6];	// tage.scala:346:48, :348:48
        t_io_update_alloc_3_REG_1 = _RANDOM[6'h1C][7];	// tage.scala:347:48, :348:48
        t_io_update_old_ctr_3_REG_1 = _RANDOM[6'h1C][10:8];	// tage.scala:348:48
        t_io_update_u_mask_3_REG_1 = _RANDOM[6'h1C][11];	// tage.scala:348:48, :350:47
        t_io_update_u_3_REG_1 = _RANDOM[6'h1C][13:12];	// tage.scala:348:48, :351:47
        t_io_update_pc_REG_1 = {_RANDOM[6'h1C][31:14], _RANDOM[6'h1D][21:0]};	// tage.scala:348:48, :353:41
        t_io_update_hist_REG_1 =
          {_RANDOM[6'h1D][31:22], _RANDOM[6'h1E], _RANDOM[6'h1F][21:0]};	// tage.scala:353:41, :354:41
        t_io_update_mask_0_REG_2 = _RANDOM[6'h1F][22];	// tage.scala:345:48, :354:41
        t_io_update_taken_0_REG_2 = _RANDOM[6'h1F][23];	// tage.scala:346:48, :354:41
        t_io_update_alloc_0_REG_2 = _RANDOM[6'h1F][24];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_0_REG_2 = _RANDOM[6'h1F][27:25];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_0_REG_2 = _RANDOM[6'h1F][28];	// tage.scala:350:47, :354:41
        t_io_update_u_0_REG_2 = _RANDOM[6'h1F][30:29];	// tage.scala:351:47, :354:41
        t_io_update_mask_1_REG_2 = _RANDOM[6'h1F][31];	// tage.scala:345:48, :354:41
        t_io_update_taken_1_REG_2 = _RANDOM[6'h20][0];	// tage.scala:346:48
        t_io_update_alloc_1_REG_2 = _RANDOM[6'h20][1];	// tage.scala:346:48, :347:48
        t_io_update_old_ctr_1_REG_2 = _RANDOM[6'h20][4:2];	// tage.scala:346:48, :348:48
        t_io_update_u_mask_1_REG_2 = _RANDOM[6'h20][5];	// tage.scala:346:48, :350:47
        t_io_update_u_1_REG_2 = _RANDOM[6'h20][7:6];	// tage.scala:346:48, :351:47
        t_io_update_mask_2_REG_2 = _RANDOM[6'h20][8];	// tage.scala:345:48, :346:48
        t_io_update_taken_2_REG_2 = _RANDOM[6'h20][9];	// tage.scala:346:48
        t_io_update_alloc_2_REG_2 = _RANDOM[6'h20][10];	// tage.scala:346:48, :347:48
        t_io_update_old_ctr_2_REG_2 = _RANDOM[6'h20][13:11];	// tage.scala:346:48, :348:48
        t_io_update_u_mask_2_REG_2 = _RANDOM[6'h20][14];	// tage.scala:346:48, :350:47
        t_io_update_u_2_REG_2 = _RANDOM[6'h20][16:15];	// tage.scala:346:48, :351:47
        t_io_update_mask_3_REG_2 = _RANDOM[6'h20][17];	// tage.scala:345:48, :346:48
        t_io_update_taken_3_REG_2 = _RANDOM[6'h20][18];	// tage.scala:346:48
        t_io_update_alloc_3_REG_2 = _RANDOM[6'h20][19];	// tage.scala:346:48, :347:48
        t_io_update_old_ctr_3_REG_2 = _RANDOM[6'h20][22:20];	// tage.scala:346:48, :348:48
        t_io_update_u_mask_3_REG_2 = _RANDOM[6'h20][23];	// tage.scala:346:48, :350:47
        t_io_update_u_3_REG_2 = _RANDOM[6'h20][25:24];	// tage.scala:346:48, :351:47
        t_io_update_pc_REG_2 =
          {_RANDOM[6'h20][31:26], _RANDOM[6'h21], _RANDOM[6'h22][1:0]};	// tage.scala:346:48, :353:41
        t_io_update_hist_REG_2 =
          {_RANDOM[6'h22][31:2], _RANDOM[6'h23], _RANDOM[6'h24][1:0]};	// tage.scala:353:41, :354:41
        t_io_update_mask_0_REG_3 = _RANDOM[6'h24][2];	// tage.scala:345:48, :354:41
        t_io_update_taken_0_REG_3 = _RANDOM[6'h24][3];	// tage.scala:346:48, :354:41
        t_io_update_alloc_0_REG_3 = _RANDOM[6'h24][4];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_0_REG_3 = _RANDOM[6'h24][7:5];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_0_REG_3 = _RANDOM[6'h24][8];	// tage.scala:350:47, :354:41
        t_io_update_u_0_REG_3 = _RANDOM[6'h24][10:9];	// tage.scala:351:47, :354:41
        t_io_update_mask_1_REG_3 = _RANDOM[6'h24][11];	// tage.scala:345:48, :354:41
        t_io_update_taken_1_REG_3 = _RANDOM[6'h24][12];	// tage.scala:346:48, :354:41
        t_io_update_alloc_1_REG_3 = _RANDOM[6'h24][13];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_1_REG_3 = _RANDOM[6'h24][16:14];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_1_REG_3 = _RANDOM[6'h24][17];	// tage.scala:350:47, :354:41
        t_io_update_u_1_REG_3 = _RANDOM[6'h24][19:18];	// tage.scala:351:47, :354:41
        t_io_update_mask_2_REG_3 = _RANDOM[6'h24][20];	// tage.scala:345:48, :354:41
        t_io_update_taken_2_REG_3 = _RANDOM[6'h24][21];	// tage.scala:346:48, :354:41
        t_io_update_alloc_2_REG_3 = _RANDOM[6'h24][22];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_2_REG_3 = _RANDOM[6'h24][25:23];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_2_REG_3 = _RANDOM[6'h24][26];	// tage.scala:350:47, :354:41
        t_io_update_u_2_REG_3 = _RANDOM[6'h24][28:27];	// tage.scala:351:47, :354:41
        t_io_update_mask_3_REG_3 = _RANDOM[6'h24][29];	// tage.scala:345:48, :354:41
        t_io_update_taken_3_REG_3 = _RANDOM[6'h24][30];	// tage.scala:346:48, :354:41
        t_io_update_alloc_3_REG_3 = _RANDOM[6'h24][31];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_3_REG_3 = _RANDOM[6'h25][2:0];	// tage.scala:348:48
        t_io_update_u_mask_3_REG_3 = _RANDOM[6'h25][3];	// tage.scala:348:48, :350:47
        t_io_update_u_3_REG_3 = _RANDOM[6'h25][5:4];	// tage.scala:348:48, :351:47
        t_io_update_pc_REG_3 = {_RANDOM[6'h25][31:6], _RANDOM[6'h26][13:0]};	// tage.scala:348:48, :353:41
        t_io_update_hist_REG_3 =
          {_RANDOM[6'h26][31:14], _RANDOM[6'h27], _RANDOM[6'h28][13:0]};	// tage.scala:353:41, :354:41
        t_io_update_mask_0_REG_4 = _RANDOM[6'h28][14];	// tage.scala:345:48, :354:41
        t_io_update_taken_0_REG_4 = _RANDOM[6'h28][15];	// tage.scala:346:48, :354:41
        t_io_update_alloc_0_REG_4 = _RANDOM[6'h28][16];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_0_REG_4 = _RANDOM[6'h28][19:17];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_0_REG_4 = _RANDOM[6'h28][20];	// tage.scala:350:47, :354:41
        t_io_update_u_0_REG_4 = _RANDOM[6'h28][22:21];	// tage.scala:351:47, :354:41
        t_io_update_mask_1_REG_4 = _RANDOM[6'h28][23];	// tage.scala:345:48, :354:41
        t_io_update_taken_1_REG_4 = _RANDOM[6'h28][24];	// tage.scala:346:48, :354:41
        t_io_update_alloc_1_REG_4 = _RANDOM[6'h28][25];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_1_REG_4 = _RANDOM[6'h28][28:26];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_1_REG_4 = _RANDOM[6'h28][29];	// tage.scala:350:47, :354:41
        t_io_update_u_1_REG_4 = _RANDOM[6'h28][31:30];	// tage.scala:351:47, :354:41
        t_io_update_mask_2_REG_4 = _RANDOM[6'h29][0];	// tage.scala:345:48
        t_io_update_taken_2_REG_4 = _RANDOM[6'h29][1];	// tage.scala:345:48, :346:48
        t_io_update_alloc_2_REG_4 = _RANDOM[6'h29][2];	// tage.scala:345:48, :347:48
        t_io_update_old_ctr_2_REG_4 = _RANDOM[6'h29][5:3];	// tage.scala:345:48, :348:48
        t_io_update_u_mask_2_REG_4 = _RANDOM[6'h29][6];	// tage.scala:345:48, :350:47
        t_io_update_u_2_REG_4 = _RANDOM[6'h29][8:7];	// tage.scala:345:48, :351:47
        t_io_update_mask_3_REG_4 = _RANDOM[6'h29][9];	// tage.scala:345:48
        t_io_update_taken_3_REG_4 = _RANDOM[6'h29][10];	// tage.scala:345:48, :346:48
        t_io_update_alloc_3_REG_4 = _RANDOM[6'h29][11];	// tage.scala:345:48, :347:48
        t_io_update_old_ctr_3_REG_4 = _RANDOM[6'h29][14:12];	// tage.scala:345:48, :348:48
        t_io_update_u_mask_3_REG_4 = _RANDOM[6'h29][15];	// tage.scala:345:48, :350:47
        t_io_update_u_3_REG_4 = _RANDOM[6'h29][17:16];	// tage.scala:345:48, :351:47
        t_io_update_pc_REG_4 = {_RANDOM[6'h29][31:18], _RANDOM[6'h2A][25:0]};	// tage.scala:345:48, :353:41
        t_io_update_hist_REG_4 =
          {_RANDOM[6'h2A][31:26], _RANDOM[6'h2B], _RANDOM[6'h2C][25:0]};	// tage.scala:353:41, :354:41
        t_io_update_mask_0_REG_5 = _RANDOM[6'h2C][26];	// tage.scala:345:48, :354:41
        t_io_update_taken_0_REG_5 = _RANDOM[6'h2C][27];	// tage.scala:346:48, :354:41
        t_io_update_alloc_0_REG_5 = _RANDOM[6'h2C][28];	// tage.scala:347:48, :354:41
        t_io_update_old_ctr_0_REG_5 = _RANDOM[6'h2C][31:29];	// tage.scala:348:48, :354:41
        t_io_update_u_mask_0_REG_5 = _RANDOM[6'h2D][0];	// tage.scala:350:47
        t_io_update_u_0_REG_5 = _RANDOM[6'h2D][2:1];	// tage.scala:350:47, :351:47
        t_io_update_mask_1_REG_5 = _RANDOM[6'h2D][3];	// tage.scala:345:48, :350:47
        t_io_update_taken_1_REG_5 = _RANDOM[6'h2D][4];	// tage.scala:346:48, :350:47
        t_io_update_alloc_1_REG_5 = _RANDOM[6'h2D][5];	// tage.scala:347:48, :350:47
        t_io_update_old_ctr_1_REG_5 = _RANDOM[6'h2D][8:6];	// tage.scala:348:48, :350:47
        t_io_update_u_mask_1_REG_5 = _RANDOM[6'h2D][9];	// tage.scala:350:47
        t_io_update_u_1_REG_5 = _RANDOM[6'h2D][11:10];	// tage.scala:350:47, :351:47
        t_io_update_mask_2_REG_5 = _RANDOM[6'h2D][12];	// tage.scala:345:48, :350:47
        t_io_update_taken_2_REG_5 = _RANDOM[6'h2D][13];	// tage.scala:346:48, :350:47
        t_io_update_alloc_2_REG_5 = _RANDOM[6'h2D][14];	// tage.scala:347:48, :350:47
        t_io_update_old_ctr_2_REG_5 = _RANDOM[6'h2D][17:15];	// tage.scala:348:48, :350:47
        t_io_update_u_mask_2_REG_5 = _RANDOM[6'h2D][18];	// tage.scala:350:47
        t_io_update_u_2_REG_5 = _RANDOM[6'h2D][20:19];	// tage.scala:350:47, :351:47
        t_io_update_mask_3_REG_5 = _RANDOM[6'h2D][21];	// tage.scala:345:48, :350:47
        t_io_update_taken_3_REG_5 = _RANDOM[6'h2D][22];	// tage.scala:346:48, :350:47
        t_io_update_alloc_3_REG_5 = _RANDOM[6'h2D][23];	// tage.scala:347:48, :350:47
        t_io_update_old_ctr_3_REG_5 = _RANDOM[6'h2D][26:24];	// tage.scala:348:48, :350:47
        t_io_update_u_mask_3_REG_5 = _RANDOM[6'h2D][27];	// tage.scala:350:47
        t_io_update_u_3_REG_5 = _RANDOM[6'h2D][29:28];	// tage.scala:350:47, :351:47
        t_io_update_pc_REG_5 =
          {_RANDOM[6'h2D][31:30], _RANDOM[6'h2E], _RANDOM[6'h2F][5:0]};	// tage.scala:350:47, :353:41
        t_io_update_hist_REG_5 =
          {_RANDOM[6'h2F][31:6], _RANDOM[6'h30], _RANDOM[6'h31][5:0]};	// tage.scala:353:41, :354:41
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TageTable_24 tables_0 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_0_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_0_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_0_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_0_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_0_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_0_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_0_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_0_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_0_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_0_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_0_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_0_io_f3_resp_3_bits_u)
  );
  TageTable_25 tables_1 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_1),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG_1),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_1),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG_1),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG_1),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG_1),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG_1),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG_1),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG_1),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG_1),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG_1),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG_1),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG_1),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG_1),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_1),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_1),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_1),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_1),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG_1),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG_1),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_1),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_1),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_1),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_1),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG_1),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG_1),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG_1),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG_1),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_1_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_1_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_1_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_1_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_1_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_1_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_1_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_1_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_1_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_1_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_1_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_1_io_f3_resp_3_bits_u)
  );
  TageTable_26 tables_2 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_2),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG_2),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_2),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG_2),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG_2),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG_2),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG_2),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG_2),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG_2),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG_2),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG_2),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG_2),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG_2),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG_2),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_2),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_2),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_2),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_2),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG_2),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG_2),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_2),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_2),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_2),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_2),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG_2),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG_2),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG_2),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG_2),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_2_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_2_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_2_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_2_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_2_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_2_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_2_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_2_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_2_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_2_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_2_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_2_io_f3_resp_3_bits_u)
  );
  TageTable_27 tables_3 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_3),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG_3),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_3),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG_3),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG_3),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG_3),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG_3),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG_3),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG_3),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG_3),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG_3),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG_3),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG_3),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG_3),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_3),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_3),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_3),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_3),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG_3),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG_3),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_3),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_3),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_3),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_3),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG_3),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG_3),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG_3),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG_3),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_3_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_3_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_3_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_3_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_3_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_3_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_3_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_3_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_3_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_3_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_3_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_3_io_f3_resp_3_bits_u)
  );
  TageTable_28 tables_4 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_4),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG_4),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_4),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG_4),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG_4),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG_4),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG_4),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG_4),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG_4),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG_4),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG_4),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG_4),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG_4),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG_4),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_4),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_4),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_4),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_4),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG_4),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG_4),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_4),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_4),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_4),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_4),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG_4),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG_4),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG_4),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG_4),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_4_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_4_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_4_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_4_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_4_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_4_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_4_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_4_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_4_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_4_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_4_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_4_io_f3_resp_3_bits_u)
  );
  TageTable_29 tables_5 (	// tage.scala:224:21
    .clock                 (clock),
    .reset                 (reset),
    .io_f1_req_valid       (t_io_f1_req_valid_REG_5),	// tage.scala:225:35
    .io_f1_req_pc          (t_io_f1_req_pc_REG_5),	// tage.scala:226:35
    .io_f1_req_ghist       (io_f1_ghist),
    .io_update_mask_0      (t_io_update_mask_0_REG_5),	// tage.scala:345:48
    .io_update_mask_1      (t_io_update_mask_1_REG_5),	// tage.scala:345:48
    .io_update_mask_2      (t_io_update_mask_2_REG_5),	// tage.scala:345:48
    .io_update_mask_3      (t_io_update_mask_3_REG_5),	// tage.scala:345:48
    .io_update_taken_0     (t_io_update_taken_0_REG_5),	// tage.scala:346:48
    .io_update_taken_1     (t_io_update_taken_1_REG_5),	// tage.scala:346:48
    .io_update_taken_2     (t_io_update_taken_2_REG_5),	// tage.scala:346:48
    .io_update_taken_3     (t_io_update_taken_3_REG_5),	// tage.scala:346:48
    .io_update_alloc_0     (t_io_update_alloc_0_REG_5),	// tage.scala:347:48
    .io_update_alloc_1     (t_io_update_alloc_1_REG_5),	// tage.scala:347:48
    .io_update_alloc_2     (t_io_update_alloc_2_REG_5),	// tage.scala:347:48
    .io_update_alloc_3     (t_io_update_alloc_3_REG_5),	// tage.scala:347:48
    .io_update_old_ctr_0   (t_io_update_old_ctr_0_REG_5),	// tage.scala:348:48
    .io_update_old_ctr_1   (t_io_update_old_ctr_1_REG_5),	// tage.scala:348:48
    .io_update_old_ctr_2   (t_io_update_old_ctr_2_REG_5),	// tage.scala:348:48
    .io_update_old_ctr_3   (t_io_update_old_ctr_3_REG_5),	// tage.scala:348:48
    .io_update_pc          (t_io_update_pc_REG_5),	// tage.scala:353:41
    .io_update_hist        (t_io_update_hist_REG_5),	// tage.scala:354:41
    .io_update_u_mask_0    (t_io_update_u_mask_0_REG_5),	// tage.scala:350:47
    .io_update_u_mask_1    (t_io_update_u_mask_1_REG_5),	// tage.scala:350:47
    .io_update_u_mask_2    (t_io_update_u_mask_2_REG_5),	// tage.scala:350:47
    .io_update_u_mask_3    (t_io_update_u_mask_3_REG_5),	// tage.scala:350:47
    .io_update_u_0         (t_io_update_u_0_REG_5),	// tage.scala:351:47
    .io_update_u_1         (t_io_update_u_1_REG_5),	// tage.scala:351:47
    .io_update_u_2         (t_io_update_u_2_REG_5),	// tage.scala:351:47
    .io_update_u_3         (t_io_update_u_3_REG_5),	// tage.scala:351:47
    .io_f3_resp_0_valid    (_tables_5_io_f3_resp_0_valid),
    .io_f3_resp_0_bits_ctr (_tables_5_io_f3_resp_0_bits_ctr),
    .io_f3_resp_0_bits_u   (_tables_5_io_f3_resp_0_bits_u),
    .io_f3_resp_1_valid    (_tables_5_io_f3_resp_1_valid),
    .io_f3_resp_1_bits_ctr (_tables_5_io_f3_resp_1_bits_ctr),
    .io_f3_resp_1_bits_u   (_tables_5_io_f3_resp_1_bits_u),
    .io_f3_resp_2_valid    (_tables_5_io_f3_resp_2_valid),
    .io_f3_resp_2_bits_ctr (_tables_5_io_f3_resp_2_bits_ctr),
    .io_f3_resp_2_bits_u   (_tables_5_io_f3_resp_2_bits_u),
    .io_f3_resp_3_valid    (_tables_5_io_f3_resp_3_valid),
    .io_f3_resp_3_bits_ctr (_tables_5_io_f3_resp_3_bits_ctr),
    .io_f3_resp_3_bits_u   (_tables_5_io_f3_resp_3_bits_u)
  );
  MaxPeriodFibonacciLFSR_7 alloc_lfsr_prng (	// PRNG.scala:82:22
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_io_out_5)
  );
  MaxPeriodFibonacciLFSR_7 alloc_lfsr_prng_1 (	// PRNG.scala:82:22
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_1_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_1_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_1_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_1_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_1_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_1_io_out_5)
  );
  MaxPeriodFibonacciLFSR_7 alloc_lfsr_prng_2 (	// PRNG.scala:82:22
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_2_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_2_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_2_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_2_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_2_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_2_io_out_5)
  );
  MaxPeriodFibonacciLFSR_7 alloc_lfsr_prng_3 (	// PRNG.scala:82:22
    .clock    (clock),
    .reset    (reset),
    .io_out_0 (_alloc_lfsr_prng_3_io_out_0),
    .io_out_1 (_alloc_lfsr_prng_3_io_out_1),
    .io_out_2 (_alloc_lfsr_prng_3_io_out_2),
    .io_out_3 (_alloc_lfsr_prng_3_io_out_3),
    .io_out_4 (_alloc_lfsr_prng_3_io_out_4),
    .io_out_5 (_alloc_lfsr_prng_3_io_out_5)
  );
  assign io_resp_f3_0_taken = _io_resp_f3_0_taken_output;	// tage.scala:264:18, :265:29
  assign io_resp_f3_1_taken = _io_resp_f3_1_taken_output;	// tage.scala:264:18, :265:29
  assign io_resp_f3_2_taken = _io_resp_f3_2_taken_output;	// tage.scala:264:18, :265:29
  assign io_resp_f3_3_taken = _io_resp_f3_3_taken_output;	// tage.scala:264:18, :265:29
  assign io_f3_meta =
    {64'h0,
     f3_meta_provider_3_valid,
     f3_meta_provider_3_bits,
     f3_meta_provider_2_valid,
     f3_meta_provider_2_bits,
     f3_meta_provider_1_valid,
     f3_meta_provider_1_bits,
     f3_meta_provider_0_valid,
     f3_meta_provider_0_bits,
     (_tables_5_io_f3_resp_3_valid
        ? _GEN_45
        : _tables_4_io_f3_resp_3_valid
            ? _GEN_44
            : _tables_3_io_f3_resp_3_valid
                ? _GEN_43
                : _tables_2_io_f3_resp_3_valid
                    ? _GEN_42
                    : _tables_1_io_f3_resp_3_valid & _tables_0_io_f3_resp_3_valid
                        ? _tables_0_io_f3_resp_3_bits_ctr[2]
                        : io_resp_in_0_f3_3_taken) != _io_resp_f3_3_taken_output,
     (_tables_5_io_f3_resp_2_valid
        ? _GEN_31
        : _tables_4_io_f3_resp_2_valid
            ? _GEN_30
            : _tables_3_io_f3_resp_2_valid
                ? _GEN_29
                : _tables_2_io_f3_resp_2_valid
                    ? _GEN_28
                    : _tables_1_io_f3_resp_2_valid & _tables_0_io_f3_resp_2_valid
                        ? _tables_0_io_f3_resp_2_bits_ctr[2]
                        : io_resp_in_0_f3_2_taken) != _io_resp_f3_2_taken_output,
     (_tables_5_io_f3_resp_1_valid
        ? _GEN_17
        : _tables_4_io_f3_resp_1_valid
            ? _GEN_16
            : _tables_3_io_f3_resp_1_valid
                ? _GEN_15
                : _tables_2_io_f3_resp_1_valid
                    ? _GEN_14
                    : _tables_1_io_f3_resp_1_valid & _tables_0_io_f3_resp_1_valid
                        ? _tables_0_io_f3_resp_1_bits_ctr[2]
                        : io_resp_in_0_f3_1_taken) != _io_resp_f3_1_taken_output,
     (_tables_5_io_f3_resp_0_valid
        ? _GEN_3
        : _tables_4_io_f3_resp_0_valid
            ? _GEN_2
            : _tables_3_io_f3_resp_0_valid
                ? _GEN_1
                : _tables_2_io_f3_resp_0_valid
                    ? _GEN_0
                    : _tables_1_io_f3_resp_0_valid & _tables_0_io_f3_resp_0_valid
                        ? _tables_0_io_f3_resp_0_bits_ctr[2]
                        : io_resp_in_0_f3_0_taken) != _io_resp_f3_0_taken_output,
     _GEN_47[f3_meta_provider_3_bits],
     _GEN_33[f3_meta_provider_2_bits],
     _GEN_19[f3_meta_provider_1_bits],
     _GEN_5[f3_meta_provider_0_bits],
     _GEN_46[f3_meta_provider_3_bits],
     _GEN_32[f3_meta_provider_2_bits],
     _GEN_18[f3_meta_provider_1_bits],
     _GEN_4[f3_meta_provider_0_bits],
     |_GEN_53,
     _alloc_entry_T_6[0]
       ? masked_entry_3
       : _GEN_53[0]
           ? 3'h0
           : _GEN_53[1]
               ? 3'h1
               : _GEN_53[2]
                   ? 3'h2
                   : _GEN_53[3] ? 3'h3 : _GEN_53[4] ? 3'h4 : {1'h1, ~(_GEN_53[5]), 1'h1},
     |_GEN_39,
     _alloc_entry_T_4[0]
       ? masked_entry_2
       : _GEN_39[0]
           ? 3'h0
           : _GEN_39[1]
               ? 3'h1
               : _GEN_39[2]
                   ? 3'h2
                   : _GEN_39[3] ? 3'h3 : _GEN_39[4] ? 3'h4 : {1'h1, ~(_GEN_39[5]), 1'h1},
     |_GEN_25,
     _alloc_entry_T_2[0]
       ? masked_entry_1
       : _GEN_25[0]
           ? 3'h0
           : _GEN_25[1]
               ? 3'h1
               : _GEN_25[2]
                   ? 3'h2
                   : _GEN_25[3] ? 3'h3 : _GEN_25[4] ? 3'h4 : {1'h1, ~(_GEN_25[5]), 1'h1},
     |_GEN_11,
     _alloc_entry_T[0]
       ? masked_entry
       : _GEN_11[0]
           ? 3'h0
           : _GEN_11[1]
               ? 3'h1
               : _GEN_11[2]
                   ? 3'h2
                   : _GEN_11[3] ? 3'h3 : _GEN_11[4] ? 3'h4 : {1'h1, ~(_GEN_11[5]), 1'h1}};	// Mux.scala:47:69, OneHot.scala:47:40, :58:35, tage.scala:224:21, :264:18, :265:{29,55}, :266:29, :269:27, :270:21, :271:{21,50}, :275:48, :276:31, :282:77, :289:{26,44}, :293:52, :303:37, :359:14
endmodule

