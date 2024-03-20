`timescale 1ns/1ps

module datapath_tb;

  // Parámetros del tamaño de datos y profundidad de memoria
  parameter MEM_DEPTH = 64;

  // Señales de control
  reg clk, reset;
  
  // Señales de entrada
  reg [1:0] RegSrc;
  reg RegWrite;
  reg [1:0] ImmSrc;
  reg ALUSrc;
  reg [1:0] ALUControl;
  reg MemtoReg;
  reg PCSrc;
  reg [31:0] Instr;
  reg [31:0] ReadData;

  // Señales de salida
  wire [3:0] ALUFlags;
  wire [31:0] PC, ALUResult, WriteData;

  // Instancia del módulo datapath
  datapath dp_inst (
    .clk(clk),
    .reset(reset),
    .RegSrc(RegSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .ALUControl(ALUControl),
    .MemtoReg(MemtoReg),
    .PCSrc(PCSrc),
    .ALUFlags(ALUFlags),
    .PC(PC),
    .Instr(Instr),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );
  
  // Generación de reloj
  always #5 clk = ~clk;

  // Inicialización
  initial begin
    // Inicializar señales
    clk = 0;
    reset = 1;
    RegSrc = 2'b00;
    RegWrite = 0;
    ImmSrc = 2'b00;
    ALUSrc = 0;
    ALUControl = 2'b0000;
    MemtoReg = 0;
    PCSrc = 0;
    Instr = 32'h00000000;
    ReadData = 32'h00000000;
	 
	 $display("PC = %d", PC);

    // Esperar unos ciclos
    #10 reset = 0;
    $display("PC = %d", PC);
    // Esperar unos ciclos adicionales para que la simulación estabilice
    #10;
	 
	  $display("PC = %d", PC);

    // Configurar instrucción y datos para prueba
    //Instr = 32'h8C000000;  
    //ReadData = 32'h12345678; 

    // Esperar unos ciclos adicionales para que el resultado sea visible
    #20;
    
    // Mostrar el valor de PC
    $display("PC = %d", PC);

    // Finalizar simulación
    $finish;
  end

  // Añadir generación de estímulos adicionales según sea necesario

endmodule
