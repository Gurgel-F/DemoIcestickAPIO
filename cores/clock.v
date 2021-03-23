`timescale 1ns / 1ps

module clock(
	input clk,				// Master Clock
	output reg mod_clk 		// Custom clock value in ms
);

	integer count;
	
	parameter master_clk_frq = 100000000;     // Master Clock in Hz
	parameter clk_period = 1000;			// Clock Period in ms

	localparam cycle = (master_clk_frq/1000*clk_period/2);
	
	initial count <= 0;
	
	always @(posedge clk) begin
		count <= count >= cycle ? 0 : count + 1;
		if(count == 0)
			mod_clk <= ~mod_clk;
	end

endmodule
