module logic_unit8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [7:0] and_result,
    output wire [7:0] or_result,
    output wire [7:0] xor_result,
    output wire [7:0] not_result
);
    assign and_result = a & b;
    assign or_result  = a | b;
    assign xor_result = a ^ b;
    assign not_result = ~a;

endmodule

