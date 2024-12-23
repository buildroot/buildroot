################################################################################
#
# python-aiosignal
#
################################################################################

PYTHON_AIOSIGNAL_VERSION = 1.3.2
PYTHON_AIOSIGNAL_SOURCE = aiosignal-$(PYTHON_AIOSIGNAL_VERSION).tar.gz
PYTHON_AIOSIGNAL_SITE = https://files.pythonhosted.org/packages/ba/b5/6d55e80f6d8a08ce22b982eafa278d823b541c925f11ee774b0b9c43473d
PYTHON_AIOSIGNAL_SETUP_TYPE = setuptools
PYTHON_AIOSIGNAL_LICENSE = Apache-2.0
PYTHON_AIOSIGNAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
