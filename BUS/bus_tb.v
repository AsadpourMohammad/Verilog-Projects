`include "bus.v"

module bus_tb();
    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] c;
    reg [7:0] d;
    reg [7:0] e;
    reg [7:0] f;
    reg S0;
    reg S1;
    reg S2;

    wire [7:0] out;

    bus bus1 (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .out(out)
    );

    initial begin
        $dumpfile("bus_tb.vcd");
        $dumpvars(0, bus_tb);

        // Set initial values of registors and selectors to 0
        a = 8'b00000000;
        b = 8'b00000000;
        c = 8'b00000000;
        d = 8'b00000000;
        e = 8'b00000000;
        f = 8'b00000000;
        S0 = 0;
        S1 = 0;
        S2 = 0;

        // Set initial values for each register
        #5;
        a = 8'b00000001;
        b = 8'b00000010;
        c = 8'b00000011;
        d = 8'b00000100;
        e = 8'b00000101;
        f = 8'b00000110;

        // Selecting 0
        #10;
        S0 = 0;
        S1 = 0;
        S2 = 0;

        // Selecting 1
        #10;
        S0 = 1;
        S1 = 0;
        S2 = 0;

        // Selecting 2
        #10;
        S0 = 0;
        S1 = 1;
        S2 = 0;

        // Selecting 3
        #10;
        S0 = 1;
        S1 = 1;
        S2 = 0;

        // Selecting 4
        #10;
        S0 = 0;
        S1 = 0;
        S2 = 1;

        // Selecting 5
        #10;
        S0 = 1;
        S1 = 0;
        S2 = 1;

        // Selecting 6 (Results in don't care)
        #10;
        S0 = 0;
        S1 = 1;
        S2 = 1;

        // Selecting 7 (Results in don't care)
        #10;
        S0 = 1;
        S1 = 1;
        S2 = 1;

        #20;
    end
endmodule
