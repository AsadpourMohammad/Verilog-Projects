`timescale 1ns/1ns

module full_adder_tb;
    reg a;
    reg b;
    reg cin;
    wire sum;
    wire carry;

    full_adder fa (a, b, cin, sum, carry);

    initial
    begin
        $dumpfile("fa.vcd");
        $dumpvars(0, full_adder_tb);

        a = 0;
        b = 0;
        cin = 0;
        #10;

        a = 0;
        b = 0;
        cin = 1;
        #10;

        a = 0;
        b = 1;
        cin = 0;
        #10;

        a = 0;
        b = 1;
        cin = 1;
        #10;

        a = 1;
        b = 0;
        cin = 0;
        #10;

        a = 1;
        b = 0;
        cin = 1;
        #10;

        a = 1;
        b = 1;
        cin = 0;
        #10;

        a = 1;
        b = 1;
        cin = 1;
        #10;

        $finish;
    end
endmodule