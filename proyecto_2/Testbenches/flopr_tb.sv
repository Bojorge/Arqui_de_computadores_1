module flopr_tb;

  // Inputs
  logic clk = 0;
  logic reset;
  logic [7:0] d; // Assuming WIDTH is 8 bits

  // Outputs
  logic [7:0] q; // Assuming WIDTH is 8 bits

  // Instantiate the flopr module
  flopr #(.WIDTH(8)) u_flopr (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  // Clock generation
  always #5 clk = ~clk;

  

  // Stimulus generation
  initial begin
	 #100
	 
	 reset = 1'b0;
    d = 8'd12; // Set the data input
    #100; // Wait for a few clock cycles
	 $display("Time = %0t, q = %d", $time, q);
	 
    d = 8'd34; // Change the data input
    #100; // Wait for a few more clock cycles
    $display("Time = %0t, q = %d", $time, q);
	 
	 reset = 1'b1;
	 #100; // Wait for a few more clock cycles
    $display("Time = %0t, q = %d", $time, q);
	 
	 
    #100 
	 $finish; // Finish the simulation
  end

endmodule
