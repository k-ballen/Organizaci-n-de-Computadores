module mux_entrada  ( input wire d0,// es 0 NO jump
							  input wire d1,// es 1 Unconditional jump
							  input wire Z, //ZERO
							  input wire N, // NEGATIVE
							  input wire C, //CARRRY
							  input wire P, // PARITY
							  input wire intp, // JUMP IF INTERRUPT
							  input wire dd0, // Not used
                       input wire [2:0]jcond,               
                       output reg load);         

   always @ (d0 or d1 or Z or N or C or P or intp or dd0 or jcond) begin
      case (jcond)
         3'b000 : load <= 1'b0;
         3'b001 : load <= 1'b1;
			3'b010 : load <= Z;
			3'b011 : load <= N;
			3'b100 : load <= C;
			3'b101 : load <= P;
			3'b110 : load <= intp;
			3'b111 : load <= dd0;
      endcase
   end
endmodule
