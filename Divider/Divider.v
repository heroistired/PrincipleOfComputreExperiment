module Divider (clk,clkout);
input clk;
output reg clkout;
reg [3:0]num;

always @(posedge clk)
begin
	if (num==9) num=0;
	else num=num+1;
	if (num>4) clkout=1;
	else clkout=0;
	end	
endmodule