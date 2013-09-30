/* 
 * Copyright (c) 2006, Technische Universitaet Berlin
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
 * $Revision: 1.6 $
 * $Date: 2008-06-11 00:42:13 $
 * @author: Jan Hauer <hauer@tkn.tu-berlin.de>
 * ========================================================================
 */

/** 
 * This component virtualizes access to the HAL of the MSP430 ADC10.  
 * 
 * @author Jan Hauer 
 *
 * @see  Please refer to the README.txt and TEP 101 for more information about
 * this component and its intended use.
 */
#include <Msp430Adc10.h>
generic configuration Msp430Adc10ClientC()
{
  provides {
    interface Resource;
    interface Msp430Adc10SingleChannel;
    interface Msp430Adc10MultiChannel;
    interface Msp430Adc10Overflow;
  }
} implementation {
  components Msp430Adc10P;
   
  enum {
    ID = unique(MSP430ADC10_RESOURCE),
  };
  Resource = Msp430Adc10P.Resource[ID];
  Msp430Adc10SingleChannel = Msp430Adc10P.SingleChannel[ID];
  Msp430Adc10MultiChannel = Msp430Adc10P.MultiChannel[ID];
  Msp430Adc10Overflow = Msp430Adc10P.Overflow[ID];
}
