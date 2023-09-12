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

module MSHR(
  input         clock,
                reset,
                io_allocate_valid,
                io_allocate_bits_prio_0,
                io_allocate_bits_prio_1,
                io_allocate_bits_prio_2,
                io_allocate_bits_control,
  input  [2:0]  io_allocate_bits_opcode,
                io_allocate_bits_param,
                io_allocate_bits_size,
  input  [6:0]  io_allocate_bits_source,
  input  [12:0] io_allocate_bits_tag,
  input  [5:0]  io_allocate_bits_offset,
                io_allocate_bits_put,
  input  [9:0]  io_allocate_bits_set,
  input         io_allocate_bits_repeat,
                io_directory_valid,
                io_directory_bits_dirty,
  input  [1:0]  io_directory_bits_state,
  input  [5:0]  io_directory_bits_clients,
  input  [12:0] io_directory_bits_tag,
  input         io_directory_bits_hit,
  input  [2:0]  io_directory_bits_way,
  input         io_schedule_ready,
                io_sinkc_valid,
                io_sinkc_bits_last,
  input  [12:0] io_sinkc_bits_tag,
  input  [6:0]  io_sinkc_bits_source,
  input  [2:0]  io_sinkc_bits_param,
  input         io_sinkc_bits_data,
                io_sinkd_valid,
                io_sinkd_bits_last,
  input  [2:0]  io_sinkd_bits_opcode,
                io_sinkd_bits_param,
                io_sinkd_bits_sink,
  input         io_sinkd_bits_denied,
                io_sinke_valid,
  input  [9:0]  io_nestedwb_set,
  input  [12:0] io_nestedwb_tag,
  input         io_nestedwb_b_toN,
                io_nestedwb_b_toB,
                io_nestedwb_b_clr_dirty,
                io_nestedwb_c_set_dirty,
  output        io_status_valid,
  output [9:0]  io_status_bits_set,
  output [12:0] io_status_bits_tag,
  output [2:0]  io_status_bits_way,
  output        io_status_bits_blockC,
                io_status_bits_nestC,
                io_schedule_valid,
                io_schedule_bits_a_valid,
  output [12:0] io_schedule_bits_a_bits_tag,
  output [9:0]  io_schedule_bits_a_bits_set,
  output [2:0]  io_schedule_bits_a_bits_param,
  output        io_schedule_bits_a_bits_block,
                io_schedule_bits_b_valid,
  output [2:0]  io_schedule_bits_b_bits_param,
  output [12:0] io_schedule_bits_b_bits_tag,
  output [9:0]  io_schedule_bits_b_bits_set,
  output [5:0]  io_schedule_bits_b_bits_clients,
  output        io_schedule_bits_c_valid,
  output [2:0]  io_schedule_bits_c_bits_opcode,
                io_schedule_bits_c_bits_param,
  output [12:0] io_schedule_bits_c_bits_tag,
  output [9:0]  io_schedule_bits_c_bits_set,
  output [2:0]  io_schedule_bits_c_bits_way,
  output        io_schedule_bits_c_bits_dirty,
                io_schedule_bits_d_valid,
                io_schedule_bits_d_bits_prio_0,
                io_schedule_bits_d_bits_prio_2,
  output [2:0]  io_schedule_bits_d_bits_opcode,
                io_schedule_bits_d_bits_param,
                io_schedule_bits_d_bits_size,
  output [6:0]  io_schedule_bits_d_bits_source,
  output [5:0]  io_schedule_bits_d_bits_offset,
                io_schedule_bits_d_bits_put,
  output [9:0]  io_schedule_bits_d_bits_set,
  output [2:0]  io_schedule_bits_d_bits_way,
  output        io_schedule_bits_d_bits_bad,
                io_schedule_bits_e_valid,
  output [2:0]  io_schedule_bits_e_bits_sink,
  output        io_schedule_bits_x_valid,
                io_schedule_bits_dir_valid,
  output [9:0]  io_schedule_bits_dir_bits_set,
  output [2:0]  io_schedule_bits_dir_bits_way,
  output        io_schedule_bits_dir_bits_data_dirty,
  output [1:0]  io_schedule_bits_dir_bits_data_state,
  output [5:0]  io_schedule_bits_dir_bits_data_clients,
  output [12:0] io_schedule_bits_dir_bits_data_tag,
  output        io_schedule_bits_reload
);

  reg         request_valid;	// MSHR.scala:94:30
  reg         request_prio_0;	// MSHR.scala:95:20
  reg         request_prio_1;	// MSHR.scala:95:20
  reg         request_prio_2;	// MSHR.scala:95:20
  reg         request_control;	// MSHR.scala:95:20
  reg  [2:0]  request_opcode;	// MSHR.scala:95:20
  reg  [2:0]  request_param;	// MSHR.scala:95:20
  reg  [2:0]  request_size;	// MSHR.scala:95:20
  reg  [6:0]  request_source;	// MSHR.scala:95:20
  reg  [12:0] request_tag;	// MSHR.scala:95:20
  reg  [5:0]  request_offset;	// MSHR.scala:95:20
  reg  [5:0]  request_put;	// MSHR.scala:95:20
  reg  [9:0]  request_set;	// MSHR.scala:95:20
  reg         meta_valid;	// MSHR.scala:96:27
  reg         meta_dirty;	// MSHR.scala:97:17
  reg  [1:0]  meta_state;	// MSHR.scala:97:17
  reg  [5:0]  meta_clients;	// MSHR.scala:97:17
  reg  [12:0] meta_tag;	// MSHR.scala:97:17
  reg         meta_hit;	// MSHR.scala:97:17
  reg  [2:0]  meta_way;	// MSHR.scala:97:17
  reg         s_rprobe;	// MSHR.scala:118:33
  reg         w_rprobeackfirst;	// MSHR.scala:119:33
  reg         w_rprobeacklast;	// MSHR.scala:120:33
  reg         s_release;	// MSHR.scala:121:33
  reg         w_releaseack;	// MSHR.scala:122:33
  reg         s_pprobe;	// MSHR.scala:123:33
  reg         s_acquire;	// MSHR.scala:124:33
  reg         s_flush;	// MSHR.scala:125:33
  reg         w_grantfirst;	// MSHR.scala:126:33
  reg         w_grantlast;	// MSHR.scala:127:33
  reg         w_grant;	// MSHR.scala:128:33
  reg         w_pprobeackfirst;	// MSHR.scala:129:33
  reg         w_pprobeacklast;	// MSHR.scala:130:33
  reg         w_pprobeack;	// MSHR.scala:131:33
  reg         s_grantack;	// MSHR.scala:133:33
  reg         s_execute;	// MSHR.scala:134:33
  reg         w_grantack;	// MSHR.scala:135:33
  reg         s_writeback;	// MSHR.scala:136:33
  reg  [2:0]  sink;	// MSHR.scala:144:17
  reg         gotT;	// MSHR.scala:145:17
  reg         bad_grant;	// MSHR.scala:146:22
  reg  [5:0]  probes_done;	// MSHR.scala:147:24
  reg  [5:0]  probes_toN;	// MSHR.scala:148:23
  wire        _io_status_bits_nestC_output =
    meta_valid & (~w_rprobeackfirst | ~w_pprobeackfirst | ~w_grantfirst);	// MSHR.scala:96:27, :119:33, :126:33, :129:33, :165:103, :170:{39,43,64,82}
  wire        no_wait =
    w_rprobeacklast & w_releaseack & w_grantlast & w_pprobeacklast & w_grantack;	// MSHR.scala:120:33, :122:33, :127:33, :130:33, :135:33, :180:83
  wire        _io_schedule_bits_a_valid_output = ~s_acquire & s_release & s_pprobe;	// MSHR.scala:121:33, :123:33, :124:33, :181:{31,55}
  wire        _io_schedule_bits_b_valid_output = ~s_rprobe | ~s_pprobe;	// MSHR.scala:118:33, :123:33, :182:{31,41,44}
  wire        _io_schedule_bits_c_valid_output = ~s_release & w_rprobeackfirst;	// MSHR.scala:119:33, :121:33, :183:{32,43}
  wire        _io_schedule_bits_d_valid_output = ~s_execute & w_pprobeack & w_grant;	// MSHR.scala:128:33, :131:33, :134:33, :184:{31,57}
  wire        _io_schedule_bits_e_valid_output = ~s_grantack & w_grantfirst;	// MSHR.scala:126:33, :133:33, :185:{31,43}
  wire        _io_schedule_bits_x_valid_output = ~s_flush & w_releaseack;	// MSHR.scala:122:33, :125:33, :186:{31,40}
  wire        _io_schedule_bits_dir_valid_output =
    ~s_release & w_rprobeackfirst | ~s_writeback & no_wait;	// MSHR.scala:119:33, :121:33, :136:33, :180:83, :183:32, :187:{45,66,70,83}
  wire        _io_schedule_valid_output =
    _io_schedule_bits_a_valid_output | _io_schedule_bits_b_valid_output
    | _io_schedule_bits_c_valid_output | _io_schedule_bits_d_valid_output
    | _io_schedule_bits_e_valid_output | _io_schedule_bits_x_valid_output
    | _io_schedule_bits_dir_valid_output;	// MSHR.scala:181:55, :182:41, :183:43, :184:57, :185:43, :186:40, :187:66, :190:105
  wire [5:0]  req_clientBit =
    {request_source[6:2] == 5'hC & request_source[1:0] != 2'h3,
     request_source[6:3] == 4'h4 & request_source[2:0] < 3'h5,
     request_source[6:4] == 3'h0 & request_source[3:0] < 4'h9,
     request_source == 7'h38,
     request_source == 7'h3C,
     request_source == 7'h40};	// Cat.scala:30:58, MSHR.scala:95:20, Parameters.scala:46:9, :52:64, :54:{10,32}, :56:50, :57:20, :266:13
  wire        _excluded_client_T_1 = request_opcode == 3'h6;	// MSHR.scala:95:20, Parameters.scala:267:14
  wire        req_needT =
    ~(request_opcode[2]) | request_opcode == 3'h5 & request_param == 3'h1
    | (_excluded_client_T_1 | (&request_opcode)) & (|request_param);	// MSHR.scala:95:20, Parameters.scala:265:{5,12}, :266:{13,33,42,70}, :267:{14,42,52,80,89}
  wire        req_acquire = _excluded_client_T_1 | (&request_opcode);	// MSHR.scala:95:20, :216:53, Parameters.scala:267:{14,52}
  wire        _final_meta_writeback_state_T_2 =
    request_param != 3'h3 & meta_state == 2'h2;	// MSHR.scala:95:20, :97:17, :222:{55,64,78}
  wire [5:0]  _final_meta_writeback_clients_T_7 =
    meta_clients
    & ~(request_param == 3'h1 | request_param == 3'h2 | request_param == 3'h5
          ? req_clientBit
          : 6'h0);	// Cat.scala:30:58, MSHR.scala:95:20, :97:17, :223:{50,52,56}, Parameters.scala:266:13, :278:{11,43,66,75}
  wire [5:0]  _GEN = ({6{~meta_hit}} | ~probes_toN) & meta_clients;	// MSHR.scala:97:17, :148:23, :226:21, :227:36, :229:{36,54}
  wire [1:0]  _final_meta_writeback_state_T_6 = {1'h1, ~req_acquire};	// MSHR.scala:102:14, :216:53, :235:40
  wire [1:0]  _final_meta_writeback_state_T_9 = {1'h1, ~(~(|meta_clients) & req_acquire)};	// MSHR.scala:97:17, :102:14, :216:53, :217:{25,39}, :241:{55,72}
  wire [1:0]  _final_meta_writeback_state_T_13 = {meta_state == 2'h2, 1'h1};	// MSHR.scala:97:17, :102:14, Mux.scala:80:{57,60}
  wire [5:0]  _final_meta_writeback_clients_T_14 =
    (meta_hit ? meta_clients & ~probes_toN : 6'h0) | (req_acquire ? req_clientBit : 6'h0);	// Cat.scala:30:58, MSHR.scala:97:17, :148:23, :216:53, :223:56, :242:{40,64,66,88}, :243:40
  wire        _GEN_0 = request_prio_2 | request_control;	// MSHR.scala:95:20, :220:54, :225:57, :244:30
  wire        _GEN_1 = request_prio_2 | ~request_control;	// MSHR.scala:94:30, :95:20, :102:14, :220:54, :224:34, :225:57, :231:30, :245:30
  wire [5:0]  _final_meta_writeback_clients_T_16 = meta_clients & ~probes_toN;	// MSHR.scala:97:17, :148:23, :255:{52,54}
  wire        _io_schedule_bits_dir_bits_data_WIRE_dirty =
    ~bad_grant
    & (request_prio_2
         ? meta_dirty | request_opcode[0]
         : request_control
             ? ~meta_hit & meta_dirty
             : meta_hit & meta_dirty | ~(request_opcode[2]));	// MSHR.scala:95:20, :97:17, :146:22, :220:54, :221:{34,48,65}, :225:57, :226:21, :227:36, :233:{32,45,60,63}, :248:20, :249:21, Parameters.scala:265:12
  wire [1:0]  _GEN_2 = {1'h0, meta_hit};	// MSHR.scala:94:30, :97:17, :249:21, :254:36, :260:36
  wire [1:0]  _io_schedule_bits_dir_bits_data_WIRE_state =
    bad_grant
      ? _GEN_2
      : request_prio_2
          ? (_final_meta_writeback_state_T_2 ? 2'h3 : meta_state)
          : request_control
              ? (meta_hit ? 2'h0 : meta_state)
              : req_needT
                  ? _final_meta_writeback_state_T_6
                  : meta_hit
                      ? ((&meta_state)
                           ? _final_meta_writeback_state_T_9
                           : _final_meta_writeback_state_T_13)
                      : gotT ? _final_meta_writeback_state_T_6 : 2'h1;	// MSHR.scala:95:20, :97:17, :145:17, :146:22, :220:54, :222:{34,40,64}, :225:57, :226:21, :228:36, :234:{32,38}, :235:40, :236:{40,55}, :241:55, :248:20, :249:21, :254:36, :260:36, Mux.scala:80:{57,60}, Parameters.scala:266:70
  wire [5:0]  _io_schedule_bits_dir_bits_data_WIRE_clients =
    bad_grant
      ? (meta_hit ? _final_meta_writeback_clients_T_16 : 6'h0)
      : request_prio_2
          ? _final_meta_writeback_clients_T_7
          : request_control ? _GEN : _final_meta_writeback_clients_T_14;	// MSHR.scala:95:20, :97:17, :146:22, :220:54, :223:{34,50,56}, :225:57, :226:21, :229:36, :242:{34,88}, :248:20, :249:21, :255:{36,52}, :261:36
  wire [5:0]  excluded_client =
    meta_hit & request_prio_0
    & (_excluded_client_T_1 | (&request_opcode) | request_opcode == 3'h4)
      ? req_clientBit
      : 6'h0;	// Cat.scala:30:58, MSHR.scala:95:20, :97:17, :223:56, :276:{28,57}, Parameters.scala:267:{14,52}, :275:{77,87}
  wire        _new_meta_T = io_allocate_valid & io_allocate_bits_repeat;	// MSHR.scala:502:40
  wire        new_meta_hit =
    _new_meta_T ? (bad_grant ? meta_hit : _GEN_1) : io_directory_bits_hit;	// MSHR.scala:97:17, :146:22, :220:54, :224:34, :225:57, :248:20, :249:21, :502:{21,40}
  wire        new_request_prio_2 =
    io_allocate_valid ? io_allocate_bits_prio_2 : request_prio_2;	// MSHR.scala:95:20, :503:24
  wire        _GEN_3 = io_directory_valid | _new_meta_T;	// MSHR.scala:502:40, :536:28
  `ifndef SYNTHESIS	// MSHR.scala:102:14
    always @(posedge clock) begin	// MSHR.scala:102:14
      automatic logic            _GEN_4;	// MSHR.scala:101:35
      automatic logic            _GEN_5;	// MSHR.scala:103:14
      automatic logic            _GEN_6;	// MSHR.scala:105:22
      automatic logic            _GEN_7;	// MSHR.scala:108:33
      automatic logic [3:0][3:0] _GEN_8;	// Conditional.scala:37:30, :39:67, :40:58, MSHR.scala:315:26, :316:26, :317:26
      automatic logic [3:0]      before_0;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}
      automatic logic [3:0][3:0] _GEN_9 =
        {{{2'h1,
           ~(|_io_schedule_bits_dir_bits_data_WIRE_clients),
           ~_io_schedule_bits_dir_bits_data_WIRE_dirty}},
         {{3'h1, ~_io_schedule_bits_dir_bits_data_WIRE_dirty}},
         {{3'h0, ~(|_io_schedule_bits_dir_bits_data_WIRE_clients)}},
         {4'h8}};	// Conditional.scala:37:30, :39:67, :40:58, MSHR.scala:94:30, :102:14, :220:54, :248:20, :249:21, :312:27, :315:{26,32}, :316:{26,32}, :317:{26,32}, Parameters.scala:57:20
      automatic logic [3:0]      after =
        _GEN_9[_io_schedule_bits_dir_bits_data_WIRE_state];	// Conditional.scala:37:30, :39:67, :40:58, MSHR.scala:220:54, :248:20, :249:21, :315:26, :316:26, :317:26
      automatic logic            _GEN_10;	// MSHR.scala:371:35
      automatic logic            _GEN_11;	// MSHR.scala:372:15
      automatic logic            _GEN_12 = after == 4'h1;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :372:15
      automatic logic            _GEN_13 = after == 4'h0;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :373:15
      automatic logic            _GEN_14 = after == 4'h7;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :374:15
      automatic logic            _GEN_15 = after == 4'h5;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :375:15
      automatic logic            _GEN_16 = after == 4'h4;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :376:15, Parameters.scala:54:32
      automatic logic            _GEN_17 = after == 4'h3;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :378:15
      automatic logic            _GEN_18 = after == 4'h2;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :379:15
      automatic logic            _GEN_19;	// MSHR.scala:381:15
      automatic logic            _GEN_20 = after == 4'h8;	// Conditional.scala:39:67, :40:58, MSHR.scala:315:26, :381:15, Parameters.scala:57:20
      automatic logic            _GEN_21;	// MSHR.scala:390:15
      automatic logic            _GEN_22;	// MSHR.scala:399:15
      automatic logic            _GEN_23;	// MSHR.scala:408:15
      automatic logic            _GEN_24;	// MSHR.scala:417:15
      automatic logic            _GEN_25;	// MSHR.scala:426:15
      automatic logic            _GEN_26;	// MSHR.scala:435:15
      automatic logic            _GEN_27;	// MSHR.scala:444:15
      _GEN_4 = meta_valid & ~(|meta_state);	// MSHR.scala:96:27, :97:17, :101:{22,35}
      _GEN_5 = ~meta_dirty | reset;	// MSHR.scala:97:17, :103:{14,15}
      _GEN_6 = meta_state == 2'h1;	// MSHR.scala:97:17, :105:22
      _GEN_7 = meta_valid & meta_state == 2'h2;	// MSHR.scala:96:27, :97:17, :108:{22,33}
      _GEN_8 =
        {{{2'h1, ~(|meta_clients), ~meta_dirty}},
         {{3'h1, ~meta_dirty}},
         {{3'h0, ~(|meta_clients)}},
         {4'h8}};	// Conditional.scala:37:30, :39:67, :40:58, MSHR.scala:94:30, :97:17, :102:14, :217:39, :315:{26,32}, :316:{26,32}, :317:{26,32}, Parameters.scala:57:20
      before_0 = meta_hit ? _GEN_8[meta_state] : 4'h8;	// Conditional.scala:37:30, :39:67, :40:58, MSHR.scala:97:17, :315:26, :316:26, :317:26, :320:{17,23}, Parameters.scala:57:20
      _GEN_10 = ~s_writeback & no_wait & io_schedule_ready;	// MSHR.scala:136:33, :180:83, :187:70, :371:35
      _GEN_11 = before_0 == 4'h8;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :372:15, Parameters.scala:57:20
      _GEN_19 = before_0 == 4'h1;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :372:15, :381:15
      _GEN_21 = before_0 == 4'h0;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :373:15, :390:15
      _GEN_22 = before_0 == 4'h7;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :374:15, :399:15
      _GEN_23 = before_0 == 4'h5;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :375:15, :408:15
      _GEN_24 = before_0 == 4'h6;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :417:15
      _GEN_25 = before_0 == 4'h4;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :426:15, Parameters.scala:54:32
      _GEN_26 = before_0 == 4'h3;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :378:15, :435:15
      _GEN_27 = before_0 == 4'h2;	// Conditional.scala:40:58, MSHR.scala:320:{17,23}, :379:15, :444:15
      if (_GEN_4 & ~(~(|meta_clients) | reset)) begin	// MSHR.scala:97:17, :101:35, :102:{14,15,29}
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:102:14
          $error("Assertion failed\n    at MSHR.scala:102 assert (!meta.clients.orR)\n");	// MSHR.scala:102:14
        if (`STOP_COND_)	// MSHR.scala:102:14
          $fatal;	// MSHR.scala:102:14
      end
      if (_GEN_4 & ~_GEN_5) begin	// MSHR.scala:101:35, :103:14
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:103:14
          $error("Assertion failed\n    at MSHR.scala:103 assert (!meta.dirty)\n");	// MSHR.scala:103:14
        if (`STOP_COND_)	// MSHR.scala:103:14
          $fatal;	// MSHR.scala:103:14
      end
      if (meta_valid & _GEN_6 & ~_GEN_5) begin	// MSHR.scala:96:27, :103:14, :105:22, :106:14
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:106:14
          $error("Assertion failed\n    at MSHR.scala:106 assert (!meta.dirty)\n");	// MSHR.scala:106:14
        if (`STOP_COND_)	// MSHR.scala:106:14
          $fatal;	// MSHR.scala:106:14
      end
      if (_GEN_7 & ~((|meta_clients) | reset)) begin	// MSHR.scala:97:17, :102:29, :108:33, :109:14
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:109:14
          $error("Assertion failed\n    at MSHR.scala:109 assert (meta.clients.orR)\n");	// MSHR.scala:109:14
        if (`STOP_COND_)	// MSHR.scala:109:14
          $fatal;	// MSHR.scala:109:14
      end
      if (_GEN_7 & ~((meta_clients & meta_clients - 6'h1) == 6'h0 | reset)) begin	// MSHR.scala:97:17, :108:33, :110:{14,29,45,57}, :223:56
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:110:14
          $error("Assertion failed\n    at MSHR.scala:110 assert ((meta.clients & (meta.clients - UInt(1))) === UInt(0)) // at most one\n");	// MSHR.scala:110:14
        if (`STOP_COND_)	// MSHR.scala:110:14
          $fatal;	// MSHR.scala:110:14
      end
      if (~(~(meta_valid & w_releaseack & w_rprobeacklast & w_pprobeacklast
              & ~w_grantfirst)
            | ~(~meta_valid | (~w_releaseack | ~w_rprobeacklast | ~w_pprobeacklast)
                & ~w_grantfirst) | reset)) begin	// MSHR.scala:96:27, :120:33, :122:33, :126:33, :130:33, :165:{28,40,45,62,79,82,100,103}, :166:93, :176:{10,11,36}
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:176:10
          $error("Assertion failed\n    at MSHR.scala:176 assert (!io.status.bits.nestB || !io.status.bits.blockB)\n");	// MSHR.scala:176:10
        if (`STOP_COND_)	// MSHR.scala:176:10
          $fatal;	// MSHR.scala:176:10
      end
      if (~(~_io_status_bits_nestC_output | meta_valid | reset)) begin	// MSHR.scala:96:27, :170:39, :177:{10,11}
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:177:10
          $error("Assertion failed\n    at MSHR.scala:177 assert (!io.status.bits.nestC || !io.status.bits.blockC)\n");	// MSHR.scala:177:10
        if (`STOP_COND_)	// MSHR.scala:177:10
          $fatal;	// MSHR.scala:177:10
      end
      if (bad_grant & meta_hit & ~(~meta_valid | _GEN_6 | reset)) begin	// MSHR.scala:96:27, :97:17, :105:22, :146:22, :165:28, :251:14
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:251:14
          $error("Assertion failed\n    at MSHR.scala:251 assert (!meta_valid || meta.state === BRANCH)\n");	// MSHR.scala:251:14
        if (`STOP_COND_)	// MSHR.scala:251:14
          $fatal;	// MSHR.scala:251:14
      end
      if (_GEN_10 & ~(~(_GEN_11 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :372:15, :375:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:375:15
          $error("Assertion failed: State transition from S_INVALID to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:375:15
        if (`STOP_COND_)	// MSHR.scala:375:15
          $fatal;	// MSHR.scala:375:15
      end
      if (_GEN_10 & ~(~(_GEN_11 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :372:15, :376:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:376:15
          $error("Assertion failed: State transition from S_INVALID to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:376:15
        if (`STOP_COND_)	// MSHR.scala:376:15
          $fatal;	// MSHR.scala:376:15
      end
      if (_GEN_10 & ~(~(_GEN_11 & _GEN_18) | reset)) begin	// MSHR.scala:371:35, :372:15, :379:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:379:15
          $error("Assertion failed: State transition from S_INVALID to S_TRUNK_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:379:15
        if (`STOP_COND_)	// MSHR.scala:379:15
          $fatal;	// MSHR.scala:379:15
      end
      if (_GEN_10 & ~(~(_GEN_19 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:381:15
          $error("Assertion failed: State transition from S_BRANCH to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:381:15
        if (`STOP_COND_)	// MSHR.scala:381:15
          $fatal;	// MSHR.scala:381:15
      end
      if (_GEN_10 & ~(~(_GEN_19 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :381:15, :384:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:384:15
          $error("Assertion failed: State transition from S_BRANCH to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:384:15
        if (`STOP_COND_)	// MSHR.scala:384:15
          $fatal;	// MSHR.scala:384:15
      end
      if (_GEN_10 & ~(~(_GEN_19 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :376:15, :381:15, :385:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:385:15
          $error("Assertion failed: State transition from S_BRANCH to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:385:15
        if (`STOP_COND_)	// MSHR.scala:385:15
          $fatal;	// MSHR.scala:385:15
      end
      if (_GEN_10 & ~(~(_GEN_19 & _GEN_18) | reset)) begin	// MSHR.scala:371:35, :379:15, :381:15, :388:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:388:15
          $error("Assertion failed: State transition from S_BRANCH to S_TRUNK_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:388:15
        if (`STOP_COND_)	// MSHR.scala:388:15
          $fatal;	// MSHR.scala:388:15
      end
      if (_GEN_10 & ~(~(_GEN_21 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :390:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:390:15
          $error("Assertion failed: State transition from S_BRANCH_C to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:390:15
        if (`STOP_COND_)	// MSHR.scala:390:15
          $fatal;	// MSHR.scala:390:15
      end
      if (_GEN_10 & ~(~(_GEN_21 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :390:15, :393:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:393:15
          $error("Assertion failed: State transition from S_BRANCH_C to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:393:15
        if (`STOP_COND_)	// MSHR.scala:393:15
          $fatal;	// MSHR.scala:393:15
      end
      if (_GEN_10 & ~(~(_GEN_21 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :376:15, :390:15, :395:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:395:15
          $error("Assertion failed: State transition from S_BRANCH_C to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:395:15
        if (`STOP_COND_)	// MSHR.scala:395:15
          $fatal;	// MSHR.scala:395:15
      end
      if (_GEN_10 & ~(~(_GEN_21 & _GEN_18) | reset)) begin	// MSHR.scala:371:35, :379:15, :390:15, :397:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:397:15
          $error("Assertion failed: State transition from S_BRANCH_C to S_TRUNK_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:397:15
        if (`STOP_COND_)	// MSHR.scala:397:15
          $fatal;	// MSHR.scala:397:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :399:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:399:15
          $error("Assertion failed: State transition from S_TIP to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:399:15
        if (`STOP_COND_)	// MSHR.scala:399:15
          $fatal;	// MSHR.scala:399:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :399:15, :400:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:400:15
          $error("Assertion failed: State transition from S_TIP to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:400:15
        if (`STOP_COND_)	// MSHR.scala:400:15
          $fatal;	// MSHR.scala:400:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :399:15, :401:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:401:15
          $error("Assertion failed: State transition from S_TIP to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:401:15
        if (`STOP_COND_)	// MSHR.scala:401:15
          $fatal;	// MSHR.scala:401:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :399:15, :402:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:402:15
          $error("Assertion failed: State transition from S_TIP to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:402:15
        if (`STOP_COND_)	// MSHR.scala:402:15
          $fatal;	// MSHR.scala:402:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :376:15, :399:15, :404:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:404:15
          $error("Assertion failed: State transition from S_TIP to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:404:15
        if (`STOP_COND_)	// MSHR.scala:404:15
          $fatal;	// MSHR.scala:404:15
      end
      if (_GEN_10 & ~(~(_GEN_22 & _GEN_18) | reset)) begin	// MSHR.scala:371:35, :379:15, :399:15, :406:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:406:15
          $error("Assertion failed: State transition from S_TIP to S_TRUNK_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:406:15
        if (`STOP_COND_)	// MSHR.scala:406:15
          $fatal;	// MSHR.scala:406:15
      end
      if (_GEN_10 & ~(~(_GEN_23 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :408:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:408:15
          $error("Assertion failed: State transition from S_TIP_C to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:408:15
        if (`STOP_COND_)	// MSHR.scala:408:15
          $fatal;	// MSHR.scala:408:15
      end
      if (_GEN_10 & ~(~(_GEN_23 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :408:15, :409:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:409:15
          $error("Assertion failed: State transition from S_TIP_C to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:409:15
        if (`STOP_COND_)	// MSHR.scala:409:15
          $fatal;	// MSHR.scala:409:15
      end
      if (_GEN_10 & ~(~(_GEN_23 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :408:15, :410:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:410:15
          $error("Assertion failed: State transition from S_TIP_C to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:410:15
        if (`STOP_COND_)	// MSHR.scala:410:15
          $fatal;	// MSHR.scala:410:15
      end
      if (_GEN_10 & ~(~(_GEN_23 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :376:15, :408:15, :413:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:413:15
          $error("Assertion failed: State transition from S_TIP_C to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:413:15
        if (`STOP_COND_)	// MSHR.scala:413:15
          $fatal;	// MSHR.scala:413:15
      end
      if (_GEN_10 & ~(~(_GEN_23 & _GEN_18) | reset)) begin	// MSHR.scala:371:35, :379:15, :408:15, :415:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:415:15
          $error("Assertion failed: State transition from S_TIP_C to S_TRUNK_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:415:15
        if (`STOP_COND_)	// MSHR.scala:415:15
          $fatal;	// MSHR.scala:415:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :417:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:417:15
          $error("Assertion failed: State transition from S_TIP_D to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:417:15
        if (`STOP_COND_)	// MSHR.scala:417:15
          $fatal;	// MSHR.scala:417:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :417:15, :418:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:418:15
          $error("Assertion failed: State transition from S_TIP_D to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:418:15
        if (`STOP_COND_)	// MSHR.scala:418:15
          $fatal;	// MSHR.scala:418:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :417:15, :419:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:419:15
          $error("Assertion failed: State transition from S_TIP_D to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:419:15
        if (`STOP_COND_)	// MSHR.scala:419:15
          $fatal;	// MSHR.scala:419:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_14) | reset)) begin	// MSHR.scala:371:35, :374:15, :417:15, :420:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:420:15
          $error("Assertion failed: State transition from S_TIP_D to S_TIP should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:420:15
        if (`STOP_COND_)	// MSHR.scala:420:15
          $fatal;	// MSHR.scala:420:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :417:15, :421:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:421:15
          $error("Assertion failed: State transition from S_TIP_D to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:421:15
        if (`STOP_COND_)	// MSHR.scala:421:15
          $fatal;	// MSHR.scala:421:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_16) | reset)) begin	// MSHR.scala:371:35, :376:15, :417:15, :422:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:422:15
          $error("Assertion failed: State transition from S_TIP_D to S_TIP_CD should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:422:15
        if (`STOP_COND_)	// MSHR.scala:422:15
          $fatal;	// MSHR.scala:422:15
      end
      if (_GEN_10 & ~(~(_GEN_24 & _GEN_17) | reset)) begin	// MSHR.scala:371:35, :378:15, :417:15, :423:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:423:15
          $error("Assertion failed: State transition from S_TIP_D to S_TRUNK_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:423:15
        if (`STOP_COND_)	// MSHR.scala:423:15
          $fatal;	// MSHR.scala:423:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :426:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:426:15
          $error("Assertion failed: State transition from S_TIP_CD to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:426:15
        if (`STOP_COND_)	// MSHR.scala:426:15
          $fatal;	// MSHR.scala:426:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :426:15, :427:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:427:15
          $error("Assertion failed: State transition from S_TIP_CD to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:427:15
        if (`STOP_COND_)	// MSHR.scala:427:15
          $fatal;	// MSHR.scala:427:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :426:15, :428:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:428:15
          $error("Assertion failed: State transition from S_TIP_CD to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:428:15
        if (`STOP_COND_)	// MSHR.scala:428:15
          $fatal;	// MSHR.scala:428:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_14) | reset)) begin	// MSHR.scala:371:35, :374:15, :426:15, :429:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:429:15
          $error("Assertion failed: State transition from S_TIP_CD to S_TIP should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:429:15
        if (`STOP_COND_)	// MSHR.scala:429:15
          $fatal;	// MSHR.scala:429:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :426:15, :430:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:430:15
          $error("Assertion failed: State transition from S_TIP_CD to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:430:15
        if (`STOP_COND_)	// MSHR.scala:430:15
          $fatal;	// MSHR.scala:430:15
      end
      if (_GEN_10 & ~(~(_GEN_25 & _GEN_17) | reset)) begin	// MSHR.scala:371:35, :378:15, :426:15, :432:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:432:15
          $error("Assertion failed: State transition from S_TIP_CD to S_TRUNK_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:432:15
        if (`STOP_COND_)	// MSHR.scala:432:15
          $fatal;	// MSHR.scala:432:15
      end
      if (_GEN_10 & ~(~(_GEN_26 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :435:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:435:15
          $error("Assertion failed: State transition from S_TRUNK_C to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:435:15
        if (`STOP_COND_)	// MSHR.scala:435:15
          $fatal;	// MSHR.scala:435:15
      end
      if (_GEN_10 & ~(~(_GEN_26 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :435:15, :436:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:436:15
          $error("Assertion failed: State transition from S_TRUNK_C to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:436:15
        if (`STOP_COND_)	// MSHR.scala:436:15
          $fatal;	// MSHR.scala:436:15
      end
      if (_GEN_10 & ~(~(_GEN_26 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :435:15, :437:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:437:15
          $error("Assertion failed: State transition from S_TRUNK_C to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:437:15
        if (`STOP_COND_)	// MSHR.scala:437:15
          $fatal;	// MSHR.scala:437:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_20) | reset)) begin	// MSHR.scala:371:35, :381:15, :444:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:444:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_INVALID should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:444:15
        if (`STOP_COND_)	// MSHR.scala:444:15
          $fatal;	// MSHR.scala:444:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_12) | reset)) begin	// MSHR.scala:371:35, :372:15, :444:15, :445:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:445:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_BRANCH should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:445:15
        if (`STOP_COND_)	// MSHR.scala:445:15
          $fatal;	// MSHR.scala:445:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_13) | reset)) begin	// MSHR.scala:371:35, :373:15, :444:15, :446:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:446:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_BRANCH_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:446:15
        if (`STOP_COND_)	// MSHR.scala:446:15
          $fatal;	// MSHR.scala:446:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_14) | reset)) begin	// MSHR.scala:371:35, :374:15, :444:15, :447:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:447:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_TIP should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:447:15
        if (`STOP_COND_)	// MSHR.scala:447:15
          $fatal;	// MSHR.scala:447:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_15) | reset)) begin	// MSHR.scala:371:35, :375:15, :444:15, :448:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:448:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_TIP_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:448:15
        if (`STOP_COND_)	// MSHR.scala:448:15
          $fatal;	// MSHR.scala:448:15
      end
      if (_GEN_10 & ~(~(_GEN_27 & _GEN_17) | reset)) begin	// MSHR.scala:371:35, :378:15, :444:15, :451:15
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:451:15
          $error("Assertion failed: State transition from S_TRUNK_CD to S_TRUNK_C should be impossible (false,true,true,true,true)\n    at MSHR.scala:356 assert(!(before === from.code && after === to.code), s\"State transition from ${from} to ${to} should be impossible ${cfg}\")\n");	// MSHR.scala:451:15
        if (`STOP_COND_)	// MSHR.scala:451:15
          $fatal;	// MSHR.scala:451:15
      end
      if (io_allocate_valid
          & ~(~request_valid | no_wait & io_schedule_ready & _io_schedule_valid_output
              | reset)) begin	// MSHR.scala:94:30, :180:83, :190:105, :530:{12,13,40}
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:530:12
          $error("Assertion failed\n    at MSHR.scala:530 assert (!request_valid || (no_wait && io.schedule.fire()))\n");	// MSHR.scala:530:12
        if (`STOP_COND_)	// MSHR.scala:530:12
          $fatal;	// MSHR.scala:530:12
      end
      if (_GEN_3 & new_request_prio_2 & ~(new_meta_hit | reset)) begin	// MSHR.scala:502:21, :503:24, :536:28, :582:14
        if (`ASSERT_VERBOSE_COND_)	// MSHR.scala:582:14
          $error("Assertion failed\n    at MSHR.scala:582 assert (new_meta.hit)\n");	// MSHR.scala:582:14
        if (`STOP_COND_)	// MSHR.scala:582:14
          $fatal;	// MSHR.scala:582:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [5:0] probe_bit;	// Cat.scala:30:58
    automatic logic       _GEN_28;	// MSHR.scala:480:42
    automatic logic       _GEN_29;	// MSHR.scala:144:17, :479:25, :480:81, :481:12
    probe_bit =
      {io_sinkc_bits_source[6:2] == 5'hC & io_sinkc_bits_source[1:0] != 2'h3,
       io_sinkc_bits_source[6:3] == 4'h4 & io_sinkc_bits_source[2:0] < 3'h5,
       io_sinkc_bits_source[6:4] == 3'h0 & io_sinkc_bits_source[3:0] < 4'h9,
       io_sinkc_bits_source == 7'h38,
       io_sinkc_bits_source == 7'h3C,
       io_sinkc_bits_source == 7'h40};	// Cat.scala:30:58, Parameters.scala:46:9, :52:64, :54:{10,32}, :56:50, :57:20, :266:13
    _GEN_28 = io_sinkd_bits_opcode == 3'h4 | io_sinkd_bits_opcode == 3'h5;	// MSHR.scala:480:{32,42,66}, Parameters.scala:266:13
    _GEN_29 = io_sinkd_valid & _GEN_28;	// MSHR.scala:144:17, :479:25, :480:{42,81}, :481:12
    if (reset) begin
      request_valid <= 1'h0;	// MSHR.scala:94:30
      meta_valid <= 1'h0;	// MSHR.scala:94:30, :96:27
      s_rprobe <= 1'h1;	// MSHR.scala:102:14, :118:33
      w_rprobeackfirst <= 1'h1;	// MSHR.scala:102:14, :119:33
      w_rprobeacklast <= 1'h1;	// MSHR.scala:102:14, :120:33
      s_release <= 1'h1;	// MSHR.scala:102:14, :121:33
      w_releaseack <= 1'h1;	// MSHR.scala:102:14, :122:33
      s_pprobe <= 1'h1;	// MSHR.scala:102:14, :123:33
      s_acquire <= 1'h1;	// MSHR.scala:102:14, :124:33
      s_flush <= 1'h1;	// MSHR.scala:102:14, :125:33
      w_grantfirst <= 1'h1;	// MSHR.scala:102:14, :126:33
      w_grantlast <= 1'h1;	// MSHR.scala:102:14, :127:33
      w_grant <= 1'h1;	// MSHR.scala:102:14, :128:33
      w_pprobeackfirst <= 1'h1;	// MSHR.scala:102:14, :129:33
      w_pprobeacklast <= 1'h1;	// MSHR.scala:102:14, :130:33
      w_pprobeack <= 1'h1;	// MSHR.scala:102:14, :131:33
      s_grantack <= 1'h1;	// MSHR.scala:102:14, :133:33
      s_execute <= 1'h1;	// MSHR.scala:102:14, :134:33
      w_grantack <= 1'h1;	// MSHR.scala:102:14, :135:33
      s_writeback <= 1'h1;	// MSHR.scala:102:14, :136:33
    end
    else begin
      automatic logic _GEN_30;	// MSHR.scala:136:33, :194:28, :203:{35,50}
      _GEN_30 = io_schedule_ready & no_wait;	// MSHR.scala:136:33, :180:83, :194:28, :203:{35,50}
      request_valid <= io_allocate_valid | ~_GEN_30 & request_valid;	// MSHR.scala:94:30, :136:33, :194:28, :203:{35,50}, :205:20, :206:21, :529:28, :531:19
      meta_valid <= _GEN_3 | ~_GEN_30 & meta_valid;	// MSHR.scala:94:30, :96:27, :136:33, :194:28, :203:{35,50}, :205:20, :206:21, :207:18, :536:{28,79}, :537:16
      if (_GEN_3) begin	// MSHR.scala:536:28
        automatic logic       new_meta_dirty;	// MSHR.scala:502:21
        automatic logic [1:0] new_meta_state =
          _new_meta_T
            ? _io_schedule_bits_dir_bits_data_WIRE_state
            : io_directory_bits_state;	// MSHR.scala:220:54, :248:20, :249:21, :502:{21,40}
        automatic logic [5:0] new_meta_clients;	// MSHR.scala:502:21
        automatic logic       new_request_control;	// MSHR.scala:503:24
        automatic logic [2:0] new_request_opcode;	// MSHR.scala:503:24
        automatic logic [2:0] new_request_param;	// MSHR.scala:503:24
        automatic logic [6:0] new_request_source;	// MSHR.scala:503:24
        automatic logic       _new_skipProbe_T;	// Parameters.scala:267:14
        automatic logic       new_needT;	// Parameters.scala:266:70
        automatic logic [5:0] new_clientBit;	// Cat.scala:30:58
        automatic logic       _GEN_31;	// MSHR.scala:575:56
        automatic logic       _GEN_32;	// MSHR.scala:592:61
        automatic logic       _GEN_33 = ~new_meta_hit & (|new_meta_state);	// MSHR.scala:94:30, :102:14, :502:21, :550:22, :588:27, :589:19, :603:{27,45}
        automatic logic       _GEN_34;	// MSHR.scala:550:22, :568:60, :585:61
        automatic logic       _GEN_35;	// MSHR.scala:547:22, :568:60, :585:61
        automatic logic       _GEN_36;	// MSHR.scala:614:27
        automatic logic       _GEN_37;	// MSHR.scala:553:22, :568:60, :585:61, :614:72
        automatic logic       _GEN_38;	// MSHR.scala:553:22, :568:60, :585:61, :614:72
        automatic logic       _GEN_39;	// MSHR.scala:624:53
        automatic logic       _GEN_40;	// MSHR.scala:552:22, :568:60, :585:61, :625:63
        automatic logic       _GEN_41;	// MSHR.scala:633:49
        new_meta_dirty =
          _new_meta_T
            ? _io_schedule_bits_dir_bits_data_WIRE_dirty
            : io_directory_bits_dirty;	// MSHR.scala:220:54, :248:20, :249:21, :502:{21,40}
        new_meta_clients =
          _new_meta_T
            ? _io_schedule_bits_dir_bits_data_WIRE_clients
            : io_directory_bits_clients;	// MSHR.scala:220:54, :248:20, :249:21, :502:{21,40}
        new_request_control =
          io_allocate_valid ? io_allocate_bits_control : request_control;	// MSHR.scala:95:20, :503:24
        new_request_opcode = io_allocate_valid ? io_allocate_bits_opcode : request_opcode;	// MSHR.scala:95:20, :503:24
        new_request_param = io_allocate_valid ? io_allocate_bits_param : request_param;	// MSHR.scala:95:20, :503:24
        new_request_source = io_allocate_valid ? io_allocate_bits_source : request_source;	// MSHR.scala:95:20, :503:24
        _new_skipProbe_T = new_request_opcode == 3'h6;	// MSHR.scala:503:24, Parameters.scala:267:14
        new_needT =
          ~(new_request_opcode[2]) | new_request_opcode == 3'h5
          & new_request_param == 3'h1 | (_new_skipProbe_T | (&new_request_opcode))
          & (|new_request_param);	// MSHR.scala:503:24, Parameters.scala:265:{5,12}, :266:{13,33,42,70}, :267:{14,42,52,80,89}
        new_clientBit =
          {new_request_source[6:2] == 5'hC & new_request_source[1:0] != 2'h3,
           new_request_source[6:3] == 4'h4 & new_request_source[2:0] < 3'h5,
           new_request_source[6:4] == 3'h0 & new_request_source[3:0] < 4'h9,
           new_request_source == 7'h38,
           new_request_source == 7'h3C,
           new_request_source == 7'h40};	// Cat.scala:30:58, MSHR.scala:503:24, Parameters.scala:46:9, :52:64, :54:{10,32}, :56:50, :57:20, :266:13
        _GEN_31 = new_meta_state == 2'h2;	// MSHR.scala:502:21, :575:56
        _GEN_32 = new_meta_clients == 6'h0;	// MSHR.scala:223:56, :502:21, :592:61
        _GEN_34 = new_request_prio_2 | (new_request_control ? ~new_meta_hit : ~_GEN_33);	// MSHR.scala:94:30, :102:14, :502:21, :503:24, :550:22, :568:60, :585:61, :588:27, :589:19, :603:{27,58}, :604:19
        _GEN_35 =
          new_request_prio_2
          | (new_request_control ? ~new_meta_hit | _GEN_32 : ~_GEN_33 | _GEN_32);	// MSHR.scala:502:21, :503:24, :547:22, :568:60, :585:61, :588:27, :592:{61,75}, :603:{27,58}, :607:74
        _GEN_36 = ~new_meta_hit | new_meta_state == 2'h1 & new_needT;	// MSHR.scala:94:30, :102:14, :502:21, :550:22, :588:27, :589:19, :614:{27,46,57}, Parameters.scala:266:70
        _GEN_37 = new_request_prio_2 | new_request_control;	// MSHR.scala:503:24, :553:22, :568:60, :585:61, :614:72
        _GEN_38 = _GEN_37 | ~_GEN_36;	// MSHR.scala:94:30, :102:14, :553:22, :568:60, :585:61, :614:{27,72}, :615:19
        _GEN_39 =
          new_meta_hit & (new_needT | _GEN_31)
          & (|(new_meta_clients
               & ~(_new_skipProbe_T | (&new_request_opcode) | new_request_opcode == 3'h4
                     ? new_clientBit
                     : 6'h0)));	// Cat.scala:30:58, MSHR.scala:223:56, :502:21, :503:24, :506:26, :575:56, :624:{24,53}, :625:{31,33,49}, Parameters.scala:266:70, :267:{14,52}, :275:{77,87}
        _GEN_40 = _GEN_37 | ~_GEN_39;	// MSHR.scala:94:30, :102:14, :552:22, :553:22, :568:60, :585:61, :614:72, :624:53, :625:63, :626:18
        _GEN_41 = _new_skipProbe_T | (&new_request_opcode);	// MSHR.scala:503:24, :633:49, Parameters.scala:267:{14,52}
        s_rprobe <= _GEN_35;	// MSHR.scala:118:33, :547:22, :568:60, :585:61
        w_rprobeackfirst <= _GEN_35;	// MSHR.scala:119:33, :547:22, :568:60, :585:61
        w_rprobeacklast <= _GEN_35;	// MSHR.scala:120:33, :547:22, :568:60, :585:61
        s_release <= _GEN_34;	// MSHR.scala:121:33, :550:22, :568:60, :585:61
        w_releaseack <= _GEN_34;	// MSHR.scala:122:33, :550:22, :568:60, :585:61
        s_pprobe <= _GEN_40;	// MSHR.scala:123:33, :552:22, :568:60, :585:61, :625:63
        s_acquire <= _GEN_38;	// MSHR.scala:124:33, :553:22, :568:60, :585:61, :614:72
        s_flush <= new_request_prio_2 | ~new_request_control;	// MSHR.scala:94:30, :102:14, :125:33, :503:24, :554:22, :568:60, :585:61, :586:15
        w_grantfirst <= _GEN_38;	// MSHR.scala:126:33, :553:22, :568:60, :585:61, :614:72
        w_grantlast <= _GEN_38;	// MSHR.scala:127:33, :553:22, :568:60, :585:61, :614:72
        w_grant <= _GEN_38;	// MSHR.scala:128:33, :553:22, :568:60, :585:61, :614:72
        w_pprobeackfirst <= _GEN_40;	// MSHR.scala:129:33, :552:22, :568:60, :585:61, :625:63
        w_pprobeacklast <= _GEN_40;	// MSHR.scala:130:33, :552:22, :568:60, :585:61, :625:63
        w_pprobeack <= _GEN_40;	// MSHR.scala:131:33, :552:22, :568:60, :585:61, :625:63
        s_grantack <= _GEN_38;	// MSHR.scala:133:33, :553:22, :568:60, :585:61, :614:72
        s_execute <= ~new_request_prio_2 & new_request_control;	// MSHR.scala:134:33, :503:24, :568:60, :569:17, :585:61
        w_grantack <= _GEN_37 | ~_GEN_41;	// MSHR.scala:94:30, :102:14, :135:33, :553:22, :564:22, :568:60, :585:61, :614:72, :633:{49,88}, :634:20
        if (new_request_prio_2)	// MSHR.scala:503:24
          s_writeback <=
            ~((new_request_param == 3'h1 | new_request_param == 3'h2
               | new_request_param == 3'h5) & (|(new_meta_clients & new_clientBit))
              | (new_request_param == 3'h0 | new_request_param == 3'h4) & _GEN_31)
            & ~(new_request_opcode[0] & ~new_meta_dirty);	// Cat.scala:30:58, MSHR.scala:94:30, :102:14, :136:33, :502:21, :503:24, :565:22, :571:{31,35,38,55}, :572:21, :575:{38,56,67}, :576:21, :579:{38,59,76,89}, :580:21, Parameters.scala:266:13, :278:{11,43,66,75}, :281:{11,34,43}
        else	// MSHR.scala:503:24
          s_writeback <=
            new_request_control
            | ~(~(new_request_opcode[2]) & new_meta_hit & ~new_meta_dirty | _GEN_41
                | _GEN_39) & ~_GEN_36;	// MSHR.scala:94:30, :102:14, :136:33, :502:21, :503:24, :553:22, :565:22, :571:38, :585:61, :614:{27,72}, :615:19, :624:53, :625:63, :630:21, :633:{49,88}, :635:21, :638:{13,52,72}, :639:21, Parameters.scala:265:12
      end
      else begin	// MSHR.scala:536:28
        automatic logic last_probe;	// MSHR.scala:456:46
        automatic logic _GEN_42;	// MSHR.scala:119:33, :458:49, :467:22
        automatic logic _GEN_43;	// MSHR.scala:120:33, :458:49, :468:21
        last_probe = (probes_done | probe_bit) == (meta_clients & ~excluded_client);	// Cat.scala:30:58, MSHR.scala:97:17, :147:24, :276:28, :286:53, :456:{33,46,64}
        _GEN_42 = io_sinkc_valid & last_probe;	// MSHR.scala:119:33, :456:46, :458:49, :467:22
        _GEN_43 = io_sinkc_valid & last_probe & io_sinkc_bits_last;	// MSHR.scala:120:33, :456:46, :458:49, :468:21
        s_rprobe <= io_schedule_ready | s_rprobe;	// MSHR.scala:118:33, :194:28, :195:50
        w_rprobeackfirst <= _GEN_42 | w_rprobeackfirst;	// MSHR.scala:119:33, :458:49, :467:22
        w_rprobeacklast <= _GEN_43 | w_rprobeacklast;	// MSHR.scala:120:33, :458:49, :468:21
        s_release <= io_schedule_ready & w_rprobeackfirst | s_release;	// MSHR.scala:119:33, :121:33, :194:28, :196:{35,50}
        w_releaseack <=
          io_sinkd_valid & ~_GEN_28 & io_sinkd_bits_opcode == 3'h6 | w_releaseack;	// MSHR.scala:122:33, :479:25, :480:{42,81}, :492:{37,53}, Parameters.scala:267:14
        s_pprobe <= io_schedule_ready | s_pprobe;	// MSHR.scala:123:33, :194:28, :197:50
        s_acquire <= io_schedule_ready & s_release & s_pprobe | s_acquire;	// MSHR.scala:121:33, :123:33, :124:33, :194:28, :198:{35,50}
        s_flush <= io_schedule_ready & w_releaseack | s_flush;	// MSHR.scala:122:33, :125:33, :194:28, :199:{35,50}
        w_grantfirst <= _GEN_29 | w_grantfirst;	// MSHR.scala:126:33, :144:17, :479:25, :480:81, :481:12, :482:20
        if (_GEN_29) begin	// MSHR.scala:144:17, :479:25, :480:81, :481:12
          w_grantlast <= io_sinkd_bits_last;	// MSHR.scala:127:33
          w_grant <= ~(|request_offset) | io_sinkd_bits_last;	// MSHR.scala:95:20, :128:33, :472:77, :487:{33,45}
        end
        w_pprobeackfirst <= _GEN_42 | w_pprobeackfirst;	// MSHR.scala:119:33, :129:33, :458:49, :467:22, :469:22
        w_pprobeacklast <= _GEN_43 | w_pprobeacklast;	// MSHR.scala:120:33, :130:33, :458:49, :468:21, :470:21
        w_pprobeack <=
          io_sinkc_valid & last_probe & (io_sinkc_bits_last | ~(|request_offset))
          | w_pprobeack;	// MSHR.scala:95:20, :131:33, :456:46, :458:49, :472:{59,77}, :473:17
        s_grantack <= io_schedule_ready & w_grantfirst | s_grantack;	// MSHR.scala:126:33, :133:33, :194:28, :201:{35,50}
        s_execute <= io_schedule_ready & w_pprobeack & w_grant | s_execute;	// MSHR.scala:128:33, :131:33, :134:33, :194:28, :202:{35,50}
        w_grantack <= io_sinke_valid | w_grantack;	// MSHR.scala:135:33, :496:25, :497:16
        s_writeback <= _GEN_30 | s_writeback;	// MSHR.scala:136:33, :194:28, :203:{35,50}
      end
    end
    if (io_allocate_valid) begin
      request_prio_0 <= io_allocate_bits_prio_0;	// MSHR.scala:95:20
      request_prio_1 <= io_allocate_bits_prio_1;	// MSHR.scala:95:20
      request_prio_2 <= io_allocate_bits_prio_2;	// MSHR.scala:95:20
      request_control <= io_allocate_bits_control;	// MSHR.scala:95:20
      request_opcode <= io_allocate_bits_opcode;	// MSHR.scala:95:20
      request_param <= io_allocate_bits_param;	// MSHR.scala:95:20
      request_size <= io_allocate_bits_size;	// MSHR.scala:95:20
      request_source <= io_allocate_bits_source;	// MSHR.scala:95:20
      request_tag <= io_allocate_bits_tag;	// MSHR.scala:95:20
      request_offset <= io_allocate_bits_offset;	// MSHR.scala:95:20
      request_put <= io_allocate_bits_put;	// MSHR.scala:95:20
      request_set <= io_allocate_bits_set;	// MSHR.scala:95:20
    end
    if (_GEN_3) begin	// MSHR.scala:536:28
      if (_new_meta_T) begin	// MSHR.scala:502:40
        meta_dirty <= _io_schedule_bits_dir_bits_data_WIRE_dirty;	// MSHR.scala:97:17, :220:54, :248:20, :249:21
        if (bad_grant) begin	// MSHR.scala:146:22
          meta_state <= _GEN_2;	// MSHR.scala:97:17, :249:21, :254:36, :260:36
          if (meta_hit)	// MSHR.scala:97:17
            meta_clients <= _final_meta_writeback_clients_T_16;	// MSHR.scala:97:17, :255:52
          else	// MSHR.scala:97:17
            meta_clients <= 6'h0;	// MSHR.scala:97:17, :223:56
        end
        else begin	// MSHR.scala:146:22
          if (request_prio_2) begin	// MSHR.scala:95:20
            if (_final_meta_writeback_state_T_2)	// MSHR.scala:222:64
              meta_state <= 2'h3;	// MSHR.scala:97:17
            meta_clients <= _final_meta_writeback_clients_T_7;	// MSHR.scala:97:17, :223:50
          end
          else if (request_control) begin	// MSHR.scala:95:20
            if (meta_hit)	// MSHR.scala:97:17
              meta_state <= 2'h0;	// MSHR.scala:97:17
            meta_clients <= _GEN;	// MSHR.scala:97:17, :226:21, :229:36
          end
          else begin	// MSHR.scala:95:20
            if (req_needT)	// Parameters.scala:266:70
              meta_state <= _final_meta_writeback_state_T_6;	// MSHR.scala:97:17, :235:40
            else if (meta_hit) begin	// MSHR.scala:97:17
              if (&meta_state)	// MSHR.scala:97:17, Mux.scala:80:60
                meta_state <= _final_meta_writeback_state_T_9;	// MSHR.scala:97:17, :241:55
              else	// Mux.scala:80:60
                meta_state <= _final_meta_writeback_state_T_13;	// MSHR.scala:97:17, Mux.scala:80:57
            end
            else if (gotT)	// MSHR.scala:145:17
              meta_state <= _final_meta_writeback_state_T_6;	// MSHR.scala:97:17, :235:40
            else	// MSHR.scala:145:17
              meta_state <= 2'h1;	// MSHR.scala:97:17
            meta_clients <= _final_meta_writeback_clients_T_14;	// MSHR.scala:97:17, :242:88
          end
          meta_hit <= _GEN_1;	// MSHR.scala:97:17, :220:54, :224:34, :225:57
        end
        if (~_GEN_0)	// MSHR.scala:220:54, :225:57, :244:30
          meta_tag <= request_tag;	// MSHR.scala:95:20, :97:17
      end
      else begin	// MSHR.scala:502:40
        meta_dirty <= io_directory_bits_dirty;	// MSHR.scala:97:17
        meta_state <= io_directory_bits_state;	// MSHR.scala:97:17
        meta_clients <= io_directory_bits_clients;	// MSHR.scala:97:17
        meta_tag <= io_directory_bits_tag;	// MSHR.scala:97:17
        meta_hit <= io_directory_bits_hit;	// MSHR.scala:97:17
      end
      probes_done <= 6'h0;	// MSHR.scala:147:24, :223:56
      probes_toN <= 6'h0;	// MSHR.scala:148:23, :223:56
    end
    else begin	// MSHR.scala:536:28
      automatic logic       _GEN_44;	// MSHR.scala:153:41
      automatic logic [5:0] _GEN_45 = {6{io_sinkc_valid}};	// MSHR.scala:147:24, :458:49, :464:17
      _GEN_44 =
        meta_valid & (|meta_state) & io_nestedwb_set == request_set
        & io_nestedwb_tag == meta_tag;	// MSHR.scala:95:20, :96:27, :97:17, :101:22, :153:{25,41,60}
      meta_dirty <=
        io_sinkc_valid & (|meta_state) & io_sinkc_bits_tag == meta_tag
        & io_sinkc_bits_data
        | (_GEN_44
             ? io_nestedwb_c_set_dirty | ~io_nestedwb_b_clr_dirty & meta_dirty
             : meta_dirty);	// MSHR.scala:97:17, :101:22, :153:{41,74}, :154:{36,49}, :155:{36,49}, :458:49, :477:{55,91,104}
      if (_GEN_44 & io_nestedwb_b_toB)	// MSHR.scala:97:17, :153:{41,74}, :156:{30,43}
        meta_state <= 2'h1;	// MSHR.scala:97:17
      meta_hit <= ~(_GEN_44 & io_nestedwb_b_toN) & meta_hit;	// MSHR.scala:97:17, :153:{41,74}, :157:{30,41}
      probes_done <= _GEN_45 & probe_bit | probes_done;	// Cat.scala:30:58, MSHR.scala:147:24, :458:49, :464:17
      probes_toN <=
        _GEN_45
        & (io_sinkc_bits_param == 3'h1 | io_sinkc_bits_param == 3'h2
           | io_sinkc_bits_param == 3'h5
             ? probe_bit
             : 6'h0) | probes_toN;	// Cat.scala:30:58, MSHR.scala:147:24, :148:23, :223:56, :458:49, :464:17, :465:{16,35}, Parameters.scala:266:13, :278:{11,43,66,75}
    end
    if (~_GEN_3 | _new_meta_T) begin	// MSHR.scala:97:17, :502:40, :536:{28,79}, :538:10
    end
    else	// MSHR.scala:97:17, :536:79, :538:10
      meta_way <= io_directory_bits_way;	// MSHR.scala:97:17
    if (_GEN_29)	// MSHR.scala:144:17, :479:25, :480:81, :481:12
      sink <= io_sinkd_bits_sink;	// MSHR.scala:144:17
    gotT <= ~_GEN_3 & (_GEN_29 ? io_sinkd_bits_param == 3'h0 : gotT);	// MSHR.scala:97:17, :144:17, :145:17, :479:25, :480:81, :481:12, :490:{12,35}, :536:{28,79}, :538:10, :542:10
    bad_grant <= ~_GEN_3 & (_GEN_29 ? io_sinkd_bits_denied : bad_grant);	// MSHR.scala:97:17, :144:17, :146:22, :479:25, :480:81, :481:12, :485:17, :536:{28,79}, :538:10, :543:15
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:3];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        request_valid = _RANDOM[2'h0][0];	// MSHR.scala:94:30
        request_prio_0 = _RANDOM[2'h0][1];	// MSHR.scala:94:30, :95:20
        request_prio_1 = _RANDOM[2'h0][2];	// MSHR.scala:94:30, :95:20
        request_prio_2 = _RANDOM[2'h0][3];	// MSHR.scala:94:30, :95:20
        request_control = _RANDOM[2'h0][4];	// MSHR.scala:94:30, :95:20
        request_opcode = _RANDOM[2'h0][7:5];	// MSHR.scala:94:30, :95:20
        request_param = _RANDOM[2'h0][10:8];	// MSHR.scala:94:30, :95:20
        request_size = _RANDOM[2'h0][13:11];	// MSHR.scala:94:30, :95:20
        request_source = _RANDOM[2'h0][20:14];	// MSHR.scala:94:30, :95:20
        request_tag = {_RANDOM[2'h0][31:21], _RANDOM[2'h1][1:0]};	// MSHR.scala:94:30, :95:20
        request_offset = _RANDOM[2'h1][7:2];	// MSHR.scala:95:20
        request_put = _RANDOM[2'h1][13:8];	// MSHR.scala:95:20
        request_set = _RANDOM[2'h1][23:14];	// MSHR.scala:95:20
        meta_valid = _RANDOM[2'h1][24];	// MSHR.scala:95:20, :96:27
        meta_dirty = _RANDOM[2'h1][25];	// MSHR.scala:95:20, :97:17
        meta_state = _RANDOM[2'h1][27:26];	// MSHR.scala:95:20, :97:17
        meta_clients = {_RANDOM[2'h1][31:28], _RANDOM[2'h2][1:0]};	// MSHR.scala:95:20, :97:17
        meta_tag = _RANDOM[2'h2][14:2];	// MSHR.scala:97:17
        meta_hit = _RANDOM[2'h2][15];	// MSHR.scala:97:17
        meta_way = _RANDOM[2'h2][18:16];	// MSHR.scala:97:17
        s_rprobe = _RANDOM[2'h2][19];	// MSHR.scala:97:17, :118:33
        w_rprobeackfirst = _RANDOM[2'h2][20];	// MSHR.scala:97:17, :119:33
        w_rprobeacklast = _RANDOM[2'h2][21];	// MSHR.scala:97:17, :120:33
        s_release = _RANDOM[2'h2][22];	// MSHR.scala:97:17, :121:33
        w_releaseack = _RANDOM[2'h2][23];	// MSHR.scala:97:17, :122:33
        s_pprobe = _RANDOM[2'h2][24];	// MSHR.scala:97:17, :123:33
        s_acquire = _RANDOM[2'h2][25];	// MSHR.scala:97:17, :124:33
        s_flush = _RANDOM[2'h2][26];	// MSHR.scala:97:17, :125:33
        w_grantfirst = _RANDOM[2'h2][27];	// MSHR.scala:97:17, :126:33
        w_grantlast = _RANDOM[2'h2][28];	// MSHR.scala:97:17, :127:33
        w_grant = _RANDOM[2'h2][29];	// MSHR.scala:97:17, :128:33
        w_pprobeackfirst = _RANDOM[2'h2][30];	// MSHR.scala:97:17, :129:33
        w_pprobeacklast = _RANDOM[2'h2][31];	// MSHR.scala:97:17, :130:33
        w_pprobeack = _RANDOM[2'h3][0];	// MSHR.scala:131:33
        s_grantack = _RANDOM[2'h3][2];	// MSHR.scala:131:33, :133:33
        s_execute = _RANDOM[2'h3][3];	// MSHR.scala:131:33, :134:33
        w_grantack = _RANDOM[2'h3][4];	// MSHR.scala:131:33, :135:33
        s_writeback = _RANDOM[2'h3][5];	// MSHR.scala:131:33, :136:33
        sink = _RANDOM[2'h3][8:6];	// MSHR.scala:131:33, :144:17
        gotT = _RANDOM[2'h3][9];	// MSHR.scala:131:33, :145:17
        bad_grant = _RANDOM[2'h3][10];	// MSHR.scala:131:33, :146:22
        probes_done = _RANDOM[2'h3][16:11];	// MSHR.scala:131:33, :147:24
        probes_toN = _RANDOM[2'h3][22:17];	// MSHR.scala:131:33, :148:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_status_valid = request_valid;	// MSHR.scala:94:30
  assign io_status_bits_set = request_set;	// MSHR.scala:95:20
  assign io_status_bits_tag = request_tag;	// MSHR.scala:95:20
  assign io_status_bits_way = meta_way;	// MSHR.scala:97:17
  assign io_status_bits_blockC = ~meta_valid;	// MSHR.scala:96:27, :165:28
  assign io_status_bits_nestC = _io_status_bits_nestC_output;	// MSHR.scala:170:39
  assign io_schedule_valid = _io_schedule_valid_output;	// MSHR.scala:190:105
  assign io_schedule_bits_a_valid = _io_schedule_bits_a_valid_output;	// MSHR.scala:181:55
  assign io_schedule_bits_a_bits_tag = request_tag;	// MSHR.scala:95:20
  assign io_schedule_bits_a_bits_set = request_set;	// MSHR.scala:95:20
  assign io_schedule_bits_a_bits_param =
    {1'h0, req_needT ? (meta_hit ? 2'h2 : 2'h1) : 2'h0};	// MSHR.scala:94:30, :97:17, :279:{35,41,56}, Parameters.scala:266:70
  assign io_schedule_bits_a_bits_block =
    request_size != 3'h6 | ~(request_opcode == 3'h0 | (&request_opcode));	// MSHR.scala:95:20, :280:{51,95}, :281:{38,55,71}, Parameters.scala:267:{14,52}
  assign io_schedule_bits_b_valid = _io_schedule_bits_b_valid_output;	// MSHR.scala:182:41
  assign io_schedule_bits_b_bits_param =
    s_rprobe ? (request_prio_1 ? request_param : {1'h0, req_needT ? 2'h2 : 2'h1}) : 3'h2;	// MSHR.scala:94:30, :95:20, :118:33, :283:{41,61,97}, Parameters.scala:266:70, :278:43
  assign io_schedule_bits_b_bits_tag = s_rprobe ? request_tag : meta_tag;	// MSHR.scala:95:20, :97:17, :118:33, :284:41
  assign io_schedule_bits_b_bits_set = request_set;	// MSHR.scala:95:20
  assign io_schedule_bits_b_bits_clients = meta_clients & ~excluded_client;	// MSHR.scala:97:17, :276:28, :286:{51,53}
  assign io_schedule_bits_c_valid = _io_schedule_bits_c_valid_output;	// MSHR.scala:183:43
  assign io_schedule_bits_c_bits_opcode = {2'h3, meta_dirty};	// MSHR.scala:97:17, :287:41
  assign io_schedule_bits_c_bits_param = meta_state == 2'h1 ? 3'h2 : 3'h1;	// MSHR.scala:97:17, :288:{41,53}, Parameters.scala:278:43
  assign io_schedule_bits_c_bits_tag = meta_tag;	// MSHR.scala:97:17
  assign io_schedule_bits_c_bits_set = request_set;	// MSHR.scala:95:20
  assign io_schedule_bits_c_bits_way = meta_way;	// MSHR.scala:97:17
  assign io_schedule_bits_c_bits_dirty = meta_dirty;	// MSHR.scala:97:17
  assign io_schedule_bits_d_valid = _io_schedule_bits_d_valid_output;	// MSHR.scala:184:57
  assign io_schedule_bits_d_bits_prio_0 = request_prio_0;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_prio_2 = request_prio_2;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_opcode = request_opcode;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_param =
    req_acquire
      ? (request_param == 3'h1
           ? 3'h1
           : request_param == 3'h2
               ? {1'h0, meta_hit & (|(meta_clients & req_clientBit)) ? 2'h2 : 2'h1}
               : request_param == 3'h0
                   ? {2'h0,
                      req_acquire & (meta_hit ? ~(|meta_clients) & (&meta_state) : gotT)}
                   : 3'h0)
      : request_param;	// Cat.scala:30:58, MSHR.scala:94:30, :95:20, :97:17, :145:17, :216:53, :217:{25,39}, :218:{34,40,67,81}, :273:{30,47,64}, :295:41, :298:53, Mux.scala:80:{57,60}, Parameters.scala:278:43
  assign io_schedule_bits_d_bits_size = request_size;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_source = request_source;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_offset = request_offset;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_put = request_put;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_set = request_set;	// MSHR.scala:95:20
  assign io_schedule_bits_d_bits_way = meta_way;	// MSHR.scala:97:17
  assign io_schedule_bits_d_bits_bad = bad_grant;	// MSHR.scala:146:22
  assign io_schedule_bits_e_valid = _io_schedule_bits_e_valid_output;	// MSHR.scala:185:43
  assign io_schedule_bits_e_bits_sink = sink;	// MSHR.scala:144:17
  assign io_schedule_bits_x_valid = _io_schedule_bits_x_valid_output;	// MSHR.scala:186:40
  assign io_schedule_bits_dir_valid = _io_schedule_bits_dir_valid_output;	// MSHR.scala:187:66
  assign io_schedule_bits_dir_bits_set = request_set;	// MSHR.scala:95:20
  assign io_schedule_bits_dir_bits_way = meta_way;	// MSHR.scala:97:17
  assign io_schedule_bits_dir_bits_data_dirty =
    s_release & _io_schedule_bits_dir_bits_data_WIRE_dirty;	// MSHR.scala:121:33, :220:54, :248:20, :249:21, :307:41
  assign io_schedule_bits_dir_bits_data_state =
    s_release ? _io_schedule_bits_dir_bits_data_WIRE_state : 2'h0;	// MSHR.scala:121:33, :220:54, :248:20, :249:21, :307:41
  assign io_schedule_bits_dir_bits_data_clients =
    s_release ? _io_schedule_bits_dir_bits_data_WIRE_clients : 6'h0;	// MSHR.scala:121:33, :220:54, :223:56, :248:20, :249:21, :307:41
  assign io_schedule_bits_dir_bits_data_tag =
    s_release ? (_GEN_0 ? meta_tag : request_tag) : 13'h0;	// MSHR.scala:95:20, :97:17, :121:33, :220:54, :225:57, :244:30, :269:19, :307:41
  assign io_schedule_bits_reload = no_wait;	// MSHR.scala:180:83
endmodule

