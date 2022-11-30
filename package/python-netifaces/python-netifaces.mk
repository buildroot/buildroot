################################################################################
#
# python-netifaces
#
################################################################################

PYTHON_NETIFACES_VERSION = 0.11.0
PYTHON_NETIFACES_SOURCE = netifaces-$(PYTHON_NETIFACES_VERSION).tar.gz
PYTHON_NETIFACES_SITE = https://files.pythonhosted.org/packages/a6/91/86a6eac449ddfae239e93ffc1918cf33fd9bab35c04d1e963b311e347a73
PYTHON_NETIFACES_LICENSE = MIT
PYTHON_NETIFACES_LICENSE_FILES = LICENSE
PYTHON_NETIFACES_SETUP_TYPE = setuptools

$(eval $(python-package))
