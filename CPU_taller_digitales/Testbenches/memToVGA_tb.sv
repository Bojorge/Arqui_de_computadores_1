`timescale 1ps/1ps

module memToVGA_tb();

	logic clk = 0; 
	logic vga_clk = 0;
	logic reset = 0;
	logic enable = 1;
	logic [31:0] memAddress = 0;
	logic [31:0] WriteData, DataAdr, ReadData;
	logic MemWrite;
	logic [31:0] pixel;
	
	RAM ram_i(
		.address_a(DataAdr[15:0]),
		.address_b(memAddress[15:0]),
		.clock(clk),
		.data_a(WriteData),
		.data_b(WriteData),
		.wren_a(1'b0),  
		.wren_b(1'b0), 
		.q_a(ReadData),
		.q_b(pixel)
	);

	always_ff @(posedge vga_clk) begin
		if (reset) begin
			memAddress <= 0;
		end else if (enable) begin
			if (memAddress < 65536) begin
				memAddress <= memAddress + 1;
			end
		end
	end
	 
	always_ff @(posedge vga_clk) begin
		$display("memAddress = %d", memAddress);
		$display("pixel = %d", pixel);
	end

	always #5 clk = ~clk;
	always #10 vga_clk = ~vga_clk;
	 
	initial begin
		reset = 1;
		#10 reset = 0;

		#100000 $finish;
	end

endmodule
