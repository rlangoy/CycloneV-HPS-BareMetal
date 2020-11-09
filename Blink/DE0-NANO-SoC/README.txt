Blink
======================
This is a program for the DE0-NANO-SoC borad programmed by the Blink/HW/my_soc.rbf
To demonstate how to make a c-program that controls the LEDS by accessing the PIO module


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

The blink.bin file is compiled using make :)


Requirement's
=============

The ARM CPU provided by the HPS (Hardware Process System) is programmed using U-BOOT.
The U-Boot is a normaly provided by the Linux image provided in the software/doc of the development board.
For DE0-NANO-SoC:
      Install the DE0-NANO-SoC Linux Image (with U-BOOT ) from http://download.terasic.com/downloads/cd-rom/de0-nano-soc/atlas/atlas_sdcard.zip
      Unzip atlas_sdcard.zip
      Install instruction for the .img file can be found at https://www.raspberrypi.org/documentation/installation/installing-images/



UPLOAD AND RUNNING USING U-BOOT
===============================

hello01.bin has its entrypoint / start address at: 0x10000

 a) Connect the "DE0-Nano or other INTEL / Cyclon-V SOC"  UART (USB) to the Computer.

 b) use a serial terminal program to comunicate width the Dev-Board UART
        Windows:
         ExtraPuTTY http://www.extraputty.com/download.php
         or Tera Term http://hp.vector.co.jp/authors/VA002416/teraterm.html )
        Linux:
           Start a new terminal
           Install minicom:
              sudo apt-install minicom
              minicom -D/dev/ttyACM0 -b115200 -o

 c) Copy the FPGA-programming file Blink/HW/my_soc.rbf to the SD-Card

 d) stop U-Boot and 
    1) Program the FPGA HW:
          #Load FPGA  from the SD-Card
          fatload mmc 0:1 ${fpgadata} my_soc.rbf;
          #Program FPGA
          fpga load 0 ${fpgadata} ${filesize};
    2) Enable the FPGA to ARM (HPS) bridges
           #Enable all bridges (busses)
           run bridge_enable_handoff

    3) (Optional check HW before running)
            #Write to leds (4 leds off and 4 leds on)
            mw 0xff200000 0x0f
            #Read system ID (ff210000: 12abcdef)
            md 0xff210000

    4) Run the program
            #Load blink.bin from SD-card and run
            fatload mmc 0 0x10000 blink.bin;
            go 0x10000

U-BOOT enviromental valiables
##############################
SOCFPGA_CYCLONE5 # env print
axibridge=ffd0501c
axibridge_handoff=0x00000000
baudrate=115200
bootargs=console=ttyS0,115200
bootcmd=run callscript;run mmcload;run bridge_enable_handoff;run mmcboot
bootdelay=5
bootimage=zImage
bootimagesize=0x600000
bridge_disable=mw $fpgaintf 0; mw $fpga2sdram 0; go $fpga2sdram_apply; mw $axibridge 0; mw $l3remap 0x1
bridge_enable_handoff=mw $fpgaintf ${fpgaintf_handoff}; go $fpga2sdram_apply; mw $fpga2sdram ${fpga2sdram_handoff}; mw $axibridge ${axibridge_handoff}; mw $l3remap ${l3remap_handoff}
callscript=if fatload mmc 0:1 $fpgadata $scriptfile;then source $fpgadata; else echo Optional boot script not found. Continuing to boot normally; fi;
ethact=mii0
fdtaddr=0x00000100
fdtimage=socfpga.dtb
fdtimagesize=0x5000
fpga=0
fpga2sdram=ffc25080
fpga2sdram_apply=3ff7d52c
fpga2sdram_handoff=0x00000000
fpgadata=0x2000000
fpgadatasize=0x700000
fpgaintf=ffd08028
fpgaintf_handoff=0x00000000
l3remap=ff800000
l3remap_handoff=0x00000019
loadaddr=0x8000
micrel-ksz9021-clk-skew=0xf0f0
micrel-ksz9021-data-skew=0x0
mmcboot=setenv bootargs console=ttyS0,115200 root=${mmcroot} rw rootwait;bootz ${loadaddr} - ${fdtaddr}
mmcload=mmc rescan;${mmcloadcmd} mmc 0:${mmcloadpart} ${loadaddr} ${bootimage};${mmcloadcmd} mmc 0:${mmcloadpart} ${fdtaddr} ${fdtimage}
mmcloadcmd=fatload
mmcloadpart=1
mmcroot=/dev/mmcblk0p2
netboot=dhcp ${bootimage} ; tftp ${fdtaddr} ${fdtimage} ; run ramboot
qspiboot=setenv bootargs console=ttyS0,115200 root=${qspiroot} rw rootfstype=${qspirootfstype};bootz ${loadaddr} - ${fdtaddr}
qspibootimageaddr=0xa0000
qspifdtaddr=0x50000
qspiload=sf probe ${qspiloadcs};sf read ${loadaddr} ${qspibootimageaddr} ${bootimagesize};sf read ${fdtaddr} ${qspifdtaddr} ${fdtimagesize};
qspiloadcs=0
qspiroot=/dev/mtdblock1
qspirootfstype=jffs2
ramboot=setenv bootargs console=ttyS0,115200;bootz ${loadaddr} - ${fdtaddr}
scriptfile=u-boot.scr
setenv_ethaddr_eeprom=3ff9d08d
stderr=serial
stdin=serial
stdout=serial
verify=n


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
