module bit1mux4x1(
    input I0,
    input I1,
    input I2,
    input I3,
    input [1:0] sel,
    output out);

    wire T0, T1, T2, T3;

    and (T0, I0, ~sel[0], ~sel[1]);
    and (T1, I1, sel[0], ~sel[1]);
    and (T2, I2, ~sel[0], sel[1]);
    and (T3, I3, sel[0], sel[1]);

    or (out, T0, T1, T2, T3);
endmodule

module FullAdder(input A, input B, input cin, output S, output cout);
    wire xor_result, first_and_result;
    xor (xor_result, A, B);
    and (first_and_result, A, B);

    wire second_and_result;
    xor (S, xor_result, cin);
    and (second_and_result, xor_result, cin);

    or (cout, second_and_result, first_and_result);
endmodule

module ArithmeticCircuit(
    input [3:0] A,
    input [3:0] B,
    input [1:0] sel,
    input cin,
    output [3:0] result,
    output cout);

    wire mux0_result;
    bit1mux4x1 mux0(B[0], ~B[0], 1'b0, 1'b1, sel, mux0_result);

    wire cout0;
    FullAdder f0(A[0], mux0_result, cin, result[0], cout0);

    wire mux1_result;
    bit1mux4x1 mux1(B[1], ~B[1], 1'b0, 1'b1, sel, mux1_result);

    wire cout1;
    FullAdder f1(A[1], mux1_result, cout0, result[1], cout1);

    wire mux2_result;
    bit1mux4x1 mux2(B[2], ~B[2], 1'b0, 1'b1, sel, mux2_result);

    wire cout2;
    FullAdder f2(A[2], mux2_result, cout1, result[2], cout2);

    wire mux3_result;
    bit1mux4x1 mux3(B[3], ~B[3], 1'b0, 1'b1, sel, mux3_result);

    FullAdder f3(A[3], mux3_result, cout2, result[3], cout);
endmodule

module bit4mux4x1(
    input [3:0] I0,
    input [3:0] I1,
    input [3:0] I2,
    input [3:0] I3,
    input [1:0] sel,
    output reg [3:0] out);

    always @ (I0 or I1 or I2 or I3 or sel) begin
        case (sel)
            2'b00 : out <= I0;
            2'b01 : out <= I1;
            2'b10 : out <= I2;
            2'b11 : out <= I3;
        endcase
    end

endmodule

module LogicCircuit (input [3:0] A, input [3:0] B, input [1:0] sel, output [3:0] result);
    wire [3:0] and_result;
    assign and_result = A && B;

    wire [3:0] or_result;
    assign or_result = A || B;

    wire [3:0] xor_result;
    assign xor_result = A ^ B;

    wire [3:0] not_result;
    assign not_result = !A;

    bit4mux4x1 mux(and_result, or_result, xor_result, not_result, sel, result);
endmodule

module mux2x1(input I0, input I1, input S,output out);
    wire w0, w1;

    and (w0, I0, ~S);
    and (w1, I1, S);

    or (out, w0, w1);
endmodule

module ShiftUnit(input [3:0] A, input IR, input IL, input sel, output [3:0] result);
    mux2x1 mux0(IR, A[1], sel, result[0]);
    mux2x1 mux1(A[0], A[2], sel, result[1]);
    mux2x1 mux2(A[1], A[3], sel, result[2]);
    mux2x1 mux3(A[2], IL, sel, result[3]);
endmodule

module ALU(
    input [3:0] A,
    input [3:0] B,
    input [1:0] main_sel,
    input [1:0] sub_sel,
    input cin,
    output [3:0] result);

    wire [3:0] AC_result;
    wire cout;
    ArithmeticCircuit ac(A, B, sub_sel, cin, AC_result, cout);

    wire [3:0] LC_result;
    LogicCircuit lc(.A(A), .B(B), .sel(sub_sel), .result(LC_result));

    wire [3:0] SHR_result;
    ShiftUnit shr(A, 1'b0, 1'b0, 1'b0, SHR_result);

    wire [3:0] SHL_result;
    ShiftUnit shl(A, 1'b0, 1'b0, 1'b1, SHL_result);

    bit4mux4x1 mux(.I0(AC_result), .I1(LC_result), .I2(SHR_result), .I3(SHL_result), .sel(main_sel), .out(result));
endmodule