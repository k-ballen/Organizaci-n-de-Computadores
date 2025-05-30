module sp_ram
  #( parameter        DATA_WIDTH = 8,
                       ADDR_WIDTH = 8)
  ( input    wire     clk ,
    input    wire     wr_rdn,
    input    wire [ADDR_WIDTH-1:0] addr,
    input    wire [DATA_WIDTH-1:0] w_data,
    output   wire [DATA_WIDTH-1:0] r_data
  );

  // signal declaration
  reg [DATA_WIDTH-1:0] ram [0:2**ADDR_WIDTH-1];
  reg [ADDR_WIDTH-1:0] addr_reg;

  // Write procedure
  always @(posedge clk) begin
    if (wr_rdn) begin
      ram[addr] <= w_data;
    end
    addr_reg <= addr;
  end

  // READ
  assign r_data = ram[addr_reg];

endmodule
