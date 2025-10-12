################################################################################
#
# python-daphne
#
################################################################################

PYTHON_DAPHNE_VERSION = 4.2.1
PYTHON_DAPHNE_SOURCE = daphne-$(PYTHON_DAPHNE_VERSION).tar.gz
PYTHON_DAPHNE_SITE = https://files.pythonhosted.org/packages/cd/9d/322b605fdc03b963cf2d33943321c8f4405e8d82e698bf49d1eed1ca40c4
PYTHON_DAPHNE_SETUP_TYPE = setuptools
# https://github.com/django/daphne/blob/master/LICENSE
PYTHON_DAPHNE_LICENSE = BSD-3-Clause
PYTHON_DAPHNE_LICENSE_FILES = LICENSE
PYTHON_DAPHNE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
