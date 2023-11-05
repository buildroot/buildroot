################################################################################
#
# python-hatch-fancy-pypi-readme
#
################################################################################

PYTHON_HATCH_FANCY_PYPI_README_VERSION = 23.1.0
PYTHON_HATCH_FANCY_PYPI_README_SOURCE = hatch_fancy_pypi_readme-$(PYTHON_HATCH_FANCY_PYPI_README_VERSION).tar.gz
PYTHON_HATCH_FANCY_PYPI_README_SITE = https://files.pythonhosted.org/packages/85/a6/58d585eba4321bf2e7a4d1ed2af141c99d88c1afa4b751926be160f09325
PYTHON_HATCH_FANCY_PYPI_README_LICENSE = MIT
PYTHON_HATCH_FANCY_PYPI_README_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_FANCY_PYPI_README_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_FANCY_PYPI_README_DEPENDENCIES = host-python-hatchling

$(eval $(host-python-package))
