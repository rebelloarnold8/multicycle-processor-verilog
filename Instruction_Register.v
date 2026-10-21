module Instruction_Register(Instr,IRwrite,CLK,ReadData);
    input IRwrite,CLK;
    input [63:0]ReadData;
    output reg[63:0]Instr;
    always @(posedge CLK) begin
        if(IRwrite)
            Instr<=ReadData;
        else
            Instr<=Instr;
    end
endmodule