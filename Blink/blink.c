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

#pragma pack(1)
#define UART0_BASE 0xFFC02000   //Page  3082
//#define UART0_BASE 0xFF200000   //Page  3082
#define UART0_RBR_THR_DLL ((unsigned int *) (UART0_BASE + 0x00)) // Multi-function register. That holds the  transmit data

#define LW_FPGA_SLAVE_BASE 0xFF200000
#define LEDS_OUT_REG ((unsigned int *) (LW_FPGA_SLAVE_BASE + 0x00))

//volatile unsigned int  * const TxRxUART0 = UART0_RBR_THR_DLL;
//volatile unsigned int  * const FPGA_LED  = LEDS_OUT_REG;

unsigned int  * const TxRxUART0 = UART0_RBR_THR_DLL;
unsigned int  * const FPGA_LED  = LEDS_OUT_REG;

volatile unsigned char* slave_addr = (unsigned char*) 0xFF200000;  // the  offset of led_pio component in Qsys is 0x0 so it can be ignored



void print_uart1(const char *s) 
{
    while(*s != '\0') 
    {     /* Loop until end of string */
	 *TxRxUART0 = (unsigned int)(*s); /* Transmit char */
	 s++; /* Next char */
    }
}

void write_led(const char ledValue)
{
  
//  int volatile * const led_reg = (int *) 0xFF200000
//  *led_reg=(int) 0x00;
}


void led_on()
{
//  write_led(0xff);
//   unsigned int orgLedState=*FPGA_LED;
//     *FPGA_LED_DDR = 0x000000ff;
     *slave_addr    = (char) 0xff;

//  volatile unsigned int * led_reg = (int *) 0xFF200000
//  *led_reg=(unsigned volatile int) 0xff;
}

void led_off()
{
// unsigned int orgLedState=*FPGA_LED;
// *FPGA_LED=orgLedState & 0xffffff00;
// write_led(0x00);slave_addr
//   *FPGA_LED_DDR = (char *) 0xff;
     *slave_addr     = (char) 0x00;
//  volatile unsigned int * led_reg = (int *) 0xFF200000
//  *led_reg=(unsigned volatile int) 0xff;
 
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
   print_uart1("\r\nLed's On!");
   led_on();
   delay();
   led_off();
   print_uart1("\r\nLed's Off!");
   delay();
  }
}
