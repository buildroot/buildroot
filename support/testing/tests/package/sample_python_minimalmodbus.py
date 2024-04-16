import minimalmodbus
from serial.serialutil import SerialException

# We can't test proper behaviour in emulation, because there is
# actually no emulated modbus hardware, so we rely on the module
# to fail in an expected way to consider it is working correctly.
# Failure (of the script) is success (of the test)!
try:
    instrument = minimalmodbus.Instrument('/dev/ttyUSB99', 1)
except SerialException:
    pass
