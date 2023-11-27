`timescale 1ns/1ns

module ss_tb;
reg [3:0] in;
wire a, b, c, d, e, f, g;

ss uut (in, a, b, c, d, e, f, g);

initial
begin
    $dumpfile("ss.vcd");
    $dumpvars(0, ss_tb);

    in = 4'b0000;
    #10;

    in = 4'b0001;
    #10;

    in = 4'b0010;
    #10;

    in = 4'b0011;
    #10;

    in = 4'b0100;
    #10;

    in = 4'b0101;
    #10;

    in = 4'b0110;
    #10;

    in = 4'b0111;
    #10;

    in = 4'b1000;
    #10;

    in = 4'b1001;
    #10;

    $finish;
end
endmodule;