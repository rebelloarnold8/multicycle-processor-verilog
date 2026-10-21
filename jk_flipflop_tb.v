module jk_flipflop_tb;

// Parameters
parameter CLK_PERIOD = 10; // Clock period in time units

// Signals
reg j, k, clk, reset;
wire q, q_bar;

// Instantiate the JK flip-flop
jk_flipflop uut (
    .j(j),
    .k(k),
    .clk(clk),
    .reset(reset),
    .q(q),
    .q_bar(q_bar)
);

// Clock generation
always #((CLK_PERIOD)/2) clk = ~clk;

// Stimulus generation
initial begin
    // Initialize inputs
    j = 1'b0;
k = 1'b0;
reset = 1;
clk=1;
 
#100
reset=0;
j=1'b1;
k=1'b0;

#100
reset=0;
j=1'b1;
k=1'b1;
 
#100
reset=0;
j=1'b0;
k=1'b1;
 
#100
reset=0;
j=1'b1;
k=1'b1;
 
#100
reset=0;
j=1'b0;
k=1'b0;
 
#100
reset=0;
j=1'b1;
k=1'b0;

#100 $finish;
end
always #25 clk <= ~clk;


// Monitor for displaying outputs
always @(posedge clk) begin
    $display("Time=%0t: j=%b, k=%b, q=%b, q_bar=%b", $time, j, k, q, q_bar);
end

endmodule