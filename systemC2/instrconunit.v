module instrconunit (branch,jump,clk,reset,imm,PC);
input branch;
input jump;
input clk;
input reset;
input [7:0]imm;
output reg [7:0]PC;

always @(posedge clk)
begin
if (!reset) begin
	PC <= 0;
end
else begin
	if (branch==0 && jump==0) begin
		PC = PC +1;
	end
	else begin
		if (jump==1) begin
			PC <= imm;
		end
		else if (branch==1 && jump==0) begin
			PC <= PC + imm +1;
		end
	end
end
end
endmodule
