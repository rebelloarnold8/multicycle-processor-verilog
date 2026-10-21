module regA64(CLK,ReadData1,A);
    input CLK;
    input [63:0]ReadData1;
    output reg [63:0]A;
    always @(posedge CLK) begin
        A<=ReadData1;
    end
endmodule