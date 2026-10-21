module ALU(SrcA,SrcB,ALUResult,ALUControl,zero);
    input  [63:0]SrcA,SrcB;           // Operand A and B
    input  ALUControl;                // 0 = add, 1 = sub
    output reg [63:0]ALUResult;
    output zero;                      // Flag for branch instructions

    always @(*) begin
        case (ALUControl)
            1'b0: ALUResult=SrcA+SrcB;
            1'b1: ALUResult=SrcA-SrcB;
            default: ALUResult=64'bx;
        endcase
    end

    assign zero=(ALUResult==64'd0);
endmodule
