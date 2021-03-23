# Demo Icestick APIO
Icestick demo using apio

## Steps to run 
 ```bash
 apio clean
 apio verify  
 apio build  
 apio upload 
 ```
 ## Notes
 uart module uses 2 stop bits
 
 use 
 ```bash
 apio build --verbose-pnr
 ```
 to get information about resource usage and routing
 ```
 Info: Device utilisation:
 Info: 	         ICESTORM_LC:   339/ 1280    26%
 Info: 	        ICESTORM_RAM:     0/   16     0%
 Info: 	               SB_IO:     8/  112     7%
 Info: 	               SB_GB:     4/    8    50%
 Info: 	        ICESTORM_PLL:     0/    1     0%
 Info: 	         SB_WARMBOOT:     0/    1     0%

```
 
 ## Description
 
 This demo application instantiates a uart and custom clock module, blinks all the red leds, the uart prints in response the crc8 of the last byte received
 
 ## Credits
 * [APIO](https://github.com/FPGAwars/apio/), toolbox for FPGAs
 * verilog uart core by [osdvu](https://github.com/cyrozap/osdvu/)
