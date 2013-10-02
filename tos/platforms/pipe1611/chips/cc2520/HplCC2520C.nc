/*
 * Copyright (c) 2013 Eric B. Decker
 * Copyright (c) 2011 University of Utah. 
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

/**
 * @author Thomas Schmid
 * @author Eric B. Decker <cire831@gmail.com>
 */

#include <RadioConfig.h>

configuration HplCC2520C {
  provides {

    interface GeneralIO as CCA;
    interface GeneralIO as CSN;
    interface GeneralIO as FIFO;
    interface GeneralIO as FIFOP;
    interface GeneralIO as RSTN;
    interface GeneralIO as SFD;
    interface GeneralIO as VREN;
    interface GpioCapture as SfdCapture;
    interface GpioInterrupt as FifopInterrupt;
    interface GpioInterrupt as FifoInterrupt;

    interface SpiByte;
    interface SpiPacket;

    interface Resource as SpiResource;
    interface Init;

    interface Alarm<TRadio, uint16_t> as Alarm;
    interface LocalTime<TRadio> as LocalTimeRadio;
  }

}
implementation {
  components new Msp430Spi0C() as SpiC;
  SpiResource = SpiC;
  SpiByte     = SpiC;
  SpiPacket   = SpiC;

  components CC2520SpiConfigP;
  CC2520SpiConfigP.Msp430SpiConfigure <- SpiC;


  // pins

  components HplMsp430GeneralIOC as GeneralIOC;
  components new Msp430GpioC() as CCAM;
  components new Msp430GpioC() as CSNM;
  components new Msp430GpioC() as FIFOM;
  components new Msp430GpioC() as FIFOPM;
  components new Msp430GpioC() as RSTNM;
  components new Msp430GpioC() as SFDM;
  components new Msp430GpioC() as VRENM;

  CCAM   -> GeneralIOC.Port17;
  CSNM   -> GeneralIOC.Port30;
  FIFOM  -> GeneralIOC.Port14; 
  FIFOPM -> GeneralIOC.Port16;
  RSTNM  -> GeneralIOC.Port13;
  SFDM   -> GeneralIOC.Port11;
  VRENM  -> GeneralIOC.Port15;
  
  CCA   = CCAM;
  CSN   = CSNM;
  FIFO  = FIFOM;
  FIFOP = FIFOPM;
  RSTN  = RSTNM;
  SFD   = SFDM;
  VREN  = VRENM;



  // capture
  components Msp430TimerC as TimerC;
  components new GpioCaptureC();
  GpioCaptureC.Msp430TimerControl -> TimerC.ControlA0;
  GpioCaptureC.Msp430Capture -> TimerC.CaptureA0;
  GpioCaptureC.GeneralIO -> GeneralIOC.Port11;
  SfdCapture = GpioCaptureC;

  components new Msp430InterruptC() as FifoInterruptC, HplMsp430InterruptC;

  FifoInterruptC.HplInterrupt -> HplMsp430InterruptC.Port14;
  FifoInterrupt = FifoInterruptC.Interrupt; 

  components new Msp430InterruptC() as FifopInterruptC;
  FifopInterruptC.HplInterrupt -> HplMsp430InterruptC.Port16;
  FifopInterrupt = FifopInterruptC.Interrupt; 

  // alarm
  components new Alarm32khz16C() as AlarmC;
  Alarm = AlarmC;
  Init = AlarmC;

  // localTime
  components LocalTime32khzC;
  LocalTimeRadio = LocalTime32khzC.LocalTime;

}
