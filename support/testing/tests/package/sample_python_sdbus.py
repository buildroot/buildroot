#!/usr/bin/env python3

import sdbus
from sdbus_block.dbus_daemon import FreedesktopDbus

s = FreedesktopDbus(sdbus.sd_bus_open_system())

props = s.properties_get_all_dict()

print(props)

# Check for a randomly chosen interface:
assert 'org.freedesktop.DBus.Monitoring' in props['interfaces']
