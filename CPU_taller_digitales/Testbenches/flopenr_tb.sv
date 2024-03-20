module flopenr_tb;

  // Inputs
  logic clk = 0;
  logic reset;
  logic en;
  logic [7:0] d; // Assuming WIDTH is 8 bits

  // Outputs
  logic [7:0] q; // Assuming WIDTH is 8 bits

  // Instantiate the flopenr module
  flopenr #(.WIDTH(8)) u_flopenr (
    .clk(clk),
    .reset(reset),
    .en(en),
    .d(d),
    .q(q)
  );

  // Clock generation
  always #5 clk = ~clk;


  // Stimulus generation
  initial begin
	 #50
	 
	 reset = 1'b1;
	 en = 1'b0; // Enable the flip-flop
	 #50
	 $display("Time = %0t, q = %h", $time, q);
	 reset = 1'b0;
	 #50;
	 
    d = 8'h12; // Set the data input
    en = 1'b0; // Enable the flip-flop
    #50; // Wait for a few clock cycles
	 $display("Time = %0t, q = %h", $time, q);
	 
	 #50;
	 
    d = 8'h34; // Change the data input
	 en = 1'b0; // Enable the flip-flop
    #50; // Wait for a few clock cycles
	 $display("Time = %0t, q = %h", $time, q);
	 
	 #50;
	 
    d = 8'h12; // Set the data input
    en = 1'b1; // Enable the flip-flop
    #50; // Wait for a few clock cycles
	 $display("Time = %0t, q = %h", $time, q);
	 
	 #50;
	 
    d = 8'h34; // Change the data input
	  en = 1'b1; // Enable the flip-flop
    #50; // Wait for a few clock cycles
	 $display("Time = %0t, q = %h", $time, q);
	 
	 
	 #50
	 
	 reset = 1'b1;
	 #50
	 $display("Time = %0t, q = %h", $time, q);
	 
    #50 
	 $finish; // Finish the simulation
  end

endmodule
