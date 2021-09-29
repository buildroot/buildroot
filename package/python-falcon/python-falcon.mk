################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 3.0.1
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/63/22/6a9009c53ad78e65d88a44db8eccc7f39c6f54fc05fb43b1e9cbbc481d06
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_HOST_PYTHON_CYTHON),y)
PYTHON_FALCON_DEPENDENCIES += host-python-cython
endif

$(eval $(python-package))
