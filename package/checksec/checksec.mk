################################################################################
#
# checksec
#
################################################################################

# git hash of 2.7.1 release.
CHECKSEC_VERSION = 181cdfa84893a5d72695944efabfa5b56687379c
CHECKSEC_SITE = $(call github,slimm609,checksec.sh,$(CHECKSEC_VERSION))
CHECKSEC_LICENSE = BSD-3-Clause
CHECKSEC_LICENSE_FILES = LICENSE.txt

define HOST_CHECKSEC_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/checksec $(HOST_DIR)/bin/checksec
endef

$(eval $(host-generic-package))
