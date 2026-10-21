
module full_subtractor_64bit(
output [63:0] d2,
output bo2,
input [63:0] a2,
input [63:0] b2,
input bin2
);

wire c21,c22,c23;
full_subtractor_16bit g21(d2 [15:0],c21,a2 [15:0],b2 [15:0],bin2);
full_subtractor_16bit g22(d2 [31:16],c22,a2 [31:16],b2 [31:16],c21);
full_subtractor_16bit g23(d2 [47:32],c23,a2 [47:32],b2 [47:32],c22);
full_subtractor_16bit g24(d2 [63:48],bo2,a2 [63:48],b2 [63:48],c23);
endmodule

module full_subtractor_16bit(
output [15:0] d1,
output bo1,
input [15:0] a1,
input [15:0] b1,
input bin1
);

wire c11,c12,c13;
full_subtractor_4bit g11(d1 [3:0],c11,a1 [3:0],b1 [3:0],bin1);
full_subtractor_4bit g12(d1 [7:4],c12,a1 [7:4],b1 [7:4],c11);
full_subtractor_4bit g13(d1 [11:8],c13,a1 [11:8],b1 [11:8],c12);
full_subtractor_4bit g14(d1 [15:12],bo1,a1 [15:12],b1 [15:12],c13);
endmodule


module full_subtractor_4bit(
output [3:0] d,
output bo,
input [3:0] a,
input [3:0] b,
input bin
);
	wire c1,c2,c3,c4,c5;
	full_subtractor_gate g1(d[0],c1,a[0],b[0],bin);
	full_subtractor_gate g2(d[1],c2,a[1],b[1],c1);
	full_subtractor_gate g3(d[2],c3,a[2],b[2],c2);
	full_subtractor_gate g4(d[3],bo,a[3],b[3],c3);
endmodule


module full_subtractor_gate(
    output difference,borrowOut,input a,b,borrowIn
    );

assign difference = a ^ b ^ borrowIn;
assign borrowOut = (~a & b)|(borrowIn&~(a^b));
                
endmodule