// ucsbece154a_top_tb.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


`define SIM

`define ASSERT(CONDITION, MESSAGE) if ((CONDITION)==1'b1); else begin $error($sformatf MESSAGE); end

module ucsbece154a_top_tb ();

// test bench contents
logic clk = 1;
always #1 clk <= ~clk;
logic reset;

ucsbece154a_top top ( clk, reset );

logic [31:0] reg_zero, reg_ra, reg_sp, reg_gp, reg_tp;
logic [31:0] reg_t0, reg_t1, reg_t2, reg_t3, reg_t4, reg_t5, reg_t6;
logic [31:0] reg_s0, reg_s1, reg_s2, reg_s3, reg_s4, reg_s5, reg_s6, reg_s7, reg_s8, reg_s9, reg_s10, reg_s11;
logic [31:0] reg_a0, reg_a1, reg_a2, reg_a3, reg_a4, reg_a5, reg_a6, reg_a7;

assign reg_zero = top.riscv.dp.rf.zero;
assign reg_ra = top.riscv.dp.rf.ra;
assign reg_sp = top.riscv.dp.rf.sp;
assign reg_gp = top.riscv.dp.rf.gp;
assign reg_tp = top.riscv.dp.rf.tp;
assign reg_t0 = top.riscv.dp.rf.t0;
assign reg_t1 = top.riscv.dp.rf.t1;
assign reg_t2 = top.riscv.dp.rf.t2;
assign reg_s0 = top.riscv.dp.rf.s0;
assign reg_s1 = top.riscv.dp.rf.s1;
assign reg_a0 = top.riscv.dp.rf.a0;
assign reg_a1 = top.riscv.dp.rf.a1;
assign reg_a2 = top.riscv.dp.rf.a2;
assign reg_a3 = top.riscv.dp.rf.a3;
assign reg_a4 = top.riscv.dp.rf.a4;
assign reg_a5 = top.riscv.dp.rf.a5;
assign reg_a6 = top.riscv.dp.rf.a6;
assign reg_a7 = top.riscv.dp.rf.a7;
assign reg_s2 = top.riscv.dp.rf.s2;
assign reg_s3 = top.riscv.dp.rf.s3;
assign reg_s4 = top.riscv.dp.rf.s4;
assign reg_s5 = top.riscv.dp.rf.s5;
assign reg_s6 = top.riscv.dp.rf.s6;
assign reg_s7 = top.riscv.dp.rf.s7;
assign reg_s8 = top.riscv.dp.rf.s8;
assign reg_s9 = top.riscv.dp.rf.s9;
assign reg_s10 = top.riscv.dp.rf.s10;
assign reg_s11 = top.riscv.dp.rf.s11;
assign reg_t3 = top.riscv.dp.rf.t3;
assign reg_t4 = top.riscv.dp.rf.t4;
assign reg_t5 = top.riscv.dp.rf.t5;
assign reg_t6 = top.riscv.dp.rf.t6;
//




integer i;
initial begin
$display( "Begin simulation." );

//\\ =========================== \\//

reset = 1;
@(negedge clk);
@(negedge clk);
reset = 0;

// Test for program 1
// (you will need to implement your own test for program 2)
for (i = 0; i < 20; i=i+1)
    @(negedge clk);

`ASSERT(reg_zero==32'b0, ("reg_zero incorrect"));
`ASSERT(reg_sp==32'hBEEF000, ("reg_sp incorrect"));
`ASSERT(reg_gp==32'h44, ("reg_gp incorrect"));
`ASSERT(reg_tp==32'h1, ("reg_tp incorrect"));
`ASSERT(reg_t0==32'hb, ("reg_t0 incorrect"));
`ASSERT(reg_t2==32'h7, ("reg_t2 incorrect"));
`ASSERT(top.dmem.RAM[24]==32'h7, ("dmem.RAM[24] incorrect"));
`ASSERT(top.dmem.RAM[25]==32'h19, ("dmem.RAM[25] incorrect"));
`ASSERT(top.dmem.RAM[26]==32'hBEEF000, ("dmem.RAM[26] incorrect"));

//\\ =========================== \\//
$display( "End simulation.");
$stop;
end

endmodule

`undef ASSERT
