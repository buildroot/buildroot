################################################################################
#
# python-texttable
#
################################################################################

PYTHON_TEXTTABLE_VERSION = 1.7.2
PYTHON_TEXTTABLE_SOURCE = texttable-$(PYTHON_TEXTTABLE_VERSION).tar.gz
PYTHON_TEXTTABLE_SITE = https://files.pythonhosted.org/packages/03/19/9590fd39a668ea0a0869493441fe65852246a3ec67616877baad98bcb039
PYTHON_TEXTTABLE_SETUP_TYPE = setuptools
PYTHON_TEXTTABLE_LICENSE = MIT
PYTHON_TEXTTABLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
