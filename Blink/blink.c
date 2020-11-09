/*
    Cyclone V Hard Processor System
    Technical Reference Manual

    UART info could be found in
        22-1 UART Controller (UART) / Page 3069 in
           2018.07.17  cv_5v4
           Cyclone V Hard Processor System
           Technical Reference Manual

    https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_54001.pdf
*/

#pragma pack(1)  // Byte align the memory in the compiler

//Uart info se page 3082 in  section 22-1 in the Ref manual
#define UART0_BASE        0xFFC02000
#define RBR_THR_DLL_BASE  0x00
#define UART0_RBR_THR_DLL ((unsigned int *) (UART0_BASE + 0x00)) // Multi-function register. That holds the  transmit data

#define LW_HPS_FPGA_BRIDGE 0xFF200000  // The LWH2F (Light Weight Hardware to FPGA ) bridge  (Table 2-2 in section 2-16 in the Ref manual)

// Slave addresses is assigned in the Quartus Plaform Designes (QSYS)
#define POI_LED_BASE       0x00000000  // Base address of the LED's I/O ports
#define LEDS_OUT_REG ((unsigned int *) (LW_HPS_FPGA_BRIDGE + POI_LED_BASE))   // The address of the LED's

unsigned int  * const TxRxUART0 = UART0_RBR_THR_DLL;   // Assign address to the UART Rx and Tx register from the ARM side
unsigned int  * const FPGA_LED  = LEDS_OUT_REG;        // Assing address of the paralell I/O port connected to the LEDS from the ARM sidd


void print_uart1(const char *s)
{
    while(*s != '\0')
    {     /* Loop until end of string */
	 *TxRxUART0 = (unsigned int)(*s); /* Transmit char */
	 s++; /* Next char */
    }
}

void write_led(char value)
{
  *FPGA_LED=value;
}


void all_leds_on()
{
  write_led(0xff);
}

void all_leds_off()
{
 write_led(0x00);
}

void delay()
{
   long u=0;
   for(long i=0;i<1000000;i++)
     u=u+1;

}
void c_entry() 
{
  while(1)
  {
   print_uart1("\r\nTurn all Led's On!");
   all_leds_on();
   delay();
   all_leds_off();
   print_uart1("\r\nTurn all Led's Off!");
   delay();
  }
}
