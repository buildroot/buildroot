################################################################################
#
# python-aniso8601
#
################################################################################

PYTHON_ANISO8601_VERSION = 10.0.0
PYTHON_ANISO8601_SOURCE = aniso8601-$(PYTHON_ANISO8601_VERSION).tar.gz
PYTHON_ANISO8601_SITE = https://files.pythonhosted.org/packages/f3/3f/dc8a28fa6dc72c13d8c158b01f8975f240e9e72c336cc1ae00f424e2d7ce
PYTHON_ANISO8601_SETUP_TYPE = setuptools
PYTHON_ANISO8601_LICENSE = BSD-3-Clause
PYTHON_ANISO8601_LICENSE_FILES = LICENSE

$(eval $(python-package))
