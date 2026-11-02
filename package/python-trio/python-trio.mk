################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.35.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/9c/e2/1db4e79abb730bbf048c1024a622b0e1e895f5b0e18c59f3f6b3e4b296ef
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
