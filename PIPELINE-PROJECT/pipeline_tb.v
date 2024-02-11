`timescale 1ns/1ns
`include "pipeline.v"

module pipeline_tb();
    reg clk, rst;
    reg [22:0] a, b;
    reg m;
    reg [7:0] p, q;
    wire [7:0] final_exponent;
    wire [22:0] normal_mantissa_sum;

    pipeline pip(clk, rst, a, p, b, q, m, final_exponent, normal_mantissa_sum);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("pipeline_tb.vcd");
        $dumpvars(0, pipeline_tb);

        a = 23'b00000000000000000000000;
        b = 23'b10000000000000000000000;

        p = 8'b01111110;
        q = 8'b01111111;

        m = 1;
        rst = 0;

        #20;


        a = 23'b01010000000000000000000;
        b = 23'b00111001100000000000000;

        m = 0;

        #100;

        m = 1;

        #100;

        a = 23'b00100000000000000000000;
        b = 23'b10000000000000000000000;

        p = 8'b10000000;
        q = 8'b10000000;

        #100;
        
        a = 23'b00100000000000000000000;
        b = 23'b10000000000000000000000;

        p = 8'b10000000;
        q = 8'b10000000;

        m = 0;

        #100;

        m = 1;

        #100;
        $finish;
    end
endmodule