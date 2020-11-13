import devmem
# Pyhsical addresses
LPHS_BRIDGE                   = 0xff200000
CRC32_CALC_BASE               =    0x40000
CRC32_RESET_BASE= CRC32_CALC_BASE + 0x0004


#Read and diplay the 32bit content stored at the byte address  CRC32_RESET_BASE
def readCRC32Sum() :
        CRC32_CALC_ADDR=LPHS_BRIDGE+CRC32_CALC_BASE
        crc32CALCReg=devmem.DevMem(CRC32_CALC_ADDR,1,'/dev/mem',0)
        crc32Sum=crc32CALCReg.read(0,1)

        return crc32Sum.data[0]


print ("Curent CRC32 sum is: ", hex(readCRC32Sum()))

