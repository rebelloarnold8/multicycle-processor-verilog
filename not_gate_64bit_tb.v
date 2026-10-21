module not_gate_64bit_tb;

parameter CLK_PERIOD = 10;

reg [63:0] a;
wire [63:0] out;
reg clk;

not_gate_64bit instances (
    .a(a),
    .out(out)
);

always #((CLK_PERIOD)/2) clk = ~clk;

initial begin
	 a = 64'h0000000000000000;
	 #10 a = 64'hFFFFFFFFFFFFFFFF;
    #10 a = 64'h5555555555555555;
    #10 a = 64'hAAAAAAAAAAAAAAAA;
    #10 a = 64'hF0F0F0F0F0F0F0F0;
	  #10 $finish;
end

endmodule 
