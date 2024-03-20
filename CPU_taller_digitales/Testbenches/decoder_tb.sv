module decoder_tb;

  // Inputs
  logic [3:0] Cond;
  logic [1:0] Op;
  logic [5:0] Funct;
  logic [3:0] Rd;

  // Outputs
  logic [1:0] FlagW;
  logic PCS;
  logic RegW;
  logic MemW;
  logic MemtoReg;
  logic ALUSrc;
  logic [1:0] ImmSrc;
  logic [1:0] RegSrc;
  logic [1:0] ALUControl;

  // Instantiate the decoder module
  decoder u_decoder (
	 .Cond(Cond),
    .Op(Op),
    .Funct(Funct),
    .Rd(Rd),
    .FlagW(FlagW),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .MemtoReg(MemtoReg),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl)
  );

  // Stimulus generation
  initial begin
    // Test with Op = 2'b00, Funct = 6'b000000, Rd = 4'b0000
	 Cond = 4'b0000;
    Op = 2'b00;
    Funct = 6'b000000;
    Rd = 4'b0000;
    #10; // Wait for a few time units
    $display("Time = %0t, FlagW = %b, PCS = %b, RegW = %b, MemW = %b, MemtoReg = %b, ALUSrc = %b, ImmSrc = %b, RegSrc = %b, ALUControl = %b",
             $time, FlagW, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl);
    
    // Test with Op = 2'b01, Funct = 6'b000000, Rd = 4'b0001
	 Cond = 4'b0000;
    Op = 2'b01;
    Funct = 6'b000000;
    Rd = 4'b0001;
    #10; // Wait for a few more time units
    $display("Time = %0t, FlagW = %b, PCS = %b, RegW = %b, MemW = %b, MemtoReg = %b, ALUSrc = %b, ImmSrc = %b, RegSrc = %b, ALUControl = %b",
             $time, FlagW, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl);
    
    // Test with Op = 2'b10, Funct = 6'b000001, Rd = 4'b1111
	 Cond = 4'b0000;
    Op = 2'b10;
    Funct = 6'b000001;
    Rd = 4'b1111;
    #10; // Wait for a few more time units
    $display("Time = %0t, FlagW = %b, PCS = %b, RegW = %b, MemW = %b, MemtoReg = %b, ALUSrc = %b, ImmSrc = %b, RegSrc = %b, ALUControl = %b",
             $time, FlagW, PCS, RegW, MemW, MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl);
    
    #10 $finish; // Finish the simulation
  end

endmodule
