module arm_tb;

  // Inputs
  logic clk = 0;
  logic reset = 1;
  logic [31:0] Instr;
  logic [31:0] ReadData;

  // Outputs
  logic MemWrite;
  logic [31:0] PC;
  logic [31:0] ALUResult;
  logic [31:0] WriteData;

  // Instantiate the arm module
  arm u_arm (
    .clk(clk),
    .reset(reset),
    .Instr(Instr),
    .ReadData(ReadData),
    .MemWrite(MemWrite),
    .PC(PC),
    .ALUResult(ALUResult),
    .WriteData(WriteData)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
  reset = 1'b1; // Activa el reset al principio

  #100; // Espera un poco

  reset = 1'b0; // Desactiva el reset para comenzar la operación normal

  // Configura Instr y ReadData con los valores deseados para la prueba
  Instr = 32'b11010010000000000000000100100010; // Ejemplo de instrucción
  ReadData = 32'hAABBCCDD; // Ejemplo de datos de lectura

  // Espera suficiente tiempo para que el módulo procese las entradas
  #1000;

  // Muestra los resultados
  $display("MemWrite = %b", MemWrite);
  $display("PC = %h", PC);
  $display("ALUResult = %h", ALUResult);
  $display("WriteData = %h", WriteData);

  $finish; // Finaliza la simulación
end


endmodule
