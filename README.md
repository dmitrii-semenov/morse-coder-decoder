# VHDL project

Topic: Sender and receiver of the Morse code.

### Team members

* Dmitrii Semenov (responsible for top level simulation, VHDL programing)
* Roman Lunin (responsible for VHDL programing, github decoration)

## Theoretical description and explanation

Enter a description of the problem and how to solve it.

## Hardware description of demo application

Insert descriptive text and schematic(s) of your implementation.

## Software description

Put flowchats/state diagrams of your algorithm(s) and direct links to source/testbench files in `src` and `sim` folders. 

## Components simulation

### Button driver
The first part of our project is the button driver. It is a block that automatically detects if the input button `BTND` is pressed by a user. Block also determines if the button is pressed for a short period (dot) or a long period (dash). The length of determination of a dot is set by a constant `g_LENGTH` at the top level. Once the combination of dots and dashes is complete, the user sends the combination using the button `BTNL`. This block is essential for the "sender" mode of our device. To switch between the "sender" and "receiver" modes `SW0` action was implemented into the design file. While the switch is activated (logical '1') device works in "sender" mode and the work process of this block is enabled. There is one output pin, that is connected to the multiplexer and three led pins, that are connected to RGB led. LEDs work as follows: Once the device is ready for getting the input combination of dots and dashes, the green LED is activated. Once the user starts to hold the button `BTND` for at least `g_LENGTH` period, the red LED is activated. That means that the user holds the button for enough time to send a dot. If the user releases the button, the block reads the dot signal and the green LED is activated, which means that the clock is ready for the further symbol. If the user continues to hold `BTND` button while the LED is red, alter 2-time intervals `g_LENGTH` (3 in total with the first that activates the red LED), LED turn into blue. In this situation, a dash signal will be sent to the block. After releasing a button, the LED will turn back to green color. Once the combination is finished, the user press and hold `BTNL` button (send) until the letter will appear on the 7-segment display. Simulation with all necessary signals is presented below

     ~SIMULATION~

## Instructions

Write an instruction manual for your application, including photos or a link to a video.

## References

1. Put here the literature references you used.
2. ...
