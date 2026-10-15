`timescale 1ns / 1ps
// Simple Part 3 testbench: a few hand-picked cases from the board test table.
module tb_simple_calc_first_sseg_simple;
    reg  [15:0] SW = 0;
    wire [15:14] LED;
    wire [6:0] sseg;
    wire [7:0] AN;
    wire DP;

    reg  [3:0] want;          // digit we expect on the display
    wire [6:0] want_sseg;     // its segment pattern
    integer d, errors = 0;

    simple_calc_first_sseg dut(.SW(SW), .LED(LED), .sseg(sseg), .AN(AN), .DP(DP));
    hex2sseg ref_h(.hex(want), .sseg(want_sseg));

    // Apply X, Y, op, then step through the digits and check the answer.
    task test(input [3:0] x, input [3:0] y, input [1:0] op, input integer answer);
        begin
            for (d = 0; d < 3; d = d + 1) begin   // 0 = ones, 1 = tens, 2 = hundreds
                SW = {op, 4'b0, d[1:0], y, x};     // SW[15:14]=op, SW[9:8]=digit, SW[7:4]=Y, SW[3:0]=X
                want = (d == 0) ? answer % 10 : (d == 1) ? (answer / 10) % 10 : answer / 100;
                #10;
                if (sseg !== want_sseg || AN !== ~(8'b1 << (4 + d))) begin
                    errors = errors + 1;
                    $display("FAIL: X=%0d Y=%0d op=%0d digit %0d", x, y, op, 4 + d);
                end
            end
        end
    endtask

    initial begin
        test(1,  2,  2'b00, 3);     // 1 + 2   = 3
        test(5,  7,  2'b00, 12);    // 5 + 7   = 12
        test(15, 15, 2'b00, 30);    // 15 + 15 = 30
        test(9,  4,  2'b01, 5);     // 9 - 4   = 5
        test(12, 10, 2'b10, 120);   // 12 * 10 = 120
        test(6,  7,  2'b11, 42);    // 6 * 7   = 42
        test(15, 15, 2'b10, 225);   // 15 * 15 = 225
        if (errors == 0) $display("PASS"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
