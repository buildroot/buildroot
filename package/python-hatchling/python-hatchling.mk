################################################################################
#
# python-hatchling
#
################################################################################

PYTHON_HATCHLING_VERSION = 1.33.0
PYTHON_HATCHLING_SOURCE = hatchling-$(PYTHON_HATCHLING_VERSION).tar.gz
PYTHON_HATCHLING_SITE = https://files.pythonhosted.org/packages/7a/f1/e47b937226ae3b093bbd0132eb0b7ee5bfad12c2b5324afd10ae49946b05
PYTHON_HATCHLING_LICENSE = MIT
PYTHON_HATCHLING_LICENSE_FILES = LICENSE.txt
PYTHON_HATCHLING_SETUP_TYPE = pep517
HOST_PYTHON_HATCHLING_DEPENDENCIES = \
	host-python-packaging \
	host-python-pathspec \
	host-python-pluggy \
	host-python-tomlkit \
	host-python-trove-classifiers

$(eval $(host-python-package))
