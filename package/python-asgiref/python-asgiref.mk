################################################################################
#
# python-asgiref
#
################################################################################

PYTHON_ASGIREF_VERSION = 3.10.0
PYTHON_ASGIREF_SOURCE = asgiref-$(PYTHON_ASGIREF_VERSION).tar.gz
PYTHON_ASGIREF_SITE = https://files.pythonhosted.org/packages/46/08/4dfec9b90758a59acc6be32ac82e98d1fbfc321cb5cfa410436dbacf821c
PYTHON_ASGIREF_SETUP_TYPE = setuptools
PYTHON_ASGIREF_LICENSE = BSD-3-Clause
PYTHON_ASGIREF_LICENSE_FILES = LICENSE

$(eval $(python-package))
