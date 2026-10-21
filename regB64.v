module regB64(CLK,ReadData2,B);
    input CLK;
    input [63:0]ReadData2;
    output reg [63:0]B;
    always @(posedge CLK) begin
        B<=ReadData2;
    end
endmodule