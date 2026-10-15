# ece2300L-lab3 : Combinational-Circuit Building Blocks

## Files
- [`src/priority_encoder_generic.v`](src/priority_encoder_generic.v) – starter: parameterized priority encoder
- [`src/decoder_generic.v`](src/decoder_generic.v) – starter: parameterized decoder
- [`src/hex2sseg.v`](src/hex2sseg.v) – starter: hex to seven-segment converter
- [`src/mux_4x1_nbit.v`](src/mux_4x1_nbit.v) – starter: parameterized 4x1 mux
- [`src/prior_encoder_test.v`](src/prior_encoder_test.v) – Part 1 top module
- [`src/first_sseg_driver.v`](src/first_sseg_driver.v) – Part 2 driver module
- [`src/first_sseg_driver_test.v`](src/first_sseg_driver_test.v) – Part 2 top module
- [`src/simple_calc_first_sseg.v`](src/simple_calc_first_sseg.v) – Part 3 top module
- [`src/full_adder.v`](src/full_adder.v) – Lab 2: 1-bit full adder
- [`src/addsub_4bit.v`](src/addsub_4bit.v) – Lab 2: 4-bit adder/subtractor
- [`src/csa_multiplier_4bit.v`](src/csa_multiplier_4bit.v) – Lab 2: 4x4 carry-save multiplier
- [`src/simple_calc.v`](src/simple_calc.v) – Lab 2: simple calculator
- [`src/bin2bcd.v`](src/bin2bcd.v) – Lab 2: binary to BCD converter
- [`tb/tb_prior_encoder_test.v`](tb/tb_prior_encoder_test.v) – Part 1 testbench
- [`tb/tb_first_sseg_driver.v`](tb/tb_first_sseg_driver.v) – Part 2 driver testbench
- [`tb/tb_first_sseg_driver_test.v`](tb/tb_first_sseg_driver_test.v) – Part 2 top-module testbench
- [`tb/tb_lab2_blocks.v`](tb/tb_lab2_blocks.v) – Lab 2 block testbench
- [`tb/tb_simple_calc_first_sseg.v`](tb/tb_simple_calc_first_sseg.v) – Part 3 testbench (exhaustive)
- [`tb/tb_simple_calc_first_sseg_simple.v`](tb/tb_simple_calc_first_sseg_simple.v) – Part 3 testbench (simplified)
- [`constraints/part1_prior_encoder_test.xdc`](constraints/part1_prior_encoder_test.xdc) – Part 1 board constraints, Nexys A7-100T
- [`constraints/part2_first_sseg_driver_test.xdc`](constraints/part2_first_sseg_driver_test.xdc) – Part 2 board constraints, Nexys A7-100T
- [`constraints/part3_simple_calc_first_sseg.xdc`](constraints/part3_simple_calc_first_sseg.xdc) – Part 3 board constraints, Nexys A7-100T

## Part 1: Priority Encoder
Simulation waveform:

![Part 1 waveform](screenshots/part1_waveform.png)

Schematic:

![Part 1 schematic](screenshots/part1_schematic.png)

## Part 2: Seven-Segment Driver
Simulation waveform:

![Part 2 waveform](screenshots/part2_waveform.png)

Schematic:

![Part 2 schematic](screenshots/part2_schematic.png)

## Part 3: Calculator with Seven-Segment Output
Simulation waveform:

![Part 3 waveform](screenshots/part3_waveform.png)

Block diagram:

![Part 3 block diagram](screenshots/part3_blockdiagram.png)

## Demo Videos
- [Part 1 demo video](video/part1_demo.mp4)
- [Part 2 demo video](video/part2_demo.mp4)
- [Part 3 demo video](video/part3_demo.mp4)
