################################################################################
#
# python-texttable
#
################################################################################

PYTHON_TEXTTABLE_VERSION = 1.7.1
PYTHON_TEXTTABLE_SOURCE = texttable-$(PYTHON_TEXTTABLE_VERSION).tar.gz
PYTHON_TEXTTABLE_SITE = https://files.pythonhosted.org/packages/72/c8/c926b35a849405ae0cb21956f8d7bd5e4f2c277c211784ed7d441df1b807
PYTHON_TEXTTABLE_SETUP_TYPE = setuptools
PYTHON_TEXTTABLE_LICENSE = MIT
PYTHON_TEXTTABLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
