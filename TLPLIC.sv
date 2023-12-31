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

module TLPLIC(
  input         clock,
                reset,
                auto_int_in_0,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [11:0] auto_in_a_bits_source,
  input  [27:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
  output        auto_int_out_10_0,
                auto_int_out_9_0,
                auto_int_out_8_0,
                auto_int_out_7_0,
                auto_int_out_6_0,
                auto_int_out_5_0,
                auto_int_out_4_0,
                auto_int_out_3_0,
                auto_int_out_2_0,
                auto_int_out_1_0,
                auto_int_out_0_0,
                auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_size,
  output [11:0] auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data
);

  wire        out_woready_47;	// RegisterRouter.scala:79:24
  wire        out_woready_10;	// RegisterRouter.scala:79:24
  wire        out_woready_26;	// RegisterRouter.scala:79:24
  wire        out_woready_35;	// RegisterRouter.scala:79:24
  wire        out_woready_44;	// RegisterRouter.scala:79:24
  wire        out_woready_7;	// RegisterRouter.scala:79:24
  wire        out_woready_23;	// RegisterRouter.scala:79:24
  wire        out_woready_32;	// RegisterRouter.scala:79:24
  wire        out_woready_41;	// RegisterRouter.scala:79:24
  wire        out_woready_29;	// RegisterRouter.scala:79:24
  wire        out_woready_38;	// RegisterRouter.scala:79:24
  wire        _out_rofireMux_T_1;	// RegisterRouter.scala:79:24
  wire        out_backSel_416;	// RegisterRouter.scala:79:24
  wire        out_backSel_400;	// RegisterRouter.scala:79:24
  wire        out_backSel_384;	// RegisterRouter.scala:79:24
  wire        out_backSel_368;	// RegisterRouter.scala:79:24
  wire        out_backSel_352;	// RegisterRouter.scala:79:24
  wire        out_backSel_336;	// RegisterRouter.scala:79:24
  wire        out_backSel_320;	// RegisterRouter.scala:79:24
  wire        out_backSel_304;	// RegisterRouter.scala:79:24
  wire        out_backSel_288;	// RegisterRouter.scala:79:24
  wire        out_backSel_272;	// RegisterRouter.scala:79:24
  wire        out_backSel_256;	// RegisterRouter.scala:79:24
  wire        completer_10;	// Plic.scala:295:35
  wire        completerDev;	// RegisterRouter.scala:79:24, package.scala:154:13
  wire        completer_6;	// Plic.scala:295:35
  wire        completer_2;	// Plic.scala:295:35
  wire        completer_0;	// Plic.scala:295:35
  wire        completer_7;	// Plic.scala:295:35
  wire        completer_3;	// Plic.scala:295:35
  wire        completer_1;	// Plic.scala:295:35
  wire        completer_8;	// Plic.scala:295:35
  wire        completer_4;	// Plic.scala:295:35
  wire        completer_9;	// Plic.scala:295:35
  wire        completer_5;	// Plic.scala:295:35
  wire        _out_back_io_enq_ready;	// Decoupled.scala:296:21
  wire        _out_back_io_deq_valid;	// Decoupled.scala:296:21
  wire        _out_back_io_deq_bits_read;	// Decoupled.scala:296:21
  wire [22:0] _out_back_io_deq_bits_index;	// Decoupled.scala:296:21
  wire [63:0] _out_back_io_deq_bits_data;	// Decoupled.scala:296:21
  wire [7:0]  _out_back_io_deq_bits_mask;	// Decoupled.scala:296:21
  wire [11:0] _out_back_io_deq_bits_extra_tlrr_extra_source;	// Decoupled.scala:296:21
  wire [1:0]  _out_back_io_deq_bits_extra_tlrr_extra_size;	// Decoupled.scala:296:21
  wire        _fanin_10_io_dev;	// Plic.scala:184:25
  wire        _fanin_10_io_max;	// Plic.scala:184:25
  wire        _fanin_9_io_dev;	// Plic.scala:184:25
  wire        _fanin_9_io_max;	// Plic.scala:184:25
  wire        _fanin_8_io_dev;	// Plic.scala:184:25
  wire        _fanin_8_io_max;	// Plic.scala:184:25
  wire        _fanin_7_io_dev;	// Plic.scala:184:25
  wire        _fanin_7_io_max;	// Plic.scala:184:25
  wire        _fanin_6_io_dev;	// Plic.scala:184:25
  wire        _fanin_6_io_max;	// Plic.scala:184:25
  wire        _fanin_5_io_dev;	// Plic.scala:184:25
  wire        _fanin_5_io_max;	// Plic.scala:184:25
  wire        _fanin_4_io_dev;	// Plic.scala:184:25
  wire        _fanin_4_io_max;	// Plic.scala:184:25
  wire        _fanin_3_io_dev;	// Plic.scala:184:25
  wire        _fanin_3_io_max;	// Plic.scala:184:25
  wire        _fanin_2_io_dev;	// Plic.scala:184:25
  wire        _fanin_2_io_max;	// Plic.scala:184:25
  wire        _fanin_1_io_dev;	// Plic.scala:184:25
  wire        _fanin_1_io_max;	// Plic.scala:184:25
  wire        _fanin_io_dev;	// Plic.scala:184:25
  wire        _fanin_io_max;	// Plic.scala:184:25
  wire        _gateways_gateway_io_plic_valid;	// Plic.scala:156:27
  reg         priority_0;	// Plic.scala:163:31
  reg         threshold_0;	// Plic.scala:166:31
  reg         threshold_1;	// Plic.scala:166:31
  reg         threshold_2;	// Plic.scala:166:31
  reg         threshold_3;	// Plic.scala:166:31
  reg         threshold_4;	// Plic.scala:166:31
  reg         threshold_5;	// Plic.scala:166:31
  reg         threshold_6;	// Plic.scala:166:31
  reg         threshold_7;	// Plic.scala:166:31
  reg         threshold_8;	// Plic.scala:166:31
  reg         threshold_9;	// Plic.scala:166:31
  reg         threshold_10;	// Plic.scala:166:31
  reg         pending_0;	// Plic.scala:168:22
  reg         enables_0_0;	// Plic.scala:174:26
  reg         enables_1_0;	// Plic.scala:174:26
  reg         enables_2_0;	// Plic.scala:174:26
  reg         enables_3_0;	// Plic.scala:174:26
  reg         enables_4_0;	// Plic.scala:174:26
  reg         enables_5_0;	// Plic.scala:174:26
  reg         enables_6_0;	// Plic.scala:174:26
  reg         enables_7_0;	// Plic.scala:174:26
  reg         enables_8_0;	// Plic.scala:174:26
  reg         enables_9_0;	// Plic.scala:174:26
  reg         enables_10_0;	// Plic.scala:174:26
  reg         maxDevs_0;	// Plic.scala:181:22
  reg         maxDevs_1;	// Plic.scala:181:22
  reg         maxDevs_2;	// Plic.scala:181:22
  reg         maxDevs_3;	// Plic.scala:181:22
  reg         maxDevs_4;	// Plic.scala:181:22
  reg         maxDevs_5;	// Plic.scala:181:22
  reg         maxDevs_6;	// Plic.scala:181:22
  reg         maxDevs_7;	// Plic.scala:181:22
  reg         maxDevs_8;	// Plic.scala:181:22
  reg         maxDevs_9;	// Plic.scala:181:22
  reg         maxDevs_10;	// Plic.scala:181:22
  reg         bundleOut_0_0_REG;	// Plic.scala:188:41
  reg         bundleOut_1_0_REG;	// Plic.scala:188:41
  reg         bundleOut_2_0_REG;	// Plic.scala:188:41
  reg         bundleOut_3_0_REG;	// Plic.scala:188:41
  reg         bundleOut_4_0_REG;	// Plic.scala:188:41
  reg         bundleOut_5_0_REG;	// Plic.scala:188:41
  reg         bundleOut_6_0_REG;	// Plic.scala:188:41
  reg         bundleOut_7_0_REG;	// Plic.scala:188:41
  reg         bundleOut_8_0_REG;	// Plic.scala:188:41
  reg         bundleOut_9_0_REG;	// Plic.scala:188:41
  reg         bundleOut_10_0_REG;	// Plic.scala:188:41
  wire [1:0]  _GEN = {1'h0, completerDev};	// OneHot.scala:65:12, RegisterRouter.scala:79:24, package.scala:154:13
  wire        _out_T_47 =
    {_out_back_io_deq_bits_index[22:19],
     _out_back_io_deq_bits_index[17:13],
     _out_back_io_deq_bits_index[8],
     _out_back_io_deq_bits_index[3:0]} == 14'h0;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [31:0] _out_womask_T_47 =
    {{8{_out_back_io_deq_bits_mask[7]}},
     {8{_out_back_io_deq_bits_mask[6]}},
     {8{_out_back_io_deq_bits_mask[5]}},
     {8{_out_back_io_deq_bits_mask[4]}}};	// Bitwise.scala:26:51, :72:12, Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire        claimer_5 =
    _out_rofireMux_T_1 & out_backSel_336 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_5_T = {enables_5_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_5 = out_woready_7 & (&_out_womask_T_47) & _out_completer_5_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_9 =
    _out_rofireMux_T_1 & out_backSel_400 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_9_T = {enables_9_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_9 = out_woready_10 & (&_out_womask_T_47) & _out_completer_9_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_4 =
    _out_rofireMux_T_1 & out_backSel_320 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_4_T = {enables_4_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_4 = out_woready_23 & (&_out_womask_T_47) & _out_completer_4_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_8 =
    _out_rofireMux_T_1 & out_backSel_384 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_8_T = {enables_8_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_8 = out_woready_26 & (&_out_womask_T_47) & _out_completer_8_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_1 =
    _out_rofireMux_T_1 & out_backSel_272 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_1_T = {enables_1_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_1 = out_woready_29 & (&_out_womask_T_47) & _out_completer_1_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_3 =
    _out_rofireMux_T_1 & out_backSel_304 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_3_T = {enables_3_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_3 = out_woready_32 & (&_out_womask_T_47) & _out_completer_3_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_7 =
    _out_rofireMux_T_1 & out_backSel_368 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_7_T = {enables_7_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_7 = out_woready_35 & (&_out_womask_T_47) & _out_completer_7_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_0 =
    _out_rofireMux_T_1 & out_backSel_256 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_0_T = {enables_0_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_0 = out_woready_38 & (&_out_womask_T_47) & _out_completer_0_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_2 =
    _out_rofireMux_T_1 & out_backSel_288 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_2_T = {enables_2_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_2 = out_woready_41 & (&_out_womask_T_47) & _out_completer_2_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_6 =
    _out_rofireMux_T_1 & out_backSel_352 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  wire [1:0]  _out_completer_6_T = {enables_6_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_6 = out_woready_44 & (&_out_womask_T_47) & _out_completer_6_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire        claimer_10 =
    _out_rofireMux_T_1 & out_backSel_416 & _out_T_47 & (|_out_womask_T_47);	// RegisterRouter.scala:79:24
  assign completerDev = _out_back_io_deq_bits_data[32];	// Decoupled.scala:296:21, RegisterRouter.scala:79:24, package.scala:154:13
  `ifndef SYNTHESIS	// Plic.scala:245:11
    always @(posedge clock) begin	// Plic.scala:245:11
      automatic logic [10:0] _GEN_0 =
        {claimer_10,
         claimer_9,
         claimer_8,
         claimer_7,
         claimer_6,
         claimer_5,
         claimer_4,
         claimer_3,
         claimer_2,
         claimer_1,
         claimer_0};	// Plic.scala:245:21, RegisterRouter.scala:79:24
      automatic logic [10:0] _GEN_1 =
        {completer_10,
         completer_9,
         completer_8,
         completer_7,
         completer_6,
         completer_5,
         completer_4,
         completer_3,
         completer_2,
         completer_1,
         completer_0};	// Plic.scala:262:23, :295:35
      if (~((_GEN_0 & _GEN_0 - 11'h1) == 11'h0 | reset)) begin	// Plic.scala:245:{11,21,28,46,58}
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:245:11
          $error("Assertion failed\n    at Plic.scala:245 assert((claimer.asUInt & (claimer.asUInt - UInt(1))) === UInt(0)) // One-Hot\n");	// Plic.scala:245:11
        if (`STOP_COND_)	// Plic.scala:245:11
          $fatal;	// Plic.scala:245:11
      end
      if (~((_GEN_1 & _GEN_1 - 11'h1) == 11'h0 | reset)) begin	// Plic.scala:245:46, :262:{11,23,30,50,62}
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:262:11
          $error("Assertion failed\n    at Plic.scala:262 assert((completer.asUInt & (completer.asUInt - UInt(1))) === UInt(0)) // One-Hot\n");	// Plic.scala:262:11
        if (`STOP_COND_)	// Plic.scala:262:11
          $fatal;	// Plic.scala:262:11
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
      if (~(completerDev == _out_back_io_deq_bits_data[32] | reset)) begin	// Decoupled.scala:296:21, Plic.scala:292:{19,33}, RegisterRouter.scala:79:24, package.scala:154:13
        if (`ASSERT_VERBOSE_COND_)	// Plic.scala:292:19
          $error("Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:292 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n");	// Plic.scala:292:19
        if (`STOP_COND_)	// Plic.scala:292:19
          $fatal;	// Plic.scala:292:19
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [1:0]  _out_completer_10_T = {enables_10_0, 1'h0} >> _GEN;	// Cat.scala:30:58, OneHot.scala:65:12, Plic.scala:174:26, :295:51
  assign completer_10 = out_woready_47 & (&_out_womask_T_47) & _out_completer_10_T[0];	// Plic.scala:295:{35,51}, RegisterRouter.scala:79:24
  wire [8:0]  out_oindex =
    {_out_back_io_deq_bits_index[18],
     _out_back_io_deq_bits_index[12:9],
     _out_back_io_deq_bits_index[7:4]};	// Cat.scala:30:58, Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire [8:0]  _GEN_2 =
    {_out_back_io_deq_bits_index[18],
     _out_back_io_deq_bits_index[12:9],
     _out_back_io_deq_bits_index[7:4]};	// Cat.scala:30:58, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_256 = _GEN_2 == 9'h100;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_272 = _GEN_2 == 9'h110;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_288 = _GEN_2 == 9'h120;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_304 = _GEN_2 == 9'h130;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_320 = _GEN_2 == 9'h140;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_336 = _GEN_2 == 9'h150;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_352 = _GEN_2 == 9'h160;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_368 = _GEN_2 == 9'h170;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_384 = _GEN_2 == 9'h180;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_400 = _GEN_2 == 9'h190;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_backSel_416 = _GEN_2 == 9'h1A0;	// Conditional.scala:37:30, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire        _out_wofireMux_T = _out_back_io_deq_valid & auto_in_d_ready;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  assign _out_rofireMux_T_1 = _out_wofireMux_T & _out_back_io_deq_bits_read;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  wire        _out_wofireMux_T_2 = _out_wofireMux_T & ~_out_back_io_deq_bits_read;	// Decoupled.scala:296:21, RegisterRouter.scala:79:24
  assign out_woready_38 = _out_wofireMux_T_2 & out_backSel_256 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_29 = _out_wofireMux_T_2 & out_backSel_272 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_41 = _out_wofireMux_T_2 & out_backSel_288 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_32 = _out_wofireMux_T_2 & out_backSel_304 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_23 = _out_wofireMux_T_2 & out_backSel_320 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_7 = _out_wofireMux_T_2 & out_backSel_336 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_44 = _out_wofireMux_T_2 & out_backSel_352 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_35 = _out_wofireMux_T_2 & out_backSel_368 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_26 = _out_wofireMux_T_2 & out_backSel_384 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_10 = _out_wofireMux_T_2 & out_backSel_400 & _out_T_47;	// RegisterRouter.scala:79:24
  assign out_woready_47 = _out_wofireMux_T_2 & out_backSel_416 & _out_T_47;	// RegisterRouter.scala:79:24
  wire        _out_out_bits_data_T_24 = out_oindex == 9'h0;	// Cat.scala:30:58, Conditional.scala:37:30
  wire [2:0]  bundleIn_0_d_bits_opcode = {2'h0, _out_back_io_deq_bits_read};	// Decoupled.scala:296:21, RegisterRouter.scala:94:19
  always @(posedge clock) begin
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h0 & _out_T_47 & _out_back_io_deq_bits_mask[4])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      priority_0 <= _out_back_io_deq_bits_data[32];	// Decoupled.scala:296:21, Plic.scala:163:31, RegisterRouter.scala:79:24
    if (out_woready_38 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_0 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_29 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_1 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_41 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_2 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_32 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_3 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_23 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_4 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_7 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_5 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_44 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_6 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_35 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_7 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_26 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_8 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_10 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_9 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (out_woready_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Decoupled.scala:296:21, RegisterRouter.scala:79:24
      threshold_10 <= _out_back_io_deq_bits_data[0];	// Decoupled.scala:296:21, Plic.scala:166:31, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h20 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_0_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h21 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_1_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h22 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_2_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h23 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_3_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h24 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_4_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h25 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_5_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h26 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_6_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h27 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_7_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h28 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_8_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h29 & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_9_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    if (_out_wofireMux_T_2 & _GEN_2 == 9'h2A & _out_T_47 & _out_back_io_deq_bits_mask[0])	// Bitwise.scala:26:51, Conditional.scala:37:30, Decoupled.scala:296:21, OneHot.scala:58:35, RegisterRouter.scala:79:24
      enables_10_0 <= _out_back_io_deq_bits_data[1];	// Decoupled.scala:296:21, Plic.scala:174:26, RegisterRouter.scala:79:24
    maxDevs_0 <= _fanin_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_1 <= _fanin_1_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_2 <= _fanin_2_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_3 <= _fanin_3_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_4 <= _fanin_4_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_5 <= _fanin_5_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_6 <= _fanin_6_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_7 <= _fanin_7_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_8 <= _fanin_8_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_9 <= _fanin_9_io_dev;	// Plic.scala:181:22, :184:25
    maxDevs_10 <= _fanin_10_io_dev;	// Plic.scala:181:22, :184:25
    bundleOut_0_0_REG <= _fanin_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_1_0_REG <= _fanin_1_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_2_0_REG <= _fanin_2_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_3_0_REG <= _fanin_3_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_4_0_REG <= _fanin_4_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_5_0_REG <= _fanin_5_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_6_0_REG <= _fanin_6_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_7_0_REG <= _fanin_7_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_8_0_REG <= _fanin_8_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_9_0_REG <= _fanin_9_io_max;	// Plic.scala:184:25, :188:41
    bundleOut_10_0_REG <= _fanin_10_io_max;	// Plic.scala:184:25, :188:41
    if (reset)
      pending_0 <= 1'h0;	// Plic.scala:168:22
    else begin
      automatic logic claimedDevs_1;	// Plic.scala:246:96
      claimedDevs_1 =
        claimer_0 & maxDevs_0 | claimer_1 & maxDevs_1 | claimer_2 & maxDevs_2 | claimer_3
        & maxDevs_3 | claimer_4 & maxDevs_4 | claimer_5 & maxDevs_5 | claimer_6
        & maxDevs_6 | claimer_7 & maxDevs_7 | claimer_8 & maxDevs_8 | claimer_9
        & maxDevs_9 | claimer_10 & maxDevs_10;	// Plic.scala:181:22, :246:{49,96}, RegisterRouter.scala:79:24
      if (claimedDevs_1 | _gateways_gateway_io_plic_valid)	// Plic.scala:156:27, :246:96, :251:15
        pending_0 <= ~claimedDevs_1;	// Plic.scala:168:22, :246:96, :251:34
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
        priority_0 = _RANDOM[1'h0][0];	// Plic.scala:163:31
        threshold_0 = _RANDOM[1'h0][1];	// Plic.scala:163:31, :166:31
        threshold_1 = _RANDOM[1'h0][2];	// Plic.scala:163:31, :166:31
        threshold_2 = _RANDOM[1'h0][3];	// Plic.scala:163:31, :166:31
        threshold_3 = _RANDOM[1'h0][4];	// Plic.scala:163:31, :166:31
        threshold_4 = _RANDOM[1'h0][5];	// Plic.scala:163:31, :166:31
        threshold_5 = _RANDOM[1'h0][6];	// Plic.scala:163:31, :166:31
        threshold_6 = _RANDOM[1'h0][7];	// Plic.scala:163:31, :166:31
        threshold_7 = _RANDOM[1'h0][8];	// Plic.scala:163:31, :166:31
        threshold_8 = _RANDOM[1'h0][9];	// Plic.scala:163:31, :166:31
        threshold_9 = _RANDOM[1'h0][10];	// Plic.scala:163:31, :166:31
        threshold_10 = _RANDOM[1'h0][11];	// Plic.scala:163:31, :166:31
        pending_0 = _RANDOM[1'h0][12];	// Plic.scala:163:31, :168:22
        enables_0_0 = _RANDOM[1'h0][13];	// Plic.scala:163:31, :174:26
        enables_1_0 = _RANDOM[1'h0][14];	// Plic.scala:163:31, :174:26
        enables_2_0 = _RANDOM[1'h0][15];	// Plic.scala:163:31, :174:26
        enables_3_0 = _RANDOM[1'h0][16];	// Plic.scala:163:31, :174:26
        enables_4_0 = _RANDOM[1'h0][17];	// Plic.scala:163:31, :174:26
        enables_5_0 = _RANDOM[1'h0][18];	// Plic.scala:163:31, :174:26
        enables_6_0 = _RANDOM[1'h0][19];	// Plic.scala:163:31, :174:26
        enables_7_0 = _RANDOM[1'h0][20];	// Plic.scala:163:31, :174:26
        enables_8_0 = _RANDOM[1'h0][21];	// Plic.scala:163:31, :174:26
        enables_9_0 = _RANDOM[1'h0][22];	// Plic.scala:163:31, :174:26
        enables_10_0 = _RANDOM[1'h0][23];	// Plic.scala:163:31, :174:26
        maxDevs_0 = _RANDOM[1'h0][24];	// Plic.scala:163:31, :181:22
        maxDevs_1 = _RANDOM[1'h0][25];	// Plic.scala:163:31, :181:22
        maxDevs_2 = _RANDOM[1'h0][26];	// Plic.scala:163:31, :181:22
        maxDevs_3 = _RANDOM[1'h0][27];	// Plic.scala:163:31, :181:22
        maxDevs_4 = _RANDOM[1'h0][28];	// Plic.scala:163:31, :181:22
        maxDevs_5 = _RANDOM[1'h0][29];	// Plic.scala:163:31, :181:22
        maxDevs_6 = _RANDOM[1'h0][30];	// Plic.scala:163:31, :181:22
        maxDevs_7 = _RANDOM[1'h0][31];	// Plic.scala:163:31, :181:22
        maxDevs_8 = _RANDOM[1'h1][0];	// Plic.scala:181:22
        maxDevs_9 = _RANDOM[1'h1][1];	// Plic.scala:181:22
        maxDevs_10 = _RANDOM[1'h1][2];	// Plic.scala:181:22
        bundleOut_0_0_REG = _RANDOM[1'h1][3];	// Plic.scala:181:22, :188:41
        bundleOut_1_0_REG = _RANDOM[1'h1][4];	// Plic.scala:181:22, :188:41
        bundleOut_2_0_REG = _RANDOM[1'h1][5];	// Plic.scala:181:22, :188:41
        bundleOut_3_0_REG = _RANDOM[1'h1][6];	// Plic.scala:181:22, :188:41
        bundleOut_4_0_REG = _RANDOM[1'h1][7];	// Plic.scala:181:22, :188:41
        bundleOut_5_0_REG = _RANDOM[1'h1][8];	// Plic.scala:181:22, :188:41
        bundleOut_6_0_REG = _RANDOM[1'h1][9];	// Plic.scala:181:22, :188:41
        bundleOut_7_0_REG = _RANDOM[1'h1][10];	// Plic.scala:181:22, :188:41
        bundleOut_8_0_REG = _RANDOM[1'h1][11];	// Plic.scala:181:22, :188:41
        bundleOut_9_0_REG = _RANDOM[1'h1][12];	// Plic.scala:181:22, :188:41
        bundleOut_10_0_REG = _RANDOM[1'h1][13];	// Plic.scala:181:22, :188:41
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_68 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_out_back_io_enq_ready),	// Decoupled.scala:296:21
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (_out_back_io_deq_valid),	// Decoupled.scala:296:21
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (_out_back_io_deq_bits_extra_tlrr_extra_size),	// Decoupled.scala:296:21
    .io_in_d_bits_source  (_out_back_io_deq_bits_extra_tlrr_extra_source)	// Decoupled.scala:296:21
  );
  LevelGateway gateways_gateway (	// Plic.scala:156:27
    .clock            (clock),
    .reset            (reset),
    .io_interrupt     (auto_int_in_0),
    .io_plic_ready    (~pending_0),	// Plic.scala:168:22, :250:18
    .io_plic_complete
      ((completer_0 | completer_1 | completer_2 | completer_3 | completer_4 | completer_5
        | completer_6 | completer_7 | completer_8 | completer_9 | completer_10)
       & completerDev),	// Plic.scala:264:{28,48}, :295:35, RegisterRouter.scala:79:24, package.scala:154:13
    .io_plic_valid    (_gateways_gateway_io_plic_valid)
  );
  PLICFanIn fanin (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_0_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_io_dev),
    .io_max    (_fanin_io_max)
  );
  PLICFanIn fanin_1 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_1_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_1_io_dev),
    .io_max    (_fanin_1_io_max)
  );
  PLICFanIn fanin_2 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_2_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_2_io_dev),
    .io_max    (_fanin_2_io_max)
  );
  PLICFanIn fanin_3 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_3_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_3_io_dev),
    .io_max    (_fanin_3_io_max)
  );
  PLICFanIn fanin_4 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_4_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_4_io_dev),
    .io_max    (_fanin_4_io_max)
  );
  PLICFanIn fanin_5 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_5_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_5_io_dev),
    .io_max    (_fanin_5_io_max)
  );
  PLICFanIn fanin_6 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_6_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_6_io_dev),
    .io_max    (_fanin_6_io_max)
  );
  PLICFanIn fanin_7 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_7_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_7_io_dev),
    .io_max    (_fanin_7_io_max)
  );
  PLICFanIn fanin_8 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_8_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_8_io_dev),
    .io_max    (_fanin_8_io_max)
  );
  PLICFanIn fanin_9 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_9_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_9_io_dev),
    .io_max    (_fanin_9_io_max)
  );
  PLICFanIn fanin_10 (	// Plic.scala:184:25
    .io_prio_0 (priority_0),	// Plic.scala:163:31
    .io_ip     (enables_10_0 & pending_0),	// Plic.scala:168:22, :174:26, :186:40
    .io_dev    (_fanin_10_io_dev),
    .io_max    (_fanin_10_io_max)
  );
  Queue_74 out_back (	// Decoupled.scala:296:21
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (auto_in_a_valid),
    .io_enq_bits_read                    (auto_in_a_bits_opcode == 3'h4),	// RegisterRouter.scala:68:36
    .io_enq_bits_index                   (auto_in_a_bits_address[25:3]),	// Edges.scala:191:34, RegisterRouter.scala:69:19
    .io_enq_bits_data                    (auto_in_a_bits_data),
    .io_enq_bits_mask                    (auto_in_a_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source (auto_in_a_bits_source),
    .io_enq_bits_extra_tlrr_extra_size   (auto_in_a_bits_size),
    .io_deq_ready                        (auto_in_d_ready),
    .io_enq_ready                        (_out_back_io_enq_ready),
    .io_deq_valid                        (_out_back_io_deq_valid),
    .io_deq_bits_read                    (_out_back_io_deq_bits_read),
    .io_deq_bits_index                   (_out_back_io_deq_bits_index),
    .io_deq_bits_data                    (_out_back_io_deq_bits_data),
    .io_deq_bits_mask                    (_out_back_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source (_out_back_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size   (_out_back_io_deq_bits_extra_tlrr_extra_size)
  );
  assign auto_int_out_10_0 = bundleOut_10_0_REG > threshold_10;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_9_0 = bundleOut_9_0_REG > threshold_9;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_8_0 = bundleOut_8_0_REG > threshold_8;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_7_0 = bundleOut_7_0_REG > threshold_7;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_6_0 = bundleOut_6_0_REG > threshold_6;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_5_0 = bundleOut_5_0_REG > threshold_5;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_4_0 = bundleOut_4_0_REG > threshold_4;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_3_0 = bundleOut_3_0_REG > threshold_3;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_2_0 = bundleOut_2_0_REG > threshold_2;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_1_0 = bundleOut_1_0_REG > threshold_1;	// Plic.scala:166:31, :188:{41,63}
  assign auto_int_out_0_0 = bundleOut_0_0_REG > threshold_0;	// Plic.scala:166:31, :188:{41,63}
  assign auto_in_a_ready = _out_back_io_enq_ready;	// Decoupled.scala:296:21
  assign auto_in_d_valid = _out_back_io_deq_valid;	// Decoupled.scala:296:21
  assign auto_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_in_d_bits_size = _out_back_io_deq_bits_extra_tlrr_extra_size;	// Decoupled.scala:296:21
  assign auto_in_d_bits_source = _out_back_io_deq_bits_extra_tlrr_extra_source;	// Decoupled.scala:296:21
  assign auto_in_d_bits_data =
    ~(_out_out_bits_data_T_24 | out_oindex == 9'h10 | out_oindex == 9'h20
      | out_oindex == 9'h21 | out_oindex == 9'h22 | out_oindex == 9'h23
      | out_oindex == 9'h24 | out_oindex == 9'h25 | out_oindex == 9'h26
      | out_oindex == 9'h27 | out_oindex == 9'h28 | out_oindex == 9'h29
      | out_oindex == 9'h2A | out_oindex == 9'h100 | out_oindex == 9'h110
      | out_oindex == 9'h120 | out_oindex == 9'h130 | out_oindex == 9'h140
      | out_oindex == 9'h150 | out_oindex == 9'h160 | out_oindex == 9'h170
      | out_oindex == 9'h180 | out_oindex == 9'h190 | out_oindex == 9'h1A0) | _out_T_47
      ? (_out_out_bits_data_T_24
           ? {31'h0, priority_0, 32'h0}
           : out_oindex == 9'h10
               ? {62'h0, pending_0, 1'h0}
               : out_oindex == 9'h20
                   ? {62'h0, enables_0_0, 1'h0}
                   : out_oindex == 9'h21
                       ? {62'h0, enables_1_0, 1'h0}
                       : out_oindex == 9'h22
                           ? {62'h0, enables_2_0, 1'h0}
                           : out_oindex == 9'h23
                               ? {62'h0, enables_3_0, 1'h0}
                               : out_oindex == 9'h24
                                   ? {62'h0, enables_4_0, 1'h0}
                                   : out_oindex == 9'h25
                                       ? {62'h0, enables_5_0, 1'h0}
                                       : out_oindex == 9'h26
                                           ? {62'h0, enables_6_0, 1'h0}
                                           : out_oindex == 9'h27
                                               ? {62'h0, enables_7_0, 1'h0}
                                               : out_oindex == 9'h28
                                                   ? {62'h0, enables_8_0, 1'h0}
                                                   : out_oindex == 9'h29
                                                       ? {62'h0, enables_9_0, 1'h0}
                                                       : out_oindex == 9'h2A
                                                           ? {62'h0, enables_10_0, 1'h0}
                                                           : out_oindex == 9'h100
                                                               ? {31'h0,
                                                                  maxDevs_0,
                                                                  31'h0,
                                                                  threshold_0}
                                                               : out_oindex == 9'h110
                                                                   ? {31'h0,
                                                                      maxDevs_1,
                                                                      31'h0,
                                                                      threshold_1}
                                                                   : out_oindex == 9'h120
                                                                       ? {31'h0,
                                                                          maxDevs_2,
                                                                          31'h0,
                                                                          threshold_2}
                                                                       : out_oindex == 9'h130
                                                                           ? {31'h0,
                                                                              maxDevs_3,
                                                                              31'h0,
                                                                              threshold_3}
                                                                           : out_oindex == 9'h140
                                                                               ? {31'h0,
                                                                                  maxDevs_4,
                                                                                  31'h0,
                                                                                  threshold_4}
                                                                               : out_oindex == 9'h150
                                                                                   ? {31'h0,
                                                                                      maxDevs_5,
                                                                                      31'h0,
                                                                                      threshold_5}
                                                                                   : out_oindex == 9'h160
                                                                                       ? {31'h0,
                                                                                          maxDevs_6,
                                                                                          31'h0,
                                                                                          threshold_6}
                                                                                       : out_oindex == 9'h170
                                                                                           ? {31'h0,
                                                                                              maxDevs_7,
                                                                                              31'h0,
                                                                                              threshold_7}
                                                                                           : out_oindex == 9'h180
                                                                                               ? {31'h0,
                                                                                                  maxDevs_8,
                                                                                                  31'h0,
                                                                                                  threshold_8}
                                                                                               : out_oindex == 9'h190
                                                                                                   ? {31'h0,
                                                                                                      maxDevs_9,
                                                                                                      31'h0,
                                                                                                      threshold_9}
                                                                                                   : out_oindex == 9'h1A0
                                                                                                       ? {31'h0,
                                                                                                          maxDevs_10,
                                                                                                          31'h0,
                                                                                                          threshold_10}
                                                                                                       : 64'h0)
      : 64'h0;	// Cat.scala:30:58, Conditional.scala:37:30, :39:67, :40:58, MuxLiteral.scala:53:32, Plic.scala:163:31, :166:31, :168:22, :174:26, :181:22, RegisterRouter.scala:79:24
endmodule

