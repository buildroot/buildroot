################################################################################
#
# python-traitlets
#
################################################################################

PYTHON_TRAITLETS_VERSION = 5.8.0
PYTHON_TRAITLETS_SOURCE = traitlets-$(PYTHON_TRAITLETS_VERSION).tar.gz
PYTHON_TRAITLETS_SITE = https://files.pythonhosted.org/packages/56/48/0eb99357330a02974d537be8e4096bc58cfac1089e3153570119ccea7a40
PYTHON_TRAITLETS_LICENSE = BSD-3-Clause
PYTHON_TRAITLETS_LICENSE_FILES = COPYING.md
PYTHON_TRAITLETS_SETUP_TYPE = pep517
PYTHON_TRAITLETS_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
