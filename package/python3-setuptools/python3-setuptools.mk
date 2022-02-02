################################################################################
#
# python3-setuptools
#
################################################################################

# Please keep in sync with
# package/python-setuptools/python-setuptools.mk
PYTHON3_SETUPTOOLS_VERSION = 60.7.0
PYTHON3_SETUPTOOLS_SOURCE = setuptools-$(PYTHON3_SETUPTOOLS_VERSION).tar.gz
PYTHON3_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/29/dd/48d662bb93e5e51e72265ef612f869947d4ae4126328d7156824cd50d440
PYTHON3_SETUPTOOLS_LICENSE = MIT
PYTHON3_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON3_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON3_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON3_SETUPTOOLS_SETUP_TYPE = setuptools
HOST_PYTHON3_SETUPTOOLS_DL_SUBDIR = python-setuptools
HOST_PYTHON3_SETUPTOOLS_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
