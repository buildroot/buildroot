################################################################################
#
# python-pyasn1-modules
#
################################################################################

PYTHON_PYASN1_MODULES_VERSION = 0.3.0
PYTHON_PYASN1_MODULES_SOURCE = pyasn1_modules-$(PYTHON_PYASN1_MODULES_VERSION).tar.gz
PYTHON_PYASN1_MODULES_SITE = https://files.pythonhosted.org/packages/3b/e4/7dec823b1b5603c5b3c51e942d5d9e65efd6ff946e713a325ed4146d070f
PYTHON_PYASN1_MODULES_SETUP_TYPE = setuptools
PYTHON_PYASN1_MODULES_LICENSE = BSD-2-Clause
PYTHON_PYASN1_MODULES_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
