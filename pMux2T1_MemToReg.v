module pMux2T1_MemToReg(MemtoReg,AluOut,data,WD);
    input MemtoReg;
    input[63:0] AluOut,data;
    output [63:0]WD;
    assign WD=MemtoReg?data:AluOut;
endmodule
