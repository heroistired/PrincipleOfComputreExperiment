module Divider1 (clk,clkout);
input clk;
output reg clkout;
reg [31:0]num;

always @(posedge clk)
begin
	if (num==100000) num=0;
	else num=num+1;
	if (num>50000) clkout=1;
	else clkout=0;
	end
endmodule