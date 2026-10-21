module sr_flipflop_tb;

reg clk;
reg reset;
reg s,r;
 
wire q;
wire qb;
// Instantiate the 1-bit SR flip-flop
sr_flipflop srflipflop( .clk(clk), .reset(reset), .s(s), .r(r), .q(q), .q_bar(qb) );
// Clock generation
initial begin
$monitor(clk,s,r,q,qb,reset);
 
s = 1'b0;
r = 1'b0;
reset = 1;
clk=1;
 
#100
reset=0;
s=1'b1;
r=1'b0;

#100
reset=0;
s=1'b1;
r=1'b1;
 
#100
reset=0;
s=1'b0;
r=1'b1;
 
#100
reset=0;
s=1'b1;
r=1'b1;
 
#100
reset=0;
s=1'b0;
r=1'b0;
 
#100
reset=0;
s=1'b1;
r=1'b0;

#100
$finish;
end
always #25 clk <= ~clk;
 
endmodule