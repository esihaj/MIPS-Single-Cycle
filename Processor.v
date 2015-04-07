module Processor(input clk, reset);
	wire [18:0] instruction;
	wire mem_write, reg_write, push, pop, alu_use_carry;
	wire [2:0] alu_op;
	wire [1:0] pc_mux, reg_write_mux;
	wire alu_in_mux,reg_B_mux, select_c, select_z, write_c, write_z;
	
	Controller cntrl(C, Z, instruction,
					mem_write, reg_write, push, pop, alu_use_carry,
					alu_op, pc_mux, 
					reg_write_mux, alu_in_mux,reg_B_mux,
					select_c, select_z, write_c, write_z);

	DataPath dp(clk, reset, 
				mem_write, reg_write, push, pop, alu_use_carry, alu_op,
				pc_mux, reg_write_mux, alu_in_mux,reg_B_mux,
				select_c, select_z, write_c, write_z,
				C, Z);
endmodule
