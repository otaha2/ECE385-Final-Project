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
							  input			is_player1,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] p1_h, p1_w, //player height and width
                       input 			[9:0] p1x, p1y,
							  input        [23:0] data,
							  input 			[9:0] action, direction,
							  output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [18:0] read_address
                     );
    
    logic [7:0] Red, Green, Blue;
	 
	 logic [9:0] tot_w;
	 
	 
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 assign tot_w = 10'd547;
	 
    
	 
    // Assign color based on is_ball signal
    always_comb
    begin
	 if(action == 10'd9)
	 begin
		if(direction == 10'd1) 
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w;
		end
		else //flip sprite
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*tot_w;
		end
	  end
	  
	 else if(action == 10'd0)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w;
		end
	  end
	  
	 else if(action == 10'd1)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd2)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 2*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 2*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd3)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 3*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 3*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd4)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 4*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 4*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd5)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 4*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 4*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd6)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 5*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 5*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd7)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 6*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 6*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd8)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 7*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 7*p1_h*p1_w;
		end
	  end
	  
	  else if(action == 10'd9)
	 begin
		if(direction == 10'd1) //flip sprite
		begin
			read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + 8*p1_h*p1_w;
		end
		else //direction == 10'd1
		begin
			read_address = (p1_w -(DrawX-p1x)) + (DrawY-p1y)*tot_w + 8*p1_h*p1_w;
		end
	  end
	  
	  else
		read_address = (DrawX-p1x) + (DrawY-p1y)*tot_w + p1_h*tot_w; //defualt standing... sprite #9
			
        if (is_player1 == 1'b1)
        begin
				/*
				 if(action == 10'd1)
				   begin
						
					end
				
				*/
            //get color from sprite
				//if color is green, pick the background color
				/*if(data == 24'h33d42)
				begin
					Red = 8'hff; 
					Green = 8'hff;
					Blue = 8'hff;
				end
				//otherwise get the color of the sprite
				else
				begin
						Red = data[23:16];
						Green = data[15:8];
						Blue = data[7:0];
				end*/
				
				if(data == 24'hff0ff)
				begin
					Red = 8'hff; 
					Green = 8'hff;
					Blue = 8'hff;
				end
				//otherwise get the color of the sprite
				/*else
				begin
						Red = data[23:16];
						Green = data[15:8];
						Blue = data[7:0];
				end*/
				else
				begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
				end
				
        end
        else 
        begin
            // Background with nice color gradient
				
				// White Background
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
    end 
    
endmodule
