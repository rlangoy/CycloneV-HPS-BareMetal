# CycloneV-HPS-BareMetal
Cyclone-V SOC bearbone ARM programming using U-BOOT

The program are tested on a DE0-NANO-SoC board but should be working for all Intel Cyclone-V SOC's.
The ARM CPU provided by the HPS (Hardware Process System) is programmed using UBOOT.
(The U-Boot is a normaly provided by the Linux image provided in the software/doc of the development board.) 

Programs :
.\Hello01 ->  Makes a .bin file that could be uploaded using u-Boot 
               to the Ze and displays "Hello World" using the serial uart


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
