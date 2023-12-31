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

module Directory(
  input         clock,
                reset,
                io_write_valid,
  input  [9:0]  io_write_bits_set,
  input  [2:0]  io_write_bits_way,
  input         io_write_bits_data_dirty,
  input  [1:0]  io_write_bits_data_state,
  input  [5:0]  io_write_bits_data_clients,
  input  [12:0] io_write_bits_data_tag,
  input         io_read_valid,
  input  [9:0]  io_read_bits_set,
  input  [12:0] io_read_bits_tag,
  output        io_write_ready,
                io_result_bits_dirty,
  output [1:0]  io_result_bits_state,
  output [5:0]  io_result_bits_clients,
  output [12:0] io_result_bits_tag,
  output        io_result_bits_hit,
  output [2:0]  io_result_bits_way,
  output        io_ready
);

  wire         cc_dir_MPORT_mask_7;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_6;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_5;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_4;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_3;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_2;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_1;	// Directory.scala:98:65
  wire         cc_dir_MPORT_mask_0;	// Directory.scala:98:65
  wire [21:0]  cc_dir_MPORT_data_7;	// Directory.scala:97:40
  wire [9:0]   cc_dir_MPORT_addr;	// Directory.scala:96:10
  wire         cc_dir_MPORT_en;	// Directory.scala:94:14
  wire         _victimLFSR_prng_io_out_6;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_7;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_8;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_9;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_10;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_11;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_12;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_13;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_14;	// PRNG.scala:82:22
  wire         _victimLFSR_prng_io_out_15;	// PRNG.scala:82:22
  wire         _write_io_deq_valid;	// Decoupled.scala:296:21
  wire [9:0]   _write_io_deq_bits_set;	// Decoupled.scala:296:21
  wire [2:0]   _write_io_deq_bits_way;	// Decoupled.scala:296:21
  wire         _write_io_deq_bits_data_dirty;	// Decoupled.scala:296:21
  wire [1:0]   _write_io_deq_bits_data_state;	// Decoupled.scala:296:21
  wire [5:0]   _write_io_deq_bits_data_clients;	// Decoupled.scala:296:21
  wire [12:0]  _write_io_deq_bits_data_tag;	// Decoupled.scala:296:21
  wire [175:0] _cc_dir_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  reg  [10:0]  wipeCount;	// Directory.scala:77:26
  reg          wipeOff;	// Directory.scala:78:24
  assign cc_dir_MPORT_en =
    ~io_read_valid & (~(wipeCount[10]) & ~wipeOff | _write_io_deq_valid);	// Decoupled.scala:296:21, Directory.scala:77:26, :78:24, :79:27, :83:{9,22}, :84:23, :88:{24,37}, :94:14
  assign cc_dir_MPORT_addr = wipeCount[10] ? _write_io_deq_bits_set : wipeCount[9:0];	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :80:26, :96:10
  assign cc_dir_MPORT_data_7 =
    wipeCount[10]
      ? {_write_io_deq_bits_data_dirty,
         _write_io_deq_bits_data_state,
         _write_io_deq_bits_data_clients,
         _write_io_deq_bits_data_tag}
      : 22'h0;	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :97:{40,67}
  assign cc_dir_MPORT_mask_0 = _write_io_deq_bits_way == 3'h0 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :121:42
  assign cc_dir_MPORT_mask_1 = _write_io_deq_bits_way == 3'h1 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_2 = _write_io_deq_bits_way == 3'h2 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_3 = _write_io_deq_bits_way == 3'h3 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_4 = _write_io_deq_bits_way == 3'h4 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_5 = _write_io_deq_bits_way == 3'h5 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_6 = _write_io_deq_bits_way == 3'h6 | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}, :129:67
  assign cc_dir_MPORT_mask_7 = (&_write_io_deq_bits_way) | ~(wipeCount[10]);	// Decoupled.scala:296:21, Directory.scala:77:26, :79:27, :83:9, :98:{51,65}
  reg          ren1;	// Directory.scala:101:21
  reg  [12:0]  tag;	// Reg.scala:15:16
  reg  [9:0]   set;	// Reg.scala:15:16
  wire [9:0]   victimLFSR =
    {_victimLFSR_prng_io_out_6,
     _victimLFSR_prng_io_out_7,
     _victimLFSR_prng_io_out_8,
     _victimLFSR_prng_io_out_9,
     _victimLFSR_prng_io_out_10,
     _victimLFSR_prng_io_out_11,
     _victimLFSR_prng_io_out_12,
     _victimLFSR_prng_io_out_13,
     _victimLFSR_prng_io_out_14,
     _victimLFSR_prng_io_out_15};	// Directory.scala:113:46, PRNG.scala:82:22
  wire [2:0]   _GEN =
    {_victimLFSR_prng_io_out_6, _victimLFSR_prng_io_out_7, _victimLFSR_prng_io_out_8};	// Directory.scala:115:43, PRNG.scala:82:22
  wire [1:0]   _GEN_0 = {_victimLFSR_prng_io_out_6, _victimLFSR_prng_io_out_7};	// Directory.scala:115:43, PRNG.scala:82:22
  wire         victimLTE_lo_hi_hi = victimLFSR > 10'h17F;	// Directory.scala:113:46, :115:43
  wire         victimLTE_hi_lo_hi = victimLFSR > 10'h27F;	// Directory.scala:113:46, :115:43
  wire         victimLTE_hi_hi_lo = victimLFSR > 10'h2FF;	// Directory.scala:113:46, :115:43
  wire         victimLTE_hi_hi_hi = victimLFSR > 10'h37F;	// Directory.scala:113:46, :115:43
  wire [3:0]   victimWay_hi =
    {victimLTE_hi_hi_hi,
     victimLTE_hi_hi_lo,
     victimLTE_hi_lo_hi,
     _victimLFSR_prng_io_out_6}
    & {1'h1, ~victimLTE_hi_hi_hi, ~victimLTE_hi_hi_lo, ~victimLTE_hi_lo_hi};	// Directory.scala:115:43, :117:{31,55,57}, OneHot.scala:30:18, PRNG.scala:82:22
  wire [2:0]   _victimWay_T =
    victimWay_hi[3:1] | {victimLTE_lo_hi_hi, |_GEN_0, |_GEN}
    & {~_victimLFSR_prng_io_out_6, ~victimLTE_lo_hi_hi, ~(|_GEN_0)};	// Directory.scala:115:43, :117:{31,55,57}, OneHot.scala:30:18, :31:18, :32:28, PRNG.scala:82:22
  wire [2:0]   victimWay =
    {|victimWay_hi, |(_victimWay_T[2:1]), _victimWay_T[2] | _victimWay_T[0]};	// Cat.scala:30:58, Directory.scala:117:55, OneHot.scala:30:18, :31:18, :32:{14,28}
  wire         _io_result_bits_T_71 = (|_GEN) & ~(|_GEN_0);	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}
  wire         _io_result_bits_T_72 = (|_GEN_0) & ~victimLTE_lo_hi_hi;	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}
  wire         _io_result_bits_T_73 = victimLTE_lo_hi_hi & ~_victimLFSR_prng_io_out_6;	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}, PRNG.scala:82:22
  wire         _io_result_bits_T_74 = _victimLFSR_prng_io_out_6 & ~victimLTE_hi_lo_hi;	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}, PRNG.scala:82:22
  wire         _io_result_bits_T_75 = victimLTE_hi_lo_hi & ~victimLTE_hi_hi_lo;	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}
  wire         _io_result_bits_T_76 = victimLTE_hi_hi_lo & ~victimLTE_hi_hi_hi;	// Bitwise.scala:49:65, Directory.scala:115:43, :117:{55,57}
  `ifndef SYNTHESIS	// Directory.scala:84:10
    always @(posedge clock) begin	// Directory.scala:84:10
      if (~(wipeCount[10] | ~io_read_valid | reset)) begin	// Directory.scala:77:26, :79:27, :84:{10,23}
        if (`ASSERT_VERBOSE_COND_)	// Directory.scala:84:10
          $error("Assertion failed\n    at Directory.scala:84 assert (wipeDone || !io.read.valid)\n");	// Directory.scala:84:10
        if (`STOP_COND_)	// Directory.scala:84:10
          $fatal;	// Directory.scala:84:10
      end
      if (~(~io_read_valid | wipeCount[10] | reset)) begin	// Directory.scala:77:26, :79:27, :84:23, :89:10
        if (`ASSERT_VERBOSE_COND_)	// Directory.scala:89:10
          $error("Assertion failed\n    at Directory.scala:89 assert (!io.read.valid || wipeDone)\n");	// Directory.scala:89:10
        if (`STOP_COND_)	// Directory.scala:89:10
          $fatal;	// Directory.scala:89:10
      end
      if (~(~ren1
            | ({~victimLTE_hi_hi_lo,
                ~victimLTE_hi_lo_hi,
                ~_victimLFSR_prng_io_out_6,
                ~victimLTE_lo_hi_hi,
                ~(|_GEN_0),
                ~(|_GEN)}
               & {victimLTE_hi_hi_hi,
                  victimLTE_hi_hi_lo,
                  victimLTE_hi_lo_hi,
                  _victimLFSR_prng_io_out_6,
                  victimLTE_lo_hi_hi,
                  |_GEN_0}) == 6'h0 | reset)) begin	// Directory.scala:101:21, :115:43, :117:{57,70}, :119:11, :120:{10,39,54}, Mux.scala:27:72, PRNG.scala:82:22
        if (`ASSERT_VERBOSE_COND_)	// Directory.scala:120:10
          $error("Assertion failed\n    at Directory.scala:120 assert (!ren2 || ((victimSimp >> 1) & ~victimSimp) === UInt(0)) // monotone\n");	// Directory.scala:120:10
        if (`STOP_COND_)	// Directory.scala:120:10
          $fatal;	// Directory.scala:120:10
      end
      if (~(~ren1
            | {1'h0,
               {1'h0, {1'h0, ~(|_GEN)} + {1'h0, _io_result_bits_T_71}}
                 + {1'h0, {1'h0, _io_result_bits_T_72} + {1'h0, _io_result_bits_T_73}}}
            + {1'h0,
               {1'h0, {1'h0, _io_result_bits_T_74} + {1'h0, _io_result_bits_T_75}}
                 + {1'h0,
                    {1'h0, _io_result_bits_T_76} + {1'h0, victimLTE_hi_hi_hi}}} == 4'h1
            | reset)) begin	// Bitwise.scala:47:55, :49:65, Directory.scala:101:21, :115:43, :117:{55,57}, :119:11, :121:{10,42}
        if (`ASSERT_VERBOSE_COND_)	// Directory.scala:121:10
          $error("Assertion failed\n    at Directory.scala:121 assert (!ren2 || PopCount(victimWayOH) === UInt(1))\n");	// Directory.scala:121:10
        if (`STOP_COND_)	// Directory.scala:121:10
          $fatal;	// Directory.scala:121:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire         setQuash = _write_io_deq_valid & _write_io_deq_bits_set == set;	// Decoupled.scala:296:21, Directory.scala:123:{31,45}, Reg.scala:15:16
  wire         tagMatch = _write_io_deq_bits_data_tag == tag;	// Decoupled.scala:296:21, Directory.scala:124:34, Reg.scala:15:16
  wire         hits_lo_lo_lo =
    _cc_dir_ext_RW0_rdata[12:0] == tag & (|(_cc_dir_ext_RW0_rdata[20:19]))
    & (~setQuash | (|_write_io_deq_bits_way));	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_lo_lo_hi =
    _cc_dir_ext_RW0_rdata[34:22] == tag & (|(_cc_dir_ext_RW0_rdata[42:41]))
    & (~setQuash | _write_io_deq_bits_way != 3'h1);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_lo_hi_lo =
    _cc_dir_ext_RW0_rdata[56:44] == tag & (|(_cc_dir_ext_RW0_rdata[64:63]))
    & (~setQuash | _write_io_deq_bits_way != 3'h2);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_lo_hi_hi =
    _cc_dir_ext_RW0_rdata[78:66] == tag & (|(_cc_dir_ext_RW0_rdata[86:85]))
    & (~setQuash | _write_io_deq_bits_way != 3'h3);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_hi_lo_lo =
    _cc_dir_ext_RW0_rdata[100:88] == tag & (|(_cc_dir_ext_RW0_rdata[108:107]))
    & (~setQuash | _write_io_deq_bits_way != 3'h4);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_hi_lo_hi =
    _cc_dir_ext_RW0_rdata[122:110] == tag & (|(_cc_dir_ext_RW0_rdata[130:129]))
    & (~setQuash | _write_io_deq_bits_way != 3'h5);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_hi_hi_lo =
    _cc_dir_ext_RW0_rdata[144:132] == tag & (|(_cc_dir_ext_RW0_rdata[152:151]))
    & (~setQuash | _write_io_deq_bits_way != 3'h6);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire         hits_hi_hi_hi =
    _cc_dir_ext_RW0_rdata[166:154] == tag & (|(_cc_dir_ext_RW0_rdata[174:173]))
    & (~setQuash | _write_io_deq_bits_way != 3'h7);	// Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:123:31, :127:69, :129:{11,30,42,46,56,67}, Reg.scala:15:16
  wire [7:0]   hits =
    {hits_hi_hi_hi,
     hits_hi_hi_lo,
     hits_hi_lo_hi,
     hits_hi_lo_lo,
     hits_lo_hi_hi,
     hits_lo_hi_lo,
     hits_lo_lo_hi,
     hits_lo_lo_lo};	// Cat.scala:30:58, Directory.scala:129:42
  wire         _io_result_bits_T_69 =
    setQuash & (tagMatch | _write_io_deq_bits_way == victimWay);	// Cat.scala:30:58, Decoupled.scala:296:21, Directory.scala:123:31, :124:34, :125:29, :134:{62,75}
  wire         _io_result_bits_way_T_3 = setQuash & tagMatch;	// Directory.scala:123:31, :124:34, :135:42
  wire [2:0]   _io_result_bits_way_T =
    {hits_hi_hi_hi, hits_hi_hi_lo, hits_hi_lo_hi}
    | {hits_lo_hi_hi, hits_lo_hi_lo, hits_lo_lo_hi};	// Directory.scala:129:42, OneHot.scala:30:18, :31:18, :32:28
  always @(posedge clock) begin
    if (reset) begin
      wipeCount <= 11'h0;	// Directory.scala:77:26
      wipeOff <= 1'h1;	// Directory.scala:78:24
      ren1 <= 1'h0;	// Directory.scala:101:21
    end
    else begin
      if (wipeCount[10] | wipeOff) begin	// Directory.scala:77:26, :78:24, :79:27, :83:{32,44}
      end
      else	// Directory.scala:77:26, :83:{32,44}
        wipeCount <= wipeCount + 11'h1;	// Directory.scala:77:26, :83:57
      wipeOff <= 1'h0;	// Directory.scala:78:24
      ren1 <= io_read_valid;	// Directory.scala:101:21
    end
    if (io_read_valid) begin
      tag <= io_read_bits_tag;	// Reg.scala:15:16
      set <= io_read_bits_set;	// Reg.scala:15:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:1];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        wipeCount = _RANDOM[1'h0][10:0];	// Directory.scala:77:26
        wipeOff = _RANDOM[1'h0][11];	// Directory.scala:77:26, :78:24
        ren1 = _RANDOM[1'h0][12];	// Directory.scala:77:26, :101:21
        tag = _RANDOM[1'h0][25:13];	// Directory.scala:77:26, Reg.scala:15:16
        set = {_RANDOM[1'h0][31:26], _RANDOM[1'h1][3:0]};	// Directory.scala:77:26, Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  cc_dir_1024x176 cc_dir_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (cc_dir_MPORT_en ? cc_dir_MPORT_addr : io_read_bits_set),	// DescribedSRAM.scala:19:26, Directory.scala:94:14, :96:10
    .RW0_en    (io_read_valid | cc_dir_MPORT_en),	// DescribedSRAM.scala:19:26, Directory.scala:94:14
    .RW0_clk   (clock),
    .RW0_wmode (~io_read_valid),	// Directory.scala:84:23
    .RW0_wdata ({8{cc_dir_MPORT_data_7}}),	// DescribedSRAM.scala:19:26, Directory.scala:97:40
    .RW0_wmask
      ({cc_dir_MPORT_mask_7,
        cc_dir_MPORT_mask_6,
        cc_dir_MPORT_mask_5,
        cc_dir_MPORT_mask_4,
        cc_dir_MPORT_mask_3,
        cc_dir_MPORT_mask_2,
        cc_dir_MPORT_mask_1,
        cc_dir_MPORT_mask_0}),	// DescribedSRAM.scala:19:26, Directory.scala:98:65
    .RW0_rdata (_cc_dir_ext_RW0_rdata)
  );
  Queue_27 write (	// Decoupled.scala:296:21
    .clock                    (clock),
    .reset                    (reset),
    .io_enq_valid             (io_write_valid),
    .io_enq_bits_set          (io_write_bits_set),
    .io_enq_bits_way          (io_write_bits_way),
    .io_enq_bits_data_dirty   (io_write_bits_data_dirty),
    .io_enq_bits_data_state   (io_write_bits_data_state),
    .io_enq_bits_data_clients (io_write_bits_data_clients),
    .io_enq_bits_data_tag     (io_write_bits_data_tag),
    .io_deq_ready             (~io_read_valid),	// Directory.scala:84:23
    .io_enq_ready             (io_write_ready),
    .io_deq_valid             (_write_io_deq_valid),
    .io_deq_bits_set          (_write_io_deq_bits_set),
    .io_deq_bits_way          (_write_io_deq_bits_way),
    .io_deq_bits_data_dirty   (_write_io_deq_bits_data_dirty),
    .io_deq_bits_data_state   (_write_io_deq_bits_data_state),
    .io_deq_bits_data_clients (_write_io_deq_bits_data_clients),
    .io_deq_bits_data_tag     (_write_io_deq_bits_data_tag)
  );
  MaxPeriodFibonacciLFSR victimLFSR_prng (	// PRNG.scala:82:22
    .clock        (clock),
    .reset        (reset),
    .io_increment (io_read_valid),
    .io_out_0     (/* unused */),
    .io_out_1     (/* unused */),
    .io_out_2     (/* unused */),
    .io_out_3     (/* unused */),
    .io_out_4     (/* unused */),
    .io_out_5     (/* unused */),
    .io_out_6     (_victimLFSR_prng_io_out_6),
    .io_out_7     (_victimLFSR_prng_io_out_7),
    .io_out_8     (_victimLFSR_prng_io_out_8),
    .io_out_9     (_victimLFSR_prng_io_out_9),
    .io_out_10    (_victimLFSR_prng_io_out_10),
    .io_out_11    (_victimLFSR_prng_io_out_11),
    .io_out_12    (_victimLFSR_prng_io_out_12),
    .io_out_13    (_victimLFSR_prng_io_out_13),
    .io_out_14    (_victimLFSR_prng_io_out_14),
    .io_out_15    (_victimLFSR_prng_io_out_15)
  );
  assign io_result_bits_dirty =
    (|hits)
      ? hits_lo_lo_lo & _cc_dir_ext_RW0_rdata[21] | hits_lo_lo_hi
        & _cc_dir_ext_RW0_rdata[43] | hits_lo_hi_lo & _cc_dir_ext_RW0_rdata[65]
        | hits_lo_hi_hi & _cc_dir_ext_RW0_rdata[87] | hits_hi_lo_lo
        & _cc_dir_ext_RW0_rdata[109] | hits_hi_lo_hi & _cc_dir_ext_RW0_rdata[131]
        | hits_hi_hi_lo & _cc_dir_ext_RW0_rdata[153] | hits_hi_hi_hi
        & _cc_dir_ext_RW0_rdata[175]
      : _io_result_bits_T_69
          ? _write_io_deq_bits_data_dirty
          : ~(|_GEN) & _cc_dir_ext_RW0_rdata[21] | _io_result_bits_T_71
            & _cc_dir_ext_RW0_rdata[43] | _io_result_bits_T_72 & _cc_dir_ext_RW0_rdata[65]
            | _io_result_bits_T_73 & _cc_dir_ext_RW0_rdata[87] | _io_result_bits_T_74
            & _cc_dir_ext_RW0_rdata[109] | _io_result_bits_T_75
            & _cc_dir_ext_RW0_rdata[131] | _io_result_bits_T_76
            & _cc_dir_ext_RW0_rdata[153] | victimLTE_hi_hi_hi
            & _cc_dir_ext_RW0_rdata[175];	// Bitwise.scala:49:65, Cat.scala:30:58, Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:115:43, :117:{55,57}, :127:69, :129:42, :131:21, :134:{24,52,62}, Mux.scala:27:72
  assign io_result_bits_state =
    (|hits)
      ? (hits_lo_lo_lo ? _cc_dir_ext_RW0_rdata[20:19] : 2'h0)
        | (hits_lo_lo_hi ? _cc_dir_ext_RW0_rdata[42:41] : 2'h0)
        | (hits_lo_hi_lo ? _cc_dir_ext_RW0_rdata[64:63] : 2'h0)
        | (hits_lo_hi_hi ? _cc_dir_ext_RW0_rdata[86:85] : 2'h0)
        | (hits_hi_lo_lo ? _cc_dir_ext_RW0_rdata[108:107] : 2'h0)
        | (hits_hi_lo_hi ? _cc_dir_ext_RW0_rdata[130:129] : 2'h0)
        | (hits_hi_hi_lo ? _cc_dir_ext_RW0_rdata[152:151] : 2'h0)
        | (hits_hi_hi_hi ? _cc_dir_ext_RW0_rdata[174:173] : 2'h0)
      : _io_result_bits_T_69
          ? _write_io_deq_bits_data_state
          : ((|_GEN) ? 2'h0 : _cc_dir_ext_RW0_rdata[20:19])
            | (_io_result_bits_T_71 ? _cc_dir_ext_RW0_rdata[42:41] : 2'h0)
            | (_io_result_bits_T_72 ? _cc_dir_ext_RW0_rdata[64:63] : 2'h0)
            | (_io_result_bits_T_73 ? _cc_dir_ext_RW0_rdata[86:85] : 2'h0)
            | (_io_result_bits_T_74 ? _cc_dir_ext_RW0_rdata[108:107] : 2'h0)
            | (_io_result_bits_T_75 ? _cc_dir_ext_RW0_rdata[130:129] : 2'h0)
            | (_io_result_bits_T_76 ? _cc_dir_ext_RW0_rdata[152:151] : 2'h0)
            | (victimLTE_hi_hi_hi ? _cc_dir_ext_RW0_rdata[174:173] : 2'h0);	// Bitwise.scala:49:65, Cat.scala:30:58, Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:115:43, :117:55, :127:69, :129:42, :131:21, :134:{24,52,62}, Mux.scala:27:72
  assign io_result_bits_clients =
    (|hits)
      ? (hits_lo_lo_lo ? _cc_dir_ext_RW0_rdata[18:13] : 6'h0)
        | (hits_lo_lo_hi ? _cc_dir_ext_RW0_rdata[40:35] : 6'h0)
        | (hits_lo_hi_lo ? _cc_dir_ext_RW0_rdata[62:57] : 6'h0)
        | (hits_lo_hi_hi ? _cc_dir_ext_RW0_rdata[84:79] : 6'h0)
        | (hits_hi_lo_lo ? _cc_dir_ext_RW0_rdata[106:101] : 6'h0)
        | (hits_hi_lo_hi ? _cc_dir_ext_RW0_rdata[128:123] : 6'h0)
        | (hits_hi_hi_lo ? _cc_dir_ext_RW0_rdata[150:145] : 6'h0)
        | (hits_hi_hi_hi ? _cc_dir_ext_RW0_rdata[172:167] : 6'h0)
      : _io_result_bits_T_69
          ? _write_io_deq_bits_data_clients
          : ((|_GEN) ? 6'h0 : _cc_dir_ext_RW0_rdata[18:13])
            | (_io_result_bits_T_71 ? _cc_dir_ext_RW0_rdata[40:35] : 6'h0)
            | (_io_result_bits_T_72 ? _cc_dir_ext_RW0_rdata[62:57] : 6'h0)
            | (_io_result_bits_T_73 ? _cc_dir_ext_RW0_rdata[84:79] : 6'h0)
            | (_io_result_bits_T_74 ? _cc_dir_ext_RW0_rdata[106:101] : 6'h0)
            | (_io_result_bits_T_75 ? _cc_dir_ext_RW0_rdata[128:123] : 6'h0)
            | (_io_result_bits_T_76 ? _cc_dir_ext_RW0_rdata[150:145] : 6'h0)
            | (victimLTE_hi_hi_hi ? _cc_dir_ext_RW0_rdata[172:167] : 6'h0);	// Bitwise.scala:49:65, Cat.scala:30:58, Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:115:43, :117:55, :127:69, :129:42, :131:21, :134:{24,52,62}, Mux.scala:27:72
  assign io_result_bits_tag =
    (|hits)
      ? (hits_lo_lo_lo ? _cc_dir_ext_RW0_rdata[12:0] : 13'h0)
        | (hits_lo_lo_hi ? _cc_dir_ext_RW0_rdata[34:22] : 13'h0)
        | (hits_lo_hi_lo ? _cc_dir_ext_RW0_rdata[56:44] : 13'h0)
        | (hits_lo_hi_hi ? _cc_dir_ext_RW0_rdata[78:66] : 13'h0)
        | (hits_hi_lo_lo ? _cc_dir_ext_RW0_rdata[100:88] : 13'h0)
        | (hits_hi_lo_hi ? _cc_dir_ext_RW0_rdata[122:110] : 13'h0)
        | (hits_hi_hi_lo ? _cc_dir_ext_RW0_rdata[144:132] : 13'h0)
        | (hits_hi_hi_hi ? _cc_dir_ext_RW0_rdata[166:154] : 13'h0)
      : _io_result_bits_T_69
          ? _write_io_deq_bits_data_tag
          : ((|_GEN) ? 13'h0 : _cc_dir_ext_RW0_rdata[12:0])
            | (_io_result_bits_T_71 ? _cc_dir_ext_RW0_rdata[34:22] : 13'h0)
            | (_io_result_bits_T_72 ? _cc_dir_ext_RW0_rdata[56:44] : 13'h0)
            | (_io_result_bits_T_73 ? _cc_dir_ext_RW0_rdata[78:66] : 13'h0)
            | (_io_result_bits_T_74 ? _cc_dir_ext_RW0_rdata[100:88] : 13'h0)
            | (_io_result_bits_T_75 ? _cc_dir_ext_RW0_rdata[122:110] : 13'h0)
            | (_io_result_bits_T_76 ? _cc_dir_ext_RW0_rdata[144:132] : 13'h0)
            | (victimLTE_hi_hi_hi ? _cc_dir_ext_RW0_rdata[166:154] : 13'h0);	// Bitwise.scala:49:65, Cat.scala:30:58, Decoupled.scala:296:21, DescribedSRAM.scala:19:26, Directory.scala:115:43, :117:55, :127:69, :129:42, :131:21, :134:{24,52,62}, Mux.scala:27:72
  assign io_result_bits_hit =
    (|hits) | _io_result_bits_way_T_3 & (|_write_io_deq_bits_data_state);	// Cat.scala:30:58, Decoupled.scala:296:21, Directory.scala:131:21, :135:{29,42,54,75}
  assign io_result_bits_way =
    (|hits)
      ? {|{hits_hi_hi_hi, hits_hi_hi_lo, hits_hi_lo_hi, hits_hi_lo_lo},
         |(_io_result_bits_way_T[2:1]),
         _io_result_bits_way_T[2] | _io_result_bits_way_T[0]}
      : _io_result_bits_way_T_3 ? _write_io_deq_bits_way : victimWay;	// Cat.scala:30:58, Decoupled.scala:296:21, Directory.scala:129:42, :131:21, :135:42, :136:{28,53}, OneHot.scala:30:18, :31:18, :32:{14,28}
  assign io_ready = wipeCount[10];	// Directory.scala:77:26, :79:27
endmodule

