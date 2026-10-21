module full_adder_64bit_tb;

parameter CLK_PERIOD = 10; 
reg clk;
reg [63:0] a;
reg [63:0] b;
reg cin;
wire [63:0] s;
wire cout;
//reg a0,a1,a2,a3,b0,b1,b2,b3,cin;
//wire s, s1, s2, s3, cout;
full_adder_64bit gate1(s,cout,a,b,cin);
/* reg [15:0] count1;
	reg [15:0] count2;
	initial
	for(count1 =0;count1<256;count1=count1+1)begin
		for(count2 =0;count2<256;count2=count2+1)begin
			b=count1;
			a=count2;
			cin=0;
			#10;
			b=count1;
			a=count2;
			cin=1;
			#10;
		end
	end
	*/
	
	always #((CLK_PERIOD)/2) clk = ~clk;
	initial begin 
	a = 64'h0000000000000000;
    b = 64'h0000000000000000;
    cin = 1'b0;
	#10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; cin = 1'b1;	// max value + max value
    #10 a = 64'h7FFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; // max signed int + max value
    #10 a = 64'h0000000000000000; b = 64'h0000000000000001; // 0 + 1
    #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; // -1 + 1
    #10 a = 64'h7FFFFFFFFFFFFFFF; b = 64'h0000000000000001; // max signed int + 1
	
	end
	
endmodule 