module Datapath(PC_Enable,CLK,reset,IorD,MemWrite,IRwrite,RegDst,MemtoReg,RegWrite,AluSrcA,ALUControl,PCSrc,AluSrcB,zero,opcode,Funct);

    input PC_Enable,CLK,reset,IorD,MemWrite,IRwrite,RegDst,MemtoReg,RegWrite,AluSrcA,ALUControl,PCSrc;
    input [1:0]AluSrcB;
    output zero;
    output [11:0]opcode,Funct;

    wire [63:0]PC,PCNext,Addr,ReadData,Instr,Data,ImmExt,rdData1,rdData2,WD,A,B,SrcA,SrcB,ALUResult,ALUOut;
    wire [9:0]A3;

    // Instruction format (64-bit):
    //   R: opcode[63:52] rs[51:42] rt[41:32] rd[31:22] ... funct[11:0]
    //   I: opcode[63:52] rs[51:42] rt[41:32] imm[31:0]
    assign opcode=Instr[63:52];
    assign Funct=Instr[11:0];

    Program_Counter pc(PC,CLK,reset,PCNext,PC_Enable);
    IorD_Mux ID(IorD,PC,ALUOut,Addr);
    Instruction_Memory mem(Addr,MemWrite,CLK,B,ReadData);
    Instruction_Register IR(Instr,IRwrite,CLK,ReadData);
    Data_Register dataReg(CLK,Data,ReadData);
    RegDst_Mux RDst(RegDst,Instr[41:32],Instr[31:22],A3);
    Sign_Extend_Module sign(Instr[31:0],ImmExt);
    pMux2T1_MemToReg MemTReg(MemtoReg,ALUOut,Data,WD);
    Register_File regFile(rdData1,rdData2,WD,CLK,RegWrite,Instr[51:42],Instr[41:32],A3);
    regA64 regA(CLK,rdData1,A);
    regB64 regB(CLK,rdData2,B);
    pMux2T1_AluSrcA AluSrcA1(AluSrcA,PC,A,SrcA);
    pMux4T1_SrcB MuxSrcB(AluSrcB,B,ImmExt,SrcB);
    ALU alu(SrcA,SrcB,ALUResult,ALUControl,zero);
    ALU_Result_Buffer temp(CLK,ALUResult,ALUOut);
    pMux2T1_PCSrc MuxPCSrc(PCSrc,ALUResult,ALUOut,PCNext);

endmodule
