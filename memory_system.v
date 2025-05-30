// Sistema de memorias y registros integrado con la ALU del procesador
module memory_system 
(
	 input wire       mdr_alu_n,
	 input wire       mdr_en,
	 input wire 		bank_wr_en,
	 input wire [2:0] BusB_addr,
	 input wire [2:0] BusC_addr,
	 input wire       enaf,
	 input wire [2:0] selop,
	 input wire [1:0] shamt,
	 input wire       mar_en,
	 input wire       ir_en,
	 input wire       clk,
	 input wire       rst,
	 input wire       ir_clr,
	 input wire       wr_rd_n,
	 
	 output wire       C,N,Z,P,
	 output wire[4:0]  opcode
	 
	 
);	

    wire [7:0] BUS_A_s;
	 wire [7:0] BUS_B_s;
	 wire [7:0] BUS_C_s;
	 wire [7:0] BUS_alu_s;

	 wire [8-1:0] bus_data_in_s;
	 wire [8-1:0] bus_data_out_s;
	 wire [8-1:0] address_bus_s;


// Registro de IR
reg_RTL #(.MAX_WIDTH(5)) reg_IR (
    .d(BUS_C_s[7:3]),
    .clk(clk),
    .en(ir_en),
	 .sclr(ir_clr),
    .rst(rst),
	 .q(opcode)//opcode
);

// Registro de MAR
reg_RTL #(.MAX_WIDTH(8)) reg_MAR (
    .d(BUS_C_s),
    .clk(clk),
    .en(mar_en),
	 .sclr(1'b0),
    .rst(rst),
    .q(address_bus_s)
);


// MDR
MDR #(.N(8)) bloq_RTL (
    .bus_alu(BUS_alu_s),
	 .bus_data_in(bus_data_in_s),
    .mdr_alu_n(mdr_alu_n),
	 .mdr_en(mdr_en),
    .clk(clk),
	 .rst(rst),
	 .sclr(1'b0),
    .bus_c(BUS_C_s),
    .bus_data_out(bus_data_out_s)
);

//register bank
register_bank #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(3)
    ) reg_bank (
        .clk(clk),
        .rst(rst),
        .w_en(bank_wr_en),
        .w_addr(BusC_addr),
        .r_addr(BusB_addr),
        .w_data(BUS_C_s),
        .busA(BUS_A_s),
        .busB(BUS_B_s)
    );

//RAM	 
sp_ram #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(8)
    ) ram_module (
        .clk(clk),
        .wr_rdn(wr_rd_n),
        .addr(address_bus_s),
        .w_data(bus_data_out_s),
        .r_data(bus_data_in_s)
    );

//ALU
	alu #(.MAX_WIDTH(8)) ALU_tb ( 
			.clk(clk), 
			.rst(rst), 
			.busA(BUS_A_s), 
			.busB(BUS_B_s), 
			.selop(selop), 
			.shamt(shamt),
			.enaf(enaf),
			.busC(BUS_alu_s),
			.C(C), .N(N), .P(P), .Z(Z)
			);
			
	 
endmodule
