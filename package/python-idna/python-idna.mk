################################################################################
#
# python-idna
#
################################################################################

PYTHON_IDNA_VERSION = 3.2
PYTHON_IDNA_SOURCE = idna-$(PYTHON_IDNA_VERSION).tar.gz
PYTHON_IDNA_SITE = https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005
PYTHON_IDNA_LICENSE = BSD-3-Clause
PYTHON_IDNA_LICENSE_FILES = LICENSE.md
PYTHON_IDNA_SETUP_TYPE = setuptools

$(eval $(python-package))
