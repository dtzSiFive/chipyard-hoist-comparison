// Generated by CIRCT firtool-1.54.0-30-g7bb1650e3
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

module TLSerdesser(
  input         clock,
                reset,
                auto_manager_in_a_valid,
  input  [2:0]  auto_manager_in_a_bits_opcode,
                auto_manager_in_a_bits_param,
                auto_manager_in_a_bits_size,
  input  [3:0]  auto_manager_in_a_bits_source,
  input  [28:0] auto_manager_in_a_bits_address,
  input  [7:0]  auto_manager_in_a_bits_mask,
  input  [63:0] auto_manager_in_a_bits_data,
  input         auto_manager_in_a_bits_corrupt,
                auto_manager_in_d_ready,
                auto_client_out_a_ready,
                auto_client_out_d_valid,
  input  [2:0]  auto_client_out_d_bits_opcode,
  input  [1:0]  auto_client_out_d_bits_param,
  input  [3:0]  auto_client_out_d_bits_size,
  input         auto_client_out_d_bits_source,
  input  [2:0]  auto_client_out_d_bits_sink,
  input         auto_client_out_d_bits_denied,
  input  [63:0] auto_client_out_d_bits_data,
  input         auto_client_out_d_bits_corrupt,
                io_ser_in_valid,
  input  [3:0]  io_ser_in_bits,
  input         io_ser_out_ready,
  output        auto_manager_in_a_ready,
                auto_manager_in_d_valid,
  output [2:0]  auto_manager_in_d_bits_opcode,
  output [1:0]  auto_manager_in_d_bits_param,
  output [2:0]  auto_manager_in_d_bits_size,
  output [3:0]  auto_manager_in_d_bits_source,
  output        auto_manager_in_d_bits_sink,
                auto_manager_in_d_bits_denied,
  output [63:0] auto_manager_in_d_bits_data,
  output        auto_manager_in_d_bits_corrupt,
                auto_client_out_a_valid,
  output [2:0]  auto_client_out_a_bits_opcode,
                auto_client_out_a_bits_param,
  output [3:0]  auto_client_out_a_bits_size,
  output        auto_client_out_a_bits_source,
  output [31:0] auto_client_out_a_bits_address,
  output [7:0]  auto_client_out_a_bits_mask,
  output [63:0] auto_client_out_a_bits_data,
  output        auto_client_out_a_bits_corrupt,
                auto_client_out_d_ready,
                io_ser_in_ready,
                io_ser_out_valid,
  output [3:0]  io_ser_out_bits
);

  wire        _inDes_io_out_valid;	// Serdes.scala:629:23
  wire [2:0]  _inDes_io_out_bits_chanId;	// Serdes.scala:629:23
  wire [2:0]  _inDes_io_out_bits_opcode;	// Serdes.scala:629:23
  wire [2:0]  _inDes_io_out_bits_param;	// Serdes.scala:629:23
  wire [3:0]  _inDes_io_out_bits_size;	// Serdes.scala:629:23
  wire [3:0]  _inDes_io_out_bits_source;	// Serdes.scala:629:23
  wire [63:0] _inDes_io_out_bits_data;	// Serdes.scala:629:23
  wire        _inDes_io_out_bits_corrupt;	// Serdes.scala:629:23
  wire [7:0]  _inDes_io_out_bits_union;	// Serdes.scala:629:23
  wire        _outSer_io_in_ready;	// Serdes.scala:624:24
  wire        _outArb_io_in_1_ready;	// Serdes.scala:622:24
  wire        _outArb_io_in_4_ready;	// Serdes.scala:622:24
  wire        _outArb_io_out_valid;	// Serdes.scala:622:24
  wire [2:0]  _outArb_io_out_bits_chanId;	// Serdes.scala:622:24
  wire [2:0]  _outArb_io_out_bits_opcode;	// Serdes.scala:622:24
  wire [2:0]  _outArb_io_out_bits_param;	// Serdes.scala:622:24
  wire [3:0]  _outArb_io_out_bits_size;	// Serdes.scala:622:24
  wire [3:0]  _outArb_io_out_bits_source;	// Serdes.scala:622:24
  wire [31:0] _outArb_io_out_bits_address;	// Serdes.scala:622:24
  wire [63:0] _outArb_io_out_bits_data;	// Serdes.scala:622:24
  wire        _outArb_io_out_bits_corrupt;	// Serdes.scala:622:24
  wire [7:0]  _outArb_io_out_bits_union;	// Serdes.scala:622:24
  wire        _outArb_io_out_bits_last;	// Serdes.scala:622:24
  wire [26:0] _merged_bits_last_beats1_decode_T_1 =
    27'hFFF << auto_client_out_d_bits_size;	// package.scala:234:77
  reg  [8:0]  merged_bits_last_counter_1;	// Edges.scala:228:27
  wire [18:0] _merged_bits_last_beats1_decode_T_13 =
    19'hFFF << auto_manager_in_a_bits_size;	// package.scala:234:77
  reg  [8:0]  merged_bits_last_counter_4;	// Edges.scala:228:27
  wire        manager_tl_d_valid =
    _inDes_io_out_valid & _inDes_io_out_bits_chanId == 3'h3;	// Serdes.scala:239:37, :629:23, :637:46
  always @(posedge clock) begin
    if (reset) begin
      merged_bits_last_counter_1 <= 9'h0;	// Edges.scala:228:27
      merged_bits_last_counter_4 <= 9'h0;	// Edges.scala:228:27
    end
    else begin
      if (_outArb_io_in_1_ready & auto_client_out_d_valid) begin	// Decoupled.scala:40:37, Serdes.scala:622:24
        if (merged_bits_last_counter_1 == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (auto_client_out_d_bits_opcode[0])	// Edges.scala:105:36
            merged_bits_last_counter_1 <= ~(_merged_bits_last_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:105:36
            merged_bits_last_counter_1 <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          merged_bits_last_counter_1 <= merged_bits_last_counter_1 - 9'h1;	// Edges.scala:228:27, :229:28
      end
      if (_outArb_io_in_4_ready & auto_manager_in_a_valid) begin	// Decoupled.scala:40:37, Serdes.scala:622:24
        if (merged_bits_last_counter_4 == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (auto_manager_in_a_bits_opcode[2])	// Edges.scala:91:37
            merged_bits_last_counter_4 <= 9'h0;	// Edges.scala:228:27
          else	// Edges.scala:91:37
            merged_bits_last_counter_4 <= ~(_merged_bits_last_beats1_decode_T_13[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:230:25
          merged_bits_last_counter_4 <= merged_bits_last_counter_4 - 9'h1;	// Edges.scala:228:27, :229:28
      end
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
        merged_bits_last_counter_1 = _RANDOM[1'h0][17:9];	// Edges.scala:228:27
        merged_bits_last_counter_4 = _RANDOM[1'h1][12:4];	// Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_78 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_outArb_io_in_4_ready),	// Serdes.scala:622:24
    .io_in_a_valid        (auto_manager_in_a_valid),
    .io_in_a_bits_opcode  (auto_manager_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_manager_in_a_bits_param),
    .io_in_a_bits_size    (auto_manager_in_a_bits_size),
    .io_in_a_bits_source  (auto_manager_in_a_bits_source),
    .io_in_a_bits_address (auto_manager_in_a_bits_address),
    .io_in_a_bits_mask    (auto_manager_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_manager_in_a_bits_corrupt),
    .io_in_d_ready        (auto_manager_in_d_ready),
    .io_in_d_valid        (manager_tl_d_valid),	// Serdes.scala:637:46
    .io_in_d_bits_opcode  (_inDes_io_out_bits_opcode),	// Serdes.scala:629:23
    .io_in_d_bits_param   (_inDes_io_out_bits_param[1:0]),	// Serdes.scala:405:15, :629:23
    .io_in_d_bits_size    (_inDes_io_out_bits_size[2:0]),	// Serdes.scala:406:15, :629:23
    .io_in_d_bits_source  (_inDes_io_out_bits_source),	// Serdes.scala:629:23
    .io_in_d_bits_sink    (_inDes_io_out_bits_union[1]),	// Serdes.scala:468:17, :629:23
    .io_in_d_bits_denied  (_inDes_io_out_bits_union[0]),	// Serdes.scala:469:30, :629:23
    .io_in_d_bits_corrupt (_inDes_io_out_bits_corrupt)	// Serdes.scala:629:23
  );
  HellaPeekingArbiter outArb (	// Serdes.scala:622:24
    .clock                (clock),
    .reset                (reset),
    .io_in_1_valid        (auto_client_out_d_valid),
    .io_in_1_bits_opcode  (auto_client_out_d_bits_opcode),
    .io_in_1_bits_param   ({1'h0, auto_client_out_d_bits_param}),	// Serdes.scala:315:20
    .io_in_1_bits_size    (auto_client_out_d_bits_size),
    .io_in_1_bits_source  ({3'h0, auto_client_out_d_bits_source}),	// Serdes.scala:317:20
    .io_in_1_bits_data    (auto_client_out_d_bits_data),
    .io_in_1_bits_corrupt (auto_client_out_d_bits_corrupt),
    .io_in_1_bits_union
      ({4'h0, auto_client_out_d_bits_sink, auto_client_out_d_bits_denied}),	// Serdes.scala:322:22
    .io_in_1_bits_last
      (merged_bits_last_counter_1 == 9'h1
       | (auto_client_out_d_bits_opcode[0]
            ? ~(_merged_bits_last_beats1_decode_T_1[11:3])
            : 9'h0) == 9'h0),	// Edges.scala:105:36, :220:14, :228:27, :231:{25,37,47}, package.scala:234:{46,77,82}
    .io_in_4_valid        (auto_manager_in_a_valid),
    .io_in_4_bits_opcode  (auto_manager_in_a_bits_opcode),
    .io_in_4_bits_param   (auto_manager_in_a_bits_param),
    .io_in_4_bits_size    ({1'h0, auto_manager_in_a_bits_size}),	// Serdes.scala:259:20
    .io_in_4_bits_source  (auto_manager_in_a_bits_source),
    .io_in_4_bits_address ({3'h0, auto_manager_in_a_bits_address}),	// Serdes.scala:261:20, :317:20
    .io_in_4_bits_data    (auto_manager_in_a_bits_data),
    .io_in_4_bits_corrupt (auto_manager_in_a_bits_corrupt),
    .io_in_4_bits_union   (auto_manager_in_a_bits_mask),
    .io_in_4_bits_last
      (merged_bits_last_counter_4 == 9'h1
       | (auto_manager_in_a_bits_opcode[2]
            ? 9'h0
            : ~(_merged_bits_last_beats1_decode_T_13[11:3])) == 9'h0),	// Edges.scala:91:37, :220:14, :228:27, :231:{25,37,47}, package.scala:234:{46,77,82}
    .io_out_ready         (_outSer_io_in_ready),	// Serdes.scala:624:24
    .io_in_1_ready        (_outArb_io_in_1_ready),
    .io_in_4_ready        (_outArb_io_in_4_ready),
    .io_out_valid         (_outArb_io_out_valid),
    .io_out_bits_chanId   (_outArb_io_out_bits_chanId),
    .io_out_bits_opcode   (_outArb_io_out_bits_opcode),
    .io_out_bits_param    (_outArb_io_out_bits_param),
    .io_out_bits_size     (_outArb_io_out_bits_size),
    .io_out_bits_source   (_outArb_io_out_bits_source),
    .io_out_bits_address  (_outArb_io_out_bits_address),
    .io_out_bits_data     (_outArb_io_out_bits_data),
    .io_out_bits_corrupt  (_outArb_io_out_bits_corrupt),
    .io_out_bits_union    (_outArb_io_out_bits_union),
    .io_out_bits_last     (_outArb_io_out_bits_last)
  );
  GenericSerializer outSer (	// Serdes.scala:624:24
    .clock              (clock),
    .reset              (reset),
    .io_in_valid        (_outArb_io_out_valid),	// Serdes.scala:622:24
    .io_in_bits_chanId  (_outArb_io_out_bits_chanId),	// Serdes.scala:622:24
    .io_in_bits_opcode  (_outArb_io_out_bits_opcode),	// Serdes.scala:622:24
    .io_in_bits_param   (_outArb_io_out_bits_param),	// Serdes.scala:622:24
    .io_in_bits_size    (_outArb_io_out_bits_size),	// Serdes.scala:622:24
    .io_in_bits_source  (_outArb_io_out_bits_source),	// Serdes.scala:622:24
    .io_in_bits_address (_outArb_io_out_bits_address),	// Serdes.scala:622:24
    .io_in_bits_data    (_outArb_io_out_bits_data),	// Serdes.scala:622:24
    .io_in_bits_corrupt (_outArb_io_out_bits_corrupt),	// Serdes.scala:622:24
    .io_in_bits_union   (_outArb_io_out_bits_union),	// Serdes.scala:622:24
    .io_in_bits_last    (_outArb_io_out_bits_last),	// Serdes.scala:622:24
    .io_out_ready       (io_ser_out_ready),
    .io_in_ready        (_outSer_io_in_ready),
    .io_out_valid       (io_ser_out_valid),
    .io_out_bits        (io_ser_out_bits)
  );
  GenericDeserializer inDes (	// Serdes.scala:629:23
    .clock               (clock),
    .reset               (reset),
    .io_in_valid         (io_ser_in_valid),
    .io_in_bits          (io_ser_in_bits),
    .io_out_ready
      (_inDes_io_out_bits_chanId != 3'h4
       & (_inDes_io_out_bits_chanId == 3'h3
            ? auto_manager_in_d_ready
            : ~(_inDes_io_out_bits_chanId == 3'h2 | _inDes_io_out_bits_chanId == 3'h1)
              & ~(|_inDes_io_out_bits_chanId) & auto_client_out_a_ready)),	// Mux.scala:80:{57,60}, Serdes.scala:236:37, :239:37, :334:20, :629:23
    .io_in_ready         (io_ser_in_ready),
    .io_out_valid        (_inDes_io_out_valid),
    .io_out_bits_chanId  (_inDes_io_out_bits_chanId),
    .io_out_bits_opcode  (_inDes_io_out_bits_opcode),
    .io_out_bits_param   (_inDes_io_out_bits_param),
    .io_out_bits_size    (_inDes_io_out_bits_size),
    .io_out_bits_source  (_inDes_io_out_bits_source),
    .io_out_bits_address (auto_client_out_a_bits_address),
    .io_out_bits_data    (_inDes_io_out_bits_data),
    .io_out_bits_corrupt (_inDes_io_out_bits_corrupt),
    .io_out_bits_union   (_inDes_io_out_bits_union)
  );
  assign auto_manager_in_a_ready = _outArb_io_in_4_ready;	// Serdes.scala:622:24
  assign auto_manager_in_d_valid = manager_tl_d_valid;	// Serdes.scala:637:46
  assign auto_manager_in_d_bits_opcode = _inDes_io_out_bits_opcode;	// Serdes.scala:629:23
  assign auto_manager_in_d_bits_param = _inDes_io_out_bits_param[1:0];	// Serdes.scala:405:15, :629:23
  assign auto_manager_in_d_bits_size = _inDes_io_out_bits_size[2:0];	// Serdes.scala:406:15, :629:23
  assign auto_manager_in_d_bits_source = _inDes_io_out_bits_source;	// Serdes.scala:629:23
  assign auto_manager_in_d_bits_sink = _inDes_io_out_bits_union[1];	// Serdes.scala:468:17, :629:23
  assign auto_manager_in_d_bits_denied = _inDes_io_out_bits_union[0];	// Serdes.scala:469:30, :629:23
  assign auto_manager_in_d_bits_data = _inDes_io_out_bits_data;	// Serdes.scala:629:23
  assign auto_manager_in_d_bits_corrupt = _inDes_io_out_bits_corrupt;	// Serdes.scala:629:23
  assign auto_client_out_a_valid = _inDes_io_out_valid & ~(|_inDes_io_out_bits_chanId);	// Serdes.scala:236:37, :629:23, :631:45
  assign auto_client_out_a_bits_opcode = _inDes_io_out_bits_opcode;	// Serdes.scala:629:23
  assign auto_client_out_a_bits_param = _inDes_io_out_bits_param;	// Serdes.scala:629:23
  assign auto_client_out_a_bits_size = _inDes_io_out_bits_size;	// Serdes.scala:629:23
  assign auto_client_out_a_bits_source = _inDes_io_out_bits_source[0];	// Serdes.scala:378:15, :629:23
  assign auto_client_out_a_bits_mask = _inDes_io_out_bits_union;	// Serdes.scala:629:23
  assign auto_client_out_a_bits_data = _inDes_io_out_bits_data;	// Serdes.scala:629:23
  assign auto_client_out_a_bits_corrupt = _inDes_io_out_bits_corrupt;	// Serdes.scala:629:23
  assign auto_client_out_d_ready = _outArb_io_in_1_ready;	// Serdes.scala:622:24
endmodule

