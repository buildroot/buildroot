################################################################################
#
# python-aexpect
#
################################################################################

PYTHON_AEXPECT_VERSION = 1.8.0
PYTHON_AEXPECT_SOURCE = aexpect-$(PYTHON_AEXPECT_VERSION).tar.gz
PYTHON_AEXPECT_SITE = https://files.pythonhosted.org/packages/a3/74/837acfcdb3187cb931aa2edc4979e64aa9954092e4fd36b1161f65d65fdb
PYTHON_AEXPECT_SETUP_TYPE = setuptools
PYTHON_AEXPECT_LICENSE = GPL-2.0+
PYTHON_AEXPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
