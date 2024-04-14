module alu_tb;
  // Parámetro para la longitud de las palabras
  parameter N_bits = 32;

  // Señales de entrada
  reg [N_bits-1:0] SrcA;
  reg [N_bits-1:0] SrcB;
  reg [1:0] ALUControl;

  // Señales de salida
  wire [N_bits-1:0] ALUResult;
  wire [3:0] ALUFlags;

  // Instancia del módulo alu
  alu #(N_bits) ALU_inst (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .ALUFlags(ALUFlags)
  );

  // Inicialización
  initial begin
    // Prueba de suma (ALUControl = 2'b00)
    SrcA = 32'd2;
    SrcB = 32'd1;
    ALUControl = 2'b00;
    #10;
	 $display("SrcA = %d", SrcA);
	 $display("SrcB = %d", SrcB);
	 $display("ALUResult = %d", ALUResult);

    if (ALUResult !== (SrcA + SrcB))
      $display("Error en la suma");

    // Prueba de resta (ALUControl = 2'b01)
    SrcA = 32'd2;
    SrcB = 32'd1;
    ALUControl = 2'b01;
    #10;
	 $display("SrcA = %d", SrcA);
	 $display("SrcB = %d", SrcB);
	 $display("ALUResult = %d", ALUResult);
	 
    if (ALUResult !== (SrcA - SrcB))
      $display("Error en la resta");

    // Prueba de AND (ALUControl = 2'b10)
    SrcA = 32'd1;
    SrcB = 32'd1;
    ALUControl = 2'b10;
    #10;
	 $display("SrcA = %d", SrcA);
	 $display("SrcB = %d", SrcB);
	 $display("ALUResult = %d", ALUResult);
	 
    if (ALUResult !== (SrcA & SrcB))
      $display("Error en la operación AND");

    // Prueba de OR (ALUControl = 2'b11)
    SrcA = 32'd1;
    SrcB = 32'd1;
    ALUControl = 2'b11;
    #10;
	 $display("SrcA = %d", SrcA);
	 $display("SrcB = %d", SrcB);
	 $display("ALUResult = %d", ALUResult);
	 
    if (ALUResult !== (SrcA | SrcB))
      $display("Error en la operación OR");

    $display("Pruebas completadas");
    $finish;
  end
endmodule
