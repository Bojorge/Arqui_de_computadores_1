`timescale 1ns / 1ps

module TopModule_tb;

  // Parámetros
  parameter CLK_PERIOD = 10; // Periodo del reloj en unidades de tiempo

  // Señales del testbench
  logic clk;
  logic rst;
  logic vga_clk;
  logic h_sync, v_sync, sync_b, blank_b;
  logic [7:0] red, green, blue;
  logic [31:0] memAddress, pixel;
  logic [9:0] x, y;

  // Instancia del módulo bajo prueba
  TopModule uut (
    .clk(clk),
    .rst(rst),
    .vga_clk(vga_clk),
    .h_sync(h_sync),
    .v_sync(v_sync),
    .sync_b(sync_b),
    .blank_b(blank_b),
    .red(red),
    .green(green),
    .blue(blue),
    .memAddress(memAddress),
    .pixel(pixel),
    .x(x),
    .y(y)
  );

  // Generación de pulsos de reloj
  initial begin
    clk = 0;
    forever #((CLK_PERIOD / 2)) clk = ~clk;
  end
  
  always_ff @(posedge vga_clk) begin
		 $display("X = %d", x);
		 $display("Y = %d", y);
		 $display("Memory Address = %d", memAddress);
		 $display("Pixel = %d", pixel);
		 
		 $display("---------------------------------------------");
		 $display("---------------------------------------------");
		 $display("---------------------------------------------");

  end

  // Secuencia de prueba
  initial begin
    // Desactivar reset y habilitar el módulo
    rst = 0;

    #20000;
	 $finish;
  end

endmodule
