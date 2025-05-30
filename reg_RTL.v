//======= reg_RTL.v ================
module reg_RTL
  #( parameter MAX_WIDTH = 8)
   ( input  wire clk,
     input  wire rst,
     input  wire en,
	  input  wire sclr,
     input  wire[MAX_WIDTH-1:0]  d,
     output reg [MAX_WIDTH-1:0]  q);
	
	//Preguntar si asi esta bien :3
	
   always @(posedge clk, posedge rst) begin
     if (rst)
       q <= {MAX_WIDTH{1'b0}};
     else if(sclr)
	  //INCLUIR SYNC CLEAR DENTRO -> ESA SENAL SE PONE EN CERO
       q <= {MAX_WIDTH{1'b0}};
	  else if(en)
	    q <= d;
   end

endmodule
