#!/usr/bin/env python3

import sdbus

from sdbus_block.modemmanager import MM

sdbus.set_default_bus(sdbus.sd_bus_open_system())
mm = MM()

assert mm.version is not None
