################################################################################
#
# python3-setuptools
#
################################################################################

# Please keep in sync with
# package/python-setuptools/python-setuptools.mk
PYTHON3_SETUPTOOLS_VERSION = 60.6.0
PYTHON3_SETUPTOOLS_SOURCE = setuptools-$(PYTHON3_SETUPTOOLS_VERSION).tar.gz
PYTHON3_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/8f/89/9fec81ec84737c925a1ee992af2c6c7153aec4051c26afeadd6b822354d2
PYTHON3_SETUPTOOLS_LICENSE = MIT
PYTHON3_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON3_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON3_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON3_SETUPTOOLS_SETUP_TYPE = setuptools
HOST_PYTHON3_SETUPTOOLS_DL_SUBDIR = python-setuptools
HOST_PYTHON3_SETUPTOOLS_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
