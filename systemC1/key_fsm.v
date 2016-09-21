module key_fsm (clk,reset,num,symbol,key,SRCH,SRCL,DSTH,DSTL,ALU_OP,finish,num_display,num_A0,num_A1,num_A2,num_B0,num_B1,num_B2,DST,SRC);
input clk;
input reset;
input [3:0]num; //identified num
input [3:0]symbol; //identified symbol
input key; //a signal to mark a keyboard input after shake
output reg [7:0]SRCH;
output reg [7:0]SRCL;
output reg [7:0]DSTH;
output reg [7:0]DSTL;
output reg [7:0]ALU_OP;
output reg finish;
output reg num_display; //decide which number to display while inputing
output [3:0]num_A0;
output [3:0]num_A1;
output [3:0]num_A2;
output [3:0]num_B0;
output [3:0]num_B1;
output [3:0]num_B2;
output [15:0]DST;
output [15:0]SRC;

//declare states
parameter [1:0]idle=2'b00;
parameter [1:0]firstnum=2'b01;
parameter [1:0]oper=2'b10;
parameter [1:0]secondnum=2'b11;

//define initial values & other parameters
reg [2:0]state=idle;
reg [3:0]num_A0=0;
reg [3:0]num_A1=0;
reg [3:0]num_A2=0;
reg [3:0]num_B0;
reg [3:0]num_B1;
reg [3:0]num_B2;
reg [1:0]cnt=0;
reg judge; //to judge if the key is still pressed

assign SRC = (num_A2[3:0])*100+(num_A1[3:0])*10+num_A0[3:0];
assign DST = (num_B2[3:0])*100+(num_B1[3:0])*10+num_B0[3:0];

always @(posedge clk)
begin
	if (!reset) begin
		num_A0 <= 0;
		num_A1 <= 0;
		num_A2 <= 0;
		num_B0 <= 0;
		num_B1 <= 0;
		num_B2 <= 0;
		ALU_OP <= 8'b00000000;
		state <= idle;
		cnt <= 0;
	end
	else begin
	case (state)
	idle: //no input
		begin
			judge <= 1;
			if (symbol==4'b1111 && key==1 && judge==1) begin //if there is a number input
				num_A0 <= num;
				num_A1 <= 0;
				num_A2 <= 0;
				num_B0 <= 0;
				num_B1 <= 0;
				num_B2 <= 0;
				ALU_OP <= 8'b00000000;
				cnt <= cnt+1; //1st digit is saveds
				state <= firstnum;
				num_display <= 0; //display the first number
				judge <= 0;
				finish <= 0;
			end
			else begin
				state <= idle;
			end
		end
		
	firstnum: //inputing first number
		begin
			if (key==1) begin
				judge <= 0;
			end
			else begin
				judge <= 1;
			end
			if (cnt < 2'b11) begin 
				if (symbol==4'b1111 && key==1 && judge==1) begin 
					num_A2 <= num_A1;
					num_A1 <= num_A0;
					num_A0 <= num;
					cnt <= cnt+1; 
					state <= firstnum;
				end
				else if (symbol==4'b0001 && key==1) begin //+
					ALU_OP <= 8'b00000001;
					state <= oper;
					judge <= 1;
					cnt <= 0;
				end
				else if (symbol==4'b0010 && key==1) begin //-
					ALU_OP <= 8'b00000010;
					cnt <= 0;
					judge <= 1;
					state <= oper;
				end
				else if (symbol==4'b0011 && key==1) begin //and
					ALU_OP <= 8'b00000100;
					cnt <= 0;
					state <= oper;
					judge <= 1;
				end 
				else if (symbol==4'b0101 && key==1) begin //cmp
					ALU_OP <= 8'b00001000;
					cnt <= 0;
					state <= oper;
					judge <= 1;
				end
				else if (symbol==4'b0110 && key==1) begin //or
					ALU_OP <= 8'b00010000;
					cnt <=0;
					state <= oper;
					judge <= 1;
				end
				else begin
					state <= firstnum;
				end
			end
			else if (cnt==2'b11) begin //3 digits full
				if (symbol==4'b0001 && key==1 && judge==1) begin //+
					ALU_OP <= 8'b00000001;
					state <= oper;
					judge <= 1;
					cnt <= 0;
				end
				else if (symbol==4'b0010 && key==1) begin //-
					ALU_OP <= 8'b00000010;
					cnt <= 0;
					state <= oper;
					judge <= 1;
				end
				else if (symbol==4'b0011 && key==1) begin //and
					ALU_OP <= 8'b00000100;
					cnt <= 0;
					state <= oper;
					judge <= 1;
				end 
				else if (symbol==4'b0101 && key==1) begin //cmp
					ALU_OP <= 8'b00001000;
					cnt <= 0;
					state <= oper;
					judge <= 1;
				end
				else if (symbol==4'b0110 && key==1) begin //or
					ALU_OP <= 8'b00010000;
					cnt <=0;
					state <= oper;
					judge <= 1;
				end
				else begin
					state <= firstnum;
				end
			end
		end
		
	oper: 
		begin
				if (key==1) begin
					judge <= 0;
				end
				else begin
					judge <= 1;
				end
				if (symbol==4'b1111 && key==1 && judge==1) begin
					num_B0 <= num;
					cnt <= cnt + 1;
					state <= secondnum;
					num_display <= 1; //start to display second number
				end
				else begin
					state <= oper;
				end
		end
		
	secondnum: //inputing second number
		begin
				if (key==1) begin
					judge <= 0;
				end
				else begin
					judge <= 1;
				end
				if (cnt < 2'b11) begin 
					if (symbol==4'b1111 && key==1 && judge==1) begin //2nd digit
						num_B2 <= num_B1;
						num_B1 <= num_B0;
						num_B0 <= num;
						cnt <= cnt+1; //2nd digit is saved
						state <= secondnum;
					end
					else if (symbol==4'b0100 && key==1) begin //=
						cnt <= 0;
						finish <= 1;
						//translating numbers
						SRCH[7:0] <= SRC[15:8];
						SRCL[7:0] <= SRC[7:0];
						DSTH[7:0] <= DST[15:8];
						DSTL[7:0] <= DST[7:0];
						state <= idle;
					end
					else begin
						state <= secondnum;
					end
				end
				else if (cnt==2'b11) begin //3 digits full
					if (symbol==4'b0100 && key==1) begin //=
						cnt <= 0;
						finish <= 1;
						//translating numbers
						SRCH[7:0] <= SRC[15:8];
						SRCL[7:0] <= SRC[7:0];
						DSTH[7:0] <= DST[15:8];
						DSTL[7:0] <= DST[7:0];
						state <= idle;
					end
					else begin
						state <= secondnum;
					end
				end
		end
	endcase
	end
end
endmodule
					
					
					
				
				