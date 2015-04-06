module DataPath(input clk, mem_write, reg_write, push, pop, input [2:0] alu_op);
//PC
//Instruction memory
//register file
//ALU
//shifter
//dataMemory
//sign extend
	
	//wires and registers
	//pc & inst Memory
	reg  [11:0] pc;
	wire [18:0] instruction;
	
	//data memory
	reg  [7:0] mem_addr, mem_write_data;
	wire [7:0] mem_out_data;
	
	//reg file
	reg  [2:0] reg_addr_A, reg_addr_B, reg_addr_write;
	reg  [7:0] reg_write_data;
	wire [7:0]	reg_data_A, reg_data_B;
	
	//stack
	reg  [11:0] stack_in;
	wire [11:0] stack_out;
	
	//ALU
	reg [7:0] alu_A, alu_B;
	reg alu_cin;
	wire [7:0] alu_out;
	wire alu_co, alu_z;

	//Shifter
	wire shift_c, shift_z;
	reg [7:0] shift_data; 
	reg [2:0] bitcount;
	reg dir, sh_roBar;
	wire [7:0] shift_out;
	
	//Modules
	InstMem inst_mem (pc,instruction);
	DataMem data_mem (clk, mem_write, mem_addr , mem_write_data, mem_out_data);
	RegFile reg_file (clk, reg_write, reg_addr_A, reg_addr_B, reg_addr_write, reg_write_data, reg_data_A, reg_data_B);
	Stack 	stack(clk, push,pop, stack_in, stack_out);
	ALU 	alu(alu_op , alu_A, alu_B, alu_cin, alu_out, alu_co, alu_z); 
	BarrelShifter bs(data, bitcount,  dir, sh_roBar, shift_out, shift_c, shift_z);
	
	

	always @(instruction) begin //calculate the new pc
	end
	
	always @(posedge clk)begin //set new values to registers
	end 
	
endmodule
