################################################################################
#
# python-wsaccel
#
################################################################################

PYTHON_WSACCEL_VERSION = 0.6.3
PYTHON_WSACCEL_SOURCE = wsaccel-$(PYTHON_WSACCEL_VERSION).tar.gz
PYTHON_WSACCEL_SITE = https://files.pythonhosted.org/packages/f5/d1/3e99875a764d0d6ec94a74977ed72dd3022a7f31d036622da9cff8fc072f
PYTHON_WSACCEL_LICENSE = Apache-2.0
PYTHON_WSACCEL_LICENSE_FILES = LICENSE
PYTHON_WSACCEL_SETUP_TYPE = setuptools

$(eval $(python-package))
