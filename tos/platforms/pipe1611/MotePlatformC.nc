module MotePlatformC @safe() {
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
	P3SEL = 0;
	P4SEL = 0;
	P5SEL = 0;
	P6SEL = 0;

	P1OUT = 0x00;
	P1DIR = 0xe0;
 
	P2OUT = 0x30;
	P2DIR = 0x7b;

	P3OUT = 0x00;
	P3DIR = 0xf1;

	P4OUT = 0xff;
	P4DIR = 0xff;

	P5OUT = 0xff;
	P5DIR = 0xff;

	P6OUT = 0x00;
	P6DIR = 0xff;

	P1IE = 0;
	P2IE = 0;

	// the commands above take care of the pin directions
	// there is no longer a need for explicit set pin
	// directions using the TOSH_SET/CLR macros

	// wait 10ms for the flash to startup
	uwait(1024*10);
	// Put the flash in deep sleep state
	//TOSH_FLASH_M25P_DP();

      }//atomic
    return SUCCESS;
  }
}
