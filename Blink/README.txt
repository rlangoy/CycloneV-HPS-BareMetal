Hello01
======================

Makes a .bin file that could be uploaded using u-Boot 
        to a CycloneV Soc board (ie DE0-NANO-SoC) and display Hello World  using the serial uart

HW-DOC
=======
Hardware info of the Cyclon-V HPS system is found in the:
	Cyclone V Hard Processor System
	Technical Reference Manual
https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_54001.pdf


BUILD REQUIREMENTS
===================

Build requirements for Ubuntu 20.04.1 (should work for most debian
installation on x86 platfom)

Install ARM Cross-Compiler:

   Refresh list of software available
      sudo apt-get update

   Install the ARM Cross-Compiler using 
      sudo apt-get install gcc-arm-linux-gnueabihf

BUILD 
======

The hello01.bin file is compiled using make :)


UPLOAD AND RUNNING USING U-BOOT
===============================

hello01.bin has its entrypoint / start address at: 0x10000

 a) Connect the "DE0-Nano or other INTEL / Cyclon-V SOC"  UART (USB) to the Computer.
 b)  use a serial terminal program to comunicate width the ZedBoard's UART 
        Windows:  
         ExtraPuTTY http://www.extraputty.com/download.php
         or Tera Term http://hp.vector.co.jp/authors/VA002416/teraterm.html )
        Linux:
           Start a new terminal
	   Install minicom:
              sudo apt-install minicom
	      minicom -D/dev/ttyACM0 -b115200 -o                 

 c) power on the DE0-Nano or other INTEL / Cyclon-V SOC board with SD card and Linux Immage installed  and wait for the message:
        Hit any key to stop autoboot:   
     and stop it by pressing a key :)


# Addresses stored in the ENV
#FPGA-Load info
#fpgadata=0x2000000
#fpgadatasize=0x700000
#Bridges info
#fpgaintf=ffd08028;
#fpgaintf_handoff=0x00000000;
#fpga2sdram_apply=3ff7d52c;
#fpga2sdram=ffc25080;
#fpga2sdram_handoff=0x00000000;
#axibridge=ffd0501c;
#axibridge_handoff=0x00000000;
#l3remap=ff800000;
#l3remap_handoff=0x00000019;
#Enable all bridges (busses)
#mw $fpgaintf ${fpgaintf_handoff}; go $fpga2sdram_apply; mw $fpga2sdram ${fpga2sdram_handoff}; mw $axibridge ${axibridge_handoff}; mw $l3remap ${l3remap_handoff}

#Load FPGA my_soc.rbf;
fatload mmc 0:1 ${fpgadata} my_soc.rbf;
#Program FPGA
fpga load 0 ${fpgadata} ${filesize};

#Enable all bridges (busses)
run bridge_enable_handoff

#Write to led
mw 0xff200000 0x0f 
#Read system ID
md 0xff210000

fatload mmc 0 0x10000 blink.bin;
go 0x10000




LICENSE
==========

Copyright (C) 2020  Rune Langoy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
