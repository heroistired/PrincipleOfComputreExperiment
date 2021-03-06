module ALU(CS,data_a,data_b,carry_in,S,zero,carry_out);
input [2:0]CS; //operation
input [7:0]data_a;
input [7:0]data_b;
input carry_in;
output reg [7:0]S; //result
output reg zero;
output reg carry_out;

reg [8:0]sum;

always @(CS,data_a,data_b,carry_in)
begin
	if (CS==3'b000) begin //and
		S = data_a & data_b;
	end
	else if (CS==3'b001) begin //or
		S = data_a | data_b;
	end
	else if (CS==3'b010) begin //add
		sum = data_a + data_b;
		if (sum > 8'b11111111) begin
			carry_out = 1;
			S = sum - 9'b100000000;
		end
		else begin
			carry_out = 0;
			S = sum;
		end
	end
	else if (CS==3'b011) begin //sub
		S = data_a - data_b;
		if (data_a < data_b) begin
			carry_out = 0;
		end
		else begin
			carry_out = 1;
		end
	end
	else if (CS==3'b100) begin //addc
		S = data_a + data_b + carry_in;
	end
	else if (CS==3'b101) begin //subc
		S = data_a - data_b - (1-carry_in);
	end
	else if (CS==3'b110) begin //cmp
		if (data_a < data_b) begin
			S = 1;
		end
		else begin
			S = 0;
		end
	end
	if (S==0) begin
		zero = 1;
	end
	else begin
		zero = 0;
	end
end
endmodule 		
				
				