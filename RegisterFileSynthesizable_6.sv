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

module RegisterFileSynthesizable_6(
  input         clock,
                reset,
  input  [6:0]  io_read_ports_0_addr,
                io_read_ports_1_addr,
                io_read_ports_2_addr,
  input         io_write_ports_0_valid,
  input  [6:0]  io_write_ports_0_bits_addr,
  input  [64:0] io_write_ports_0_bits_data,
  input         io_write_ports_1_valid,
  input  [6:0]  io_write_ports_1_bits_addr,
  input  [64:0] io_write_ports_1_bits_data,
  output [64:0] io_read_ports_0_data,
                io_read_ports_1_data,
                io_read_ports_2_data
);

  reg [6:0] read_addrs_0;	// regfile.scala:125:50
  reg [6:0] read_addrs_1;	// regfile.scala:125:50
  reg [6:0] read_addrs_2;	// regfile.scala:125:50
  `ifndef SYNTHESIS	// regfile.scala:171:15
    always @(posedge clock) begin	// regfile.scala:171:15
      if (~(~io_write_ports_0_valid | ~io_write_ports_1_valid
            | io_write_ports_0_bits_addr != io_write_ports_1_bits_addr
            | io_write_ports_0_bits_addr == 7'h0 | reset)) begin	// regfile.scala:171:{15,16}, :172:16, :173:45, :174:45
        if (`ASSERT_VERBOSE_COND_)	// regfile.scala:171:15
          $error("Assertion failed: [regfile] too many writers a register\n    at regfile.scala:171 assert(!io.write_ports(i).valid ||\n");	// regfile.scala:171:15
        if (`STOP_COND_)	// regfile.scala:171:15
          $fatal;	// regfile.scala:171:15
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    read_addrs_0 <= io_read_ports_0_addr;	// regfile.scala:125:50
    read_addrs_1 <= io_read_ports_1_addr;	// regfile.scala:125:50
    read_addrs_2 <= io_read_ports_2_addr;	// regfile.scala:125:50
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
        read_addrs_0 = _RANDOM[/*Zero width*/ 1'b0][6:0];	// regfile.scala:125:50
        read_addrs_1 = _RANDOM[/*Zero width*/ 1'b0][13:7];	// regfile.scala:125:50
        read_addrs_2 = _RANDOM[/*Zero width*/ 1'b0][20:14];	// regfile.scala:125:50
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  regfile_64x65 regfile_ext (	// regfile.scala:117:20
    .R0_addr (read_addrs_2[5:0]),	// regfile.scala:125:50, :128:28
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (read_addrs_1[5:0]),	// regfile.scala:125:50, :128:28
    .R1_en   (1'h1),
    .R1_clk  (clock),
    .R2_addr (read_addrs_0[5:0]),	// regfile.scala:125:50, :128:28
    .R2_en   (1'h1),
    .R2_clk  (clock),
    .W0_addr (io_write_ports_1_bits_addr[5:0]),	// regfile.scala:163:14
    .W0_en   (io_write_ports_1_valid),
    .W0_clk  (clock),
    .W0_data (io_write_ports_1_bits_data),
    .W1_addr (io_write_ports_0_bits_addr[5:0]),	// regfile.scala:163:14
    .W1_en   (io_write_ports_0_valid),
    .W1_clk  (clock),
    .W1_data (io_write_ports_0_bits_data),
    .R0_data (io_read_ports_2_data),
    .R1_data (io_read_ports_1_data),
    .R2_data (io_read_ports_0_data)
  );
endmodule

