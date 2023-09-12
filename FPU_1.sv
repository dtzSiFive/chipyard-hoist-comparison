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

module FPU_1(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input  [2:0]  io_req_bits_fcsr_rm,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  wire        _fpmu_io_out_valid;	// fpu.scala:222:20
  wire [64:0] _fpmu_io_out_bits_data;	// fpu.scala:222:20
  wire [4:0]  _fpmu_io_out_bits_exc;	// fpu.scala:222:20
  wire        _fpiu_io_out_bits_lt;	// fpu.scala:213:20
  wire [63:0] _fpiu_io_out_bits_toint;	// fpu.scala:213:20
  wire [4:0]  _fpiu_io_out_bits_exc;	// fpu.scala:213:20
  wire [1:0]  _sfma_io_in_bits_fma_decoder_io_cmd;	// fpu.scala:199:29
  wire        _sfma_io_out_valid;	// fpu.scala:209:20
  wire [64:0] _sfma_io_out_bits_data;	// fpu.scala:209:20
  wire [4:0]  _sfma_io_out_bits_exc;	// fpu.scala:209:20
  wire [1:0]  _dfma_io_in_bits_fma_decoder_io_cmd;	// fpu.scala:199:29
  wire        _dfma_io_out_valid;	// fpu.scala:205:20
  wire [64:0] _dfma_io_out_bits_data;	// fpu.scala:205:20
  wire [4:0]  _dfma_io_out_bits_exc;	// fpu.scala:205:20
  wire        _fp_decoder_io_sigs_ren2;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_ren3;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_swap23;	// fpu.scala:179:26
  wire [1:0]  _fp_decoder_io_sigs_typeTagIn;	// fpu.scala:179:26
  wire [1:0]  _fp_decoder_io_sigs_typeTagOut;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_toint;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_fastpipe;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_fma;	// fpu.scala:179:26
  wire        _fp_decoder_io_sigs_wflags;	// fpu.scala:179:26
  wire [2:0]  fpiu_io_in_bits_req_rm =
    (&(io_req_bits_uop_imm_packed[2:0]))
      ? io_req_bits_fcsr_rm
      : io_req_bits_uop_imm_packed[2:0];	// fpu.scala:182:{18,51}, util.scala:289:58
  wire        _sfma_io_in_valid_T = io_req_valid & _fp_decoder_io_sigs_fma;	// fpu.scala:179:26, :206:36
  wire        _fpmu_double_T_1 = _fp_decoder_io_sigs_typeTagOut == 2'h1;	// fpu.scala:179:26, :206:74
  wire [32:0] _sfma_io_in_bits_req_in2_T_1 =
    {io_req_bits_rs2_data[31], io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:0]}
    | ((&(io_req_bits_rs2_data[64:60])) ? 33'h0 : 33'hE0400000);	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}
  wire        _fpiu_io_in_valid_T_2 =
    io_req_valid
    & (_fp_decoder_io_sigs_toint | _fp_decoder_io_sigs_fastpipe
       & _fp_decoder_io_sigs_wflags);	// fpu.scala:179:26, :214:{36,54,75}
  wire [2:0]  fpiu_io_in_bits_req_in1_expOut_hi =
    {io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:29]};	// FPU.scala:270:18, :273:26, :353:14
  wire [11:0] _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2 =
    {3'h0, io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:23]} + 12'h700;	// FPU.scala:270:18, :274:{31,48}, :275:19, :353:14
  wire [64:0] fpiu_io_in_bits_req_in1 =
    _fp_decoder_io_sigs_typeTagIn[0] | (&(io_req_bits_rs1_data[64:60]))
      ? (_fp_decoder_io_sigs_typeTagIn[0]
           ? io_req_bits_rs1_data
           : {io_req_bits_rs1_data[31],
              fpiu_io_in_bits_req_in1_expOut_hi == 3'h0
              | fpiu_io_in_bits_req_in1_expOut_hi > 3'h5
                ? {io_req_bits_rs1_data[52],
                   io_req_bits_rs1_data[30:29],
                   _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2[8:0]}
                : _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2,
              io_req_bits_rs1_data[22:0],
              29'h0})
      : 65'hE008000000000000;	// Cat.scala:30:58, FPU.scala:269:20, :270:18, :271:38, :273:26, :274:48, :275:{10,19,25,36,65}, :327:{49,84}, :352:14, :353:14, :364:10, :367:31, fpu.scala:179:26, package.scala:31:49, :32:76
  wire [2:0]  fpiu_io_in_bits_req_in2_expOut_hi =
    {io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:29]};	// FPU.scala:270:18, :273:26, :353:14
  wire [11:0] _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2 =
    {3'h0, io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:23]} + 12'h700;	// FPU.scala:270:18, :274:{31,48}, :275:19, :353:14
  wire [64:0] fpiu_io_in_bits_req_in2 =
    _fp_decoder_io_sigs_typeTagIn[0] | (&(io_req_bits_rs2_data[64:60]))
      ? (_fp_decoder_io_sigs_typeTagIn[0]
           ? io_req_bits_rs2_data
           : {io_req_bits_rs2_data[31],
              fpiu_io_in_bits_req_in2_expOut_hi == 3'h0
              | fpiu_io_in_bits_req_in2_expOut_hi > 3'h5
                ? {io_req_bits_rs2_data[52],
                   io_req_bits_rs2_data[30:29],
                   _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2[8:0]}
                : _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2,
              io_req_bits_rs2_data[22:0],
              29'h0})
      : 65'hE008000000000000;	// Cat.scala:30:58, FPU.scala:269:20, :270:18, :271:38, :273:26, :274:48, :275:{10,19,25,36,65}, :327:{49,84}, :352:14, :353:14, :364:10, :367:31, fpu.scala:179:26, package.scala:31:49, :32:76
  reg         fpiu_out_REG;	// fpu.scala:216:30
  reg         fpiu_outPipe_valid;	// Valid.scala:117:22
  reg  [63:0] fpiu_outPipe_bits_toint;	// Reg.scala:15:16
  reg  [4:0]  fpiu_outPipe_bits_exc;	// Reg.scala:15:16
  reg         fpiu_outPipe_valid_1;	// Valid.scala:117:22
  reg  [63:0] fpiu_outPipe_bits_1_toint;	// Reg.scala:15:16
  reg  [4:0]  fpiu_outPipe_bits_1_exc;	// Reg.scala:15:16
  reg         fpiu_outPipe_valid_2;	// Valid.scala:117:22
  reg  [63:0] fpiu_outPipe_bits_2_toint;	// Reg.scala:15:16
  reg  [4:0]  fpiu_outPipe_bits_2_exc;	// Reg.scala:15:16
  wire        _fpmu_double_T = io_req_valid & _fp_decoder_io_sigs_fastpipe;	// fpu.scala:179:26, :223:36
  reg         fpmu_double_v;	// Valid.scala:117:22
  reg         fpmu_double_b;	// Reg.scala:15:16
  reg         fpmu_double_outPipe_valid;	// Valid.scala:117:22
  reg         fpmu_double_outPipe_bits;	// Reg.scala:15:16
  reg         fpmu_double_outPipe_valid_1;	// Valid.scala:117:22
  reg         fpmu_double_outPipe_bits_1;	// Reg.scala:15:16
  reg         fpmu_double_outPipe_bits_2;	// Reg.scala:15:16
  always @(posedge clock) begin
    fpiu_out_REG <= _fpiu_io_in_valid_T_2 & ~_fp_decoder_io_sigs_fastpipe;	// fpu.scala:179:26, :214:36, :216:{30,48,51}
    if (fpiu_out_REG) begin	// fpu.scala:216:30
      fpiu_outPipe_bits_toint <= _fpiu_io_out_bits_toint;	// Reg.scala:15:16, fpu.scala:213:20
      fpiu_outPipe_bits_exc <= _fpiu_io_out_bits_exc;	// Reg.scala:15:16, fpu.scala:213:20
    end
    if (fpiu_outPipe_valid) begin	// Valid.scala:117:22
      fpiu_outPipe_bits_1_toint <= fpiu_outPipe_bits_toint;	// Reg.scala:15:16
      fpiu_outPipe_bits_1_exc <= fpiu_outPipe_bits_exc;	// Reg.scala:15:16
    end
    if (fpiu_outPipe_valid_1) begin	// Valid.scala:117:22
      fpiu_outPipe_bits_2_toint <= fpiu_outPipe_bits_1_toint;	// Reg.scala:15:16
      fpiu_outPipe_bits_2_exc <= fpiu_outPipe_bits_1_exc;	// Reg.scala:15:16
    end
    if (_fpmu_double_T)	// fpu.scala:223:36
      fpmu_double_b <= _fpmu_double_T_1;	// Reg.scala:15:16, fpu.scala:206:74
    if (fpmu_double_v)	// Valid.scala:117:22
      fpmu_double_outPipe_bits <= fpmu_double_b;	// Reg.scala:15:16
    if (fpmu_double_outPipe_valid)	// Valid.scala:117:22
      fpmu_double_outPipe_bits_1 <= fpmu_double_outPipe_bits;	// Reg.scala:15:16
    if (fpmu_double_outPipe_valid_1)	// Valid.scala:117:22
      fpmu_double_outPipe_bits_2 <= fpmu_double_outPipe_bits_1;	// Reg.scala:15:16
    if (reset) begin
      fpiu_outPipe_valid <= 1'h0;	// Valid.scala:117:22
      fpiu_outPipe_valid_1 <= 1'h0;	// Valid.scala:117:22
      fpiu_outPipe_valid_2 <= 1'h0;	// Valid.scala:117:22
      fpmu_double_v <= 1'h0;	// Valid.scala:117:22
      fpmu_double_outPipe_valid <= 1'h0;	// Valid.scala:117:22
      fpmu_double_outPipe_valid_1 <= 1'h0;	// Valid.scala:117:22
    end
    else begin
      fpiu_outPipe_valid <= fpiu_out_REG;	// Valid.scala:117:22, fpu.scala:216:30
      fpiu_outPipe_valid_1 <= fpiu_outPipe_valid;	// Valid.scala:117:22
      fpiu_outPipe_valid_2 <= fpiu_outPipe_valid_1;	// Valid.scala:117:22
      fpmu_double_v <= _fpmu_double_T;	// Valid.scala:117:22, fpu.scala:223:36
      fpmu_double_outPipe_valid <= fpmu_double_v;	// Valid.scala:117:22
      fpmu_double_outPipe_valid_1 <= fpmu_double_outPipe_valid;	// Valid.scala:117:22
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:33];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h22; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        fpiu_out_REG = _RANDOM[6'h0][0];	// fpu.scala:216:30
        fpiu_outPipe_valid = _RANDOM[6'h0][1];	// Valid.scala:117:22, fpu.scala:216:30
        fpiu_outPipe_bits_toint = {_RANDOM[6'h9][31:1], _RANDOM[6'hA], _RANDOM[6'hB][0]};	// Reg.scala:15:16
        fpiu_outPipe_bits_exc = _RANDOM[6'hB][5:1];	// Reg.scala:15:16
        fpiu_outPipe_valid_1 = _RANDOM[6'hB][6];	// Reg.scala:15:16, Valid.scala:117:22
        fpiu_outPipe_bits_1_toint =
          {_RANDOM[6'h14][31:6], _RANDOM[6'h15], _RANDOM[6'h16][5:0]};	// Reg.scala:15:16
        fpiu_outPipe_bits_1_exc = _RANDOM[6'h16][10:6];	// Reg.scala:15:16
        fpiu_outPipe_valid_2 = _RANDOM[6'h16][11];	// Reg.scala:15:16, Valid.scala:117:22
        fpiu_outPipe_bits_2_toint =
          {_RANDOM[6'h1F][31:11], _RANDOM[6'h20], _RANDOM[6'h21][10:0]};	// Reg.scala:15:16
        fpiu_outPipe_bits_2_exc = _RANDOM[6'h21][15:11];	// Reg.scala:15:16
        fpmu_double_v = _RANDOM[6'h21][16];	// Reg.scala:15:16, Valid.scala:117:22
        fpmu_double_b = _RANDOM[6'h21][17];	// Reg.scala:15:16
        fpmu_double_outPipe_valid = _RANDOM[6'h21][18];	// Reg.scala:15:16, Valid.scala:117:22
        fpmu_double_outPipe_bits = _RANDOM[6'h21][19];	// Reg.scala:15:16
        fpmu_double_outPipe_valid_1 = _RANDOM[6'h21][20];	// Reg.scala:15:16, Valid.scala:117:22
        fpmu_double_outPipe_bits_1 = _RANDOM[6'h21][21];	// Reg.scala:15:16
        fpmu_double_outPipe_bits_2 = _RANDOM[6'h21][23];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  UOPCodeFPUDecoder fp_decoder (	// fpu.scala:179:26
    .io_uopc            (io_req_bits_uop_uopc),
    .io_sigs_ren2       (_fp_decoder_io_sigs_ren2),
    .io_sigs_ren3       (_fp_decoder_io_sigs_ren3),
    .io_sigs_swap23     (_fp_decoder_io_sigs_swap23),
    .io_sigs_typeTagIn  (_fp_decoder_io_sigs_typeTagIn),
    .io_sigs_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_sigs_fromint    (/* unused */),
    .io_sigs_toint      (_fp_decoder_io_sigs_toint),
    .io_sigs_fastpipe   (_fp_decoder_io_sigs_fastpipe),
    .io_sigs_fma        (_fp_decoder_io_sigs_fma),
    .io_sigs_wflags     (_fp_decoder_io_sigs_wflags)
  );
  FPUFMAPipe_2 dfma (	// fpu.scala:205:20
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_sfma_io_in_valid_T & _fpmu_double_T_1),	// fpu.scala:206:{36,51,74}
    .io_in_bits_ren3   (_fp_decoder_io_sigs_ren3),	// fpu.scala:179:26
    .io_in_bits_swap23 (_fp_decoder_io_sigs_swap23),	// fpu.scala:179:26
    .io_in_bits_rm     (fpiu_io_in_bits_req_rm),	// fpu.scala:182:18
    .io_in_bits_fmaCmd (_dfma_io_in_bits_fma_decoder_io_cmd),	// fpu.scala:199:29
    .io_in_bits_in1    (io_req_bits_rs1_data),
    .io_in_bits_in2    (io_req_bits_rs2_data),
    .io_in_bits_in3
      (_fp_decoder_io_sigs_swap23 ? io_req_bits_rs2_data : io_req_bits_rs3_data),	// fpu.scala:179:26, :191:13, :192:{27,37}
    .io_out_valid      (_dfma_io_out_valid),
    .io_out_bits_data  (_dfma_io_out_bits_data),
    .io_out_bits_exc   (_dfma_io_out_bits_exc)
  );
  FMADecoder dfma_io_in_bits_fma_decoder (	// fpu.scala:199:29
    .io_uopc (io_req_bits_uop_uopc),
    .io_cmd  (_dfma_io_in_bits_fma_decoder_io_cmd)
  );
  FPUFMAPipe_3 sfma (	// fpu.scala:209:20
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_sfma_io_in_valid_T & _fp_decoder_io_sigs_typeTagOut == 2'h0),	// fpu.scala:179:26, :206:36, :210:{51,74}
    .io_in_bits_ren3   (_fp_decoder_io_sigs_ren3),	// fpu.scala:179:26
    .io_in_bits_swap23 (_fp_decoder_io_sigs_swap23),	// fpu.scala:179:26
    .io_in_bits_rm     (fpiu_io_in_bits_req_rm),	// fpu.scala:182:18
    .io_in_bits_fmaCmd (_sfma_io_in_bits_fma_decoder_io_cmd),	// fpu.scala:199:29
    .io_in_bits_in1
      ({32'h0,
        {io_req_bits_rs1_data[31], io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:0]}
          | ((&(io_req_bits_rs1_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}, fpu.scala:189:13
    .io_in_bits_in2    ({32'h0, _sfma_io_in_bits_req_in2_T_1}),	// FPU.scala:367:26, fpu.scala:189:13, :190:13
    .io_in_bits_in3
      ({32'h0,
        _fp_decoder_io_sigs_swap23
          ? _sfma_io_in_bits_req_in2_T_1
          : {io_req_bits_rs3_data[31],
             io_req_bits_rs3_data[52],
             io_req_bits_rs3_data[30:0]}
            | ((&(io_req_bits_rs3_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}, fpu.scala:179:26, :189:13, :191:13, :192:{27,37}
    .io_out_valid      (_sfma_io_out_valid),
    .io_out_bits_data  (_sfma_io_out_bits_data),
    .io_out_bits_exc   (_sfma_io_out_bits_exc)
  );
  FMADecoder sfma_io_in_bits_fma_decoder (	// fpu.scala:199:29
    .io_uopc (io_req_bits_uop_uopc),
    .io_cmd  (_sfma_io_in_bits_fma_decoder_io_cmd)
  );
  FPToInt_1 fpiu (	// fpu.scala:213:20
    .clock                 (clock),
    .io_in_valid           (_fpiu_io_in_valid_T_2),	// fpu.scala:214:36
    .io_in_bits_ren2       (_fp_decoder_io_sigs_ren2),	// fpu.scala:179:26
    .io_in_bits_typeTagOut (_fp_decoder_io_sigs_typeTagOut),	// fpu.scala:179:26
    .io_in_bits_wflags     (_fp_decoder_io_sigs_wflags),	// fpu.scala:179:26
    .io_in_bits_rm         (fpiu_io_in_bits_req_rm),	// fpu.scala:182:18
    .io_in_bits_typ        (io_req_bits_uop_imm_packed[9:8]),	// util.scala:295:59
    .io_in_bits_fmt
      (io_req_bits_uop_uopc == 7'h46 ? 2'h0 : {1'h0, |_fp_decoder_io_sigs_typeTagIn}),	// fpu.scala:179:26, :194:{13,24}, :195:{27,43}, :196:15
    .io_in_bits_in1        (fpiu_io_in_bits_req_in1),	// FPU.scala:364:10
    .io_in_bits_in2        (fpiu_io_in_bits_req_in2),	// FPU.scala:364:10
    .io_out_bits_lt        (_fpiu_io_out_bits_lt),
    .io_out_bits_toint     (_fpiu_io_out_bits_toint),
    .io_out_bits_exc       (_fpiu_io_out_bits_exc)
  );
  FPToFP_1 fpmu (	// fpu.scala:222:20
    .clock                 (clock),
    .reset                 (reset),
    .io_in_valid           (_fpmu_double_T),	// fpu.scala:223:36
    .io_in_bits_ren2       (_fp_decoder_io_sigs_ren2),	// fpu.scala:179:26
    .io_in_bits_typeTagOut (_fp_decoder_io_sigs_typeTagOut),	// fpu.scala:179:26
    .io_in_bits_wflags     (_fp_decoder_io_sigs_wflags),	// fpu.scala:179:26
    .io_in_bits_rm         (fpiu_io_in_bits_req_rm),	// fpu.scala:182:18
    .io_in_bits_in1        (fpiu_io_in_bits_req_in1),	// FPU.scala:364:10
    .io_in_bits_in2        (fpiu_io_in_bits_req_in2),	// FPU.scala:364:10
    .io_lt                 (_fpiu_io_out_bits_lt),	// fpu.scala:213:20
    .io_out_valid          (_fpmu_io_out_valid),
    .io_out_bits_data      (_fpmu_io_out_bits_data),
    .io_out_bits_exc       (_fpmu_io_out_bits_exc)
  );
  assign io_resp_bits_data =
    _dfma_io_out_valid
      ? _dfma_io_out_bits_data
      : _sfma_io_out_valid
          ? {12'hFFF,
             _sfma_io_out_bits_data[31],
             20'hFFFFF,
             _sfma_io_out_bits_data[32],
             _sfma_io_out_bits_data[30:0]}
          : fpiu_outPipe_valid_2
              ? {1'h0, fpiu_outPipe_bits_2_toint}
              : fpmu_double_outPipe_bits_2
                  ? _fpmu_io_out_bits_data
                  : {12'hFFF,
                     _fpmu_io_out_bits_data[31],
                     20'hFFFFF,
                     _fpmu_io_out_bits_data[32],
                     _fpmu_io_out_bits_data[30:0]};	// Cat.scala:30:58, FPU.scala:333:42, :335:8, :337:8, :338:8, Reg.scala:15:16, Valid.scala:117:22, fpu.scala:205:20, :209:20, :219:20, :222:20, :234:8, :235:8, :236:8, package.scala:32:76
  assign io_resp_bits_fflags_valid =
    fpiu_outPipe_valid_2 | _fpmu_io_out_valid | _sfma_io_out_valid | _dfma_io_out_valid;	// Valid.scala:117:22, fpu.scala:205:20, :209:20, :222:20, :231:38
  assign io_resp_bits_fflags_bits_flags =
    _dfma_io_out_valid
      ? _dfma_io_out_bits_exc
      : _sfma_io_out_valid
          ? _sfma_io_out_bits_exc
          : fpiu_outPipe_valid_2 ? fpiu_outPipe_bits_2_exc : _fpmu_io_out_bits_exc;	// Reg.scala:15:16, Valid.scala:117:22, fpu.scala:205:20, :209:20, :222:20, :240:8, :241:8, :242:8
endmodule

