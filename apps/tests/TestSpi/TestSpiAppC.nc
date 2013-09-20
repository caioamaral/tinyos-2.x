configuration TestSpiAppC {

}

implementation {
	components MainC, TestSpiC as App, LedsC, PlatformSpiC as SpiC, SpiConfigP;
	components new TimerMilliC() as Timer0;

	App.Boot -> MainC.Boot;


	App.SpiByte -> SpiC;
	App.Resource -> SpiC;
	App.SpiPacket -> SpiC;

  	SpiConfigP.Msp430UsciConfigure <- App.Msp430UsciConfigure;

	App.Leds -> LedsC;

	App.Timer0 -> Timer0;
}


