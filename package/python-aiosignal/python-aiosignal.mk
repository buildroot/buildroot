################################################################################
#
# python-aiosignal
#
################################################################################

PYTHON_AIOSIGNAL_VERSION = 1.3.1
PYTHON_AIOSIGNAL_SOURCE = aiosignal-$(PYTHON_AIOSIGNAL_VERSION).tar.gz
PYTHON_AIOSIGNAL_SITE = https://files.pythonhosted.org/packages/ae/67/0952ed97a9793b4958e5736f6d2b346b414a2cd63e82d05940032f45b32f
PYTHON_AIOSIGNAL_SETUP_TYPE = setuptools
PYTHON_AIOSIGNAL_LICENSE = Apache-2.0
PYTHON_AIOSIGNAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
