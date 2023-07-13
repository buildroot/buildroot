################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.1.4
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/77/88/b0cc5fe95c31c301e9823ea9b028f669c0dcfa205ff71111037a5ed4892c
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.rst
PYTHON_CLICK_SETUP_TYPE = setuptools

$(eval $(python-package))
