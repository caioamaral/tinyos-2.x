/*
 * Copyright (c) 2013, Eric B. Decker
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
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
 * @author Eric B. Decker <cire831@gmail.com>
 *
 * Set up wiring and code for SFD capture for the CC2520EM module.
 * SFD is connected to P8.1 on the eval_5438/CC2520EM mote.  P8.1 is
 * captured via TA0.CCI1B and is controlled by TA0CCTL1.   And
 * the captured time shows up in TA0CCR1.
 *
 * See tos/platforms/mm5s/hardware/cc2520/HplCC2520C for details of
 * nesc wiring.
 */

module P12SfdCaptureC {
  provides interface GpioCapture as Capture;
  uses {
    interface Msp430TimerControl;
    interface Msp430Capture;
    interface HplMsp430GeneralIO as GeneralIO;
  }
}

implementation {

  error_t enableCapture( uint8_t mode ) {
    atomic {
      call Msp430TimerControl.disableEvents();
      call GeneralIO.makeInput();                               /* for capture to work must be input */
      call GeneralIO.selectModuleFunc();                        /* and must be assigned to the Module */

      /*
       * setControlAsCapture clears out both CCIE (pending Interrupt
       * as well as COV (overflow).
       */
      call Msp430TimerControl.setControlAsCapture( mode );
      call Msp430TimerControl.enableEvents();
    }
    return SUCCESS;
  }

  async command error_t Capture.captureRisingEdge() {
    return enableCapture( MSP430TIMER_CM_RISING );
  }

  async command error_t Capture.captureFallingEdge() {
    return enableCapture( MSP430TIMER_CM_FALLING );
  }

  async command void Capture.disable() {
    atomic {
      call Msp430TimerControl.disableEvents();
      call GeneralIO.selectIOFunc();
    }
  }

  async event void Msp430Capture.captured( uint16_t time ) {
    call Msp430TimerControl.clearPendingInterrupt();
    call Msp430Capture.clearOverflow();
    signal Capture.captured( time );
  }
}
