################################################################################
#
# python-pytablereader
#
################################################################################

PYTHON_PYTABLEREADER_VERSION = 0.31.3
PYTHON_PYTABLEREADER_SOURCE = pytablereader-$(PYTHON_PYTABLEREADER_VERSION).tar.gz
PYTHON_PYTABLEREADER_SITE = https://files.pythonhosted.org/packages/b5/c8/67590578e27cb1716c7b71291946d685b5bf63fbfe7a254a7cb3f6f8aeab
PYTHON_PYTABLEREADER_SETUP_TYPE = setuptools
PYTHON_PYTABLEREADER_LICENSE = MIT
PYTHON_PYTABLEREADER_LICENSE_FILES = LICENSE

$(eval $(python-package))
