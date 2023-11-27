module full_adder (
    input a_i, b_i, cin,
    output sum_o, carry_o
);

    wire xor_res, first_and, second_and;
    
    assign xor_res = a_i ^ b_i;
    assign first_and = a_i & b_i;
    assign second_and = xor_res & cin;

    assign sum_o = xor_res ^ cin;
    assign carry_o = first_and | second_and;

endmodule