//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,HEX2, HEX3, HEX4, HEX5, HEX6,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
    /*         // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
				 
			*/	 
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
				
				input logic 			PS2_CLK,		
				input logic 			PS2_DAT
                    );
						  
    
    logic Reset_h, Clk;
    
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    /*logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset; */
    
	 logic frame_clk;
	 logic [9:0] DrawX, DrawY;
	 logic [9:0] p1x, p1y, p2x, p2y;
	 logic [9:0] action1, direction1, action2, direction2, health1, health2;
	 
	 logic is_player1, is_player2;
	 
	 logic [18:0] read_address1, read_address2;
	 logic [23:0] data_Out1, data_Out2;
	
	 
	 logic [7:0] keyCode, keypress; //keyCode outputs a value corresponding to the specific key (see Scan Codes in Resources),
	 logic press;     //press indicates whether the key was pressed or released.
	 
	 logic hit1, hit2, p2_won, p1_won;
	 
	 logic [10:0]	end_addr;
	 logic [7:0]	end_data;
	 
	 
	 
	 
	 //Instantiaze PS/2
	 keyboard      keyB(
								.Clk(CLOCK_50),
								.psClk(PS2_CLK), 
								.psData(PS2_DAT), 
								.reset(Reset_h),
								.keyCode(keyCode),
								.press(press)    
								);
								
	KeyPress			keykey(
								.Clk(Clk),
								.keycode(keyCode),
								.press(press),
								.keypress(keypress)
								);
	 

	  
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
	 
	 
	 
	 
	 
	 
	
	 
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(
														.Clk(Clk),        
						                        .Reset(Reset_h),      
						                        .VGA_HS(VGA_HS),     
						                        .VGA_VS(VGA_VS),     
						                        .VGA_CLK(VGA_CLK),    
						                        .VGA_BLANK_N(VGA_BLANK_N),
						                        .VGA_SYNC_N(VGA_SYNC_N),           
						                        .DrawX(DrawX),      
						                        .DrawY(DrawY)       
														);
    
    // Which signal should be frame_clk?
    
    color_mapper color_instance(
										.DrawX(DrawX),		//might not be write
										.DrawY(DrawY),		//
										.p1_w(10'd60),
										.p1_h(10'd70),
										.is_player1(is_player1),
										.is_player2(is_player2),
										.p1x(p1x),
										.p1y(p1y),
										.p2x(p2x),
										.p2y(p2y),
										.VGA_R(VGA_R),
										.VGA_G(VGA_G), 
										.VGA_B(VGA_B),
										.data1(data_Out1),
										.read_address1(read_address1),
										.data2(data_Out2),
										.read_address2(read_address2),
										.action1(action1),
										.action2(action2),
										.direction1(direction1),
										.direction2(direction2),
										.hit1(hit1),
									   .hit2(hit2),
										.health1(health1),
									   .health2(health2),
										.p2_won(p2_won),
										.p1_won(p1_won),
										.font_addr(end_addr),
										.font_data(end_data)
										);   
		
		


	  Frame_control  collision(
									.p1x(p1x),
									.p1y(p1y),
									.p2x(p2x),
									.p2y(p2y),
									.action1(action1),
									.action2(action2),
									.direction1(direction1),
									.direction2(direction2),
									.hit1(hit1),
									.hit2(hit2)
									);    
		
		
		player1       		p1(
									.frame_clk(VGA_VS),
									.Reset(Reset_h),
									.Clk(Clk),
									.p1x(p1x),
									.p1y(p1y),
									.is_player1(is_player1),
									.keycode(keyCode),
									.keypress(keypress),
									.DrawX(DrawX),
									.DrawY(DrawY),
									.press(press),
									.action1(action1),
									.direction1(direction1),
									.hit1(hit1),
									.hit2(hit2),
									.health1(health1),
									.p2_won(p2_won)
									);
									
		player2       		p2(
									.frame_clk(VGA_VS),
									.Reset(Reset_h),
									.Clk(Clk),
									.p2x(p2x),
									.p2y(p2y),
									.is_player2(is_player2),
									.keycode(keyCode),
									.keypress(keypress),
									.DrawX(DrawX),
									.DrawY(DrawY),
									.press(press),
									.action2(action2),
									.direction2(direction2),
									.hit1(hit1),
									.hit2(hit2),
									.health2(health2),
									.p1_won(p1_won)
									);
									
									
		
		
		
		frameROM 			 rom(
									.read_address1(read_address1),
									.read_address2(read_address2),
									.Clk(Clk),
									.data_Out1(data_Out1),
									.data_Out2(data_Out2)
									);
									
	   font_rom 			 fonts(
										.addr(end_addr),
										.data(end_data)
										);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
    
    // Display keycode on hex display
    HexDriver hex_inst_0 (hit1, HEX0); //(keyCode[3:0], HEX0);
    HexDriver hex_inst_1 (hit2, HEX1); //(keyCode[7:4], HEX1);
	 HexDriver hex_inst_2 (action1[3:0], HEX2);
    HexDriver hex_inst_3 (action2[3:0], HEX3);
	 HexDriver hex_inst_4 (press, HEX4);
	 HexDriver hex_inst_5 (p1x[3:0], HEX5);
	 HexDriver hex_inst_6 (p1x[7:4], HEX6);
	 
    
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
