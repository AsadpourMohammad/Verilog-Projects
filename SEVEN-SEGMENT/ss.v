module ss (
    input [3:0] in,
    output a, b, c, d, e, f, g
);

    assign a = in[3] | in[1] | (in[2] & in[0]) | (~in[2] & ~in[0]);
    assign b = ~in[2] | (~in[1] & ~in[0]) | (in[1] & in[0]);
    assign c = in[2] | ~in[1] | in[0];
    assign d = in[3] | (~in[2] & ~in[0]) | (~in[2] & in[1]) | (in[1] & ~in[0]) | (in[2] & ~in[1] & in[0]);
    assign e = (~in[2] & ~in[0]) | (in[1] & ~in[0]);
    assign f = in[3] | (in[2] & ~in[1]) | (in[2] & ~in[0]) | (~in[1] & ~in[0]);
    assign g = in[3] | (in[2] & ~in[1]) | (~in[2] & in[1]) | (in[1] & ~in[0]);

endmodule