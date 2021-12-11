module regn(R, en, clk, Q);
	//chanege in postedge
	//when en enable, the regn will change



	parameter n = 8;
	input [n-1:0] R;
	input en, clk;
	output reg [n-1:0] Q;
	
	always@(posedge clk)
		if(en)
			Q <= R;

endmodule
		