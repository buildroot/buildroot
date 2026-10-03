################################################################################
#
# python-daphne
#
################################################################################

PYTHON_DAPHNE_VERSION = 4.2.3
PYTHON_DAPHNE_SOURCE = daphne-$(PYTHON_DAPHNE_VERSION).tar.gz
PYTHON_DAPHNE_SITE = https://files.pythonhosted.org/packages/ed/23/81d442839029f3f343e536650ee49dbfb5a444520876fadb5b5f19f33c02
PYTHON_DAPHNE_SETUP_TYPE = setuptools
# https://github.com/django/daphne/blob/master/LICENSE
PYTHON_DAPHNE_LICENSE = BSD-3-Clause
PYTHON_DAPHNE_LICENSE_FILES = LICENSE
PYTHON_DAPHNE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
