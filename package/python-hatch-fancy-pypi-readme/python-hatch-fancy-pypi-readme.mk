################################################################################
#
# python-hatch-fancy-pypi-readme
#
################################################################################

PYTHON_HATCH_FANCY_PYPI_README_VERSION = 25.1.0
PYTHON_HATCH_FANCY_PYPI_README_SOURCE = hatch_fancy_pypi_readme-$(PYTHON_HATCH_FANCY_PYPI_README_VERSION).tar.gz
PYTHON_HATCH_FANCY_PYPI_README_SITE = https://files.pythonhosted.org/packages/f3/0f/aed57c301f339936eb91cb4d8c1e5088a101081854bd3ec18a889df32365
PYTHON_HATCH_FANCY_PYPI_README_LICENSE = MIT
PYTHON_HATCH_FANCY_PYPI_README_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_FANCY_PYPI_README_SETUP_TYPE = hatch

$(eval $(host-python-package))
