// Unified instruction/data memory: 1024 x 64-bit words, byte-addressed
// (word index = addr[12:3]). Combinational read so the IR / Data register
// capture the word at the end of the same cycle; synchronous write.
module Instruction_Memory(addr,WE,clk,WriteData,ReadData);
    input clk,WE;
    input [63:0]addr,WriteData;
    output [63:0]ReadData;
    reg [63:0]mem[1023:0];

    assign ReadData=mem[addr[12:3]];

    always @(posedge clk) begin
        if(WE)
            mem[addr[12:3]]<=WriteData;
    end
endmodule
