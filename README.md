# VHDL project

Topic: Sender and receiver of the Morse code.

### Team members

* Dmitrii Semenov (responsible for top level simulation, debugging, VHDL programing)
* Roman Lunin (responsible for VHDL programing, github design)

## Theoretical description and explanation

Our task was to create a valid Morse code receiver and sender. At the beginning of the development of our project, we had several ideas for implementing a solution to our problem. The first idea for the receiver was to have the user specify combinations of dots and dashes using switches, for which we would require 10 switches (since the maximum combination length is 5 dashes). But we decided to refuse this idea and solve the issue in a different way. Our second idea was for the user to enter combinations using the buttons located on our `nexys-a7-50t` board. A dot would be a short press on the button (short press could be controlled by RGB LEDs, meaning the user would know when to release the button for only the dot to count), a long press would mean a dash. And in this way, the user could enter the desired combination and display a letter or number on a 7-segment display, and in case of an error, easily reset everything using the reset button. Also for the Morse code sender, we decided to use buttons where the user types the necessary symbols in the same way and sends using the "send" button. This idea seemed to us much more interesting and better for the implementation of our project.

## Hardware description of demo application

Block diagram for `top`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg)

Block diagram for `driver_7seg_8dig`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg)

### Explanation of the function of all important blocks of the project:

**Clock divider**

This block decreases the period of a clock signal, which is essential for the synchronous process. The user specifies a `g_LENGTH` constant, the length of a dot, in us. For example, if the value of `g_LENGTH` is 500 000, the dot length is `500 ms`. The output clock signal will appear with a defined period instead of a default clock signal with 10 ns period. The divided clock signal is then used in the `shifter`, `button driver` and `sender` blocks to set the dot length.

**Shifter**

This block is essential for the "receiver" mode of our device. The `SWO` switch position changes two modes, "sender" and "receiver." While the switch is deactivated (logical '0'), the device works in "receiver" mode, and the work process of this block is enabled. The input is connected to pin `D14`. That means that signal from the generator (morse code sender) is connected directly to the `shifter`. The `shifter` counts how long(in clocks) lasts signal '0'; thus, the `shifter` divides the input signal into separate letters. Thanks to the strict rules in Morse code, the `shifter` also may determine the structure of each letter or number (dots and dashes combination). As a result, a `21-bit signal` (for a specific letter or number) will appear on the output whenever a combination of signals is provided to the input pin.

**Debouncer**

This block filters the input signal from the button `BTND` (the user sets a combination of dots and dashes by pressing this button). To prevent noise or oscillations from the mechanical button (the real button may add noise to the signal or oscillations between '0' and '1' signal levels). The debouncer works in a way: it controls the input value of a signal (which is a `BTND` signal). If the value does not change for `3 ms`, it copies the input signal to the output. Of course, this block adds a `3 ms` delay, but that is not critical as potential problems may occur due to noise and oscillations.

**Button driver**

This block automatically detects if a user presses the input button `BTND`. Block also determines if the button is pressed for a short period (dot) or an extended period (dash) — the length of determination of a dot set by a constant `g_LENGTH` at the top level. Once the combination of dots and dashes is complete, the user sends the combination using the `BTNL` button. This block is essential for the "sender" mode of our device. The `SWO` switch position changes two modes, "sender" and "receiver." While the switch is activated (logical '1'), the device works in "sender" mode, and the work process of this block is enabled. One output pin is connected to the multiplexer, and three led pins are connected to RGB led. LED works as follows: The green LED is activated once the device is ready to get the input combination of dots and dashes. Once the user starts to hold the button `BTND` for at least the `g_LENGTH` period, the red LED is activated. That means the user holds the button enough to send a dot. If the user releases the button, the block reads the dot signal, and the green LED is activated, which means the clock is ready for the other symbol. If the user continues to hold the `BTND` button while the LED is red, alter 2-time intervals `g_LENGTH` (3 in total with the first that activates the red LED), LED turn into blue. In this situation, a dash signal will be sent to the block. After releasing a button, the LED will turn back to green color. Once the combination is finished, the user press and hold the `BTNL` button (send) until the letter appears on the 7-segment display. Simulation with all necessary signals is presented below.

## Software description 

**top:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/top.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_top.vhd)

**button_driver:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/button_driver.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_button_driver.vhd)

**clock_divider:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/clock_divider.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_clock_divider.vhd)

**debouncer:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/debouncer.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_debouncer.vhd)

**shifter:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/shifter.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_shifter.vhd)


**mux_21bit_2to1:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/mux_21bit_2to1.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_mux_21bit_2to1.vhd)

**mux_driver:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/mux_driver.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_mux_driver.vhd)

**signal_sender:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/signal_sender.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_signal_sender.vhd)

**driver_7seg_8digits:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/driver_7seg_8digits.vhd)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[testbench file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/tb/tb_driver_7seg_8digits.vhd)

**clock_enable:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/clock_enable.vhd)

**cnt_up_down:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/cnt_up_down.vhd)

**seg_driver_hex:**

* [sourse file](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/src/seg_driver_hex.vhd)

## Components simulation

     ~SIMULATION~

## Instructions

**Instructions for using the morse code receiver:**

**1.** Leave the `SW0` in initial position (*down*);

**2.** Connect the input source to the pin `D14` (*for example generator*);

**3.** Start sending the signal, then everything will be automatically displayed on the display as the input signal is processed.

**Instructions for using the morse code sender:**

**1.** Activate `SW0` (*up*);

**2.** Make sure that the green LED is on, this means that everything is in working mode;

**3.** To enter a point, short press the bottom button `BTND` (the red diode should be lit):

**4.** To enter a dash, long press the bottom button `BTND` (the blue diode should be lit);

**5.** Press the left button `BTNL` to process and display your combination on the display (the letter or number you specified should appear);

**6.** If you want to continue entering symbols without deleting the previous combination, then repeat steps 2-5;

**7.** If you want to reset all symbols (so that the display becomes blank), then press the button in the middle `BTNC` (*reset*);

**8.** To enter new combinations, repeat steps 2-5;

**9.** Activate `SW1` (*up*) to send your message (at the beginning the red diode will light up, which indicates the sending process, after the green diode will light up, this means your message has been sent).

## Video demonstration
Demonstration of the `"receiver"` mode

[Watch a video](https://www.youtube.com/shorts/d-faGH0KTpc)

Demonstration of the `"sender"` mode

[Watch a video](https://www.youtube.com/watch?v=6ZALID0tZt0)

## References

1. [Reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board
2. [Morse code](https://en.wikipedia.org/wiki/File:International_Morse_Code.svg) for letters encryption
3. [General information](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/video/morse-receiver.gif) about Morse code
