#!/usr/bin/env python3

# This script is from https://networkmanager.dev/docs/developers/

import gi
gi.require_version("NM", "1.0")
from gi.repository import NM  # noqa: E402


def print_values(setting, key, value, flags, data):
    print("     {}.{}: {}".format(setting.get_name(), key, value))


# Create the client object. This automatically loads all the D-Bus
# tree and creates in-memory objects for connections, devices, access
# points, etc.
client = NM.Client.new(None)

# Obtain a list of connection profiles ...
connections = client.get_connections()

# ... and print their properties
for c in connections:
    print("{}:".format(c.get_id()))
    c.for_each_setting_value(print_values, None)
    print("\n")
print("found {} defined connections".format(len(connections)))
assert len(connections) > 0

# check that we can find the loopback device ...
loopback = client.get_device_by_iface("lo")
# ... and read its type and status as expected
assert loopback.get_device_type().name == "LOOPBACK"
assert loopback.get_state().name == "ACTIVATED"
