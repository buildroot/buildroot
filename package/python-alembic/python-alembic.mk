################################################################################
#
# python-alembic
#
################################################################################

PYTHON_ALEMBIC_VERSION = 1.8.1
PYTHON_ALEMBIC_SOURCE = alembic-$(PYTHON_ALEMBIC_VERSION).tar.gz
PYTHON_ALEMBIC_SITE = https://files.pythonhosted.org/packages/37/ab/80e6d86ca81235ea1a7104089dddf74de4b45f8af0a05d4b265be44d6ff9
PYTHON_ALEMBIC_SETUP_TYPE = setuptools
PYTHON_ALEMBIC_LICENSE = MIT
PYTHON_ALEMBIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
