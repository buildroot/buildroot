################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2023.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/96/d3/a471fe68788178f2a5024031a153673df72b9287530f32b0cd469d64a68a
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))
