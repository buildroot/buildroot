uuu Howto
=========

Running uuu without root privileges
-----------------------------------

Accessing USB devices on Linux requires root privileges by default.
To be able to run uuu without root priviles, execute the following
steps:

  sudo sh -c "uuu -udev >> /etc/udev/rules.d/70-uuu.rules"
  sudo udevadm control --reload

