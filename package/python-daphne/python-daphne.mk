################################################################################
#
# python-daphne
#
################################################################################

PYTHON_DAPHNE_VERSION = 4.1.2
PYTHON_DAPHNE_SOURCE = daphne-$(PYTHON_DAPHNE_VERSION).tar.gz
PYTHON_DAPHNE_SITE = https://files.pythonhosted.org/packages/1a/c1/aedf180beb12395835cba791ce7239b8880009d9d37564d72b7590cde605
PYTHON_DAPHNE_SETUP_TYPE = setuptools
# https://github.com/django/daphne/blob/master/LICENSE
PYTHON_DAPHNE_LICENSE = BSD-3-Clause
PYTHON_DAPHNE_LICENSE_FILES = LICENSE
PYTHON_DAPHNE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
