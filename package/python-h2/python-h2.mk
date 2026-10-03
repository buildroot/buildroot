################################################################################
#
# python-h2
#
################################################################################

PYTHON_H2_VERSION = 4.4.1
PYTHON_H2_SOURCE = h2-$(PYTHON_H2_VERSION).tar.gz
PYTHON_H2_SITE = https://files.pythonhosted.org/packages/e7/85/7c366e69d84c17bb778fe41419e1fbcce3033d5b7ce29bbffff0a98b859f
PYTHON_H2_SETUP_TYPE = setuptools
PYTHON_H2_LICENSE = MIT
PYTHON_H2_LICENSE_FILES = LICENSE

$(eval $(python-package))
