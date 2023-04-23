# VHDL project

Topic: Sender and receiver of the Morse code.

### Team members

* Dmitrii Semenov (responsible for top level simulation, debugging, VHDL programing)
* Roman Lunin (responsible for VHDL programing, github design)

## Theoretical description and explanation

Enter a description of the problem and how to solve it.

## Hardware description of demo application

Insert descriptive text and schematic(s) of your implementation.

Block diagram for `top`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.jpg)

Block diagram for `driver_7seg_8dig`:

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8dig.jpg)
## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

Link to source files:
[https://github.com/dmitrii-semenov/morse-coder-decoder/tree/main/sim](https://github.com/dmitrii-semenov/morse-coder-decoder/tree/main/sim)

Link to testbench files:
[https://github.com/dmitrii-semenov/morse-coder-decoder/tree/main/src](https://github.com/dmitrii-semenov/morse-coder-decoder/tree/main/src)
## Components simulation

### Button driver
The first part of our project is the button driver. It is a block that automatically detects if the input button `BTND` is pressed by a user. Block also determines if the button is pressed for a short period (dot) or a long period (dash). The length of determination of a dot is set by a constant `g_LENGTH` at the top level. Once the combination of dots and dashes is complete, the user sends the combination using the button `BTNL`. This block is essential for the "sender" mode of our device. To switch between the "sender" and "receiver" modes `SW0` action was implemented into the design file. While the switch is activated (logical '1') device works in "sender" mode and the work process of this block is enabled. There is one output pin, that is connected to the multiplexer and three led pins, that are connected to RGB led. LEDs work as follows: Once the device is ready for getting the input combination of dots and dashes, the green LED is activated. Once the user starts to hold the button `BTND` for at least `g_LENGTH` period, the red LED is activated. That means that the user holds the button for enough time to send a dot. If the user releases the button, the block reads the dot signal and the green LED is activated, which means that the clock is ready for the further symbol. If the user continues to hold `BTND` button while the LED is red, alter 2-time intervals `g_LENGTH` (3 in total with the first that activates the red LED), LED turn into blue. In this situation, a dash signal will be sent to the block. After releasing a button, the LED will turn back to green color. Once the combination is finished, the user press and hold `BTNL` button (send) until the letter will appear on the 7-segment display. Simulation with all necessary signals is presented below

     ~SIMULATION~

## Instructions

Write an instruction manual for your application, including photos or a link to a video.

Instructions for using the morse code receiver:

1. Bring `SW0` to active position (up);

2. Make sure that the green LED is on, this means that everything is in working mode;

3. To enter a point, short press the bottom button `BTND` (the red diode should be lit):

4. To enter a dash, long press the bottom button `BTND` (the blue diode should be lit);

5. Press the left button `BTNL` to process and display your combination on the display (the letter or number you specified should appear);

6. If you want to continue entering symbols without deleting the previous combination, then repeat steps 2-5;

7. If you want to reset all symbols (so that the display becomes blank), then press the button in the middle `BTNC` (reset);

8. To enter new combinations, repeat steps 2-5.

## References

1. [Reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board
2. [Morse code](https://en.wikipedia.org/wiki/File:International_Morse_Code.svg) for letters encryption
3. [General information](https://en.wikipedia.org/wiki/Morse_code) about Morse code