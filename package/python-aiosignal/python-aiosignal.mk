################################################################################
#
# python-aiosignal
#
################################################################################

PYTHON_AIOSIGNAL_VERSION = 1.4.0
PYTHON_AIOSIGNAL_SOURCE = aiosignal-$(PYTHON_AIOSIGNAL_VERSION).tar.gz
PYTHON_AIOSIGNAL_SITE = https://files.pythonhosted.org/packages/61/62/06741b579156360248d1ec624842ad0edf697050bbaf7c3e46394e106ad1
PYTHON_AIOSIGNAL_SETUP_TYPE = setuptools
PYTHON_AIOSIGNAL_LICENSE = Apache-2.0
PYTHON_AIOSIGNAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
