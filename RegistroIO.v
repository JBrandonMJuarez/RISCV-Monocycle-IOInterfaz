module RegistroIO(
			input						clk_i,
			input						rst_ni,
			input						rd_i,
			input						wr_i,
			input						sel_i,
			input			[31:0]	DATA_i,
			output	[31:0]	DATA_o
);
	reg	[31:0]	data_reg;

	always @(posedge clk_i, negedge rst_ni)
	begin
		if (!rst_ni)
			data_reg <= 32'b0;
		else
		begin
			if (sel_i && wr_i)
				data_reg <= DATA_i;
			else if (sel_i && rd_i)
				data_reg <= data_reg;
			//else
				//data_reg <= 32'b0;
		end
	end
	
	assign DATA_o =  data_reg;


endmodule
