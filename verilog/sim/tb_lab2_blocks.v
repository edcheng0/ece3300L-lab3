`timescale 1ns / 1ps
// Exhaustive checks of the Lab 2 blocks: adder/subtractor, CSA multiplier, simple_calc, bin2bcd.
module tb_lab2_blocks;
    reg  [3:0] X, Y; reg [1:0] op;
    wire [3:0] S; wire cout, ovf, c2, o2; wire [7:0] P, R; wire [11:0] bcd; reg [7:0] b; reg [11:0] exp_bcd;
    integer x, y, n, errors = 0, sx, sy, sd;

    addsub_4bit as(.X(X), .Y(Y), .sub(op[0]), .S(S), .carry_out(cout), .overflow(ovf));
    csa_multiplier_4bit mul(.X(X), .Y(Y), .P(P));
    simple_calc calc(.X(X), .Y(Y), .op_sel(op), .result(R), .carry_out(c2), .overflow(o2));
    bin2bcd b2b(.bin(b), .bcd(bcd));

    initial begin
        for (x = 0; x < 16; x = x + 1) for (y = 0; y < 16; y = y + 1) begin
            X = x; Y = y;
            sx = (x > 7) ? x - 16 : x; sy = (y > 7) ? y - 16 : y;
            op = 2'b00; #1;
            if ({cout, S} !== x + y || ovf !== ((sx + sy > 7) || (sx + sy < -8))) begin errors = errors + 1; $display("FAIL add %0d+%0d", x, y); end
            if (R !== x + y || c2 !== cout || o2 !== ovf) begin errors = errors + 1; $display("FAIL calc add %0d+%0d", x, y); end
            op = 2'b01; #1;
            if (S !== ((x - y) & 15) || cout !== (x >= y) || ovf !== ((sx - sy > 7) || (sx - sy < -8))) begin errors = errors + 1; $display("FAIL sub %0d-%0d", x, y); end
            if (R !== ((x - y) & 15)) begin errors = errors + 1; $display("FAIL calc sub %0d-%0d", x, y); end
            if (P !== x * y) begin errors = errors + 1; $display("FAIL mul %0d*%0d", x, y); end
            op = 2'b10; #1; if (R !== x * y || c2 !== 0 || o2 !== 0) begin errors = errors + 1; $display("FAIL calc mul %0d*%0d", x, y); end
            op = 2'b11; #1; if (R !== x * y) begin errors = errors + 1; $display("FAIL calc mul(11) %0d*%0d", x, y); end
        end
        for (n = 0; n < 256; n = n + 1) begin
            b = n; #1;
            exp_bcd[11:8] = (n/100)%10; exp_bcd[7:4] = (n/10)%10; exp_bcd[3:0] = n%10;
            if (bcd !== exp_bcd) begin errors = errors + 1; $display("FAIL bcd %0d", n); end
        end
        if (errors == 0) $display("PASS: lab2 blocks"); else $display("%0d ERRORS", errors);
        $finish;
    end
endmodule
