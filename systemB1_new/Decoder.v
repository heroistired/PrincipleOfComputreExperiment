module Decoder(data_inH,data_inL,num_C3,num_C2,num_C1,num_C0,sign);
input [7:0]data_inH;
input [7:0]data_inL;
output reg [3:0]num_C3;
output reg [3:0]num_C2;
output reg [3:0]num_C1;
output reg [3:0]num_C0;
output reg sign;

reg [15:0]data_buf; //buffer of the 16-bit final result
reg [3:0]judge;
reg [7:0]data_inH_1;
reg [15:0]data_inH_2;

always @(data_inH,data_inL)
begin
	judge[3:0]=data_inH[7:4];
	if (judge==4'b1111) begin
		data_inH_1[7:0] = 0 - data_inH;
		data_inH_2[15:8] = data_inH_1[7:0];
		data_buf[15:0] = data_inH_2 - data_inL;
		sign = 1;
	end
	else begin
		data_buf[15:8] = data_inH;
		data_buf[7:0] = data_inL;
	end
	num_C3 = data_buf / 1000;
	num_C2 = (data_buf - 1000 * num_C3)/100;
	num_C1 = (data_buf - 1000 * num_C3 - 100 * num_C2)/10;
	num_C0 = data_buf - 1000 * num_C3 - 100 * num_C2 -10 * num_C1;
end
endmodule
