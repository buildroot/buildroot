################################################################################
#
# python-texttable
#
################################################################################

PYTHON_TEXTTABLE_VERSION = 1.7.0
PYTHON_TEXTTABLE_SOURCE = texttable-$(PYTHON_TEXTTABLE_VERSION).tar.gz
PYTHON_TEXTTABLE_SITE = https://files.pythonhosted.org/packages/1c/dc/0aff23d6036a4d3bf4f1d8c8204c5c79c4437e25e0ae94ffe4bbb55ee3c2
PYTHON_TEXTTABLE_SETUP_TYPE = setuptools
PYTHON_TEXTTABLE_LICENSE = MIT
PYTHON_TEXTTABLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
