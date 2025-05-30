module mux_2a1_Cout  ( input wire [7:0]d1,                
                       input wire [7:0]d2,                     
                       input wire sel,               
                       output reg [7:0]Cout);         

   always @ (d1 or d2 or sel) begin
      case (sel)
         1'b0 : Cout <= d1;
         1'b1 : Cout <= d2;
      endcase
   end
endmodule
