################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.13.0
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/07/a8/aec21f8a6d23be84a9dd9eb9259f3f2feec2b5169eefb2fd647d3a14d5e0
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
