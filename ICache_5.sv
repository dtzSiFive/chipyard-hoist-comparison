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

module ICache_5(
  input         clock,
                reset,
                auto_master_out_a_ready,
                auto_master_out_d_valid,
  input  [2:0]  auto_master_out_d_bits_opcode,
  input  [3:0]  auto_master_out_d_bits_size,
  input  [63:0] auto_master_out_d_bits_data,
  input         io_req_valid,
  input  [38:0] io_req_bits_addr,
  input  [31:0] io_s1_paddr,
  input         io_s1_kill,
                io_s2_kill,
                io_invalidate,
  output        auto_master_out_a_valid,
  output [31:0] auto_master_out_a_bits_address,
  output        io_resp_valid,
  output [63:0] io_resp_bits_data,
  output        io_perf_acquire
);

  wire         tl_out_a_valid;	// icache.scala:351:46
  wire         readEnable;	// icache.scala:258:60
  wire         writeEnable;	// icache.scala:248:51
  wire         readEnable_0;	// icache.scala:258:60
  wire         writeEnable_0;	// icache.scala:248:51
  wire         readEnable_1;	// icache.scala:258:60
  wire         writeEnable_1;	// icache.scala:248:51
  wire         readEnable_2;	// icache.scala:258:60
  wire         writeEnable_2;	// icache.scala:248:51
  wire         tag_array_MPORT_mask_3;	// icache.scala:183:100
  wire         tag_array_MPORT_mask_2;	// icache.scala:183:100
  wire         tag_array_MPORT_mask_1;	// icache.scala:183:100
  wire         tag_array_MPORT_mask_0;	// icache.scala:183:100
  wire         tag_array_tag_rdata_en;	// icache.scala:181:84
  wire [5:0]   _tag_rdata_T_4;	// icache.scala:181:42
  wire         _io_req_ready_T;	// icache.scala:171:19
  wire [63:0]  _dataArrayWay_3_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [63:0]  _dataArrayWay_2_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [63:0]  _dataArrayWay_1_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [63:0]  _dataArrayWay_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire [79:0]  _tag_array_ext_RW0_rdata;	// icache.scala:180:30
  wire         _repl_way_prng_io_out_0;	// PRNG.scala:82:22
  wire         _repl_way_prng_io_out_1;	// PRNG.scala:82:22
  wire         s0_valid = _io_req_ready_T & io_req_valid;	// Decoupled.scala:40:37, icache.scala:171:19
  reg          s1_valid;	// icache.scala:155:25
  reg          s2_valid;	// icache.scala:158:25
  reg          s2_hit;	// icache.scala:159:23
  reg          invalidated;	// icache.scala:162:24
  reg          refill_valid;	// icache.scala:163:29
  wire         refill_fire = auto_master_out_a_ready & tl_out_a_valid;	// Decoupled.scala:40:37, icache.scala:351:46
  reg          s2_miss_REG;	// icache.scala:165:48
  wire         s2_miss = s2_valid & ~s2_hit & ~s2_miss_REG;	// icache.scala:158:25, :159:23, :165:{29,37,40,48}
  reg  [31:0]  refill_paddr;	// Reg.scala:15:16
  wire         refill_one_beat =
    auto_master_out_d_valid & auto_master_out_d_bits_opcode[0];	// Edges.scala:105:36, icache.scala:169:41
  assign _io_req_ready_T = ~refill_one_beat;	// icache.scala:169:41, :171:19
  wire [26:0]  _beats1_decode_T_1 = 27'hFFF << auto_master_out_d_bits_size;	// package.scala:234:77
  wire [8:0]   beats1 =
    auto_master_out_d_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0;	// Edges.scala:105:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [8:0]   counter;	// Edges.scala:228:27
  wire [8:0]   _counter1_T = counter - 9'h1;	// Edges.scala:228:27, :229:28
  wire [8:0]   refill_cnt = beats1 & ~_counter1_T;	// Edges.scala:220:14, :229:28, :233:{25,27}
  wire         tag_array_MPORT_en =
    refill_one_beat & (counter == 9'h1 | beats1 == 9'h0) & auto_master_out_d_valid;	// Edges.scala:220:14, :228:27, :231:{25,37,47}, icache.scala:169:41, :174:37
  wire [1:0]   repl_way = {_repl_way_prng_io_out_1, _repl_way_prng_io_out_0};	// PRNG.scala:82:22, icache.scala:178:58
  assign _tag_rdata_T_4 = io_req_bits_addr[11:6];	// icache.scala:181:42
  assign tag_array_tag_rdata_en = ~tag_array_MPORT_en & s0_valid;	// Decoupled.scala:40:37, icache.scala:174:37, :181:{71,84}
  assign tag_array_MPORT_mask_0 = ~(|repl_way);	// icache.scala:178:58, :183:100
  assign tag_array_MPORT_mask_1 = repl_way == 2'h1;	// icache.scala:178:58, :183:100
  assign tag_array_MPORT_mask_2 = repl_way == 2'h2;	// icache.scala:178:58, :183:100
  assign tag_array_MPORT_mask_3 = &repl_way;	// icache.scala:178:58, :183:100
  reg  [255:0] vb_array;	// icache.scala:186:25
  wire [255:0] _s1_vb_T_1 = vb_array >> io_s1_paddr[11:6];	// icache.scala:186:25, :200:29, :202:25
  wire         s1_tag_hit_0 =
    _s1_vb_T_1[0] & _tag_array_ext_RW0_rdata[19:0] == io_s1_paddr[31:12];	// icache.scala:180:30, :201:29, :202:25, :204:{28,35}
  wire [255:0] _s1_vb_T_3 = vb_array >> {250'h1, io_s1_paddr[11:6]};	// icache.scala:186:25, :200:29, :202:25
  wire         s1_tag_hit_1 =
    _s1_vb_T_3[0] & _tag_array_ext_RW0_rdata[39:20] == io_s1_paddr[31:12];	// icache.scala:180:30, :201:29, :202:25, :204:{28,35}
  wire [255:0] _s1_vb_T_5 = vb_array >> {250'h2, io_s1_paddr[11:6]};	// icache.scala:186:25, :200:29, :202:25
  wire         s1_tag_hit_2 =
    _s1_vb_T_5[0] & _tag_array_ext_RW0_rdata[59:40] == io_s1_paddr[31:12];	// icache.scala:180:30, :201:29, :202:25, :204:{28,35}
  wire [255:0] _s1_vb_T_7 = vb_array >> {250'h3, io_s1_paddr[11:6]};	// icache.scala:186:25, :200:29, :202:25
  wire         s1_tag_hit_3 =
    _s1_vb_T_7[0] & _tag_array_ext_RW0_rdata[79:60] == io_s1_paddr[31:12];	// icache.scala:180:30, :201:29, :202:25, :204:{28,35}
  `ifndef SYNTHESIS	// icache.scala:206:9
    always @(posedge clock) begin	// icache.scala:206:9
      if (~({1'h0, {1'h0, s1_tag_hit_0} + {1'h0, s1_tag_hit_1}}
            + {1'h0, {1'h0, s1_tag_hit_2} + {1'h0, s1_tag_hit_3}} < 3'h2 | ~s1_valid
            | reset)) begin	// Bitwise.scala:47:55, icache.scala:155:25, :204:28, :206:{9,31,41}
        if (`ASSERT_VERBOSE_COND_)	// icache.scala:206:9
          $error("Assertion failed\n    at icache.scala:206 assert(PopCount(s1_tag_hit) <= 1.U || !s1_valid)\n");	// icache.scala:206:9
        if (`STOP_COND_)	// icache.scala:206:9
          $fatal;	// icache.scala:206:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign writeEnable_2 = refill_one_beat & ~invalidated & ~(|repl_way);	// icache.scala:162:24, :169:41, :178:58, :183:100, :248:{37,51,63}
  wire [8:0]   _mem_idx_T_9 = {refill_paddr[11:6], 3'h0};	// Reg.scala:15:16, icache.scala:168:32, :250:54
  assign readEnable_2 = ~writeEnable_2 & s0_valid;	// Decoupled.scala:40:37, icache.scala:248:51, :258:{55,60}
  reg  [63:0]  s2_dout_0_REG;	// icache.scala:258:30
  assign writeEnable_1 = refill_one_beat & ~invalidated & repl_way == 2'h1;	// icache.scala:162:24, :169:41, :178:58, :183:100, :248:{37,51,63}
  assign readEnable_1 = ~writeEnable_1 & s0_valid;	// Decoupled.scala:40:37, icache.scala:248:51, :258:{55,60}
  reg  [63:0]  s2_dout_1_REG;	// icache.scala:258:30
  assign writeEnable_0 = refill_one_beat & ~invalidated & repl_way == 2'h2;	// icache.scala:162:24, :169:41, :178:58, :183:100, :248:{37,51,63}
  assign readEnable_0 = ~writeEnable_0 & s0_valid;	// Decoupled.scala:40:37, icache.scala:248:51, :258:{55,60}
  reg  [63:0]  s2_dout_2_REG;	// icache.scala:258:30
  assign writeEnable = refill_one_beat & ~invalidated & (&repl_way);	// icache.scala:162:24, :169:41, :178:58, :248:{37,51,63}
  assign readEnable = ~writeEnable & s0_valid;	// Decoupled.scala:40:37, icache.scala:248:51, :258:{55,60}
  reg  [63:0]  s2_dout_3_REG;	// icache.scala:258:30
  reg          s2_tag_hit_0;	// icache.scala:329:27
  reg          s2_tag_hit_1;	// icache.scala:329:27
  reg          s2_tag_hit_2;	// icache.scala:329:27
  reg          s2_tag_hit_3;	// icache.scala:329:27
  assign tl_out_a_valid = s2_miss & ~refill_valid & ~io_s2_kill;	// icache.scala:163:29, :165:37, :351:{32,46,49}
  always @(posedge clock) begin
    s1_valid <= s0_valid;	// Decoupled.scala:40:37, icache.scala:155:25
    s2_valid <= s1_valid & ~io_s1_kill;	// icache.scala:155:25, :158:{25,35,38}
    s2_hit <= s1_tag_hit_0 | s1_tag_hit_1 | s1_tag_hit_2 | s1_tag_hit_3;	// icache.scala:157:35, :159:23, :204:28
    invalidated <= refill_valid & (io_invalidate | invalidated);	// icache.scala:162:24, :163:29, :191:24, :193:17, :362:{24,38}
    s2_miss_REG <= refill_valid;	// icache.scala:163:29, :165:48
    if (s1_valid & ~(refill_valid | s2_miss))	// icache.scala:155:25, :163:29, :165:37, :166:{54,57,72}
      refill_paddr <= io_s1_paddr;	// Reg.scala:15:16
    s2_dout_0_REG <= _dataArrayWay_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, icache.scala:258:30
    s2_dout_1_REG <= _dataArrayWay_1_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, icache.scala:258:30
    s2_dout_2_REG <= _dataArrayWay_2_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, icache.scala:258:30
    s2_dout_3_REG <= _dataArrayWay_3_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, icache.scala:258:30
    s2_tag_hit_0 <= s1_tag_hit_0;	// icache.scala:204:28, :329:27
    s2_tag_hit_1 <= s1_tag_hit_1;	// icache.scala:204:28, :329:27
    s2_tag_hit_2 <= s1_tag_hit_2;	// icache.scala:204:28, :329:27
    s2_tag_hit_3 <= s1_tag_hit_3;	// icache.scala:204:28, :329:27
    if (reset) begin
      refill_valid <= 1'h0;	// icache.scala:163:29
      counter <= 9'h0;	// Edges.scala:228:27
      vb_array <= 256'h0;	// icache.scala:186:25
    end
    else begin
      refill_valid <= ~tag_array_MPORT_en & (refill_fire | refill_valid);	// Decoupled.scala:40:37, icache.scala:163:29, :174:37, :363:{22,37}, :364:{22,37}
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
      if (io_invalidate)
        vb_array <= 256'h0;	// icache.scala:186:25
      else if (refill_one_beat) begin	// icache.scala:169:41
        automatic logic [255:0] _vb_array_T_3;	// icache.scala:188:32
        _vb_array_T_3 =
          256'h1
          << {248'h0,
              _repl_way_prng_io_out_1,
              _repl_way_prng_io_out_0,
              refill_paddr[11:6]};	// PRNG.scala:82:22, Reg.scala:15:16, icache.scala:168:32, :188:32
        if (tag_array_MPORT_en & ~invalidated)	// icache.scala:162:24, :174:37, :188:{72,75}
          vb_array <= vb_array | _vb_array_T_3;	// icache.scala:186:25, :188:32
        else	// icache.scala:188:72
          vb_array <= ~(~vb_array | _vb_array_T_3);	// icache.scala:186:25, :188:32
      end
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
        s1_valid = _RANDOM[5'h0][0];	// icache.scala:155:25
        s2_valid = _RANDOM[5'h0][1];	// icache.scala:155:25, :158:25
        s2_hit = _RANDOM[5'h0][2];	// icache.scala:155:25, :159:23
        invalidated = _RANDOM[5'h0][3];	// icache.scala:155:25, :162:24
        refill_valid = _RANDOM[5'h0][4];	// icache.scala:155:25, :163:29
        s2_miss_REG = _RANDOM[5'h0][5];	// icache.scala:155:25, :165:48
        refill_paddr = {_RANDOM[5'h0][31:6], _RANDOM[5'h1][5:0]};	// Reg.scala:15:16, icache.scala:155:25
        counter = _RANDOM[5'h1][14:6];	// Edges.scala:228:27, Reg.scala:15:16
        vb_array =
          {_RANDOM[5'h1][31:15],
           _RANDOM[5'h2],
           _RANDOM[5'h3],
           _RANDOM[5'h4],
           _RANDOM[5'h5],
           _RANDOM[5'h6],
           _RANDOM[5'h7],
           _RANDOM[5'h8],
           _RANDOM[5'h9][14:0]};	// Reg.scala:15:16, icache.scala:186:25
        s2_dout_0_REG = {_RANDOM[5'h9][31:15], _RANDOM[5'hA], _RANDOM[5'hB][14:0]};	// icache.scala:186:25, :258:30
        s2_dout_1_REG = {_RANDOM[5'hB][31:15], _RANDOM[5'hC], _RANDOM[5'hD][14:0]};	// icache.scala:258:30
        s2_dout_2_REG = {_RANDOM[5'hD][31:15], _RANDOM[5'hE], _RANDOM[5'hF][14:0]};	// icache.scala:258:30
        s2_dout_3_REG = {_RANDOM[5'hF][31:15], _RANDOM[5'h10], _RANDOM[5'h11][14:0]};	// icache.scala:258:30
        s2_tag_hit_0 = _RANDOM[5'h11][15];	// icache.scala:258:30, :329:27
        s2_tag_hit_1 = _RANDOM[5'h11][16];	// icache.scala:258:30, :329:27
        s2_tag_hit_2 = _RANDOM[5'h11][17];	// icache.scala:258:30, :329:27
        s2_tag_hit_3 = _RANDOM[5'h11][18];	// icache.scala:258:30, :329:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  MaxPeriodFibonacciLFSR_1 repl_way_prng (	// PRNG.scala:82:22
    .clock        (clock),
    .reset        (reset),
    .io_increment (refill_fire),	// Decoupled.scala:40:37
    .io_out_0     (_repl_way_prng_io_out_0),
    .io_out_1     (_repl_way_prng_io_out_1),
    .io_out_2     (/* unused */),
    .io_out_3     (/* unused */),
    .io_out_4     (/* unused */),
    .io_out_5     (/* unused */),
    .io_out_6     (/* unused */),
    .io_out_7     (/* unused */),
    .io_out_8     (/* unused */),
    .io_out_9     (/* unused */),
    .io_out_10    (/* unused */),
    .io_out_11    (/* unused */),
    .io_out_12    (/* unused */),
    .io_out_13    (/* unused */),
    .io_out_14    (/* unused */),
    .io_out_15    (/* unused */)
  );
  tag_array_64x80 tag_array_ext (	// icache.scala:180:30
    .RW0_addr  (tag_array_MPORT_en ? refill_paddr[11:6] : _tag_rdata_T_4),	// Reg.scala:15:16, icache.scala:168:32, :174:37, :180:30, :181:42
    .RW0_en    (tag_array_tag_rdata_en | tag_array_MPORT_en),	// icache.scala:174:37, :180:30, :181:84
    .RW0_clk   (clock),
    .RW0_wmode (tag_array_MPORT_en),	// icache.scala:174:37
    .RW0_wdata ({4{refill_paddr[31:12]}}),	// Reg.scala:15:16, icache.scala:167:32, :180:30
    .RW0_wmask
      ({tag_array_MPORT_mask_3,
        tag_array_MPORT_mask_2,
        tag_array_MPORT_mask_1,
        tag_array_MPORT_mask_0}),	// icache.scala:180:30, :183:100
    .RW0_rdata (_tag_array_ext_RW0_rdata)
  );
  dataArray_512x64 dataArrayWay_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_9 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, icache.scala:169:41, :245:33, :250:{24,54,81}
    .RW0_en    (readEnable_2 | writeEnable_2),	// DescribedSRAM.scala:19:26, icache.scala:248:51, :258:60
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_2),	// icache.scala:248:51
    .RW0_wdata (auto_master_out_d_bits_data),
    .RW0_rdata (_dataArrayWay_0_ext_RW0_rdata)
  );
  dataArray_512x64 dataArrayWay_1_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_9 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, icache.scala:169:41, :245:33, :250:{24,54,81}
    .RW0_en    (readEnable_1 | writeEnable_1),	// DescribedSRAM.scala:19:26, icache.scala:248:51, :258:60
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_1),	// icache.scala:248:51
    .RW0_wdata (auto_master_out_d_bits_data),
    .RW0_rdata (_dataArrayWay_1_ext_RW0_rdata)
  );
  dataArray_512x64 dataArrayWay_2_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_9 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, icache.scala:169:41, :245:33, :250:{24,54,81}
    .RW0_en    (readEnable_0 | writeEnable_0),	// DescribedSRAM.scala:19:26, icache.scala:248:51, :258:60
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable_0),	// icache.scala:248:51
    .RW0_wdata (auto_master_out_d_bits_data),
    .RW0_rdata (_dataArrayWay_2_ext_RW0_rdata)
  );
  dataArray_512x64 dataArrayWay_3_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (refill_one_beat ? _mem_idx_T_9 | refill_cnt : io_req_bits_addr[11:3]),	// Edges.scala:233:25, icache.scala:169:41, :245:33, :250:{24,54,81}
    .RW0_en    (readEnable | writeEnable),	// DescribedSRAM.scala:19:26, icache.scala:248:51, :258:60
    .RW0_clk   (clock),
    .RW0_wmode (writeEnable),	// icache.scala:248:51
    .RW0_wdata (auto_master_out_d_bits_data),
    .RW0_rdata (_dataArrayWay_3_ext_RW0_rdata)
  );
  assign auto_master_out_a_valid = tl_out_a_valid;	// icache.scala:351:46
  assign auto_master_out_a_bits_address = {refill_paddr[31:6], 6'h0};	// Reg.scala:15:16, icache.scala:354:{31,48}
  assign io_resp_valid = s2_valid & s2_hit;	// icache.scala:158:25, :159:23, :349:29
  assign io_resp_bits_data =
    (s2_tag_hit_0 ? s2_dout_0_REG : 64'h0) | (s2_tag_hit_1 ? s2_dout_1_REG : 64'h0)
    | (s2_tag_hit_2 ? s2_dout_2_REG : 64'h0) | (s2_tag_hit_3 ? s2_dout_3_REG : 64'h0);	// Bundles.scala:256:54, Mux.scala:27:72, icache.scala:258:30, :329:27
  assign io_perf_acquire = refill_fire;	// Decoupled.scala:40:37
endmodule

