`timescale 1ns/1ns

module counter_tb;
  reg mode, rst, clk;
  wire [1:0] q;

  counter c(mode, clk, rst, q);

  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0, counter_tb);

    rst = 1;
    mode = 0;
    #20;

    rst = 0;
    #80;

    mode = 1;
    #200;

    mode = 0;
    #200;
    
    $finish;
  end
endmodule