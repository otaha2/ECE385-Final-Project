module KeyPress(
						input [7:0] keycode,
						input press, Clk,
						output logic [7:0] keypress
					);
					
					
/*
keycode[0] = P2Punch (8'h70)
keycode[1] = P2Right (8'h74)
keycode[2] = P2Left (8'h6b)
keycode[3] = P2UP (8'h75)
keycode[4] = P1Punch (8'h29)
keycode[5] = P1Right (8'h23)
keycode[6] = P1Left (8'h1c)
keycode[7] = P1UP (8'h1d)

*/
	
	//assign keypress = 8'h00;
	
	always_ff @(posedge Clk)
	begin
		case(keycode)
			8'h70 : keypress[0] <= press;
			8'h74 : keypress[1] <= press;
			8'h6b : keypress[2] <= press;
			8'h75 : keypress[3] <= press;
			8'h29 : keypress[4] <= press;
			8'h23 : keypress[5] <= press;
			8'h1c : keypress[6] <= press;
			8'h1d : keypress[7] <= press;
			//default : keypress <= 8'h;
		endcase

	end

endmodule
