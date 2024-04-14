module Processor_tb;

    // Parámetros del módulo
    logic [8:0] resultado;

    // Definimos los valores de los números a sumar
    logic [7:0] a = 5; // Primer número
    logic [7:0] b = 3; // Segundo número

    // Instanciación del módulo bajo prueba
    Processor dut (
        .resultado(resultado)
    );

    // Inicialización de la simulación
    initial begin
        // Hacer pruebas con diferentes valores de a y b
        #10; // Espera un ciclo de simulación antes de comenzar las pruebas

        // Primer caso de prueba: a = 5, b = 3
        $display("Caso de prueba 1: a = 5, b = 3");
        #5; // Espera 5 unidades de tiempo antes de verificar el resultado
        if (resultado === 8) // Verifica si el resultado es 8
            $display("El resultado es correcto: %d", resultado);
        else
            $display("El resultado es incorrecto: %d", resultado);

        // Segundo caso de prueba: a = 10, b = 20
        $display("Caso de prueba 2: a = 10, b = 20");
        #5; // Espera 5 unidades de tiempo antes de cambiar los valores de entrada
        a = 10; // Cambia el valor de a
        b = 20; // Cambia el valor de b
        #5; // Espera 5 unidades de tiempo antes de verificar el resultado
        if (resultado === 30) // Verifica si el resultado es 30
            $display("El resultado es correcto: %d", resultado);
        else
            $display("El resultado es incorrecto: %d", resultado);

        // Puedes agregar más casos de prueba aquí

        #10; // Espera un poco más antes de finalizar la simulación
        $finish; // Finaliza la simulación
    end

endmodule
