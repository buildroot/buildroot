################################################################################
#
# python-typer
#
################################################################################

PYTHON_TYPER_VERSION = 0.27.2
PYTHON_TYPER_SOURCE = typer-$(PYTHON_TYPER_VERSION).tar.gz
PYTHON_TYPER_SITE = https://files.pythonhosted.org/packages/16/f7/57713ba479fd405eb76de31404b2c744c289e336b2d999511ebf51e496f7
PYTHON_TYPER_SETUP_TYPE = pep517
PYTHON_TYPER_LICENSE = MIT, BSD-3-Clause (vendored click)
PYTHON_TYPER_LICENSE_FILES = LICENSE typer/_click/LICENSE.txt
PYTHON_TYPER_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
