################################################################################
#
# python-tzlocal
#
################################################################################

PYTHON_TZLOCAL_VERSION = 5.3
PYTHON_TZLOCAL_SOURCE = tzlocal-$(PYTHON_TZLOCAL_VERSION).tar.gz
PYTHON_TZLOCAL_SITE = https://files.pythonhosted.org/packages/33/cc/11360404b20a6340b9b4ed39a3338c4af47bc63f87f6cea94dbcbde07029
PYTHON_TZLOCAL_SETUP_TYPE = setuptools
PYTHON_TZLOCAL_LICENSE = MIT
PYTHON_TZLOCAL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
