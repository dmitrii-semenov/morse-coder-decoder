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
The first part of our project is button driver. It is a block that automatically detects if input button `BTND` is pressed by user. Block also determines if button pressed for short period of time (dot) or for a long period of time (dash). Length of determination of a dot is set by a constant `g_LENGTH` at the top level. Once combination of dots and dashes is complete, user send the combination using bitton `BTNL`. This block is essential for "sender" mode of our device. To switch between "sender" and "receiver" modes `SW0` action was implemented into design file. Whilw switch is activated (logical '1') device works in "sender" mode and work process of this block is enabled. There are one output pin, that is connected to multiplexer and three led pins, those are connected to RGB led. Leds work as follows: Once the device is ready for getting the input combination of dots and dashes, green LED activated. Once user starts to hold the button `BTND` for at least `g_LENGTH` period of time, red LED is activated. That means that user hold the button enough time to send a dot. If user releases the button, block reads dot signal and green LED activated, thta means that clock is ready for the further symbol. If user continues to hold `BTND` button while LED is red, alter 2 time intervals `g_LENGTH` (3 in total with the first that activates red LED), LED turn into blue. In this situation, a dash signal will be send to the block. After releasing a button, LED will turn back to green colour. Once combination is finished, user press and hold `BTNL` button (send) until the letter will appear on the 7-segment display. Simulation with all necessarily signals is presented below

     ~SIMULATION~

## Instructions

Write an instruction manual for your application, including photos or a link to a video.

## References

1. Put here the literature references you used.
2. ...
