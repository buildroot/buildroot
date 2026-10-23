################################################################################
#
# python-tzlocal
#
################################################################################

PYTHON_TZLOCAL_VERSION = 5.4.5
PYTHON_TZLOCAL_SOURCE = tzlocal-$(PYTHON_TZLOCAL_VERSION).tar.gz
PYTHON_TZLOCAL_SITE = https://files.pythonhosted.org/packages/d8/89/2bd035df331499589fc92e59375c17c6cea6a500453b2c5f6a6ec9572825
PYTHON_TZLOCAL_SETUP_TYPE = setuptools
PYTHON_TZLOCAL_LICENSE = MIT
PYTHON_TZLOCAL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
