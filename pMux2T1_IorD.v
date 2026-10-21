module pMux2T1_IorD(IorD,PC,data,Addr);
    input IorD;
    input[63:0] PC,data;
    output [63:0]Addr;
    assign Addr=IorD?data:PC;
endmodule