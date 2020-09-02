################################################################################
#
# python-packaging
#
################################################################################

PYTHON_PACKAGING_VERSION = 20.3
PYTHON_PACKAGING_SOURCE = packaging-$(PYTHON_PACKAGING_VERSION).tar.gz
PYTHON_PACKAGING_SITE = https://files.pythonhosted.org/packages/65/37/83e3f492eb52d771e2820e88105f605335553fe10422cba9d256faeb1702
PYTHON_PACKAGING_SETUP_TYPE = setuptools
PYTHON_PACKAGING_LICENSE = Apache-2.0 or BSD-2-Clause
PYTHON_PACKAGING_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD

$(eval $(python-package))
