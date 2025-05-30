`timescale 1ns/1ps

module PDUA_tb();

    // Señales
	 
	 reg clk;
	 reg rst;
	 reg INT;


    // Instancia del DUT (Device Under Test)
    PDUA_CONTROLU  PDUA (
      .clk(clk),
	   .rst(rst),
	   .INT(INT)
    );

    // Reloj: 10ns período (100MHz)
    always #5 clk = ~clk;

    // Estímulos
    initial begin
	
					  
        // Inicializar señales
        clk = 0;
        rst = 1;
		  INT = 0;
		  #10;
		  
		  // Inicializar señales
        clk = 0;
        rst = 0;
		  INT = 0;
		  #44000;
		  

//		  // Prueba de fetch sin intp 
//        clk = 0;
//        rst = 0;
//		  Z = 0; 
//		  N = 0;
//		  C = 0;
//		  P = 0; 
//		  opcode  = 5'b00000;
//		  intp = 0; 



		   
        $finish;
    end

endmodule
