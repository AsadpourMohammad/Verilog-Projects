module dff(
    input clk, d, rst,
    output reg q
);
    always @ (posedge clk) 
    begin
        if (rst == 1)
            q <= 0;
        else
            q <= d;
    end
endmodule

module counter (
    input mode, clk, rst,
    output [1:0] q
);
    wire first_xor, second_xor;
    assign first_xor = q[1] ^ q[0];
    assign second_xor = mode ^ first_xor;

    dff dff1(clk, second_xor, rst, q[1]);
    dff dff2(clk, ~q[0], rst, q[0]);
endmodule
