// ucsbece154a_rf.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


module ucsbece154a_rf (
    input  logic         clk,
    input  logic  [4:0]  a1_i, a2_i, a3_i,
    output logic  [31:0] rd1_o, rd2_o,
    input  logic         we3_i,
    input  logic  [31:0] wd3_i
);

logic [31:0] MEM [0:31]; // = '{default:32'b0};

assign rd1_o = (a1_i == 5'd0) ? '0 : MEM[a1_i];
assign rd2_o = (a2_i == 5'd0) ? '0 : MEM[a2_i];

// Single clocked process owns all writes to MEM
always_ff @(posedge clk) begin
      MEM[0] <= '0;                  // keep x0 pinned to zero every cycle
      if (we3_i && (a3_i != 5'd0))
        MEM[a3_i] <= wd3_i;
`ifdef SIM
      if (we3_i && (a3_i == 5'd0))
        $warning("Attempted to write to $zero register");
`endif
end

`ifdef SIM
logic [31:0] zero, ra, sp, gp, tp, t0, t1, t2, t3, t4, t5, t6;
logic [31:0] a0, a1, a2, a3, a4, a5, a6, a7;
logic [31:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11; 

assign zero = MEM[5'd0];
assign ra = MEM[5'd1];
assign sp = MEM[5'd2];
assign gp = MEM[5'd3];
assign tp = MEM[5'd4];
assign t0 = MEM[5'd5];
assign t1 = MEM[5'd6];
assign t2 = MEM[5'd7];
assign s0 = MEM[5'd8];
assign s1 = MEM[5'd9];
assign a0 = MEM[5'd10];
assign a1 = MEM[5'd11];
assign a2 = MEM[5'd12];
assign a3 = MEM[5'd13];
assign a4 = MEM[5'd14];
assign a5 = MEM[5'd15];
assign a6 = MEM[5'd16];
assign a7 = MEM[5'd17];
assign s2 = MEM[5'd18];
assign s3 = MEM[5'd19];
assign s4 = MEM[5'd20];
assign s5 = MEM[5'd21];
assign s6 = MEM[5'd22];
assign s7 = MEM[5'd23];
assign s8 = MEM[5'd24];
assign s9 = MEM[5'd25];
assign s10 = MEM[5'd26];
assign s11 = MEM[5'd27];
assign t3 = MEM[5'd28];
assign t4 = MEM[5'd29];
assign t5 = MEM[5'd30];
assign t6 = MEM[5'd31];
`endif

endmodule
