module Processor (
    output logic [8:0] resultado // Salida del resultado de la suma de 9 bits
);

    // Definimos los valores de los números a sumar
    logic [7:0] a = 5; // Primer número
    logic [7:0] b = 3; // Segundo número

    always_comb begin
        resultado = a + b; // Realiza la suma de los dos números y asigna el resultado
    end

endmodule