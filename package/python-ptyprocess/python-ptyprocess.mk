################################################################################
#
# python-ptyprocess
#
################################################################################

PYTHON_PTYPROCESS_VERSION = 0.7.0
PYTHON_PTYPROCESS_SITE = https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e
PYTHON_PTYPROCESS_SOURCE = ptyprocess-$(PYTHON_PTYPROCESS_VERSION).tar.gz
PYTHON_PTYPROCESS_LICENSE = ISC
PYTHON_PTYPROCESS_LICENSE_FILES = LICENSE
PYTHON_PTYPROCESS_SETUP_TYPE = setuptools

$(eval $(python-package))
