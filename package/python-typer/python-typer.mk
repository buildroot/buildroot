################################################################################
#
# python-typer
#
################################################################################

PYTHON_TYPER_VERSION = 0.28.0
PYTHON_TYPER_SOURCE = typer-$(PYTHON_TYPER_VERSION).tar.gz
PYTHON_TYPER_SITE = https://files.pythonhosted.org/packages/ad/8f/21021859316f44289101638dc74d82e13d722d8533e4b8708a3ab7c8461a
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
