module stack(input clk, push, pop, input [11:0] data_in, output reg [11:0] data_out);
	reg [11:0] registers [7:0];
	reg [2:0] top = 3'b0;
	
	always@(posedge clk) begin
		if(push) begin
			registers [top] = data_in;
			top = top + 3'b1;
		end
		else if (pop)
			top = top - 3'b1; 
	end 
	always@(top)
		data_out = registers [top-3'b1];
	
endmodule

module test_stack();
	wire [11:0] out;
	reg clk = 0, push = 0, pop = 0;
	reg [11:0] in;
	stack st(clk, push,pop, in, out);
	
	initial repeat(20) #5 clk = ~clk;
	
	initial begin
		in = 12'd31;
		push = 1;
		#12 in = 12'd1023;
		#10 push = 0; pop = 1;
		#30 $stop;
	end
	
endmodule