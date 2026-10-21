module pMux2T1_PCSrc(PCSrc,ALUResult,AluOut,PCNext);
    input PCSrc;
    input[63:0] ALUResult,AluOut;
    output [63:0]PCNext;
    assign PCNext=PCSrc?AluOut:ALUResult;
endmodule