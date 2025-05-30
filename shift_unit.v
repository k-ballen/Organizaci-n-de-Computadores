// shift_unit.v - Verilog version of the shift unit

`timescale 1ns / 1ps

module shift_unit #(parameter N = 8) // Generic N
(
    input wire [1:0] shamt,
    input wire [N-1:0] dataa,
    output reg [N-1:0] dataout
);

// Mux Ver. 2
always @* begin
    case (shamt)
        2'b00: dataout = dataa; // No shift
        2'b01: dataout = {1'b0, dataa[N-1:1]}; // srl
        2'b10: dataout = {dataa[N-2:0], 1'b0}; // sll
        default: dataout = {N{1'b0}}; // NU, fill with zeros
    endcase
end

endmodule

// Note: Use only one of the following implementations:
//
//// Mux Ver. 1
//assign dataout = (shamt == 2'b00) ? dataa : // No shift
//                 (shamt == 2'b01) ? {1'b0, dataa[N-1:1]} : // srl
//                 (shamt == 2'b10) ? {dataa[N-2:0], 1'b0} : // sll
//                 {N{1'b0}}; // NU, fill with zeros