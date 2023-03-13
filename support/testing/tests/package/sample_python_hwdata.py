#! /usr/bin/env python3

from hwdata import PCI, PNP, USB

# Test PCI IDs
pci_vendor_id = '1af4'
pci_device_id = '1003'

pci = PCI()

pci_vendor = pci.get_vendor(pci_vendor_id)
print("PCI Vendor: %s" % pci_vendor)
assert (pci_vendor == "Red Hat, Inc.")

pci_device = pci.get_device(pci_vendor_id, pci_device_id)
print("PCI Device: %s" % pci_device)
assert (pci_device == "Virtio console")

# Test USB IDs
usb_vendor_id = '1d6b'
usb_device_id = '0001'

usb = USB()

usb_vendor = usb.get_vendor(usb_vendor_id)
print("USB Vendor: %s" % usb_vendor)
assert (usb_vendor == "Linux Foundation")

usb_device = usb.get_device(usb_vendor_id, usb_device_id)
print("USB Device: %s" % usb_device)
assert (usb_device == "1.1 root hub")

# Test PNP IDs
pnp_id = 'RHT'

pnp = PNP()

pnp_vendor = pnp.get_vendor(pnp_id)
print("PNP Vendor: %s" % pnp_vendor)
assert (pnp_vendor == "Red Hat, Inc.")
