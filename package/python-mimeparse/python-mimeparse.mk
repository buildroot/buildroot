################################################################################
#
# python-mimeparse
#
################################################################################

PYTHON_MIMEPARSE_VERSION = 2.0.0
PYTHON_MIMEPARSE_SOURCE = python_mimeparse-$(PYTHON_MIMEPARSE_VERSION).tar.gz
PYTHON_MIMEPARSE_SITE = https://files.pythonhosted.org/packages/cd/85/c40f2e0b2128905f6c34894be01803c114f2b2efab0e8b4c3dca5e56b999
PYTHON_MIMEPARSE_SETUP_TYPE = setuptools
PYTHON_MIMEPARSE_LICENSE = MIT
PYTHON_MIMEPARSE_LICENSE_FILES = LICENSE

$(eval $(python-package))
