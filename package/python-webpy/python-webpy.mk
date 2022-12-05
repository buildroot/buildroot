################################################################################
#
# python-webpy
#
################################################################################

PYTHON_WEBPY_VERSION = 0.62
PYTHON_WEBPY_SOURCE = web.py-$(PYTHON_WEBPY_VERSION).tar.gz
PYTHON_WEBPY_SITE = https://files.pythonhosted.org/packages/cd/6e/338a060bb5b52ee8229bdada422eaa5f71b13f8d33467f37f870ed2cae4b
PYTHON_WEBPY_SETUP_TYPE = setuptools
PYTHON_WEBPY_LICENSE = Public Domain

$(eval $(python-package))
