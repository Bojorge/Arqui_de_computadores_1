`timescale 1ps/1ps

module ROM_tb;
  // Parámetros
  parameter M = 32;  // Tamaño de datos de 32 bits
  parameter MEM_DEPTH = 32;  // Profundidad de memoria de 32 palabras

  // Señales de prueba
  reg [4:0] address;
  reg clock = 0;
  wire [M-1:0] q;

  // Instancia del módulo ROM
  ROM rom_inst (
    .address(address),
    .clock(clock),
    .q(q)
  );
  
  
  // Clock generation
  always #5 clock = ~clock;

  // Inicialización
  initial begin
    address = 0;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100

    address = 1;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100

    address = 2;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100

    address = 3;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100

    address = 4;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100

    address = 5;
    #10;
	 $display("Dato: q = %b", q);
	 $display("En la direccion: address = %d", address);
	 $display("_________________________________________________");
	 #100
	 
	 
	 
    $finish;
  end
endmodule
