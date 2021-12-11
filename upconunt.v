module upconunt(clear, clk, Q);

	//00 => 01 => 10 => 11 => 00 => ..
	
	parameter n = 2;
	
	input clear, clk;
	output reg [n-1:0] Q;
	
	always @ (posedge clk)
		if(clear)
			Q <= 0;
		else
			Q <= Q + 1;
			
endmodule
	