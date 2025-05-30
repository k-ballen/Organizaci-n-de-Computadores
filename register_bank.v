module register_bank #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3
)(
    input wire clk,
    input wire rst,
    input wire w_en,
    input wire [ADDR_WIDTH-1:0] w_addr,
    input wire [ADDR_WIDTH-1:0] r_addr,
    input wire [DATA_WIDTH-1:0] w_data,
    output wire [DATA_WIDTH-1:0] busA, // salida fija (ACC)
    output wire [DATA_WIDTH-1:0] busB  // lectura dinámica
);

    // Dirección simbólica
    localparam PC         = 3'd0;
    localparam SP         = 3'd1;
    localparam DPTR       = 3'd2;
    localparam AREG       = 3'd3;
    localparam TVP        = 3'd4;
    localparam TEMP       = 3'd5;
    localparam CTE_NEGONE = 3'd6;
    localparam ACC        = 3'd7;

    // Inicialización
    localparam [DATA_WIDTH-1:0] PC_INIT     = 8'b00000000;
    localparam [DATA_WIDTH-1:0] SP_INIT     = 8'b11111111;
    localparam [DATA_WIDTH-1:0] DPTR_INIT   = 8'b00000000;
    localparam [DATA_WIDTH-1:0] AREG_INIT   = 8'b00000011; //Estos son los que estoy
    localparam [DATA_WIDTH-1:0] TVP_INIT    = 8'b00000100;
    localparam [DATA_WIDTH-1:0] TEMP_INIT   = 8'b00000000;
    localparam [DATA_WIDTH-1:0] NEG_ONE     = 8'b11111111;
    localparam [DATA_WIDTH-1:0] ACC_INIT    = 8'b11110000; //Cambiando jiji

    // Memoria de registros
    reg [DATA_WIDTH-1:0] array_reg [0:(1<<ADDR_WIDTH)-1];

    // Escritura y reinicio
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            array_reg[PC]         <= PC_INIT;
            array_reg[SP]         <= SP_INIT;
            array_reg[DPTR]       <= DPTR_INIT;
            array_reg[AREG]       <= AREG_INIT;
            array_reg[TVP]        <= TVP_INIT;
            array_reg[TEMP]       <= TEMP_INIT;
            array_reg[CTE_NEGONE] <= NEG_ONE;
            array_reg[ACC]        <= ACC_INIT;
        end else if (w_en) begin
            array_reg[w_addr] <= w_data;
        end
    end

    // Lecturas
    assign busB = array_reg[r_addr]; // lectura por dirección
    assign busA = array_reg[ACC];    // lectura fija del ACC

endmodule
