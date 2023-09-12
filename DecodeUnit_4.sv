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

module DecodeUnit_4(
  input  [31:0] io_enq_uop_inst,
  input         io_enq_uop_is_sfb,
                io_enq_uop_xcpt_pf_if,
                io_enq_uop_xcpt_ae_if,
                io_enq_uop_bp_debug_if,
                io_enq_uop_bp_xcpt_if,
  input  [31:0] io_status_isa,
  input         io_csr_decode_fp_illegal,
                io_csr_decode_read_illegal,
                io_csr_decode_write_illegal,
                io_csr_decode_write_flush,
                io_csr_decode_system_illegal,
                io_interrupt,
  input  [63:0] io_interrupt_cause,
  output [6:0]  io_deq_uop_uopc,
  output [2:0]  io_deq_uop_iq_type,
  output [9:0]  io_deq_uop_fu_code,
  output        io_deq_uop_is_br,
                io_deq_uop_is_jalr,
                io_deq_uop_is_jal,
  output [19:0] io_deq_uop_imm_packed,
  output        io_deq_uop_exception,
  output [63:0] io_deq_uop_exc_cause,
  output        io_deq_uop_bypassable,
  output [4:0]  io_deq_uop_mem_cmd,
  output [1:0]  io_deq_uop_mem_size,
  output        io_deq_uop_mem_signed,
                io_deq_uop_is_fence,
                io_deq_uop_is_fencei,
                io_deq_uop_is_amo,
                io_deq_uop_uses_ldq,
                io_deq_uop_uses_stq,
                io_deq_uop_is_sys_pc2epc,
                io_deq_uop_is_unique,
                io_deq_uop_flush_on_commit,
  output [5:0]  io_deq_uop_ldst,
                io_deq_uop_lrs1,
                io_deq_uop_lrs2,
                io_deq_uop_lrs3,
  output        io_deq_uop_ldst_val,
  output [1:0]  io_deq_uop_dst_rtype,
                io_deq_uop_lrs1_rtype,
                io_deq_uop_lrs2_rtype,
  output        io_deq_uop_frs3_en,
                io_deq_uop_fp_val,
                io_deq_uop_fp_single,
  output [11:0] io_csr_decode_csr
);

  wire [4:0]  _uop_lrs1_T;	// decode.scala:531:25
  wire [9:0]  _GEN = {io_enq_uop_inst[14:12], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_749 = _GEN == 10'h103;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_3 = _GEN == 10'h83;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_5 = _GEN == 10'h283;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_7 = _GEN == 10'h3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_9 = _GEN == 10'h203;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_11 = _GEN == 10'h123;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_13 = _GEN == 10'hA3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_15 = _GEN == 10'h23;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_17 = io_enq_uop_inst[6:0] == 7'h37;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_19 = _GEN == 10'h13;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_21 = _GEN == 10'h393;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_23 = _GEN == 10'h313;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_25 = _GEN == 10'h213;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_27 = _GEN == 10'h113;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_29 = _GEN == 10'h193;	// Decode.scala:14:{65,121}
  wire [16:0] _GEN_0 =
    {io_enq_uop_inst[31:25], io_enq_uop_inst[14:12], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_31 = _GEN_0 == 17'hB3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_33 = _GEN_0 == 17'h33;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_35 = _GEN_0 == 17'h8033;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_37 = _GEN_0 == 17'h133;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_39 = _GEN_0 == 17'h1B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_41 = _GEN_0 == 17'h3B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_43 = _GEN_0 == 17'h333;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_45 = _GEN_0 == 17'h233;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_47 = _GEN_0 == 17'h82B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_49 = _GEN_0 == 17'h2B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_51 = _GEN_0 == 17'h433;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_53 = _GEN_0 == 17'h4B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_55 = _GEN_0 == 17'h5B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_57 = _GEN_0 == 17'h533;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_59 = _GEN_0 == 17'h43B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_61 = _GEN_0 == 17'h633;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_63 = _GEN_0 == 17'h6B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_65 = _GEN_0 == 17'h733;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_67 = _GEN_0 == 17'h7B3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_69 = _GEN_0 == 17'h63B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_71 = _GEN_0 == 17'h6BB;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_73 = _GEN_0 == 17'h73B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_75 = _GEN_0 == 17'h7BB;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_77 = io_enq_uop_inst[6:0] == 7'h17;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_79 = io_enq_uop_inst[6:0] == 7'h6F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_81 = _GEN == 10'h67;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_889 = _GEN == 10'hF3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_97 = _GEN == 10'h173;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_99 = _GEN == 10'h1F3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_101 = _GEN == 10'h2F3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_103 = _GEN == 10'h373;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_105 = _GEN == 10'h3F3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_107 =
    {io_enq_uop_inst[31:25], io_enq_uop_inst[14:0]} == 22'h48073;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_888 = io_enq_uop_inst == 32'h73;	// Decode.scala:14:121
  wire        _cs_decoder_bit_T_109 = io_enq_uop_inst == 32'h100073;	// Decode.scala:14:121
  wire        _cs_decoder_bit_T_110 = io_enq_uop_inst == 32'h10200073;	// Decode.scala:14:121
  wire        _cs_decoder_bit_T_111 = io_enq_uop_inst == 32'h30200073;	// Decode.scala:14:121
  wire        _cs_decoder_bit_T_112 = io_enq_uop_inst == 32'h7B200073;	// Decode.scala:14:121
  wire        _cs_decoder_bit_T_113 = io_enq_uop_inst == 32'h10500073;	// Decode.scala:14:121
  wire        cs_is_fencei = _GEN == 10'h8F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_117 = _GEN == 10'hF;	// Decode.scala:14:{65,121}
  wire [14:0] _GEN_1 =
    {io_enq_uop_inst[31:27], io_enq_uop_inst[14:12], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_119 = _GEN_1 == 15'h12F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_121 = _GEN_1 == 15'h112F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_123 = _GEN_1 == 15'h52F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_125 = _GEN_1 == 15'h312F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_127 = _GEN_1 == 15'h212F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_129 = _GEN_1 == 15'h412F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_131 = _GEN_1 == 15'h612F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_133 = _GEN_1 == 15'h512F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_135 = _GEN_1 == 15'h712F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_137 = _GEN_1 == 15'h1AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_139 = _GEN_1 == 15'h11AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_141 = _GEN_1 == 15'h5AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_143 = _GEN_1 == 15'h31AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_145 = _GEN_1 == 15'h21AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_147 = _GEN_1 == 15'h41AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_149 = _GEN_1 == 15'h61AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_151 = _GEN_1 == 15'h51AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_153 = _GEN_1 == 15'h71AF;	// Decode.scala:14:{65,121}
  wire [19:0] _GEN_2 =
    {io_enq_uop_inst[31:27],
     io_enq_uop_inst[24:20],
     io_enq_uop_inst[14:12],
     io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_155 = _GEN_2 == 20'h1012F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_157 = _GEN_2 == 20'h101AF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_159 = _GEN_1 == 15'hD2F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_161 = _GEN_1 == 15'hDAF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_708 = _GEN == 10'h107;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_165 = _GEN == 10'h187;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_659 = _GEN == 10'h127;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_169 = _GEN == 10'h1A7;	// Decode.scala:14:{65,121}
  wire [21:0] _GEN_3 =
    {io_enq_uop_inst[31:20], io_enq_uop_inst[14:12], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_171 = _GEN_3 == 22'h3800D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_173 = _GEN_3 == 22'h3880D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_175 = _GEN_3 == 22'h3C0053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_177 = _GEN_3 == 22'h3C8053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_179 = _GEN_3 == 22'h380053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_181 = _GEN_3 == 22'h388053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_183 = _GEN_0 == 17'h4053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_185 = _GEN_0 == 17'h4453;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_187 = _GEN_0 == 17'h4153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_189 = _GEN_0 == 17'h4553;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_191 = _GEN_0 == 17'h40D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_193 = _GEN_0 == 17'h44D3;	// Decode.scala:14:{65,121}
  wire [18:0] _GEN_4 = {io_enq_uop_inst[31:20], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_195 = _GEN_4 == 19'h200D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_197 = _GEN_4 == 19'h21053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_199 = _GEN_4 == 19'h68053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_201 = _GEN_4 == 19'h680D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_203 = _GEN_4 == 19'h68153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_205 = _GEN_4 == 19'h681D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_207 = _GEN_4 == 19'h69053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_209 = _GEN_4 == 19'h690D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_211 = _GEN_4 == 19'h69153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_213 = _GEN_4 == 19'h691D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_215 = _GEN_4 == 19'h60053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_217 = _GEN_4 == 19'h600D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_219 = _GEN_4 == 19'h60153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_221 = _GEN_4 == 19'h601D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_223 = _GEN_4 == 19'h61053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_225 = _GEN_4 == 19'h610D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_227 = _GEN_4 == 19'h61153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_229 = _GEN_4 == 19'h611D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_231 = _GEN_0 == 17'h14153;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_233 = _GEN_0 == 17'h140D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_235 = _GEN_0 == 17'h14053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_237 = _GEN_0 == 17'h14553;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_239 = _GEN_0 == 17'h144D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_241 = _GEN_0 == 17'h14453;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_243 = _GEN_0 == 17'h5053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_245 = _GEN_0 == 17'h50D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_247 = _GEN_0 == 17'h5453;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_249 = _GEN_0 == 17'h54D3;	// Decode.scala:14:{65,121}
  wire [13:0] _GEN_5 = {io_enq_uop_inst[31:25], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_251 = _GEN_5 == 14'h53;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_253 = _GEN_5 == 14'h253;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_255 = _GEN_5 == 14'h453;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_257 = _GEN_5 == 14'hD3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_259 = _GEN_5 == 14'h2D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_261 = _GEN_5 == 14'h4D3;	// Decode.scala:14:{65,121}
  wire [8:0]  _GEN_6 = {io_enq_uop_inst[26:25], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_263 = _GEN_6 == 9'h43;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_265 = _GEN_6 == 9'h47;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_267 = _GEN_6 == 9'h4F;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_269 = _GEN_6 == 9'h4B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_271 = _GEN_6 == 9'hC3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_273 = _GEN_6 == 9'hC7;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_275 = _GEN_6 == 9'hCF;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_277 = _GEN_6 == 9'hCB;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_279 = _GEN_5 == 14'h653;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_281 = _GEN_5 == 14'h6D3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_283 = _GEN_4 == 19'h2C053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_285 = _GEN_4 == 19'h2D053;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_287 = _GEN == 10'h183;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_289 = _GEN == 10'h303;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_291 = _GEN == 10'h1A3;	// Decode.scala:14:{65,121}
  wire [15:0] _GEN_7 =
    {io_enq_uop_inst[31:26], io_enq_uop_inst[14:12], io_enq_uop_inst[6:0]};	// Decode.scala:14:65
  wire        _cs_decoder_bit_T_293 = _GEN_7 == 16'h93;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_295 = _GEN_7 == 16'h293;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_297 = _GEN_7 == 16'h4293;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_299 = _GEN == 10'h1B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_301 = _GEN_0 == 17'h9B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_303 = _GEN_0 == 17'h829B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_305 = _GEN_0 == 17'h29B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_307 = _GEN_0 == 17'h3B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_309 = _GEN_0 == 17'h803B;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_311 = _GEN_0 == 17'hBB;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_313 = _GEN_0 == 17'h82BB;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_bit_T_315 = _GEN_0 == 17'h2BB;	// Decode.scala:14:{65,121}
  wire        cs_fp_val =
    _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165 | _cs_decoder_bit_T_659
    | _cs_decoder_bit_T_169 | _cs_decoder_bit_T_171 | _cs_decoder_bit_T_173
    | _cs_decoder_bit_T_175 | _cs_decoder_bit_T_177 | _cs_decoder_bit_T_179
    | _cs_decoder_bit_T_181 | _cs_decoder_bit_T_183 | _cs_decoder_bit_T_185
    | _cs_decoder_bit_T_187 | _cs_decoder_bit_T_189 | _cs_decoder_bit_T_191
    | _cs_decoder_bit_T_193 | _cs_decoder_bit_T_195 | _cs_decoder_bit_T_197
    | _cs_decoder_bit_T_199 | _cs_decoder_bit_T_201 | _cs_decoder_bit_T_203
    | _cs_decoder_bit_T_205 | _cs_decoder_bit_T_207 | _cs_decoder_bit_T_209
    | _cs_decoder_bit_T_211 | _cs_decoder_bit_T_213 | _cs_decoder_bit_T_215
    | _cs_decoder_bit_T_217 | _cs_decoder_bit_T_219 | _cs_decoder_bit_T_221
    | _cs_decoder_bit_T_223 | _cs_decoder_bit_T_225 | _cs_decoder_bit_T_227
    | _cs_decoder_bit_T_229 | _cs_decoder_bit_T_231 | _cs_decoder_bit_T_233
    | _cs_decoder_bit_T_235 | _cs_decoder_bit_T_237 | _cs_decoder_bit_T_239
    | _cs_decoder_bit_T_241 | _cs_decoder_bit_T_243 | _cs_decoder_bit_T_245
    | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249 | _cs_decoder_bit_T_251
    | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255 | _cs_decoder_bit_T_257
    | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261 | _cs_decoder_bit_T_263
    | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267 | _cs_decoder_bit_T_269
    | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273 | _cs_decoder_bit_T_275
    | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279 | _cs_decoder_bit_T_281
    | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285;	// Decode.scala:14:121, :15:30
  wire        cs_fp_single =
    {io_enq_uop_inst[12], io_enq_uop_inst[6]} == 2'h0
    | {io_enq_uop_inst[25], io_enq_uop_inst[6]} == 2'h1;	// Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69
  wire [4:0]  _GEN_8 =
    {io_enq_uop_inst[14], io_enq_uop_inst[12], io_enq_uop_inst[6:5], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire        _cs_decoder_T_26 = {io_enq_uop_inst[14:12], io_enq_uop_inst[6:5]} == 5'hB;	// Decode.scala:14:{65,121}
  wire [6:0]  _GEN_9 =
    {io_enq_uop_inst[25],
     io_enq_uop_inst[14:12],
     io_enq_uop_inst[6],
     io_enq_uop_inst[4],
     io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire [5:0]  _GEN_10 =
    {io_enq_uop_inst[14:12], io_enq_uop_inst[6:5], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire [2:0]  _GEN_11 = {io_enq_uop_inst[5:4], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire        _cs_decoder_T_397 = _GEN_11 == 3'h3;	// Decode.scala:14:{65,121}
  wire [3:0]  _GEN_12 = {io_enq_uop_inst[28], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire        _cs_decoder_T_94 = _GEN_12 == 4'h2;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_96 = io_enq_uop_inst[6:3] == 4'h4;	// Decode.scala:14:{65,121}
  wire [5:0]  _GEN_13 = {io_enq_uop_inst[29:27], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire [4:0]  _GEN_14 = {io_enq_uop_inst[13:12], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire [4:0]  _GEN_15 = {io_enq_uop_inst[14:13], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire        _cs_decoder_T_120 = _GEN_15 == 5'h19;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_124 = {io_enq_uop_inst[27], io_enq_uop_inst[6:4]} == 4'hA;	// Decode.scala:14:{65,121}
  wire [5:0]  _GEN_16 =
    {io_enq_uop_inst[31:30], io_enq_uop_inst[25], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire [1:0]  _GEN_17 = {io_enq_uop_inst[4], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire        _cs_decoder_T_167 =
    {io_enq_uop_inst[13], io_enq_uop_inst[5], io_enq_uop_inst[2]} == 3'h3;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_330 = {io_enq_uop_inst[25], io_enq_uop_inst[6:3]} == 5'h8;	// Decode.scala:14:{65,121}
  wire [2:0]  _GEN_18 = {io_enq_uop_inst[6:5], io_enq_uop_inst[3]};	// Decode.scala:14:65
  wire        _cs_decoder_T_209 =
    {io_enq_uop_inst[31], io_enq_uop_inst[29], io_enq_uop_inst[6:4]} == 5'h15;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_362 =
    {io_enq_uop_inst[13:12], io_enq_uop_inst[6], io_enq_uop_inst[3]} == 4'h1;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_246 =
    {io_enq_uop_inst[25], io_enq_uop_inst[6:5], io_enq_uop_inst[2]} == 4'h5;	// Decode.scala:14:{65,121}
  wire [4:0]  _GEN_19 =
    {io_enq_uop_inst[14:13], io_enq_uop_inst[6:5], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire [3:0]  _GEN_20 = {io_enq_uop_inst[6:4], io_enq_uop_inst[2]};	// Decode.scala:14:65
  wire        cs_is_br = _GEN_20 == 4'hC;	// Decode.scala:14:{65,121}, Mux.scala:47:69
  wire        _cs_decoder_T_262 =
    {io_enq_uop_inst[25],
     io_enq_uop_inst[14],
     io_enq_uop_inst[12],
     io_enq_uop_inst[6:5],
     io_enq_uop_inst[2]} == 6'h32;	// Decode.scala:14:{65,121}
  wire [5:0]  _GEN_21 = {io_enq_uop_inst[30:28], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire [5:0]  _GEN_22 =
    {io_enq_uop_inst[14:12], io_enq_uop_inst[6:5], io_enq_uop_inst[3]};	// Decode.scala:14:65
  wire        _cs_decoder_T_321 = {io_enq_uop_inst[25], io_enq_uop_inst[6:2]} == 6'h2C;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_347 =
    {io_enq_uop_inst[13], io_enq_uop_inst[5:4], io_enq_uop_inst[2]} == 4'h5;	// Decode.scala:14:{65,121}
  wire [3:0]  _GEN_23 = {io_enq_uop_inst[14], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire        cs_decoder_hi_hi_lo_1 =
    {io_enq_uop_inst[28:27], io_enq_uop_inst[6:4]} == 5'h1D;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_500 =
    {io_enq_uop_inst[28],
     io_enq_uop_inst[14:13],
     io_enq_uop_inst[6],
     io_enq_uop_inst[3]} == 5'h5;	// Decode.scala:14:{65,121}, package.scala:15:47
  wire        _cs_decoder_T_383 =
    {io_enq_uop_inst[27],
     io_enq_uop_inst[13],
     io_enq_uop_inst[6],
     io_enq_uop_inst[3]} == 4'hD;	// Decode.scala:14:{65,121}
  wire [6:0]  cs_uopc =
    {io_enq_uop_inst[6:5] == 2'h2
       | {io_enq_uop_inst[13:12], io_enq_uop_inst[6], io_enq_uop_inst[4]} == 4'h3
       | _cs_decoder_T_500
       | {io_enq_uop_inst[28],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3]} == 5'hD | _cs_decoder_T_383,
     _cs_decoder_T_362 | _cs_decoder_T_397 | _cs_decoder_T_347 | (&_GEN_18)
       | _GEN_14 == 5'h7 | (&_GEN_14) | (&_GEN_23) | _cs_decoder_T_321
       | {io_enq_uop_inst[25], io_enq_uop_inst[6:4]} == 4'hC | _cs_decoder_T_262
       | cs_decoder_hi_hi_lo_1 | {io_enq_uop_inst[25], io_enq_uop_inst[3:2]} == 3'h2
       | {io_enq_uop_inst[13], io_enq_uop_inst[3:2]} == 3'h2,
     _cs_decoder_T_330 | _cs_decoder_T_246 | _GEN_21 == 6'h5
       | {io_enq_uop_inst[30:29], io_enq_uop_inst[27], io_enq_uop_inst[6:4]} == 6'h5
       | cs_is_br | _GEN_22 == 6'hE | {io_enq_uop_inst[13], io_enq_uop_inst[6:2]} == 6'h2C
       | _GEN_22 == 6'h16
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3]} == 4'h5 | _GEN_19 == 5'h12 | _GEN_8 == 5'h12
       | {io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[5:4],
          io_enq_uop_inst[2]} == 7'h26 | _cs_decoder_T_321
       | {io_enq_uop_inst[28:27],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 6'h13
       | {io_enq_uop_inst[30:29], io_enq_uop_inst[14:13], io_enq_uop_inst[5:2]} == 8'h8C
       | {io_enq_uop_inst[31:30],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 6'h23
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[29],
          io_enq_uop_inst[14:12],
          io_enq_uop_inst[4],
          io_enq_uop_inst[2]} == 7'h66,
     _cs_decoder_T_362
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[5:4],
          io_enq_uop_inst[2]} == 7'h6 | _cs_decoder_T_330 | _cs_decoder_T_246
       | _GEN_19 == 5'h6 | _GEN_8 == 5'h6 | cs_is_br | _GEN_9 == 7'hA
       | {io_enq_uop_inst[13:12], io_enq_uop_inst[6:2]} == 7'h24
       | {io_enq_uop_inst[14:13], io_enq_uop_inst[6:4], io_enq_uop_inst[2]} == 6'h12
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[2]} == 6'h32 | _cs_decoder_T_262
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 6'h34 | _GEN_13 == 6'hD
       | {io_enq_uop_inst[31], io_enq_uop_inst[28:27], io_enq_uop_inst[6:4]} == 6'h15
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[29],
          io_enq_uop_inst[27],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 7'h23
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[29],
          io_enq_uop_inst[27],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 7'h23 | _GEN_16 == 6'h1D | _cs_decoder_T_209
       | {io_enq_uop_inst[14:12], io_enq_uop_inst[6:4], io_enq_uop_inst[2]} == 7'h42
       | _GEN_21 == 6'h25
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[27],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:4]} == 6'hD,
     {io_enq_uop_inst[14:12], io_enq_uop_inst[6:3]} == 7'h2 | (&_GEN_17)
       | _cs_decoder_T_167
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[5],
          io_enq_uop_inst[3]} == 5'h3
       | {io_enq_uop_inst[30:27],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3]} == 8'h4 | _cs_decoder_T_330
       | {io_enq_uop_inst[25], io_enq_uop_inst[6], io_enq_uop_inst[2]} == 3'h3
       | (&_GEN_18)
       | {io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3:2]} == 5'hA
       | {io_enq_uop_inst[14:12], io_enq_uop_inst[5:4]} == 5'h7 | _cs_decoder_T_26
       | {io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3]} == 4'h9
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3]} == 6'h12
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6:5]} == 5'h9
       | {io_enq_uop_inst[14], io_enq_uop_inst[12], io_enq_uop_inst[5:4]} == 4'hA
       | {io_enq_uop_inst[14], io_enq_uop_inst[12], io_enq_uop_inst[6:3]} == 6'h32
       | _cs_decoder_T_120 | {io_enq_uop_inst[25], io_enq_uop_inst[4:2]} == 4'hA
       | {io_enq_uop_inst[25], io_enq_uop_inst[14], io_enq_uop_inst[6:3]} == 6'h26
       | {io_enq_uop_inst[25], io_enq_uop_inst[13:12], io_enq_uop_inst[6:3]} == 7'h76
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3]} == 5'h19
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:4]} == 6'h1D
       | {io_enq_uop_inst[30], io_enq_uop_inst[28:27], io_enq_uop_inst[6:4]} == 6'h1D
       | {io_enq_uop_inst[30:29],
          io_enq_uop_inst[27],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[4:3]} == 7'h32
       | {io_enq_uop_inst[31:30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[20],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3]} == 7'h24 | _cs_decoder_T_209
       | {io_enq_uop_inst[31:30], io_enq_uop_inst[14:12], io_enq_uop_inst[4:3]} == 7'h62
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6:4]} == 7'h3,
     {io_enq_uop_inst[13], io_enq_uop_inst[4:2]} == 4'h1
       | {io_enq_uop_inst[12], io_enq_uop_inst[6:5], io_enq_uop_inst[3]} == 4'h1
       | _cs_decoder_T_397
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 8'h4 | _cs_decoder_T_94 | _cs_decoder_T_96
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[22],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[5:2]} == 9'hC
       | {io_enq_uop_inst[6:5], io_enq_uop_inst[2]} == 3'h5 | _GEN_13 == 6'h5
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3:2]} == 6'hA
       | {io_enq_uop_inst[29:27],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[5:4]} == 7'h5
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 6'h14
       | {io_enq_uop_inst[14:12], io_enq_uop_inst[6:4]} == 6'hF | _GEN_14 == 5'h17
       | _GEN_14 == 5'h19
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[14:12],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[2]} == 7'h2A
       | {io_enq_uop_inst[14], io_enq_uop_inst[12], io_enq_uop_inst[5:3]} == 5'h1C
       | _cs_decoder_T_120
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[2]} == 6'h32 | _cs_decoder_T_124
       | {io_enq_uop_inst[30:29],
          io_enq_uop_inst[27],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:4]} == 7'h1D
       | {io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[5:4],
          io_enq_uop_inst[2]} == 7'h66 | _GEN_16 == 6'h15
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[28],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 6'h23 | _GEN_10 == 6'h1A | (&_GEN_15),
     _GEN_8 == 5'h0 | io_enq_uop_inst[5:2] == 4'h0
       | {io_enq_uop_inst[6:5], io_enq_uop_inst[3:2]} == 4'h1
       | io_enq_uop_inst[5:3] == 3'h5
       | {io_enq_uop_inst[30:29],
          io_enq_uop_inst[27],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 8'h8 | (&{io_enq_uop_inst[6], io_enq_uop_inst[3:2]})
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3]} == 6'h8
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[12],
          io_enq_uop_inst[5],
          io_enq_uop_inst[3]} == 4'h7
       | {io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4:2]} == 6'h18
       | {io_enq_uop_inst[13:12], io_enq_uop_inst[6:5]} == 4'h8 | _cs_decoder_T_26
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[2]} == 7'h1A
       | (&{io_enq_uop_inst[14], io_enq_uop_inst[12], io_enq_uop_inst[6:4]})
       | {io_enq_uop_inst[14:13], io_enq_uop_inst[4:2]} == 5'h18 | _GEN_9 == 7'h4A
       | {io_enq_uop_inst[28:27],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 7'h38
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[21],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[4],
          io_enq_uop_inst[2]} == 8'h42
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 7'h28
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[5:4],
          io_enq_uop_inst[2]} == 8'h66
       | {io_enq_uop_inst[29],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14:13],
          io_enq_uop_inst[5],
          io_enq_uop_inst[3:2]} == 7'h60
       | {io_enq_uop_inst[29],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[5],
          io_enq_uop_inst[3:2]} == 7'h60
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[14],
          io_enq_uop_inst[6],
          io_enq_uop_inst[3:2]} == 5'h12
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 7'h58
       | {io_enq_uop_inst[31],
          io_enq_uop_inst[25],
          io_enq_uop_inst[6:5],
          io_enq_uop_inst[3:2]} == 6'h38
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[25],
          io_enq_uop_inst[14],
          io_enq_uop_inst[12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4:2]} == 8'h4 | _GEN_10 == 6'h22
       | {io_enq_uop_inst[25],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4],
          io_enq_uop_inst[2]} == 6'h32};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, decode.scala:578:32, :585:35, package.scala:15:47
  wire        _cs_decoder_T_535 =
    {io_enq_uop_inst[25],
     io_enq_uop_inst[6],
     io_enq_uop_inst[4],
     io_enq_uop_inst[2]} == 4'h2;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_391 = _GEN_20 == 4'h2;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_542 = _GEN_12 == 4'h7;	// Decode.scala:14:{65,121}
  wire [3:0]  _GEN_24 = {io_enq_uop_inst[12], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire [3:0]  _GEN_25 = {io_enq_uop_inst[13], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire        _cs_decoder_T_415 =
    {io_enq_uop_inst[28],
     io_enq_uop_inst[25],
     io_enq_uop_inst[5:4],
     io_enq_uop_inst[2]} == 5'h16;	// Decode.scala:14:{65,121}
  wire        _cs_decoder_T_417 =
    {io_enq_uop_inst[31:29], io_enq_uop_inst[6], io_enq_uop_inst[4]} == 5'hF;	// Decode.scala:14:{65,121}
  wire        cs_frs3_en = io_enq_uop_inst[6:4] == 3'h4;	// Decode.scala:14:{65,121}, decode.scala:491:32
  wire [4:0]  _GEN_26 = {io_enq_uop_inst[31], io_enq_uop_inst[28], io_enq_uop_inst[6:4]};	// Decode.scala:14:65
  wire        _cs_decoder_T_460 = io_enq_uop_inst[6:2] == 5'h9;	// Decode.scala:14:{65,121}
  wire [1:0]  cs_dst_type =
    {~(_cs_decoder_bit_T_749 | _cs_decoder_bit_T_3 | _cs_decoder_bit_T_5
       | _cs_decoder_bit_T_7 | _cs_decoder_bit_T_9 | _cs_decoder_bit_T_17
       | _cs_decoder_bit_T_19 | _cs_decoder_bit_T_21 | _cs_decoder_bit_T_23
       | _cs_decoder_bit_T_25 | _cs_decoder_bit_T_27 | _cs_decoder_bit_T_29
       | _cs_decoder_bit_T_31 | _cs_decoder_bit_T_33 | _cs_decoder_bit_T_35
       | _cs_decoder_bit_T_37 | _cs_decoder_bit_T_39 | _cs_decoder_bit_T_41
       | _cs_decoder_bit_T_43 | _cs_decoder_bit_T_45 | _cs_decoder_bit_T_47
       | _cs_decoder_bit_T_49 | _cs_decoder_bit_T_51 | _cs_decoder_bit_T_53
       | _cs_decoder_bit_T_55 | _cs_decoder_bit_T_57 | _cs_decoder_bit_T_59
       | _cs_decoder_bit_T_61 | _cs_decoder_bit_T_63 | _cs_decoder_bit_T_65
       | _cs_decoder_bit_T_67 | _cs_decoder_bit_T_69 | _cs_decoder_bit_T_71
       | _cs_decoder_bit_T_73 | _cs_decoder_bit_T_75 | _cs_decoder_bit_T_77
       | _cs_decoder_bit_T_79 | _cs_decoder_bit_T_81 | _cs_decoder_bit_T_889
       | _cs_decoder_bit_T_97 | _cs_decoder_bit_T_99 | _cs_decoder_bit_T_101
       | _cs_decoder_bit_T_103 | _cs_decoder_bit_T_105 | _cs_decoder_bit_T_119
       | _cs_decoder_bit_T_121 | _cs_decoder_bit_T_123 | _cs_decoder_bit_T_125
       | _cs_decoder_bit_T_127 | _cs_decoder_bit_T_129 | _cs_decoder_bit_T_131
       | _cs_decoder_bit_T_133 | _cs_decoder_bit_T_135 | _cs_decoder_bit_T_137
       | _cs_decoder_bit_T_139 | _cs_decoder_bit_T_141 | _cs_decoder_bit_T_143
       | _cs_decoder_bit_T_145 | _cs_decoder_bit_T_147 | _cs_decoder_bit_T_149
       | _cs_decoder_bit_T_151 | _cs_decoder_bit_T_153 | _cs_decoder_bit_T_155
       | _cs_decoder_bit_T_157 | _cs_decoder_bit_T_159 | _cs_decoder_bit_T_161
       | _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165 | _cs_decoder_bit_T_171
       | _cs_decoder_bit_T_173 | _cs_decoder_bit_T_175 | _cs_decoder_bit_T_177
       | _cs_decoder_bit_T_179 | _cs_decoder_bit_T_181 | _cs_decoder_bit_T_183
       | _cs_decoder_bit_T_185 | _cs_decoder_bit_T_187 | _cs_decoder_bit_T_189
       | _cs_decoder_bit_T_191 | _cs_decoder_bit_T_193 | _cs_decoder_bit_T_195
       | _cs_decoder_bit_T_197 | _cs_decoder_bit_T_199 | _cs_decoder_bit_T_201
       | _cs_decoder_bit_T_203 | _cs_decoder_bit_T_205 | _cs_decoder_bit_T_207
       | _cs_decoder_bit_T_209 | _cs_decoder_bit_T_211 | _cs_decoder_bit_T_213
       | _cs_decoder_bit_T_215 | _cs_decoder_bit_T_217 | _cs_decoder_bit_T_219
       | _cs_decoder_bit_T_221 | _cs_decoder_bit_T_223 | _cs_decoder_bit_T_225
       | _cs_decoder_bit_T_227 | _cs_decoder_bit_T_229 | _cs_decoder_bit_T_231
       | _cs_decoder_bit_T_233 | _cs_decoder_bit_T_235 | _cs_decoder_bit_T_237
       | _cs_decoder_bit_T_239 | _cs_decoder_bit_T_241 | _cs_decoder_bit_T_243
       | _cs_decoder_bit_T_245 | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249
       | _cs_decoder_bit_T_251 | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255
       | _cs_decoder_bit_T_257 | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261
       | _cs_decoder_bit_T_263 | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267
       | _cs_decoder_bit_T_269 | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273
       | _cs_decoder_bit_T_275 | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279
       | _cs_decoder_bit_T_281 | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285
       | _cs_decoder_bit_T_287 | _cs_decoder_bit_T_289 | _cs_decoder_bit_T_293
       | _cs_decoder_bit_T_295 | _cs_decoder_bit_T_297 | _cs_decoder_bit_T_299
       | _cs_decoder_bit_T_301 | _cs_decoder_bit_T_303 | _cs_decoder_bit_T_305
       | _cs_decoder_bit_T_307 | _cs_decoder_bit_T_309 | _cs_decoder_bit_T_311
       | _cs_decoder_bit_T_313 | _cs_decoder_bit_T_315),
     _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165 | _cs_decoder_bit_T_175
       | _cs_decoder_bit_T_177 | _cs_decoder_bit_T_183 | _cs_decoder_bit_T_185
       | _cs_decoder_bit_T_187 | _cs_decoder_bit_T_189 | _cs_decoder_bit_T_191
       | _cs_decoder_bit_T_193 | _cs_decoder_bit_T_195 | _cs_decoder_bit_T_197
       | _cs_decoder_bit_T_199 | _cs_decoder_bit_T_201 | _cs_decoder_bit_T_203
       | _cs_decoder_bit_T_205 | _cs_decoder_bit_T_207 | _cs_decoder_bit_T_209
       | _cs_decoder_bit_T_211 | _cs_decoder_bit_T_213 | _cs_decoder_bit_T_243
       | _cs_decoder_bit_T_245 | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249
       | _cs_decoder_bit_T_251 | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255
       | _cs_decoder_bit_T_257 | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261
       | _cs_decoder_bit_T_263 | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267
       | _cs_decoder_bit_T_269 | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273
       | _cs_decoder_bit_T_275 | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279
       | _cs_decoder_bit_T_281 | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285};	// Cat.scala:30:58, Decode.scala:14:121, :15:30, :40:35
  wire [2:0]  cs_imm_sel =
    {io_enq_uop_inst[4:3] == 2'h1,
     (&_GEN_17) | {io_enq_uop_inst[6], io_enq_uop_inst[4], io_enq_uop_inst[2]} == 3'h4,
     (&_GEN_17) | io_enq_uop_inst[6:4] == 3'h2};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, decode.scala:491:32, :578:32
  wire        cs_is_fence =
    {io_enq_uop_inst[13:12], io_enq_uop_inst[6], io_enq_uop_inst[4:3]} == 5'h1;	// Decode.scala:14:{65,121}
  wire        cs_is_amo = _cs_decoder_T_500 | _cs_decoder_T_383;	// Decode.scala:14:121, :15:30
  wire [1:0]  _GEN_27 = {io_enq_uop_inst[28], io_enq_uop_inst[3]};	// Decode.scala:14:65
  wire [4:0]  cs_mem_cmd =
    {io_enq_uop_inst[6],
     {io_enq_uop_inst[28:27], io_enq_uop_inst[3]} == 3'h1,
     io_enq_uop_inst[6] | (&{io_enq_uop_inst[27], io_enq_uop_inst[3]}) | (&_GEN_27)
       | (&{io_enq_uop_inst[31], io_enq_uop_inst[3]}),
     (&_GEN_27) | (&{io_enq_uop_inst[30], io_enq_uop_inst[3]}),
     _GEN_18 == 3'h2 | (&{io_enq_uop_inst[28:27], io_enq_uop_inst[5]})
       | (&{io_enq_uop_inst[29], io_enq_uop_inst[5]})};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, decode.scala:578:{32,55}
  wire [2:0]  cs_csr_cmd =
    {_cs_decoder_T_542 | (&_GEN_24) | (&_GEN_25) | _cs_decoder_T_415 | _cs_decoder_T_417,
     &_GEN_25,
     &_GEN_24};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  wire        _csr_ren_T = cs_csr_cmd == 3'h6;	// Cat.scala:30:58, package.scala:15:47
  wire        csr_en = _csr_ren_T | (&cs_csr_cmd) | cs_csr_cmd == 3'h5;	// Cat.scala:30:58, package.scala:15:47, :72:59
  wire        csr_ren = (_csr_ren_T | (&cs_csr_cmd)) & _uop_lrs1_T == 5'h0;	// Cat.scala:30:58, Decode.scala:14:121, decode.scala:490:{50,62}, :531:25, package.scala:15:47, :72:59
  wire        _GEN_28 = io_interrupt & ~io_enq_uop_is_sfb;	// decode.scala:511:{19,22}
  assign _uop_lrs1_T = io_enq_uop_inst[19:15];	// decode.scala:531:25
  assign io_deq_uop_uopc = cs_uopc;	// Cat.scala:30:58
  assign io_deq_uop_iq_type =
    {_cs_decoder_bit_T_659 | _cs_decoder_bit_T_169 | _cs_decoder_bit_T_171
       | _cs_decoder_bit_T_173 | _cs_decoder_bit_T_179 | _cs_decoder_bit_T_181
       | _cs_decoder_bit_T_183 | _cs_decoder_bit_T_185 | _cs_decoder_bit_T_187
       | _cs_decoder_bit_T_189 | _cs_decoder_bit_T_191 | _cs_decoder_bit_T_193
       | _cs_decoder_bit_T_195 | _cs_decoder_bit_T_197 | _cs_decoder_bit_T_215
       | _cs_decoder_bit_T_217 | _cs_decoder_bit_T_219 | _cs_decoder_bit_T_221
       | _cs_decoder_bit_T_223 | _cs_decoder_bit_T_225 | _cs_decoder_bit_T_227
       | _cs_decoder_bit_T_229 | _cs_decoder_bit_T_231 | _cs_decoder_bit_T_233
       | _cs_decoder_bit_T_235 | _cs_decoder_bit_T_237 | _cs_decoder_bit_T_239
       | _cs_decoder_bit_T_241 | _cs_decoder_bit_T_243 | _cs_decoder_bit_T_245
       | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249 | _cs_decoder_bit_T_251
       | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255 | _cs_decoder_bit_T_257
       | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261 | _cs_decoder_bit_T_263
       | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267 | _cs_decoder_bit_T_269
       | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273 | _cs_decoder_bit_T_275
       | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279 | _cs_decoder_bit_T_281
       | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285,
     _cs_decoder_bit_T_749 | _cs_decoder_bit_T_3 | _cs_decoder_bit_T_5
       | _cs_decoder_bit_T_7 | _cs_decoder_bit_T_9 | _cs_decoder_bit_T_11
       | _cs_decoder_bit_T_13 | _cs_decoder_bit_T_15 | _cs_decoder_bit_T_107
       | _cs_decoder_bit_T_119 | _cs_decoder_bit_T_121 | _cs_decoder_bit_T_123
       | _cs_decoder_bit_T_125 | _cs_decoder_bit_T_127 | _cs_decoder_bit_T_129
       | _cs_decoder_bit_T_131 | _cs_decoder_bit_T_133 | _cs_decoder_bit_T_135
       | _cs_decoder_bit_T_137 | _cs_decoder_bit_T_139 | _cs_decoder_bit_T_141
       | _cs_decoder_bit_T_143 | _cs_decoder_bit_T_145 | _cs_decoder_bit_T_147
       | _cs_decoder_bit_T_149 | _cs_decoder_bit_T_151 | _cs_decoder_bit_T_153
       | _cs_decoder_bit_T_155 | _cs_decoder_bit_T_157 | _cs_decoder_bit_T_159
       | _cs_decoder_bit_T_161 | _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165
       | _cs_decoder_bit_T_659 | _cs_decoder_bit_T_169 | _cs_decoder_bit_T_287
       | _cs_decoder_bit_T_289 | _cs_decoder_bit_T_291,
     ~(_cs_decoder_bit_T_749 | _cs_decoder_bit_T_3 | _cs_decoder_bit_T_5
       | _cs_decoder_bit_T_7 | _cs_decoder_bit_T_9 | _cs_decoder_bit_T_11
       | _cs_decoder_bit_T_13 | _cs_decoder_bit_T_15 | _cs_decoder_bit_T_107
       | _cs_decoder_bit_T_119 | _cs_decoder_bit_T_121 | _cs_decoder_bit_T_123
       | _cs_decoder_bit_T_125 | _cs_decoder_bit_T_127 | _cs_decoder_bit_T_129
       | _cs_decoder_bit_T_131 | _cs_decoder_bit_T_133 | _cs_decoder_bit_T_135
       | _cs_decoder_bit_T_137 | _cs_decoder_bit_T_139 | _cs_decoder_bit_T_141
       | _cs_decoder_bit_T_143 | _cs_decoder_bit_T_145 | _cs_decoder_bit_T_147
       | _cs_decoder_bit_T_149 | _cs_decoder_bit_T_151 | _cs_decoder_bit_T_153
       | _cs_decoder_bit_T_155 | _cs_decoder_bit_T_157 | _cs_decoder_bit_T_159
       | _cs_decoder_bit_T_161 | _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165
       | _cs_decoder_bit_T_659 | _cs_decoder_bit_T_169 | _cs_decoder_bit_T_171
       | _cs_decoder_bit_T_173 | _cs_decoder_bit_T_179 | _cs_decoder_bit_T_181
       | _cs_decoder_bit_T_183 | _cs_decoder_bit_T_185 | _cs_decoder_bit_T_187
       | _cs_decoder_bit_T_189 | _cs_decoder_bit_T_191 | _cs_decoder_bit_T_193
       | _cs_decoder_bit_T_195 | _cs_decoder_bit_T_197 | _cs_decoder_bit_T_215
       | _cs_decoder_bit_T_217 | _cs_decoder_bit_T_219 | _cs_decoder_bit_T_221
       | _cs_decoder_bit_T_223 | _cs_decoder_bit_T_225 | _cs_decoder_bit_T_227
       | _cs_decoder_bit_T_229 | _cs_decoder_bit_T_231 | _cs_decoder_bit_T_233
       | _cs_decoder_bit_T_235 | _cs_decoder_bit_T_237 | _cs_decoder_bit_T_239
       | _cs_decoder_bit_T_241 | _cs_decoder_bit_T_243 | _cs_decoder_bit_T_245
       | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249 | _cs_decoder_bit_T_251
       | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255 | _cs_decoder_bit_T_257
       | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261 | _cs_decoder_bit_T_263
       | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267 | _cs_decoder_bit_T_269
       | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273 | _cs_decoder_bit_T_275
       | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279 | _cs_decoder_bit_T_281
       | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285 | _cs_decoder_bit_T_287
       | _cs_decoder_bit_T_289 | _cs_decoder_bit_T_291)};	// Cat.scala:30:58, Decode.scala:14:121, :15:30, :40:35
  assign io_deq_uop_fu_code =
    {_cs_decoder_T_460 | _GEN_26 == 5'h15,
     _GEN_26 == 5'h1D,
     cs_decoder_hi_hi_lo_1,
     {io_enq_uop_inst[31], io_enq_uop_inst[28], io_enq_uop_inst[6:5]} == 4'h2
       | {io_enq_uop_inst[31], io_enq_uop_inst[27], io_enq_uop_inst[6:5]} == 4'h2
       | cs_frs3_en,
     _cs_decoder_T_542 | (&_GEN_24) | (&_GEN_25) | _cs_decoder_T_415 | _cs_decoder_T_417,
     {io_enq_uop_inst[25],
      io_enq_uop_inst[14],
      io_enq_uop_inst[6:5],
      io_enq_uop_inst[2]} == 5'h1A,
     {io_enq_uop_inst[25],
      io_enq_uop_inst[14],
      io_enq_uop_inst[6:4],
      io_enq_uop_inst[2]} == 6'h26,
     {io_enq_uop_inst[6], io_enq_uop_inst[4]} == 2'h0
       | {io_enq_uop_inst[30],
          io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[5:4],
          io_enq_uop_inst[2]} == 8'h66,
     _cs_decoder_T_397 | _cs_decoder_T_347 | (&_GEN_18),
     _cs_decoder_T_535 | _cs_decoder_T_391 | (&_GEN_11) | cs_is_br};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69
  assign io_deq_uop_is_br = cs_is_br;	// Decode.scala:14:121
  assign io_deq_uop_is_jalr = cs_uopc == 7'h26;	// Cat.scala:30:58, decode.scala:585:35
  assign io_deq_uop_is_jal = cs_uopc == 7'h25;	// Cat.scala:30:58, decode.scala:584:35
  assign io_deq_uop_imm_packed =
    {io_enq_uop_inst[31:25],
     cs_imm_sel == 3'h2 | cs_imm_sel == 3'h1
       ? io_enq_uop_inst[11:7]
       : io_enq_uop_inst[24:20],
     io_enq_uop_inst[19:12]};	// Cat.scala:30:58, decode.scala:530:25, :532:25, :578:{20,32,41,55}, :579:{29,51}
  assign io_deq_uop_exception =
    _GEN_28 | io_enq_uop_bp_debug_if | io_enq_uop_bp_xcpt_if | io_enq_uop_xcpt_pf_if
    | io_enq_uop_xcpt_ae_if
    | ~(_cs_decoder_bit_T_749 | _cs_decoder_bit_T_3 | _cs_decoder_bit_T_5
        | _cs_decoder_bit_T_7 | _cs_decoder_bit_T_9 | _cs_decoder_bit_T_11
        | _cs_decoder_bit_T_13 | _cs_decoder_bit_T_15 | _cs_decoder_bit_T_17
        | _cs_decoder_bit_T_19 | _cs_decoder_bit_T_21 | _cs_decoder_bit_T_23
        | _cs_decoder_bit_T_25 | _cs_decoder_bit_T_27 | _cs_decoder_bit_T_29
        | _cs_decoder_bit_T_31 | _cs_decoder_bit_T_33 | _cs_decoder_bit_T_35
        | _cs_decoder_bit_T_37 | _cs_decoder_bit_T_39 | _cs_decoder_bit_T_41
        | _cs_decoder_bit_T_43 | _cs_decoder_bit_T_45 | _cs_decoder_bit_T_47
        | _cs_decoder_bit_T_49 | _cs_decoder_bit_T_51 | _cs_decoder_bit_T_53
        | _cs_decoder_bit_T_55 | _cs_decoder_bit_T_57 | _cs_decoder_bit_T_59
        | _cs_decoder_bit_T_61 | _cs_decoder_bit_T_63 | _cs_decoder_bit_T_65
        | _cs_decoder_bit_T_67 | _cs_decoder_bit_T_69 | _cs_decoder_bit_T_71
        | _cs_decoder_bit_T_73 | _cs_decoder_bit_T_75 | _cs_decoder_bit_T_77
        | _cs_decoder_bit_T_79 | _cs_decoder_bit_T_81 | _GEN == 10'h63 | _GEN == 10'hE3
        | _GEN == 10'h2E3 | _GEN == 10'h3E3 | _GEN == 10'h263 | _GEN == 10'h363
        | _cs_decoder_bit_T_889 | _cs_decoder_bit_T_97 | _cs_decoder_bit_T_99
        | _cs_decoder_bit_T_101 | _cs_decoder_bit_T_103 | _cs_decoder_bit_T_105
        | _cs_decoder_bit_T_107 | _cs_decoder_bit_T_888 | _cs_decoder_bit_T_109
        | _cs_decoder_bit_T_110 | _cs_decoder_bit_T_111 | _cs_decoder_bit_T_112
        | _cs_decoder_bit_T_113 | cs_is_fencei | _cs_decoder_bit_T_117
        | _cs_decoder_bit_T_119 | _cs_decoder_bit_T_121 | _cs_decoder_bit_T_123
        | _cs_decoder_bit_T_125 | _cs_decoder_bit_T_127 | _cs_decoder_bit_T_129
        | _cs_decoder_bit_T_131 | _cs_decoder_bit_T_133 | _cs_decoder_bit_T_135
        | _cs_decoder_bit_T_137 | _cs_decoder_bit_T_139 | _cs_decoder_bit_T_141
        | _cs_decoder_bit_T_143 | _cs_decoder_bit_T_145 | _cs_decoder_bit_T_147
        | _cs_decoder_bit_T_149 | _cs_decoder_bit_T_151 | _cs_decoder_bit_T_153
        | _cs_decoder_bit_T_155 | _cs_decoder_bit_T_157 | _cs_decoder_bit_T_159
        | _cs_decoder_bit_T_161 | _cs_decoder_bit_T_708 | _cs_decoder_bit_T_165
        | _cs_decoder_bit_T_659 | _cs_decoder_bit_T_169 | _cs_decoder_bit_T_171
        | _cs_decoder_bit_T_173 | _cs_decoder_bit_T_175 | _cs_decoder_bit_T_177
        | _cs_decoder_bit_T_179 | _cs_decoder_bit_T_181 | _cs_decoder_bit_T_183
        | _cs_decoder_bit_T_185 | _cs_decoder_bit_T_187 | _cs_decoder_bit_T_189
        | _cs_decoder_bit_T_191 | _cs_decoder_bit_T_193 | _cs_decoder_bit_T_195
        | _cs_decoder_bit_T_197 | _cs_decoder_bit_T_199 | _cs_decoder_bit_T_201
        | _cs_decoder_bit_T_203 | _cs_decoder_bit_T_205 | _cs_decoder_bit_T_207
        | _cs_decoder_bit_T_209 | _cs_decoder_bit_T_211 | _cs_decoder_bit_T_213
        | _cs_decoder_bit_T_215 | _cs_decoder_bit_T_217 | _cs_decoder_bit_T_219
        | _cs_decoder_bit_T_221 | _cs_decoder_bit_T_223 | _cs_decoder_bit_T_225
        | _cs_decoder_bit_T_227 | _cs_decoder_bit_T_229 | _cs_decoder_bit_T_231
        | _cs_decoder_bit_T_233 | _cs_decoder_bit_T_235 | _cs_decoder_bit_T_237
        | _cs_decoder_bit_T_239 | _cs_decoder_bit_T_241 | _cs_decoder_bit_T_243
        | _cs_decoder_bit_T_245 | _cs_decoder_bit_T_247 | _cs_decoder_bit_T_249
        | _cs_decoder_bit_T_251 | _cs_decoder_bit_T_253 | _cs_decoder_bit_T_255
        | _cs_decoder_bit_T_257 | _cs_decoder_bit_T_259 | _cs_decoder_bit_T_261
        | _cs_decoder_bit_T_263 | _cs_decoder_bit_T_265 | _cs_decoder_bit_T_267
        | _cs_decoder_bit_T_269 | _cs_decoder_bit_T_271 | _cs_decoder_bit_T_273
        | _cs_decoder_bit_T_275 | _cs_decoder_bit_T_277 | _cs_decoder_bit_T_279
        | _cs_decoder_bit_T_281 | _cs_decoder_bit_T_283 | _cs_decoder_bit_T_285
        | _cs_decoder_bit_T_287 | _cs_decoder_bit_T_289 | _cs_decoder_bit_T_291
        | _cs_decoder_bit_T_293 | _cs_decoder_bit_T_295 | _cs_decoder_bit_T_297
        | _cs_decoder_bit_T_299 | _cs_decoder_bit_T_301 | _cs_decoder_bit_T_303
        | _cs_decoder_bit_T_305 | _cs_decoder_bit_T_307 | _cs_decoder_bit_T_309
        | _cs_decoder_bit_T_311 | _cs_decoder_bit_T_313 | _cs_decoder_bit_T_315)
    | cs_fp_val & io_csr_decode_fp_illegal | cs_is_amo & ~(io_status_isa[0]) | cs_fp_val
    & ~cs_fp_single & ~(io_status_isa[3]) | csr_en
    & (io_csr_decode_read_illegal | ~csr_ren & io_csr_decode_write_illegal)
    | (cs_uopc == 7'h6B | cs_csr_cmd == 3'h4) & io_csr_decode_system_illegal;	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, decode.scala:490:50, :491:32, :492:24, :497:25, :498:15, :500:{15,18,32}, :501:{19,34,37,51}, :502:{12,43,46,55}, :503:{14,30}, :508:26, :511:19, package.scala:72:59
  assign io_deq_uop_exc_cause =
    _GEN_28
      ? io_interrupt_cause
      : {60'h0,
         io_enq_uop_bp_debug_if
           ? 4'hE
           : io_enq_uop_bp_xcpt_if
               ? 4'h3
               : io_enq_uop_xcpt_pf_if
                   ? 4'hC
                   : {2'h0, io_enq_uop_xcpt_ae_if ? 2'h1 : 2'h2}};	// Mux.scala:47:69, decode.scala:511:19
  assign io_deq_uop_bypassable = _cs_decoder_T_535 | _cs_decoder_T_391 | (&_GEN_11);	// Decode.scala:14:{65,121}, :15:30
  assign io_deq_uop_mem_cmd = cs_mem_cmd;	// Cat.scala:30:58
  assign io_deq_uop_mem_size =
    cs_mem_cmd == 5'h14 | cs_mem_cmd == 5'h5
      ? {|(io_enq_uop_inst[24:20]), |_uop_lrs1_T}
      : io_enq_uop_inst[13:12];	// Cat.scala:30:58, decode.scala:531:25, :532:25, :561:{24,81,99,113}, package.scala:15:47, :72:59
  assign io_deq_uop_mem_signed = ~(io_enq_uop_inst[14]);	// decode.scala:562:{21,26}
  assign io_deq_uop_is_fence = cs_is_fence;	// Decode.scala:14:121
  assign io_deq_uop_is_fencei = cs_is_fencei;	// Decode.scala:14:121
  assign io_deq_uop_is_amo = cs_is_amo;	// Decode.scala:15:30
  assign io_deq_uop_uses_ldq =
    io_enq_uop_inst[6:3] == 4'h0
    | {io_enq_uop_inst[28:27],
       io_enq_uop_inst[13],
       io_enq_uop_inst[6],
       io_enq_uop_inst[3]} == 5'h15;	// Decode.scala:14:{65,121}, :15:30
  assign io_deq_uop_uses_stq =
    cs_is_fence | _cs_decoder_T_94 | _cs_decoder_T_96 | _cs_decoder_T_124;	// Decode.scala:14:121, :15:30
  assign io_deq_uop_is_sys_pc2epc = _cs_decoder_bit_T_888 | _cs_decoder_bit_T_109;	// Decode.scala:14:121, :15:30
  assign io_deq_uop_is_unique =
    _cs_decoder_bit_T_889 | _cs_decoder_bit_T_97 | _cs_decoder_bit_T_99
    | _cs_decoder_bit_T_101 | _cs_decoder_bit_T_103 | _cs_decoder_bit_T_105
    | _cs_decoder_bit_T_107 | _cs_decoder_bit_T_888 | _cs_decoder_bit_T_109
    | _cs_decoder_bit_T_110 | _cs_decoder_bit_T_111 | _cs_decoder_bit_T_112
    | _cs_decoder_bit_T_113 | cs_is_fencei | _cs_decoder_bit_T_117 | _cs_decoder_bit_T_119
    | _cs_decoder_bit_T_121 | _cs_decoder_bit_T_123 | _cs_decoder_bit_T_125
    | _cs_decoder_bit_T_127 | _cs_decoder_bit_T_129 | _cs_decoder_bit_T_131
    | _cs_decoder_bit_T_133 | _cs_decoder_bit_T_135 | _cs_decoder_bit_T_137
    | _cs_decoder_bit_T_139 | _cs_decoder_bit_T_141 | _cs_decoder_bit_T_143
    | _cs_decoder_bit_T_145 | _cs_decoder_bit_T_147 | _cs_decoder_bit_T_149
    | _cs_decoder_bit_T_151 | _cs_decoder_bit_T_153 | _cs_decoder_bit_T_155
    | _cs_decoder_bit_T_157 | _cs_decoder_bit_T_159 | _cs_decoder_bit_T_161;	// Decode.scala:14:121, :15:30
  assign io_deq_uop_flush_on_commit =
    {io_enq_uop_inst[6], io_enq_uop_inst[4:3]} == 3'h1 | (&(io_enq_uop_inst[6:4]))
    | csr_en & ~csr_ren & io_csr_decode_write_flush;	// Decode.scala:14:{65,121}, decode.scala:490:50, :502:46, :570:{45,68}, :578:55, package.scala:72:59
  assign io_deq_uop_ldst = {1'h0, io_enq_uop_inst[11:7]};	// decode.scala:530:{18,25}
  assign io_deq_uop_lrs1 = {1'h0, _uop_lrs1_T};	// decode.scala:530:18, :531:{18,25}
  assign io_deq_uop_lrs2 = {1'h0, io_enq_uop_inst[24:20]};	// decode.scala:530:18, :532:{18,25}
  assign io_deq_uop_lrs3 = {1'h0, io_enq_uop_inst[31:27]};	// decode.scala:530:18, :533:{18,25}
  assign io_deq_uop_ldst_val =
    cs_dst_type != 2'h2 & ~(io_enq_uop_inst[11:7] == 5'h0 & cs_dst_type == 2'h0);	// Cat.scala:30:58, Decode.scala:14:121, Mux.scala:47:69, decode.scala:530:25, :535:{33,42,45,56,64,81}
  assign io_deq_uop_dst_rtype = cs_dst_type;	// Cat.scala:30:58
  assign io_deq_uop_lrs1_rtype =
    {{io_enq_uop_inst[13], io_enq_uop_inst[6], io_enq_uop_inst[4:3]} == 4'h1 | (&_GEN_17)
       | (&_GEN_18)
       | {io_enq_uop_inst[28], io_enq_uop_inst[13:12], io_enq_uop_inst[6:4]} == 6'h7
       | (&_GEN_23)
       | {io_enq_uop_inst[28],
          io_enq_uop_inst[25],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[5:4]} == 6'h23
       | {io_enq_uop_inst[31:29],
          io_enq_uop_inst[13:12],
          io_enq_uop_inst[6],
          io_enq_uop_inst[4]} == 7'h33,
     {io_enq_uop_inst[31], io_enq_uop_inst[6:5]} == 3'h2
       | {io_enq_uop_inst[28], io_enq_uop_inst[6:5]} == 3'h2 | cs_frs3_en | (&_GEN_23)};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, decode.scala:578:32
  assign io_deq_uop_lrs2_rtype =
    {io_enq_uop_inst[6:5] == 2'h0 | (&_GEN_17) | _cs_decoder_T_167 | (&_GEN_18)
       | _cs_decoder_T_542 | (&_GEN_24) | (&_GEN_25)
       | {io_enq_uop_inst[28:27], io_enq_uop_inst[6], io_enq_uop_inst[3]} == 4'h9
       | {io_enq_uop_inst[28], io_enq_uop_inst[25], io_enq_uop_inst[5:4]} == 4'hB
       | {io_enq_uop_inst[30], io_enq_uop_inst[5:4]} == 3'h5
       | (&{io_enq_uop_inst[30:29], io_enq_uop_inst[4]}),
     _cs_decoder_T_460 | {io_enq_uop_inst[30], io_enq_uop_inst[6:5]} == 3'h2
       | cs_frs3_en};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, decode.scala:578:32, package.scala:15:47
  assign io_deq_uop_frs3_en = cs_frs3_en;	// Decode.scala:14:121
  assign io_deq_uop_fp_val = cs_fp_val;	// Decode.scala:15:30
  assign io_deq_uop_fp_single = cs_fp_single;	// Decode.scala:15:30
  assign io_csr_decode_csr = io_enq_uop_inst[31:20];	// decode.scala:488:28
endmodule

