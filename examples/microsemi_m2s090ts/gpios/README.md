# Description

This example shows how to use DIP switches, push-buttons and LEDs.
* 4 DIP switches (SW5) and 4 push-buttons (SW1..4) drives the 8 active low LEDs.

# How to run synthesis, implementation and programming

* For the used FPGA, Libero-Soc (this example use version 11.7) with a valid license is needed.
* Prepare the environment to use Libero-SoC.
* Run synthesis, implementation and bitstream generation:
```
$ make run
```
* Run programing (or use FlashPro):
```
$ make prog
```

# How to test on hardware

* Change SW1..5 to see how the LEDs changes its state.
