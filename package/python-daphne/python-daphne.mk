################################################################################
#
# python-daphne
#
################################################################################

PYTHON_DAPHNE_VERSION = 4.0.0
PYTHON_DAPHNE_SOURCE = daphne-$(PYTHON_DAPHNE_VERSION).tar.gz
PYTHON_DAPHNE_SITE = https://files.pythonhosted.org/packages/d7/77/57b19d5caabf8537879aa4cf3a017b99d0b727f2521ffca7fd9140573509
PYTHON_DAPHNE_SETUP_TYPE = setuptools
# https://github.com/django/daphne/blob/master/LICENSE
PYTHON_DAPHNE_LICENSE = BSD-3-Clause
PYTHON_DAPHNE_LICENSE_FILES = LICENSE

$(eval $(python-package))
