module full_adder (
    input a_i, b_i, cin,
    output sum_o, carry_o
);
    wire xor_res, first_and, second_and;

    xor (xor_res, a_i, b_i);

    and (first_and, a_i, b_i);
    and (second_and, xor_res, cin);

    xor (sum_o, xor_res, cin);
    or (carry_o, first_and, second_and);

endmodule