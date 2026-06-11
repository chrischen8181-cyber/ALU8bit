module shifter8 (
    input  wire [7:0] a,
    output wire [7:0] left_result,
    output wire [7:0] right_result,
    output wire       left_carry,
    output wire       right_carry
);

    assign left_result  = {a[6:0], 1'b0};
    assign right_result = {1'b0, a[7:1]};
    assign left_carry   = a[7];
    assign right_carry  = a[0];

endmodule

