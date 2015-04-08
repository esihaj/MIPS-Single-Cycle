module DataMem(input clk, mem_write, input [7:0] addr ,
						input [7:0] write_data, output reg [7:0] out_data);

	reg [7:0] registers [255:0];
	initial $readmemb("mem2.bin", registers);
	
	always@(addr) begin
		out_data = registers[addr];
	end
	
	always@(posedge clk) begin
		if(mem_write) 
			registers[addr] = write_data;
		out_data = registers[addr];
	end
endmodule
/*
module test_data_memory();

	reg clk = 0, mem_write;
	reg [7:0] addr;
	reg [7:0] write_data;
	wire [7:0]	out_data;
	
	DataMem mem (clk, mem_write, addr ,write_data, out_data);
	initial repeat(20) #5 clk = ~clk;
	
	initial begin
	addr = 8'd5;
	write_data = 8'd15;
	mem_write = 1'b1;
	#22 $stop;
	end
endmodule*/