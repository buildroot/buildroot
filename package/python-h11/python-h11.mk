################################################################################
#
# python-h11
#
################################################################################

PYTHON_H11_VERSION = 0.14.0
PYTHON_H11_SOURCE = h11-$(PYTHON_H11_VERSION).tar.gz
PYTHON_H11_SITE = https://files.pythonhosted.org/packages/f5/38/3af3d3633a34a3316095b39c8e8fb4853a28a536e55d347bd8d8e9a14b03
PYTHON_H11_SETUP_TYPE = setuptools
PYTHON_H11_LICENSE = MIT
PYTHON_H11_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
