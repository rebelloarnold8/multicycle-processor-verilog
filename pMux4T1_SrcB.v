module pMux4T1_SrcB(AluSrcB,B,ImmExt,SrcB);
    input [1:0] AluSrcB;
    input[63:0] B,ImmExt;
    output reg[63:0]SrcB;

    always @(*) begin
        case (AluSrcB)
            2'd0:SrcB=B;
            2'd1:SrcB=64'd8;          // PC + 8 (64-bit instructions)
            2'd2:SrcB=ImmExt;
            2'd3:SrcB=ImmExt<<3;      // branch offset in instructions -> bytes
        endcase
    end
endmodule
