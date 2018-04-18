module player1(input frame_clk, Reset, Clk, 
					input [7:0] keycode,
					output logic [9:0] p1x, p1y
					);
					
					
parameter [9:0] px_center = 10'd280;
parameter [9:0] py_center = 10'd80;



logic [9:0] px_pos, py_pos, px_mot, py_mot;



			//do we need this???
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

	 
	 
	 //reset control
	 always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
           px_pos <= px_center;
			  py_pos <= py_center; 
			  px_mot <= 10'd0;
			  py_mot <= 10'd0; 
        end
        else
        begin
			  px_mot <= 10'd0;
			  py_mot <= 10'd0; 
			  //px_pos <= px_c;
			  //py_pos <= py_center; 
			  
			  
			  
			  
			  
			  
			  
        end
    end
	 
	 
	 
	 
	 
	 