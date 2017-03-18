################################################################################
#
# ohdevtools
#
################################################################################

OHDEVTOOLS_VERSION = 2a4a254080fba32cd4d513dad096f70b453faced
OHDEVTOOLS_SITE = $(call github,openhome,ohdevtools,$(OHDEVTOOLS_VERSION))
OHDEVTOOLS_LICENSE = BSD-2c
OHDEVTOOLS_LICENSE_FILES = License.txt

OHDEVTOOLS_NEEDS_HOST_PYTHON = python2

define HOST_OHDEVTOOLS_INSTALL_CMDS
	mkdir -p $(OHDEVTOOLS_ROOT)
	cp -dpfr $(@D)/* $(OHDEVTOOLS_ROOT)
endef

$(eval $(host-generic-package))

# variables used by other packages
OHDEVTOOLS_ROOT = $(HOST_DIR)/usr/share/ohdevtools
