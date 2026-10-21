module Control_Unit(clk,reset,opcode,Funct,zero,IRwrite,MemWrite,Branch,RegWrite,PC_Enable,MemtoReg,RegDst,IorD,PCSrc,AluSrcA,ALUSrcB,ALUControl);
    input clk,reset;
    input [11:0]opcode;
    input [11:0]Funct;
    input zero;
    output reg IRwrite,MemWrite,Branch,RegWrite;        // Register enable signals
    output PC_Enable;
    output reg MemtoReg,RegDst,IorD,PCSrc,AluSrcA,ALUControl;   // Mux select signals
    output reg [1:0]ALUSrcB;                             // Mux select signal

    reg [1:0]ALUOp;
    reg PCWrite;

    localparam OP_R=0, OP_BEQ=4, OP_LW=35, OP_SW=43;
    localparam F_ADD=32, F_SUB=34;
    localparam Fetch=0,Decode=1,MemAdr=2,MemRead=3,MemWB=4,MemWrite1=5,ExecuteR=6,ALUWB=7,BEQ=8;
    reg [3:0]state,nextState;

    // State register
    always @(posedge clk, posedge reset) begin
        if(reset) state<=Fetch;
        else      state<=nextState;
    end

    assign PC_Enable=(Branch && zero) || PCWrite;

    // Next-state and output logic (Moore)
    always @(*) begin
        // defaults: nothing written, muxes don't-care-but-defined
        IRwrite=0; MemWrite=0; Branch=0; RegWrite=0; PCWrite=0;
        MemtoReg=0; RegDst=0; IorD=0; PCSrc=0; AluSrcA=0; ALUSrcB=2'd0; ALUOp=2'd0;
        nextState=Fetch;

        case (state)
            Fetch: begin                // IR <- Mem[PC]; PC <- PC + 8
                IorD=0; AluSrcA=0; ALUSrcB=2'd1; ALUOp=2'd0;
                PCSrc=0; IRwrite=1; PCWrite=1;
                nextState=Decode;
            end
            Decode: begin               // A,B <- RF; ALUOut <- PC + (imm<<3)
                AluSrcA=0; ALUSrcB=2'd3; ALUOp=2'd0;
                case (opcode)
                    OP_LW, OP_SW: nextState=MemAdr;
                    OP_R:         nextState=ExecuteR;
                    OP_BEQ:       nextState=BEQ;
                    default:      nextState=Fetch;   // unknown opcode: skip
                endcase
            end
            MemAdr: begin               // ALUOut <- A + imm
                AluSrcA=1; ALUSrcB=2'd2; ALUOp=2'd0;
                nextState=(opcode==OP_SW) ? MemWrite1 : MemRead;
            end
            MemRead: begin              // Data <- Mem[ALUOut]
                IorD=1;
                nextState=MemWB;
            end
            MemWB: begin                // RF[rt] <- Data
                MemtoReg=1; RegDst=0; RegWrite=1;
                nextState=Fetch;
            end
            MemWrite1: begin            // Mem[ALUOut] <- B
                IorD=1; MemWrite=1;
                nextState=Fetch;
            end
            ExecuteR: begin             // ALUOut <- A op B
                AluSrcA=1; ALUSrcB=2'd0; ALUOp=2'd2;
                nextState=ALUWB;
            end
            ALUWB: begin                // RF[rd] <- ALUOut
                RegDst=1; MemtoReg=0; RegWrite=1;
                nextState=Fetch;
            end
            BEQ: begin                  // if (A-B==0) PC <- ALUOut
                AluSrcA=1; ALUSrcB=2'd0; ALUOp=2'd1;
                PCSrc=1; Branch=1;
                nextState=Fetch;
            end
            default: nextState=Fetch;
        endcase
    end

    // ALU decoder
    always @(*) begin
        case (ALUOp)
            2'd0: ALUControl=0;                         // add
            2'd1: ALUControl=1;                         // sub
            2'd2: ALUControl=(Funct==F_SUB) ? 1'b1 : 1'b0;  // R-type: add / sub
            default: ALUControl=0;
        endcase
    end

endmodule
