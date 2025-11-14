// ucsbece154a_datapath.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


module ucsbece154a_datapath (
    input  logic        clk, reset_i,
    input  logic        PCSrc_i,
    output logic [31:0] PC_o,
    input  logic [31:0] Instr_i,
    input  logic        RegWrite_i,
    input  logic  [2:0] ImmSrc_i,
    input  logic        ALUSrc_i,
    input  logic  [2:0] ALUControl_i,
    output logic        Zero_o,
    output logic [31:0] ALUResult_o, WriteData_o,
    input  logic [31:0] ReadData_i,
    input  logic  [1:0] ResultSrc_i
);


`include "ucsbece154a_defines.svh"

/// Your code here
logic [31:0] rd1_o, rd2_o;
logic [31:0] ImmExt_o;
logic [31:0] ALUSrcB_i;
logic [31:0] Result_i;
logic [31:0] PCPlus4_o, PCTarget_o, PCNext_i;


// --------------------- MAIN INSTRUCTION EXECUTION (RF, Extend, and ALU) ---------------------
// Use name "rf" for a register file module so testbench file work properly (or modify testbench file) 
ucsbece154a_rf rf (
    clk, 
    Instr_i[19:15], Instr_i[24:20], Instr_i[11:7], // a1, a2, a3
    rd1_o, rd2_o,
    RegWrite_i,
    Result_i
);

assign WriteData_o = rd2_o; // for dmem

// extend immediate
always_comb begin
    case (ImmSrc_i)
        imm_Itype : ImmExt_o = {{20{Instr_i[31]}}, Instr_i[31:20]};                     
        imm_Stype : ImmExt_o = {{20{Instr_i[31]}}, Instr_i[31:25], Instr_i[11:7]};
        imm_Btype : ImmExt_o = {{20{Instr_i[31]}}, Instr_i[31], Instr_i[7], Instr_i[30:25], Instr_i[11:8]};
        imm_Jtype : ImmExt_o = {{20{Instr_i[31]}}, Instr_i[31], Instr_i[19:12], Instr_i[20], Instr_i[30:21]};
        imm_Utype : ImmExt_o = {{12{Instr_i[31]}}, Instr_i[31:12]};
        default: ImmExt_o = 32'd0;
    endcase
end

// ALU Src mux
always_comb begin
    case (ALUSrc_i)
        ALUSrc_reg : ALUSrcB_i = rd2_o;
        ALUSrc_imm : ALUSrcB_i = ImmExt_o;
    endcase
end

ucsbece154a_alu alu (
    .a(rd1_o), .b(ALUSrcB_i),
    .f(ALUControl_i),
    .result(ALUResult_o),
    .zero(Zero_o)
);

// mux for selecting between ALU_result or ReadData_i for WriteData_o
always_comb begin
    case (ResultSrc_i)
        ResultSrc_ALU : Result_i = ALUResult_o;
        ResultSrc_load : Result_i = ReadData_i;
        ResultSrc_jal : Result_i = PCPlus4_o;
        ResultSrc_lui : Result_i = ImmExt_o;
        default: Result_i = 32'd0;
    endcase
end


// --------------------- HANDLING FOR PC ---------------------

assign PCPlus4_o = PC_o + 32'd4;
assign PCTarget_o = PC_o + ImmExt_o;

assign PCNext_i = (PCSrc_i) ? PCTarget_o : PCPlus4_o;
always_ff @(posedge clk or posedge reset_i) begin
    if (reset_i)
        PC_o <= 32'd0;
    else
        PC_o <= PCNext_i; 
end


endmodule
