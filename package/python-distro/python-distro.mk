################################################################################
#
# python-distro
#
################################################################################

PYTHON_DISTRO_VERSION = 1.6.0
PYTHON_DISTRO_SITE = https://files.pythonhosted.org/packages/a5/26/256fa167fe1bf8b97130b4609464be20331af8a3af190fb636a8a7efd7a2
PYTHON_DISTRO_SOURCE = distro-$(PYTHON_DISTRO_VERSION).tar.gz
PYTHON_DISTRO_LICENSE = Apache-2.0
PYTHON_DISTRO_LICENSE_FILES = LICENSE
PYTHON_DISTRO_SETUP_TYPE = setuptools

$(eval $(python-package))
