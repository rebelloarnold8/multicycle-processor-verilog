module Register_File(rdData1,rdData2,wrData,clk,write,rs,rt,rd);
    input clk,write;
    input[9:0] rs,rt,rd;
    output[63:0] rdData1,rdData2;
    input[63:0] wrData;
    reg [63:0]regfile[0:64];

    assign rdData1=rs?regfile[rs]:0;
    assign rdData2=rt?regfile[rt]:0;

    always @(posedge clk) begin
        if(write) regfile[rd]<=wrData;
    end

endmodule