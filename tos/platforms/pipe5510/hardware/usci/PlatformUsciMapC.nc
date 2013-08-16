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
 */

#include "msp430usci.h"

/**
 * Connect the appropriate pins for USCI support on a MSP430F5510
 *
 * @author Peter A. Bigot <pab@peoplepowerco.com>
 */

configuration PlatformUsciMapC {
} implementation {
  components HplMsp430GeneralIOC as GIO;

  components Msp430UsciUartA0P as UartA0C;
  UartA0C.URXD -> GIO.UCA0RXD;
  UartA0C.UTXD -> GIO.UCA0TXD;

  components Msp430UsciSpiB0P as SpiB0C;
  SpiB0C.SIMO -> GIO.UCB0SIMO;
  SpiB0C.SOMI -> GIO.UCB0SOMI;
  SpiB0C.CLK  -> GIO.UCB0CLK;

  components Msp430UsciSpiB1P as SpiB1C;
  SpiB1C.SIMO -> GIO.UCB1SIMO;
  SpiB1C.SOMI -> GIO.UCB1SOMI;
  SpiB1C.CLK  -> GIO.UCB1CLK;
 
}
