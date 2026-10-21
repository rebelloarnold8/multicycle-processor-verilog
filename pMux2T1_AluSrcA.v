module pMux2T1_AluSrcA(AluScrA,PC,A,SrcA);
    input AluScrA;
    input[63:0] PC,A;
    output [63:0]SrcA;
    assign SrcA=AluScrA?A:PC;
endmodule