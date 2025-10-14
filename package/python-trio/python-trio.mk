################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.31.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/76/8f/c6e36dd11201e2a565977d8b13f0b027ba4593c1a80bed5185489178e257
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
