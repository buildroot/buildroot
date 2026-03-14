################################################################################
#
# python-pkgconfig
#
################################################################################

PYTHON_PKGCONFIG_VERSION = 1.6.0
PYTHON_PKGCONFIG_SOURCE = pkgconfig-$(PYTHON_PKGCONFIG_VERSION).tar.gz
PYTHON_PKGCONFIG_SITE = https://files.pythonhosted.org/packages/52/fd/0adde075cd3bfecd557bc7d757e00e231d34d8a6edb4c8d1642759254c21
PYTHON_PKGCONFIG_SETUP_TYPE = poetry
PYTHON_PKGCONFIG_LICENSE = MIT
PYTHON_PKGCONFIG_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
