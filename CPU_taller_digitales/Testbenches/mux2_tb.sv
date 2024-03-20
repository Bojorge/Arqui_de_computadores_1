module mux2_tb;

  // Parameters
  parameter WIDTH = 8;
  
  // Inputs
  logic [WIDTH-1:0] d0, d1;
  logic s;
  
  // Outputs
  logic [WIDTH-1:0] y;
  
  // Instantiate the mux2 module
  mux2 #(WIDTH) u_mux2 (
    .d0(d0),
    .d1(d1),
    .s(s),
    .y(y)
  );

  always begin
    #5 d0 = $random;
    #5 d1 = $random;
    #5 s = $random % 2; // Randomize s to be 0 or 1
  end

  // Monitor the output
  always @(posedge y) begin
    $display("d0 = %d, d1 = %d, s = %b, y = %d", d0, d1, s, y);
  end

  initial begin
    #200 $finish;
  end

endmodule