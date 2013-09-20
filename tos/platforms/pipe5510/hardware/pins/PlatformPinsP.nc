/*
 * Copyright (c) 2009-2010 People Power Company
 * All rights reserved.
 *
 * This open source code was developed with funding from People Power Company
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

/**
 * @author David Moss
 * @author Peter A. Bigot <pab@peoplepowerco.com>
 * @author Caio Amaral <eng.caioamaral@gmail.com>
 */

module PlatformPinsP {
  provides interface Init;
}

implementation {
  int i;

  command error_t Init.init() {
    atomic {
	/**
	 * Port 1; Usage: <value><function><direction>
	 * Example 0pI: Low output, function port, input.
	 * 1.0 = 0pI | 1.1 = 0pI | 1.2 = 0pI | 1.3 = 1pO
	 * 1.4 = 0pI | 1.5 = 0pI | 1.6 = 0pI | 1.7 = 0pI
	 */
	P1OUT = 0x08;
	P1DIR = 0x88;

	/**
	 * Port 2; Usage: <value><function><direction>
	 * 2.0 = 0p0 (Vreg_en)
	 */
	P2OUT = 0x00;
	P2DIR = 0x01;
	
	/**
	 * Port 4; Usage: <value><function><direction>
	 * 4.0 = 1pO | 4.1 = 0pI | 4.2 = 0pI | 4.3 = 0pI
	 * 4.4 = 1pI | 4.5 = 1pI | 4.6 = 0pO | 4.7 = 0pO
	 */
	P4OUT = 0x31;
	P4DIR = 0xD1;

	/**
	 * Port 5; Usage: <value><function><direction>
	 * 5.0 = 0pI | 5.1 = 0pO 
	 */

	P5OUT = 0x00;
	P5DIR = 0x02;
      
	// Port mapping (Caio)     
	PMAPPWD = PMAPPW;                         // Get write-access to port mapping regs
//     	P1MAP5 = PM_UCA1RXD;                      // Map UCA1RXD output to P1.5
//     	P1MAP4 = PM_UCA1TXD;                      // Map UCA1TXD output to P1.6
   	P4MAP1 = PM_UCB1SIMO;			  // Map UCB1SIMO output to P4.1
	P4MAP2 = PM_UCB1SOMI;			  // Map UCB1SOMI output to P4.2
	P4MAP3 = PM_UCB1CLK;   			  // Map UCB1CLK output to P4.3
	PMAPPWD = 0;                              // Lock port mapping registers


    }
    return SUCCESS;
  }
}
