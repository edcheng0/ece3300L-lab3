`timescale 1ns / 1ps
// 4-bit ripple adder/subtractor.  sub = 0: S = X + Y      sub = 1: S = X - Y (X + ~Y + 1)
// carry_out : carry out of the MSB (for subtraction, 1 means "no borrow", i.e. X >= Y)
// overflow  : signed (two's complement) overflow = carry into MSB XOR carry out of MSB
module addsub_4bit(
    input  [3:0] X, Y,
    input        sub,
    output [3:0] S,
    output       carry_out,
    output       overflow
    );
    wire [3:0] yx = Y ^ {4{sub}};
    wire [4:0] c;
    assign c[0] = sub;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : fa_chain
            full_adder fa(.a(X[i]), .b(yx[i]), .cin(c[i]), .s(S[i]), .cout(c[i+1]));
        end
    endgenerate

    assign carry_out = c[4];
    assign overflow  = c[4] ^ c[3];
endmodule
