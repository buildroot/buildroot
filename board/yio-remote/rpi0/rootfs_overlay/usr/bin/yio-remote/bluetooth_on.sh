#!/bin/bash
#modprobe hci_uart
hciattach /dev/ttyS0 bcm43xx 921600 noflow -
