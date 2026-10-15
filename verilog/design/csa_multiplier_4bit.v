`timescale 1ns / 1ps
// 4x4 unsigned carry-save-adder (array) multiplier with a final ripple adder.
module csa_multiplier_4bit(
    input  [3:0] X, Y,
    output [7:0] P
    );
    // partial products: pp[i][j] = X[j] & Y[i], weight 2^(i+j)
    wire [3:0] pp [0:3];
    // s[i][j] has weight 2^(i+j); c[i][j] has weight 2^(i+j+1)
    wire [3:0] s [0:3];
    wire [3:0] c [0:3];

    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin : pp_gen
            assign pp[i] = X & {4{Y[i]}};
        end
    endgenerate

    // stage 0 is just the first partial product row
    assign s[0] = pp[0];
    assign c[0] = 4'b0000;

    // stages 1..3: one row of full adders each (carry-save, no carry ripple inside a row)
    generate
        for (i = 1; i < 4; i = i + 1) begin : stage
            for (j = 0; j < 4; j = j + 1) begin : col
                full_adder fa(
                    .a   (j < 3 ? s[i-1][j+1] : 1'b0),
                    .b   (pp[i][j]),
                    .cin (c[i-1][j]),
                    .s   (s[i][j]),
                    .cout(c[i][j])
                );
            end
        end
    endgenerate

    // low product bits come straight out of the array
    assign P[0] = s[0][0];
    assign P[1] = s[1][0];
    assign P[2] = s[2][0];
    assign P[3] = s[3][0];

    // final ripple-carry adder for the upper 4 bits: {0,s3[3:1]} + c3[3:0]
    wire [3:0] fa_a = {1'b0, s[3][3], s[3][2], s[3][1]};
    wire [3:0] fa_b = c[3];
    wire [4:0] fc;
    assign fc[0] = 1'b0;
    generate
        for (i = 0; i < 4; i = i + 1) begin : final_add
            full_adder fa(.a(fa_a[i]), .b(fa_b[i]), .cin(fc[i]), .s(P[4+i]), .cout(fc[i+1]));
        end
    endgenerate
endmodule
