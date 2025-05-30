module mux_uPC (
    input  wire [2:0] d1,
    input  wire [2:0] d2,
    input  wire       sel,
    output reg  [2:0] Cout
);

    always @* begin
        Cout = (sel == 1'b0) ? d1 : d2;
    end

endmodule
