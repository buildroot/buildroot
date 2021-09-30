################################################################################
#
# python-sortedcontainers
#
################################################################################

PYTHON_SORTEDCONTAINERS_VERSION = 2.4.0
PYTHON_SORTEDCONTAINERS_SOURCE = sortedcontainers-$(PYTHON_SORTEDCONTAINERS_VERSION).tar.gz
PYTHON_SORTEDCONTAINERS_SITE = https://files.pythonhosted.org/packages/e8/c4/ba2f8066cceb6f23394729afe52f3bf7adec04bf9ed2c820b39e19299111
PYTHON_SORTEDCONTAINERS_SETUP_TYPE = setuptools
PYTHON_SORTEDCONTAINERS_LICENSE = Apache-2.0
PYTHON_SORTEDCONTAINERS_LICENSE_FILES = LICENSE

$(eval $(python-package))
