`include "ha.v"

module full_adder (
    input a_i, b_i, cin,
    output sum_o, carry_o
);

    wire sum_o1, carry_o1, carry_o2;

    half_adder ha1 (a_i, b_i, sum_o1, carry_o1);
    half_adder ha2 (sum_o1, cin, sum_o, carry_o2);

    assign carry_o = carry_o1 | carry_o2;

endmodule