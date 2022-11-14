################################################################################
#
# python-pycparser
#
################################################################################

PYTHON_PYCPARSER_VERSION = 2.21
PYTHON_PYCPARSER_SOURCE = pycparser-$(PYTHON_PYCPARSER_VERSION).tar.gz
PYTHON_PYCPARSER_SITE = https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de
PYTHON_PYCPARSER_SETUP_TYPE = setuptools
PYTHON_PYCPARSER_LICENSE = BSD-3-Clause
PYTHON_PYCPARSER_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
