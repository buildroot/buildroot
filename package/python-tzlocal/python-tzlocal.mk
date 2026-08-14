################################################################################
#
# python-tzlocal
#
################################################################################

PYTHON_TZLOCAL_VERSION = 5.4.4
PYTHON_TZLOCAL_SOURCE = tzlocal-$(PYTHON_TZLOCAL_VERSION).tar.gz
PYTHON_TZLOCAL_SITE = https://files.pythonhosted.org/packages/81/5b/879b2f932adfa7a053c360d50bc896c977fa6426109185f7c12ebdd0cb9d
PYTHON_TZLOCAL_SETUP_TYPE = setuptools
PYTHON_TZLOCAL_LICENSE = MIT
PYTHON_TZLOCAL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
