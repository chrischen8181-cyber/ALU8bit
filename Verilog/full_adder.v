module full_adder (
    input  wire a,
    input  wire b,
    input  wire carry_in,
    output wire sum,
    output wire carry_out
);
    wire first_sum;
    wire first_carry;
    wire second_carry;

    half_adder first_half (
        .a(a),
        .b(b),
        .sum(first_sum),
        .carry(first_carry)
    );

    half_adder second_half (
        .a(first_sum),
        .b(carry_in),
        .sum(sum),
        .carry(second_carry)
    );
    assign carry_out = first_carry | second_carry;

endmodule

