################################################################################
#
# scons
#
################################################################################

SCONS_VERSION = 4.5.2
SCONS_SOURCE = SCons-$(SCONS_VERSION).tar.gz
SCONS_SITE = http://downloads.sourceforge.net/project/scons/scons/$(SCONS_VERSION)
SCONS_LICENSE = MIT
SCONS_LICENSE_FILES = LICENSE
SCONS_SETUP_TYPE = setuptools

HOST_SCONS_INSTALL_OPTS = \
	--install-lib=$(HOST_DIR)/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages

$(eval $(host-python-package))

# variables used by other packages
SCONS = $(HOST_DIR)/bin/python3 $(HOST_DIR)/bin/scons $(if $(QUIET),-s)
