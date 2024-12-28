################################################################################
#
# scons
#
################################################################################

SCONS_VERSION = 4.8.1
SCONS_SITE = https://files.pythonhosted.org/packages/b9/76/a2c1293642f9a448f2d012cabf525be69ca5abf4af289bc0935ac1554ee8
SCONS_LICENSE = MIT
SCONS_LICENSE_FILES = LICENSE
SCONS_SETUP_TYPE = setuptools

$(eval $(host-python-package))

# variables used by other packages
SCONS = $(HOST_DIR)/bin/python3 $(HOST_DIR)/bin/scons $(if $(QUIET),-s)
