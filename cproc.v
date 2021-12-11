module cproc(Data, Reset, w, clk, F, Rx, Ry, Done, BusWires, T, I, Extern, FuncReg, FRin, Xreg);

	//the c_proc means the continuous proc
	//删掉没用的变量，包括rest 与 clear
	
	
	//taril2
	output FRin;
	output [0:3] Xreg;
	output [0:3]T;
	output [0:3]I;
	output Extern;
	output [1:6]FuncReg; //调整位宽！！
	
	//record
	input [7:0] Data;
	input Reset, w, clk;
	input [1:0] F, Rx, Ry; //注意位宽
	output wire [7:0] BusWires;
	output Done;
	
	reg [0:3] Rin, Rout;
	reg [7:0] Sum;
	wire AddSub, Extern, Ain, Gin, Gout, FRin;
	wire [1:0] Count;
	wire [0:3] T, I, Xreg, Y;
	wire [7:0] R0, R1, R2, R3, A, G;
	wire [1:6] Func, FuncReg;
	integer k;
	
	upconunt counter(.clear(Reset), .clk(clk), .Q(Count));  //电路没有初态...
	dec2to4 decT(.in(Count), .out(T));
	
	assign Func = {F, Rx, Ry};
	assign FRin = w & T[0];
	
	regn functionreg(Func, FRin, clk, FuncReg);
		defparam functionreg.n = 6;
	dec2to4 decI(.in(FuncReg[1:2]), .out(I));
	dec2to4 decX(.in(FuncReg[3:4]), .out(Xreg));
	dec2to4 decY(.in(FuncReg[5:6]), .out(Y));
		
	//	dec2to4 decT(.in(Count), .out(T));
	
	assign Extern = I[0] & T[1]; //怎末回事啊，我怎么尝试都有问题！
	assign Done = ((I[0] | I[1]) & T[1] | ((I[2] | I[3]) & T[3]));  //why the init done = 1  ?
	assign Ain = (I[2] | I[3]) & T[1];
	assign Gin = (I[2] | I[3]) & T[2];
	assign Gout = (I[2] | I[3]) & T[3];
	assign AddSub = I[3];
	
	always@(I, T, Xreg, Y)
		for(k = 0; k < 4; k = k + 1)
		begin
			Rin[k]=((I[0]|I[1])&T[1]&Xreg[k]) | ((I[2] | I[3]) & T[3] & Xreg[k]);
			Rout[k]= (I[1] & T[1]&Y[k]) | ((I[2] | I[3]) & ((T[1] & Xreg[k]) | (T[2] & Y[k])));
		end
	
	trin tri_ext(.Y(Data), .E(Extern), .F(BusWires)); // important
	regn reg_0(BusWires, Rin[0], clk, R0 );
	regn reg_1(BusWires, Rin[1], clk, R1 );
	regn reg_2(BusWires, Rin[2], clk, R2 );
	regn reg_3(BusWires, Rin[3], clk, R3 );
	
	
	
	trin tri_0(.Y(R0), .E(Rout[0]), .F(BusWires));
	trin tri_1(.Y(R1), .E(Rout[1]), .F(BusWires));
	trin tri_2(.Y(R2), .E(Rout[2]), .F(BusWires));
	trin tri_3(.Y(R3), .E(Rout[3]), .F(BusWires));
	regn reg_A(BusWires, Ain, clk, A);
	
	
//	
//	//make the Reset work
//	always@(Reset)
//		
	
	
	//alu
	always@(AddSub, A, BusWires)
		if(!AddSub)
			Sum = A + BusWires;
		else
			Sum = A - BusWires;
	
	regn reg_G(Sum, Gin, clk, G); // ?
	trin tri_G(.Y(G), .E(Gout), .F(BusWires));
	
endmodule
	
	
	