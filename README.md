# adxl335-spin
--------------

This is a P8X32A/Propeller, P2X8C4M64P/Propeller 2 driver object for the Analog Devices ADXL335

**IMPORTANT**: This software is meant to be used with the [spin-standard-library](https://github.com/avsa242/spin-standard-library) (P8X32A) or [p2-spin-standard-library](https://github.com/avsa242/p2-spin-standard-library) (P2X8C4M64P). Please install the applicable library first before attempting to use this code, otherwise you will be missing several files required to build the project.


## Salient Features

* Application-level binding to any compatible ADC driver
* Read sensor acceleration in micro-g's or ADC voltage
* Set/read DC-offset/bias


## Requirements

P1/SPIN1:
* spin-standard-library
* signal.adc-compatible ADC driver
* sensor.accel.common.spinh (provided by the spin-standard-library)

P2/SPIN2:
* p2-spin-standard-library
* signal.adc-compatible ADC driver
* sensor.accel.common.spin2h (provided by the p2-spin-standard-library)


## Compiler Compatibility

| Processor | Language | Compiler               | Backend      | Status                |
|-----------|----------|------------------------|--------------|-----------------------|
| P1        | SPIN1    | FlexSpin (6.9.4)       | Bytecode     | OK                    |
| P1        | SPIN1    | FlexSpin (6.9.4)       | Native/PASM  | Runtime issues        |
| P2        | SPIN2    | FlexSpin (6.9.4)       | NuCode       | Not yet implemented   |
| P2        | SPIN2    | FlexSpin (6.9.4)       | Native/PASM2 | Not yet implemented   |

(other versions or toolchains not listed are __not supported__, and _may or may not_ work)


## Hardware Compatibility

* Tested with Adafruit ADXL335 breakout and MCP3208 ADC


## Limitations

* Very early in development - may malfunction, or outright fail to build

