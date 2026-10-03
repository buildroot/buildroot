################################################################################
#
# python-alembic
#
################################################################################

PYTHON_ALEMBIC_VERSION = 1.20.0
PYTHON_ALEMBIC_SOURCE = alembic-$(PYTHON_ALEMBIC_VERSION).tar.gz
PYTHON_ALEMBIC_SITE = https://files.pythonhosted.org/packages/ed/aa/02910bdb8e2f1444f6654d5b296cd827d126f82209050ee7b1000f92ac4b
PYTHON_ALEMBIC_SETUP_TYPE = setuptools
PYTHON_ALEMBIC_LICENSE = MIT
PYTHON_ALEMBIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
