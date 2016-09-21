module Translator (clk,num,data_out);
input [3:0]num;
input clk;
output reg[7:0]data_out;

always @(posedge clk)
begin
if (num==4'b0000) begin //0
	data_out = 8'b11000000;
	end
else if (num==4'b0001) begin //1
	data_out = 8'b11111001;
	end
else if (num==4'b0010) begin //2
	data_out = 8'b10100100;
	end
else if (num==4'b0011) begin //3
	data_out = 8'b10110000;
	end
else if (num==4'b0100) begin //4
	data_out = 8'b10011001;
	end
else if (num==4'b0101) begin //5
	data_out = 8'b10010010;
	end
else if (num==4'b0110) begin //6
	data_out = 8'b10000011;
	end
else if (num==4'b0111) begin //7
	data_out = 8'b11111000;
	end
else if (num==4'b1000) begin //8
	data_out = 8'b10000000;
	end
else if (num==4'b1001) begin //9
	data_out = 8'b10011000;
	end
end
endmodule
	





