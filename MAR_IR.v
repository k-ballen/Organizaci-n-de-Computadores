module MAR_IR #(parameter N = 8) // Generic N
(
    input wire [7:0] BUS_c,
    input wire       ir_en,
	 input wire       mar_en,
    input wire       clk,
	 input wire       rst,
	 input  wire      sclr,
    output wire [4:0] q_controlUnit,
    output wire [7:0] q_addressBus
);



// Registro de IR
reg_RTL #(.MAX_WIDTH(5)) reg_IR (
    .d(BUS_c[7:3]),
    .clk(clk),
    .en(ir_en),
	 .sclr(sclr),
    .rst(rst),
	 .q(q_controlUnit)
);

// Registro de MAR
reg_RTL #(.MAX_WIDTH(N)) reg_MAR (
    .d(BUS_c),
    .clk(clk),
    .en(mar_en),
	 .sclr(sclr),
    .rst(rst),
    .q(q_addressBus)
);

endmodule




