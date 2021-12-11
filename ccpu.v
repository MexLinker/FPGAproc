module ccpu(Data, Reset, w, clk, F, Rx, Ry, Done, BusWires, T, I, Extern, FuncReg, FRin, Xreg, address, q);


//	input in;
//	output out;
//	assign out = in;

	//trial3
	input [3:0] address;
	output [15:0] q;
	
	
	output FRin;
	output [0:3] Xreg;
	output [0:3]T;	
	output [0:3]I;
	output Extern;
	output [0:5] FuncReg;
	input [7:0] Data;
	input Reset, w, clk;
	input [1:0] F, Rx, Ry;
	output wire [7:0] BusWires;
	output Done;
	
	cproc procTest(Data, Reset, w, clk, F, Rx, Ry, Done, BusWires, T, I, Extern, FuncReg, FRin, Xreg);
	
	theROM rom1 (address, clk, q);
	
endmodule