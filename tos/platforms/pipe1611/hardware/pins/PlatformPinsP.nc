module PlatformPinsP @safe() {
  provides interface Init;
}
implementation {

  inline void uwait(uint16_t u) { 
    uint16_t t0 = TAR;
    while((TAR - t0) <= u);
  } 

  inline void TOSH_wait() {
    nop(); nop();
  }



  command error_t Init.init() {
    // reset all of the ports to be input and using i/o functionality
    atomic
      {
	P1SEL = 0;
	P2SEL = 0;
	P3SEL = 0x3E;
	P4SEL = 0;
	P5SEL = 0;
	P6SEL = 0;

	P1OUT = 0x08;
	P1DIR = 0x94;
 
	P2OUT = 0x00;
	P2DIR = 0xFF;

	P3OUT = 0xF1;
	P3DIR = 0x11;

	P4OUT = 0x00;
	P4DIR = 0xff;

	P5OUT = 0x00;
	P5DIR = 0x30;

	P6OUT = 0x00;
	P6DIR = 0x55;

	P1IE = 0;
	P2IE = 0;

	ME1 |= UTXE0 + URXE0;  // Enable USART0 TXD/RXD
	U0CTL = SYNC;

	// the commands above take care of the pin directions
	// there is no longer a need for explicit set pin
	// directions using the TOSH_SET/CLR macros

	// wait 10ms for the flash to startup
	//uwait(1024*10);

	

      }//atomic
    return SUCCESS;
  }
}
