################################################################################
#
# python-opentrickler
#
################################################################################

PYTHON_OPENTRICKLER_VERSION = 2.1.2
PYTHON_OPENTRICKLER_SOURCE = opentrickler-$(PYTHON_OPENTRICKLER_VERSION).tar.xz
PYTHON_OPENTRICKLER_SITE = $(TOPDIR)/package/python-opentrickler
PYTHON_OPENTRICKLER_SITE_METHOD = file
PYTHON_OPENTRICKLER_SETUP_TYPE = setuptools
PYTHON_OPENTRICKLER_LICENSE = MIT
PYTHON_OPENTRICKLER_LICENSE_FILES = LICENSE

$(eval $(python-package))
