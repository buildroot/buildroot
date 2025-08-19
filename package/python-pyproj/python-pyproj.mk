################################################################################
#
# python-pyproj
#
################################################################################

PYTHON_PYPROJ_VERSION = 3.7.2
PYTHON_PYPROJ_SOURCE = pyproj-$(PYTHON_PYPROJ_VERSION).tar.gz
PYTHON_PYPROJ_SITE = https://files.pythonhosted.org/packages/04/90/67bd7260b4ea9b8b20b4f58afef6c223ecb3abf368eb4ec5bc2cdef81b49
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
