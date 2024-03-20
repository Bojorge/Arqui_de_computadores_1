module regfile_tb;

  // Inputs
  logic clk = 1;
  logic we3;
  logic [3:0] a1, a2, a3;
  logic [31:0] wd3, r15;
  
  // Outputs
  logic [31:0] rd1, rd2;
  
  // Instantiate the regfile module
  regfile u_regfile (
    .clk(clk),
    .we3(we3),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .wd3(wd3),
    .r15(r15),
    .rd1(rd1),
    .rd2(rd2)
  );

  
  always #10 clk = ~clk;


  initial begin
	 #30; // Wait
	 
    // Write data into a register 0
    we3 = 1'b1;
    a3 = 4'b0000; // Address of the register where data will be written
    wd3 = 32'd0; // Data to be written
    r15 = 32'd1515; // Initialize r15 with a value
	 
    #30; // Wait for a few clock cycles
    
	 we3 = 1'b0;	// Disable write
	 
    // Read data from the register 0
    a1 = 4'b0000; // Address of the register to read from
    a2 = 4'b1111; // Read r15 for reference
	 
    #30; // Wait for data to propagate
	 $display("Time = %0t, rd1 = %d, rd2 = %d", $time, rd1, rd2);
    
	 /////////////////////////////////////////////////////////////////////////////////////////////
	 
	 // Write data into a register 1
    we3 = 1'b1;
    a3 = 4'b0001; // Address of the register where data will be written
    wd3 = 32'd1; // Data to be written
    r15 = 32'd1515; // Initialize r15 with a value
	 
    #30; // Wait for a few clock cycles
    
	 we3 = 1'b0;	// Disable write
	 
    // Read data from the register 1
    a1 = 4'b0001; // Address of the register to read from
    a2 = 4'b1111; // Read r15 for reference
	 
    #30; // Wait for data to propagate
	 $display("Time = %0t, rd1 = %d, rd2 = %d", $time, rd1, rd2);
    
	 /////////////////////////////////////////////////////////////////////////////////////////////
	 
	 // Write data into a register 2
    we3 = 1'b1;
    a3 = 4'b0010; // Address of the register where data will be written
    wd3 = 32'd2; // Data to be written
    r15 = 32'd1515; // Initialize r15 with a value
	 
    #30; // Wait for a few clock cycles
    
	 we3 = 1'b0;	// Disable write
	 
    // Read data from the register 2
    a1 = 4'b0010; // Address of the register to read from
    a2 = 4'b1111; // Read r15 for reference
	 
    #30; // Wait for data to propagate
	 $display("Time = %0t, rd1 = %d, rd2 = %d", $time, rd1, rd2);
	 
	 /////////////////////////////////////////////////////////////////////////////////////////////
	 
	 // Write data into a register 3
    we3 = 1'b1;
    a3 = 4'b0011; // Address of the register where data will be written
    wd3 = 32'd3; // Data to be written
    r15 = 32'd1515; // Initialize r15 with a value
	 
    #30; // Wait for a few clock cycles
    
	 we3 = 1'b0;	// Disable write
	 
    // Read data from the register 3
    a1 = 4'b0011; // Address of the register to read from
    a2 = 4'b1111; // Read r15 for reference
	 
    #30; // Wait for data to propagate
	 $display("Time = %0t, rd1 = %d, rd2 = %d", $time, rd1, rd2);
	 #100;
	 /////////////////////////////////////////////////////////////////////////////////////////////
	 
	 #100;
	 we3 = 1'b0;
	 a1 = 4'b0000;
    a2 = 4'b0001;
	 $display(">>> rd1 = %d   >>> rd2 = %d", rd1, rd2);
	 
	 
	 #100;
	 we3 = 1'b0;
	 a1 = 4'b0010;
    a2 = 4'b0011;
	 $display(">>> rd1 = %d   >>> rd2 = %d", rd1, rd2);
	 
	 
	 #100;
	 we3 = 1'b0;
	 a1 = 4'b0000;
    a2 = 4'b0001;
	 $display(">>> rd1 = %d   >>> rd2 = %d", rd1, rd2);
	 
	 
	 #100;
	 we3 = 1'b0;
	 a1 = 4'b0010;
    a2 = 4'b0011;
	 $display(">>> rd1 = %d   >>> rd2 = %d", rd1, rd2);
	 
	 
	 
    // Finish simulation
    #100 
	 
	 $finish;
  end

endmodule