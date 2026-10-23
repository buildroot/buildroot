################################################################################
#
# python-pylru
#
################################################################################

PYTHON_PYLRU_VERSION = 1.3.2
PYTHON_PYLRU_SOURCE = pylru-$(PYTHON_PYLRU_VERSION).tar.gz
PYTHON_PYLRU_SITE = https://files.pythonhosted.org/packages/0c/88/dc306f0b4dbc5cd89c5153bdf5b2141d0f9107dde8b26edabf4f6654e65f
PYTHON_PYLRU_SETUP_TYPE = setuptools
PYTHON_PYLRU_LICENSE = MIT
PYTHON_PYLRU_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
