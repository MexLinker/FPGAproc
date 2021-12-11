module trin(Y, E, F);

	//when E=1, pass Y to F

	parameter n = 8;
	
	input [n-1:0] Y;
	input E;
	output wire  [n-1:0] F;
	
	assign F = E ? Y:'bz;
	
//	assign F = Y;
	
endmodule 