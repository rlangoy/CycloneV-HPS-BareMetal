ARMGNU ?= arm-linux-gnueabihf
COPS    =   
ARCH    = -mcpu=cortex-a9 -mfpu=vfpv3 
PF_CPPFLAGS_NO_UNALIGNED := $(call cc-option, -mno-alignment-traps,)
PLATFORM_CPPFLAGS += $(PF_CPPFLAGS_NO_UNALIGNED)


gcc : blink.bin

all : gcc clang

clean :
	rm -f *.o
	rm -f *.bin
	rm -f *.hex
	rm -f *.elf
	rm -f *.list
	rm -f *.img
	rm -f *.bc

clang: blink.bin

startup.o : startup.s
	$(ARMGNU)-as $(ARCH) startup.s -o startup.o

blink.o : blink.c
	$(ARMGNU)-gcc $(COPS) $(ARCH) -c blink.c -o blink.o

blink.bin : memmap.ld startup.o blink.o
	$(ARMGNU)-ld startup.o blink.o -T memmap.ld -o blink.elf
	$(ARMGNU)-objdump -D blink.elf > blink.list
	$(ARMGNU)-objcopy blink.elf -O ihex blink.hex
	$(ARMGNU)-objcopy blink.elf -O binary blink.bin
