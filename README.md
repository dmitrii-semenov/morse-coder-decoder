# VHDL project

Topic: Sender and receiver of the Morse code.

### Team members

* Dmitrii Semenov (responsible for the top level simulation, debugging, VHDL programing, hardware description)
* Roman Lunin (responsible for VHDL programing, github design, software description)

## Theoretical description and explanation

Our task was to create a functional Morse code receiver and sender. At the development stage of our project, we had several ideas for implementing a solution to our problem. The first idea was to have the user specify combinations of dots and dashes using switches(for the `sender` mode), for which we would require 10 switches (since the maximum combined length of one symbol is 5 dashes). However, we decided to refuse this idea and find a different solution. Our second idea was to enter combinations using the buttons on our `nexys-a7-50t` board. A dot would be a short press on the button (a short press could be controlled by RGB LED, meaning the user would know when to release the button for only the dot to count), and a long press would mean a dash.
Moreover, in this way, the user could enter the desired combination and display a letter or number on a 7-segment display. In case of an error, there is a possibility to reset everything using the reset button. The Morse code receiver would be built using signal value counters. Thus no user actions are required for this mode. This idea was much more exciting and better for implementing our project.

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

**Multiplexer**

This block is a regular 2-to-1 multiplexer 21-bit. The `slc` signal, which is `SW0`(it is a switch that sets one of two working modes), controls which of the input signals is transferred to the output. We mainly used a multiplexer to avoid a short between the output pins of the `button_driver` and `shifter`.

**Mux driver**

This block is an input driver for our 7-segment displays. When the input signal changes its value, the driver shifts all output signals on one segment to the left. The last letter/number will be displayed on the right display cell. This block also works as a "memory" cell that remembers the last 8 letters/numbers entered. Thanks to it, we can display 8 symbols simultaneously instead of 1. 

**Display driver**

This block is a driver for our 7-segment displays. It switches the anodes of all displays sequentially to set the symbol on each display. This block consists of `clock_enable` (clock divider that increases clock period to a specific value so that the user will not recognize the anode switch process), `counter_up_down` (that counts from 1 to 8 to switch all the anodes. sequentially), `p_mux` (this part connects inputs to outputs via switches) and `seg_driver_hex` (that transforms 21-bit signals of specific symbols to 7-bit signals, that activates different display segments).

**Signal sender**

The last block is a signal sender. Once switch `SW1` is activated, this block sends the Morse code signal to the output pin `E16`. The length of a dot is defined by a constant `g_LENGTH` at the top level (this constant is used in `shifter`, `clock_divider`, and `button_driver`). Once switch `SW1` is activated, the right RGB LED (`LED16`) will turn red. That indicates that signal sending is in process. Once all the letters from a display are sent, RGB LED will turn green, indicating the procedure's finish. (Note that only symbols on display will be sent from the left symbol to the right) 

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

**clock_divider:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/clock_divider.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/clock_divider.png)

**`sig_ce`** - outgoing signal from clock_divider (reduced clock)

**`sig_clk_100mhz`** - regular clock with a frequency of 100MHz

**`sig_rst`** - reset (button `BTNC`)


**debouncer:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/debouncer.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/debouncer.png)

**`input`** - the signal that is set by the `BTND` button

**`output`** - the signal that goes to the input of the button_driver

**`rst`** - reset (button `BTNC`)

**`sig_clk_100mhz`** - regular clock with a frequency of 100MHz


**shifter:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/shifter.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/shifter.png)

**`input`** - input signal from pin `D14`

**`output`** - output 21-bit signal going to the input of the mux_21bit_2to1 (input a)

**`rst`** - reset (button `BTNC`)

**`sig_clk_100mhz`** - reduced clock

**`SW`** - switch `SW0` with which we select the receiver (`SW0` in the down position)


**button_driver:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/button_driver.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/button_driver.png)

**`input`** - the signal that comes from debouncer

**`led17_b`**, **`led17_g`** and **`led17_r`** - indication of the time frame for the introduction of combinations and mode indication

**`output`** - output 21-bit signal going to the input of the mux_21bit_2to1 (input b)

**`rst`** - reset (button `BTNC`)

**`send`** - sending a signal that is controlled by a button `BTNL`

**`sig_clk_100mhz`** - reduced clock

**`SW`** - switch `SW0` with which we select the sender (`SW0` in the up position)


**mux_21bit_2to1:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/mux_21bit_2to1.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/mux_21bit_2to1.png)

**`s_a`** - signal coming from shifter

**`s_b`** - signal coming from button_driver

**`s_f`** - output signal going to mux_driver

**`slc`** - signal, which controls which of the input signals is transferred to the output


**mux_driver:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/mux_driver.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/mux_driver.png)

**`input`** - input signal with original combination from mux_21bit_2to1

**`from output1 to output8`** - these are all combinations entered by the user for displaying on displays and for further sending

**`rst`** - reset (button `BTNC`)

**`sig_clk_100mhz`** - regular clock with a frequency of 100MHz


**driver_7seg_8dig:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8digits.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/driver_7seg_8digits.png)

**`sig_clk_100mhz`** - regular clock with a frequency of 100MHz

**`from sig_data1 to sig_data8 `** - these are all the combinations entered at the beginning by the user that came from the mux_driver and which need to be displayed on the 7-segment displays

**`sig_dig`** - 8-bit signal that tells which of the 8 positions entered symbol will be

**`sig_rst`** - reset (button `BTNC`)

**`sig_seg`** - a 7-bit signal that tells which segments should be lit for a particular combination


**signal_sender:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/signal_sender.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/signal_sender.png)

**`from data1 to data8 `** - these are all the combinations entered at the beginning by the user that came from mux_driver and that need to be sent

**`led16_b`**, **`led16_g`** and **`led16_r`** - sending progress indication

**`input`** - output signal that comes to the pin `E16`

**`rst`** - reset (button `BTNC`)

**`send`** - sending which is carried out using a switch `SW1`

**`sig_clk_100mhz`** - reduced clock


**top:**

![https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.png](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/img/top.png)


**`btnc`** - reset (button `BTNC`)

**`btnd`** - a button with which the user sets a combination of dots and dashes

**`btnl`** - a button with which the user sends a combination for display on displays

**`sig_clk_100mhz`** - regular clock with a frequency of 100MHz

**`led16_b`**, **`led16_g`** and **`led16_r`** - sending progress indication

**`led17_b`**, **`led17_g`** and **`led17_r`** - indication of the time frame for the introduction of combinations and mode indication

**`led_sig`** - 

**`seg`** - a 7-bit signal that tells which segments should be lit for a particular combination

**`SW`** - switch `SW0` with which we select the sender or the receiver

**`SW1`** - switch `SW1` with which the sending is carried out

## Instructions

**Instructions for using the Morse code receiver:**

**1.** Deactivate `SW0`(*down*);

**2.** Connect the input source to the pin `D14` (*for example generator*);

**3.** Start sending the signal, then everything will be automatically displayed as the input signal is processed.

**Instructions for using the morse code sender:**

**1.** Activate `SW0` (*up*);

**2.** Make sure that the left RGB LED is green. This means that everything is in working mode;

**3.** To enter a point, short press the bottom button `BTND` (the RGB LED will turn red);

**4.** To enter a dash, continue to hold the bottom button `BTND` (the RGB LED will turn blue);

**5.** To enter a new dot or dash, release the button `BTND` and return to step 2(the RGB LED will turn green);

**6.** Press the left button `BTNL` to send the symbol you just typed and to display your combination on display (the letter or number you specified should appear);

**7.** If you want to continue entering symbols without deleting the previous combination, then repeat steps 2-6;

**8.** If you want to reset all symbols (so that the display becomes blank), then press the button in the middle `BTNC` (*reset*);

**9.** To enter new combinations, repeat steps 2-6;

**10.** Activate `SW1` (*up*) to send your message (at the beginning, the right RGB LED will turn red, which indicates the sending process. When the right RGB LED turns green, this means your message has been sent).

## Video demonstration
Demonstration of the `"receiver"` mode

[Watch a video](https://www.youtube.com/shorts/d-faGH0KTpc)

Demonstration of the `"sender"` mode

[Watch a video](https://www.youtube.com/watch?v=6ZALID0tZt0)

## References

1. [Reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board
2. [Morse code](https://en.wikipedia.org/wiki/File:International_Morse_Code.svg) for letters encryption
3. [General information](https://github.com/dmitrii-semenov/morse-coder-decoder/blob/main/video/morse-receiver.gif) about Morse code
