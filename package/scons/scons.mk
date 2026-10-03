################################################################################
#
# scons
#
################################################################################

SCONS_VERSION = 4.11.1
SCONS_SITE = https://files.pythonhosted.org/packages/42/b9/b7a5c88f348a0c34594d88100872c55fa1cae863ccb222c1c438341b5503
SCONS_LICENSE = MIT
SCONS_LICENSE_FILES = LICENSE
SCONS_SETUP_TYPE = setuptools

$(eval $(host-python-package))

# variables used by other packages
SCONS = $(HOST_DIR)/bin/python3 $(HOST_DIR)/bin/scons $(if $(QUIET),-s)
