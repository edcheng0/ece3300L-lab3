# Lab 3 – Combinational-Circuit Building Blocks

## Files

### Source (`src/`)
- [`priority_encoder_generic.v`](src/priority_encoder_generic.v) — starter: parameterized priority encoder
- [`decoder_generic.v`](src/decoder_generic.v) — starter: parameterized decoder
- [`hex2sseg.v`](src/hex2sseg.v) — starter: hex to seven-segment converter
- [`mux_4x1_nbit.v`](src/mux_4x1_nbit.v) — starter: parameterized 4x1 mux
- [`prior_encoder_test.v`](src/prior_encoder_test.v) — Part 1 top module
- [`first_sseg_driver.v`](src/first_sseg_driver.v) — Part 2 driver module
- [`first_sseg_driver_test.v`](src/first_sseg_driver_test.v) — Part 2 top module
- [`simple_calc_first_sseg.v`](src/simple_calc_first_sseg.v) — Part 3 top module
- [`full_adder.v`](src/full_adder.v) — Lab 2: 1-bit full adder
- [`addsub_4bit.v`](src/addsub_4bit.v) — Lab 2: 4-bit adder/subtractor
- [`csa_multiplier_4bit.v`](src/csa_multiplier_4bit.v) — Lab 2: 4x4 carry-save multiplier
- [`simple_calc.v`](src/simple_calc.v) — Lab 2: simple calculator
- [`bin2bcd.v`](src/bin2bcd.v) — Lab 2: binary to BCD converter

### Testbenches (`tb/`)
- [`tb_prior_encoder_test.v`](tb/tb_prior_encoder_test.v) — Part 1 testbench
- [`tb_first_sseg_driver.v`](tb/tb_first_sseg_driver.v) — Part 2 driver testbench
- [`tb_first_sseg_driver_test.v`](tb/tb_first_sseg_driver_test.v) — Part 2 top-module testbench
- [`tb_lab2_blocks.v`](tb/tb_lab2_blocks.v) — Lab 2 block testbench
- [`tb_simple_calc_first_sseg.v`](tb/tb_simple_calc_first_sseg.v) — Part 3 testbench (exhaustive)
- [`tb_simple_calc_first_sseg_simple.v`](tb/tb_simple_calc_first_sseg_simple.v) — Part 3 testbench (simplified)

### Constraints (`constraints/`)
- [`part1_prior_encoder_test.xdc`](constraints/part1_prior_encoder_test.xdc) — Part 1, Nexys A7-100T
- [`part2_first_sseg_driver_test.xdc`](constraints/part2_first_sseg_driver_test.xdc) — Part 2, Nexys A7-100T
- [`part3_simple_calc_first_sseg.xdc`](constraints/part3_simple_calc_first_sseg.xdc) — Part 3, Nexys A7-100T

---

## Part 1 (Displaying the output of a priority encoder)

- Top module: [`prior_encoder_test.v`](src/prior_encoder_test.v)
- Uses [`priority_encoder_generic.v`](src/priority_encoder_generic.v) (16x4) and [`hex2sseg.v`](src/hex2sseg.v)
- IO (see [XDC](constraints/part1_prior_encoder_test.xdc)):
  - SW15–SW0 → 16 inputs of the priority encoder (SW15 = highest priority)
  - One seven-segment digit active (AN = 0 for that digit)
  - hex2sseg output → seven-segment LEDs
  - DP off
- Testbench: [`tb_prior_encoder_test.v`](tb/tb_prior_encoder_test.v)

## Part 2 (Building a rudimentary seven-segment display driver)

- Driver module: [`first_sseg_driver.v`](src/first_sseg_driver.v)
  - 3-bit `active_digit`, 4-bit `num`, 1-bit `DP_ctrl`
  - Outputs: `sseg`, `AN`, `DP`
- Test system: [`first_sseg_driver_test.v`](src/first_sseg_driver_test.v)
  - Connects 3-bit input X to both `active_digit` and `num`
- IO (see [XDC](constraints/part2_first_sseg_driver_test.xdc)):
  - SW2–SW0 → input X
  - Seven-segment control signals → board outputs
- Testbenches: [`tb_first_sseg_driver.v`](tb/tb_first_sseg_driver.v), [`tb_first_sseg_driver_test.v`](tb/tb_first_sseg_driver_test.v)

## Part 3 (Calculator output on the rudimentary driver)

- Top module: [`simple_calc_first_sseg.v`](src/simple_calc_first_sseg.v)
- Imports: [`simple_calc.v`](src/simple_calc.v) (+ [`addsub_4bit.v`](src/addsub_4bit.v), [`csa_multiplier_4bit.v`](src/csa_multiplier_4bit.v), [`full_adder.v`](src/full_adder.v)), [`bin2bcd.v`](src/bin2bcd.v), [`mux_4x1_nbit.v`](src/mux_4x1_nbit.v), [`first_sseg_driver.v`](src/first_sseg_driver.v)
- Inputs: X[3:0], Y[3:0], op_sel[1:0] (00 = add, 01 = subtract, 1x = multiply)
- IO (see [XDC](constraints/part3_simple_calc_first_sseg.xdc)):
  - SW3–SW0 → X
  - SW7–SW4 → Y
  - SW9–SW8 → select active digit (4, 5, 6, 7)
  - SW15–SW14 → op_sel
  - Seven-segment 7–4 → BCD result output
  - LED14 → carry_out of adder/subtractor
  - LED15 → overflow of adder/subtractor
- Testbenches: [`tb_simple_calc_first_sseg.v`](tb/tb_simple_calc_first_sseg.v) (exhaustive), [`tb_simple_calc_first_sseg_simple.v`](tb/tb_simple_calc_first_sseg_simple.v) (simplified)
