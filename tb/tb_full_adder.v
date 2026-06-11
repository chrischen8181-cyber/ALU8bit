`timescale 1ns/1ps

module tb_full_adder;

    reg  a;
    reg  b;
    reg  carry_in;
    wire sum;
    wire carry_out;
    integer test_value;
    integer errors;
    reg [1:0] expected;

    full_adder dut (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        errors = 0;

        for (test_value = 0; test_value < 8; test_value = test_value + 1) begin
            {a, b, carry_in} = test_value[2:0];
            // Explicitly widen each input so a carry cannot be truncated.
            expected = {1'b0, a} + {1'b0, b} + {1'b0, carry_in};
            #1;

            if ({carry_out, sum} !== expected) begin
                $display("FAIL a=%b b=%b cin=%b: got %b%b expected %b",
                         a, b, carry_in, carry_out, sum, expected);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("FULL ADDER: all tests passed");
        else
            $display("FULL ADDER: %0d test(s) failed", errors);

        $finish;
    end

endmodule
