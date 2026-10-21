module sr_flipflop (
    input clk,
	 input reset,
	 input s,
    input r,
    output reg q,
    output reg q_bar
);


always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 1'b0; // Reset
        q_bar <= 1'b1;
    end else if (s && ~r) begin
        q <= 1'b0; // Set
        q_bar <= 1'b1;
    end else if (~s && r) begin
        q <= 1'b1; // Reset
        q_bar <= 1'b0;
    end else if (s && r) begin
        q <= q;     // Hold state (undefined behavior)
        q_bar <= q_bar;
    end else begin
        q <= 1'b1;     // No change
        q_bar <= 1'b1;
    end
end

endmodule

module d_flipflop
(
    input clk,
	 input reset,
	 input d,
    output reg q,
    output reg q_bar
);

sr_flipflop dff(clk, reset, d,~d,q,q_bar);
endmodule


