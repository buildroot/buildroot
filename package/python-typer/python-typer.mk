################################################################################
#
# python-typer
#
################################################################################

PYTHON_TYPER_VERSION = 0.27.3
PYTHON_TYPER_SOURCE = typer-$(PYTHON_TYPER_VERSION).tar.gz
PYTHON_TYPER_SITE = https://files.pythonhosted.org/packages/03/51/d33db42cc72ffd8c30777547b42d01f0cbf9d95a770457698d0174b3ed71
PYTHON_TYPER_SETUP_TYPE = pep517
PYTHON_TYPER_LICENSE = MIT, BSD-3-Clause (vendored click)
PYTHON_TYPER_LICENSE_FILES = LICENSE typer/_click/LICENSE.txt
PYTHON_TYPER_DEPENDENCIES = host-python-pdm-backend
HOST_PYTHON_TYPER_DEPENDENCIES = \
	host-python-annotated-doc \
	host-python-pdm-backend \
	host-python-rich \
	host-python-shellingham

$(eval $(python-package))
$(eval $(host-python-package))
