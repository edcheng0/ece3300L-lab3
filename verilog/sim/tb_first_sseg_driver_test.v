`timescale 1ns / 1ps
module tb_first_sseg_driver_test;
    reg  [2:0] SW;
    wire [6:0] sseg;
    wire [7:0] AN;
    wire       DP;
    integer i, errors = 0;
    reg [3:0] expected;
    wire [6:0] exp_sseg;

    first_sseg_driver_test dut(.SW(SW), .sseg(sseg), .AN(AN), .DP(DP));
    hex2sseg ref_h(.hex(expected), .sseg(exp_sseg));

    initial begin
        $dumpfile("tb_first_sseg_driver_test.vcd"); $dumpvars(0, tb_first_sseg_driver_test);
        for (i = 0; i < 8; i = i + 1) begin
            SW = i; expected = i; #10;
            // exactly digit i on (AN[i]=0), all others off, correct pattern, DP off
            if (AN !== ~(8'b1 << i) || sseg !== exp_sseg || DP !== 1'b1) begin
                errors = errors + 1;
                $display("FAIL X=%0d AN=%b sseg=%b DP=%b", i, AN, sseg, DP);
            end
        end
        if (errors == 0) $display("PASS: first_sseg_driver_test"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
