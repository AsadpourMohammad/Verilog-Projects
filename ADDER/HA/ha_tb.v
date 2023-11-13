`timescale 1ns/1ns

module half_adder_tb;
    reg a;
    reg b;
    wire sum;
    wire carry;

    half_adder uut (a, b, sum, carry);

    initial
    begin
        $dumpfile("ha.vcd");
        $dumpvars(0, half_adder_tb);

        a = 0;
        b = 0;
        #10;

        a = 0;
        b = 1;
        #10;
        
        a = 1;
        b = 0;
        #10;
        
        a = 1;
        b = 1;
        #10;
        
        $finish;
    end
endmodule