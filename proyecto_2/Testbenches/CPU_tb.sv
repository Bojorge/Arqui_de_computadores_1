`timescale 1ns/1ps

module CPU_tb();
	logic clk = 0;
	logic reset = 1;
	logic [31:0] WriteData, DataAdr, ReadData;
	logic MemWrite;
	//logic [31:0] ins;
	
	
	
	
	CPU CPU_inst(.clk(clk), 
					 .reset(reset), 
					 .WriteData(WriteData), 
					 .DataAdr(DataAdr), 
					 .ReadData(ReadData), 
					 .MemWrite(MemWrite)
					 //.ins(ins)
	);
	
	
	always
	begin
		clk <= ~clk; 
		# 5;
		
	end
	
	
	always @(negedge clk)
	begin
		reset = 0;
		
		#10
		
		$display("----------------------------------------------------   1");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   2");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   3");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   4");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   5");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   6");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   7");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
		$display("----------------------------------------------------   8");
		$display("WriteData = %d", WriteData);
		$display("DataAdr = %d", DataAdr);
		$display("MemWrite = %d", MemWrite);
		$display("ReadData = %d", ReadData);
		//$display("ins = %b", ins);
		$display("-------------------------------------------------------");
	
		#10
		
	
		#10
				
		
		$finish;
	end
endmodule
	
	
	
	