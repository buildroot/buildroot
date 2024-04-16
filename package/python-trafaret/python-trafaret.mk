################################################################################
#
# python-trafaret
#
################################################################################

PYTHON_TRAFARET_VERSION = 2.1.1
PYTHON_TRAFARET_SOURCE = trafaret-$(PYTHON_TRAFARET_VERSION).tar.gz
PYTHON_TRAFARET_SITE = https://files.pythonhosted.org/packages/c9/ed/aac034e566f8846aee6472dcc90da6011a0b1829e3ffc768407df519a3b0
PYTHON_TRAFARET_SETUP_TYPE = setuptools
PYTHON_TRAFARET_LICENSE = BSD-2-Clause
PYTHON_TRAFARET_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
