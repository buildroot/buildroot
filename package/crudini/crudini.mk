################################################################################
#
# crudini
#
################################################################################

CRUDINI_VERSION = 0.9.3
CRUDINI_SITE = $(call github,pixelb,crudini,$(CRUDINI_VERSION))
CRUDINI_SETUP_TYPE = setuptools
CRUDINI_LICENSE = GPL-2.0
CRUDINI_LICENSE_FILES = COPYING
# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_CRUDINI_DEPENDENCIES = host-python-iniparse

$(eval $(python-package))
$(eval $(host-python-package))
