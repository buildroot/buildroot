################################################################################
#
# python-traitlets
#
################################################################################

PYTHON_TRAITLETS_VERSION = 5.7.1
PYTHON_TRAITLETS_SOURCE = traitlets-$(PYTHON_TRAITLETS_VERSION).tar.gz
PYTHON_TRAITLETS_SITE = https://files.pythonhosted.org/packages/0b/db/9adbbb2bef9a43ecfa4f1cbcec1d662adade10262328a4b7ef65effc6341
PYTHON_TRAITLETS_LICENSE = BSD-3-Clause
PYTHON_TRAITLETS_LICENSE_FILES = COPYING.md
PYTHON_TRAITLETS_SETUP_TYPE = pep517
PYTHON_TRAITLETS_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
