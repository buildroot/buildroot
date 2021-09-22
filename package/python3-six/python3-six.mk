################################################################################
#
# python3-six
#
################################################################################

# Please keep in sync with package/python-six/python-six.mk
PYTHON3_SIX_VERSION = 1.16.0
PYTHON3_SIX_SOURCE = six-$(PYTHON3_SIX_VERSION).tar.gz
PYTHON3_SIX_SITE = https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e
PYTHON3_SIX_SETUP_TYPE = setuptools
PYTHON3_SIX_LICENSE = MIT
PYTHON3_SIX_LICENSE_FILES = LICENSE
HOST_PYTHON3_SIX_DL_SUBDIR = python-six
HOST_PYTHON3_SIX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
