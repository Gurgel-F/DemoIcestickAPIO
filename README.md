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
  Info: 	         ICESTORM_LC:   336/ 1280    26%
  Info: 	        ICESTORM_RAM:     0/   16     0%
  Info: 	               SB_IO:     6/  112     5%
  Info: 	               SB_GB:     2/    8    25%
  Info: 	        ICESTORM_PLL:     0/    1     0%
  Info: 	         SB_WARMBOOT:     0/    1     0%
```
 
 ## Credits
 * [APIO](https://github.com/FPGAwars/apio/), toolbox for FPGAs
 * verilog uart core [osdvu](https://github.com/cyrozap/osdvu/)
