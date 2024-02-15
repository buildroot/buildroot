################################################################################
#
# python-hatchling
#
################################################################################

PYTHON_HATCHLING_VERSION = 1.21.1
PYTHON_HATCHLING_SOURCE = hatchling-$(PYTHON_HATCHLING_VERSION).tar.gz
PYTHON_HATCHLING_SITE = https://files.pythonhosted.org/packages/d8/a1/7dd1caa87c0b15c04c6291e25112e5d082cce02ee87f221a8be1d594f857
PYTHON_HATCHLING_LICENSE = MIT
PYTHON_HATCHLING_LICENSE_FILES = LICENSE.txt
PYTHON_HATCHLING_SETUP_TYPE = pep517
HOST_PYTHON_HATCHLING_DEPENDENCIES = \
	host-python-editables \
	host-python-packaging \
	host-python-pathspec \
	host-python-pluggy \
	host-python-trove-classifiers

$(eval $(host-python-package))
