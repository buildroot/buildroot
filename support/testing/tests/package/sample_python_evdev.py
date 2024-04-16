import evdev

devices = [evdev.InputDevice(path) for path in evdev.list_devices()]
e = evdev.events.InputEvent(1036996631, 984417, evdev.ecodes.EV_KEY, evdev.ecodes.KEY_A, 2)
k = evdev.events.KeyEvent(e)

assert(k.keystate == evdev.events.KeyEvent.key_hold)
assert(k.event == e)
assert(k.scancode == evdev.ecodes.KEY_A)
assert(k.keycode == 'KEY_A')
assert(len(devices) > 0)
