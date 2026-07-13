local dbus = require 'easydbus'

local bus = assert(dbus.system())
local service_name = 'easydbus.SampleTest'
local object_path = '/easydbus/sample'
local interface_name = 'easydbus.SampleTest'
local signal_name = 'Pinged'

local owner_id = assert(bus:own_name(service_name))

local payload
bus:subscribe(nil, object_path, interface_name, signal_name,
              function(arg) payload = arg; dbus.mainloop_quit() end)
assert(bus:emit(nil, object_path, interface_name, signal_name,
                's', 'hello'))
dbus.mainloop()

bus:unown_name(owner_id)

assert(payload == 'hello',
       'unexpected payload: ' .. tostring(payload))
print('OK')
