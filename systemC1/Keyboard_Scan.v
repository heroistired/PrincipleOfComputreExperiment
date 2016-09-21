// Quartus II Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module Keyboard_Scan
(
	input	clk, in,
	output reg [3:0] out
);

	// Declare state register
	reg		[1:0]state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				out = 4'b0001;
			S1:
				out = 4'b0010;
			S2:
				out = 4'b0100;
			S3:
				out = 4'b1000;
			default:
				out = 4'b0001;
		endcase
	end

	// Determine the next state
	always @ (posedge clk)
	begin
		case (state)
				S0:
					if (!in)
						state <= S1;
					else
						state <= S0;
				S1:
					if (!in)
						state <= S2;
					else
						state <= S1;
				S2:
					if (!in)
						state <= S3;
					else
						state <= S2;
				S3:
					if (!in)
						state <= S0;
					else
						state <= S3;
		endcase
	end

endmodule
