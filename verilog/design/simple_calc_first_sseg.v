`timescale 1ns / 1ps
// Part 3: simple calculator + bin2bcd + 4x1 mux + rudimentary sseg driver.
//
// !! simple_calc and bin2bcd come from YOUR Lab 2. The port names used below are
// !! assumptions -- rename the .port(...) connections to match your modules.
//   simple_calc(X[3:0], Y[3:0], op_sel[1:0], result[7:0], carry_out, overflow)
//   bin2bcd(bin[7:0], bcd[11:0])
module simple_calc_first_sseg(
    input  [15:0] SW,
    output [15:14] LED,   // LED14 = carry_out, LED15 = overflow
    output [6:0]  sseg,
    output [7:0]  AN,
    output        DP
    );

    wire [3:0]  X      = SW[3:0];
    wire [3:0]  Y      = SW[7:4];
    wire [1:0]  dsel   = SW[9:8];     // picks digit 4,5,6,7
    wire [1:0]  op_sel = SW[15:14];

    wire [7:0]  calc_result;
    wire        carry_out, overflow;
    wire [11:0] bcd;
    wire [3:0]  digit_val;

    simple_calc calc (
        .X(X), .Y(Y), .op_sel(op_sel),
        .result(calc_result),
        .carry_out(carry_out),
        .overflow(overflow)
    );

    bin2bcd b2b (
        .bin(calc_result),
        .bcd(bcd)
    );

    // bcd[3:0] = ones -> digit 4, bcd[7:4] = tens -> digit 5,
    // bcd[11:8] = hundreds -> digit 6, digit 7 shows 0
    mux_4x1_nbit #(.N(4)) mux (
        .w0(bcd[3:0]),
        .w1(bcd[7:4]),
        .w2(bcd[11:8]),
        .w3(4'h0),
        .s(dsel),
        .f(digit_val)
    );

    first_sseg_driver drv (
        .active_digit({1'b1, dsel}),  // 3'b100..3'b111 = digits 4..7
        .num(digit_val),
        .DP_ctrl(1'b0),
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );

    assign LED[14] = carry_out;
    assign LED[15] = overflow;
endmodule
