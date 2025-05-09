################################################################################
#
# python-pyproj
#
################################################################################

PYTHON_PYPROJ_VERSION = 3.7.1
PYTHON_PYPROJ_SOURCE = pyproj-$(PYTHON_PYPROJ_VERSION).tar.gz
PYTHON_PYPROJ_SITE = https://files.pythonhosted.org/packages/67/10/a8480ea27ea4bbe896c168808854d00f2a9b49f95c0319ddcbba693c8a90
PYTHON_PYPROJ_SETUP_TYPE = setuptools
PYTHON_PYPROJ_LICENSE = MIT
PYTHON_PYPROJ_LICENSE_FILES = LICENSE
PYTHON_PYPROJ_DEPENDENCIES = host-python-cython proj
PYTHON_PYPROJ_ENV = \
	PROJ_DIR=$(HOST_DIR)/bin/ \
	PROJ_INCDIR=$(HOST_DIR)/include/ \
	PROJ_LIBDIR=$(TARGET_DIR)/usr/lib/ \
	PROJ_VERSION=$(PROJ_VERSION)

$(eval $(python-package))
