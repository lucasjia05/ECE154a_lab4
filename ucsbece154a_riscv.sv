// ucsbece154a_riscv.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


// ports are roughly specified from left to right as they are shown in the design

module ucsbece154a_riscv (
    input  logic        clk, reset_i,
    output logic [31:0] PC_o,
    input  logic [31:0] Instr_i,
    output logic        MemWrite_o,
    output logic [31:0] ALUResult_o, WriteData_o,
    input  logic [31:0] ReadData_i 
);

logic  [1:0] ResultSrc;
logic  [2:0] ImmSrc;
logic        PCSrc, ALUSrc, RegWrite, Zero;
logic  [2:0] ALUControl;


// ports are roughly specified in counterclock wise order as they are shown for control unit in the design figure starting with "op"

ucsbece154a_controller c (
    Instr_i[6:0], Instr_i[14:12], Instr_i[30], Zero,
    RegWrite, ImmSrc, ALUSrc,
    ALUControl, MemWrite_o, ResultSrc,
    PCSrc
);

// ports are roughly specified from left to right as they are shown for datapath

ucsbece154a_datapath dp (
    clk, reset_i,
    PCSrc, PC_o, Instr_i,
    RegWrite, ImmSrc, ALUSrc, 
    ALUControl, Zero, 
    ALUResult_o, WriteData_o, ReadData_i,
    ResultSrc
);

endmodule
