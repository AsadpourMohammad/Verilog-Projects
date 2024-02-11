`include "ALU.v"

module ALU_tb;
  // Inputs
  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] main_sel, sub_sel;
  reg cin;

  // Output
  wire [3:0] result;

  // Instantiate the Unit Under Test (UUT)
  ALU uut (A, B, main_sel, sub_sel, cin, result);

  initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars(0, ALU_tb);

    #10

    // Initialize inputs for Mathmatical Operations
    A = 4'b0011;
    B = 4'b0010;
    cin = 1'b0;
    main_sel = 2'b00;

    sub_sel = 2'b00;

    #10;

    // 1 -> Transfer A -> A
    cin = 1'b0;
    sub_sel = 2'b00;

    #10;

    // 2 -> Increment A -> A + 1
    cin = 1'b1;
    sub_sel = 2'b00;

    #10;

    // 3 -> Addition -> A + B
    cin = 1'b0;
    sub_sel = 2'b01;

    #10;

    // 4 -> Addition with carry -> A + B + 1
    cin = 1'b1;
    sub_sel = 2'b01;

    #10;

    // 5 -> Subtract with borrow -> A + B'
    cin = 1'b0;
    sub_sel = 2'b10;

    #10;

    // 6 -> Subtraction -> A + B' + 1
    cin = 1'b1;
    sub_sel = 2'b10;

    #10;

    // 7 -> Decrement A -> A - 1
    cin = 1'b0;
    sub_sel = 2'b11;

    #10;

    // 8 -> Transfer A -> A
    cin = 1'b1;
    sub_sel = 2'b11;

    #10;

    // Initialize inputs for Logicical Operations
    A = 4'b0001;
    B = 4'b0000;
    main_sel = 2'b01;
    cin = 1'bx;

    sub_sel = 2'b00;

    #10;

    // 1 -> AND

    sub_sel = 2'b00;

    #10;

    // 2 -> OR

    sub_sel = 2'b01;

    #10;

    // 3 -> XOR

    sub_sel = 2'b10;

    #10;

    // 4 -> Complement

    sub_sel = 2'b11;

    #10;

    // Initialize inputs for Shift Operations
    A = 4'b0010;

    B = 4'bx;
    sub_sel = 2'bx;

    // 1 -> Right Shift
    main_sel = 2'b10;

    #10;

    // 1 -> Left Shift
    main_sel = 2'b11;

    #10;
  end
endmodule
