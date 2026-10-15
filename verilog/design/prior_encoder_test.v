`timescale 1ns / 1ps
// Part 1: priority encoder test system.
// SW15..SW0 -> 16x4 priority encoder -> hex2sseg -> one seven-segment digit.
module prior_encoder_test(
    input  [15:0] SW,
    output [6:0]  sseg,   // gfedcba, active low
    output [7:0]  AN,     // active low
    output        DP      // active low
    );

    wire [3:0] enc_out;   // index of the highest asserted switch

    priority_encoder_generic #(.N(16)) pe (
        .w(SW),
        .z(),             // "any switch on" flag, not used in this part
        .y(enc_out)
    );

    hex2sseg h2s (
        .hex(enc_out),
        .sseg(sseg)
    );

    assign AN = 8'b1111_1110;  // only digit 0 active (AN0 = 0)
    assign DP = 1'b1;          // decimal point off (active low)
endmodule
