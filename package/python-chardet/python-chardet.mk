################################################################################
#
# python-chardet
#
################################################################################

PYTHON_CHARDET_VERSION = 5.0.0
PYTHON_CHARDET_SOURCE = chardet-$(PYTHON_CHARDET_VERSION).tar.gz
PYTHON_CHARDET_SITE = https://files.pythonhosted.org/packages/31/a2/12c090713b3d0e141f367236d3a8bdc3e5fca0d83ff3647af4892c16c205
PYTHON_CHARDET_SETUP_TYPE = setuptools
PYTHON_CHARDET_LICENSE = LGPL-2.1+
PYTHON_CHARDET_LICENSE_FILES = LICENSE

$(eval $(python-package))
