################################################################################
#
# python-webpy
#
################################################################################

PYTHON_WEBPY_VERSION = 0.76
PYTHON_WEBPY_SITE = $(call github,webpy,webpy,v$(PYTHON_WEBPY_VERSION))
PYTHON_WEBPY_SETUP_TYPE = setuptools
PYTHON_WEBPY_LICENSE = Public Domain
PYTHON_WEBPY_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
