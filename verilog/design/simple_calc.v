`timescale 1ns / 1ps
// Simple unsigned calculator.
//   op_sel = 00 : X + Y   (result[4] = carry, result = 0..30)
//   op_sel = 01 : X - Y   (4-bit wrap-around if X < Y; carry_out = 0 then)
//   op_sel = 1x : X * Y   (0..225)
// carry_out / overflow come from the adder/subtractor (forced 0 when multiplying).
module simple_calc(
    input  [3:0] X, Y,
    input  [1:0] op_sel,
    output reg [7:0] result,
    output       carry_out,
    output       overflow
    );
    wire [3:0] as_s;
    wire       as_cout, as_ovf;
    wire [7:0] mult;

    addsub_4bit as (.X(X), .Y(Y), .sub(op_sel[0]), .S(as_s), .carry_out(as_cout), .overflow(as_ovf));
    csa_multiplier_4bit mul (.X(X), .Y(Y), .P(mult));

    always @* begin
        if (op_sel[1])
            result = mult;
        else if (op_sel[0])
            result = {4'b0000, as_s};            // subtract
        else
            result = {3'b000, as_cout, as_s};    // add: carry becomes bit 4
    end

    assign carry_out = op_sel[1] ? 1'b0 : as_cout;
    assign overflow  = op_sel[1] ? 1'b0 : as_ovf;
endmodule
