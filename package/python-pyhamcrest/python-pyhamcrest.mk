################################################################################
#
# python-pyhamcrest
#
################################################################################

PYTHON_PYHAMCREST_VERSION = 2.0.2
PYTHON_PYHAMCREST_SOURCE = PyHamcrest-$(PYTHON_PYHAMCREST_VERSION).tar.gz
PYTHON_PYHAMCREST_SITE = https://files.pythonhosted.org/packages/58/05/7b993fabb44ff0b52a90916d96bfd91a65ecf90b8248e72bba325ba8e438
PYTHON_PYHAMCREST_SETUP_TYPE = setuptools
PYTHON_PYHAMCREST_LICENSE = BSD-3-Clause
PYTHON_PYHAMCREST_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
