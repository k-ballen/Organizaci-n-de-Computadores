`timescale 1ns/1ps

module controlUnit_tb();

    // Señales
	 
	 reg clk;
	 reg rst;
	 reg Z;
	 reg N;
	 reg C;
	 reg P;
	 reg intp;
	 reg[4:0] opcode;
	 wire[20:0] controlUnit_out;


    // Instancia del DUT (Device Under Test)
    controlUnit_up  controUnit (
      .clk(clk),
	   .rst(rst),
	   .Z(Z),
	   .N(N),
	   .C(C),
	   .P(P),
	   .intp(intp),
	   .opcode(opcode),
      .controlUnit_out(controlUnit_out)
    );

    // Reloj: 10ns período (100MHz)
    always #5 clk = ~clk;

    // Estímulos
    initial begin
	
					  
        // Inicializar señales
        clk = 0;
        rst = 1;
		  Z = 0; 
		  N = 0;
		  C = 0;
		  P = 0; 
		  opcode  = 5'b00000;
		  intp = 0;
		  #10;

//		  // Prueba de fetch sin intp 
//        clk = 0;
//        rst = 0;
//		  Z = 0; 
//		  N = 0;
//		  C = 0;
//		  P = 0; 
//		  opcode  = 5'b00000;
//		  intp = 0; 
//		  #80;
//		  

//		  // Prueba mov ACC, A 
//        clk = 0;
//        rst = 0;
//		  Z = 0; 
//		  N = 0;
//		  C = 0;
//		  P = 0; 
//		  opcode  = 5'b00001;
//		  intp = 0; 
//		  #80;
//		  
		  // Prueba de fetch sin intp 
        clk = 0;
        rst = 0;
		  Z = 0; 
		  N = 0;
		  C = 0;
		  P = 0; 
		  opcode  = 5'b00000;
		  intp = 1; 
		  #80;
		  
		  //reset
		  clk = 0;
        rst = 1;
		  Z = 0; 
		  N = 0;
		  C = 0;
		  P = 0; 
		  opcode  = 5'b00000;
		  intp = 0;
		  #10;
		   
        $finish;
    end

endmodule
