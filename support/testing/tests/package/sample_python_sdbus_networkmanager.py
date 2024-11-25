#!/usr/bin/env python3

import sdbus

from sdbus_block.networkmanager import (
    DeviceType,
    NetworkManager,
    NetworkDeviceGeneric
)

sdbus.set_default_bus(sdbus.sd_bus_open_system())

nm = NetworkManager()
devices = [NetworkDeviceGeneric(d) for d in nm.get_devices()]

print([d.interface for d in devices])

assert devices
# Check that we found at least the loopback interface:
assert [dev for dev in devices if dev.device_type == DeviceType.LOOPBACK]
