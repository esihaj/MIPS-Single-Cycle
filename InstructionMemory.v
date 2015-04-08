module InstMem(input [11:0] addr, output reg [18:0] out_data);

	reg [18:0] registers [4095:0];
	initial $readmemb("prgm2.bin", registers);
	
	always@(addr) begin
		out_data = registers[addr];
	end
endmodule

module test_inst_memory();

	reg [11:0] addr;
	wire [18:0]	out_data;
	
	InstMem mem(addr,out_data);
	
	initial begin
	addr = 12'd5;
	#2 addr = 12'd3;
	#2 $stop;
	end
endmodule