/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameROM
(

		input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

// mem has width of 24 bits and a total of 4980 addresses
logic [23:0] stick_figure [0:75599];

initial
begin
	 $readmemh("Sprites/stick_figure_sprite.txt", stick_figure);
	 //$readmemh("Sprites/naruto_stand1.txt", stand1);
end


always_ff @ (posedge Clk) 
begin
	data_Out <= stick_figure[read_address];
	//data_Out <= stand1[read_address];
end

endmodule
