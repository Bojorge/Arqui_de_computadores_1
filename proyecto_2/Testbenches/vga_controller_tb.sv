`timescale 1ns / 1ns

module vga_controller_tb;

  // Parámetros del módulo
  parameter HACTIVE = 640;
  parameter HFP = 16;
  parameter HSYN = 96;
  parameter HBP = 48;
  parameter VACTIVE = 480;
  parameter VFP = 10;
  parameter VSYN = 2;

  // Señales de prueba
  reg vga_clk;
  wire h_sync, v_sync, sync_b, blank_b;
  wire [9:0] x, y;

  // Instancia del módulo bajo prueba
  vga_controller #(
    .HACTIVE(HACTIVE),
    .HFP(HFP),
    .HSYN(HSYN),
    .HBP(HBP),
    .VACTIVE(VACTIVE),
    .VFP(VFP),
    .VSYN(VSYN)
  ) uut (
    .vga_clk(vga_clk),
    .h_sync(h_sync),
    .v_sync(v_sync),
    .sync_b(sync_b),
    .blank_b(blank_b),
    .x(x),
    .y(y)
  );

  // Generación de señales de prueba
  initial begin
    vga_clk = 0;
    forever begin
      #5 vga_clk = ~vga_clk;
    end
  end

  // Monitoreo de señales de salida
  always @(posedge vga_clk) begin
    $display("x: %d, y: %d, h_sync: %b, v_sync: %b, sync_b: %b, blank_b: %b", x, y, h_sync, v_sync, sync_b, blank_b);

    // Puedes agregar aserciones para verificar el comportamiento aquí
  end

  // Finalizar la simulación después de un tiempo
  initial begin
    #26000; // Ajusta este valor para controlar la duración de la simulación
    $finish;
  end
endmodule