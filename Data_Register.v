module Data_Register(CLK,data,ReadData);
    input CLK;
    input [63:0]ReadData;
    output reg[63:0]data;
    always @(posedge CLK) begin
        data<=ReadData;
        
    end
endmodule