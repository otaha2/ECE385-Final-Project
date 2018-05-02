module  Frame_control(
							input [9:0] p1x, p1y, p2x, p2y,
							input [9:0] action1, action2, direction1, direction2,
							output logic hit1, hit2,
							output logic [9:0] health1, health2
							);

/*
Punch: 
   10'd12
	10'd13
	10'd14
	10'd11

*/			
parameter [9:0] pw = 10'd60;

assign health1 = 10'd100;
assign health2 = 10'd100;

always_comb	
begin
	hit1= 1'b0;
	hit2 = 1'b0; 
	
	//case p1> p2>    (p1 hiting)
	if( (p1x < p2x) && (p1x + pw >= p2x + 10'd20) && (action1 == 10'd14) && (direction1 == 1'b1) && (direction2 == 1'b1))
		 hit1 = 1'b1;
		 
	//case p2> p1>    (p2 hiting)
	else if( (p2x < p1x) && (p2x + pw >= p1x + 10'd20) && (action2 == 10'd14) && (direction2 == 1'b1) && (direction1 == 1'b1) )
		 hit2 = 1'b1;
		 
	//case p1> <p2  (p1 hiting)
	else if( (p1x < p2x) && (p1x + pw >= p2x + 10'd35) && (action1 == 10'd14) && (direction1 == 1'b1) && (direction2 == 1'b0) )
		 hit1 = 1'b1;
		 
	//case p2> <p1  (p2 hiting)
	else if( (p2x < p1x) && (p2x + pw >= p1x + 10'd35) && (action2 == 10'd14) && (direction2 == 1'b1) && (direction1 == 1'b0) )
		 hit2 = 1'b1;
		 
		 
		 
	//case p2>  <p1 (p1 hiting)
	else if( (p1x > p2x) && (p1x <= p2x + 10'd27) && (action1 == 10'd14) && (direction1 == 1'b0) && (direction2 == 1'b1) )
		 hit1 = 1'b1;
	
	//case p1>  <p2 (p2 hiting)
	else if( (p2x > p1x) && (p2x <= p1x + 10'd27) && (action2 == 10'd14) && (direction2 == 1'b0) && (direction1 == 1'b1) )
		 hit2 = 1'b1;
		 
	//case <p2  <p1 (p1 hiting)
	else if( (p1x > p2x) && (p1x <= p2x + 10'd37) && (action1 == 10'd14) && (direction1 == 1'b0) && (direction2 == 1'b0))
		 hit1 = 1'b1;
	
	//case <p1  <p2 (p2 hiting)
	else if( (p2x > p1x) && (p2x <= p1x + 10'd37) && (action2 == 10'd14) && (direction2 == 1'b0) && (direction1 == 1'b0) )
		 hit2 = 1'b1;
	
end	


					
endmodule



module Start(
				input Clk, Reset,
				input [7:0] keyCode,
				output logic is_start
				);		
				
				
				
logic is_start_in;	
				
always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
        is_start <= 1'b1;
        end
		  
        else
        begin
		  is_start <= is_start_in;
        end
    end
				
				
always_comb
	begin
	is_start_in = is_start;
	
	if(keyCode == 8'h5A)     //enter key
		is_start_in = 1'b0; 
	
	end
	

endmodule 


module  End(
				input Clk, Reset,
				input [9:0] DrawY, DrawX
				//output logic 	
				);

//player1 wins 

logic [3:0] end_out;

/*
always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
        P <= 1'b1;
        end
		  
        else
        begin
		  is_start <= is_start_in;
        end
    end
				
				
always_comb
	begin
	is_start_in = is_start;
	
	if(keyCode == 8'h5A)     //enter key
		is_start_in = 1'b0; 
	
	end
 
*/


endmodule


module Combo1(
				input frame_clk, Clk, Reset, 
				input [7:0] keypress, 
				input [9:0] p2x, p2y, p1x, p1y, player_direction, DrawX, DrawY,
				output logic [9:0] combo_x, combo_y, combo_direction, 
				output logic draw_combo, is_combo, combo_hit2

				);
				
				
//parameter [9:0] px_center = 10'd200;
//parameter [9:0] py_center = 10'd400;

parameter [9:0] combo_min = 10'd85;       // Leftmost point on the X axis
parameter [9:0] combo_max = 10'd555;     // Rightmost point on the X axis
parameter [9:0] py_min = 10'd1;       // Topmost point on the Y axis
parameter [9:0] py_max = 10'd479;     // Bottommost point on the Y axis
parameter [9:0] combo_step = 10'd8;      // Step size on the X axis
//parameter [9:0] py_step = 10'd5;      // Step size on the Y axis
parameter [9:0] combo_width = 10'd40;        // Player Width
parameter [9:0] combo_height = 10'd30;		//Player Height				
				
				
				
				
				
				
				
				
				
logic [9:0] combo_pos, combo_posy, combo_posy_in, combo_pos_in, combo_mot, combo_mot_in, counter, counter_in, dir, dir_in;
logic make_combo, make_combo_in;
logic [3:0] combo_seq, combo_seq_in;

logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

always_ff @ (posedge Clk)
	 begin
		if(Reset)
			counter <= 10'd0;
		else
			counter <= counter_in;
	 end
	 
	 
always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
			  draw_combo <= 1'b0;
			  make_combo <= 1'b0;
			  combo_seq <= 4'b0;
			  combo_mot <= 10'd0;
			  combo_pos <= 10'd0;
			  dir <= player_direction;
			  
			  /*
			  py_pos <= py_center; 
			  py_mot <= 10'd0;
			  act <= 10'd9;
			  health <= 10'd100;
			  p2_win <= 1'b0;
			  
			  */
        end
        else
        begin
			  draw_combo <= make_combo_in;
			  make_combo <= make_combo_in;
			  combo_pos <= combo_pos_in;
			  combo_posy <= combo_posy_in;
			  combo_y <= combo_posy_in;
			  combo_mot <= combo_mot_in;
			  combo_x <= combo_pos_in;
			  dir <= dir_in;
			  combo_direction <= dir_in;
			  combo_seq <= combo_seq_in;
        end
    end
	 
	 always_comb
    begin
        // By default, keep motion and position unchanged
        combo_pos_in = combo_pos;
		  combo_posy_in = combo_posy;
        combo_mot_in = combo_mot;
		  dir_in = dir;
		  counter_in = counter;
		  make_combo_in = make_combo;
		  combo_seq_in = combo_seq;
		  combo_hit2 = 1'b0;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  
		  //left
		  if(combo_seq == 10'd0 && keypress[6] == 1 && counter <= 10'd50)
		  begin
		  combo_seq_in = 10'd1;
		  counter_in = 10'd0;
		  end
		  //right
		  else if(combo_seq == 10'd1 && keypress[5] == 1 && counter <= 10'd50)
		  begin
		  combo_seq_in = 10'd2;
		  counter_in = 10'd0;
		  end
		  //up
		  else if(combo_seq == 10'd2 && keypress[7] == 1 && counter <= 10'd50)
		  begin
		  combo_seq_in = 10'd3;
		  counter_in = 10'd0;
		  end
		  //punch
		  else if(combo_seq == 10'd3 && keypress[4] == 1 && counter <= 10'd50)
		  begin
		  combo_seq_in = 10'd4;
		  counter_in = 10'd0;
		  end
		  //right
		  else if(combo_seq == 10'd4 && keypress[5] == 1 && counter <= 10'd5)
		  begin
		  combo_seq_in = 10'd5;
		  counter_in = 10'd0;
		  dir_in = player_direction;
		  make_combo_in = 1'b1;
		  combo_mot_in = combo_step;
		  combo_pos_in = p1x;
		  combo_posy_in = p1y;
		  end
		  //left
		  else if(combo_seq == 10'd4 && keypress[6] == 1 && counter <= 10'd5)
		  begin
		  combo_seq_in = 10'd5;
		  counter_in = 10'd0;
		  dir_in = player_direction;
		  make_combo_in = 1'b1;
		  combo_mot_in = (~(combo_step) + 1'b1);
		  combo_pos_in = p1x;
		  combo_posy_in = p1y;
		  end
		  else if(make_combo != 1'b1)
		  begin
		  combo_seq_in = 10'd0;
		  counter_in = 10'd0;
		  combo_mot_in = 10'd0;
		  end
		  
		  else
		  begin
		  combo_seq_in = 10'd0;
		  make_combo_in = 10'd0;
		  combo_mot_in = 10'd0;
		  end
		  
		  
			
			
			if( dir == 1'b1 && combo_pos + combo_width >= p2x )  // combo is touching the person. make it go away.
			begin
                make_combo_in = 10'd0; 
					 combo_mot_in = 10'd0; 
					 combo_hit2 = 1'b1;
			end
			else if( dir == 1'b0 && combo_pos <= p2x + 10'd60 )  // combo is touching the person. make it go away.
			begin
                make_combo_in = 10'd0; 
					 combo_mot_in = 10'd0; 
					 combo_hit2 = 1'b1;
			end
			
			if(combo_pos + combo_width >= combo_max)  // Combo is at the right edge, stop moving and make it go away
			begin
				 make_combo_in = 1'b0;
             combo_mot_in = 10'd0;  
			end
			else if (combo_pos <= combo_min)  // Combo is at the left edge, stop moving make it go away
			begin
             make_combo_in = 1'b0;
             combo_mot_in = 10'd0; 
			end
			
			// Update the Combo's position with its motion
				combo_pos_in = combo_pos + combo_mot;
				combo_posy_in = combo_posy;
				
		end
	end
	
	int Width, Height;
    assign Width = combo_width;
	 assign Height = combo_height;
    always_comb begin
        if ( (DrawX >= combo_pos) && (DrawX <= (combo_pos + Width)) && (DrawY >= combo_posy) && (DrawY <= combo_posy + Height) ) 
            is_combo = 1'b1;
        else
            is_combo = 1'b0;
    end



endmodule





module Combo2(
				input frame_clk, Clk, Reset, 
				input [7:0] keypress, 
				input [9:0] p1x, p1y, p2x, p2y, player_direction, DrawX, DrawY,
				output logic [9:0] combo_x, combo_y, combo_direction, 
				output logic draw_combo, is_combo, combo_hit1

				);
				
				
//parameter [9:0] px_center = 10'd200;
//parameter [9:0] py_center = 10'd400;

parameter [9:0] combo_min = 10'd85;       // Leftmost point on the X axis
parameter [9:0] combo_max = 10'd555;     // Rightmost point on the X axis
parameter [9:0] py_min = 10'd1;       // Topmost point on the Y axis
parameter [9:0] py_max = 10'd479;     // Bottommost point on the Y axis
parameter [9:0] combo_step = 10'd8;      // Step size on the X axis
//parameter [9:0] py_step = 10'd5;      // Step size on the Y axis
parameter [9:0] combo_width = 10'd40;        // Player Width
parameter [9:0] combo_height = 10'd30;		//Player Height				
				
				
				
				
				
				
				
				
				
logic [9:0] combo_pos,  combo_posy, combo_posy_in, combo_pos_in, combo_mot, combo_mot_in, counter, counter_in, dir, dir_in;
logic make_combo, make_combo_in, counter_begin, counter_begin_in;
logic [3:0] combo_seq, combo_seq_in;

logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

always_ff @ (posedge Clk)
	 begin
		if(Reset)
			counter <= 10'd0;
		else
			counter <= counter_in;
	 end
	 
	 
always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
			  draw_combo <= 1'b0;
			  make_combo <= 1'b0;
			  combo_seq <= 4'b0;
			  combo_mot <= 10'd0;
			  combo_pos <= 10'd0;
			  dir <= player_direction;
			  counter_begin <= 1'b0;
			  
			  /*
			  py_pos <= py_center; 
			  py_mot <= 10'd0;
			  act <= 10'd9;
			  health <= 10'd100;
			  p2_win <= 1'b0;
			  
			  */
        end
        else
        begin
			  draw_combo <= make_combo_in;
			  make_combo <= make_combo_in;
			  combo_pos <= combo_pos_in;
			  combo_posy <= combo_posy_in;
			  combo_y <= combo_posy_in;
			  combo_mot <= combo_mot_in;
			  combo_x <= combo_pos_in;
			  dir <= dir_in;
			  combo_direction <= dir_in;
			  combo_seq <= combo_seq_in;
			  counter_begin <= counter_begin_in;
        end
    end
	 
	 always_comb
    begin
        // By default, keep motion and position unchanged
        combo_pos_in = combo_pos;
		  combo_posy_in = combo_posy;
        combo_mot_in = combo_mot;
		  dir_in = dir;
		  counter_in = counter;
		  make_combo_in = make_combo;
		  combo_seq_in = combo_seq;
		  combo_hit1 = 1'b0;
		  counter_begin_in = counter_begin;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  if(counter_begin == 1'b1)
		  begin
			counter_in = counter + 1;
			end
		  else
			begin
			counter_in = 1'b0;
			end
			
		  //left
		  if(combo_seq == 10'd0 && keypress[2] == 1)
		  begin
		  counter_begin_in = 1'b1;
		  combo_seq_in = 10'd1;
		  //counter_in = 10'd0;
		  end
		  //right
		  else if(combo_seq == 10'd1 && keypress[1] == 1 ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd2;
		  counter_in = 10'd0;
		  end
		  else if(combo_seq == 10'd1 && keypress[1] != 1 && keypress != 8'h00 ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd0;
		  counter_in = 10'd0;
		  end
		  //up
		  else if(combo_seq == 10'd2 && keypress[3] == 1 ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd3;
		  counter_in = 10'd0;
		  end
		  else if(combo_seq == 10'd2 && keypress[3] != 1 && keypress != 8'h00 ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd0;
		  counter_in = 10'd0;
		  end
		  //punch
		  else if(combo_seq == 10'd3 && keypress[0] == 1 ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd4;
		  counter_in = 10'd0;
		  end
		  else if(combo_seq == 10'd3 && keypress[0] != 1 && keypress != 8'h00) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd0;
		  counter_in = 10'd0;
		  end
		  //right
		  else if(combo_seq == 10'd4 && (keypress[1] == 1 || keypress[2] == 1) ) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd5;
		  counter_in = 10'd0;
		  dir_in = player_direction;
		  make_combo_in = 1'b1;
		  combo_mot_in = combo_step;
		  combo_pos_in = p2x;
		  combo_posy_in = p2y;
		  end
		  else if(combo_seq == 10'd4 && keypress[1] != 1 && keypress[2] != 1 && keypress != 8'h00) //&& counter <= 10'd5000
		  begin
		  combo_seq_in = 10'd0;
		  counter_in = 10'd0;
		  end
		  else if(make_combo == 1'b1)
		  begin
		  make_combo_in = 1'b1;
		  combo_mot_in = combo_mot;
		  dir_in = dir;
		  //counter_begin_in = counter_begin;
		  end
		  
		  else
		  begin
		  counter_begin_in =1'b0;
		  combo_seq_in = combo_seq;
		  make_combo_in = 10'd0;
		  combo_mot_in = 10'd0;
		  end
		  
		  
			
			
			if( dir == 1'b1 && combo_pos + combo_width >= p1x )  // combo is touching the person. make it go away.
			begin
                make_combo_in = 10'd0; 
					 combo_mot_in = 10'd0; 
					 combo_hit1 = 1'b1;
			end
			else if( dir == 1'b0 && combo_pos <= p1x + 10'd60 )  // combo is touching the person. make it go away.
			begin
                make_combo_in = 10'd0; 
					 combo_mot_in = 10'd0; 
					 combo_hit1 = 1'b1;
			end
			
			if(combo_pos + combo_width >= combo_max)  // Combo is at the right edge, stop moving and make it go away
			begin
				 make_combo_in = 1'b0;
             combo_mot_in = 10'd0;  
			end
			else if (combo_pos <= combo_min)  // Combo is at the left edge, stop moving make it go away
			begin
             make_combo_in = 1'b0;
             combo_mot_in = 10'd0; 
			end
			
			// Update the Combo's position with its motion
				combo_pos_in = combo_pos + combo_mot;
				combo_posy_in = combo_posy;
				
		end
	end
	
	int Width, Height;
    assign Width = combo_width;
	 assign Height = combo_height;
    always_comb begin
        if ( (DrawX >= combo_pos) && (DrawX <= (combo_pos + Width)) && (DrawY >= combo_posy) && (DrawY <= combo_posy + Height) ) 
            is_combo = 1'b1;
        else
            is_combo = 1'b0;
    end



endmodule





