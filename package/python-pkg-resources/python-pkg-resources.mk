################################################################################
#
# python-pkg-resources
#
################################################################################

PYTHON_PKG_RESOURCES_VERSION = 7fa76c17eacf8a67c6932c9c2dd97861f42439cf
PYTHON_PKG_RESOURCES_SITE = $(call github,pypa,pkg_resources,$(PYTHON_PKG_RESOURCES_VERSION))
PYTHON_PKG_RESOURCES_SETUP_TYPE = setuptools
PYTHON_PKG_RESOURCES_LICENSE = MIT
PYTHON_PKG_RESOURCES_LICENSE_FILES = LICENSE
HOST_PYTHON_PKG_RESOURCES_DEPENDENCIES = \
	host-python-jaraco-text \
	host-python-packaging \
	host-python-platformdirs

$(eval $(host-python-package))
