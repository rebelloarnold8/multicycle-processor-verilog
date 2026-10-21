module ALU_Result_Buffer(CLK,ALUResult,ALUOut);
    input CLK;
    input[63:0] ALUResult;
    output reg [63:0]ALUOut;
    always @(posedge CLK) begin
        ALUOut<=ALUResult;
    end
endmodule