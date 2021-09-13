################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 7.1.2
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/27/6f/be940c8b1f1d69daceeb0032fee6c34d7bd70e3e649ccac0951500b4720e
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.rst
PYTHON_CLICK_SETUP_TYPE = setuptools

$(eval $(python-package))
