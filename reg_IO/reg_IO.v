module reg_IO(IO0,IO1,clk,wr_L,wr_H,reset,data_inH,data_inL);
input [7:0]IO0;
input [7:0]IO1;
input clk;
input wr_L;
input wr_H;
input reset;
output reg [7:0]data_inH;
output reg [7:0]data_inL;

always @(posedge clk) begin
	if (reset) begin 
		if (wr_L==1) begin
			data_inL = IO0;
		end
		if (wr_H==1) begin
			data_inH = IO1;
		end
		else begin
			data_inH = data_inH;
			data_inL = data_inL;
		end
	end
	else begin
		data_inH = 0;
		data_inL = 0;
	end
end
endmodule
