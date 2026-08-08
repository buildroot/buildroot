import pyudev

context = pyudev.Context()
assert('/dev/ttyAMA0' in [ d.device_node for d in context.list_devices() ])
