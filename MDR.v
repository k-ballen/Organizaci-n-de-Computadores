module MDR #(parameter N = 8) // Generic N
(
    input wire [7:0] bus_alu,
	 input wire [7:0] bus_data_in,
    input wire       mdr_alu_n,
	 input wire       mdr_en,
    input wire       clk,
	 input wire       rst,
	 input  wire      sclr,
    output wire [7:0] bus_c,
    output wire [7:0] bus_data_out
);

wire[7:0]   out_q1;
wire[7:0]   out_q2;

// Registro de IR 
reg_RTL #(.MAX_WIDTH(N)) reg_1 (
    .d(bus_data_in),
    .clk(clk),
    .en(mdr_en),
	 .sclr(sclr),
    .rst(rst),
	 .q(out_q1)
);

// Registro de MAR
reg_RTL #(.MAX_WIDTH(N)) reg_2 (
    .d(bus_alu),
    .clk(clk),
    .en(mdr_en),
	 .sclr(sclr),
    .rst(rst),
    .q(out_q2)
);

	
// Mux para cout
mux_2a1_Cout  mux_cout (
			.d1(bus_alu), 
			.d2(out_q1), 
			.sel(mdr_alu_n), 
			.Cout(bus_c)
);

assign bus_data_out = out_q2; 
	
endmodule
