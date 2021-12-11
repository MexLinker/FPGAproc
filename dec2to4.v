module dec2to4(in, out);

	//00 -- 0001
	//01 -- 0010
	//10 -- 0100
	//11 -- 1000

	input [1:0] in;
	output reg [3:0] out;
	
	always@(in)
		casex(in)
//			'b11: out=8;
//			'b10: out=4;
//			'b01: out=2;
//			'b00: out=1;
			
			'b11: out=1;
			'b10: out=2;
			'b01: out=4;
			'b00: out=8; // 尝试重写？？？
//			
			default: out=1;
		endcase
		
endmodule