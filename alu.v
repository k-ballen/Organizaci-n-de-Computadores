// alu.v - Verilog version of the ALU

module alu #(
    parameter MAX_WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire [MAX_WIDTH-1:0] busA,
    input wire [MAX_WIDTH-1:0] busB,
    input wire [2:0] selop,
    input wire [1:0] shamt,
    input wire enaf,
    output wire [MAX_WIDTH-1:0] busC,
    output wire C,
    output wire N,
    output wire P,
    output wire Z
);

	wire[7:0] result1;
	wire cout;
	
	//Conexiones bloque Processing_unit	
	processing_unit #(.N(8)) proc_u (
        .dataa(busA),
        .datab(busB),
        .selop(selop),
        .result(result1),
        .cout(cout)
    );
	 
	 //Conexiones Flag Register
	 flag_register #(.MAX_WIDTH(8)) flag_r ( 
			.clk(clk), 
			.rst(rst), 
			.enaf(enaf), 
			.dataa(result1), 
			.carry(cout), 
			.C(C), .N(N), .P(P), .Z(Z)
	 );
	 
	 //Conexiones Shift Unit
	 shift_unit #(.N(8)) shift_u (
			.dataout(busC), 
			.dataa(result1), 
			.shamt(shamt)
	 );

endmodule	 