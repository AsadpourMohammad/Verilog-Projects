module half_adder (
    input a_i, b_i,
    output sum_o, carry_o
);

    assign sum_o = a_i ^ b_i;
    assign carry_o = a_i & b_i;

endmodule