################################################################################
#
# python-idna
#
################################################################################

PYTHON_IDNA_VERSION = 3.3
PYTHON_IDNA_SOURCE = idna-$(PYTHON_IDNA_VERSION).tar.gz
PYTHON_IDNA_SITE = https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436
PYTHON_IDNA_LICENSE = BSD-3-Clause
PYTHON_IDNA_LICENSE_FILES = LICENSE.md
PYTHON_IDNA_SETUP_TYPE = setuptools
HOST_PYTHON_IDNA_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
