module  controlUnit_up 
(
    input wire       clk,
	 input wire       rst,
	 input wire       Z,
	 input wire       N,
	 input wire       C,
	 input wire       P,
	 input wire       intp,
	 input wire[4:0]  opcode,

    output wire[20:0] controlUnit_out 
);

wire        load,cout;
wire[2:0]   result_addsub;
wire[2:0]   d,mini_inst;
wire[7:0]   int_addr;
wire[28:0]  r_data;

wire[2:0] jcond;
wire       en_uPC; //en
wire       clr_uPC; //sclr
wire[2:0] offset;

// Mux jcond 
mux_entrada  mux_1 (
    .d0(1'b0),// es 0 NO jump
	 .d1(1'b1),// es 1 Unconditional jump
	 .Z(Z), //ZERO
	 .N(N), // NEGATIVE
	 .C(C), //CARRRY
	 .P(P), // PARITY
	 .intp(intp), // JUMP IF INTERRUPT
	 .dd0(1'b0), // Not used
    .jcond(jcond),               
    .load(load)
);

// add_sub
add_sub #(.N(3)) oui1 (
    .a(mini_inst),
    .b(3'b001),
    .addn_sub(1'b0),
    .s(result_addsub),
    .cout(cout)
);


// mux uPC
mux_uPC  mux_2 (
    .d1(result_addsub),                
    .d2(offset),                     
    .sel(load),               
    .Cout(d)
);

	
// Reg uPC

reg_RTL   #(.MAX_WIDTH(3)) uPC (
  	  .clk(clk),
     .rst(rst),
     .en(en_uPC),
	  .sclr(clr_uPC),
     .d(d),
     .q(mini_inst)
);

assign int_addr = {opcode, mini_inst};

// ROM

async_rom_case  rom (

    .r_addr(int_addr),
    .r_data(r_data)
);


assign controlUnit_out = r_data[28:8];

assign en_uPC = r_data[7];
assign clr_uPC = r_data[6];
assign jcond = r_data[5:3];
assign offset = r_data[2:0];

	
endmodule
