################################################################################
#
# python-tftpy
#
################################################################################

PYTHON_TFTPY_VERSION = 0.8.7
PYTHON_TFTPY_SOURCE = tftpy-$(PYTHON_TFTPY_VERSION).tar.gz
PYTHON_TFTPY_SITE = https://files.pythonhosted.org/packages/4c/4f/92f31ab66baf5147d3c080d1a0820b68bced08a1fe5d3565868118649c81
PYTHON_TFTPY_LICENSE = MIT
PYTHON_TFTPY_LICENSE_FILES = LICENSE
PYTHON_TFTPY_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
