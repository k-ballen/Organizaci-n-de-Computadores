
module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    output wire s,
    output wire cout
);

assign s = a ^ b ^ cin; // Sum
assign cout = (a & b) | (a & cin) | (b & cin); // Carry out

endmodule 
