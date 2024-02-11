module mux8to1(
    input S0,
    input S1,
    input S2,
    input D0,
    input D1,
    input D2,
    input D3,
    input D4,
    input D5,
    input D6,
    input D7,
    output out);

    wire T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11;

    not(T1, S0);
    not(T2, S1);
    not(T3, S2);

    and(T4, D0, T1, T2, T3), (T5, D1, S0, T2, T3);
    and(T6, D2, T1, S1, T3), (T7, D3, S0, S1, T3);
    and(T8, D4, T1, T2, S2), (T9, D5, S0, T2, S2);
    and(T10, D6, T1, S1, S2), (T11, D7, S0, S1, S2);

    or(out, T4, T5, T6, T7, T8, T9, T10, T11);
endmodule

module bus(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [7:0] c,
    input wire [7:0] d,
    input wire [7:0] e,
    input wire [7:0] f,
    input S0,
    input S1,
    input S2,
    output wire [7:0] out);

    mux8to1 m1(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[0]),
        .D1(b[0]),
        .D2(c[0]),
        .D3(d[0]),
        .D4(e[0]),
        .D5(f[0]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[0]));

    mux8to1 m2(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[1]),
        .D1(b[1]),
        .D2(c[1]),
        .D3(d[1]),
        .D4(e[1]),
        .D5(f[1]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[1]));

    mux8to1 m3(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[2]),
        .D1(b[2]),
        .D2(c[2]),
        .D3(d[2]),
        .D4(e[2]),
        .D5(f[2]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[2]));

    mux8to1 m4(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[3]),
        .D1(b[3]),
        .D2(c[3]),
        .D3(d[3]),
        .D4(e[3]),
        .D5(f[3]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[3]));

    mux8to1 m5(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[4]),
        .D1(b[4]),
        .D2(c[4]),
        .D3(d[4]),
        .D4(e[4]),
        .D5(f[4]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[4]));

    mux8to1 m6(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[5]),
        .D1(b[5]),
        .D2(c[5]),
        .D3(d[5]),
        .D4(e[5]),
        .D5(f[5]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[5]));

    mux8to1 m7(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[6]),
        .D1(b[6]),
        .D2(c[6]),
        .D3(d[6]),
        .D4(e[6]),
        .D5(f[6]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[6]));

    mux8to1 m8(
        .S0(S0),
        .S1(S1),
        .S2(S2),
        .D0(a[7]),
        .D1(b[7]),
        .D2(c[7]),
        .D3(d[7]),
        .D4(e[7]),
        .D5(f[7]),
        .D6(1'bx),
        .D7(1'bx),
        .out(out[7]));
endmodule