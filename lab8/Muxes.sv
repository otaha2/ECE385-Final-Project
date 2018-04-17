module mux2 						//2-1 mux   //from website
		#(parameter width = 128) 	
		(input logic [width-1:0] d0, d1,
		input logic s, 
		output logic [width-1:0] y);


		always_comb 
		begin 
			if (s) 
			 //do we need begin and end?
				y = d1; 
			else 
				y = d0;
		end 
		
endmodule
//default with 8-bit width mux2 my_8_mux (.d0(bus8_a), .d1(bus8_b), ...)
//16-bit mux instead of 8-bit mux2 #(width = 16) my_16_mux (.d0(bus16_a), .d1(bus16_b), ...


module mux4			//4-1 mux
	#(parameter width = 128)
	(
		input logic [width-1:0] A0, A1, A2, A3,
		input logic [1:0] select,
		output logic [width-1:0] OUT
	);
		always_comb
		begin
		
			case(select)
				2'b00 : OUT = A0;
				2'b01 : OUT = A1;
				2'b10 : OUT = A2;
				2'b11 : OUT = A3;
			endcase
		end
	
		
endmodule
	

	
module REG(input logic  CLK, Load, RESET, 
			  input logic  [127:0] DD, 
			  output logic [127:0] Q );
				 
				 
always_ff @ (posedge CLK) 
begin 

	if (RESET) 
			Q <= 128'b0; 
	
	else 
		if (Load) 
			Q <= DD; 
			else //in most cases this is redundant, maintaining Q inferred 
			Q <= Q;
			
end 

endmodule
	
	
	
	
	
	
	
	



	
	
	
	
module mux16			//16-1 mux
	(
		input logic [15:0] A0, A1, A2, A3,
		input logic [3:0] select,
		output logic [15:0] OUT
	
	);
	
		
		always_comb
		begin
		
			case(select)
				4'b0001 : OUT = A0;
				4'b0010 : OUT = A1;
				4'b0100 : OUT = A2;
				4'b1000 : OUT = A3;
				default: OUT = 16'hXXXX;
			endcase
		end

endmodule
	
	
	

	

	
	
	