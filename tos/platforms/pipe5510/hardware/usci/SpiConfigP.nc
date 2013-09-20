#include "msp430usci.h"

/*
 * MM5, 5510, USCI, SPI
 * x5 usci configuration
 */

const msp430_usci_config_t spi_config = {
  /*
   * UCCKPH: 0,
   * UCCKPL: 0,
   * UCMSB:  1,
   * UC7BIT: 0,
   * UCMST:  1,
   * UCMODE: 0, // 3 pin SPI
   * UCSYNC: 1,
   * UCSSEL: SMCLK,
   */
  ctl0 : (UCMSB | UCMST | UCSYNC),
  ctl1 : UCSSEL__SMCLK,
  br0  : 2,			/* 8MHz -> 4 MHz */
  br1  : 0,
  mctl : 0,                     /* Always 0 in SPI mode */
};


module SpiConfigP {
  provides interface Msp430UsciConfigure;
}
implementation {
  async command const msp430_usci_config_t *Msp430UsciConfigure.getConfiguration() {
    return &spi_config;
  }
}
