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
							  input			is_player1, is_player2, hit1, hit2, p1_won, p2_won, is_start,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input			[9:0] p1_h, p1_w, //player height and width
                       input 			[9:0] p1x, p1y, p2x, p2y, health1, health2,
							  input        [23:0] data1, data2,
							  input 			[9:0] action1, action2, direction1, direction2,
							  input		   [7:0]	font_data, 
							  input        [3:0] start_data, pipe_data,
							  output logic [10:0] font_addr,
							  output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [18:0] read_address1, read_address2, start_address, pipe_address
							  
                     );
    
    logic [7:0] Red, Green, Blue;
	 logic [9:0] tot_w;
	 logic P, L, A, Y, E, R, ONE, TWO, W, I, N, S; 
	 
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 assign tot_w = 10'd540;
	 
    
	 
    // Assign color based on is_ball signal
    always_comb
    begin
	 
	 start_address = DrawY*10'd640 + DrawX; 
	 
	 
	 
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
		
		//pipe
		if(DrawX >= 10'd555 && DrawX < 10'd640 && DrawY >= 10'd390 && DrawY <= 10'd480)
		begin
			pipe_address = DrawX - 10'd555 + (DrawY - 10'd390)*10'd85;
		end
		else if(DrawX >= 10'd0 && DrawX < 10'd85 && DrawY >= 10'd390 && DrawY <= 10'd480)
		begin
			pipe_address = (10'd85 - (DrawX - 10'd0)) + (DrawY - 10'd390)*10'd85;
		end
		else
			pipe_address = DrawX - 10'd555 + (DrawY - 10'd390)*10'd85;
		//Font Display
		

		if( (DrawX >= 10'd264) && (DrawX < 10'd272) && (DrawY >= 10'd232) && (DrawY < 10'd248) )	
			begin
				font_addr = DrawY - 10'd232 + 16*'h50;      //P =x50
				P = 1'b1; 
			end
		else if( (DrawX >= 10'd274) && (DrawX < 10'd282) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h4c;      //L =x4c
				L = 1'b1; 
			end
		else if( (DrawX >= 10'd284) && (DrawX < 10'd292) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h41;      //A =x41
				A = 1'b1; 
			end
		else if( (DrawX >= 10'd294) && (DrawX < 10'd302) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h59;      //Y =x59
				Y = 1'b1; 
			end
		else if( (DrawX >= 10'd304) && (DrawX < 10'd312) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h45;      //E =x45
				E = 1'b1; 
			end
		else if( (DrawX >= 10'd314) && (DrawX < 10'd322) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h52;      //R =x52
				R = 1'b1; 
			end
		else if( (DrawX >= 10'd324) && (DrawX < 10'd332) && (DrawY >= 10'd232) && (DrawY < 10'd248) && p1_won == 1'b1 )
			begin
				font_addr = DrawY - 10'd232 + 16*'h31;      //1 =x31
				ONE = 1'b1; 
			end
		else if( (DrawX >= 10'd324) && (DrawX < 10'd332) && (DrawY >= 10'd232) && (DrawY < 10'd248) && p2_won == 1'b1 )
			begin
				font_addr = DrawY - 10'd232 + 16*'h32;      //2 =x32
				TWO = 1'b1; 
			end
		else if( (DrawX >= 10'd338) && (DrawX < 10'd346) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h57;      //W =x57
				W = 1'b1; 
			end
		else if( (DrawX >= 10'd348) && (DrawX < 10'd356) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h49;      //I =x49
				I = 1'b1; 
			end
		else if( (DrawX >= 10'd358) && (DrawX < 10'd366) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h4e;      //N =x4e
				N = 1'b1; 
			end
		else if( (DrawX >= 10'd368) && (DrawX < 10'd376) && (DrawY >= 10'd232) && (DrawY < 10'd248) )
			begin
				font_addr = DrawY - 10'd232 + 16*'h53;      //S =x53
				S = 1'b1; 
			end
				
		else
			begin
				font_addr = 10'b0; 
				P = 1'b0; 
				L = 1'b0; 
				A = 1'b0;
				Y = 1'b0;
				E = 1'b0;
				R = 1'b0;
				ONE = 1'b0;
				TWO = 1'b0; 
				W = 1'b0;
				I = 1'b0;
				N = 1'b0;
				S = 1'b0;
			end
			
			
	 
	
	
		
		  if(is_start == 1'b1)
		   begin
				if(start_data == 3'd0)
					begin
						Red = 8'h80;
						Green = 8'hf2;
						Blue = 8'hff;
					end
				else if(start_data == 3'd1)
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
				else if(start_data == 3'd2)
					begin
						Red = 8'h32;
						Green = 8'h59;
						Blue = 8'h96;
					end
				else if(start_data == 3'd3)
					begin
						Red = 8'h60;
						Green = 8'hc1;
						Blue = 8'hfb;
					end
				else if(start_data == 3'd4)
					begin
						Red = 8'h1d;
						Green = 8'h4a;
						Blue = 8'h5d;
					end
				else if(start_data == 3'd5)
					begin
						Red = 8'h5d;
						Green = 8'h8a;
						Blue = 8'hdf;
					end
				else if(start_data == 3'd6)
					begin
						Red = 8'h77;
						Green = 8'h9e;
						Blue = 8'hdf;
					end
				else if(start_data == 3'd7)
					begin
						Red = 8'h2d;
						Green = 8'h48;
						Blue = 8'h7f;
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
			if(font_data[10'd8 - DrawX - 10'd264] == 1'b1)
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
		  //draw pipe
		  else if((DrawX >= 10'd555 && DrawX < 10'd640 && DrawY >= 10'd390 && DrawY <= 10'd480) || (DrawX >= 10'd0 && DrawX < 10'd85 && DrawY >= 10'd390 && DrawY <= 10'd480))
		  begin
			if(pipe_data == 0)
			begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'hff;
			end
			else if(pipe_data == 1)
			begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
			end
			else if(pipe_data == 2)
			begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'hff;
			end
			else if(pipe_data == 3)
			begin
				Red = 8'h00;
				Green = 8'hf8;
				Blue = 8'h0d;
			end
			else if(pipe_data == 4)
			begin
				Red = 8'h01;
				Green = 8'h80;
				Blue = 8'h06;
			end
			else if(pipe_data == 5)
			begin
				Red = 8'h0a;
				Green = 8'h5e;
				Blue = 8'h07;
			end
			else if(pipe_data == 6)
			begin
				Red = 8'h06;
				Green = 8'hcb;
				Blue = 8'h00;
			end
			else if(pipe_data == 7)
			begin
				Red = 8'h07;
				Green = 8'h43;
				Blue = 8'h09;
			end
			else
				begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'hff;
				end
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
				if(health1 > 10'd60 && health1 <= 10'd100)
				begin
					Red = 8'h00;
					Green = 8'hff;
					Blue = 8'h00;
				end
				else if(health1 <= 10'd60 && health1 > 10'd20)
				begin
					Red = 8'hf4;
					Green = 8'h8c;
					Blue = 8'h42;
				end
				else
				begin
					Red = 8'hff;
					Green = 8'h00;
					Blue = 8'h00;
				end
		  end
		  
		  //player 2 health bar
		  else if( (DrawX > 10'd490) && (DrawX <= 10'd490 + health2) && (DrawY >= 10'd20) && (DrawY <= 10'd40))
		  begin
				if(health2 > 10'd60 && health2 <= 10'd100)
				begin
					Red = 8'h00;
					Green = 8'hff;
					Blue = 8'h00;
				end
				else if(health2 <= 10'd60 && health2 > 10'd20)
				begin
					Red = 8'hf4;
					Green = 8'h8c;
					Blue = 8'h42;
				end
				else
				begin
					Red = 8'hff;
					Green = 8'h00;
					Blue = 8'h00;
				end
		  end
		  
		  
        else 
        begin
				
				// White Background
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
		  
		 
		  
		  
    end //for big comb block
	 
	 
	 
			/*
		  if(p1_won == 1'b1 || p2_won == 1'b1)
		  begin
					if((DrawX >= 10'd264) && (DrawX < 10'd272) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
					
						if(font_data[10'd8 - DrawX - 10'd264] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd274) && (DrawX < 10'd282) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd274] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd284) && (DrawX < 10'd292) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd284] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd294) && (DrawX < 10'd302) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd294] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd304) && (DrawX < 10'd312) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd304] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd314) && (DrawX < 10'd322) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd314] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd324) && (DrawX < 10'd332) && (DrawY >= 10'd232) && (DrawY < 10'd248) && p1_won == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd324] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if( (DrawX >= 10'd324) && (DrawX < 10'd332) && (DrawY >= 10'd232) && (DrawY < 10'd248) && p2_won == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd324] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd338) && (DrawX < 10'd346) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd338] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd348) && (DrawX < 10'd356) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd348] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd358) && (DrawX < 10'd366) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd358] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if((DrawX >= 10'd368) && (DrawX < 10'd376) && (DrawY >= 10'd232) && (DrawY < 10'd248))
					begin
						if(font_data[10'd8 - DrawX - 10'd368] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h00;
						end
		  end  */
	 
	 
	 /*
	 
	 if(P == 1'b1)
					begin
					
						if(font_data[10'd8 - DrawX - 10'd264] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(L == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd274] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(A == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd284] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(Y == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd294] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(E == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd304] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(R == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd314] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(ONE == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd324] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if( TWO == 1'b1 )
					begin
						if(font_data[10'd8 - DrawX - 10'd324] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(W == 1'b1 )
					begin
						if(font_data[10'd8 - DrawX - 10'd338] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if( I == 1'b1 )
					begin
						if(font_data[10'd8 - DrawX - 10'd348] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if( N == 1'b1 )
					begin
						if(font_data[10'd8 - DrawX - 10'd358] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else if(S == 1'b1)
					begin
						if(font_data[10'd8 - DrawX - 10'd368] == 1'b1)
					   begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'hff;
					   end
					end
					else
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue = 8'h00;
						end
	 
	 */

	 
	 
	 
	 
	 
	
    
endmodule
