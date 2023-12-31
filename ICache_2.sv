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

module ICache_2(
  input         clock,
                reset,
                auto_master_out_a_ready,
                auto_master_out_d_valid,
  input  [2:0]  auto_master_out_d_bits_opcode,
  input  [3:0]  auto_master_out_d_bits_size,
  input  [63:0] auto_master_out_d_bits_data,
  input         auto_master_out_d_bits_corrupt,
                io_req_valid,
  input  [32:0] io_req_bits_addr,
  input  [31:0] io_s1_paddr,
  input         io_s1_kill,
                io_s2_kill,
                io_invalidate,
  output        auto_master_out_a_valid,
  output [31:0] auto_master_out_a_bits_address,
  output        io_resp_valid,
  output [31:0] io_resp_bits_data,
  output        io_resp_bits_replay,
                io_resp_bits_ae
);

  wire        readEnable;	// ICache.scala:295:46
  wire        writeEnable;	// ICache.scala:285:32
  wire        readEnable_0;	// ICache.scala:295:46
  wire        writeEnable_0;	// ICache.scala:285:32
  wire        readEnable_1;	// ICache.scala:218:83
  wire [5:0]  _tag_rdata_T_4;	// ICache.scala:218:42
  wire        _io_req_ready_T_2;	// ICache.scala:191:19
  wire [31:0] _data_arrays_1_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [31:0] _data_arrays_0_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [20:0] _tag_array_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire        s0_valid = _io_req_ready_T_2 & io_req_valid;	// Decoupled.scala:40:37, ICache.scala:191:19
  reg         s1_valid;	// ICache.scala:169:21
  reg         s2_valid;	// ICache.scala:174:25
  reg         s2_hit;	// ICache.scala:175:23
  reg         invalidated;	// ICache.scala:177:24
  reg         refill_valid;	// ICache.scala:178:29
  wire        s2_miss = s2_valid & ~s2_hit & ~io_s2_kill;	// ICache.scala:174:25, :175:23, :182:{29,37,40}
  reg         s2_request_refill_REG;	// ICache.scala:184:45
  wire        tl_out_a_valid = s2_miss & s2_request_refill_REG;	// ICache.scala:182:37, :184:{35,45}
  reg  [31:0] refill_paddr;	// Reg.scala:15:16
  wire        refill_one_beat =
    auto_master_out_d_valid & auto_master_out_d_bits_opcode[0];	// Edges.scala:105:36, ICache.scala:189:41
  assign _io_req_ready_T_2 = ~refill_one_beat;	// ICache.scala:189:41, :191:19
  wire [26:0] _beats1_decode_T_1 = 27'hFFF << auto_master_out_d_bits_size;	// package.scala:234:77
  wire [8:0]  beats1 =
    auto_master_out_d_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0;	// Edges.scala:105:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [8:0]  counter;	// Edges.scala:228:27
  wire [8:0]  _counter1_T = counter - 9'h1;	// Edges.scala:228:27, :229:28
  wire [8:0]  refill_cnt = beats1 & ~_counter1_T;	// Edges.scala:220:14, :229:28, :233:{25,27}
  wire        writeEnable_1 =
    refill_one_beat & (counter == 9'h1 | beats1 == 9'h0) & auto_master_out_d_valid;	// Edges.scala:220:14, :228:27, :231:{25,37,47}, ICache.scala:189:41, :195:37
  assign _tag_rdata_T_4 = io_req_bits_addr[11:6];	// ICache.scala:218:42
  assign readEnable_1 = ~writeEnable_1 & s0_valid;	// Decoupled.scala:40:37, ICache.scala:195:37, :218:{70,83}
  reg         accruedRefillError;	// ICache.scala:219:31
  wire        refillError =
    auto_master_out_d_bits_corrupt | (|refill_cnt) & accruedRefillError;	// Edges.scala:233:25, ICache.scala:219:31, :220:{43,58,62}
  reg  [63:0] vb_array;	// ICache.scala:231:21
  assign writeEnable_0 = refill_one_beat & ~invalidated;	// ICache.scala:177:24, :189:41, :285:{32,35}
  wire [8:0]  _mem_idx_T_6 = {refill_paddr[11:6], 3'h0};	// ICache.scala:286:52, :483:21, Reg.scala:15:16
  assign readEnable_0 = ~writeEnable_0 & s0_valid & ~(io_req_bits_addr[2]);	// Decoupled.scala:40:37, ICache.scala:282:111, :285:32, :295:{41,46}, package.scala:154:13
  assign writeEnable = refill_one_beat & ~invalidated;	// ICache.scala:177:24, :189:41, :285:{32,35}
  assign readEnable = ~writeEnable_0 & s0_valid & io_req_bits_addr[2];	// Decoupled.scala:40:37, ICache.scala:285:32, :295:{41,46}, package.scala:154:13
  reg  [31:0] s2_dout_0;	// Reg.scala:15:16
  reg         s2_disparity;	// Reg.scala:15:16
  reg         s2_tl_error;	// Reg.scala:15:16
  wire        invalidate = s2_valid & s2_disparity | io_invalidate;	// ICache.scala:174:25, :331:{22,39,52}, Reg.scala:15:16
  always @(posedge clock) begin
    automatic logic        _s1_can_request_refill_T;	// ICache.scala:183:41
    automatic logic [63:0] _s1_vb_T_1;	// ICache.scala:259:25
    automatic logic        s1_tag_hit_0;	// ICache.scala:262:26
    _s1_can_request_refill_T = s2_miss | refill_valid;	// ICache.scala:178:29, :182:37, :183:41
    _s1_vb_T_1 = vb_array >> io_s1_paddr[11:6];	// ICache.scala:231:21, :259:25, :483:21
    s1_tag_hit_0 = _s1_vb_T_1[0] & _tag_array_0_ext_RW0_rdata[19:0] == io_s1_paddr[31:12];	// DescribedSRAM.scala:19:26, ICache.scala:254:30, :259:25, :262:{26,33}, package.scala:154:13
    if (reset) begin
      s1_valid <= 1'h0;	// ICache.scala:150:29, :169:21
      s2_valid <= 1'h0;	// ICache.scala:150:29, :174:25
      refill_valid <= 1'h0;	// ICache.scala:150:29, :178:29
      counter <= 9'h0;	// Edges.scala:228:27
      vb_array <= 64'h0;	// ICache.scala:231:21
    end
    else begin
      s1_valid <= s0_valid;	// Decoupled.scala:40:37, ICache.scala:169:21
      s2_valid <= s1_valid & ~io_s1_kill;	// ICache.scala:169:21, :174:{25,35,38}
      refill_valid <=
        ~writeEnable_1 & (auto_master_out_a_ready & tl_out_a_valid | refill_valid);	// Decoupled.scala:40:37, ICache.scala:178:29, :184:35, :195:37, :474:{22,37}, :475:{22,37}
      if (auto_master_out_d_valid) begin
        if (counter == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (auto_master_out_d_bits_opcode[0])	// Edges.scala:105:36
            counter <= ~(_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:105:36
            counter <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          counter <= _counter1_T;	// Edges.scala:228:27, :229:28
      end
      if (invalidate)	// ICache.scala:331:{39,52}
        vb_array <= 64'h0;	// ICache.scala:231:21
      else if (refill_one_beat) begin	// ICache.scala:189:41
        automatic logic [127:0] _vb_array_T_3;	// ICache.scala:235:32
        _vb_array_T_3 = 128'h1 << refill_paddr[11:6];	// ICache.scala:235:32, :483:21, Reg.scala:15:16
        vb_array <=
          writeEnable_1 & ~invalidated
            ? vb_array | _vb_array_T_3[63:0]
            : ~(~vb_array | _vb_array_T_3[63:0]);	// ICache.scala:177:24, :195:37, :231:21, :235:{32,72,75}
      end
    end
    s2_hit <= s1_tag_hit_0;	// ICache.scala:175:23, :262:26
    invalidated <= refill_valid & (invalidate | invalidated);	// ICache.scala:177:24, :178:29, :238:21, :240:17, :331:{39,52}, :473:{24,38}
    s2_request_refill_REG <= ~_s1_can_request_refill_T;	// ICache.scala:183:{31,41}, :184:45
    if (s1_valid & ~_s1_can_request_refill_T)	// ICache.scala:169:21, :183:{31,41}, :185:54
      refill_paddr <= io_s1_paddr;	// Reg.scala:15:16
    if (refill_one_beat)	// ICache.scala:189:41
      accruedRefillError <= refillError;	// ICache.scala:219:31, :220:43
    if (s1_valid) begin	// ICache.scala:169:21
      if (io_s1_paddr[2])	// package.scala:154:13
        s2_dout_0 <= _data_arrays_1_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, Reg.scala:15:16
      else	// package.scala:154:13
        s2_dout_0 <= _data_arrays_0_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, Reg.scala:15:16
      s2_tl_error <= s1_tag_hit_0 & _tag_array_0_ext_RW0_rdata[20];	// DescribedSRAM.scala:19:26, ICache.scala:262:26, :264:32, Reg.scala:15:16, package.scala:154:13
    end
    s2_disparity <= ~s1_valid & s2_disparity;	// ICache.scala:169:21, Reg.scala:15:16, :16:{19,23}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:8];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h9; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_valid = _RANDOM[4'h0][4];	// ICache.scala:169:21
        s2_valid = _RANDOM[4'h1][6];	// ICache.scala:174:25
        s2_hit = _RANDOM[4'h1][7];	// ICache.scala:174:25, :175:23
        invalidated = _RANDOM[4'h1][8];	// ICache.scala:174:25, :177:24
        refill_valid = _RANDOM[4'h1][9];	// ICache.scala:174:25, :178:29
        s2_request_refill_REG = _RANDOM[4'h1][12];	// ICache.scala:174:25, :184:45
        refill_paddr = {_RANDOM[4'h1][31:13], _RANDOM[4'h2][12:0]};	// ICache.scala:174:25, Reg.scala:15:16
        counter = _RANDOM[4'h3][22:14];	// Edges.scala:228:27
        accruedRefillError = _RANDOM[4'h3][23];	// Edges.scala:228:27, ICache.scala:219:31
        vb_array = {_RANDOM[4'h3][31:24], _RANDOM[4'h4], _RANDOM[4'h5][23:0]};	// Edges.scala:228:27, ICache.scala:231:21
        s2_dout_0 = {_RANDOM[4'h7][31:5], _RANDOM[4'h8][4:0]};	// Reg.scala:15:16
        s2_disparity = _RANDOM[4'h8][5];	// Reg.scala:15:16
        s2_tl_error = _RANDOM[4'h8][6];	// Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  tag_array_0_64x21 tag_array_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (writeEnable_1 ? refill_paddr[11:6] : _tag_rdata_T_4),	// DescribedSRAM.scala:19:26, ICache.scala:195:37, :218:42, :483:21, Reg.scala:15:16
    .RW0_en    (readEnable_1 | writeEnable_1),	// DescribedSRAM.scala:19:26, ICache.scala:195:37, :218:83
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_1),	// ICache.scala:195:37
    .RW0_wdata ({refillError, refill_paddr[31:12]}),	// Cat.scala:30:58, ICache.scala:187:33, :220:43, Reg.scala:15:16
    .RW0_rdata (_tag_array_0_ext_RW0_rdata)
  );
  data_arrays_512x32 data_arrays_0_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_6 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, ICache.scala:189:41, :283:31, :286:{22,52,79}
    .RW0_en    (readEnable_0 | writeEnable_0),	// DescribedSRAM.scala:19:26, ICache.scala:285:32, :295:46
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_0),	// ICache.scala:285:32
    .RW0_wdata (auto_master_out_d_bits_data[31:0]),	// ICache.scala:291:71
    .RW0_rdata (_data_arrays_0_0_ext_RW0_rdata)
  );
  data_arrays_512x32 data_arrays_1_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_6 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, ICache.scala:189:41, :283:31, :286:{22,52,79}
    .RW0_en    (readEnable | writeEnable),	// DescribedSRAM.scala:19:26, ICache.scala:285:32, :295:46
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_0),	// ICache.scala:285:32
    .RW0_wdata (auto_master_out_d_bits_data[63:32]),	// ICache.scala:291:71
    .RW0_rdata (_data_arrays_1_0_ext_RW0_rdata)
  );
  assign auto_master_out_a_valid = tl_out_a_valid;	// ICache.scala:184:35
  assign auto_master_out_a_bits_address = {refill_paddr[31:6], 6'h0};	// ICache.scala:229:40, :418:64, Reg.scala:15:16
  assign io_resp_valid = s2_valid & s2_hit;	// ICache.scala:174:25, :175:23, :336:33
  assign io_resp_bits_data = s2_dout_0;	// Reg.scala:15:16
  assign io_resp_bits_replay = s2_disparity;	// Reg.scala:15:16
  assign io_resp_bits_ae = s2_tl_error;	// Reg.scala:15:16
endmodule

