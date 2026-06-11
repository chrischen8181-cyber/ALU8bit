
module alu8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] opcode,
    output reg  [7:0] y,
    output reg        zero,
    output reg        negative,
    output reg        carry,
    output reg        overflow
);
    localparam [2:0] OP_ADD = 3'b000;
    localparam [2:0] OP_SUB = 3'b001;
    localparam [2:0] OP_AND = 3'b010;
    localparam [2:0] OP_OR  = 3'b011;
    localparam [2:0] OP_XOR = 3'b100;
    localparam [2:0] OP_NOT = 3'b101;
    localparam [2:0] OP_SHL = 3'b110;
    localparam [2:0] OP_SHR = 3'b111;
    wire       subtract;
    wire [7:0] arithmetic_result;
    wire       arithmetic_carry;
    wire       arithmetic_overflow;
    wire [7:0] and_result;
    wire [7:0] or_result;
    wire [7:0] xor_result;
    wire [7:0] not_result;
    wire [7:0] shift_left_result;
    wire [7:0] shift_right_result;
    wire       shift_left_carry;
    wire       shift_right_carry;

    assign subtract = (opcode == OP_SUB);

    add_sub8 arithmetic_unit (
        .a(a),
        .b(b),
        .subtract(subtract),
        .result(arithmetic_result),
        .carry_out(arithmetic_carry),
        .overflow(arithmetic_overflow)
    );

    logic_unit8 logic_unit (
        .a(a),
        .b(b),
        .and_result(and_result),
        .or_result(or_result),
        .xor_result(xor_result),
        .not_result(not_result)
    );

    shifter8 shift_unit (
        .a(a),
        .left_result(shift_left_result),
        .right_result(shift_right_result),
        .left_carry(shift_left_carry),
        .right_carry(shift_right_carry)
    );

    // Blocking assignments model combinational selection logic.
    always @* begin
        y        = 8'b00000000;
        carry    = 1'b0;
        overflow = 1'b0;

        case (opcode)
            OP_ADD: begin
                y        = arithmetic_result;
                carry    = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            OP_SUB: begin
                y        = arithmetic_result;
                carry    = arithmetic_carry;
                overflow = arithmetic_overflow;
            end

            OP_AND: y = and_result;
            OP_OR:  y = or_result;
            OP_XOR: y = xor_result;
            OP_NOT: y = not_result;

            OP_SHL: begin
                y     = shift_left_result;
                carry = shift_left_carry;
            end

            OP_SHR: begin
                y     = shift_right_result;
                carry = shift_right_carry;
            end

            default: begin
                y        = 8'b00000000;
                carry    = 1'b0;
                overflow = 1'b0;
            end
        endcase

        zero     = (y == 8'b00000000);
        negative = y[7];
    end

endmodule

