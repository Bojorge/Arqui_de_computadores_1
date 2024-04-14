module condlogic_tb;

  // Inputs
  logic clk = 0;
  logic reset;
  logic [3:0] Cond;
  logic [3:0] ALUFlags;
  logic [1:0] FlagW;
  logic PCS;
  logic RegW;
  logic MemW;

  // Outputs
  logic PCSrc;
  logic RegWrite;
  logic MemWrite;

  // Instantiate the condlogic module
  condlogic u_condlogic (
    .clk(clk),
    .reset(reset),
    .Cond(Cond),
    .ALUFlags(ALUFlags),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite)
  );

  // Instantiate flagreg1 and flagreg0 modules
  flopenr #(2) flagreg1 (
    .clk(clk),
    .reset(reset),
    .en(FlagW[1]),
    .d(ALUFlags[3:2]),
    .q(ALUFlags[3:2])
  );

  flopenr #(2) flagreg0 (
    .clk(clk),
    .reset(reset),
    .en(FlagW[0]),
    .d(ALUFlags[1:0]),
    .q(ALUFlags[1:0])
  );

  // Instantiate condcheck module
  condcheck u_condcheck (
    .Cond(Cond),
    .Flags(ALUFlags),
    .CondEx(CondEx)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    #100;

    // Test 1: PCSrc and RegWrite are conditional
    reset = 1'b0;
    Cond = 4'b0100; // MI (negative)
    ALUFlags = 4'b0010; // CS (carry set)
    FlagW = 2'b11; // FlagW is conditional
    PCS = 1'b0; // Not conditional
    RegW = 1'b1; // Conditional
    MemW = 1'b0; // Not conditional

    // Check the results
    if (PCSrc !== 1'b0) $display("Test 1 Failed: PCSrc");
    if (RegWrite !== 1'b1) $display("Test 1 Failed: RegWrite");
    if (MemWrite !== 1'b0) $display("Test 1 Failed: MemWrite");

    // Add more test cases as needed...

    $finish; // Finish the simulation
  end

endmodule
