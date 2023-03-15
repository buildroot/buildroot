################################################################################
#
# python-libconf
#
################################################################################

PYTHON_LIBCONF_VERSION = 2.0.1
PYTHON_LIBCONF_SITE = $(call github,ChrisAichinger,python-libconf,$(PYTHON_LIBCONF_VERSION))
PYTHON_LIBCONF_SETUP_TYPE = setuptools
PYTHON_LIBCONF_LICENSE = MIT
PYTHON_LIBCONF_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
