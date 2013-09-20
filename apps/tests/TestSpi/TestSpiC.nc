#include "Timer.h"

module TestSpiC {
	uses {
		interface Leds;
		interface Boot;
		interface SpiByte;
		interface Resource;
		interface SpiPacket;
		interface Timer<TMilli> as Timer0;
		interface SplitControl;
		interface Msp430UsciConfigure;
	}
}
implementation {
	//#define PERIOD 500	

	uint8_t* txBuf;
	uint8_t* rsBuf;
	uint16_t len;
	

	event void Boot.booted() {
		call Timer0.startPeriodic( 250 );
	}


	event void Timer0.fired() {
		dbg("TestSpiC", "Timer 0 fired @ %s.\n", sim_time_string());
		call Leds.led0Toggle();
	}

	async event void SpiPacket.sendDone(uint8_t* txBuf, uint8_t* rxBuf, uint16_t len, error_t error) {
		if(error == SUCCESS) {
			call Leds.led2Toggle();
		//	call Timer0.StartOneShot(PERIOD);
		}
		else{
			call Leds.led1Toggle();
		}
	}


	event void Resource.granted(){

	}
	event void SplitControl.startDone(error_t err) {
		if(TOS_NODE_ID == 0) {
			call SpiPacket.send( uint8_t* txBuf, uint8_t* rxBuf, uint16_t len );
		}
	}

	event void SplitControl.stopDone(error_t err) {
	}







/*


  message_t syncMsg;


 


  event void AMSend.sendDone(message_t* msg, error_t error) {
    if(error == SUCCESS) {
      call Leds.led2Toggle();
      call MilliTimer.startOneShot(PERIOD);
    }
  }

  event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
    call Leds.led2Toggle();
    call MilliTimer.startOneShot(PERIOD);
    return msg;
  }


*/
}




