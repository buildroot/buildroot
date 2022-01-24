################################################################################
#
# python3-pycparser
#
################################################################################

# Please keep in sync with package/python-pycparser/python-pycparser.mk
PYTHON3_PYCPARSER_VERSION = 2.21
PYTHON3_PYCPARSER_SOURCE = pycparser-$(PYTHON3_PYCPARSER_VERSION).tar.gz
PYTHON3_PYCPARSER_SITE = https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de
PYTHON3_PYCPARSER_SETUP_TYPE = setuptools
PYTHON3_PYCPARSER_LICENSE = BSD-3-Clause
PYTHON3_PYCPARSER_LICENSE_FILES = LICENSE
HOST_PYTHON3_PYCPARSER_DL_SUBDIR = python-pycparser
HOST_PYTHON3_PYCPARSER_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
