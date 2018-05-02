module player2(input frame_clk, Reset, Clk, press, hit1, hit2,
					input [7:0] keycode,
					input [7:0] keypress,
					input [9:0] DrawX, DrawY,
					output logic [9:0] p2x, p2y, 
					output logic is_player2, p1_won,
					output logic [9:0] action2, direction2, //1 is right, 0 is left. used to know whether or not to flip the sprite 
					output logic [9:0] health2
					);
					
					
parameter [9:0] px_center = 10'd400;
parameter [9:0] py_center = 10'd400;

parameter [9:0] px_min = 10'd85;       // Leftmost point on the X axis
parameter [9:0] px_max = 10'd555;     // Rightmost point on the X axis
parameter [9:0] py_min = 10'd1;       // Topmost point on the Y axis
parameter [9:0] py_max = 10'd479;     // Bottommost point on the Y axis
parameter [9:0] px_step = 10'd5;      // Step size on the X axis
parameter [9:0] py_step = 10'd5;      // Step size on the Y axis
parameter [9:0] Player_Width = 10'd60;        // Player Width
parameter [9:0] Player_Height = 10'd70;		//Player Height


/*
ACTION KEY
walking:
action = 0
action = 1
action = ...
action = 9

punch:
action = 9
action = 12
		 = 13
		 = 14
		 = 11


*/



logic [9:0] px_pos;
logic [9:0] py_pos, px_mot, py_mot;
logic [9:0] px_pos_in, py_pos_in, px_mot_in, py_mot_in, dir_in, dir, act, act_in, counter, counter_in, health, health_in;
logic p1_win_in, p1_win;




    // Detect rising edge of frame_clk
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
	 
	 
	 //reset control
	 always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
           px_pos <= px_center;
			  py_pos <= py_center; 
			  px_mot <= 10'd0;
			  py_mot <= 10'd0;
			  act <= 10'd9;
			  health = 10'd100;
			  p1_win <= 1'b0;
			  dir <= 1'b0;
        end
        else
        begin
			  px_pos <= px_pos_in;
			  py_pos <= py_pos_in;
			  px_mot <= px_mot_in;
			  py_mot <= py_mot_in; 
			  p2x <= px_pos_in ;
			  p2y <= py_pos_in; 
			  dir <= dir_in;
			  direction2 <= dir_in;
			  action2 <= act_in;
			  act <= act_in;
			  health <= health_in;
			  health2 <= health_in;
			  p1_win <= p1_win_in;
			  p1_won <= p1_win_in;
		
        end
    end
	 
	 always_comb
    begin
        // By default, keep motion and position unchanged
        px_pos_in = px_pos;
        py_pos_in = py_pos;
        px_mot_in = px_mot;
        py_mot_in = py_mot;
		  dir_in = dir;
		  act_in = act;
		  counter_in = counter;
		  health_in = health;
		  p1_win_in = p1_win;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            
				
				
				
				//update keypress
				//unique case(keycode[7:0])
				/*if(keycode == 8'h1d)			//w, up!!
				  begin
					px_mot_in = 10'd0;
					py_mot_in = (~(py_step) + 1'b1); //why + 1'b1?? Answer: 2's complmenet!
				  end*/
				  
				  //ARE WE DOING A CROUCH BUTTON?
				 //else if(keycode == 8'h16)			//s, Down!!
				  //begin
					//Ball_X_Motion_in = 10'd0;
					//Ball_Y_Motion_in = Ball_Y_Step;
				  //end
				  
				 if(keypress[2] == 1 && keypress[0] != 1 && act >= 10'd0 && act <= 10'd9)			//a, left!
				  begin
					counter_in = counter + 10'd1;
					py_mot_in = 10'd0;
					px_mot_in = (~(px_step) + 1'b1);
					dir_in = 10'd0;
					
				  if(act == 10'd9)
					act_in = 10'd0;
				  else if(act == 10'd0 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2)
				 begin 
					act_in = 10'd1;
					counter_in = 10'd0;
					end
				  else if(act == 10'd1 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
				  begin
					act_in = 10'd2;
					counter_in = 10'd0;
					end
				  else if(act == 10'd2 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
				  begin
					act_in = 10'd3;
					counter_in = 10'd0;
					end
				  else if(act == 10'd3 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
				  begin
					act_in = 10'd4;
					counter_in = 10'd0;
					end
					else if(act == 10'd4 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
					begin
					act_in = 10'd5;
					counter_in = 10'd0;
					end
					else if(act == 10'd5 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
					begin
					act_in = 10'd6;
					counter_in = 10'd0;
					end
					else if(act == 10'd6 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
					begin
					act_in = 10'd7;
					counter_in = 10'd0;
					end
					else if(act == 10'd7 && px_mot == (~(px_step) + 1'b1) && counter >= 10'd2) 
					begin
					act_in = 10'd9;
					counter_in = 10'd0;
					end
					/*else if(act == 10'd8 && px_mot == (~(px_step) + 1'b1) && counter == 10'd2) 
					begin
					act_in = 10'd9;
					counter_in = 10'd0;
					end*/
					else
					begin
					act_in = act;
					//counter_in = 10'd0;
					end
				  
					
				  end
				 else if(keypress[1] == 1 && keypress[0] != 1 && act >= 10'd0 && act <= 10'd9)			//d, Right!! 
				  begin
				  counter_in = counter + 10'd1;
				  	py_mot_in = 10'd0;
					px_mot_in = px_step;
					dir_in = 10'd1;
					
				  if(act == 10'd9)
					act_in = 10'd0;
				  else if(act == 10'd0 && px_mot == px_step && counter >= 10'd2)
				  begin
					act_in = 10'd1;
					counter_in = 10'd0;
					end
				  else if(act == 10'd1 && px_mot == px_step && counter >= 10'd2)
				  begin
					act_in = 10'd2;
					counter_in = 10'd0;
					end
					else if(act == 10'd2 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd3;
					counter_in = 10'd0;
					end
					else if(act == 10'd3 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd4;
					counter_in = 10'd0;
					end
					else if(act == 10'd4 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd5;
					counter_in = 10'd0;
					end
					else if(act == 10'd5 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd6;
					counter_in = 10'd0;
					end
					else if(act == 10'd6 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd7;
					counter_in = 10'd0;
					end
					else if(act == 10'd7 && px_mot == px_step && counter >= 10'd2)
					begin
					act_in = 10'd9;
					counter_in = 10'd0;
					end
					/*else if(act == 10'd8 && px_mot == px_step && counter == 10'd2) 
					begin
					act_in = 10'd9;
					counter_in = 10'd0;
					end*/
				  else
				  begin
					act_in = act;
					//counter_in = 10'd0;
					end
				  
					
				  end
				 else if(keypress[0] == 1) //punch
				 begin
					counter_in = counter + 10'd1;
					
					if(act < 10'd11 || act > 10'd14)
					act_in = 10'd12;
					else if(act == 10'd12 && counter == 10'd3)
					begin
					act_in = 10'd13;
					counter_in = 10'd0;
					end
					else if(act == 10'd13 && counter == 10'd3)
					begin
					act_in = 10'd14;
					counter_in = 10'd0;
					end
					else if(act == 10'd14 && counter == 10'd3)
					begin
					act_in = 10'd11;
					counter_in = 10'd0;
					end
					else if(act == 10'd11 && counter == 10'd3)
					begin
					act_in = 10'd9;
					counter_in = 10'd0;
					end
					else
					begin
					act_in = act;
					end
					
					px_mot_in = 10'd0;
					py_mot_in = 10'd0;
					dir_in = dir;
				 end
				 else
				  begin
					/*if(py_mot_in == (~(py_step) + 1'b1)) //if the last motion was an up motion, the player must come back down (gravity)
						py_mot_in = py_step;
					else
						begin
						py_mot_in = 10'd0;
						end*/
					
					py_mot_in = 10'd0; //py_mot;	
					px_mot_in = 10'd0; //px_mot;
					dir_in = dir;
					act_in = 10'd9;
					counter_in = 10'd0;
					
				  end
				
				
				
				
            if( py_pos + Player_Height >= py_max )  // person is at the bottom edge, stop y motion
				  begin
                py_mot_in = 10'd0;    
					 px_mot_in = 10'd0; 
				  end
				else if ( py_pos <= py_min )  // Player is at the top edge, go down
				  begin
                py_mot_in = py_step;
					 px_mot_in = 10'd0; //my addition
				  end
           
				//X boundary conditions 
				else if(px_pos >= px_max && px_mot_in == px_step)  // Player is at the right edge, stop moving
				   begin
                px_mot_in = px_step;  
					 py_mot_in = 10'd0;
					 px_pos_in = 10'd85;
					 dir_in = 1'b1; 
					end
			   else if (px_pos + Player_Width <= px_min && px_mot_in == (~(px_step) + 1'b1))  // Ball is at the left edge, stop moving && px_mot_in == (~(px_step) + 1'b1)
				   begin
                px_mot_in = (~(px_step) + 1'b1);
					 py_mot_in = 10'd0; 
					 px_pos_in = 10'd555;
					 dir_in = 1'b0;
					end
					 
				
			 if(hit1 == 1'b1)
					health_in = health - 10'd1;
				else
					health_in = health; 
			
			
			if(health <= 10'd0)
			begin
				health_in = 10'd0;
				p1_win_in = 1'b1;
			end
			else
				p1_win_in = 1'b0;
        
            // Update the Players's position with its motion
            if((px_pos < px_max && px_pos + Player_Width > px_min))
				begin
					px_pos_in = px_pos + px_mot;
					py_pos_in = py_pos + py_mot;
				end
				else if(px_pos >= px_max && px_mot_in == px_step)
				begin
					px_pos_in = 10'd85;
					py_pos_in = py_pos + py_mot;
				end
				else 
				begin
					px_pos_in = 10'd554 - Player_Width;
					py_pos_in = py_pos + py_mot;
				end
				
        end
	  end
	  // Compute whether the pixel corresponds to Player or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int Width, Height;
    assign Width = Player_Width;
	 assign Height = Player_Height;
    always_comb begin
        if ( (DrawX >= px_pos) && (DrawX <= (px_pos + Width)) && (DrawY >= py_pos) && (DrawY <= py_pos + Height) ) 
            is_player2 = 1'b1;
        else
            is_player2 = 1'b0;
    end
	 
	 
endmodule
	 