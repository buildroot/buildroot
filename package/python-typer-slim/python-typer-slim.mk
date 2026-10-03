################################################################################
#
# python-typer-slim
#
################################################################################

PYTHON_TYPER_SLIM_VERSION = 0.24.0
PYTHON_TYPER_SLIM_SOURCE = typer_slim-$(PYTHON_TYPER_SLIM_VERSION).tar.gz
PYTHON_TYPER_SLIM_SITE = https://files.pythonhosted.org/packages/a7/a7/e6aecc4b4eb59598829a3b5076a93aff291b4fdaa2ded25efc4e1f4d219c
PYTHON_TYPER_SLIM_SETUP_TYPE = pep517
PYTHON_TYPER_SLIM_LICENSE = MIT
PYTHON_TYPER_SLIM_LICENSE_FILES = LICENSE
PYTHON_TYPER_SLIM_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
