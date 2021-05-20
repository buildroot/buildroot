################################################################################
#
# python3-six
#
################################################################################

# Please keep in sync with package/python-six/python-six.mk
PYTHON3_SIX_VERSION = 1.15.0
PYTHON3_SIX_SOURCE = six-$(PYTHON3_SIX_VERSION).tar.gz
PYTHON3_SIX_SITE = https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426
PYTHON3_SIX_SETUP_TYPE = setuptools
PYTHON3_SIX_LICENSE = MIT
PYTHON3_SIX_LICENSE_FILES = LICENSE
HOST_PYTHON3_SIX_DL_SUBDIR = python-six
HOST_PYTHON3_SIX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
