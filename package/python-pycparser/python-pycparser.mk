################################################################################
#
# python-pycparser
#
################################################################################

PYTHON_PYCPARSER_VERSION = 3.12
PYTHON_PYCPARSER_SOURCE = pycparser-$(PYTHON_PYCPARSER_VERSION).tar.gz
PYTHON_PYCPARSER_SITE = https://files.pythonhosted.org/packages/cb/27/eeb9f307bf07060f3d9f9aa0fb8c15b01bdfded0a941e4b2719c7f94cacd
PYTHON_PYCPARSER_SETUP_TYPE = setuptools
PYTHON_PYCPARSER_LICENSE = BSD-3-Clause
PYTHON_PYCPARSER_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
