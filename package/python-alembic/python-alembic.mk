################################################################################
#
# python-alembic
#
################################################################################

PYTHON_ALEMBIC_VERSION = 1.20.1
PYTHON_ALEMBIC_SOURCE = alembic-$(PYTHON_ALEMBIC_VERSION).tar.gz
PYTHON_ALEMBIC_SITE = https://files.pythonhosted.org/packages/93/1c/00909e0fbebad2121d916fdcab044cae988146680e9ee4387ba25fef8747
PYTHON_ALEMBIC_SETUP_TYPE = setuptools
PYTHON_ALEMBIC_LICENSE = MIT
PYTHON_ALEMBIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
