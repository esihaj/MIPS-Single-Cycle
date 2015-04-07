module DataPath(input clk, reset, mem_write, reg_write, push, pop, alu_use_carry, input [2:0] alu_op, input [1:0] pc_mux, input reg_write_mux, alu_in_mux,reg_B_mux, select_c, select_z, write_c, write_z);
//PC
//Instruction memory
//register file
//ALU
//shifter
//dataMemory
//sign extend
	
	//wires and registers
	//C & Z FlipFlop
	reg [7:0] C,Z;
	reg [7:0] next_C,next_Z;
	//pc & inst Memory
	reg  [11:0] pc, next_pc;
	wire [18:0] instruction;
	
	//reg file
	reg  [2:0] reg_addr_A, reg_addr_B, reg_addr_write;
	reg  [7:0] reg_write_data;
	wire [7:0]	reg_data_A, reg_data_B;
	
	//data memory
	reg  [7:0] mem_addr, mem_write_data;
	wire [7:0] mem_out_data;
	
	
	
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
		//PC
		case(pc_mux)
			2'b00: next_pc = pc + 1;
			2'b01: next_pc = pc + 1 + instruction[7:0];
			2'b10: next_pc = instruction[11:0];
			2'b11: next_pc = stack_out;
		endcase
		
		//Stack
		stack_in = pc + 1;
		
		//ALU
		alu_A = reg_data_A;
		case(alu_in_mux)
			1'b0: alu_B = reg_data_B;
			1'b1: alu_B = instruction[7:0];
		endcase 
		alu_cin = alu_use_carry ? C : 1'b0;
		
		//Data Memory
		mem_addr = alu_out;
		mem_write_data = reg_data_B;
		
		//Shifter
		bitcount = instruction[8:5];
		sh_roBar = instruction[15];
		dir = instruction[14];
		shift_data = reg_data_A;
		
		//RegFile
		reg_addr_A = instruction[10:8];
		case(reg_B_mux)
			1'b0: reg_addr_B = instruction[7:5];
			1'b1: reg_addr_B = instruction[13:11];
		endcase
		reg_addr_write = instruction[13:11];
		case(reg_write_mux)
			2'b00: reg_write_data = alu_out;
			2'b01: reg_write_data = shift_out;
			2'b10: reg_write_data = mem_out_data;
		endcase
		
		//C & Z FlipFlop
		case(select_c)
			1'b0: next_C = alu_co;
			1'b1: next_C = shift_c;
		endcase
		case(select_z)
			1'b0: next_Z = alu_z;
			1'b1: next_Z = shift_z;
		endcase
	end
	
	always @(posedge clk)begin //set new values to registers
		if(reset == 1'b0) begin
			pc = next_pc;
			if(write_c)
				C = next_C;
			if(write_z)
				Z = next_Z;
		end
		else begin
			{pc,C,Z} = 0;
		end
	end 
endmodule