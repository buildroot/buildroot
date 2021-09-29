################################################################################
#
# python-regex
#
################################################################################

# Please keep in sync with package/python3-regex/python3-regex.mk
PYTHON_REGEX_VERSION = 2021.4.4
PYTHON_REGEX_SOURCE = regex-$(PYTHON_REGEX_VERSION).tar.gz
PYTHON_REGEX_SITE = https://files.pythonhosted.org/packages/38/3f/4c42a98c9ad7d08c16e7d23b2194a0e4f3b2914662da8bc88986e4e6de1f
PYTHON_REGEX_SETUP_TYPE = setuptools
PYTHON_REGEX_LICENSE = CNRI-Python

$(eval $(python-package))
