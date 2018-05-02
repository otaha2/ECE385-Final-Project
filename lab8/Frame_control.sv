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










