module InterfazIO(
	input						clk_i,
	input						rst_ni,
	inout			[7:0]		DataA_io,
	inout			[7:0]		DataB_io,
	inout			[7:0]		DataC_io,
	input			[7:0]		data_i,
	input			[1:0]		dir_i,
	//input						dir_ctl,
	input						wr_i,
	input						rd_i,
	output reg	[7:0]		data_o
);
	
	wire	[1:0] ctl_data_o;
	wire	[7:0]	dataA_iw;
	wire	[7:0]	dataB_iw;
	wire	[7:0]	dataC_iw;
	wire			sel_w;
	reg	[3:0]	wrsel_w;
	
	assign sel_w = 1'b1;
	
	always @(*)
	begin
		case (dir_i)
			2'b00:
				begin
					wrsel_w[0] <= sel_w;
					wrsel_w[1] <= 1'b0;
					wrsel_w[2] <= 1'b0;
					wrsel_w[3] <= 1'b0;
				end
			2'b01:
				begin
					wrsel_w[0] <= 1'b0;
					wrsel_w[1] <= sel_w;
					wrsel_w[2] <= 1'b0;
					wrsel_w[3] <= 1'b0;
				end
			2'b10:
				begin
					wrsel_w[0] <= 1'b0;
					wrsel_w[1] <= 1'b0;
					wrsel_w[2] <= sel_w;
					wrsel_w[3] <= 1'b0;
				end
			2'b11:
				begin
					wrsel_w[0] <= 1'b0;
					wrsel_w[1] <= 1'b0;
					wrsel_w[2] <= 1'b0;
					wrsel_w[3] <= sel_w;
				end
//			default:
//				wrsel_w <= 4'b0000;
			
		endcase
	end
	
	always @(*)
	begin
		case (dir_i)
			2'b00:
				begin
					data_o <= 8'b0;
				end
			2'b01:
				begin
					data_o <= dataA_iw;
				end
			2'b10:
				begin
					data_o <= dataB_iw;
				end
			2'b11:
				begin
					data_o <= dataC_iw;
				end
			default:
				data_o <= 8'b0;
		endcase
	end
	
	TRC TRC_U0(
		.clk_i			(clk_i),
	   .rst_ni			(rst_ni),
	   .ctl_data_i		(data_i[1:0]),
	   .wr_i				(wr_i),
	   .rd_i				(rd_i),
		.sel_i			(wrsel_w[0]),
	   .ctl_data_o		(ctl_data_o)
	);
	
	RegIO RegIO_A(
		.clk_i			(clk_i),
		.int_data_i		(data_i),
		.ext_data_io	(DataA_io),
		.dir_ctl			(ctl_data_o[0]),
		.wr_i				(wr_i),
		.rd_i				(rd_i),
		.sel_i			(wrsel_w[1]),
		.int_data_o		(dataA_iw)
	);
	
	RegIO RegIO_B(
		.clk_i			(clk_i),
		.int_data_i		(data_i),
		.ext_data_io	(DataB_io),
		.dir_ctl			(!ctl_data_o[0]),
		.wr_i				(wr_i),
		.rd_i				(rd_i),
		.sel_i			(wrsel_w[2]),
		.int_data_o		(dataB_iw)
	);
	
	RegIO RegIO_C(
		.clk_i			(clk_i),
		.int_data_i		(data_i),
		.ext_data_io	(DataC_io),
		.dir_ctl			(ctl_data_o[1]),
		.wr_i				(wr_i),
		.rd_i				(rd_i),
		.sel_i			(wrsel_w[3]),
		.int_data_o		(dataC_iw)
	);
	

endmodule
