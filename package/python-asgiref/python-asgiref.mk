################################################################################
#
# python-asgiref
#
################################################################################

PYTHON_ASGIREF_VERSION = 3.5.2
PYTHON_ASGIREF_SOURCE = asgiref-$(PYTHON_ASGIREF_VERSION).tar.gz
PYTHON_ASGIREF_SITE = https://files.pythonhosted.org/packages/1f/35/e7d59b92ceffb1dc62c65156278de378670b46ab2364a3ea7216fe194ba3
PYTHON_ASGIREF_SETUP_TYPE = setuptools
PYTHON_ASGIREF_LICENSE = BSD-3-Clause
PYTHON_ASGIREF_LICENSE_FILES = LICENSE

$(eval $(python-package))
