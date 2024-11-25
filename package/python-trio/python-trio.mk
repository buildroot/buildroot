################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.27.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/17/d1/a83dee5be404da7afe5a71783a33b8907bacb935a6dc8c69ab785e4a3eed
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
