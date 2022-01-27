################################################################################
#
# python-aiosignal
#
################################################################################

PYTHON_AIOSIGNAL_VERSION = 1.2.0
PYTHON_AIOSIGNAL_SOURCE = aiosignal-$(PYTHON_AIOSIGNAL_VERSION).tar.gz
PYTHON_AIOSIGNAL_SITE = https://files.pythonhosted.org/packages/27/6b/a89fbcfae70cf53f066ec22591938296889d3cc58fec1e1c393b10e8d71d
PYTHON_AIOSIGNAL_SETUP_TYPE = setuptools
PYTHON_AIOSIGNAL_LICENSE = Apache-2.0
PYTHON_AIOSIGNAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
