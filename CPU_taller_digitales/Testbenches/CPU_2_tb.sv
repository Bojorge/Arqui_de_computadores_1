`timescale 1 ps / 1 ps

module CPU_2_tb();

	logic clk = 0;
	logic vga_clk = 0;
	logic reset = 1;
	logic enable = 1;
	logic [31:0] WriteData, DataAdr, ReadData;
	logic MemWrite;
	logic [31:0] pixel;
	logic [31:0] memAddress = 0;

			  	
	CPU CPU_inst(.clk(clk), 
					 .vga_clk(vga_clk),
					 .reset(reset), 
					 .enable(enable),
					 .WriteData(WriteData), 
					 .DataAdr(DataAdr), 
					 .ReadData(ReadData), 
					 .MemWrite(MemWrite),
					 .pixel(pixel),
					 .x(memAddress)
	);	
	
		
	
	
	 
	always_ff @(posedge vga_clk) begin
		$display("memAddress = %d", memAddress);
		$display("pixel = %d", pixel);
	end

	always #5 clk = ~clk;
	always #10 vga_clk = ~vga_clk;
	 
	initial begin
		reset = 1;
		#10 reset = 0;

		#1000 $finish;
	end

endmodule
