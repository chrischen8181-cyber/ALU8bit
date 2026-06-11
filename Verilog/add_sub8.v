module add_sub8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       subtract,
    output wire [7:0] result,
    output wire       carry_out,
    output wire       overflow
);

    wire [7:0] selected_b;
    wire       carry_into_msb;

    assign selected_b = b ^ {8{subtract}};

    ripple_adder8 arithmetic_adder (
        .a(a),
        .b(selected_b),
        .carry_in(subtract),
        .sum(result),
        .carry_out(carry_out),
        .carry_into_msb(carry_into_msb)
    );
    assign overflow = carry_into_msb ^ carry_out;

endmodule

