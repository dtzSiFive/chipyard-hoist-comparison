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

module TLFragmenter_6(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [7:0]  auto_in_a_bits_source,
  input  [11:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_size,
  input  [11:0] auto_out_d_bits_source,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_size,
  output [7:0]  auto_in_d_bits_source,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [1:0]  auto_out_a_bits_size,
  output [11:0] auto_out_a_bits_source,
                auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        _repeater_io_full;	// Fragmenter.scala:262:30
  wire        _repeater_io_enq_ready;	// Fragmenter.scala:262:30
  wire        _repeater_io_deq_valid;	// Fragmenter.scala:262:30
  wire [2:0]  _repeater_io_deq_bits_opcode;	// Fragmenter.scala:262:30
  wire [2:0]  _repeater_io_deq_bits_size;	// Fragmenter.scala:262:30
  wire [7:0]  _repeater_io_deq_bits_source;	// Fragmenter.scala:262:30
  wire [11:0] _repeater_io_deq_bits_address;	// Fragmenter.scala:262:30
  wire [7:0]  _repeater_io_deq_bits_mask;	// Fragmenter.scala:262:30
  reg  [2:0]  acknum;	// Fragmenter.scala:189:29
  reg  [2:0]  dOrig;	// Fragmenter.scala:190:24
  reg         dToggle;	// Fragmenter.scala:191:30
  wire        dFirst = acknum == 3'h0;	// Fragmenter.scala:189:29, :193:29
  wire [5:0]  _dsizeOH1_T_1 = 6'h7 << auto_out_d_bits_size;	// package.scala:234:77
  wire [2:0]  _GEN = ~(auto_out_d_bits_source[2:0]);	// Fragmenter.scala:192:41, package.scala:232:53
  wire [2:0]  dFirst_size_hi = auto_out_d_bits_source[2:0] & {1'h1, _GEN[2:1]};	// Fragmenter.scala:192:41, OneHot.scala:30:18, package.scala:232:{51,53}
  wire [2:0]  _dFirst_size_T_6 =
    {1'h0, dFirst_size_hi[2:1]} | ~(_dsizeOH1_T_1[2:0]) & {_GEN[0], _dsizeOH1_T_1[2:1]};	// OneHot.scala:30:18, :31:18, :32:28, package.scala:232:{51,53}, :234:{46,77,82}
  wire [2:0]  dFirst_size =
    {|dFirst_size_hi,
     |(_dFirst_size_T_6[2:1]),
     _dFirst_size_T_6[2] | _dFirst_size_T_6[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, package.scala:232:51
  wire        drop = ~(auto_out_d_bits_opcode[0]) & (|(auto_out_d_bits_source[2:0]));	// Edges.scala:105:36, Fragmenter.scala:192:41, :194:30, :222:{20,30}
  wire        bundleOut_0_d_ready = auto_in_d_ready | drop;	// Fragmenter.scala:222:30, :223:35
  wire        bundleIn_0_d_valid = auto_out_d_valid & ~drop;	// Fragmenter.scala:222:30, :224:{36,39}
  wire [2:0]  bundleIn_0_d_bits_size = dFirst ? dFirst_size : dOrig;	// Cat.scala:30:58, Fragmenter.scala:190:24, :193:29, :227:32
  wire [12:0] _aOrigOH1_T_1 = 13'h3F << _repeater_io_deq_bits_size;	// Fragmenter.scala:262:30, package.scala:234:77
  reg  [2:0]  gennum;	// Fragmenter.scala:291:29
  wire        aFirst = gennum == 3'h0;	// Fragmenter.scala:189:29, :291:29, :292:29
  wire [2:0]  _old_gennum1_T_1 = gennum - 3'h1;	// Fragmenter.scala:291:29, :293:79
  wire [2:0]  new_gennum = aFirst ? ~(_aOrigOH1_T_1[5:3]) : _old_gennum1_T_1;	// Fragmenter.scala:292:29, :293:{30,79}, package.scala:234:{46,77,82}
  reg         aToggle_r;	// Reg.scala:15:16
  `ifndef SYNTHESIS	// Fragmenter.scala:309:16
    always @(posedge clock) begin	// Fragmenter.scala:309:16
      if (~(~_repeater_io_full | _repeater_io_deq_bits_opcode[2] | reset)) begin	// Edges.scala:91:37, Fragmenter.scala:262:30, :309:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// Fragmenter.scala:309:16
          $error("Assertion failed\n    at Fragmenter.scala:309 assert (!repeater.io.full || !aHasData)\n");	// Fragmenter.scala:309:16
        if (`STOP_COND_)	// Fragmenter.scala:309:16
          $fatal;	// Fragmenter.scala:309:16
      end
      if (~(~_repeater_io_full | (&_repeater_io_deq_bits_mask) | reset)) begin	// Fragmenter.scala:262:30, :309:17, :312:{16,53}
        if (`ASSERT_VERBOSE_COND_)	// Fragmenter.scala:312:16
          $error("Assertion failed\n    at Fragmenter.scala:312 assert (!repeater.io.full || in_a.bits.mask === fullMask)\n");	// Fragmenter.scala:312:16
        if (`STOP_COND_)	// Fragmenter.scala:312:16
          $fatal;	// Fragmenter.scala:312:16
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic _GEN_0;	// Decoupled.scala:40:37
    automatic logic _GEN_1;	// Fragmenter.scala:190:24, :208:29, :210:25, :211:19
    _GEN_0 = bundleOut_0_d_ready & auto_out_d_valid;	// Decoupled.scala:40:37, Fragmenter.scala:223:35
    _GEN_1 = _GEN_0 & dFirst;	// Decoupled.scala:40:37, Fragmenter.scala:190:24, :193:29, :208:29, :210:25, :211:19
    if (reset) begin
      acknum <= 3'h0;	// Fragmenter.scala:189:29
      dToggle <= 1'h0;	// Fragmenter.scala:191:30
      gennum <= 3'h0;	// Fragmenter.scala:189:29, :291:29
    end
    else begin
      if (_GEN_0) begin	// Decoupled.scala:40:37
        if (dFirst)	// Fragmenter.scala:193:29
          acknum <= auto_out_d_bits_source[2:0];	// Fragmenter.scala:189:29, :192:41
        else	// Fragmenter.scala:193:29
          acknum <= acknum - {2'h0, auto_out_d_bits_opcode[0] | (&auto_out_d_bits_size)};	// Edges.scala:105:36, Fragmenter.scala:189:29, :204:{32,60}, :209:55, OneHot.scala:65:12
      end
      if (_GEN_1)	// Fragmenter.scala:190:24, :208:29, :210:25, :211:19
        dToggle <= auto_out_d_bits_source[3];	// Fragmenter.scala:191:30, :212:41
      if (auto_out_a_ready & _repeater_io_deq_valid) begin	// Decoupled.scala:40:37, Fragmenter.scala:262:30
        if (aFirst)	// Fragmenter.scala:292:29
          gennum <= ~(_aOrigOH1_T_1[5:3]);	// Fragmenter.scala:291:29, package.scala:234:{46,77,82}
        else	// Fragmenter.scala:292:29
          gennum <= _old_gennum1_T_1;	// Fragmenter.scala:291:29, :293:79
      end
    end
    if (_GEN_1)	// Fragmenter.scala:190:24, :208:29, :210:25, :211:19
      dOrig <= dFirst_size;	// Cat.scala:30:58, Fragmenter.scala:190:24
    if (aFirst)	// Fragmenter.scala:292:29
      aToggle_r <= dToggle;	// Fragmenter.scala:191:30, Reg.scala:15:16
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        acknum = _RANDOM[/*Zero width*/ 1'b0][2:0];	// Fragmenter.scala:189:29
        dOrig = _RANDOM[/*Zero width*/ 1'b0][5:3];	// Fragmenter.scala:189:29, :190:24
        dToggle = _RANDOM[/*Zero width*/ 1'b0][6];	// Fragmenter.scala:189:29, :191:30
        gennum = _RANDOM[/*Zero width*/ 1'b0][9:7];	// Fragmenter.scala:189:29, :291:29
        aToggle_r = _RANDOM[/*Zero width*/ 1'b0][10];	// Fragmenter.scala:189:29, Reg.scala:15:16
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_38 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_repeater_io_enq_ready),	// Fragmenter.scala:262:30
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (bundleIn_0_d_valid),	// Fragmenter.scala:224:36
    .io_in_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_in_d_bits_size    (bundleIn_0_d_bits_size),	// Fragmenter.scala:227:32
    .io_in_d_bits_source  (auto_out_d_bits_source[11:4])	// Fragmenter.scala:226:47
  );
  Repeater_6 repeater (	// Fragmenter.scala:262:30
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (_repeater_io_deq_bits_opcode[2] & (|new_gennum)),	// Edges.scala:91:37, Fragmenter.scala:262:30, :293:30, :302:{41,53}
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (auto_out_a_ready),
    .io_full             (_repeater_io_full),
    .io_enq_ready        (_repeater_io_enq_ready),
    .io_deq_valid        (_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeater_io_deq_bits_source),
    .io_deq_bits_address (_repeater_io_deq_bits_address),
    .io_deq_bits_mask    (_repeater_io_deq_bits_mask),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  assign auto_in_a_ready = _repeater_io_enq_ready;	// Fragmenter.scala:262:30
  assign auto_in_d_valid = bundleIn_0_d_valid;	// Fragmenter.scala:224:36
  assign auto_in_d_bits_size = bundleIn_0_d_bits_size;	// Fragmenter.scala:227:32
  assign auto_in_d_bits_source = auto_out_d_bits_source[11:4];	// Fragmenter.scala:226:47
  assign auto_out_a_valid = _repeater_io_deq_valid;	// Fragmenter.scala:262:30
  assign auto_out_a_bits_opcode = _repeater_io_deq_bits_opcode;	// Fragmenter.scala:262:30
  assign auto_out_a_bits_size =
    _repeater_io_deq_bits_size[2] ? 2'h3 : _repeater_io_deq_bits_size[1:0];	// Fragmenter.scala:262:30, :285:{24,31}, OneHot.scala:65:12
  assign auto_out_a_bits_source =
    {_repeater_io_deq_bits_source, ~(aFirst ? dToggle : aToggle_r), new_gennum};	// Cat.scala:30:58, Fragmenter.scala:191:30, :262:30, :292:29, :293:30, :297:{23,27}, Reg.scala:15:16
  assign auto_out_a_bits_address =
    {_repeater_io_deq_bits_address[11:6],
     _repeater_io_deq_bits_address[5:0] | {~(new_gennum | _aOrigOH1_T_1[5:3]), 3'h0}};	// Fragmenter.scala:189:29, :262:30, :293:30, :304:{49,51,88,111}, package.scala:234:{77,82}
  assign auto_out_a_bits_mask = _repeater_io_full ? 8'hFF : auto_in_a_bits_mask;	// Fragmenter.scala:262:30, :312:53, :313:31
  assign auto_out_d_ready = bundleOut_0_d_ready;	// Fragmenter.scala:223:35
endmodule

