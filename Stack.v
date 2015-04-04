module stack(input clk, push, pop, input [7:0] data_in, output reg [7:0] data_out);
	reg [11:0] registers [7:0];
	reg [2:0] top = 3'b0;
	
	always@(clk) begin
		if(push) begin
			registers [top+1] <= data_in;
			top <= top + 3'b1;
			
		end
		else if (pop)
			top = top - 3'b1; 
	end 
	always@(top)
		data_out = registers [top];
	
endmodule