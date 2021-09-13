################################################################################
#
# python3-regex
#
################################################################################

# Please keep in sync with package/python-regex/python-regex.mk
PYTHON3_REGEX_VERSION = 2021.4.4
PYTHON3_REGEX_SOURCE = regex-$(PYTHON3_REGEX_VERSION).tar.gz
PYTHON3_REGEX_SITE = https://files.pythonhosted.org/packages/38/3f/4c42a98c9ad7d08c16e7d23b2194a0e4f3b2914662da8bc88986e4e6de1f
PYTHON3_REGEX_SETUP_TYPE = setuptools
PYTHON3_REGEX_LICENSE = CNRI-Python
HOST_PYTHON3_REGEX_DL_SUBDIR = python-regex
HOST_PYTHON3_REGEX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
