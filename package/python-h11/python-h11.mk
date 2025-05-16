################################################################################
#
# python-h11
#
################################################################################

PYTHON_H11_VERSION = 0.16.0
PYTHON_H11_SOURCE = h11-$(PYTHON_H11_VERSION).tar.gz
PYTHON_H11_SITE = https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963
PYTHON_H11_SETUP_TYPE = setuptools
PYTHON_H11_LICENSE = MIT
PYTHON_H11_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
