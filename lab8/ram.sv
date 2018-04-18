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

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] p1_stand [0:4979];

initial
begin
	 $readmemh("Sprites/naruto_stand1.txt", p1_stand);
end


always_ff @ (posedge Clk) begin
	
	data_Out<= pl_stand[read_address];
end

endmodule
