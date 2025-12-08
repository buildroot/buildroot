################################################################################
#
# snagboot
#
################################################################################

SNAGBOOT_VERSION = 2.5
SNAGBOOT_SITE = $(call github,bootlin,snagboot,v$(SNAGBOOT_VERSION))
SNAGBOOT_LICENSE = GPL-2.0
SNAGBOOT_LICENSE_FILES = LICENSE
SNAGBOOT_SETUP_TYPE = setuptools
HOST_SNAGBOOT_DEPENDENCIES = \
	host-python-pyyaml \
	host-python-pyusb \
	host-python-serial \
	host-python-xmodem \
	host-python-tftpy \
	host-python-crccheck \
	host-python-pylibfdt \
	host-python-packaging \
	host-python-pyfatfs

# We do not install the dependencies for the snagfactory GUI
define SNAGBOOT_REMOVE_SNAGFACTORY
	$(RM) $(HOST_DIR)/bin/snagfactory
endef
HOST_SNAGBOOT_POST_INSTALL_HOOKS += SNAGBOOT_REMOVE_SNAGFACTORY

$(eval $(host-python-package))
