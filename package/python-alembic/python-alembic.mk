################################################################################
#
# python-alembic
#
################################################################################

PYTHON_ALEMBIC_VERSION = 1.16.4
PYTHON_ALEMBIC_SOURCE = alembic-$(PYTHON_ALEMBIC_VERSION).tar.gz
PYTHON_ALEMBIC_SITE = https://files.pythonhosted.org/packages/83/52/72e791b75c6b1efa803e491f7cbab78e963695e76d4ada05385252927e76
PYTHON_ALEMBIC_SETUP_TYPE = setuptools
PYTHON_ALEMBIC_LICENSE = MIT
PYTHON_ALEMBIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
