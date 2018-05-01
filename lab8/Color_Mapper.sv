//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( //input              is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
							  input			is_player1, is_player2, hit1, hit2, p1_won, p2_won,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] p1_h, p1_w, //player height and width
                       input 			[9:0] p1x, p1y, p2x, p2y, health1, health2,
							  input        [23:0] data1, data2,
							  input 			[9:0] action1, action2, direction1, direction2,
							  input		   [7:0]	font_data,
							  output logic [10:0] font_addr,
							  output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [18:0] read_address1, read_address2
							  
                     );
    
    logic [7:0] Red, Green, Blue;
	 logic [9:0] tot_w;
	 logic P; 
	 
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 assign tot_w = 10'd540;
	 
    
	 
    // Assign color based on is_ball signal
    always_comb
    begin
	 if(action1 == 10'd9)
	 begin
		if(direction1 == 10'd1) 
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w - 2*tot_w;
		end
		else //flip sprite
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w - 2*tot_w;
		end
	  end
	  
	 else if(action1 == 10'd0)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w;
		end
	  end
	  
	 else if(action1 == 10'd1)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_w;
		end
	  end
	  
	  else if(action1 == 10'd2)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 2*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 2*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd3)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 3*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 3*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd4)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 4*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 4*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd5)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 5*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 5*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd6)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 6*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 6*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd7)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 7*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 7*p1_w;
		end
	  end
	  
	  else if(action1 == 10'd8)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + 8*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 8*p1_w;
		end
	  end
	  
	   else if(action1 == 10'd11)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w + 2*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w + 2*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action1 == 10'd12)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w + 3*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w + 3*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action1 == 10'd13)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w + 4*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w + 4*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action1 == 10'd14)
	 begin
		if(direction1 == 10'd1) //flip sprite
		begin
			read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w + 5*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address1 = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w + 5*p1_w - 2*tot_w;
		end
	  end
	  
	  else
		read_address1 = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w - 2*tot_w;            //defualt standing... sprite #9
		
		
		
		
	 if(action2 == 10'd9)
	 begin
		if(direction2 == 10'd1) 
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w - 2*tot_w;
		end
		else //flip sprite
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_h*tot_w - 2*tot_w ;
		end
	  end
	  
	 else if(action2 == 10'd0)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w;
		end
	  end
	  
	 else if(action2 == 10'd1)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_w;
		end
	  end
	  
	  else if(action2 == 10'd2)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 2*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 2*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd3)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 3*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 3*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd4)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 4*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 4*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd5)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 5*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 5*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd6)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 6*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 6*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd7)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 7*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 7*p1_w;
		end
	  end
	  
	  else if(action2 == 10'd8)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + 8*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + 8*p1_w;
		end
	  end
	  
	   else if(action2 == 10'd11)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w - 2*tot_w + 2*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_h*tot_w + 2*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action2 == 10'd12)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w + 3*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_h*tot_w + 3*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action2 == 10'd13)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w + 4*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_h*tot_w + 4*p1_w - 2*tot_w;
		end
	  end
	  
	   else if(action2 == 10'd14)
	 begin
		if(direction2 == 10'd1) //flip sprite
		begin
			read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w + 5*p1_w - 2*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address2 = (p1_w -(DrawX-p2x)) + (DrawY-p2y)*tot_w + p1_h*tot_w + 5*p1_w - 2*tot_w;
		end
	  end
	
	  
	  else
		read_address2 = (DrawX-p2x) + (DrawY-p2y)*tot_w + p1_h*tot_w; //defualt standing... sprite #9
		
		
		//Font Display
		
	  if(p1_won == 1'b1 || p2_won == 1'b1)
		  begin
				if( (DrawX > 10'd100) && (DrawX <= 10'd108) && (DrawY >= 10'd20) && (DrawY <= 10'd36) )	
					begin
					font_addr = DrawY - 10'd20 + 16*'h50;      //P =x50
					P = 1'b1; 
					end
				else
					P = 1'b0; 
		  end   
		
		
		
		
		
		
		
		  if(P == 1'b1)
		  begin
					//font_addr = DrawY - 10'd20 + 16*'h50;      //P =x50
					if(font_data[DrawX - 10'd100] == 1'b1)
					   begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
					   end
					else
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
		  end
		  else if(p1_won == 1'b1 || p2_won == 1'b1)
		  begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
		  end
		  
        else if (is_player1 == 1'b1)
        begin
				if(data1 == 24'hff0ff)
				begin
					if(is_player2 == 1'b1 && data2 != 24'hff0ff)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
					end
					else
					begin
						Red = 8'hff; 
						Green = 8'hff;
						Blue = 8'hff;
					end
				end
				else
				begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
				end
				
        end
		  
		  
		  else if (is_player2 == 1'b1)
        begin
				
				if(data2 == 24'hff0ff)
				begin
						Red = 8'hff; 
						Green = 8'hff;
						Blue = 8'hff;
				end
				else
				begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
				end
				
        end
		  
			//player 1 health bar
		  else if( (DrawX > 10'd50) && (DrawX <= 10'd50 + health1) && (DrawY >= 10'd20) && (DrawY <= 10'd40))
		  begin
				Red = 8'hff;
				Green = 8'h00;
				Blue = 8'h00;
		  end
		  
		  //player 2 health bar
		  else if( (DrawX > 10'd490) && (DrawX <= 10'd490 + health2) && (DrawY >= 10'd20) && (DrawY <= 10'd40))
		  begin
				Red = 8'hff;
				Green = 8'h00;
				Blue = 8'h00;
		  end
		  
		  
        else 
        begin
				
				// White Background
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
    end //for big comb block
	 
	 
	 
	 //otherwise get the color of the sprite
				/*else
				begin
						Red = data[23:16];
						Green = data[15:8];
						Blue = data[7:0];
				end*/
    
endmodule
