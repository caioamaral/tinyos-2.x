/*
* Copyright (c) 2009-2010 People Power Co.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * @author Peter Bigot
 */

#ifndef _H_hardware_h
#define _H_hardware_h

#include "msp430hardware.h"

// enum so components can override power saving,
// as per TEP 112.
enum {
  TOS_SLEEP_NONE = MSP430_POWER_ACTIVE,
};

/* Use the PlatformAdcC component, and enable 8 pins */
//#define ADC12_USE_PLATFORM_ADC 1
//#define ADC12_PIN_AUTO_CONFIGURE 1
//#define ADC12_PINS_AVAILABLE 4

/* @TODO@ Disable probe for XT1 support until the anomaly observed in
 * apps/bootstrap/LocalTime is resolved. */
#ifndef PLATFORM_MSP430_HAS_XT1
#define PLATFORM_MSP430_HAS_XT1 1
#endif /* PLATFORM_MSP430_HAS_XT1 */

// Don't know if this is right, just testing
#define MSP430_HAS_ADC10 1

// LEDs
TOSH_ASSIGN_PIN(RED_LED, 4, 6);
TOSH_ASSIGN_PIN(GREEN_LED, 4, 7 )
TOSH_ASSIGN_PIN(YELLOW_LED, 5, 1);

// CC2520 RADIO #defines
TOSH_ASSIGN_PIN(RADIO_CSN, 4, 0);
TOSH_ASSIGN_PIN(RADIO_VREF, 1, 7);
TOSH_ASSIGN_PIN(RADIO_RESET, 1, 1);
TOSH_ASSIGN_PIN(RADIO_FIFOP, 1, 5);
TOSH_ASSIGN_PIN(RADIO_SFD, 1, 2);
TOSH_ASSIGN_PIN(RADIO_GIO0, 1, 3);
TOSH_ASSIGN_PIN(RADIO_FIFO, 1, 4);
TOSH_ASSIGN_PIN(RADIO_GIO1, 1, 4);
TOSH_ASSIGN_PIN(RADIO_CCA, 1, 6);

TOSH_ASSIGN_PIN(CC_FIFOP, 1, 5);
TOSH_ASSIGN_PIN(CC_FIFO, 1, 4);
TOSH_ASSIGN_PIN(CC_SFD, 1, 2);
TOSH_ASSIGN_PIN(CC_VREN, 1, 7);
TOSH_ASSIGN_PIN(CC_RSTN, 1, 1);

#endif // _H_hardware_h
