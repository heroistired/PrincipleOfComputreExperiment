module Flag(Flagin,CLK,Reset,wrflag,Flagout);
input [7:0]Flagin;
input CLK;
input Reset;
input wrflag;
output reg [7:0]Flagout;

always @(posedge CLK)
begin
	if (Reset) begin
		if (wrflag==1) begin
			Flagout = Flagin;
		end
		else begin
			Flagout = Flagout;
		end
	end
	else begin
		Flagout = 0;
	end
end
endmodule
