module dff(
    input clk, d, rst,
    output reg q
);
    always @ (posedge clk)
    begin
        if (rst == 1)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

module fsm (
    input in, clk, rst, output [1:0] Q, output Y
);
    wire w [5:0];

    assign w[2] = Q[1] & ~in;
    assign w[3] = Q[0] & ~in;
    assign Y = w[2] | w[3];
    assign w[0] = Q[1] & in;
    assign w[1] = Q[0] & in;
    assign w[4] = w[0] | w[1];
    assign w[5] = ~Q[1] & in;
    assign w[5] = ~Q[1] & in;
    +
    dff dffA(clk, w[4], rst, Q[1]);
    dff dffB(clk, w[5], rst, Q[0]);
endmodule