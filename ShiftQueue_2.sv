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

module ShiftQueue_2(
  input         clock,
                reset,
                io_enq_valid,
                io_enq_bits_btb_bridx,
  input  [33:0] io_enq_bits_pc,
  input  [31:0] io_enq_bits_data,
  input         io_enq_bits_xcpt_pf_inst,
                io_enq_bits_xcpt_ae_inst,
                io_enq_bits_replay,
                io_deq_ready,
  output        io_enq_ready,
                io_deq_valid,
                io_deq_bits_btb_taken,
                io_deq_bits_btb_bridx,
  output [33:0] io_deq_bits_pc,
  output [31:0] io_deq_bits_data,
  output        io_deq_bits_xcpt_pf_inst,
                io_deq_bits_xcpt_ae_inst,
                io_deq_bits_replay,
  output [4:0]  io_mask
);

  reg        valid_0;	// ShiftQueue.scala:21:30
  reg        valid_1;	// ShiftQueue.scala:21:30
  reg        valid_2;	// ShiftQueue.scala:21:30
  reg        valid_3;	// ShiftQueue.scala:21:30
  reg        valid_4;	// ShiftQueue.scala:21:30
  reg        elts_0_btb_taken;	// ShiftQueue.scala:22:25
  reg        elts_0_btb_bridx;	// ShiftQueue.scala:22:25
  reg [33:0] elts_0_pc;	// ShiftQueue.scala:22:25
  reg [31:0] elts_0_data;	// ShiftQueue.scala:22:25
  reg        elts_0_xcpt_pf_inst;	// ShiftQueue.scala:22:25
  reg        elts_0_xcpt_ae_inst;	// ShiftQueue.scala:22:25
  reg        elts_0_replay;	// ShiftQueue.scala:22:25
  reg        elts_1_btb_taken;	// ShiftQueue.scala:22:25
  reg        elts_1_btb_bridx;	// ShiftQueue.scala:22:25
  reg [33:0] elts_1_pc;	// ShiftQueue.scala:22:25
  reg [31:0] elts_1_data;	// ShiftQueue.scala:22:25
  reg        elts_1_xcpt_pf_inst;	// ShiftQueue.scala:22:25
  reg        elts_1_xcpt_ae_inst;	// ShiftQueue.scala:22:25
  reg        elts_1_replay;	// ShiftQueue.scala:22:25
  reg        elts_2_btb_taken;	// ShiftQueue.scala:22:25
  reg        elts_2_btb_bridx;	// ShiftQueue.scala:22:25
  reg [33:0] elts_2_pc;	// ShiftQueue.scala:22:25
  reg [31:0] elts_2_data;	// ShiftQueue.scala:22:25
  reg        elts_2_xcpt_pf_inst;	// ShiftQueue.scala:22:25
  reg        elts_2_xcpt_ae_inst;	// ShiftQueue.scala:22:25
  reg        elts_2_replay;	// ShiftQueue.scala:22:25
  reg        elts_3_btb_taken;	// ShiftQueue.scala:22:25
  reg        elts_3_btb_bridx;	// ShiftQueue.scala:22:25
  reg [33:0] elts_3_pc;	// ShiftQueue.scala:22:25
  reg [31:0] elts_3_data;	// ShiftQueue.scala:22:25
  reg        elts_3_xcpt_pf_inst;	// ShiftQueue.scala:22:25
  reg        elts_3_xcpt_ae_inst;	// ShiftQueue.scala:22:25
  reg        elts_3_replay;	// ShiftQueue.scala:22:25
  reg        elts_4_btb_taken;	// ShiftQueue.scala:22:25
  reg        elts_4_btb_bridx;	// ShiftQueue.scala:22:25
  reg [33:0] elts_4_pc;	// ShiftQueue.scala:22:25
  reg [31:0] elts_4_data;	// ShiftQueue.scala:22:25
  reg        elts_4_xcpt_pf_inst;	// ShiftQueue.scala:22:25
  reg        elts_4_xcpt_ae_inst;	// ShiftQueue.scala:22:25
  reg        elts_4_replay;	// ShiftQueue.scala:22:25
  always @(posedge clock) begin
    automatic logic _valid_4_T_4;	// Decoupled.scala:40:37
    automatic logic wen_4;	// ShiftQueue.scala:29:10
    _valid_4_T_4 = ~valid_4 & io_enq_valid;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :31:48
    wen_4 = io_deq_ready ? _valid_4_T_4 & valid_4 : _valid_4_T_4 & valid_3 & ~valid_4;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :29:10, :30:45, :31:{45,48}
    if (reset) begin
      valid_0 <= 1'h0;	// ShiftQueue.scala:21:30
      valid_1 <= 1'h0;	// ShiftQueue.scala:21:30
      valid_2 <= 1'h0;	// ShiftQueue.scala:21:30
      valid_3 <= 1'h0;	// ShiftQueue.scala:21:30
      valid_4 <= 1'h0;	// ShiftQueue.scala:21:30
    end
    else if (io_deq_ready) begin
      valid_0 <= valid_1 | _valid_4_T_4 & valid_0;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :36:{28,45}
      valid_1 <= valid_2 | _valid_4_T_4 & valid_1;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :36:{28,45}
      valid_2 <= valid_3 | _valid_4_T_4 & valid_2;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :36:{28,45}
      valid_3 <= valid_4 | _valid_4_T_4 & valid_3;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :36:{28,45}
      valid_4 <= _valid_4_T_4 & valid_4;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :36:45
    end
    else begin
      valid_0 <= _valid_4_T_4 | valid_0;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :37:45
      valid_1 <= _valid_4_T_4 & valid_0 | valid_1;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :37:{25,45}
      valid_2 <= _valid_4_T_4 & valid_1 | valid_2;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :37:{25,45}
      valid_3 <= _valid_4_T_4 & valid_2 | valid_3;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :37:{25,45}
      valid_4 <= _valid_4_T_4 & valid_3 | valid_4;	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :37:{25,45}
    end
    if (io_deq_ready ? valid_1 | _valid_4_T_4 & valid_0 : _valid_4_T_4 & ~valid_0) begin	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :29:10, :30:{28,45}, :31:{45,48}
      elts_0_btb_taken <= valid_1 & elts_1_btb_taken;	// ShiftQueue.scala:21:30, :22:25, :27:57
      if (valid_1) begin	// ShiftQueue.scala:21:30
        elts_0_btb_bridx <= elts_1_btb_bridx;	// ShiftQueue.scala:22:25
        elts_0_pc <= elts_1_pc;	// ShiftQueue.scala:22:25
        elts_0_data <= elts_1_data;	// ShiftQueue.scala:22:25
        elts_0_xcpt_pf_inst <= elts_1_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_0_xcpt_ae_inst <= elts_1_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_0_replay <= elts_1_replay;	// ShiftQueue.scala:22:25
      end
      else begin	// ShiftQueue.scala:21:30
        elts_0_btb_bridx <= io_enq_bits_btb_bridx;	// ShiftQueue.scala:22:25
        elts_0_pc <= io_enq_bits_pc;	// ShiftQueue.scala:22:25
        elts_0_data <= io_enq_bits_data;	// ShiftQueue.scala:22:25
        elts_0_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_0_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_0_replay <= io_enq_bits_replay;	// ShiftQueue.scala:22:25
      end
    end
    if (io_deq_ready
          ? valid_2 | _valid_4_T_4 & valid_1
          : _valid_4_T_4 & valid_0 & ~valid_1) begin	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :29:10, :30:{28,45}, :31:{45,48}
      elts_1_btb_taken <= valid_2 & elts_2_btb_taken;	// ShiftQueue.scala:21:30, :22:25, :27:57
      if (valid_2) begin	// ShiftQueue.scala:21:30
        elts_1_btb_bridx <= elts_2_btb_bridx;	// ShiftQueue.scala:22:25
        elts_1_pc <= elts_2_pc;	// ShiftQueue.scala:22:25
        elts_1_data <= elts_2_data;	// ShiftQueue.scala:22:25
        elts_1_xcpt_pf_inst <= elts_2_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_1_xcpt_ae_inst <= elts_2_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_1_replay <= elts_2_replay;	// ShiftQueue.scala:22:25
      end
      else begin	// ShiftQueue.scala:21:30
        elts_1_btb_bridx <= io_enq_bits_btb_bridx;	// ShiftQueue.scala:22:25
        elts_1_pc <= io_enq_bits_pc;	// ShiftQueue.scala:22:25
        elts_1_data <= io_enq_bits_data;	// ShiftQueue.scala:22:25
        elts_1_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_1_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_1_replay <= io_enq_bits_replay;	// ShiftQueue.scala:22:25
      end
    end
    if (io_deq_ready
          ? valid_3 | _valid_4_T_4 & valid_2
          : _valid_4_T_4 & valid_1 & ~valid_2) begin	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :29:10, :30:{28,45}, :31:{45,48}
      elts_2_btb_taken <= valid_3 & elts_3_btb_taken;	// ShiftQueue.scala:21:30, :22:25, :27:57
      if (valid_3) begin	// ShiftQueue.scala:21:30
        elts_2_btb_bridx <= elts_3_btb_bridx;	// ShiftQueue.scala:22:25
        elts_2_pc <= elts_3_pc;	// ShiftQueue.scala:22:25
        elts_2_data <= elts_3_data;	// ShiftQueue.scala:22:25
        elts_2_xcpt_pf_inst <= elts_3_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_2_xcpt_ae_inst <= elts_3_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_2_replay <= elts_3_replay;	// ShiftQueue.scala:22:25
      end
      else begin	// ShiftQueue.scala:21:30
        elts_2_btb_bridx <= io_enq_bits_btb_bridx;	// ShiftQueue.scala:22:25
        elts_2_pc <= io_enq_bits_pc;	// ShiftQueue.scala:22:25
        elts_2_data <= io_enq_bits_data;	// ShiftQueue.scala:22:25
        elts_2_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_2_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_2_replay <= io_enq_bits_replay;	// ShiftQueue.scala:22:25
      end
    end
    if (io_deq_ready
          ? valid_4 | _valid_4_T_4 & valid_3
          : _valid_4_T_4 & valid_2 & ~valid_3) begin	// Decoupled.scala:40:37, ShiftQueue.scala:21:30, :29:10, :30:{28,45}, :31:{45,48}
      elts_3_btb_taken <= valid_4 & elts_4_btb_taken;	// ShiftQueue.scala:21:30, :22:25, :27:57
      if (valid_4) begin	// ShiftQueue.scala:21:30
        elts_3_btb_bridx <= elts_4_btb_bridx;	// ShiftQueue.scala:22:25
        elts_3_pc <= elts_4_pc;	// ShiftQueue.scala:22:25
        elts_3_data <= elts_4_data;	// ShiftQueue.scala:22:25
        elts_3_xcpt_pf_inst <= elts_4_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_3_xcpt_ae_inst <= elts_4_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_3_replay <= elts_4_replay;	// ShiftQueue.scala:22:25
      end
      else begin	// ShiftQueue.scala:21:30
        elts_3_btb_bridx <= io_enq_bits_btb_bridx;	// ShiftQueue.scala:22:25
        elts_3_pc <= io_enq_bits_pc;	// ShiftQueue.scala:22:25
        elts_3_data <= io_enq_bits_data;	// ShiftQueue.scala:22:25
        elts_3_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:22:25
        elts_3_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:22:25
        elts_3_replay <= io_enq_bits_replay;	// ShiftQueue.scala:22:25
      end
    end
    elts_4_btb_taken <= ~wen_4 & elts_4_btb_taken;	// ShiftQueue.scala:22:25, :29:10, :32:{16,26}
    if (wen_4) begin	// ShiftQueue.scala:29:10
      elts_4_btb_bridx <= io_enq_bits_btb_bridx;	// ShiftQueue.scala:22:25
      elts_4_pc <= io_enq_bits_pc;	// ShiftQueue.scala:22:25
      elts_4_data <= io_enq_bits_data;	// ShiftQueue.scala:22:25
      elts_4_xcpt_pf_inst <= io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:22:25
      elts_4_xcpt_ae_inst <= io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:22:25
      elts_4_replay <= io_enq_bits_replay;	// ShiftQueue.scala:22:25
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:18];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h13; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        valid_0 = _RANDOM[5'h0][0];	// ShiftQueue.scala:21:30
        valid_1 = _RANDOM[5'h0][1];	// ShiftQueue.scala:21:30
        valid_2 = _RANDOM[5'h0][2];	// ShiftQueue.scala:21:30
        valid_3 = _RANDOM[5'h0][3];	// ShiftQueue.scala:21:30
        valid_4 = _RANDOM[5'h0][4];	// ShiftQueue.scala:21:30
        elts_0_btb_taken = _RANDOM[5'h0][7];	// ShiftQueue.scala:21:30, :22:25
        elts_0_btb_bridx = _RANDOM[5'h0][10];	// ShiftQueue.scala:21:30, :22:25
        elts_0_pc = {_RANDOM[5'h1][31:22], _RANDOM[5'h2][23:0]};	// ShiftQueue.scala:22:25
        elts_0_data = {_RANDOM[5'h2][31:24], _RANDOM[5'h3][23:0]};	// ShiftQueue.scala:22:25
        elts_0_xcpt_pf_inst = _RANDOM[5'h3][26];	// ShiftQueue.scala:22:25
        elts_0_xcpt_ae_inst = _RANDOM[5'h3][27];	// ShiftQueue.scala:22:25
        elts_0_replay = _RANDOM[5'h3][28];	// ShiftQueue.scala:22:25
        elts_1_btb_taken = _RANDOM[5'h3][31];	// ShiftQueue.scala:22:25
        elts_1_btb_bridx = _RANDOM[5'h4][2];	// ShiftQueue.scala:22:25
        elts_1_pc = {_RANDOM[5'h5][31:14], _RANDOM[5'h6][15:0]};	// ShiftQueue.scala:22:25
        elts_1_data = {_RANDOM[5'h6][31:16], _RANDOM[5'h7][15:0]};	// ShiftQueue.scala:22:25
        elts_1_xcpt_pf_inst = _RANDOM[5'h7][18];	// ShiftQueue.scala:22:25
        elts_1_xcpt_ae_inst = _RANDOM[5'h7][19];	// ShiftQueue.scala:22:25
        elts_1_replay = _RANDOM[5'h7][20];	// ShiftQueue.scala:22:25
        elts_2_btb_taken = _RANDOM[5'h7][23];	// ShiftQueue.scala:22:25
        elts_2_btb_bridx = _RANDOM[5'h7][26];	// ShiftQueue.scala:22:25
        elts_2_pc = {_RANDOM[5'h9][31:6], _RANDOM[5'hA][7:0]};	// ShiftQueue.scala:22:25
        elts_2_data = {_RANDOM[5'hA][31:8], _RANDOM[5'hB][7:0]};	// ShiftQueue.scala:22:25
        elts_2_xcpt_pf_inst = _RANDOM[5'hB][10];	// ShiftQueue.scala:22:25
        elts_2_xcpt_ae_inst = _RANDOM[5'hB][11];	// ShiftQueue.scala:22:25
        elts_2_replay = _RANDOM[5'hB][12];	// ShiftQueue.scala:22:25
        elts_3_btb_taken = _RANDOM[5'hB][15];	// ShiftQueue.scala:22:25
        elts_3_btb_bridx = _RANDOM[5'hB][18];	// ShiftQueue.scala:22:25
        elts_3_pc = {_RANDOM[5'hC][31:30], _RANDOM[5'hD]};	// ShiftQueue.scala:22:25
        elts_3_data = _RANDOM[5'hE];	// ShiftQueue.scala:22:25
        elts_3_xcpt_pf_inst = _RANDOM[5'hF][2];	// ShiftQueue.scala:22:25
        elts_3_xcpt_ae_inst = _RANDOM[5'hF][3];	// ShiftQueue.scala:22:25
        elts_3_replay = _RANDOM[5'hF][4];	// ShiftQueue.scala:22:25
        elts_4_btb_taken = _RANDOM[5'hF][7];	// ShiftQueue.scala:22:25
        elts_4_btb_bridx = _RANDOM[5'hF][10];	// ShiftQueue.scala:22:25
        elts_4_pc = {_RANDOM[5'h10][31:22], _RANDOM[5'h11][23:0]};	// ShiftQueue.scala:22:25
        elts_4_data = {_RANDOM[5'h11][31:24], _RANDOM[5'h12][23:0]};	// ShiftQueue.scala:22:25
        elts_4_xcpt_pf_inst = _RANDOM[5'h12][26];	// ShiftQueue.scala:22:25
        elts_4_xcpt_ae_inst = _RANDOM[5'h12][27];	// ShiftQueue.scala:22:25
        elts_4_replay = _RANDOM[5'h12][28];	// ShiftQueue.scala:22:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~valid_4;	// ShiftQueue.scala:21:30, :31:48
  assign io_deq_valid = io_enq_valid | valid_0;	// ShiftQueue.scala:21:30, :41:16, :45:{25,40}
  assign io_deq_bits_btb_taken = valid_0 & elts_0_btb_taken;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_btb_bridx = valid_0 ? elts_0_btb_bridx : io_enq_bits_btb_bridx;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_pc = valid_0 ? elts_0_pc : io_enq_bits_pc;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_data = valid_0 ? elts_0_data : io_enq_bits_data;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_xcpt_pf_inst =
    valid_0 ? elts_0_xcpt_pf_inst : io_enq_bits_xcpt_pf_inst;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_xcpt_ae_inst =
    valid_0 ? elts_0_xcpt_ae_inst : io_enq_bits_xcpt_ae_inst;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_deq_bits_replay = valid_0 ? elts_0_replay : io_enq_bits_replay;	// ShiftQueue.scala:21:30, :22:25, :42:15, :46:{22,36}
  assign io_mask = {valid_4, valid_3, valid_2, valid_1, valid_0};	// ShiftQueue.scala:21:30, :53:20
endmodule

