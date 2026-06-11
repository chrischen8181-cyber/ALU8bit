`timescale 1ns/1ps

module tb_alu8;

    localparam [2:0] OP_ADD = 3'b000;
    localparam [2:0] OP_SUB = 3'b001;
    localparam [2:0] OP_AND = 3'b010;
    localparam [2:0] OP_OR  = 3'b011;
    localparam [2:0] OP_XOR = 3'b100;
    localparam [2:0] OP_NOT = 3'b101;
    localparam [2:0] OP_SHL = 3'b110;
    localparam [2:0] OP_SHR = 3'b111;

    reg  [7:0] a;
    reg  [7:0] b;
    reg  [2:0] opcode;
    wire [7:0] y;
    wire       zero;
    wire       negative;
    wire       carry;
    wire       overflow;
    integer tests;
    integer errors;

    alu8 dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .y(y),
        .zero(zero),
        .negative(negative),
        .carry(carry),
        .overflow(overflow)
    );

    task check;
        input [2:0] test_opcode;
        input [7:0] test_a;
        input [7:0] test_b;
        input [7:0] expected_y;
        input expected_zero;
        input expected_negative;
        input expected_carry;
        input expected_overflow;
        begin
            opcode = test_opcode;
            a = test_a;
            b = test_b;
            #1;
            tests = tests + 1;

            if ((y !== expected_y) ||
                (zero !== expected_zero) ||
                (negative !== expected_negative) ||
                (carry !== expected_carry) ||
                (overflow !== expected_overflow)) begin
                $display("FAIL op=%b a=%h b=%h | y=%h ZNCV=%b%b%b%b | expected y=%h ZNCV=%b%b%b%b",
                         opcode, a, b, y, zero, negative, carry, overflow,
                         expected_y, expected_zero, expected_negative,
                         expected_carry, expected_overflow);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        tests = 0;
        errors = 0;

        check(OP_ADD, 8'd13,  8'd7,   8'd20,  0, 0, 0, 0);
        check(OP_ADD, 8'hFF,  8'h01,  8'h00,  1, 0, 1, 0);
        check(OP_ADD, 8'h7F,  8'h01,  8'h80,  0, 1, 0, 1);
        check(OP_ADD, 8'h80,  8'h80,  8'h00,  1, 0, 1, 1);

        check(OP_SUB, 8'd10,  8'd3,   8'd7,   0, 0, 1, 0);
        check(OP_SUB, 8'd3,   8'd10,  8'hF9,  0, 1, 0, 0);
        check(OP_SUB, 8'h80,  8'h01,  8'h7F,  0, 0, 1, 1);

        check(OP_AND, 8'hAA,  8'hCC,  8'h88,  0, 1, 0, 0);
        check(OP_OR,  8'hAA,  8'hCC,  8'hEE,  0, 1, 0, 0);
        check(OP_XOR, 8'hFF,  8'hFF,  8'h00,  1, 0, 0, 0);
        check(OP_NOT, 8'h00,  8'h00,  8'hFF,  0, 1, 0, 0);
        check(OP_SHL, 8'h81,  8'h00,  8'h02,  0, 0, 1, 0);
        check(OP_SHR, 8'h03,  8'h00,  8'h01,  0, 0, 1, 0);

        if (errors == 0)
            $display("ALU8: all %0d tests passed", tests);
        else
            $display("ALU8: %0d of %0d test(s) failed", errors, tests);

        $finish;
    end

endmodule

