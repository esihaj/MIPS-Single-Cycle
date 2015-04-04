module RegFile(input clk, reg_write, input [2:0] addr_A, addr_B, addr_write ,
						input [7:0] write_data, output reg [7:0] data_A, data_B);

	reg [7:0] registers [7:0];
	
	always@(addr_A, addr_B) begin
		registers[0] = 8'b0;
		data_A = registers[addr_A];
		data_B = registers[addr_B];
	end
	
	always@(posedge clk) begin
		if(reg_write) 
			registers[addr_write] = write_data;
		registers[0] = 8'b0;
	end
endmodule
/*
module test_reg_file();
	reg clk = 0, reg_write;
	reg [2:0] addr_A, addr_B, addr_write;
	reg [7:0] write_data;
	wire [7:0]	data_A, data_B;
	
	RegFile rg(clk, reg_write, addr_A, addr_B, addr_write, write_data, data_A, data_B);
	initial repeat(20) #5 clk = ~clk;
	
	initial begin
	addr_A = 0;
	addr_B = 0;
	addr_write = 3'b100;
	reg_write = 1'b1;
	write_data = 8'd5;
	#10 addr_A = 3'b100;
	addr_write = 3'b0;
	reg_write = 1'b1;
	write_data = 8'd5;
	#11 reg_write =  1'b0;
	addr_write = 3'b001;
	write_data = 8'd3;
	addr_A = 3'b001;
	#20 $stop;
	end
endmodule*/