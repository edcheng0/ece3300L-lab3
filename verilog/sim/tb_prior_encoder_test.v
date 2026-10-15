`timescale 1ns / 1ps
module tb_prior_encoder_test;
    reg  [15:0] SW;
    wire [6:0]  sseg;
    wire [7:0]  AN;
    wire        DP;
    integer i, errors = 0;
    reg [3:0] expected;
    wire [6:0] exp_sseg;

    prior_encoder_test dut(.SW(SW), .sseg(sseg), .AN(AN), .DP(DP));
    hex2sseg ref_h(.hex(expected), .sseg(exp_sseg));

    initial begin
        $dumpfile("tb_prior_encoder_test.vcd"); $dumpvars(0, tb_prior_encoder_test);
        // walk a single switch through all 16 positions
        for (i = 0; i < 16; i = i + 1) begin
            SW = 16'b1 << i; expected = i; #10;
            if (sseg !== exp_sseg || AN !== 8'b11111110 || DP !== 1'b1) begin
                errors = errors + 1; $display("FAIL single SW[%0d]", i); end
        end
        // priority: lower switches are ignored when a higher one is on
        SW = 16'b0000_0101_0000_0110; expected = 4'd10; #10;
        if (sseg !== exp_sseg) begin errors = errors + 1; $display("FAIL priority A"); end
        SW = 16'b1000_0000_0000_0001; expected = 4'd15; #10;
        if (sseg !== exp_sseg) begin errors = errors + 1; $display("FAIL priority B"); end
        SW = 16'b0000_0000_0001_1111; expected = 4'd4;  #10;
        if (sseg !== exp_sseg) begin errors = errors + 1; $display("FAIL priority C"); end
        if (errors == 0) $display("PASS: prior_encoder_test"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
