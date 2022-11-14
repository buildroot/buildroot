################################################################################
#
# python-hatch-fancy-pypi-readme
#
################################################################################

PYTHON_HATCH_FANCY_PYPI_README_VERSION = 22.8.0
PYTHON_HATCH_FANCY_PYPI_README_SOURCE = hatch_fancy_pypi_readme-$(PYTHON_HATCH_FANCY_PYPI_README_VERSION).tar.gz
PYTHON_HATCH_FANCY_PYPI_README_SITE = https://files.pythonhosted.org/packages/4e/ab/9b48589d6e3a2f72cc1e8f5221c28ff28fcdf116dbbd6e9beb946054212d
PYTHON_HATCH_FANCY_PYPI_README_LICENSE = MIT
PYTHON_HATCH_FANCY_PYPI_README_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_FANCY_PYPI_README_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_FANCY_PYPI_README_DEPENDENCIES = host-python-hatchling

$(eval $(host-python-package))
