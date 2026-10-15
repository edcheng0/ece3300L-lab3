`timescale 1ns / 1ps
// Part 2: rudimentary seven-segment driver.
// active_digit picks which of the 8 digits is lit, num is the hex value shown,
// DP_ctrl = 1 turns the decimal point ON.
module first_sseg_driver(
    input  [2:0] active_digit,
    input  [3:0] num,
    input        DP_ctrl,
    output [6:0] sseg,    // gfedcba, active low
    output [7:0] AN,      // active low
    output       DP       // active low
    );

    // decoder_generic declares its output as [0:2**N-1], so y[0] is the MSB.
    wire [0:7] dec_y;

    decoder_generic #(.N(3)) dec (
        .w(active_digit),
        .en(1'b1),
        .y(dec_y)
    );

    // Reorder so decoder output k drives AN[k] (and invert: AN is active low).
    assign AN = ~{dec_y[7], dec_y[6], dec_y[5], dec_y[4],
                  dec_y[3], dec_y[2], dec_y[1], dec_y[0]};

    hex2sseg h2s (
        .hex(num),
        .sseg(sseg)
    );

    assign DP = ~DP_ctrl;
endmodule
