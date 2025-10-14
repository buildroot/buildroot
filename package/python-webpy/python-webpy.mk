################################################################################
#
# python-webpy
#
################################################################################

PYTHON_WEBPY_VERSION = 0.70
PYTHON_WEBPY_SITE = $(call github,webpy,webpy,webpy-$(PYTHON_WEBPY_VERSION))
PYTHON_WEBPY_SETUP_TYPE = setuptools
PYTHON_WEBPY_LICENSE = Public Domain

$(eval $(python-package))
