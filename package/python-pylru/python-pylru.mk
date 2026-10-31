################################################################################
#
# python-pylru
#
################################################################################

PYTHON_PYLRU_VERSION = 1.3.3
PYTHON_PYLRU_SOURCE = pylru-$(PYTHON_PYLRU_VERSION).tar.gz
PYTHON_PYLRU_SITE = https://files.pythonhosted.org/packages/ed/d2/a944dfae27670a4d230301acc83115eb8a5004f8c71549a3cf5d35a40fe0
PYTHON_PYLRU_SETUP_TYPE = setuptools
PYTHON_PYLRU_LICENSE = MIT
PYTHON_PYLRU_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
