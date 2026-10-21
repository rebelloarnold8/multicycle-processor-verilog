module Program_Counter(PC,CLK,reset,PCNext,PC_Enable);
    output reg [63:0]PC;
    input [63:0]PCNext;
    input CLK,reset,PC_Enable;

    always @(posedge CLK, posedge reset) begin
        if(reset)
            PC<=0;
        else if(PC_Enable)
            PC<=PCNext;
    end
endmodule
