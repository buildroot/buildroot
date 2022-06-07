################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 3.1.0
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/36/53/4fd90c6c841bc2e4be29ab92c65e5406df9096c421f138bef9d95d43afc9
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_HOST_PYTHON_CYTHON),y)
PYTHON_FALCON_DEPENDENCIES += host-python-cython
endif

$(eval $(python-package))
