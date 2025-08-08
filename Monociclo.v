module Monociclo(
	input								MAX10_CLK1_50,
	input 		     [1:0]		KEY,
	//input			[7:0]			dataA_in,
	//input			[7:0]			dataB_in,
	inout						[9:0]		SW,
	output		reg     [7:0]		HEX0,
	output		reg     [7:0]		HEX1,
	output		reg     [7:0]		HEX2,
	output		reg     [7:0]		HEX3
	
);
	wire [7:0]	dataA_in;
	wire [7:0]	dataB_in;

	always @(*)
	begin
		case (dataB_in)
			8'b11110111:
			begin
				HEX0 = ~dataA_in;
				HEX1 = 8'b11111111;
				HEX2 = 8'b11111111;
				HEX3 = 8'b11111111;
			end	
			8'b11111011:
				begin
				HEX0 = 8'b11111111;
				HEX1 = ~dataA_in;
				HEX2 = 8'b11111111;
				HEX3 = 8'b11111111;
			end	
			8'b11111101:
			begin
				HEX0 = 8'b11111111;
				HEX1 = 8'b11111111;
				HEX2 = ~dataA_in;
				HEX3 = 8'b11111111;
			end
			8'b11111110:
			begin
				HEX0 = 8'b11111111;
				HEX1 = 8'b11111111;
				HEX2 = 8'b11111111;
				HEX3 = ~dataA_in;
			end
			default:
			begin
				HEX0 = 8'b11111111;
				HEX1 = 8'b11111111;
				HEX2 = 8'b11111111;
				HEX3 = 8'b11111111;
			end
		endcase
	end
	
	
	MonocicloCore U0(
		.clk_i		(MAX10_CLK1_50),
		.rst_ni		(KEY[0]),		
		.DataA_io	(SW[7:0]),
		.DataB_io	(dataA_in),
		.DataC_io	(dataB_in)
	);


endmodule