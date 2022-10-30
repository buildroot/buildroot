################################################################################
#
# python-pypa-build
#
################################################################################

PYTHON_PYPA_BUILD_VERSION = 0.9.0
PYTHON_PYPA_BUILD_SOURCE = build-$(PYTHON_PYPA_BUILD_VERSION).tar.gz
PYTHON_PYPA_BUILD_SITE = https://files.pythonhosted.org/packages/0f/61/aaf43fbb36cc4308be8ac8088f52db9622b0dbf1f0880c1016ae6aa03f46
PYTHON_PYPA_BUILD_LICENSE = MIT
PYTHON_PYPA_BUILD_LICENSE_FILES = LICENSE
PYTHON_PYPA_BUILD_SETUP_TYPE = setuptools
HOST_PYTHON_PYPA_BUILD_DEPENDENCIES = \
	host-python-packaging \
	host-python-pep517 \
	host-python-tomli

$(eval $(host-python-package))
