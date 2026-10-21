module Multicycle_Processor(input CLK, reset);

    wire PC_Enable, IorD, MemWrite, IRwrite, RegDst, MemtoReg, RegWrite;
    wire AluSrcA, ALUControl, PCSrc, Branch, zero;
    wire [1:0]  ALUSrcB;
    wire [11:0] opcode, Funct;

    Datapath dp(PC_Enable,CLK,reset,IorD,MemWrite,IRwrite,RegDst,MemtoReg,RegWrite,AluSrcA,ALUControl,PCSrc,ALUSrcB,zero,opcode,Funct);
    Control_Unit cu(CLK,reset,opcode,Funct,zero,IRwrite,MemWrite,Branch,RegWrite,PC_Enable,MemtoReg,RegDst,IorD,PCSrc,AluSrcA,ALUSrcB,ALUControl);

endmodule
