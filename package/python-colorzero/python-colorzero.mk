################################################################################
#
# python-colorzero
#
################################################################################

PYTHON_COLORZERO_VERSION = 2.0
PYTHON_COLORZERO_SOURCE = colorzero-$(PYTHON_COLORZERO_VERSION).tar.gz
PYTHON_COLORZERO_SITE = https://files.pythonhosted.org/packages/b3/ca/688824a06e8c4d04c7d2fd2af2d8da27bed51af20ee5f094154e1d680334
PYTHON_COLORZERO_LICENSE = BSD-3-Clause
PYTHON_COLORZERO_LICENSE_FILES = LICENSE.txt
PYTHON_COLORZERO_SETUP_TYPE = setuptools

$(eval $(python-package))
