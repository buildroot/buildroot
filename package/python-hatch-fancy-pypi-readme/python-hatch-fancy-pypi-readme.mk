################################################################################
#
# python-hatch-fancy-pypi-readme
#
################################################################################

PYTHON_HATCH_FANCY_PYPI_README_VERSION = 24.1.0
PYTHON_HATCH_FANCY_PYPI_README_SOURCE = hatch_fancy_pypi_readme-$(PYTHON_HATCH_FANCY_PYPI_README_VERSION).tar.gz
PYTHON_HATCH_FANCY_PYPI_README_SITE = https://files.pythonhosted.org/packages/b4/c2/c9094283a07dd96c5a8f7a5f1910259d40d2e29223b95dd875a6ca13b58f
PYTHON_HATCH_FANCY_PYPI_README_LICENSE = MIT
PYTHON_HATCH_FANCY_PYPI_README_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_FANCY_PYPI_README_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_FANCY_PYPI_README_DEPENDENCIES = host-python-hatchling

$(eval $(host-python-package))
