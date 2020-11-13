CRC32 Memory mapped core
========================

Implementation of "Avalon memory mapped" CRC32 - ip from https://bues.ch/cms/hacking/crcgen (https://github.com/mbuesch/crcgen)
using DE0-Nano-SoC

File Structure:
	.\DE0-NANO-SoC   <- Files for building the DE0-Nano-SoC HPS system with CRC32 Module and LED paralell output
	    HW\DE0_Nano_SoC_CRC32.qar  <- Quartus 20.1 Project archive (Unpack using quartus in this folder)
	    HW\ip\CRC32                <- CRC32 QSys-compoent source (verilog and testench +.tlc sctipt)
	    
	.\Linux          <- Files for testing the memorymapped CRC32 module using Python
	    SW\testCRC32Sum.py      <- Simple test prog for generating CRC32 checksum
	    SW\hwCRC32SpeedTest.py  <- Benchmark/speedtest of HW CRC32 checksum generation
	    SW\swCRC32SpeedTest.py  <- Benchmark/speedtest of SW CRC32 checksum generation
	
	
 
 
 
 

