#ifndef _H_hardware_h
#define _H_hardware_h

#include "msp430hardware.h"

// enum so components can override power saving,
// as per TEP 112.
enum {
  TOS_SLEEP_NONE = MSP430_POWER_ACTIVE,
};

#define MSP430_HAS_ADC12 1

// LEDs
TOSH_ASSIGN_PIN(RED_LED, 6, 0);
TOSH_ASSIGN_PIN(GREEN_LED, 5, 4);
TOSH_ASSIGN_PIN(YELLOW_LED, 5, 5);

// CC2520 RADIO #defines
TOSH_ASSIGN_PIN(RADIO_CSN, 3, 0);
TOSH_ASSIGN_PIN(RADIO_VREN, 1, 5);
TOSH_ASSIGN_PIN(RADIO_RESET, 1, 3);
TOSH_ASSIGN_PIN(RADIO_FIFOP, 1, 6); 	//GPIO2
TOSH_ASSIGN_PIN(RADIO_SFD, 1, 1); 	//GPIO4
TOSH_ASSIGN_PIN(RADIO_GIO0, 1, 2); 	//GPIO0
TOSH_ASSIGN_PIN(RADIO_FIFO, 1, 4); 	//GPIO1
TOSH_ASSIGN_PIN(RADIO_GIO1, 1, 4); 	//GPIO1
TOSH_ASSIGN_PIN(RADIO_CCA, 1, 7); 	//GPIO3

TOSH_ASSIGN_PIN(CC_FIFOP, 1, 6); 	//GPIO2
TOSH_ASSIGN_PIN(CC_FIFO, 1, 4); 	//GPIO1
TOSH_ASSIGN_PIN(CC_SFD, 1, 1);		//GPIO4
TOSH_ASSIGN_PIN(CC_VREN, 1, 5);
TOSH_ASSIGN_PIN(CC_RSTN, 1, 3);


// UART pins
TOSH_ASSIGN_PIN(SOMI0, 3, 2);
TOSH_ASSIGN_PIN(SIMO0, 3, 1);
TOSH_ASSIGN_PIN(UCLK0, 3, 3);
TOSH_ASSIGN_PIN(UTXD0, 3, 4);
TOSH_ASSIGN_PIN(URXD0, 3, 5);
//TOSH_ASSIGN_PIN(UTXD1, 3, 6);
//TOSH_ASSIGN_PIN(URXD1, 3, 7);
//TOSH_ASSIGN_PIN(UCLK1, 5, 3);
//TOSH_ASSIGN_PIN(SOMI1, 5, 2);
//TOSH_ASSIGN_PIN(SIMO1, 5, 1);

// ADC
TOSH_ASSIGN_PIN(ADC0, 6, 3);
TOSH_ASSIGN_PIN(ADC1, 6, 5);
TOSH_ASSIGN_PIN(ADC2, 6, 7);
//TOSH_ASSIGN_PIN(ADC3, 6, 4);



// GIO pins
//TOSH_ASSIGN_PIN(GIO0, 2, 0);
//TOSH_ASSIGN_PIN(GIO1, 2, 1);
//TOSH_ASSIGN_PIN(GIO2, 2, 3);
//TOSH_ASSIGN_PIN(GIO3, 2, 6);


// PROGRAMMING PINS (tri-state)
//TOSH_ASSIGN_PIN(TCK, );
//TOSH_ASSIGN_PIN(PROG_RX, 1, 1);
//TOSH_ASSIGN_PIN(PROG_TX, 2, 2);

// need to undef atomic inside header files or nesC ignores the directive
#undef atomic

#endif // _H_hardware_h
