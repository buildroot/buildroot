################################################################################
#
# python-pyproj
#
################################################################################

PYTHON_PYPROJ_VERSION = 3.8.0
PYTHON_PYPROJ_SOURCE = pyproj-$(PYTHON_PYPROJ_VERSION).tar.gz
PYTHON_PYPROJ_SITE = https://files.pythonhosted.org/packages/c8/29/6598570c90cbfc84ddefc3ccac4aa412bf51a527d72c74cc4fe64a5e6f24
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
