################################################################################
#
# python-tftpy
#
################################################################################

PYTHON_TFTPY_VERSION = 0.8.5
PYTHON_TFTPY_SITE = $(call github,msoulier,tftpy,$(PYTHON_TFTPY_VERSION))
PYTHON_TFTPY_LICENSE = MIT
PYTHON_TFTPY_LICENSE_FILES = LICENSE
PYTHON_TFTPY_SETUP_TYPE = setuptools

$(eval $(python-package))
