`timescale 1ps/1ps

module RAM_tb;
  // Parámetros
  parameter N = 32;  // Tamaño de datos de 32 bits
  parameter M = 32;  // Tamaño de direcciones de 5 bits
  parameter MEM_DEPTH = 32;  // Profundidad de memoria de 32 palabras

  // Señales de prueba
  reg [M-1:0] address_a;
  reg [M-1:0] address_b;
  reg clock = 0;
  reg [N-1:0] data_a;
  reg [N-1:0] data_b;
  reg wren_a;
  reg wren_b;
  wire [N-1:0] q_a;
  wire [N-1:0] q_b;
  
  
  RAM ram_inst(
			  .address_a(address_a[15:0]),
			  .address_b(address_b[15:0]),
			  .clock(clock),
			  .data_a(data_a),
			  .data_b(data_b),
			  .wren_a(wren_a),
			  .wren_b(wren_a),
			  .q_a(q_a),
			  .q_b(q_b)
	);
	
  
  // Clock generation
  always #5 clock = ~clock;

  // Inicialización
  initial begin	 
	 #10;
	 
	 address_a = 653;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;

	 address_a = 1;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 2;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 3;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 4;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 5;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 6;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_a = 7;
    wren_a = 1'b0;
	 #10;
	 $display("Dato de salida: q_a = %d", q_a);
	 $display("En la direccion: address_a = %d", address_a);
	 
	 
	 $display("_________________________________________________");
	 $display("_________________________________________________");
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 653;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;

	 address_b = 1;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 2;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 3;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 4;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 5;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 6;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");
	 
	 #10;
	 
	 address_b = 7;
    wren_b = 1'b0;
	 #10;
	 $display("Dato de salida: q_b = %d", q_b);
	 $display("En la direccion: address_b = %d", address_b);
	 
	 
	 $display("_________________________________________________");

    
    $finish;
  end
endmodule
