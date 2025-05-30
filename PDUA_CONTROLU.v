module PDUA_CONTROLU (
    input wire clk,
    input wire rst,
    input wire INT
);

    wire Z, N, C, P;
    wire [4:0] opcode; 
    wire [20:0] control_signals;
    wire wr_rd_n;
    wire mdr_alu_n;
    wire mdr_en;
    wire mar_en;
    wire ir_en;
	 wire int_clr;
    wire bank_wr_en;
    wire enaf;
    wire [1:0] shamt;
    wire [2:0] selop;
    wire [2:0] busC_addr;
    wire [2:0] busB_addr;
	 wire sclr;
	 wire wr_rdn;
	 wire ir_clr;
	 wire intp;

// Registro para las interrupciones
reg_RTL #(.MAX_WIDTH(1)) reg_Intp (
    .d(1'b1),
    .clk(clk),
    .en(INT),
	 .sclr(int_clr),
    .rst(rst),
	 .q(intp)
); 
	 
    // Instanciar la Unidad de Control
    controlUnit_up control_unit (
        .clk(clk),
        .rst(rst),
        .Z(Z),
        .N(N),
        .C(C),
        .P(P),
        .intp(intp),
        .opcode(opcode),
        .controlUnit_out(control_signals)
    );

    // Instanciar el sistema de memoria PDUA
    memory_system PDUA (
        .mdr_alu_n(mdr_alu_n),
        .mdr_en(mdr_en),
        .bank_wr_en(bank_wr_en),
        .BusB_addr(busB_addr),
        .BusC_addr(busC_addr),
        .enaf(enaf),
        .selop(selop),
        .shamt(shamt),
        .mar_en(mar_en),
        .ir_en(ir_en),
        .clk(clk),
        .rst(rst),
        .ir_clr(ir_clr), //Sospechoso          
        .wr_rd_n(wr_rdn),
        .C(C),
        .N(N),
        .Z(Z),
        .P(P),
        .opcode(opcode)
    );
	 
	 // Decodificar señales de control
    assign enaf        = control_signals[20];
    assign selop       = control_signals[19:17];
    assign shamt       = control_signals[16:15];
    assign busB_addr   = control_signals[14:12];
    assign busC_addr   = control_signals[11:9];
    assign bank_wr_en  = control_signals[8];
    assign mar_en      = control_signals[7];
    assign mdr_en      = control_signals[6];
    assign mdr_alu_n   = control_signals[5];
    assign int_clr     = control_signals[4];
    assign iom         = control_signals[3];
	 assign wr_rdn      = control_signals[2];
	 assign ir_en       = control_signals[1];
	 assign ir_clr      = control_signals[0];

endmodule

