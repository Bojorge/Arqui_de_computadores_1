module zeroExtend_tb;

    // Inputs
    logic [7:0] Immediate;
    
    // Outputs
    logic [15:0] ZeroExtImmediate;
    
    // Instantiate zeroExtend module
    zeroExtend u_zeroExtend (
        .Immediate(Immediate),
        .ZeroExtImmediate(ZeroExtImmediate)
    );

    // Test cases
    initial begin
        // Test case 1: Número positivo
        Immediate = 8'b00001011;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 1: ZeroExtImmediate = %b", ZeroExtImmediate);

        // Test case 2: Número negativo
        Immediate = 8'b10010100;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 2: ZeroExtImmediate = %b", ZeroExtImmediate);

        // Test case 3: Número con todos los bits en uno
        Immediate = 8'b11111111;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 3: ZeroExtImmediate = %b", ZeroExtImmediate);

        // Finalizar la simulación
        #10 $finish;
    end

endmodule
