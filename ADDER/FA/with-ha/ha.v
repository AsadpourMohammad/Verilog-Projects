module half_adder (
    input a_i, b_i,
    output sum_o, carry_o
);

    xor (sum_o, a_i, b_i);
    and (carry_o, a_i, b_i);

endmodule