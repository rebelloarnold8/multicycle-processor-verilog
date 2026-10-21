module full_subtractor_64bit_tb;

parameter CLK_PERIOD = 10; 
reg clk;
reg [63:0] a;
reg [63:0] b;
reg bin;
wire [63:0] d;
wire bout;

full_subtractor_64bit gate1(d,bout,a,b,bin);

always #((CLK_PERIOD)/2) clk = ~clk;
	initial begin 
	a = 64'h0000000000000000;
    b = 64'h0000000000000000;
    bin = 1'b0;
	 #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; bin = 1'b1; // 1 - 1 with borrow-in
    #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; bin = 1'b0; // 1 - 1 without borrow-in
    #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; bin = 1'b1; // max value - max value with borrow-in
    #10 a = 64'h7FFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; bin = 1'b0; // max signed int - max value without borrow-in
    #10 a = 64'h0000000000000000; b = 64'h0000000000000001; bin = 1'b0; // 0 - 1 without borrow-in
    
	
	end
	
endmodule 