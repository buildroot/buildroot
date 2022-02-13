################################################################################
#
# python-pypa-build
#
################################################################################

PYTHON_PYPA_BUILD_VERSION = 0.7.0
PYTHON_PYPA_BUILD_SOURCE = build-$(PYTHON_PYPA_BUILD_VERSION).tar.gz
PYTHON_PYPA_BUILD_SITE = https://files.pythonhosted.org/packages/f0/62/c73b775216bb1f34962beaf005f38460c6161177fef6e068a7a0c30a1597
PYTHON_PYPA_BUILD_LICENSE = MIT
PYTHON_PYPA_BUILD_LICENSE_FILES = LICENSE
PYTHON_PYPA_BUILD_SETUP_TYPE = setuptools
HOST_PYTHON_PYPA_BUILD_DEPENDENCIES = \
	host-python-packaging \
	host-python-pep517 \
	host-python-tomli

$(eval $(host-python-package))
