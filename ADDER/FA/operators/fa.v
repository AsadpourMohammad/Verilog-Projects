module full_adder (
    input a_i, b_i, cin,
    output sum_o, carry_o
);

    assign {carry_o, sum_o} = a_i + b_i + cin;

endmodule