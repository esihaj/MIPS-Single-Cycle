//comment help :  [/ASM Command]
//@TODO change = to <= (non-blocking)
//select_(c,z) : mux to select which input connects to C/Z FF
module Controller(input clk, reset, C, Z, input [18:0] instruction, output reg mem_write, reg_write, push, pop, output alu_use_carry, output [2:0] alu_op, output reg [1:0] pc_mux, reg_write_mux, output reg alu_in_mux,reg_B_mux, select_c, select_z, write_c, write_z);
	//ALU
	ALUController alu_cntrl(instruction, alu_use_carry, alu_op);//in ha ro wire gereftam ke rahat betoonam be in yeki module pas bedameshoon
	//Shifter
	wire do_branch;
	ShifterController shift_cntrl(instruction, C, Z, do_branch);
	//Others
	always@(instruction, C,Z, do_branch) begin
		$display("instruction T-%t %b", $time, instruction);
		{pc_mux, reg_write_mux, alu_in_mux,reg_B_mux, select_c, select_z, write_c, write_z} = 0;
		{mem_write, reg_write, push, pop} = 0;
		casex(instruction[18:16])
			3'b100:	begin //memory
				mem_write = instruction[14];//on [/STM]
				reg_write = ~instruction[14];//on [/LDM]
				reg_B_mux = 1'b1;
				alu_in_mux = 1'b1;
				reg_write_mux = 2'b10;
			end
			3'b0??: begin //Arithmetic
				reg_write = 1'b1;
				reg_B_mux = 1'b0;
				alu_in_mux = instruction[17]; //immediate or register
				reg_write_mux = 2'b0;
				{select_c, select_z} = 2'b00;
				{write_c, write_z}   = 2'b11;
			end
			3'b110:begin //Shift
				reg_write = 1'b1;
				reg_write_mux = 2'b01;
				{select_c, select_z} = 2'b11;
				{write_c, write_z}   = 2'b11;
			end
		endcase
		
		//stack
		if(instruction[18:14] == 5'b11101)//[/JSB]
			push = 1'b1;
		else if(instruction[18:13] == 6'b111100)
			pop = 1'b1;
		
		//PC
		casex(instruction[18:14])
			5'b101??:begin //Branch
				if(do_branch)//if Branch controller confirms a branch operation
					pc_mux = 2'b01;
				else pc_mux = 2'b00;
			end
			5'b1110?: pc_mux = 2'b10;//[/JMP], [/JSB]
			5'b11110: pc_mux = 2'b11;//[/RET]
			default : pc_mux = 2'b00;//default
		endcase
	end
endmodule

module ShifterController(input [18:0] instruction,input C,Z, output reg do_branch);
	always@(instruction, C,Z)
		if(instruction[18:16] == 3'b101)
			if(instruction[15] == 1'b0)			
				 do_branch = instruction[14] ? ~Z : Z;
			else do_branch = instruction[14] ? ~C : C;
endmodule
	
module ALUController(input [18:0] instruction,output reg alu_use_carry, output reg [2:0] alu_op);
	always@(instruction) begin
		{alu_use_carry, alu_op} = 0;
		//? == don't care
		casex(instruction[18:16])//operation
			3'b00?:begin //Arithmetic
				alu_op = instruction[16:14];
				alu_use_carry  =instruction[14];
			end
			3'b01?:begin //Arithmetic immediate
				alu_op = instruction[16:14];
				alu_use_carry = instruction[14];
			end
			3'b110: begin //[add] base address + offset 
				alu_op = 3'b000;
				alu_use_carry = 1'b0;
			end
		endcase
	end
endmodule

module test_controller();
	reg C, Z, clk = 1'b0, reset = 1'b0;
	reg [18:0] instruction;
	wire mem_write, reg_write, push, pop, alu_use_carry;
	wire [2:0] alu_op;
	wire [1:0] pc_mux, reg_write_mux;
	wire alu_in_mux,reg_B_mux, select_c, select_z, write_c, write_z;
	
	Controller cntrl(clk, reset, C, Z, instruction,
					mem_write, reg_write, push, pop, alu_use_carry,
					alu_op, pc_mux, 
					reg_write_mux, alu_in_mux,reg_B_mux,
					select_c, select_z, write_c, write_z);
	initial repeat(10) #5 clk = ~clk;
	initial begin
		instruction = 19'b0100000100000001010; C = 1'b0; Z = 1'b0;
		#10 instruction = 19'b0100001000000000101; 
		#10 instruction = 19'b0000001100101000000;
		#10 $stop;
	end
	
endmodule