module full_adder_64bit(
output [63:0] s2,
output co2,
input [63:0] a2,
input [63:0] b2,
input cin2
);

wire c21,c22,c23;
full_adder_16bit g21(s2 [15:0],c21,a2 [15:0],b2 [15:0],cin2);
full_adder_16bit g22(s2 [31:16],c22,a2 [31:16],b2 [31:16],c21);
full_adder_16bit g23(s2 [47:32],c23,a2 [47:32],b2 [47:32],c22);
full_adder_16bit g24(s2 [63:48],co2,a2 [63:48],b2 [63:48],c23);
endmodule

module full_adder_16bit(
output [15:0] s1,
output co1,
input [15:0] a1,
input [15:0] b1,
input cin1
);

wire c11,c12,c13;
full_adder_4bit g11(s1 [3:0],c11,a1 [3:0],b1 [3:0],cin1);
full_adder_4bit g12(s1 [7:4],c12,a1 [7:4],b1 [7:4],c11);
full_adder_4bit g13(s1 [11:8],c13,a1 [11:8],b1 [11:8],c12);
full_adder_4bit g14(s1 [15:12],co1,a1 [15:12],b1 [15:12],c13);
endmodule

module full_adder_4bit(
output [3:0] s,
output co,
input [3:0] a,
input [3:0] b,
input cin
);
	wire c1,c2,c3,c4,c5;
	full_adder_gate g1(s[0],c1,a[0],b[0],cin);
	full_adder_gate g2(s[1],c2,a[1],b[1],c1);
	full_adder_gate g3(s[2],c3,a[2],b[2],c2);
	full_adder_gate g4(s[3],co,a[3],b[3],c3);
endmodule

module full_adder_gate(
    output sum,carry,input a,b,cin
    );

assign sum = a ^ b ^ cin;
assign carry = (a & b)|(b & cin)|(cin & a);
                
endmodule