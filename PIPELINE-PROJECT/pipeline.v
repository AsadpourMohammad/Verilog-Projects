module exponent_subtractor(input [7:0] first_ex, input [7:0] second_ex, output [7:0] max_ex, output [7:0] ex_subtract, output p_is_greater);
    assign max_ex = first_ex > second_ex ? first_ex : second_ex;
    assign ex_subtract = first_ex > second_ex ? first_ex - second_ex : second_ex - first_ex;
    assign p_is_greater = first_ex > second_ex;
endmodule

module add_leading_one(input [22:0] my_number, output reg [23:0] result);
  always @(*) begin
    result = {1'b1, my_number}; // concatenate 1 with my_number
  end
endmodule

module mantissa_selector(input [22:0] first_man, input [22:0] second_man, input p_is_greater, output [23:0] min_man, output [23:0] max_man);
    wire [23:0] first, second;
    add_leading_one f(first_man, first);
    add_leading_one s(second_man, second);

    assign max_man = p_is_greater ? first : second;
    assign min_man = p_is_greater ? second : first;
endmodule

module right_shifter(input [23:0] num, input [7:0] amount, output [23:0] shifter_out);
    assign shifter_out = num >> amount;
endmodule

module dff_23bit(input clk, input rst, input [22:0] d, output reg [22:0] out);
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else begin
            out <= d;
        end
    end
endmodule

module dff_24bit(input clk, input rst, input [23:0] d, output reg [23:0] out);
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else begin
            out <= d;
        end
    end
endmodule

module dff_8bit(input clk, input rst, input [7:0] d, output reg [7:0] out);
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else begin
            out <= d;
        end
    end
endmodule

module dff_1bit(input clk, input rst, input d, output reg out);
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else begin
            out <= d;
        end
    end
endmodule

module first_stage(
    input clk,
    input rst,
    input [22:0] a,
    input [7:0] p,
    input [22:0] b,
    input [7:0] q,
    output [7:0] max_exponent_out,
    output [23:0] max_mantissa_out,
    output [23:0] shifted_mantissa_out
);

    wire [7:0] exponent_subtract;
    wire p_is_greater;

    wire [7:0] max_exponent;
    exponent_subtractor ex_sub(p, q, max_exponent, exponent_subtract, p_is_greater);

    wire [23:0] min_mantissa;
    wire [23:0] max_mantissa;
    mantissa_selector man_sel(a, b, p_is_greater, min_mantissa, max_mantissa);

    wire [23:0] shifted_mantissa;
    right_shifter shifter(min_mantissa, exponent_subtract, shifted_mantissa);

    dff_8bit max_ex(clk, rst, max_exponent, max_exponent_out);
    dff_24bit max_mnt(clk, rst, max_mantissa, max_mantissa_out);
    dff_24bit shift_mnt(clk, rst, shifted_mantissa, shifted_mantissa_out);
endmodule

module adder (
    input [23:0] a,
    input [23:0] b,
    input m,
    output [23:0] sum,
    output carry
);

    reg [23:0] sum;
    reg carry;

    always @* begin
        {carry, sum} = m ? a - b : a + b;
    end
endmodule

module mantissa_adder(input [23:0] max_man, input [23:0] shifted_man, input m, output [23:0] man_sum, output carry);
    adder add(max_man, shifted_man, m, man_sum, carry);
endmodule

module second_stage(
    input clk,
    input rst,
    input [7:0] max_ex,
    input [23:0] max_man,
    input [23:0] shifted_man,
    input m,
    output [7:0] max_exponent_out,
    output [23:0] mantissa_sum_out,
    output carry_out
);

    wire [23:0] mantissa_sum;
    wire carry;
    mantissa_adder man_sum(max_man, shifted_man, m, mantissa_sum, carry);

    dff_8bit max_exponent(clk, rst, max_ex, max_exponent_out);
    dff_24bit sum_mantissa(clk, rst, mantissa_sum, mantissa_sum_out);
    dff_1bit carry_o(clk, rst, carry, carry_out);
endmodule

module leading_zero_counter(input [23:0] num, output [7:0] count);
    assign count = (num[23] == 1) ? 0 :
                (num[22] == 1) ? 1 :
                (num[21] == 1) ? 2 :
                (num[20] == 1) ? 3 :
                (num[19] == 1) ? 4 :
                (num[18] == 1) ? 5 :
                (num[17] == 1) ? 6 :
                (num[16] == 1) ? 7 :
                (num[15] == 1) ? 8 :
                (num[14] == 1) ? 9 :
                (num[13] == 1) ? 10 :
                (num[12] == 1) ? 11 :
                (num[11] == 1) ? 12 :
                (num[10] == 1) ? 13 :
                (num[9] == 1) ? 14 :
                (num[8] == 1) ? 15 :
                (num[7] == 1) ? 16 :
                (num[6] == 1) ? 17 :
                (num[5] == 1) ? 18 :
                (num[4] == 1) ? 19 :
                (num[3] == 1) ? 20 :
                (num[2] == 1) ? 21 :
                (num[1] == 1) ? 22 :
                (num[0] == 1) ? 23 : 24;
endmodule

module left_shifter(input [23:0] num, input [7:0] amount, output [23:0] shifter_out);
    assign shifter_out = num << amount;
endmodule

module get_one(output [7:0] out);
    assign out = 8'b00000001;
endmodule

module third_stage(
    input clk,
    input rst,
    input [7:0] max_exponent,
    input [23:0] mantissa_sum,
    input carry,
    output [7:0] max_exponent_out,
    output [7:0] shift_count_out,
    output [23:0] shifted_mantissa_sum_out
);

    wire [7:0] count_of_zero;
    leading_zero_counter lzc(mantissa_sum, count_of_zero);

    wire [7:0] shift_count;
    wire [7:0] one;
    get_one o(one);

    assign shift_count = carry ? one : count_of_zero;

    wire [23:0] shifted_mantissa_sum;
    left_shifter shifter(mantissa_sum, shift_count, shifted_mantissa_sum);

    dff_8bit max_exp(clk, rst, max_exponent, max_exponent_out);
    dff_8bit count_zero(clk, rst, shift_count, shift_count_out);
    dff_24bit shift_mnt_sum(clk, rst, shifted_mantissa_sum, shifted_mantissa_sum_out);
endmodule

module exponent_adder(input [7:0] first_ex, input [7:0] second_ex, input carry, output [7:0] ex_sum);
    assign ex_sum = carry ? first_ex + second_ex : first_ex - second_ex;
endmodule

module number_modifier (
    input [23:0] inputNumber,
    output [22:0] outputNumber
);
    assign outputNumber = inputNumber[22:0];
endmodule

module fourth_stage(
    input clk,
    input rst,
    input [7:0] max_exponent,
    input [7:0] shift_amount,
    input [23:0] shifted_mantissa_sum,
    input carry,
    output [7:0] exponent_sum_out,
    output [22:0] shifted_mantissa_sum_out
);

    wire [7:0] exponent_sum;
    exponent_adder ex_sum(max_exponent, shift_amount, carry, exponent_sum);
    wire [22:0] bit_22_sum;
    number_modifier out(shifted_mantissa_sum, bit_22_sum);

    dff_8bit max_exp(clk, rst, exponent_sum, exponent_sum_out);
    dff_23bit shift_mnt_sum(clk, rst, bit_22_sum, shifted_mantissa_sum_out);
endmodule

module twos_complement (
    input signed [22:0] num,
    output signed [22:0] twos_comp
);
    wire [23:0] inverted_num;
    assign inverted_num = ~num;

    assign twos_comp = inverted_num + 1;
endmodule

module pipeline(
    input clk,
    input rst,
    input [22:0] a,
    input [7:0] p,
    input [22:0] b,
    input [7:0] q,
    input m,
    output [7:0] final_exponent,
    output [22:0] normal_mantissa_sum
);
    wire [7:0] max_ex1;
    wire [7:0] max_ex2;
    wire [7:0] max_ex3;
    wire [23:0] max_man;
    wire [23:0] shifted_man;
    wire [23:0] mantissa_sum;
    wire [7:0] shift_amount;
    wire [23:0] shifted_mantissa_sum;

    wire [22:0] a_dff;
    dff_23bit dffa(clk, rst, a, a_dff);

    wire [7:0] p_dff;
    dff_8bit dffp(clk, rst, p, p_dff);

    wire [22:0] b_dff, b_temp, b_comp;

    twos_complement twos_comp(b, b_comp);
    assign b_temp = m ? b_comp : b;

    dff_23bit dffb(clk, rst, b_temp, b_dff);

    wire [7:0] q_dff;
    dff_8bit dffq(clk, rst, q, q_dff);

    wire carry;

    first_stage s1(clk, rst, a_dff, p_dff, b_dff, q_dff, max_ex1, max_man, shifted_man);
    second_stage s2(clk, rst, max_ex1, max_man, shifted_man, m, max_ex2, mantissa_sum, carry);
    third_stage s3(clk, rst, max_ex2, mantissa_sum, carry, max_ex3, shift_amount, shifted_mantissa_sum);
    fourth_stage s4(clk, rst, max_ex3, shift_amount, shifted_mantissa_sum, carry, final_exponent, normal_mantissa_sum);
endmodule