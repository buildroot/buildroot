################################################################################
#
# python-alembic
#
################################################################################

PYTHON_ALEMBIC_VERSION = 1.9.1
PYTHON_ALEMBIC_SOURCE = alembic-$(PYTHON_ALEMBIC_VERSION).tar.gz
PYTHON_ALEMBIC_SITE = https://files.pythonhosted.org/packages/81/87/5c531d2923c61e7ae68b23c8660df289ae4241a0d38f3fbcbd8dba64ca6b
PYTHON_ALEMBIC_SETUP_TYPE = setuptools
PYTHON_ALEMBIC_LICENSE = MIT
PYTHON_ALEMBIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
