module memToVGA(
  input logic clk,
  input logic [31:0] q_b,
  input logic enable,
  input logic rst,
  output logic [13:0] memAddress,
  output logic [31:0] pixel
);

  always_ff @(posedge clk) begin
    if (rst) begin
      memAddress <= 0;
      pixel <= 0;
	 end else if (memAddress > 10000) begin
		memAddress <= 0;
    end else if (enable) begin
      pixel <= q_b;  
      memAddress <= memAddress + 1;
    end
  end


endmodule

