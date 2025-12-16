################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.32.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/d8/ce/0041ddd9160aac0031bcf5ab786c7640d795c797e67c438e15cfedf815c8
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
