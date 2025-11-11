// ucsbece154a_top.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


module ucsbece154a_top (input logic clk, reset_i);

logic [31:0] PC, Instr, ReadData;
logic [31:0] WriteData, DataAdr;
logic        MemWrite;

// processor and memories are instantiated here
ucsbece154a_riscv riscv (clk, reset_i, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);

ucsbece154a_imem imem (PC, Instr);

ucsbece154a_dmem dmem (clk, MemWrite, DataAdr, WriteData, ReadData);

endmodule
