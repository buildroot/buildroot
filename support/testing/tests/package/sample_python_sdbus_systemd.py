#!/usr/bin/env python3

import sdbus

from sdbus_block.systemd.objects import Systemd, SystemdUnit

sdbus.set_default_bus(sdbus.sd_bus_open_system())
unit_object_path = Systemd().load_unit("systemd-journald.service")
unit = SystemdUnit(unit_object_path)

assert unit.active_enter_timestamp is not None
