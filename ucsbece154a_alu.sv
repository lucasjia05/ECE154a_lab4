//`timescale 1ns/1ps
//`default_nettype none
//------------------------------------------------------------------------------
// 32-bit ALU (SystemVerilog)
// Operations (RISC-V/H&H style):
//   ALUcontrol_add -> ADD
//   ALUcontrol_sub -> SUB
//   ALUcontrol_and -> AND
//   ALUcontrol_or -> OR
//   ALUcontrol_slt -> SLT (signed set-less-than)
// Flags:
//   zero     : (result == 0)
//   overflow : signed overflow for ADD/SUB, 0 for logic ops
//   carry    : carry out of adder for ADD/SUB (for SUB this is ~borrow)
//   negative : result[31]
// Notes:
//   Uses a single adder for ADD, SUB, and SLT (per lab restriction).
//------------------------------------------------------------------------------
module ucsbece154a_alu(
  input  logic [31:0] a,
  input  logic [31:0] b,
  input  logic [2:0]  f,
  output logic [31:0] result,
  output logic        zero,
  output logic        overflow,
  output logic        carry,
  output logic        negative
);

 `include "ucsbece154a_defines.svh"

  // Determine if operation is subtraction-like (SUB or SLT)
  logic do_sub;
  assign do_sub = (f == ALUcontrol_sub) | (f == ALUcontrol_slt);

  // Single adder path for ADD/SUB/SLT
  logic [31:0] b_in;
  logic [31:0] sum;
  logic        cout;

  assign b_in = do_sub ? ~b : b;

  // One 32-bit add; cout is carry-out (for SUB this is ~borrow)
  assign {cout, sum} = a + b_in + (do_sub ? 32'd1 : 32'd0);

  // Signed overflow detection
  logic ovf_addsub;
  always_comb begin
    unique case (1'b1)
      // ADD: a[31]==b[31] and sum[31]!=a[31]
      (f == ALUcontrol_add): ovf_addsub = (a[31] == b[31]) && (sum[31] != a[31]);
      // SUB: a[31]!=b[31] and sum[31]!=a[31]
      (f == ALUcontrol_sub): ovf_addsub = (a[31] != b[31]) && (sum[31] != a[31]);
      default      : ovf_addsub = 1'b0;
    endcase
  end

  // SLT bit: (a < b) signed using (a - b) sign ^ overflow
  logic  slt_bit;
  assign slt_bit = sum[31] ^ ((f == 3'b111) ? ((a[31] != b[31]) && (sum[31] != a[31])) : 1'b0);

  // Result mux
  always_comb begin
    unique case (f)
      ALUcontrol_and: result = a & b;
      ALUcontrol_or:  result = a | b;
      ALUcontrol_add: result = sum;                        // ADD
      ALUcontrol_sub: result = sum;                        // SUB
      ALUcontrol_slt: result = {31'b0, slt_bit};           // SLT (signed)
      default: result = 32'h00000000;
    endcase
  end

  // Flags
  assign zero     = (result == 32'h00000000);
  assign overflow = ovf_addsub;                   // only meaningful for ADD/SUB
  assign carry    = ((f == ALUcontrol_add) || (f == ALUcontrol_sub)) ? cout : 1'b0;
  assign negative = result[31];

endmodule
//`default_nettype wire
