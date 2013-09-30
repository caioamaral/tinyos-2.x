/*
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 * - Neither the name of the Technische Universitaet Berlin nor the names
 *   of its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * - Revision -------------------------------------------------------------
 * $Revision: 1.5 $
 * $Date: 2008-05-22 17:45:00 $
 * @author: Jan Hauer <hauer@tkn.tu-berlin.de>
 * @author: Caio Amaral <eng.caioamaral@gmail.com> (edited)
 * ========================================================================
 */
        
/**
 * The HplAdc10 interface exports low-level access to the ADC10 registers
 * of the MSP430 MCU.
 *
 * @author Jan Hauer
 * @see  Please refer to TEP 101 for more information about this component and its
 *          intended use.
 */
#include <Msp430Adc10.h>
interface HplAdc10
{
  /** 
   * Sets the ADC10 control register ADC10CTL0.
   * @param control0 ADC10CTL0 register data.
   **/
  async command void setCtl0(adc10ctl0_t control0); 
  
  /** 
   * Sets the ADC10 control register ADC10CTL1. 
   * @param control1 ADC10CTL1 register data.
   **/
  async command void setCtl1(adc10ctl1_t control1);

  /** 
   * Returns the ADC10 control register ADC10CTL0.
   * @return ADC10CTL0
   **/
  async command adc10ctl0_t getCtl0(); 

  /** Returns the ADC10 control register ADC10CTL1. 
   *  @return ADC10CTL1
   **/
  async command adc10ctl1_t getCtl1(); 
  
  /** 
   * Sets the ADC10 conversion memory control register ADC10MCTLx.
   * @param idx The register index (the 'x' in ADC10MCTLx) [0..15] 
   * @param memControl ADC10MCTLx register data.
   */
  async command void setMCtl(uint8_t idx, adc10memctl_t memControl); 
  
  /** 
   * Returns the ADC10 conversion memory control register ADC10MCTLx.
   * @param idx The register index (the 'x' in ADC10MCTLx) [0..15] 
   * @return memControl ADC10MCTLx register data.
   */
  async command adc10memctl_t getMCtl(uint8_t idx); 

  /** 
   * Returns the ADC10 conversion memory register ADC10MEMx.
   * @param idx The register index (the 'x' in ADC10MEMx) [0..15] 
   * @return ADC10MEMx 
   */  
  async command uint16_t getMem(uint8_t idx); 

  /** 
   * Sets the ADC10 interrupt enable register, ADC10IE.
   * @param mask Bitmask (0 means interrupt disabled, 1 menas interrupt enabled) 
   */
  async command void setIEFlags(uint16_t mask); 

  /** 
   * Returns the ADC10 interrupt enable register, ADC10IE.
   * @return ADC10IE
   */  
  async command uint16_t getIEFlags(); 
  
  /** 
   * Resets the ADC10 interrupt flag register, ADC10IFG.
   */
  async command void resetIFGs(); 

  /** 
   * Signals a conversion result. 
   * @param iv ADC10 interrupt vector value 0x6, 0x8, ... , 0x24
   */ 
  async event void conversionDone(uint16_t iv);

  /** 
   * Returns the ADC10 BUSY flag.
   * @return ADC10BUSY 
   */ 
  async command bool isBusy();

  /**
   * Stops a conversion.
   */
  async command void stopConversion();

  /**
   * Starts a conversion.
   */
  async command void startConversion();

  /**
   * Enables conversion (sets the ENC bit).
   */
  async command void enableConversion();

}

