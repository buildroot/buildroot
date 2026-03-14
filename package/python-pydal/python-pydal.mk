################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20260313.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/68/51/c6ae7cfa615718812f974560b24001aff542ee6739232fd689e87ba75b1f
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
