module Sign_Extend_Module(input [31:0]Instr,output [63:0]ImmExt);

    assign ImmExt={{32{Instr[31]}},Instr};
    
endmodule