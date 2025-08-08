module SumadorRestador(
		//Señales de control
		input			enable_i,			//Resource Vector Add/Sub bit
		input			fun7_bit6_i,	//Bit 6 Function 7
		//Señales para sumador
		input			[31:0] a_i,
		input			[31:0] b_i,
		//input					 cin_i,
		output		[31:0] suma_o,
		output				 cout_o

);
	reg [31:0] opeb_w;
	reg		  cin_w;
	
	always @(*)
	begin
		if (fun7_bit6_i) begin //Es una resta
			opeb_w = ~(b_i);
			cin_w  = 1'b1;
		end
		
		else begin		//Es suma
			opeb_w = b_i;
			cin_w  = 1'b0;
		end
	end
	
	Sumador AddSub_U0(
      .a_i		(a_i),
		.b_i		(opeb_w),
		.c_i		(cin_w),
		.s_o		(suma_o),
		.c_o		(cout_o)
);
	

endmodule