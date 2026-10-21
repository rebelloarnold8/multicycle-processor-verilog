module Instruction_Memory(addr,WE,clk,WriteData,ReadData);
    input clk,WE;
    output [63:0]ReadData;
    input [63:0]WriteData;
    input [63:0]addr;
    reg [63:0]data;
    reg[63:0]mem[1023:0];
    assign ReadData=data;
    always @(posedge clk) begin
        if(WE==0) 
            data<=mem[addr];
        else
            mem[addr]<=WriteData;
        
    end

endmodule