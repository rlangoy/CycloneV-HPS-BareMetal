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


#define UART0_BASE 0xFFC02000   //Page  3082
#define UART0_RBR_THR_DLL ((unsigned int *) (UART0_BASE + 0x00)) // Multi-function register. That holds the  transmit data 

volatile unsigned int * const TxRxUART0 = UART0_RBR_THR_DLL;

void print_uart1(const char *s) 
{
    while(*s != '\0') 
    {     /* Loop until end of string */
	 *TxRxUART0 = (unsigned int)(*s); /* Transmit char */
	 s++; /* Next char */
    }
}
static const char outPutString[] = "\r\nHello world!";

void c_entry()
{
   print_uart1(outPutString);
   while(1) ; /*dont exit the program*/
}
