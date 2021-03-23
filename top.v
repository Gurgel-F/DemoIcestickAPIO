`include "cores/uart.v"
`include "cores/clock.v"

module top(
	input CLK,
	input RX,
	output TX,
	output D1,
	output D2,
	output D3,
	output D4,
	output D5
	);

	//uart Module
	wire reset = 0;
	reg transmit;
	reg [7:0] tx_byte;
	wire received;
	wire [7:0] rx_byte;
	wire is_receiving;
	wire is_transmitting;
	wire recv_error;
	
	assign D5 = recv_error;
	
	uart #(
		.baud_rate(9600),                 // The baud rate in kilobits/s
		.sys_clk_freq(12000000)            // The master clock frequency
	)
	uart0(
		.clk(CLK),                        // The master clock for this module
		.rst(reset),                      // Synchronous reset
		.rx(RX),                		  // Incoming serial line
		.tx(TX),                	      // Outgoing serial line
		.transmit(transmit),              // Signal to transmit
		.tx_byte(tx_byte),                // Byte to transmit
		.received(received),              // Indicated that a byte has been received
		.rx_byte(rx_byte),                // Byte received
		.is_receiving(is_receiving),      // Low when receive line is idle
		.is_transmitting(is_transmitting),// Low when transmit line is idle
		.recv_error(recv_error)           // Indicates error in receiving packet.
	);
	
	
	// Custom Clk Module
	reg [3:0] clk_count;
	wire clk_t;
	
	clock #(
		.master_clk_frq(12000000),           // The master clock frequency
		.clk_period(500)				  	 // clock in ms
	)
	clk0(
		.clk(CLK),
		.mod_clk(clk_t)					  // desired clock  
	);
		
	always @(posedge clk_t)
		clk_count <= clk_count + 1;
		
	assign {D4, D3, D2, D1} = clk_count;
	
	
	reg [7:0]crc_in;
	reg [7:0]in;
	reg [7:0]crc_out;
	
	initial crc_in  = 8'h00;
	initial in = 8'h00;
	
	// Polynomial = 8'h07
	always @(*) begin
		crc_out[0] = in[0] ^ in[6] ^ in[7] ^ crc_in[0] ^ crc_in[6] ^ crc_in[7];
		crc_out[1] = in[0] ^ in[1] ^ in[6] ^ crc_in[0] ^ crc_in[1] ^ crc_in[6];
		crc_out[2] = in[0] ^ in[1] ^ in[2] ^ in[6] ^ crc_in[0] ^ crc_in[1]^ crc_in[2] ^ crc_in[6];
		crc_out[3] = in[1] ^ in[2] ^ in[3] ^ in[7] ^ crc_in[1] ^ crc_in[2] ^ crc_in[3] ^ crc_in[7];
		crc_out[4] = in[2] ^ in[3] ^ in[4] ^ crc_in[2] ^ crc_in[3] ^ crc_in[4];
		crc_out[5] = in[3] ^ in[4] ^ in[5] ^ crc_in[3] ^ crc_in[4] ^ crc_in[5];
		crc_out[6] = in[4] ^ in[5] ^ in[6] ^ crc_in[4] ^ crc_in[5] ^ crc_in[6];
		crc_out[7] = in[5] ^ in[6] ^ in[7] ^ crc_in[5] ^ crc_in[6] ^ crc_in[7];
	end
	
	//Print crc byte
	always @(posedge CLK) begin
		if(received) begin
			in = rx_byte;
			tx_byte = crc_out;
			transmit <= 1;
		end
		else
			transmit <= 0;
	end

endmodule
