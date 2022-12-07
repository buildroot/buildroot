################################################################################
#
# python-pyhamcrest
#
################################################################################

PYTHON_PYHAMCREST_VERSION = 2.0.4
PYTHON_PYHAMCREST_SOURCE = pyhamcrest-$(PYTHON_PYHAMCREST_VERSION).tar.gz
PYTHON_PYHAMCREST_SITE = https://files.pythonhosted.org/packages/b1/9a/588f086b64ace8d2e9843d8551e9068b2570c3c51b06cb49a107303f8700
PYTHON_PYHAMCREST_SETUP_TYPE = setuptools
PYTHON_PYHAMCREST_LICENSE = BSD-3-Clause
PYTHON_PYHAMCREST_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
