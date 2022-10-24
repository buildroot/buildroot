################################################################################
#
# python-distro
#
################################################################################

PYTHON_DISTRO_VERSION = 1.8.0
PYTHON_DISTRO_SITE = https://files.pythonhosted.org/packages/4b/89/eaa3a3587ebf8bed93e45aa79be8c2af77d50790d15b53f6dfc85b57f398
PYTHON_DISTRO_SOURCE = distro-$(PYTHON_DISTRO_VERSION).tar.gz
PYTHON_DISTRO_LICENSE = Apache-2.0
PYTHON_DISTRO_LICENSE_FILES = LICENSE
PYTHON_DISTRO_SETUP_TYPE = setuptools

$(eval $(python-package))
