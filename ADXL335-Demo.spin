{
---------------------------------------------------------------------------------------------------
    Filename:       ADXL335-Demo.spin
    Description:    Demo of the ADXL335 driver
        * 3DoF data output
    Author:         Jesse Burt
    Started:        Jun 22, 2024
    Updated:        Jun 22, 2024
    Copyright (c) 2024 - See end of file for terms of use.
---------------------------------------------------------------------------------------------------
}

#define ADC_DRIVER "signal.adc.mcp320x"
#pragma exportdef(ADC_DRIVER)


CON

    _clkmode    = cfg._clkmode
    _xinfreq    = cfg._xinfreq


OBJ

    cfg:    "boardcfg.flip"
    time:   "time"
    sensor: "sensor.accel.3dof.adxl335"
    ser:    "com.serial.terminal.ansi" | SER_BAUD=115_200
    adc:    "signal.adc.mcp320x" | CS=0, SCK=1, MOSI=2, MISO=3, MODEL=3208


PUB main()

    ser.start()
    time.msleep(30)
    ser.clear()
    ser.strln(@"Serial terminal started")

    if ( adc.start() )
        ser.strln(@"ADC started")
    else
        ser.strln(@"ADC driver failed to start - halting")
        repeat

    adc.set_ref_voltage(3_265000)               ' set ADC's voltage reference (measure w/DMM)

    sensor.attach_adc(@adc)                     ' bind/attach to the ADC driver
    sensor.start()                              ' set scaling, clear bias

    repeat
        ser.pos_xy(0, 3)
        if ( ser.getchar_noblock() == "c" )     ' press 'c' during the demo to set DC-offset/bias
            cal_accel()                         '   (chip package should be facing upwards)
        show_accel_data()


#include "acceldemo.common.spinh"

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

