################################################################################
#
# python-distro
#
################################################################################

PYTHON_DISTRO_VERSION = 1.9.0
PYTHON_DISTRO_SOURCE = distro-$(PYTHON_DISTRO_VERSION).tar.gz
PYTHON_DISTRO_SITE = https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3
PYTHON_DISTRO_LICENSE = Apache-2.0
PYTHON_DISTRO_LICENSE_FILES = LICENSE
PYTHON_DISTRO_SETUP_TYPE = setuptools

$(eval $(python-package))
