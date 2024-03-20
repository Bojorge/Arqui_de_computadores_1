module extend_tb;

  // Inputs
  logic [23:0] Instr;
  logic [1:0] ImmSrc;

  // Outputs
  logic [31:0] ExtImm;

  // Instantiate the extend module
  extend u_extend (
    .Instr(Instr),
    .ImmSrc(ImmSrc),
    .ExtImm(ExtImm)
  );

  // Stimulus generation
  initial begin
    // Test with 8-bit unsigned immediate (ImmSrc = 2'b00)
    Instr = 24'b000000000000001110000000; // Set the instruction
    ImmSrc = 2'b00;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    // Test with 12-bit unsigned immediate (ImmSrc = 2'b01)
    Instr = 24'b000000000011100000000000; // Set a different instruction
    ImmSrc = 2'b01;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    // Test with 24-bit two's complement shifted branch (ImmSrc = 2'b10)
    Instr = 24'b100000000000000000000000; // Set a different instruction
    ImmSrc = 2'b10;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    // Test with an undefined ImmSrc value
    Instr = 24'b101010101010000000000000; // Set another instruction
    ImmSrc = 2'b11; // Undefined value
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
	 
	 // Test with 8-bit unsigned immediate (ImmSrc = 2'b00)
    Instr = 24'b000000000000001110000000; // Set the instruction
    ImmSrc = 2'b00;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    // Test with 12-bit unsigned immediate (ImmSrc = 2'b01)
    Instr = 24'b000000000011100000000000; // Set a different instruction
    ImmSrc = 2'b01;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    // Test with 24-bit two's complement shifted branch (ImmSrc = 2'b10)
    Instr = 24'b100000000000000000000000; // Set a different instruction
    ImmSrc = 2'b10;
    #10; // Wait for a few time units
    $display("Time = %0t, ExtImm = %b", $time, ExtImm);
    
    
    #10 $finish; // Finish the simulation
  end

endmodule
