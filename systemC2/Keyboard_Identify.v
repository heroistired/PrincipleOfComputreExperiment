module Keyboard_Identify(clk,H,V,out,stop,symbol);
input [3:0]H; //row
input [3:0]V; //column
input clk;
output reg [3:0]out;
output reg [3:0]symbol;
output stop;

assign stop=H[3]||H[2]||H[1]||H[0];

parameter S0=0, S1=1;

reg state=S0;

always@(posedge clk)
begin
case (state)

S0:
begin
if (stop==0) begin
	state <=S0;
	out <=4'b0000;
	symbol <=4'b0000;
end
else begin
	state <=S1;
end
end

S1:
begin
if (stop==1)
begin
state <=S1;
	if (H[0]) 
	begin
		
		if (V==4'b0001) 
		begin
			out<=4'b0001; //1
			symbol<=4'b1111;
		end
		else if (V==4'b0010)
		begin
			out<=4'b0010; //2
			symbol<=4'b1111;
		end
		else if (V==4'b0100)
		begin 
			out<=4'b0011; //3
			symbol<=4'b1111;
		end
		else if (V==4'b1000)
		begin
			out<=4'b0100; //4
			symbol<=4'b1111;
		end
	end
	
	else if (H[1])
	begin
		
		if (V==4'b0001)
		begin
			out<=4'b0101; //5
			symbol<=4'b1111;
		end
		else if (V==4'b0010)
		begin
			out<=4'b0110; //6
			symbol<=4'b1111;
		end
		else if (V==4'b0100)
		begin
			out<=4'b0111; //7
			symbol<=4'b1111;
		end
		else if (V==4'b1000)
		begin
			out<=4'b1000; //8
			symbol<=4'b1111;
		end
	end
	
	else if(H[2])
	begin
		
		if (V==4'b0001)
		begin
			out<=4'b1001; //9
			symbol<=4'b1111;
		end
		else if (V==4'b0010)
		begin
			out<=4'b0000;
			symbol<=4'b0001; //+
		end 
		else if (V==4'b0100)
		begin
			out<=4'b0000;
			symbol<=4'b0010; //-
		end
		else if (V==4'b1000)
		begin
			out<=4'b0000;
			symbol<=4'b0011; //and
		end
	end
	
	else if(H[3])
	begin

		if (V==4'b0001)
		begin
			out<=4'b0000; //0
			symbol<=4'b1111;
		end
		else if (V==4'b0010)
		begin
			out<=4'b0000;
			symbol<=4'b0100; //=
		end 
		else if (V==4'b0100)
		begin
			out<=4'b0000;
			symbol<=4'b0101; //cmp
		end
		else if (V==4'b1000)
		begin
			out<=4'b0000;
			symbol<=4'b0110; //or
		end
	end
	
	else begin
		out <=4'b0000;
		symbol <=4'b0000;
	    end
end
else begin
	state <=S0;
end
end
endcase
end
endmodule
