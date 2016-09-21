module Display (clk,num_C3,num_C2,num_C1,num_C0,num_A2,num_A1,num_A0,num_B2,num_B1,num_B0,num_display,finish,out,seg_sel);
input [3:0]num_C3;
input [3:0]num_C2;
input [3:0]num_C1;
input [3:0]num_C0;
input [3:0]num_A2;
input [3:0]num_A1;
input [3:0]num_A0;
input [3:0]num_B2;
input [3:0]num_B1;
input [3:0]num_B0;
input num_display;
input finish;
input clk;
output reg [3:0]out;
output reg [3:0]seg_sel;

//declare states
parameter S0=0,S1=1,S2=2,S3=3;

reg [1:0]state=0;

always @(posedge clk)
begin
	case (state)
		S0: 
		begin
			seg_sel <= 4'b0001;
			if (finish==1) begin
				out <= num_C2;
			end
			else begin
				if (num_display==0) begin
					out <= num_A2;
				end
				else begin
					out <= num_B2;
				end
			end
			state <= S1;
		end
		
		S1:
		begin
			seg_sel <= 4'b0010;
			if (finish==1) begin
				out <= num_C1;
			end
			else begin
				if (num_display==0) begin
					out <= num_A1;
				end
				else begin
					out <= num_B1;
				end
			end
			state <= S2;
		end
		
		S2:
		begin
			seg_sel <= 4'b0100;
			if (finish==1) begin
				out <= num_C0;
			end
			else begin
				if (num_display==0) begin
					out <= num_A0;
				end
				else begin
					out <= num_B0;
				end
			end
			state <= S3;
		end
		
		S3:
		begin
			seg_sel <= 4'b1000;
			state <= S0;

			if (finish==1) begin
				out <= num_C3;
			end
			else begin
				out <= 0;
			end
		end
	endcase
end
endmodule
