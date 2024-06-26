module DecodeExecute_register (
    input logic clk,
    input logic wbs_in,
    input logic [1:0] mm_in,
    input logic [2:0] ALUop_in,
	 input logic wm_in,
	 input logic am_in,
	 input logic ni_in,
	 
	 input logic wce_in,	
	 input logic wme1_in,
	 input logic wme2_in,
	 input logic alu_mux_in,
	 input logic reg_dest_in,
	 input logic [3:0] reg_dest_data_writeback_in,
	 
	 input logic wre_in,
	 
	 input logic [15:0] srcA_in,
	 input logic [15:0] srcB_in,
	 
    output logic wbs_out,
    output logic wme_out,
    output logic [1:0] mm_out,
    output logic [2:0] ALUop_out,
	 output logic wm_out,
	 output logic am_out,
	 output logic ni_out,
	 
	 output logic wce_out,	
	 output logic wme1_out,
	 output logic wme2_out,
	 output logic alu_mux_out,
	 output logic reg_dest_out,
	 output logic [3:0] reg_dest_data_writeback_out,
	 
	 output logic wre_out,
	 
	 output logic [15:0] srcA_out,
	 output logic [15:0] srcB_out
);

    logic wbs;
    logic [1:0] mm;
    logic [2:0] ALUop;
	 logic wm;
	 logic am;
	 logic ni;
	 logic wce;
    logic wme1;
    logic wme2;
	 logic alu_mux;
	 logic reg_dest;
	 logic [3:0] reg_dest_data_writeback;
	 
	 logic wre;
	 
	 logic [15:0] srcA;
	 logic [15:0] srcB;
    
    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
        mm <= mm_in;
        ALUop <= ALUop_in;
		  wm <= wm_in;
		  am <= am_in;
		  ni <= ni_in;
		  
		  wce <= wce_in;
		  wme1 <= wme1_in;
		  wme2 <= wme2_in;
		  alu_mux <= alu_mux_in;
		  reg_dest <= reg_dest_in;
		  reg_dest_data_writeback <= reg_dest_data_writeback_in;
		  
		  wre <= wre_in;
		  
		  srcA <= srcA_in;
		  srcB <= srcB_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
    assign mm_out = mm;
    assign ALUop_out = ALUop;
	 assign wm_out = wm;
	 assign am_out = am;
	 assign ni_out = ni;
	 
	 assign wce_out = wce;
    assign wme1_out = wme1;
	 assign wme2_out = wme2;
	 assign alu_mux_out = alu_mux;
	 assign reg_dest_out = reg_dest;
	 assign reg_dest_data_writeback_out = reg_dest_data_writeback;
	 
	 assign wre_out = wre;
	 
	 assign srcA_out = srcA;
	 assign srcB_out = srcB;

endmodule

