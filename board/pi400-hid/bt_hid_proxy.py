#!/usr/bin/env python3
import os
import sys
import fcntl
import struct
import threading
import time
import evdev
from evdev import InputDevice, categorize, ecodes
from pydbus import SystemBus
from gi.repository import GLib

# HID UUID for Bluetooth keyboard/mouse
HID_UUID = "00001124-0000-1000-8000-00805f9b34fb"
PROFILE_PATH = "/bluez/f1dg3t_hid"
DEVICE_ALIAS = "F1dg3t's Keyboard"

# Global state
pairing_mode = False
loop = GLib.MainLoop()

# --- BlueZ / DBus helpers ---
def set_alias_and_discoverable(bus, alias, discoverable):
    adapter = bus.get("org.bluez", "/org/bluez/hci0")
    adapter.Set("org.bluez.Adapter1", "Alias", GLib.Variant("s", alias))
    adapter.Set("org.bluez.Adapter1", "Discoverable", GLib.Variant("b", discoverable))
    adapter.Set("org.bluez.Adapter1", "Pairable", GLib.Variant("b", discoverable))

def toggle_pairing():
    global pairing_mode
    pairing_mode = not pairing_mode
    bus = SystemBus()
    set_alias_and_discoverable(bus, DEVICE_ALIAS, pairing_mode)
    if pairing_mode:
        print("[*] Pairing mode ENABLED")
        threading.Thread(target=flash_numlock, daemon=True).start()
    else:
        print("[*] Pairing mode DISABLED")

def flash_numlock():
    # Blink NumLock LED while pairing
    try:
        kbd = InputDevice("/dev/input/by-path/platform-raspberrypi-ts-event-kbd")
    except FileNotFoundError:
        return
    for _ in range(20):  # blink ~10 sec
        if not pairing_mode:
            break
        fcntl.ioctl(kbd.fd, 0x4B32, struct.pack("i", 0x02))  # Toggle LED (NumLock)
        time.sleep(0.5)

def register_hid_profile():
    bus = SystemBus()
    profile_manager = bus.get("org.bluez", "/org/bluez")

    try:
        profile_manager.UnregisterProfile(PROFILE_PATH)
    except Exception:
        pass

    opts = {
        "Role": GLib.Variant("s", "server"),
        "RequireAuthentication": GLib.Variant("b", False),
        "RequireAuthorization": GLib.Variant("b", False),
    }
    profile_manager.RegisterProfile(PROFILE_PATH, HID_UUID, opts)
    set_alias_and_discoverable(bus, DEVICE_ALIAS, False)
    print("[*] HID profile registered as:", DEVICE_ALIAS)

# --- Input handling ---
def monitor_inputs():
    # Grab all input devices (keyboard, mouse, etc.)
    devices = [InputDevice(path) for path in evdev.list_devices()]
    kbd = None
    for d in devices:
        if "keyboard" in d.name.lower() or "raspberry" in d.name.lower():
            kbd = d
            break
    if not kbd:
        print("[!] No keyboard found")
        return

    print("[*] Monitoring keyboard:", kbd.path)
    for event in kbd.read_loop():
        if event.type == ecodes.EV_KEY:
            key = categorize(event)
            if key.keystate == key.key_down:
                # Check for Ctrl+Raspberry+Delete
                mods = kbd.active_keys()
                if (ecodes.KEY_LEFTCTRL in mods or ecodes.KEY_RIGHTCTRL in mods) \
                   and ecodes.KEY_LEFTMETA in mods \
                   and ecodes.KEY_DELETE in mods:
                    toggle_pairing()

# --- Main ---
def main():
    print("[*] Starting Pi400 Bluetooth HID Proxy...")
    register_hid_profile()
    threading.Thread(target=monitor_inputs, daemon=True).start()
    try:
        loop.run()
    except KeyboardInterrupt:
        print("\n[*] Exiting...")
        loop.quit()

if __name__ == "__main__":
    main()
