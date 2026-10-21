module jk_flipflop (
    input j,
    input k,
    input clk,
    input reset,
    output reg q,
    output reg q_bar
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 1'b0;
        q_bar <= 1'b1;
    end else if (~j && ~k) begin
            q <= q; // No change
            q_bar <= q_bar; // No change
        end else if (j && k) begin
            q <= ~q; // No change
            q_bar <= ~q_bar; // No change
        end else if (j) begin
            q <= 1'b1;
            q_bar <= 1'b0;
        end else if (k) begin
            q <= 1'b0;
            q_bar <= 1'b1;
        end
    end


endmodule

module t_flipflop
(
	input clk,
	 input reset,
	 input t,
    output reg q,
    output reg q_bar
);

jk_flipflop tff(t,t,clk,reset,q,q_bar);

endmodule
