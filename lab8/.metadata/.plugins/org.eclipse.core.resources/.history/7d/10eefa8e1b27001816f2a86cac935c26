//io_handler.c
#include "io_handler.h"
#include <stdio.h>

void IO_init(void)
{
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
	*otg_hpi_r = 1;
	*otg_hpi_w = 1;
	*otg_hpi_address = 0;
	*otg_hpi_data = 0;
	// Reset OTG chip
	*otg_hpi_cs = 0;
	*otg_hpi_reset = 0;
	*otg_hpi_reset = 1;
	*otg_hpi_cs = 1;
}

void IO_write(alt_u8 Address, alt_u16 Data)
{
	//set the address we want with the Data given
	otg_hpi_address = Address;
	otg_hpi_cs = 0;
	otg_hpi_w = 0;
	*otg_hpi_data = Data;

	//reset signals
	otg_hpi_cs = 1;
	otg_hpi_w = 1;
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
}

alt_u16 IO_read(alt_u8 Address)
{
	alt_u16 temp;
	//set the address we want.
	otg_hpi_address = Address;
	otg_hpi_cs = 0;
	otg_hpi_r = 0;

	//grab data
	temp = *otg_hpi_data;

	//reset signals
	otg_hpi_cs = 1;
	otg_hpi_r = 1;
//*************************************************************************//
//									TASK								   //
//*************************************************************************//
//							Write this function							   //
//*************************************************************************//
	//printf("%x\n",temp);
	return temp;
}
