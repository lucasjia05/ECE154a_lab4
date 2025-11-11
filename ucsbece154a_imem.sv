// ucsbece154a_imem.sv
// All Rights Reserved
// Copyright (c) 2025 UCSB ECE
// Distribution Prohibited


module ucsbece154a_imem (
    input  logic  [31:0] a_i,
    output logic  [31:0] rd_o
);

localparam NUM_WORDS = 64;
localparam ADDR_WIDTH = $clog2(NUM_WORDS);

logic [31:0] RAM [0:NUM_WORDS-1];

// initialize memory with test program. Change this with memfile2.dat for the modified code
initial $readmemh("memfile.dat", RAM);

assign rd_o = RAM[a_i[ADDR_WIDTH+1:2]]; // word aligned

`ifdef SIM
always_comb begin
    if (a_i[1:0]!=2'b0)
        $warning("Attempted to access invalid address 0x%h. Address coerced to 0x%h.", a_i, (a_i&(~32'b11)));
end
`endif

endmodule
