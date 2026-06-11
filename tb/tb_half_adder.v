`timescale 1ns/1ps

module tb_half_adder;

    reg  a;
    reg  b;
    wire sum;
    wire carry;
    integer errors;

    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    task check;
        input test_a;
        input test_b;
        input expected_carry;
        input expected_sum;
        begin
            a = test_a;
            b = test_b;
            #1;

            if ({carry, sum} !== {expected_carry, expected_sum}) begin
                $display("FAIL a=%b b=%b: got carry=%b sum=%b", a, b, carry, sum);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        check(0, 0, 0, 0);
        check(0, 1, 0, 1);
        check(1, 0, 0, 1);
        check(1, 1, 1, 0);

        if (errors == 0)
            $display("HALF ADDER: all tests passed");
        else
            $display("HALF ADDER: %0d test(s) failed", errors);

        $finish;
    end

endmodule

