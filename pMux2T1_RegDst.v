module pMux2T1_RegDst(RegDst,rt,rd,Addr);
    input RegDst;
    input[9:0] rt,rd;
    output [9:0]Addr;
    assign Addr=RegDst?rd:rt;
endmodule