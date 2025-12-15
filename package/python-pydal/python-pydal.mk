################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20251207.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/53/8f/f22822372765bf06a8b2aa9b0246a2f3b6abe21742b3608aa71939900cfe
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
