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
                       input 			[9:0] p1x, p1y;
							  input			[0:4978][0:23] p1_stand, //sprite standing
							  output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
	 logic [0:23] color;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
        if (is_player1)
        begin
            //get color from sprite
				
				color = p1_stand[DrawX + DrawY*p1_w];
				
            Red = color[23:16];
            Green = color[15:8];
            Blue = color[7:0];
        end
        else 
        begin
            // Background with nice color gradient
            //Red = 8'h3f; 
            //Green = 8'h00;
            //Blue = 8'h7f - {1'b0, DrawX[9:3]};
				
				// White Background
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
    end 
    
endmodule
