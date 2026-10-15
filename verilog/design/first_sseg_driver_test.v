`timescale 1ns / 1ps
// Part 2 test system: SW2..SW0 = X drives both the digit location and the value.
module first_sseg_driver_test(
    input  [2:0] SW,
    output [6:0] sseg,
    output [7:0] AN,
    output       DP
    );

    first_sseg_driver drv (
        .active_digit(SW[2:0]),
        .num({1'b0, SW[2:0]}),
        .DP_ctrl(1'b0),          // decimal point off
        .sseg(sseg),
        .AN(AN),
        .DP(DP)
    );
endmodule
