`timescale 1ns / 1ps
module tb_simple_calc_first_sseg;
    reg  [15:0] SW;
    wire [15:14] LED;
    wire [6:0] sseg; wire [7:0] AN; wire DP;
    integer x, y, op, d, errors = 0;
    integer result, sx, sy, exp_c, exp_o;
    reg [3:0] expected;
    wire [6:0] exp_sseg;

    simple_calc_first_sseg dut(.SW(SW), .LED(LED), .sseg(sseg), .AN(AN), .DP(DP));
    hex2sseg ref_h(.hex(expected), .sseg(exp_sseg));

    initial begin
        $dumpfile("tb_simple_calc_first_sseg.vcd"); $dumpvars(0, tb_simple_calc_first_sseg);
        for (op = 0; op < 3; op = op + 1)
          for (x = 0; x < 16; x = x + 1)
            for (y = 0; y < 16; y = y + 1)
              for (d = 0; d < 4; d = d + 1) begin
                SW = 0; SW[3:0] = x; SW[7:4] = y; SW[9:8] = d; SW[15:14] = op; #5;
                sx = (x > 7) ? x - 16 : x; sy = (y > 7) ? y - 16 : y;
                case (op)
                    0: begin result = x + y;         exp_c = (x + y > 15); exp_o = (sx + sy > 7) || (sx + sy < -8); end
                    1: begin result = (x - y) & 15;  exp_c = (x >= y);     exp_o = (sx - sy > 7) || (sx - sy < -8); end
                    default: begin result = x * y; exp_c = 0; exp_o = 0; end
                endcase
                case (d) 0: expected = result % 10; 1: expected = (result/10) % 10;
                         2: expected = (result/100) % 10; default: expected = 0; endcase
                #1;
                if (AN !== ~(8'b1 << (4 + d)) || sseg !== exp_sseg || DP !== 1'b1 ||
                    LED[14] !== exp_c[0] || LED[15] !== exp_o[0]) begin
                    errors = errors + 1;
                    if (errors < 10) $display("FAIL op=%0d x=%0d y=%0d d=%0d", op, x, y, d);
                end
              end
        if (errors == 0) $display("PASS: simple_calc_first_sseg"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
