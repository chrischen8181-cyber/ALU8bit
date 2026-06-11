module ripple_adder8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       carry_in,
    output wire [7:0] sum,
    output wire       carry_out,
    output wire       carry_into_msb
);
    wire [8:0] carry;
    assign carry[0] = carry_in;
    genvar bit_index;
    generate
        for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) begin : add_bits
            full_adder bit_adder (
                .a(a[bit_index]),
                .b(b[bit_index]),
                .carry_in(carry[bit_index]),
                .sum(sum[bit_index]),
                .carry_out(carry[bit_index + 1])
            );
        end
    endgenerate
    assign carry_into_msb = carry[7];
    assign carry_out      = carry[8];

endmodule

