# VHDL project

Topic: Sender and receiver of the Morse code.

### Team members

* Dmitrii Semenov (responsible for top level simulation, debugging, VHDL programing)
* Roman Lunin (responsible for VHDL programing, github design)

## Theoretical description and explanation

Enter a description of the problem and how to solve it.

Our task was to create a valid Morse code receiver and sender. At the beginning of the development of our project, we had several ideas for implementing a solution to our problem. The first idea for the receiver was to have the user specify combinations of dots and dashes using switches, for which we would require 10 switches (since the maximum combination length is 5 dashes). But we decided to refuse this idea and solve the issue in a different way. Our second idea was for the user to enter combinations using the buttons located on our `nexys-a7-50t` board. A dot would be a short press on the button (short press could be controlled by RGB LEDs, meaning the user would know when to release the button for only the dot to count), a long press would mean a dash. And in this way, the user could enter the desired combination and display a letter or number on a 7-segment display, and in case of an error, easily reset everything using the reset button. Also for the Morse code sender, we decided to use buttons where the user types the necessary symbols in the same way and sends using the "send" button. This idea seemed to us much more interesting and better for the implementation of our project.

## Hardware description of demo application

Insert descriptive text and schematic(s) of your implementation.

Block diagram for `top`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg)

Block diagram for `driver_7seg_8dig`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg)

### Explanation of the function of all important blocks of the project:

**Button driver**

The first part of our project is the button driver. It is a block that automatically detects if the input button `BTND` is pressed by a user. Block also determines if the button is pressed for a short period (dot) or a long period (dash). The length of determination of a dot is set by a constant `g_LENGTH` at the top level. Once the combination of dots and dashes is complete, the user sends the combination using the button `BTNL`. This block is essential for the "sender" mode of our device. To switch between the "sender" and "receiver" modes `SW0` action was implemented into the design file. While the switch is activated (logical '1') device works in "sender" mode and the work process of this block is enabled. There is one output pin, that is connected to the multiplexer and three led pins, that are connected to RGB led. LEDs work as follows: Once the device is ready for getting the input combination of dots and dashes, the green LED is activated. Once the user starts to hold the button `BTND` for at least `g_LENGTH` period, the red LED is activated. That means that the user holds the button for enough time to send a dot. If the user releases the button, the block reads the dot signal and the green LED is activated, which means that the clock is ready for the further symbol. If the user continues to hold `BTND` button while the LED is red, alter 2-time intervals `g_LENGTH` (3 in total with the first that activates the red LED), LED turn into blue. In this situation, a dash signal will be sent to the block. After releasing a button, the LED will turn back to green color. Once the combination is finished, the user press and hold `BTNL` button (send) until the letter will appear on the 7-segment display. Simulation with all necessary signals is presented below.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

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

Write an instruction manual for your application, including photos or a link to a video.

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
