################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20241027.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/31/7c/aa20d1d25f22d575e180181feeae4a077ff36414e0547060434c398d159a
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
