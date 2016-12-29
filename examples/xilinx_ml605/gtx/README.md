# Description

* Simple example about how to use a GigaBit Transciver (GTX) on ml605.
* It uses 8b10b and 16 data bits.
* The DIP switches drives the GPIO LEDS trougth a gtx configured with a loopback.

# Useful documents

* Virtex-6 FPGA GTX Transceivers User Guide (UG366)

# How to obtain resources

Run Coregen (example with ISE 14.7) and:
* Generate a New Project for Virtex6, xc6vlx240t, ff1156, -1. Design entry: VHDL.
* Navigate: FPGA Features and Design -> IO Interfaces.
* Run "Virtex-6 FPGA GTX Transceiver Wizard".

Virtex-6 FPGA GTX Transceiver Wizard:
* Page1:
  * Component Name=v6
  * Template=Start from scratch
  * TX=RX:
    * Line Rate: 3 Gbps
    * Data Path Width: 16
    * Encoding 8b/10b
    * Reference Clock: 150 MHz (200 MHz is not a an option)
* Page2:
  * Uncheck 'Use GTX X0Y0'
  * Check 'Use GTX X0Y18'
    * TX Clock Source: use rx pll
    * RX Clock Source: GREFCLK (in a real app, a REFCLKx must be used)
* Page3:
  * Uncheck: RXCOMMADET
  * Align to... Even Byte Boundaries
  * Check: RXBYTEISALIGNED
* Page4:
  * Main driver differential swing -> "0000"
  * Wideband/Highpass Ratio -> "000"
  * Uncheck: Synchronous Application
* Page4, 5, 6 y 7:
  * No changes.
* Generate

It generates several files and a directory called v6 (the selected component name).
* I only use v6_gtx.vhd from root directory.
* It was moved to resources.
* v6/example_design/v6_top.ucf was useful to see how to specify the used gtx.

Additionaly, a MMCM was needed to obtain 150 MHz from 200 MHz.
* A wrapper was put in resources.
* See mmcm example for this same board to know how to obtain one using coregen.
* See comments about MMCM at the bottom of this document.

# How to use resources

* See wrapper.vhdl.
* txoutclk is used to drive txusrclk2 and rxusrclk2 trough IBUFG.
* If 4 byte of data are used, two clocks are derived from txoutclk (using a MMCM).
* The useful ports are tx_data, tx_isk, rx_data, rx_isk and ready.
* When a byte of data is a K character, the corresponding isk bit must be 1.

# How to simulate

The testbench are only stimulus to see waveforms.

* For the used FPGA, ISE Design Suite (this example use version 14.7) with a valid license is needed.
* Prepare the environment to use ISE Isim. For example, run:
```
$ . /PATH_TO_ISE/ISE_DS/settings64.sh
```
* Enter to testbench directory
```
$ cd testbench
```
* Compiling
```
$ make
```
* See waveforms:
```
$ make see
```

See how when rxbyteisaligned is '1', the values in txdata and txcharisk arrive to rxdata and rxcharisk.

# How to run synthesis, implementation and programming

* For the used FPGA, ISE Design Suite (this example use version 14.7) with a valid license is needed.
* Prepare the environment to use ISE. For example, run:
```
$ . /PATH_TO_ISE/ISE_DS/settings64.sh
```
* Run synthesis, implementation and bitstream generation:
```
$ make bit
```
* Run programing (if fpga_helpers is installed):
```
$ make prog-fpga
```
* Or use impact:
```
$ impact
```

# How to test on hardware

* Change SW1.1..8 to see how the corresponding GPIO LED change its state.

# Comments


* When generated, resource/mmcm.vhd had the values:
```
...
DIVCLK_DIVIDE        => 8,
CLKFBOUT_MULT_F      => 39.000,
CLKOUT0_DIVIDE_F     => 6.500,
...
```
* Clock out must had a period of 6.67 ns (150 MHz). However, in simulation, it had 7.18 ns.
* I calculated and changed the values on resource/mmcm.vhd to (avoiding decimal values):
```
...
DIVCLK_DIVIDE        => 2,
CLKFBOUT_MULT_F      => 6.0,
CLKOUT0_DIVIDE_F     => 4.0,
...
```
* The period is the corrected after that.

* In ml605.ucf there are examples of clock constraints. It is not absolutely needed in this example, but good practice for a real app.