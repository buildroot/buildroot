################################################################################
#
# python-distro
#
################################################################################

PYTHON_DISTRO_VERSION = 1.7.0
PYTHON_DISTRO_SITE = https://files.pythonhosted.org/packages/b5/7e/ddfbd640ac9a82e60718558a3de7d5988a7d4648385cf00318f60a8b073a
PYTHON_DISTRO_SOURCE = distro-$(PYTHON_DISTRO_VERSION).tar.gz
PYTHON_DISTRO_LICENSE = Apache-2.0
PYTHON_DISTRO_LICENSE_FILES = LICENSE
PYTHON_DISTRO_SETUP_TYPE = setuptools

$(eval $(python-package))
