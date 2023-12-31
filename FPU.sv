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

module FPU(
  input         clock,
                reset,
  input  [31:0] io_inst,
  input  [63:0] io_fromint_data,
  input  [2:0]  io_fcsr_rm,
  input         io_dmem_resp_val,
  input  [2:0]  io_dmem_resp_type,
  input  [4:0]  io_dmem_resp_tag,
  input  [63:0] io_dmem_resp_data,
  input         io_valid,
                io_killx,
                io_killm,
  output        io_fcsr_flags_valid,
  output [4:0]  io_fcsr_flags_bits,
  output [63:0] io_store_data,
                io_toint_data,
  output        io_fcsr_rdy,
                io_nack_mem,
                io_illegal_rm,
                io_dec_wen,
                io_dec_ren1,
                io_dec_ren2,
                io_dec_ren3,
                io_sboard_set,
                io_sboard_clr,
  output [4:0]  io_sboard_clra
);

  wire [4:0]       divSqrt_flags;	// FPU.scala:996:66, :999:23
  wire [64:0]      divSqrt_wdata;	// FPU.scala:996:66, :998:23
  wire             divSqrt_wen;	// FPU.scala:996:66, :997:21
  wire             divSqrt_typeTag;	// FPU.scala:996:37
  wire             divSqrt_inFlight;	// FPU.scala:989:{34,53}
  wire             _divSqrt_1_io_inReady;	// FPU.scala:981:27
  wire             _divSqrt_1_io_outValid_div;	// FPU.scala:981:27
  wire             _divSqrt_1_io_outValid_sqrt;	// FPU.scala:981:27
  wire [64:0]      _divSqrt_1_io_out;	// FPU.scala:981:27
  wire [4:0]       _divSqrt_1_io_exceptionFlags;	// FPU.scala:981:27
  wire             _divSqrt_io_inReady;	// FPU.scala:981:27
  wire             _divSqrt_io_outValid_div;	// FPU.scala:981:27
  wire             _divSqrt_io_outValid_sqrt;	// FPU.scala:981:27
  wire [32:0]      _divSqrt_io_out;	// FPU.scala:981:27
  wire [4:0]       _divSqrt_io_exceptionFlags;	// FPU.scala:981:27
  wire [64:0]      _dfma_io_out_bits_data;	// FPU.scala:882:28
  wire [4:0]       _dfma_io_out_bits_exc;	// FPU.scala:882:28
  wire [64:0]      _fpmu_io_out_bits_data;	// FPU.scala:863:20
  wire [4:0]       _fpmu_io_out_bits_exc;	// FPU.scala:863:20
  wire [64:0]      _ifpu_io_out_bits_data;	// FPU.scala:858:20
  wire [4:0]       _ifpu_io_out_bits_exc;	// FPU.scala:858:20
  wire [2:0]       _fpiu_io_out_bits_in_rm;	// FPU.scala:848:20
  wire [64:0]      _fpiu_io_out_bits_in_in1;	// FPU.scala:848:20
  wire [64:0]      _fpiu_io_out_bits_in_in2;	// FPU.scala:848:20
  wire             _fpiu_io_out_bits_lt;	// FPU.scala:848:20
  wire [4:0]       _fpiu_io_out_bits_exc;	// FPU.scala:848:20
  wire [64:0]      _sfma_io_out_bits_data;	// FPU.scala:844:20
  wire [4:0]       _sfma_io_out_bits_exc;	// FPU.scala:844:20
  wire [64:0]      _regfile_ext_R0_data;	// FPU.scala:796:20
  wire [64:0]      _regfile_ext_R1_data;	// FPU.scala:796:20
  wire [64:0]      _regfile_ext_R2_data;	// FPU.scala:796:20
  wire             _fp_decoder_io_sigs_ren1;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_ren2;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_ren3;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_swap12;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_swap23;	// FPU.scala:742:26
  wire [1:0]       _fp_decoder_io_sigs_typeTagIn;	// FPU.scala:742:26
  wire [1:0]       _fp_decoder_io_sigs_typeTagOut;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_fromint;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_toint;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_fastpipe;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_fma;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_div;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_sqrt;	// FPU.scala:742:26
  wire             _fp_decoder_io_sigs_wflags;	// FPU.scala:742:26
  reg              ex_reg_valid;	// FPU.scala:746:25
  reg  [31:0]      ex_reg_inst;	// Reg.scala:15:16
  reg              ex_reg_ctrl_ren2;	// Reg.scala:15:16
  reg              ex_reg_ctrl_ren3;	// Reg.scala:15:16
  reg              ex_reg_ctrl_swap23;	// Reg.scala:15:16
  reg  [1:0]       ex_reg_ctrl_typeTagIn;	// Reg.scala:15:16
  reg  [1:0]       ex_reg_ctrl_typeTagOut;	// Reg.scala:15:16
  reg              ex_reg_ctrl_fromint;	// Reg.scala:15:16
  reg              ex_reg_ctrl_toint;	// Reg.scala:15:16
  reg              ex_reg_ctrl_fastpipe;	// Reg.scala:15:16
  reg              ex_reg_ctrl_fma;	// Reg.scala:15:16
  reg              ex_reg_ctrl_div;	// Reg.scala:15:16
  reg              ex_reg_ctrl_sqrt;	// Reg.scala:15:16
  reg              ex_reg_ctrl_wflags;	// Reg.scala:15:16
  reg  [4:0]       ex_ra_0;	// FPU.scala:749:31
  reg  [4:0]       ex_ra_1;	// FPU.scala:749:31
  reg  [4:0]       ex_ra_2;	// FPU.scala:749:31
  reg              load_wb;	// FPU.scala:752:20
  reg  [1:0]       load_wb_typeTag;	// Reg.scala:15:16
  reg  [63:0]      load_wb_data;	// Reg.scala:15:16
  reg  [4:0]       load_wb_tag;	// Reg.scala:15:16
  reg              mem_reg_valid;	// FPU.scala:763:30
  reg  [31:0]      mem_reg_inst;	// Reg.scala:15:16
  reg              wb_reg_valid;	// FPU.scala:771:25
  reg  [1:0]       mem_ctrl_typeTagOut;	// Reg.scala:15:16
  reg              mem_ctrl_fromint;	// Reg.scala:15:16
  reg              mem_ctrl_toint;	// Reg.scala:15:16
  reg              mem_ctrl_fastpipe;	// Reg.scala:15:16
  reg              mem_ctrl_fma;	// Reg.scala:15:16
  reg              mem_ctrl_div;	// Reg.scala:15:16
  reg              mem_ctrl_sqrt;	// Reg.scala:15:16
  reg              mem_ctrl_wflags;	// Reg.scala:15:16
  reg              wb_ctrl_toint;	// Reg.scala:15:16
  wire [63:0]      _wdata_T_2 =
    (load_wb_typeTag[0] ? 64'h0 : 64'hFFFFFFFF00000000) | load_wb_data;	// FPU.scala:426:23, Reg.scala:15:16, package.scala:31:49, :32:76
  wire             wdata_rawIn_isZeroExpIn = _wdata_T_2[62:52] == 11'h0;	// FPU.scala:426:23, rawFloatFromFN.scala:47:23, :50:34
  wire [5:0]       wdata_rawIn_normDist =
    _wdata_T_2[51]
      ? 6'h0
      : _wdata_T_2[50]
          ? 6'h1
          : _wdata_T_2[49]
              ? 6'h2
              : _wdata_T_2[48]
                  ? 6'h3
                  : _wdata_T_2[47]
                      ? 6'h4
                      : _wdata_T_2[46]
                          ? 6'h5
                          : _wdata_T_2[45]
                              ? 6'h6
                              : _wdata_T_2[44]
                                  ? 6'h7
                                  : _wdata_T_2[43]
                                      ? 6'h8
                                      : _wdata_T_2[42]
                                          ? 6'h9
                                          : _wdata_T_2[41]
                                              ? 6'hA
                                              : _wdata_T_2[40]
                                                  ? 6'hB
                                                  : _wdata_T_2[39]
                                                      ? 6'hC
                                                      : _wdata_T_2[38]
                                                          ? 6'hD
                                                          : _wdata_T_2[37]
                                                              ? 6'hE
                                                              : _wdata_T_2[36]
                                                                  ? 6'hF
                                                                  : _wdata_T_2[35]
                                                                      ? 6'h10
                                                                      : _wdata_T_2[34]
                                                                          ? 6'h11
                                                                          : _wdata_T_2[33]
                                                                              ? 6'h12
                                                                              : _wdata_T_2[32]
                                                                                  ? 6'h13
                                                                                  : _wdata_T_2[31]
                                                                                      ? 6'h14
                                                                                      : _wdata_T_2[30]
                                                                                          ? 6'h15
                                                                                          : _wdata_T_2[29]
                                                                                              ? 6'h16
                                                                                              : _wdata_T_2[28]
                                                                                                  ? 6'h17
                                                                                                  : _wdata_T_2[27]
                                                                                                      ? 6'h18
                                                                                                      : _wdata_T_2[26]
                                                                                                          ? 6'h19
                                                                                                          : _wdata_T_2[25]
                                                                                                              ? 6'h1A
                                                                                                              : _wdata_T_2[24]
                                                                                                                  ? 6'h1B
                                                                                                                  : _wdata_T_2[23]
                                                                                                                      ? 6'h1C
                                                                                                                      : _wdata_T_2[22]
                                                                                                                          ? 6'h1D
                                                                                                                          : _wdata_T_2[21]
                                                                                                                              ? 6'h1E
                                                                                                                              : _wdata_T_2[20]
                                                                                                                                  ? 6'h1F
                                                                                                                                  : _wdata_T_2[19]
                                                                                                                                      ? 6'h20
                                                                                                                                      : _wdata_T_2[18]
                                                                                                                                          ? 6'h21
                                                                                                                                          : _wdata_T_2[17]
                                                                                                                                              ? 6'h22
                                                                                                                                              : _wdata_T_2[16]
                                                                                                                                                  ? 6'h23
                                                                                                                                                  : _wdata_T_2[15]
                                                                                                                                                      ? 6'h24
                                                                                                                                                      : _wdata_T_2[14]
                                                                                                                                                          ? 6'h25
                                                                                                                                                          : _wdata_T_2[13]
                                                                                                                                                              ? 6'h26
                                                                                                                                                              : _wdata_T_2[12]
                                                                                                                                                                  ? 6'h27
                                                                                                                                                                  : _wdata_T_2[11]
                                                                                                                                                                      ? 6'h28
                                                                                                                                                                      : _wdata_T_2[10]
                                                                                                                                                                          ? 6'h29
                                                                                                                                                                          : _wdata_T_2[9]
                                                                                                                                                                              ? 6'h2A
                                                                                                                                                                              : _wdata_T_2[8]
                                                                                                                                                                                  ? 6'h2B
                                                                                                                                                                                  : _wdata_T_2[7]
                                                                                                                                                                                      ? 6'h2C
                                                                                                                                                                                      : _wdata_T_2[6]
                                                                                                                                                                                          ? 6'h2D
                                                                                                                                                                                          : _wdata_T_2[5]
                                                                                                                                                                                              ? 6'h2E
                                                                                                                                                                                              : _wdata_T_2[4]
                                                                                                                                                                                                  ? 6'h2F
                                                                                                                                                                                                  : _wdata_T_2[3]
                                                                                                                                                                                                      ? 6'h30
                                                                                                                                                                                                      : _wdata_T_2[2]
                                                                                                                                                                                                          ? 6'h31
                                                                                                                                                                                                          : {5'h19,
                                                                                                                                                                                                             ~(_wdata_T_2[1])};	// FPU.scala:426:23, Mux.scala:47:69, primitives.scala:92:52, rawFloatFromFN.scala:48:25
  wire [114:0]     _wdata_rawIn_subnormFract_T =
    {63'h0, _wdata_T_2[51:0]} << wdata_rawIn_normDist;	// FPU.scala:426:23, Mux.scala:47:69, rawFloatFromFN.scala:48:25, :54:36
  wire [11:0]      _wdata_rawIn_adjustedExp_T_4 =
    (wdata_rawIn_isZeroExpIn ? {6'h3F, ~wdata_rawIn_normDist} : {1'h0, _wdata_T_2[62:52]})
    + {10'h100, wdata_rawIn_isZeroExpIn ? 2'h2 : 2'h1};	// Decoupled.scala:40:37, FPU.scala:426:23, :753:58, Mux.scala:47:69, rawFloatFromFN.scala:47:23, :50:34, :56:16, :57:26, :59:15, :60:27
  wire [51:0]      wdata_rawIn_out_sig_lo =
    wdata_rawIn_isZeroExpIn
      ? {_wdata_rawIn_subnormFract_T[50:0], 1'h0}
      : _wdata_T_2[51:0];	// Decoupled.scala:40:37, FPU.scala:426:23, rawFloatFromFN.scala:48:25, :50:34, :54:{36,47,64}, :72:42
  wire [2:0]       _wdata_T_4 =
    wdata_rawIn_isZeroExpIn & ~(|(_wdata_T_2[51:0]))
      ? 3'h0
      : _wdata_rawIn_adjustedExp_T_4[11:9];	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :50:34, :51:38, :59:15, :62:34, recFNFromFN.scala:48:{16,53}
  wire             _GEN =
    _wdata_T_4[0] | (&(_wdata_rawIn_adjustedExp_T_4[11:10])) & (|(_wdata_T_2[51:0]));	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :51:38, :59:15, :63:{37,62}, :66:33, recFNFromFN.scala:48:{16,79}
  wire             wdata_rawIn_isZeroExpIn_1 = _wdata_T_2[30:23] == 8'h0;	// FPU.scala:426:23, rawFloatFromFN.scala:47:23, :50:34
  wire [4:0]       wdata_rawIn_normDist_1 =
    _wdata_T_2[22]
      ? 5'h0
      : _wdata_T_2[21]
          ? 5'h1
          : _wdata_T_2[20]
              ? 5'h2
              : _wdata_T_2[19]
                  ? 5'h3
                  : _wdata_T_2[18]
                      ? 5'h4
                      : _wdata_T_2[17]
                          ? 5'h5
                          : _wdata_T_2[16]
                              ? 5'h6
                              : _wdata_T_2[15]
                                  ? 5'h7
                                  : _wdata_T_2[14]
                                      ? 5'h8
                                      : _wdata_T_2[13]
                                          ? 5'h9
                                          : _wdata_T_2[12]
                                              ? 5'hA
                                              : _wdata_T_2[11]
                                                  ? 5'hB
                                                  : _wdata_T_2[10]
                                                      ? 5'hC
                                                      : _wdata_T_2[9]
                                                          ? 5'hD
                                                          : _wdata_T_2[8]
                                                              ? 5'hE
                                                              : _wdata_T_2[7]
                                                                  ? 5'hF
                                                                  : _wdata_T_2[6]
                                                                      ? 5'h10
                                                                      : _wdata_T_2[5]
                                                                          ? 5'h11
                                                                          : _wdata_T_2[4]
                                                                              ? 5'h12
                                                                              : _wdata_T_2[3]
                                                                                  ? 5'h13
                                                                                  : _wdata_T_2[2]
                                                                                      ? 5'h14
                                                                                      : _wdata_T_2[1]
                                                                                          ? 5'h15
                                                                                          : 5'h16;	// FPU.scala:426:23, Mux.scala:47:69, primitives.scala:92:52, rawFloatFromFN.scala:48:25
  wire [53:0]      _wdata_rawIn_subnormFract_T_2 =
    {31'h0, _wdata_T_2[22:0]} << wdata_rawIn_normDist_1;	// FPU.scala:426:23, Mux.scala:47:69, rawFloatFromFN.scala:48:25, :54:36
  wire [8:0]       _wdata_rawIn_adjustedExp_T_9 =
    (wdata_rawIn_isZeroExpIn_1
       ? {4'hF, ~wdata_rawIn_normDist_1}
       : {1'h0, _wdata_T_2[30:23]}) + {7'h20, wdata_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};	// Decoupled.scala:40:37, FPU.scala:426:23, :753:58, Mux.scala:47:69, rawFloatFromFN.scala:47:23, :50:34, :56:16, :57:26, :59:15, :60:27
  wire [2:0]       _wdata_T_8 =
    wdata_rawIn_isZeroExpIn_1 & ~(|(_wdata_T_2[22:0]))
      ? 3'h0
      : _wdata_rawIn_adjustedExp_T_9[8:6];	// FPU.scala:426:23, rawFloatFromFN.scala:48:25, :50:34, :51:38, :59:15, :62:34, recFNFromFN.scala:48:{16,53}
  wire [60:0]      _GEN_0 =
    (&{_wdata_T_4[2:1], _GEN})
      ? {&(wdata_rawIn_out_sig_lo[51:32]),
         _wdata_rawIn_adjustedExp_T_4[7:1],
         _wdata_T_8[2],
         wdata_rawIn_out_sig_lo[51:32],
         _wdata_T_2[31],
         _wdata_T_8[1],
         _wdata_T_8[0] | (&(_wdata_rawIn_adjustedExp_T_9[8:7])) & (|(_wdata_T_2[22:0])),
         _wdata_rawIn_adjustedExp_T_9[5:0],
         wdata_rawIn_isZeroExpIn_1
           ? {_wdata_rawIn_subnormFract_T_2[21:0], 1'h0}
           : _wdata_T_2[22:0]}
      : {_wdata_rawIn_adjustedExp_T_4[8:0], wdata_rawIn_out_sig_lo};	// Cat.scala:30:58, Decoupled.scala:40:37, FPU.scala:243:{25,56}, :333:{8,42}, :334:8, :335:8, :338:8, :339:8, :426:23, rawFloatFromFN.scala:46:22, :48:25, :50:34, :51:38, :54:{36,47,64}, :59:15, :63:{37,62}, :66:33, :72:42, recFNFromFN.scala:48:{16,79}, :50:23
  wire [2:0]       req_2_rm = (&(ex_reg_inst[14:12])) ? io_fcsr_rm : ex_reg_inst[14:12];	// FPU.scala:821:{18,30,38}, Reg.scala:15:16
  wire             _dfma_io_in_valid_T = ex_reg_valid & ex_reg_ctrl_fma;	// FPU.scala:746:25, :845:33, Reg.scala:15:16
  wire             _write_port_busy_T_16 = ex_reg_ctrl_typeTagOut == 2'h0;	// FPU.scala:845:70, Reg.scala:15:16
  wire [2:0]       fpiu_io_in_bits_req_in1_expOut_hi =
    {_regfile_ext_R2_data[52], _regfile_ext_R2_data[30:29]};	// FPU.scala:270:18, :273:26, :353:14, :796:20
  wire [11:0]      _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2 =
    {3'h0, _regfile_ext_R2_data[52], _regfile_ext_R2_data[30:23]} + 12'h700;	// FPU.scala:270:18, :274:{31,48}, :353:14, :796:20
  wire [64:0]      req_1_in1 =
    ex_reg_ctrl_typeTagIn[0] | (&(_regfile_ext_R2_data[64:60]))
      ? (ex_reg_ctrl_typeTagIn[0]
           ? _regfile_ext_R2_data
           : {_regfile_ext_R2_data[31],
              fpiu_io_in_bits_req_in1_expOut_hi == 3'h0
              | fpiu_io_in_bits_req_in1_expOut_hi > 3'h5
                ? {_regfile_ext_R2_data[52],
                   _regfile_ext_R2_data[30:29],
                   _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2[8:0]}
                : _fpiu_io_in_bits_req_in1_expOut_commonCase_T_2,
              _regfile_ext_R2_data[22:0],
              29'h0})
      : 65'hE008000000000000;	// Cat.scala:30:58, FPU.scala:269:20, :270:18, :271:38, :273:26, :274:48, :275:{10,19,25,36,65}, :327:{49,84}, :352:14, :353:14, :364:10, :796:20, Reg.scala:15:16, package.scala:31:49, :32:76
  wire [2:0]       fpiu_io_in_bits_req_in2_expOut_hi =
    {_regfile_ext_R1_data[52], _regfile_ext_R1_data[30:29]};	// FPU.scala:270:18, :273:26, :353:14, :796:20
  wire [11:0]      _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2 =
    {3'h0, _regfile_ext_R1_data[52], _regfile_ext_R1_data[30:23]} + 12'h700;	// FPU.scala:270:18, :274:{31,48}, :353:14, :796:20
  wire [64:0]      req_1_in2 =
    ex_reg_ctrl_typeTagIn[0] | (&(_regfile_ext_R1_data[64:60]))
      ? (ex_reg_ctrl_typeTagIn[0]
           ? _regfile_ext_R1_data
           : {_regfile_ext_R1_data[31],
              fpiu_io_in_bits_req_in2_expOut_hi == 3'h0
              | fpiu_io_in_bits_req_in2_expOut_hi > 3'h5
                ? {_regfile_ext_R1_data[52],
                   _regfile_ext_R1_data[30:29],
                   _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2[8:0]}
                : _fpiu_io_in_bits_req_in2_expOut_commonCase_T_2,
              _regfile_ext_R1_data[22:0],
              29'h0})
      : 65'hE008000000000000;	// Cat.scala:30:58, FPU.scala:269:20, :270:18, :271:38, :273:26, :274:48, :275:{10,19,25,36,65}, :327:{49,84}, :352:14, :353:14, :364:10, :796:20, Reg.scala:15:16, package.scala:31:49, :32:76
  reg  [4:0]       divSqrt_waddr;	// FPU.scala:870:26
  wire             _divSqrt_io_inValid_T = mem_ctrl_typeTagOut == 2'h0;	// FPU.scala:880:72, Reg.scala:15:16
  wire             _divSqrt_io_inValid_T_6 = mem_ctrl_typeTagOut == 2'h1;	// FPU.scala:885:78, Reg.scala:15:16, rawFloatFromFN.scala:60:27
  reg  [2:0]       wen;	// FPU.scala:909:16
  reg  [4:0]       wbInfo_0_rd;	// FPU.scala:910:19
  reg              wbInfo_0_typeTag;	// FPU.scala:910:19
  reg              wbInfo_0_cp;	// FPU.scala:910:19
  reg  [1:0]       wbInfo_0_pipeid;	// FPU.scala:910:19
  reg  [4:0]       wbInfo_1_rd;	// FPU.scala:910:19
  reg              wbInfo_1_typeTag;	// FPU.scala:910:19
  reg              wbInfo_1_cp;	// FPU.scala:910:19
  reg  [1:0]       wbInfo_1_pipeid;	// FPU.scala:910:19
  reg  [4:0]       wbInfo_2_rd;	// FPU.scala:910:19
  reg              wbInfo_2_typeTag;	// FPU.scala:910:19
  reg              wbInfo_2_cp;	// FPU.scala:910:19
  reg  [1:0]       wbInfo_2_pipeid;	// FPU.scala:910:19
  reg              write_port_busy;	// Reg.scala:15:16
  wire [4:0]       waddr = divSqrt_wen ? divSqrt_waddr : wbInfo_0_rd;	// FPU.scala:870:26, :910:19, :933:18, :996:66, :997:21
  wire [3:0][64:0] _GEN_1 =
    {{_dfma_io_out_bits_data},
     {_sfma_io_out_bits_data},
     {_ifpu_io_out_bits_data},
     {_fpmu_io_out_bits_data}};	// FPU.scala:844:20, :858:20, :863:20, :882:28, package.scala:32:{76,86}
  wire [64:0]      _wdata_T_19 = divSqrt_wen ? divSqrt_wdata : _GEN_1[wbInfo_0_pipeid];	// FPU.scala:910:19, :935:22, :996:66, :997:21, :998:23, package.scala:32:{76,86}
  wire [64:0]      wdata_1 =
    (divSqrt_wen ? divSqrt_typeTag : wbInfo_0_typeTag)
      ? _wdata_T_19
      : {12'hFFF, _wdata_T_19[31], 20'hFFFFF, _wdata_T_19[32], _wdata_T_19[30:0]};	// Cat.scala:30:58, FPU.scala:333:42, :335:8, :337:8, :338:8, :910:19, :934:21, :935:22, :996:{37,66}, :997:21, package.scala:32:76, rawFloatFromFN.scala:57:26
  wire [3:0][4:0]  _GEN_2 =
    {{_dfma_io_out_bits_exc},
     {_sfma_io_out_bits_exc},
     {_ifpu_io_out_bits_exc},
     {_fpmu_io_out_bits_exc}};	// FPU.scala:844:20, :858:20, :863:20, :882:28, package.scala:32:{76,86}
  wire             _GEN_3 = ~wbInfo_0_cp & wen[0] | divSqrt_wen;	// FPU.scala:909:16, :910:19, :937:{10,24,30,35}, :996:66, :997:21
  `ifndef SYNTHESIS	// FPU.scala:800:11
    always @(posedge clock) begin	// FPU.scala:800:11
      if (load_wb
          & ~({_wdata_T_4[2:1], _GEN} != 3'h7 | _GEN_0[60] == (&(_GEN_0[51:32]))
              | reset)) begin	// FPU.scala:243:{25,56}, :339:8, :380:{35,55,60,96}, :752:20, :800:11, recFNFromFN.scala:48:{16,79}
        if (`ASSERT_VERBOSE_COND_)	// FPU.scala:800:11
          $error("Assertion failed\n    at FPU.scala:800 assert(consistent(wdata))\n");	// FPU.scala:800:11
        if (`STOP_COND_)	// FPU.scala:800:11
          $fatal;	// FPU.scala:800:11
      end
      if (_GEN_3
          & ~(wdata_1[63:61] != 3'h7 | wdata_1[60] == (&(wdata_1[51:32])) | reset)) begin	// FPU.scala:243:{25,56}, :380:{35,55,60,96}, :937:35, :938:11, package.scala:32:76
        if (`ASSERT_VERBOSE_COND_)	// FPU.scala:938:11
          $error("Assertion failed\n    at FPU.scala:938 assert(consistent(wdata))\n");	// FPU.scala:938:11
        if (`STOP_COND_)	// FPU.scala:938:11
          $fatal;	// FPU.scala:938:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire             wb_toint_valid = wb_reg_valid & wb_ctrl_toint;	// FPU.scala:771:25, :953:37, Reg.scala:15:16
  reg  [4:0]       wb_toint_exc;	// Reg.scala:15:16
  wire             _divSqrt_io_inValid_T_8 = mem_ctrl_div | mem_ctrl_sqrt;	// FPU.scala:961:47, Reg.scala:15:16
  wire             _io_nack_mem_output =
    write_port_busy | _divSqrt_io_inValid_T_8 & (|wen) | divSqrt_inFlight;	// FPU.scala:909:16, :961:{47,65,72}, :963:61, :989:{34,53}, Reg.scala:15:16
  reg              io_sboard_set_REG;	// FPU.scala:966:55
  reg              divSqrt_killed;	// FPU.scala:974:29
  wire             _divSqrt_io_inValid_T_5 =
    mem_reg_valid & _divSqrt_io_inValid_T & _divSqrt_io_inValid_T_8 & ~divSqrt_inFlight;	// FPU.scala:763:30, :880:72, :961:47, :982:{100,103}, :989:{34,53}
  wire [8:0]       _divSqrt_io_a_expOut_commonCase_T =
    _fpiu_io_out_bits_in_in1[60:52] - 9'h100;	// FPU.scala:270:18, :274:31, :848:20
  wire [8:0]       _divSqrt_io_b_expOut_commonCase_T =
    _fpiu_io_out_bits_in_in2[60:52] - 9'h100;	// FPU.scala:270:18, :274:31, :848:20
  wire             _divSqrt_io_inValid_T_11 =
    mem_reg_valid & _divSqrt_io_inValid_T_6 & _divSqrt_io_inValid_T_8 & ~divSqrt_inFlight;	// FPU.scala:763:30, :885:78, :961:47, :982:{100,103}, :989:{34,53}
  assign divSqrt_inFlight = ~_divSqrt_1_io_inReady | ~_divSqrt_io_inReady;	// FPU.scala:981:27, :989:{13,34,53}
  assign divSqrt_typeTag = _divSqrt_1_io_outValid_div | _divSqrt_1_io_outValid_sqrt;	// FPU.scala:981:27, :996:37
  assign divSqrt_wen =
    divSqrt_typeTag
      ? ~divSqrt_killed
      : (_divSqrt_io_outValid_div | _divSqrt_io_outValid_sqrt) & ~divSqrt_killed;	// FPU.scala:974:29, :981:27, :996:{37,66}, :997:{21,24}
  assign divSqrt_wdata =
    divSqrt_typeTag
      ? ({65{_divSqrt_1_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF)
        & _divSqrt_1_io_out
      : {32'h0, _divSqrt_io_out};	// FPU.scala:243:{25,56}, :408:27, :409:10, :828:13, :981:27, :996:{37,66}, :998:23
  assign divSqrt_flags =
    divSqrt_typeTag ? _divSqrt_1_io_exceptionFlags : _divSqrt_io_exceptionFlags;	// FPU.scala:981:27, :996:{37,66}, :999:23
  always @(posedge clock) begin
    automatic logic _killm_T;	// FPU.scala:764:25
    automatic logic _memLatencyMask_T_3;	// FPU.scala:880:56
    automatic logic _memLatencyMask_T_6;	// FPU.scala:885:62
    automatic logic _memLatencyMask_T_8;	// FPU.scala:895:78
    automatic logic mem_wen;	// FPU.scala:911:31
    automatic logic _GEN_4;	// FPU.scala:916:21, :919:18, :924:52, :925:22
    automatic logic _GEN_5;	// FPU.scala:916:21, :919:18, :924:52, :925:22
    automatic logic _GEN_6;	// FPU.scala:910:19, :919:18, :924:52, :925:22
    automatic logic _GEN_7;	// FPU.scala:991:32
    automatic logic _GEN_8 = _divSqrt_io_inValid_T_11 & _divSqrt_1_io_inReady;	// FPU.scala:981:27, :982:100, :991:32
    _killm_T = io_killm | _io_nack_mem_output;	// FPU.scala:764:25, :963:61
    _memLatencyMask_T_3 = mem_ctrl_fma & _divSqrt_io_inValid_T;	// FPU.scala:880:{56,72}, Reg.scala:15:16
    _memLatencyMask_T_6 = mem_ctrl_fma & _divSqrt_io_inValid_T_6;	// FPU.scala:885:{62,78}, Reg.scala:15:16
    _memLatencyMask_T_8 = mem_ctrl_fastpipe | mem_ctrl_fromint;	// FPU.scala:895:78, Reg.scala:15:16
    mem_wen = mem_reg_valid & (mem_ctrl_fma | mem_ctrl_fastpipe | mem_ctrl_fromint);	// FPU.scala:763:30, :911:{31,69}, Reg.scala:15:16
    _GEN_4 = mem_wen & ~write_port_busy & _memLatencyMask_T_8;	// FPU.scala:895:78, :911:31, :916:21, :919:18, :924:{13,52}, :925:22, Reg.scala:15:16
    _GEN_5 = mem_wen & ~write_port_busy & _memLatencyMask_T_3;	// FPU.scala:880:56, :911:31, :916:21, :919:18, :924:{13,52}, :925:22, Reg.scala:15:16
    _GEN_6 = mem_wen & ~write_port_busy & _memLatencyMask_T_6;	// FPU.scala:885:62, :910:19, :911:31, :919:18, :924:{13,52}, :925:22, Reg.scala:15:16
    _GEN_7 = _divSqrt_io_inValid_T_5 & _divSqrt_io_inReady;	// FPU.scala:981:27, :982:100, :991:32
    if (reset) begin
      ex_reg_valid <= 1'h0;	// Decoupled.scala:40:37, FPU.scala:746:25
      mem_reg_valid <= 1'h0;	// Decoupled.scala:40:37, FPU.scala:763:30
      wb_reg_valid <= 1'h0;	// Decoupled.scala:40:37, FPU.scala:771:25
      wen <= 3'h0;	// FPU.scala:909:16
    end
    else begin
      ex_reg_valid <= io_valid;	// FPU.scala:746:25
      mem_reg_valid <= ex_reg_valid & ~(io_killx | mem_reg_valid & _killm_T);	// FPU.scala:746:25, :763:30, :764:25, :768:{24,41}, :769:{33,36}
      wb_reg_valid <= mem_reg_valid & ~_killm_T;	// FPU.scala:763:30, :764:25, :771:{25,45,49}
      if (mem_wen & ~_killm_T)	// FPU.scala:764:25, :771:49, :911:31, :918:7, :919:18, :920:19, :921:11
        wen <=
          {_memLatencyMask_T_6,
           wen[2] | _memLatencyMask_T_3,
           wen[1] | _memLatencyMask_T_8};	// FPU.scala:880:56, :885:62, :895:78, :909:16, :916:14, :921:23
      else	// FPU.scala:918:7, :919:18, :920:19, :921:11
        wen <= {1'h0, wen[2:1]};	// Decoupled.scala:40:37, FPU.scala:909:16, :918:{7,14}
    end
    if (io_valid) begin
      ex_reg_inst <= io_inst;	// Reg.scala:15:16
      ex_reg_ctrl_ren2 <= _fp_decoder_io_sigs_ren2;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_ren3 <= _fp_decoder_io_sigs_ren3;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_swap23 <= _fp_decoder_io_sigs_swap23;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_typeTagIn <= _fp_decoder_io_sigs_typeTagIn;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_typeTagOut <= _fp_decoder_io_sigs_typeTagOut;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_fromint <= _fp_decoder_io_sigs_fromint;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_toint <= _fp_decoder_io_sigs_toint;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_fastpipe <= _fp_decoder_io_sigs_fastpipe;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_fma <= _fp_decoder_io_sigs_fma;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_div <= _fp_decoder_io_sigs_div;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_sqrt <= _fp_decoder_io_sigs_sqrt;	// FPU.scala:742:26, Reg.scala:15:16
      ex_reg_ctrl_wflags <= _fp_decoder_io_sigs_wflags;	// FPU.scala:742:26, Reg.scala:15:16
      if (_fp_decoder_io_sigs_ren2 & _fp_decoder_io_sigs_swap12)	// FPU.scala:742:26, :810:25, :814:25, :815:{29,40}
        ex_ra_0 <= io_inst[24:20];	// FPU.scala:749:31, :815:50
      else if (_fp_decoder_io_sigs_ren1 & ~_fp_decoder_io_sigs_swap12)	// FPU.scala:742:26, :749:31, :810:25, :811:{13,30,41}
        ex_ra_0 <= io_inst[19:15];	// FPU.scala:749:31, :811:51
      if (_fp_decoder_io_sigs_ren2 & ~_fp_decoder_io_sigs_swap12
          & ~_fp_decoder_io_sigs_swap23)	// FPU.scala:742:26, :810:25, :811:13, :814:25, :817:{32,49,60}
        ex_ra_1 <= io_inst[24:20];	// FPU.scala:749:31, :817:70
      else if (_fp_decoder_io_sigs_ren1 & _fp_decoder_io_sigs_swap12)	// FPU.scala:742:26, :749:31, :810:25, :812:{29,40}
        ex_ra_1 <= io_inst[19:15];	// FPU.scala:749:31, :812:50
      if (_fp_decoder_io_sigs_ren3)	// FPU.scala:742:26
        ex_ra_2 <= io_inst[31:27];	// FPU.scala:749:31, :819:46
      else if (_fp_decoder_io_sigs_ren2 & _fp_decoder_io_sigs_swap23)	// FPU.scala:742:26, :749:31, :814:25, :816:{29,40}
        ex_ra_2 <= io_inst[24:20];	// FPU.scala:749:31, :816:50
    end
    load_wb <= io_dmem_resp_val;	// FPU.scala:752:20
    if (io_dmem_resp_val) begin
      load_wb_typeTag <= io_dmem_resp_type[1:0] - 2'h2;	// FPU.scala:753:{52,58}, Reg.scala:15:16
      load_wb_data <= io_dmem_resp_data;	// Reg.scala:15:16
      load_wb_tag <= io_dmem_resp_tag;	// Reg.scala:15:16
    end
    if (ex_reg_valid) begin	// FPU.scala:746:25
      automatic logic _GEN_9;	// FPU.scala:895:78
      _GEN_9 = ex_reg_ctrl_fastpipe | ex_reg_ctrl_fromint;	// FPU.scala:895:78, Reg.scala:15:16
      mem_reg_inst <= ex_reg_inst;	// Reg.scala:15:16
      mem_ctrl_typeTagOut <= ex_reg_ctrl_typeTagOut;	// Reg.scala:15:16
      mem_ctrl_fromint <= ex_reg_ctrl_fromint;	// Reg.scala:15:16
      mem_ctrl_toint <= ex_reg_ctrl_toint;	// Reg.scala:15:16
      mem_ctrl_fastpipe <= ex_reg_ctrl_fastpipe;	// Reg.scala:15:16
      mem_ctrl_fma <= ex_reg_ctrl_fma;	// Reg.scala:15:16
      mem_ctrl_div <= ex_reg_ctrl_div;	// Reg.scala:15:16
      mem_ctrl_sqrt <= ex_reg_ctrl_sqrt;	// Reg.scala:15:16
      mem_ctrl_wflags <= ex_reg_ctrl_wflags;	// Reg.scala:15:16
      write_port_busy <=
        mem_wen
        & (|({ex_reg_ctrl_fma & _write_port_busy_T_16, _GEN_9}
             & {_memLatencyMask_T_6, _memLatencyMask_T_3})) | _GEN_9 & wen[2];	// FPU.scala:845:70, :880:56, :885:62, :895:78, :909:16, :911:31, :912:{43,62,89,93,101}, Reg.scala:15:16
    end
    if (mem_reg_valid)	// FPU.scala:763:30
      wb_ctrl_toint <= mem_ctrl_toint;	// Reg.scala:15:16
    if (_GEN_8)	// FPU.scala:991:32
      divSqrt_waddr <= mem_reg_inst[11:7];	// FPU.scala:870:26, :993:38, Reg.scala:15:16
    else if (_GEN_7)	// FPU.scala:991:32
      divSqrt_waddr <= mem_reg_inst[11:7];	// FPU.scala:870:26, :993:38, Reg.scala:15:16
    if (_GEN_4) begin	// FPU.scala:916:21, :919:18, :924:52, :925:22
      wbInfo_0_rd <= mem_reg_inst[11:7];	// FPU.scala:910:19, :928:37, Reg.scala:15:16
      wbInfo_0_typeTag <= mem_ctrl_typeTagOut[0];	// FPU.scala:910:19, :926:27, Reg.scala:15:16
      wbInfo_0_pipeid <=
        {mem_ctrl_fma & _divSqrt_io_inValid_T, mem_ctrl_fromint}
        | {2{mem_ctrl_fma & _divSqrt_io_inValid_T_6}};	// FPU.scala:880:{56,72}, :885:{62,78}, :897:{63,108}, :910:19, Reg.scala:15:16
    end
    else if (wen[1]) begin	// FPU.scala:909:16, :916:14
      wbInfo_0_rd <= wbInfo_1_rd;	// FPU.scala:910:19
      wbInfo_0_typeTag <= wbInfo_1_typeTag;	// FPU.scala:910:19
      wbInfo_0_pipeid <= wbInfo_1_pipeid;	// FPU.scala:910:19
    end
    wbInfo_0_cp <= ~_GEN_4 & (wen[1] ? wbInfo_1_cp : wbInfo_0_cp);	// FPU.scala:909:16, :910:19, :916:{14,21,33}, :919:18, :924:52, :925:22
    if (_GEN_5) begin	// FPU.scala:916:21, :919:18, :924:52, :925:22
      wbInfo_1_rd <= mem_reg_inst[11:7];	// FPU.scala:910:19, :928:37, Reg.scala:15:16
      wbInfo_1_typeTag <= mem_ctrl_typeTagOut[0];	// FPU.scala:910:19, :926:27, Reg.scala:15:16
      wbInfo_1_pipeid <=
        {mem_ctrl_fma & _divSqrt_io_inValid_T, mem_ctrl_fromint}
        | {2{mem_ctrl_fma & _divSqrt_io_inValid_T_6}};	// FPU.scala:880:{56,72}, :885:{62,78}, :897:{63,108}, :910:19, Reg.scala:15:16
    end
    else if (wen[2]) begin	// FPU.scala:909:16, :916:14
      wbInfo_1_rd <= wbInfo_2_rd;	// FPU.scala:910:19
      wbInfo_1_typeTag <= wbInfo_2_typeTag;	// FPU.scala:910:19
      wbInfo_1_pipeid <= wbInfo_2_pipeid;	// FPU.scala:910:19
    end
    wbInfo_1_cp <= ~_GEN_5 & (wen[2] ? wbInfo_2_cp : wbInfo_1_cp);	// FPU.scala:909:16, :910:19, :916:{21,33}, :919:18, :924:52, :925:22
    if (_GEN_6) begin	// FPU.scala:910:19, :919:18, :924:52, :925:22
      wbInfo_2_rd <= mem_reg_inst[11:7];	// FPU.scala:910:19, :928:37, Reg.scala:15:16
      wbInfo_2_typeTag <= mem_ctrl_typeTagOut[0];	// FPU.scala:910:19, :926:27, Reg.scala:15:16
      wbInfo_2_pipeid <=
        {mem_ctrl_fma & _divSqrt_io_inValid_T, mem_ctrl_fromint}
        | {2{mem_ctrl_fma & _divSqrt_io_inValid_T_6}};	// FPU.scala:880:{56,72}, :885:{62,78}, :897:{63,108}, :910:19, Reg.scala:15:16
    end
    wbInfo_2_cp <= ~_GEN_6 & wbInfo_2_cp;	// FPU.scala:910:19, :919:18, :924:52, :925:22
    if (mem_ctrl_toint)	// Reg.scala:15:16
      wb_toint_exc <= _fpiu_io_out_bits_exc;	// FPU.scala:848:20, Reg.scala:15:16
    io_sboard_set_REG <=
      mem_ctrl_fma & _divSqrt_io_inValid_T_6 | mem_ctrl_div | mem_ctrl_sqrt;	// FPU.scala:885:{62,78}, :966:{55,112}, Reg.scala:15:16
    if (_GEN_8 | _GEN_7)	// FPU.scala:974:29, :991:{32,55}, :992:24
      divSqrt_killed <= _killm_T;	// FPU.scala:764:25, :974:29
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:7];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h8; i += 4'h1) begin
          _RANDOM[i[2:0]] = `RANDOM;
        end
        ex_reg_valid = _RANDOM[3'h0][1];	// FPU.scala:746:25
        ex_reg_inst = {_RANDOM[3'h0][31:2], _RANDOM[3'h1][1:0]};	// FPU.scala:746:25, Reg.scala:15:16
        ex_reg_ctrl_ren2 = _RANDOM[3'h1][5];	// Reg.scala:15:16
        ex_reg_ctrl_ren3 = _RANDOM[3'h1][6];	// Reg.scala:15:16
        ex_reg_ctrl_swap23 = _RANDOM[3'h1][8];	// Reg.scala:15:16
        ex_reg_ctrl_typeTagIn = _RANDOM[3'h1][10:9];	// Reg.scala:15:16
        ex_reg_ctrl_typeTagOut = _RANDOM[3'h1][12:11];	// Reg.scala:15:16
        ex_reg_ctrl_fromint = _RANDOM[3'h1][13];	// Reg.scala:15:16
        ex_reg_ctrl_toint = _RANDOM[3'h1][14];	// Reg.scala:15:16
        ex_reg_ctrl_fastpipe = _RANDOM[3'h1][15];	// Reg.scala:15:16
        ex_reg_ctrl_fma = _RANDOM[3'h1][16];	// Reg.scala:15:16
        ex_reg_ctrl_div = _RANDOM[3'h1][17];	// Reg.scala:15:16
        ex_reg_ctrl_sqrt = _RANDOM[3'h1][18];	// Reg.scala:15:16
        ex_reg_ctrl_wflags = _RANDOM[3'h1][19];	// Reg.scala:15:16
        ex_ra_0 = _RANDOM[3'h1][24:20];	// FPU.scala:749:31, Reg.scala:15:16
        ex_ra_1 = _RANDOM[3'h1][29:25];	// FPU.scala:749:31, Reg.scala:15:16
        ex_ra_2 = {_RANDOM[3'h1][31:30], _RANDOM[3'h2][2:0]};	// FPU.scala:749:31, Reg.scala:15:16
        load_wb = _RANDOM[3'h2][3];	// FPU.scala:749:31, :752:20
        load_wb_typeTag = _RANDOM[3'h2][5:4];	// FPU.scala:749:31, Reg.scala:15:16
        load_wb_data = {_RANDOM[3'h2][31:6], _RANDOM[3'h3], _RANDOM[3'h4][5:0]};	// FPU.scala:749:31, Reg.scala:15:16
        load_wb_tag = _RANDOM[3'h4][10:6];	// Reg.scala:15:16
        mem_reg_valid = _RANDOM[3'h4][13];	// FPU.scala:763:30, Reg.scala:15:16
        mem_reg_inst = {_RANDOM[3'h4][31:14], _RANDOM[3'h5][13:0]};	// Reg.scala:15:16
        wb_reg_valid = _RANDOM[3'h5][14];	// FPU.scala:771:25, Reg.scala:15:16
        mem_ctrl_typeTagOut = _RANDOM[3'h5][25:24];	// Reg.scala:15:16
        mem_ctrl_fromint = _RANDOM[3'h5][26];	// Reg.scala:15:16
        mem_ctrl_toint = _RANDOM[3'h5][27];	// Reg.scala:15:16
        mem_ctrl_fastpipe = _RANDOM[3'h5][28];	// Reg.scala:15:16
        mem_ctrl_fma = _RANDOM[3'h5][29];	// Reg.scala:15:16
        mem_ctrl_div = _RANDOM[3'h5][30];	// Reg.scala:15:16
        mem_ctrl_sqrt = _RANDOM[3'h5][31];	// Reg.scala:15:16
        mem_ctrl_wflags = _RANDOM[3'h6][0];	// Reg.scala:15:16
        wb_ctrl_toint = _RANDOM[3'h6][13];	// Reg.scala:15:16
        divSqrt_waddr = _RANDOM[3'h6][23:19];	// FPU.scala:870:26, Reg.scala:15:16
        wen = _RANDOM[3'h6][26:24];	// FPU.scala:909:16, Reg.scala:15:16
        wbInfo_0_rd = _RANDOM[3'h6][31:27];	// FPU.scala:910:19, Reg.scala:15:16
        wbInfo_0_typeTag = _RANDOM[3'h7][0];	// FPU.scala:910:19
        wbInfo_0_cp = _RANDOM[3'h7][1];	// FPU.scala:910:19
        wbInfo_0_pipeid = _RANDOM[3'h7][3:2];	// FPU.scala:910:19
        wbInfo_1_rd = _RANDOM[3'h7][8:4];	// FPU.scala:910:19
        wbInfo_1_typeTag = _RANDOM[3'h7][9];	// FPU.scala:910:19
        wbInfo_1_cp = _RANDOM[3'h7][10];	// FPU.scala:910:19
        wbInfo_1_pipeid = _RANDOM[3'h7][12:11];	// FPU.scala:910:19
        wbInfo_2_rd = _RANDOM[3'h7][17:13];	// FPU.scala:910:19
        wbInfo_2_typeTag = _RANDOM[3'h7][18];	// FPU.scala:910:19
        wbInfo_2_cp = _RANDOM[3'h7][19];	// FPU.scala:910:19
        wbInfo_2_pipeid = _RANDOM[3'h7][21:20];	// FPU.scala:910:19
        write_port_busy = _RANDOM[3'h7][22];	// FPU.scala:910:19, Reg.scala:15:16
        wb_toint_exc = _RANDOM[3'h7][27:23];	// FPU.scala:910:19, Reg.scala:15:16
        io_sboard_set_REG = _RANDOM[3'h7][28];	// FPU.scala:910:19, :966:55
        divSqrt_killed = _RANDOM[3'h7][29];	// FPU.scala:910:19, :974:29
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  FPUDecoder fp_decoder (	// FPU.scala:742:26
    .io_inst            (io_inst),
    .io_sigs_wen        (io_dec_wen),
    .io_sigs_ren1       (_fp_decoder_io_sigs_ren1),
    .io_sigs_ren2       (_fp_decoder_io_sigs_ren2),
    .io_sigs_ren3       (_fp_decoder_io_sigs_ren3),
    .io_sigs_swap12     (_fp_decoder_io_sigs_swap12),
    .io_sigs_swap23     (_fp_decoder_io_sigs_swap23),
    .io_sigs_typeTagIn  (_fp_decoder_io_sigs_typeTagIn),
    .io_sigs_typeTagOut (_fp_decoder_io_sigs_typeTagOut),
    .io_sigs_fromint    (_fp_decoder_io_sigs_fromint),
    .io_sigs_toint      (_fp_decoder_io_sigs_toint),
    .io_sigs_fastpipe   (_fp_decoder_io_sigs_fastpipe),
    .io_sigs_fma        (_fp_decoder_io_sigs_fma),
    .io_sigs_div        (_fp_decoder_io_sigs_div),
    .io_sigs_sqrt       (_fp_decoder_io_sigs_sqrt),
    .io_sigs_wflags     (_fp_decoder_io_sigs_wflags)
  );
  regfile_32x65 regfile_ext (	// FPU.scala:796:20
    .R0_addr (ex_ra_2),	// FPU.scala:749:31
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (ex_ra_1),	// FPU.scala:749:31
    .R1_en   (1'h1),
    .R1_clk  (clock),
    .R2_addr (ex_ra_0),	// FPU.scala:749:31
    .R2_en   (1'h1),
    .R2_clk  (clock),
    .W0_addr (waddr),	// FPU.scala:933:18
    .W0_en   (_GEN_3),	// FPU.scala:937:35
    .W0_clk  (clock),
    .W0_data (wdata_1),	// package.scala:32:76
    .W1_addr (load_wb_tag),	// Reg.scala:15:16
    .W1_en   (load_wb),	// FPU.scala:752:20
    .W1_clk  (clock),
    .W1_data ({_wdata_T_2[63], _wdata_T_4[2:1], _GEN, _GEN_0}),	// FPU.scala:339:8, :426:23, rawFloatFromFN.scala:46:22, recFNFromFN.scala:48:{16,79}
    .R0_data (_regfile_ext_R0_data),
    .R1_data (_regfile_ext_R1_data),
    .R2_data (_regfile_ext_R2_data)
  );
  FPUFMAPipe sfma (	// FPU.scala:844:20
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_dfma_io_in_valid_T & _write_port_busy_T_16),	// FPU.scala:845:{33,48,70}
    .io_in_bits_ren3   (ex_reg_ctrl_ren3),	// Reg.scala:15:16
    .io_in_bits_swap23 (ex_reg_ctrl_swap23),	// Reg.scala:15:16
    .io_in_bits_rm     (req_2_rm),	// FPU.scala:821:18
    .io_in_bits_fmaCmd
      ({ex_reg_inst[3], ex_reg_inst[2] | ~ex_reg_ctrl_ren3 & ex_reg_inst[27]}),	// FPU.scala:833:{30,36,39,53,67}, Reg.scala:15:16
    .io_in_bits_in1
      ({32'h0,
        {_regfile_ext_R2_data[31], _regfile_ext_R2_data[52], _regfile_ext_R2_data[30:0]}
          | ((&(_regfile_ext_R2_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}, :796:20, :828:13
    .io_in_bits_in2
      ({32'h0,
        {_regfile_ext_R1_data[31], _regfile_ext_R1_data[52], _regfile_ext_R1_data[30:0]}
          | ((&(_regfile_ext_R1_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}, :796:20, :828:13, :829:13
    .io_in_bits_in3
      ({32'h0,
        {_regfile_ext_R0_data[31], _regfile_ext_R0_data[52], _regfile_ext_R0_data[30:0]}
          | ((&(_regfile_ext_R0_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// Cat.scala:30:58, FPU.scala:327:{49,84}, :352:14, :353:14, :354:14, :367:{26,31}, :796:20, :828:13, :830:13
    .io_out_bits_data  (_sfma_io_out_bits_data),
    .io_out_bits_exc   (_sfma_io_out_bits_exc)
  );
  FPToInt fpiu (	// FPU.scala:848:20
    .clock                 (clock),
    .io_in_valid
      (ex_reg_valid
       & (ex_reg_ctrl_toint | ex_reg_ctrl_div | ex_reg_ctrl_sqrt | ex_reg_ctrl_fastpipe
          & ex_reg_ctrl_wflags)),	// FPU.scala:746:25, :849:{33,82,103}, Reg.scala:15:16
    .io_in_bits_ren2       (ex_reg_ctrl_ren2),	// Reg.scala:15:16
    .io_in_bits_typeTagOut (ex_reg_ctrl_typeTagOut),	// Reg.scala:15:16
    .io_in_bits_wflags     (ex_reg_ctrl_wflags),	// Reg.scala:15:16
    .io_in_bits_rm         (req_2_rm),	// FPU.scala:821:18
    .io_in_bits_typ        (ex_reg_inst[21:20]),	// FPU.scala:831:27, Reg.scala:15:16
    .io_in_bits_fmt        (ex_reg_inst[26:25]),	// FPU.scala:832:27, Reg.scala:15:16
    .io_in_bits_in1        (req_1_in1),	// FPU.scala:364:10
    .io_in_bits_in2        (req_1_in2),	// FPU.scala:364:10
    .io_out_bits_in_rm     (_fpiu_io_out_bits_in_rm),
    .io_out_bits_in_in1    (_fpiu_io_out_bits_in_in1),
    .io_out_bits_in_in2    (_fpiu_io_out_bits_in_in2),
    .io_out_bits_lt        (_fpiu_io_out_bits_lt),
    .io_out_bits_store     (io_store_data),
    .io_out_bits_toint     (io_toint_data),
    .io_out_bits_exc       (_fpiu_io_out_bits_exc)
  );
  IntToFP ifpu (	// FPU.scala:858:20
    .clock                (clock),
    .reset                (reset),
    .io_in_valid          (ex_reg_valid & ex_reg_ctrl_fromint),	// FPU.scala:746:25, :859:33, Reg.scala:15:16
    .io_in_bits_typeTagIn (ex_reg_ctrl_typeTagIn),	// Reg.scala:15:16
    .io_in_bits_wflags    (ex_reg_ctrl_wflags),	// Reg.scala:15:16
    .io_in_bits_rm        (req_2_rm),	// FPU.scala:821:18
    .io_in_bits_typ       (ex_reg_inst[21:20]),	// FPU.scala:831:27, Reg.scala:15:16
    .io_in_bits_in1       (io_fromint_data),
    .io_out_bits_data     (_ifpu_io_out_bits_data),
    .io_out_bits_exc      (_ifpu_io_out_bits_exc)
  );
  FPToFP fpmu (	// FPU.scala:863:20
    .clock                 (clock),
    .reset                 (reset),
    .io_in_valid           (ex_reg_valid & ex_reg_ctrl_fastpipe),	// FPU.scala:746:25, :864:33, Reg.scala:15:16
    .io_in_bits_ren2       (ex_reg_ctrl_ren2),	// Reg.scala:15:16
    .io_in_bits_typeTagOut (ex_reg_ctrl_typeTagOut),	// Reg.scala:15:16
    .io_in_bits_wflags     (ex_reg_ctrl_wflags),	// Reg.scala:15:16
    .io_in_bits_rm         (req_2_rm),	// FPU.scala:821:18
    .io_in_bits_in1        (req_1_in1),	// FPU.scala:364:10
    .io_in_bits_in2        (req_1_in2),	// FPU.scala:364:10
    .io_lt                 (_fpiu_io_out_bits_lt),	// FPU.scala:848:20
    .io_out_bits_data      (_fpmu_io_out_bits_data),
    .io_out_bits_exc       (_fpmu_io_out_bits_exc)
  );
  FPUFMAPipe_1 dfma (	// FPU.scala:882:28
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (_dfma_io_in_valid_T & ex_reg_ctrl_typeTagOut == 2'h1),	// FPU.scala:845:33, :883:{56,78}, Reg.scala:15:16, rawFloatFromFN.scala:60:27
    .io_in_bits_ren3   (ex_reg_ctrl_ren3),	// Reg.scala:15:16
    .io_in_bits_swap23 (ex_reg_ctrl_swap23),	// Reg.scala:15:16
    .io_in_bits_rm     (req_2_rm),	// FPU.scala:821:18
    .io_in_bits_fmaCmd
      ({ex_reg_inst[3], ex_reg_inst[2] | ~ex_reg_ctrl_ren3 & ex_reg_inst[27]}),	// FPU.scala:833:{30,36,39,53,67}, Reg.scala:15:16
    .io_in_bits_in1    (_regfile_ext_R2_data),	// FPU.scala:796:20
    .io_in_bits_in2    (_regfile_ext_R1_data),	// FPU.scala:796:20
    .io_in_bits_in3    (_regfile_ext_R0_data),	// FPU.scala:796:20
    .io_out_bits_data  (_dfma_io_out_bits_data),
    .io_out_bits_exc   (_dfma_io_out_bits_exc)
  );
  DivSqrtRecFN_small divSqrt (	// FPU.scala:981:27
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (_divSqrt_io_inValid_T_5),	// FPU.scala:982:100
    .io_sqrtOp         (mem_ctrl_sqrt),	// Reg.scala:15:16
    .io_a
      ({_fpiu_io_out_bits_in_in1[64],
        _fpiu_io_out_bits_in_in1[63:61] == 3'h0 | _fpiu_io_out_bits_in_in1[63:61] > 3'h5
          ? {_fpiu_io_out_bits_in_in1[63:61], _divSqrt_io_a_expOut_commonCase_T[5:0]}
          : _divSqrt_io_a_expOut_commonCase_T,
        _fpiu_io_out_bits_in_in1[51:29]}),	// Cat.scala:30:58, FPU.scala:268:17, :270:18, :271:38, :273:26, :274:{31,48}, :275:{10,19,25,36,65}, :848:20
    .io_b
      ({_fpiu_io_out_bits_in_in2[64],
        _fpiu_io_out_bits_in_in2[63:61] == 3'h0 | _fpiu_io_out_bits_in_in2[63:61] > 3'h5
          ? {_fpiu_io_out_bits_in_in2[63:61], _divSqrt_io_b_expOut_commonCase_T[5:0]}
          : _divSqrt_io_b_expOut_commonCase_T,
        _fpiu_io_out_bits_in_in2[51:29]}),	// Cat.scala:30:58, FPU.scala:268:17, :270:18, :271:38, :273:26, :274:{31,48}, :275:{10,19,25,36,65}, :848:20
    .io_roundingMode   (_fpiu_io_out_bits_in_rm),	// FPU.scala:848:20
    .io_inReady        (_divSqrt_io_inReady),
    .io_outValid_div   (_divSqrt_io_outValid_div),
    .io_outValid_sqrt  (_divSqrt_io_outValid_sqrt),
    .io_out            (_divSqrt_io_out),
    .io_exceptionFlags (_divSqrt_io_exceptionFlags)
  );
  DivSqrtRecFN_small_1 divSqrt_1 (	// FPU.scala:981:27
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (_divSqrt_io_inValid_T_11),	// FPU.scala:982:100
    .io_sqrtOp         (mem_ctrl_sqrt),	// Reg.scala:15:16
    .io_a              (_fpiu_io_out_bits_in_in1),	// FPU.scala:848:20
    .io_b              (_fpiu_io_out_bits_in_in2),	// FPU.scala:848:20
    .io_roundingMode   (_fpiu_io_out_bits_in_rm),	// FPU.scala:848:20
    .io_inReady        (_divSqrt_1_io_inReady),
    .io_outValid_div   (_divSqrt_1_io_outValid_div),
    .io_outValid_sqrt  (_divSqrt_1_io_outValid_sqrt),
    .io_out            (_divSqrt_1_io_out),
    .io_exceptionFlags (_divSqrt_1_io_exceptionFlags)
  );
  assign io_fcsr_flags_valid = wb_toint_valid | divSqrt_wen | wen[0];	// FPU.scala:909:16, :937:30, :953:37, :955:56, :996:66, :997:21
  assign io_fcsr_flags_bits =
    (wb_toint_valid ? wb_toint_exc : 5'h0) | (divSqrt_wen ? divSqrt_flags : 5'h0)
    | (wen[0] ? _GEN_2[wbInfo_0_pipeid] : 5'h0);	// FPU.scala:909:16, :910:19, :937:30, :953:37, :957:8, :958:{8,46}, :959:8, :996:66, :997:21, :999:23, Reg.scala:15:16, package.scala:32:{76,86}
  assign io_fcsr_rdy =
    ~(ex_reg_valid & ex_reg_ctrl_wflags | mem_reg_valid & mem_ctrl_wflags | wb_toint_valid
      | (|wen) | divSqrt_inFlight);	// FPU.scala:746:25, :763:30, :909:16, :953:37, :961:72, :962:{18,33,68,131}, :989:{34,53}, Reg.scala:15:16
  assign io_nack_mem = _io_nack_mem_output;	// FPU.scala:963:61
  assign io_illegal_rm =
    io_inst[14:12] == 3'h5 | io_inst[14:12] == 3'h6 | (&(io_inst[14:12]))
    & io_fcsr_rm > 3'h4;	// FPU.scala:971:{27,49,67,73,87}, package.scala:15:47
  assign io_dec_ren1 = _fp_decoder_io_sigs_ren1;	// FPU.scala:742:26
  assign io_dec_ren2 = _fp_decoder_io_sigs_ren2;	// FPU.scala:742:26
  assign io_dec_ren3 = _fp_decoder_io_sigs_ren3;	// FPU.scala:742:26
  assign io_sboard_set = wb_reg_valid & io_sboard_set_REG;	// FPU.scala:771:25, :966:{49,55}
  assign io_sboard_clr = divSqrt_wen | wen[0] & (&wbInfo_0_pipeid);	// FPU.scala:909:16, :910:19, :937:30, :967:{49,60}, :996:66, :997:21, package.scala:32:86
  assign io_sboard_clra = waddr;	// FPU.scala:933:18
endmodule

