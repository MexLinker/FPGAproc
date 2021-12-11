module controller(init, ifDone, clk, en, frr, Data, Reset);

	input init, ifDone, en, clk;
	output Reset;
	output reg [5:0] frr;
	output reg [7:0] Data;
	
//	wire Reset;
//	reg address;
//	reg [15:0] q;
//	
//	theROM rom1 (address, clk, q);
//	
//	assign [5:0] frr = q[5:0];
//	assign [7:0] Data = q[14:6];
//	assign Reset = q[15];
//	
//	always@(negedge clk) // 注意done的时间！
//		if(ifDone)
//			adress <= adress + 1;
//			Reset = 1;
//		else
//			Rest = 0;
endmodule