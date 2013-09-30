/*
 * Copyright (c) 2011, Eric B. Decker
 * Copyright (c) 2004, Technische Universitaet Berlin
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
 * @author Jan Hauer <hauer@tkn.tu-berlin.de>
 * @author Eric B. Decker <cire831@gmail.com>
 * @see  Please refer to TEP 101 for more information about this component and its
 *          intended use.
 */

/**
 * The HplAdc10 interface exports low-level access to the ADC10 registers
 * of the MSP430 MCU.
 *
 * Older msp430 include files defined ADC_VECTOR (defined to be ADC10_VECTOR)
 * new includes (TI_HEADERS etc) don't define ADC_VECTOR.  Use the blessed
 * vector: ADC10_VECTOR.
 */

#if !defined(__MSP430_HAS_ADC10__) && !defined(__MSP430_HAS_ADC10_PLUS__)
#error "HplAdc10P: processor not supported, need ADC10"
#endif

module HplAdc10P {
  provides interface HplAdc10;
}
implementation
{
 
  MSP430REG_NORACE(ADC10CTL0);
  MSP430REG_NORACE(ADC10CTL1);
  MSP430REG_NORACE(ADC10IFG);
  MSP430REG_NORACE(ADC10IE);
  MSP430REG_NORACE(ADC10IV);

  DEFINE_UNION_CAST(int2adc10ctl0,adc10ctl0_t,uint16_t)
  DEFINE_UNION_CAST(int2adc10ctl1,adc10ctl1_t,uint16_t)
  DEFINE_UNION_CAST(adc10ctl0cast2int,uint16_t,adc10ctl0_t)
  DEFINE_UNION_CAST(adc10ctl1cast2int,uint16_t,adc10ctl1_t)
  DEFINE_UNION_CAST(adc10memctl2int,uint8_t,adc10memctl_t)
  DEFINE_UNION_CAST(int2adc10memctl,adc10memctl_t,uint8_t)
  
  async command void HplAdc10.setCtl0(adc10ctl0_t control0){
    ADC10CTL0 = adc10ctl0cast2int(control0); 
  }
  
  async command void HplAdc10.setCtl1(adc10ctl1_t control1){
    ADC10CTL1 = adc10ctl1cast2int(control1); 
  }
  
  async command adc10ctl0_t HplAdc10.getCtl0(){ 
    return int2adc10ctl0(ADC10CTL0); 
  }
  
  async command adc10ctl1_t HplAdc10.getCtl1(){
    return int2adc10ctl1(ADC10CTL1); 
  }
  
  async command void HplAdc10.setMCtl(uint8_t i, adc10memctl_t memCtl){
    ADC10MCTL[i] = adc10memctl2int(memCtl);
  }
   
  async command adc10memctl_t HplAdc10.getMCtl(uint8_t i){
    return int2adc10memctl(ADC10MCTL[i]);
  }  
  
  async command uint16_t HplAdc10.getMem(uint8_t i){
    return ADC10MEM[i];
  }

  async command void HplAdc10.setIEFlags(uint16_t mask){ ADC10IE = mask; } 
  async command uint16_t HplAdc10.getIEFlags(){ return ADC10IE; } 
  
  async command void HplAdc10.resetIFGs(){ 
    ADC10IV = 0; 
    ADC10IFG = 0;
  } 

  async command void HplAdc10.startConversion() {
    /*
     * Breakfast (jhu) does the enable on a single line
     * trunk does the following...  does it matter?
     * for now leave the trunk version.
     */
    ADC10CTL0 |= ADC10ON;
    ADC10CTL0 |= (ADC10SC | ADC10ENC);
  }

  async command void HplAdc10.stopConversion(){
    // stop conversion mode immediately, conversion data is unreliable
    uint16_t ctl1 = ADC10CTL1;
    ADC10CTL1 &= ~(ADC10CONSEQ0 | ADC10CONSEQ1);
    ADC10CTL0 &= ~(ADC10SC + ADC10ENC); 
    ADC10CTL0 &= ~(ADC10ON);
    ADC10CTL1 |= (ctl1 & (ADC10CONSEQ0 | ADC10CONSEQ1));
  }

  async command void HplAdc10.enableConversion(){ 
    ADC10CTL0 |= ADC10ENC; 
  }

  async command bool HplAdc10.isBusy(){ return (ADC10CTL1 & ADC10BUSY); }

  TOSH_SIGNAL(ADC10_VECTOR) {
    signal HplAdc10.conversionDone(ADC10IV);
  }
}
