module not_gate_64bit (
    input [63:0] a,
    output reg [63:0] out
);

always @(a)
	out = ~a;

endmodule
