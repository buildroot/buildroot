################################################################################
#
# python-typeguard
#
################################################################################

PYTHON_TYPEGUARD_VERSION = 2.13.3
PYTHON_TYPEGUARD_SOURCE = typeguard-$(PYTHON_TYPEGUARD_VERSION).tar.gz
PYTHON_TYPEGUARD_SITE = https://files.pythonhosted.org/packages/3a/38/c61bfcf62a7b572b5e9363a802ff92559cb427ee963048e1442e3aef7490
PYTHON_TYPEGUARD_SETUP_TYPE = setuptools
PYTHON_TYPEGUARD_LICENSE = MIT
PYTHON_TYPEGUARD_LICENSE_FILES = LICENSE
PYTHON_TYPEGUARD_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
