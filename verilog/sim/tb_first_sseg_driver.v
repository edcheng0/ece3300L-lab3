`timescale 1ns / 1ps
// Extra: checks the driver on its own, including DP_ctrl and non-matching digit/num.
module tb_first_sseg_driver;
    reg [2:0] d; reg [3:0] n; reg dp;
    wire [6:0] sseg; wire [7:0] AN; wire DP;
    integer errors = 0;
    wire [6:0] exp_sseg; 
    first_sseg_driver dut(.active_digit(d), .num(n), .DP_ctrl(dp), .sseg(sseg), .AN(AN), .DP(DP));
    hex2sseg ref_h(.hex(n), .sseg(exp_sseg));
    integer i, j;
    initial begin
        $dumpfile("tb_first_sseg_driver.vcd"); $dumpvars(0, tb_first_sseg_driver);
        for (i = 0; i < 8; i = i + 1)
            for (j = 0; j < 16; j = j + 1) begin
                d = i; n = j; dp = j[0]; #5;
                if (AN !== ~(8'b1 << i) || sseg !== exp_sseg || DP !== ~dp) begin
                    errors = errors + 1; $display("FAIL d=%0d n=%0d", i, j); end
            end
        if (errors == 0) $display("PASS: first_sseg_driver"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
