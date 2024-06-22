{
----------------------------------------------------------------------------------------------------
    Filename:       sensor.accel.3dof.adxl335
    Description:    Driver for Analog Devices ADX335 analog 3DoF accelerometer
    Author:         Jesse Burt
    Started:        Jun 22, 2024
    Updated:        Jun 22, 2024
    Copyright (c) 2024 - See end of file for terms of use.
----------------------------------------------------------------------------------------------------

    NOTE: This driver requires an external ADC driver to operate (minimum 3 channels).

}

#include "sensor.accel.common.spinh"            ' use code common to all accelerometer drivers


CON

    CAL_XL_SCL  = 3
    CAL_XL_DR   = 100

    ACCEL_DOF   = 3
    X_AXIS      = 0
    Y_AXIS      = 1
    Z_AXIS      = 2


VAR

    long _p_adc                                 ' pointer to ADC object


#ifndef ADC_DRIVER
#   define ADC_DRIVER "signal.adc.mcp320x"      ' default to the MCP320x driver if not specified
#endif

OBJ

    time:   "time"                              ' time-delay methods
    adc=    ADC_DRIVER                          ' "virtual" instance of ADC driver object


PUB attach_adc(p_adc)
' Attach an ADC driver
'   p_adc: pointer to an ADC object (e.g. accel.attach_adc(@adc) )
    _p_adc := p_adc


PUB start(): s
' Start the driver using default I/O settings
'   Returns: calling cog's ID+1
    accel_scale(3)
    accel_set_bias(0, 0, 0)
    time.msleep(1)

    return cogid + 1


PUB accel_bias(p_x, p_y, p_z)
' Read currently set DC-offset/bias
'   p_x, p_y, p_z: pointers to variables to store axis offsets
    long[p_x] := _abias[X_AXIS]
    long[p_y] := _abias[Y_AXIS]
    long[p_z] := _abias[Z_AXIS]


PUB accel_data(p_x, p_y, p_z)
' Get accelerometer data
'   p_x, p_y, p_z: pointers to variables to store accelerometer raw data (unscaled)
    adc[_p_adc].set_adc_channel(X_AXIS)
    long[p_x] := ( (adc[_p_adc].voltage() - _abias[X_AXIS]) )

    adc[_p_adc].set_adc_channel(Y_AXIS)
    long[p_y] := ( (adc[_p_adc].voltage() - _abias[Y_AXIS]) )

    adc[_p_adc].set_adc_channel(Z_AXIS)
    long[p_z] := ( (adc[_p_adc].voltage() - _abias[Z_AXIS]) )


PUB accel_data_rate(r=-2): c
' dummy method (included only for API compatibility with other like drivers)


PUB accel_data_rdy(): f
' Flag indicating new accelerometer data is ready (dummy method)
'   Returns: TRUE (-1)
    return true


PUB accel_scale(s=-2): c
' Set accelerometer full-scale range (dummy method)
    _ares := 3                                  ' 3.33 per LSB
    return 3                                    ' 3.6g


PUB accel_set_bias(bx=0, by=0, bz=0)
' Set accelerometer DC-offset/bias
'   bx, by, bz: offset in microvolts
    longmove(@_abias, @bx, ACCEL_DOF)


DAT
{
Copyright 2024 Jesse Burt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

