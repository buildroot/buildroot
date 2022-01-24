################################################################################
#
# delve
#
################################################################################

DELVE_VERSION = 1.8.0
DELVE_SITE = $(call github,go-delve,delve,v$(DELVE_VERSION))
DELVE_LICENSE = MIT
DELVE_LICENSE_FILES = LICENSE
DELVE_DEPENDENCIES = host-pkgconf

DELVE_TAGS = cgo
DELVE_BUILD_TARGETS = cmd/dlv
DELVE_INSTALL_BINS = $(notdir $(DELVE_BUILD_TARGETS))

HOST_DELVE_TAGS = cgo
HOST_DELVE_BUILD_TARGETS = cmd/dlv
HOST_DELVE_INSTALL_BINS = $(notdir $(HOST_DELVE_BUILD_TARGETS))

$(eval $(golang-package))
$(eval $(host-golang-package))
