`timescale 1ns/1ns

module fsm_tb;
    reg in, clk, rst;
    wire [1:0] Q;
    wire Y;


    fsm uut (in, clk, rst, Q, Y);

    initial
    begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial
    begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, fsm_tb);

        in = 0;
        #20;

        in = 1;
        #20;

        in = 0;
        // y must become 1
        #20;

        in = 1;
        #20;

        in = 1;
        #20;

        in = 0;
        // y must become 1
        #20;

        in = 1;
        #20;

        in = 1;
        #20;

        in = 1;
        #20;

        in = 1;
        #20;

        in = 0;
        // y must become 1
        #20;

        $finish;
    end
endmodule